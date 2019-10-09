package icbs.loans

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import javax.servlet.http.HttpSession
import org.springframework.web.context.request.RequestContextHolder

import org.apache.poi.ss.formula.functions.Irr
import org.apache.poi.ss.formula.functions.FinanceLib

import icbs.admin.Branch
import icbs.loans.Loan
import icbs.lov.LoanAcctStatus
import icbs.lov.LoanSpecialType
import icbs.lov.LoanInstallmentFreq
import icbs.lov.LoanInstallmentStatus
import icbs.lov.LoanPerformanceId
import icbs.loans.LoanReClassHist
import icbs.gl.CfgAcctGlTemplate
import icbs.lov.LoanPerformanceClassification
import icbs.admin.Institution
import icbs.tellering.TxnFile
import icbs.admin.UserMaster
import icbs.lov.ConfigItemStatus
import icbs.admin.TxnTemplate
import org.hibernate.Session
import org.hibernate.SessionFactory
import icbs.reports.LoanListingEntry
import groovy.time.TimeCategory
import java.text.SimpleDateFormat
import java.util.Formatter.DateTime
import java.util.Date
import java.math.*;
import java.lang.Math;
@Transactional
class LoanService {
    def GlTransactionService
def generateAccountNo(Loan loanInstance) {
        
        /*
        def ol = Loan.findByAccountNo(loanInstance.accountNo)
        if (ol) {
            return loanInstance.accountNo
        }
        */
        
        int[] piArray = [1, 4, 1, 5, 9, 2, 6, 5, 3, 5, 8]
        //int serialCount = Loan.countByBranchAndProduct(loanInstance?.branch, loanInstance?.product)
        //def prList = Loan.findAllByBranchAndProduct(loanInstance?.branch, loanInstance?.product, [max: 1, sort: "accountNo", order: "desc"])
        String accountNo
        String branchCode
        String productCode
        println '+++' + loanInstance.branch
        println '+++' + loanInstance.product
        def result = Loan.executeQuery("select max(SUBSTRING(accountNo, 9,5))from Loan where SUBSTRING(accountNo, 1,7) = CONCAT(:branch,'-',:prod))", [branch: String.format("%03d", loanInstance?.branch?.code), prod: String.format("%03d", loanInstance?.product?.code)])
        int serialNum
        println '+++' + result
        String serialOld 
        if (result[0] != null) {
            //averageBal = result[0][0].div(days)
            serialOld = result[0]//.substring(8, 13).trim()
            serialNum = Integer.parseInt(serialOld)
        } else {
            serialNum = 0
        } 

        serialNum++
        
        branchCode = String.format("%03d", loanInstance?.branch?.code)
        productCode = String.format("%03d", loanInstance?.product?.code)
        String serialCode = String.format("%05d", serialNum);

        
        accountNo = branchCode + productCode + serialCode
        println '+++' + accountNo
        def checksum = 0
        for(int i= accountNo.length() - 1; i >= 0;i--) {
            checksum += Character.getNumericValue(accountNo.charAt(i)) * piArray[i]
        }
        
        String checkBit = (checksum % 10).toString()
        
        loanInstance.accountNo = branchCode+"-"+productCode +"-"+serialCode+"-"+checkBit
        loanInstance.openingDate = Branch?.get(1).runDate
        println '+++' + loanInstance.accountNo
        loanInstance.save(failOnError:true)
        
    }

    def beforeValidation(Loan loanInstance) { 
        if (loanInstance.loanApplication) {       
            loanInstance.branch = loanInstance?.loanApplication?.branch
            loanInstance.currency =  loanInstance?.product?.currency

            if (loanInstance?.interestIncomeScheme?.installmentCalcType.id == 1) {
                loanInstance.numInstallments = 1
                loanInstance.frequency = LoanInstallmentFreq.get(1)
            } else {
                loanInstance.term = 0
            }

            if (loanInstance?.currentPenaltyScheme?.type.id == 1) {  // fixed amount
                loanInstance.penaltyRate = 0
            } else if (loanInstance.currentPenaltyScheme?.type.id == 2) {  // rate based
                loanInstance.penaltyAmount = 0
            }

            // advanced interests
            if (loanInstance?.interestIncomeScheme?.advInterestType.id == 1) {  // none
                loanInstance.advInterestPeriods = 0
                loanInstance.advInterestDays = 0
            } else if (loanInstance?.interestIncomeScheme?.advInterestType.id == 2) {  // full
                if (loanInstance?.interestIncomeScheme?.installmentCalcType.id == 1) {
                    loanInstance.advInterestPeriods = 0
                    loanInstance.advInterestDays = loanInstance.term
                } else if (loanInstance?.interestIncomeScheme?.installmentCalcType.id == 5) {
                    loanInstance.advInterestPeriods = loanInstance.numInstallments
                    loanInstance.advInterestDays = 0
                } else {
                    loanInstance.advInterestPeriods = 0
                    loanInstance.advInterestDays = 0
                }
            } else if (loanInstance?.interestIncomeScheme?.advInterestType.id == 3) {
                if (loanInstance?.interestIncomeScheme?.installmentCalcType.id == 1) {
                    loanInstance.advInterestPeriods = 0
                } else if (loanInstance?.interestIncomeScheme?.installmentCalcType.id == 2 || 
                           loanInstance?.interestIncomeScheme?.installmentCalcType.id == 5) {
                    loanInstance.advInterestDays = 0
                } else {
                    loanInstance.advInterestPeriods = 0
                    loanInstance.advInterestDays = 0
                }
            }
        }
    }

    def initializeLoan(Loan loanInstance) {
        
        // determine user rights first
        loanInstance.status = LoanAcctStatus.get(1)

        loanInstance.performanceClassification = LoanPerformanceClassification.get(1)


        // do not reset balances for approved loans
        if (loanInstance.status.id <= 2) {
            loanInstance.balanceAmount = 0
            loanInstance.totalDisbursementAmount = 0         
            loanInstance.transactionSequenceNo = 0 
            loanInstance.normalInterestAmount = 0
            loanInstance.interestBalanceAmount = 0
            loanInstance.penaltyBalanceAmount = 0
            loanInstance.serviceChargeBalanceAmount = 0
            loanInstance.taxBalanceAmount = 0
            loanInstance.accruedInterestAmount = 0
        } 
        

        loanInstance.hasInterestAccrual = loanInstance?.interestIncomeScheme?.hasInterestAccrual ?: false 
    }

    def saveLoan(Loan loanInstance, def installmentAmount) {
        //saveSweepAccounts(loanInstance)          
        if (!loanInstance.accountNo) {
           generateAccountNo(loanInstance) 
        }
        
        if (!loanInstance?.interestStartDate) {
            loanInstance.interestStartDate = loanInstance?.openingDate
        }
        
        loanInstance.maturityDate = getMaturityDate(loanInstance)
        loanInstance.save flush:true
        //loanInstance.lock()

        saveServiceCharges(loanInstance)
        saveDeductions(loanInstance)             
        generateInstallmentSchedule(loanInstance, installmentAmount)
        generateUIDSchedule(loanInstance)
        //loanInstance.accountNo = generateAccountNo(loanInstance)

        
        //loanInstance.merge()
        println '+++' + loanInstance.accountNo
        loanInstance.save flush:true
        if(Institution.findByParamCode('LNS.50100').paramValue =='TRUE') {
            loanInstance.pnNo = loanInstance.accountNo
            loanInstance.save flush:true
        } 
        println '+++' + loanInstance.accountNo
    }
    
    def renewLoan(Loan loanInstance, def installmentAmount) {
        if (!loanInstance?.interestStartDate) {
            loanInstance.interestStartDate = loanInstance?.openingDate
        }
        
        loanInstance.maturityDate = getMaturityDate(loanInstance)
        loanInstance.save flush:true
        //loanInstance.lock()
        
        saveServiceCharges(loanInstance)
        saveDeductions(loanInstance)
        //saveSweepAccounts(loanInstance)               
        generateInstallmentSchedule(loanInstance, installmentAmount)
        generateUIDSchedule(loanInstance)
        //loanInstance.accountNo = generateAccountNo(loanInstance)
        generateAccountNo(loanInstance) 
        
        //loanInstance.merge()
        println '+++' + loanInstance.accountNo
        loanInstance.save flush:true
        if(Institution.findByParamCode("LNS.50100").paramValue =='TRUE') {
            loanInstance.pnNo = loanInstance.accountNo
            loanInstance.save flush:true
        } 
        println '+++' + loanInstance.accountNo
    }
    
    def saveLoanAmendment(Loan loanInstance, UserMaster user) {
        def oldClass = LoanPerformanceId.findByDescription(loanInstance.getPersistentValue('loanPerformanceId'))
        def newClass = loanInstance.loanPerformanceId
           
       if (oldClass == newClass) {
           // do nothing, logic test grails fail
       } else {
            def txnTmp = TxnTemplate.get(Institution.findByParamCode('LNS.50075').paramValue.toInteger())
            def tf = new TxnFile(acctNo:loanInstance.accountNo, branch:loanInstance.branch, currency:loanInstance.product.currency,
                loanAcct:loanInstance, status:ConfigItemStatus.read(2), txnAmt:loanInstance.balanceAmount, txnCode:txnTmp.code,
                txnDate:Branch.get(1).runDate, txnDescription:'Manual Reclassification of Loan', txnParticulars:'reclassify loan',
                txnRef:'Loan Reclass', txnTemplate:txnTmp, txnType:txnTmp.txnType,
                txnTimestamp:new Date().toTimestamp(), user: user)
            tf.save(flush:true,failOnError:true)
        
            def ll = new LoanLedger(loan:loanInstance, principalDebit:loanInstance.balanceAmount, principalCredit:loanInstance.balanceAmount, 
                principalBalance:loanInstance.balanceAmount, txnFile:tf, txnCode:tf.txnCode, txnDate:Branch.get(1).runDate,
                txnRef:tf.txnRef, txnParticulars:'Manual Reclassification', txnTemplate:tf.txnTemplate)
            ll.save(flush:true,failOnError:true)

            def rc = new LoanReClassHist(loanAcct:loanInstance, newClass:newClass.id, oldClass:oldClass.id, reclassDate:Branch.get(1).runDate,
                reclassDesc:'Manual Reclassification', txnFile:tf)
            rc.save(flush:true,failOnError:true)           
            GlTransactionService.saveTxnBreakdown(tf.id)
       }
       loanInstance.save(flush:true) 
    }

    def updateInterestRate(Loan loanInstance, def interestRate) {
   
        loanInstance.interestRate = interestRate
        loanInstance.save flush:true

        //loanInstance.lock()
        saveServiceCharges(loanInstance)
        saveDeductions(loanInstance)      
        //saveSweepAccounts(loanInstance)        
        generateInstallmentSchedule(loanInstance, null)
        generateUIDSchedule(loanInstance)
        //loanInstance.merge()
        loanInstance.save flush:true
    }

    def updateInterestAccrual(Loan loanInstance, boolean hasInterestAccrual) {
        loanInstance.hasInterestAccrual = hasInterestAccrual
        loanInstance.save flush:true

        //loanInstance.lock()
        saveServiceCharges(loanInstance)
        saveDeductions(loanInstance)      
        //saveSweepAccounts(loanInstance)        
        saveInstallments(loanInstance)
        saveEIRSchedules(loanInstance)
        //loanInstance.merge()
        loanInstance.save flush:true
    }

    def updateBranch(Loan loanInstance, Branch branch, String particulars, String reference, UserMaster user) {
        def oldBranch = loanInstance.branch
        loanInstance.branch = branch
        loanInstance.save flush:true
        def tmpDr = TxnTemplate.get(Institution.findByParamCode("LNS.50110").paramValue.toInteger())
        def tmpCr = TxnTemplate.get(Institution.findByParamCode("LNS.50120").paramValue.toInteger())
        
        def trCr = new TxnFile(acctNo:loanInstance.accountNo, branch:oldBranch, currency:loanInstance.product.currency,
            loanAcct:loanInstance, status:ConfigItemStatus.read(2), txnAmt:loanInstance.balanceAmount, txnCode:tmpCr.code,
            txnDate:Branch.get(1).runDate, txnDescription:'Loan Branch Transfer Credit', txnParticulars:particulars,
            txnRef:reference, txnTemplate:tmpCr, txnType:tmpCr.txnType,
            txnTimestamp:new Date().toTimestamp(), user: user)
        trCr.save(flush:true)    
        
        def trDr = new TxnFile(acctNo:loanInstance.accountNo, branch:loanInstance.branch, currency:loanInstance.product.currency,
            loanAcct:loanInstance, status:ConfigItemStatus.read(2), txnAmt:loanInstance.balanceAmount, txnCode:tmpDr.code,
            txnDate:Branch.get(1).runDate, txnDescription:'Loan Branch Transfer Debit', txnParticulars:particulars,
            txnRef:reference, txnTemplate:tmpDr, txnType:tmpDr.txnType,
            txnTimestamp:new Date().toTimestamp(), user: user)
        trDr.save(flush:true)     

        def llCr = new LoanLedger(loan: loanInstance, txnFile: trCr, txnDate: Branch.get(1).runDate, txnTemplate: tmpCr, 
            principalCredit: loanInstance.balanceAmount, principalDebit:0.00D, txnRef: trCr.txnRef,
            principalBalance: 0.00D, txnParticulars:particulars)
        llCr.save(flush:true, failOnError:true)
        
        def llDr = new LoanLedger(loan: loanInstance, txnFile: trDr, txnDate: Branch.get(1).runDate, txnTemplate: tmpDr, 
            principalCredit: 0.00, principalDebit:loanInstance.balanceAmount, txnRef: trDr.txnRef,
            principalBalance: loanInstance.balanceAmount, txnParticulars:particulars)
        llDr.save(flush:true, failOnError:true)
        
        def l = new LoanBranchTransfer(loan:loanInstance, newBranch:branch, oldBranch:oldBranch, 
            loanDr:trDr, loanCr:trCr, transferDate:branch.runDate, particulars:particulars, 
            reference:reference, user:user, userBranch:user.branch)
        l.save(flush:true)
        
        //loanInstance.lock()
        saveServiceCharges(loanInstance)
        saveDeductions(loanInstance)      
        //saveSweepAccounts(loanInstance)        
        saveInstallments(loanInstance)
        saveEIRSchedules(loanInstance)
        //loanInstance.merge()
        loanInstance.save flush:true
        GlTransactionService.saveLoanTransferBranchEntry(l)
        
    }

    def updateStatus(Loan loanInstance, LoanAcctStatus status) {
        loanInstance.status = status
        if (status.id == 6) {
            loanInstance.statusChangedDate = loanInstance.branch.runDate
        }
        loanInstance.save flush:true

        //loanInstance.lock()
        saveServiceCharges(loanInstance)
        saveDeductions(loanInstance)      
        //saveSweepAccounts(loanInstance)        
        saveInstallments(loanInstance)
        saveEIRSchedules(loanInstance)
        //loanInstance.merge()
        loanInstance.save flush:true
    }
    
   
        def updateOpeningBal(Loan loanInstance, LoanAcctStatus status ) {
        def granted = loanInstance.grantedAmount
        def net = loanInstance.totalNetProceeds
        def bal = granted - net 
        println bal
        loanInstance.balanceAmount = bal
        loanInstance.save flush:true

        //loanInstance.lock()
        saveServiceCharges(loanInstance)
        saveDeductions(loanInstance)      
        //saveSweepAccounts(loanInstance)        
        saveInstallments(loanInstance)
        saveEIRSchedules(loanInstance)
        //loanInstance.merge()
        loanInstance.save flush:true
    }

    def updateGLClassification(Loan loanInstance, CfgAcctGlTemplate glLink, user) {
        loanInstance.prevGLLink = loanInstance.glLink
        loanInstance.glLink = glLink
        loanInstance.save flush:true

        //loanInstance.lock()
        saveServiceCharges(loanInstance)
        saveDeductions(loanInstance)      
        //saveSweepAccounts(loanInstance)        
        saveInstallments(loanInstance)
        saveEIRSchedules(loanInstance)
        //loanInstance.merge()
        loanInstance.save flush:true
        
        //create txn file
        def x = Institution.findByParamCode('GEN.10241').paramValue.toInteger()
        def tf = new TxnFile(acctNo:loanInstance.accountNo, loanAcct:loanInstance, currency:loanInstance.product.currency,
            user:user, branch:loanInstance.branch, txnAmt:loanInstance.balanceAmount, txnCode:TxnTemplate.get(x).code, 
            txnDate:Branch.get(1).runDate,txnTimestamp:new Date().toTimestamp(), txnDescription:'Loan GL Link Update',
            status:ConfigItemStatus.get(2), txnType:TxnTemplate.get(x).txnType, txnRef:'Loan GL Link Update', 
            txnParticulars:'To update Loan GL Link', txnTemplate:TxnTemplate.get(x))
        tf.save(flush:true,failOnError:true)
        
        //create ledger
        def ll = new LoanLedger(loan: loanInstance, txnFile: tf, txnDate: Branch.get(1).runDate, txnTemplate: TxnTemplate.get(x), 
            principalCredit: loanInstance.balanceAmount, principalDebit:loanInstance.balanceAmount, txnRef: tf.txnRef,
            principalBalance: loanInstance.balanceAmount)
        ll.save(flush:true, failOnError:true)
        
        //update GL
        glTransactionService.saveTxnBreakdown(tf.id)
    }

    def saveServiceCharges(Loan loanInstance) {
        HttpSession session = RequestContextHolder.currentRequestAttributes().getSession()

        for(serviceCharge in session["serviceCharges"]) {
            //serviceCharge.save flush:true
            loanInstance.addToServiceCharges(serviceCharge)            
        }
        //loanInstance.save flush:true
        session["serviceCharges"] = null
    }

    def saveDeductions(Loan loanInstance) {
        HttpSession session = RequestContextHolder.currentRequestAttributes().getSession()

        for(deduction in session["deductions"]) {
            //deduction.save flush:true
            loanInstance.addToLoanDeductions(deduction)
            
        }     
        //loanInstance.save flush:true
        session["deductions"] = null
    }

    def saveSweepAccounts(Loan loanInstance) {
        HttpSession session = RequestContextHolder.currentRequestAttributes().getSession()

        for(sweepAccount in session["sweepAccounts"]) {
            //sweepAccount.save flush:true
            loanInstance.addToSweepAccounts(sweepAccount)            
        }
        //loanInstance.save flush:true
        session["sweepAccounts"] = null
    }

    def generateUIDSchedule(Loan loanInstance) {   
        double advInterest = 0 

        def advInterestType = loanInstance?.interestIncomeScheme?.advInterestType?.id
        def installmentCalculation = loanInstance?.interestIncomeScheme?.installmentCalcType.id        
        def amount = loanInstance?.grantedAmount ?: 0
        //def term = loanInstance?.term ?: 0
        def term = loanInstance?.maturityDate - loanInstance?.interestStartDate
        def interestRate = (loanInstance?.interestRate ?: 0)  * 0.01
        def divisor = loanInstance?.interestIncomeScheme?.divisor ?: 0

        def advInterestPeriods = loanInstance?.advInterestPeriods ?: 0
        def advInterestDays = loanInstance?.advInterestDays ?: 0

        if (advInterestType != 1) {
            // compute advanced interest

            if (advInterestType == 2) {  // full advanced interest
                if (installmentCalculation == 1) {  // single payment
                    advInterest = amount * interestRate * (term / divisor)
                } else if (installmentCalculation == 5) {  // flat
                    advInterest = amount * interestRate
                }
            } else if (advInterestType == 3) {  // partial advanced interest
                if (installmentCalculation == 1) {  // single payment
                    advInterest = amount * interestRate * (advInterestDays / divisor)
                } else if (installmentCalculation == 2 || installmentCalculation == 5) {  // fixed principal or flat
                    def advInterestStart = loanInstance.loanInstallments.find{it.sequenceNo == 1}.installmentDate
                    def advInterestEnd = loanInstance.loanInstallments.find{it.sequenceNo == advInterestPeriods}.installmentDate
                    advInterestDays = advInterestEnd - advInterestStart

                    advInterest = amount * (interestRate / divisor) * advInterestDays
                }
            }
            
            def institutionCaption = Institution.findByParamCode("GEN.10252").caption
            def isEIRImplement = Institution.findByParamCode("GEN.10252").paramValue
            println("institutionCaption: "+institutionCaption.toString())
            println("isEIRImplement: "+isEIRImplement.toString().toLowerCase())
            
            if (isEIRImplement.toString().toLowerCase()=='true'){
                //====== NBRSL requesting for EIR base computation
                println("========== Entering Bank EIR Base UID Computation....==========")
                generateUIDScheduleIRR(advInterest,loanInstance)
                loanInstance.advInterest = advInterest
                println("============ EIR Base UID Computation Finished!....============")
                return
                //generate UID schedule  
            } 
            println("============== Starting OLD UID computation ========================")                          
            if (installmentCalculation == 1) {
                if (advInterestType == 2) {
                    advInterestDays = term
                }

                def advInterestPerDay = 0
                advInterestPerDay = advInterest / advInterestDays
                def calendar = new GregorianCalendar()

                def transferEndDate = loanInstance?.interestStartDate + advInterestDays
                calendar.setTime(transferEndDate)
                def transferEndMonth = calendar.get(Calendar.MONTH)

                def prevTransferDate = loanInstance?.interestStartDate
                                
                calendar.setTime(prevTransferDate)
                calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH))
                def endOfMonth = calendar.getTime()

                def transferDate = endOfMonth
                if (transferEndDate < transferDate) {
                    transferDate = transferEndDate
                }                

                while(transferDate.clearTime() <= transferEndDate.clearTime()) {
                    def uidAmount = advInterestPerDay * (transferDate - prevTransferDate)

                    def eirSchedule = new LoanEIRSchedule(transferDate: transferDate, uidAmount: uidAmount.round(2))
                    //eirSchedule.save flush:true
                    loanInstance.addToLoanEIRSchedules(eirSchedule)

                    prevTransferDate = transferDate

                    calendar.add(Calendar.MONTH, 1)                        
                    calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH))
                    endOfMonth = calendar.getTime()

                    def currentMonth = calendar.get(Calendar.MONTH)                    

                    transferDate = endOfMonth
                    if (currentMonth == transferEndMonth && transferEndDate < transferDate) {
                        transferDate = transferEndDate
                    }
                }
            } else if (installmentCalculation == 2 || installmentCalculation == 5) {
                def freq = loanInstance?.product?.loanUidTransferFreq?.id
                def count = 0

                if (freq == 1) {
                    count = term
                } else if (freq == 2 || freq == 3) {
                    count = (term / 7D).round(0)
                } else if (freq == 4) {
                    count = (term / 30D).round(0)
                } else if (freq == 5) {
                    count = (term / 90D).round(0)
                } else if (freq == 6) {
                    count = (term / 180D).round(0)
                } else if (freq == 7) {
                    count = (term / 365D).round(0)
                }

                def uidAmount = advInterest / count
                def prevTransferDate = loanInstance?.interestStartDate
                for(int i = 0; i < count; i++) {
                    def calendar = new GregorianCalendar()
                    calendar.setTime(prevTransferDate)

                    switch(freq) {
                        case 1 :  // daily
                            calendar.add(Calendar.DAY_OF_MONTH, 1)
                        break

                        case 2:  // weekly (last day)
                            calendar.add(Calendar.DAY_OF_MONTH, 7)
                            calendar.set(Calendar.DAY_OF_WEEK, Calendar.SATURDAY)
                        break

                        case 3:  // weekly (first day)
                            calendar.add(Calendar.DAY_OF_MONTH, 7)
                            calendar.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY)
                        break

                        case 4:  // monthly
                            calendar.add(Calendar.MONTH, 1)                        
                            calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH))
                        break

                        case 5:  // quarterly
                            calendar.add(Calendar.MONTH, 3)
                            calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH))
                        break

                        case 6:  // semi-annually
                            calendar.add(Calendar.MONTH, 6)
                            calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH))
                        break

                        case 7:  // annually
                            calendar.add(Calendar.YEAR, 1)
                            calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH))
                        break
                    }

                    def transferDate = calendar.getTime()

                    def eirSchedule = new LoanEIRSchedule(transferDate: transferDate, uidAmount: uidAmount.round(2))
                    //eirSchedule.save flush:true
                    loanInstance.addToLoanEIRSchedules(eirSchedule)
                    //loanInstance.save flush:true

                    prevTransferDate = transferDate
                }

            }            
        }

        loanInstance.advInterest = advInterest
        //loanInstance.save flush:true
    }
    // new function generaUIDScheduleIRR 
    def generateUIDScheduleIRR(Double totalInterest,Loan loanInstance){
        println("===================== GENERATE UID SCHEDULE IRR =========================")
        
        //  interest computation according to the excel file code base 03/16/2017

        def theUIDdate = loanInstance?.interestStartDate
        def calendar = new GregorianCalendar()
        calendar.setTime(theUIDdate)
        calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH))
        def endOfMonth = calendar.getTime()
        def advInterestDays = loanInstance?.advInterestDays ?: 0
        def interestRate = (loanInstance?.interestRate ?: 0)  * 0.01
        def divisor = loanInstance?.interestIncomeScheme?.divisor ?: 0
        def theGrantedAmount = loanInstance?.grantedAmount ?: 0
        def loanAdvanceInterest = totalInterest
        // change computation for the MRI
        //def theIRRvalue = loanInstance?.monthlyInterestRate * 0.01
        //new computation for MRI
       def theIRRvalue = Math.pow((1 + loanAdvanceInterest / (theGrantedAmount - loanAdvanceInterest)) , (1/(advInterestDays/30)))
        theIRRvalue = theIRRvalue - 1
        //formula: 180/360*0.18*250000 = to get the interest value
        def finalinterestTotal = (advInterestDays / divisor) * interestRate * theGrantedAmount
        def cashOutlay = theGrantedAmount.round(2) - finalinterestTotal.round(2)
        // code base end 03/16/2017
       
        def loanDiscount
        def uidDays = 30
        theUIDdate += 30
        println("BEFORE LOOP VALUES")
        println("theIRRvalue: "+theIRRvalue)
        println("finalinterestTotal: "+finalinterestTotal.round(2))
        println("cashOutlay = grantAmount - interest : "+cashOutlay)
        println("theGrantedAmount: "+theGrantedAmount)
        def forRemainingValue = finalinterestTotal.round(2)
        def sumAllinLoop =0
        
        
        while(theUIDdate<=loanInstance?.maturityDate){
            
            println("********************************************************************")
            println("The UID Date: "+theUIDdate)
            println("Total Amount: "+cashOutlay)
            
            // add 30 days from the loan InterestStartDate
            
            loanDiscount = cashOutlay * theIRRvalue
            cashOutlay = cashOutlay + loanDiscount
            
            println("")
            println("loanDiscount: "+loanDiscount.round(2))
            sumAllinLoop = sumAllinLoop + loanDiscount.round(2)
            
            println("")
            
            println("********************************************************************")
            finalinterestTotal = finalinterestTotal.round(2) - loanDiscount.round(2)
            println("finalinterestTotal: "+finalinterestTotal.round(2))
            if (uidDays - advInterestDays == 0){
                println("if condition enter...")
                loanDiscount = loanDiscount + finalinterestTotal.round(2)
            }
            
                                    
            calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH))
            endOfMonth = calendar.getTime()
            
            def eirSchedule = new LoanEIRSchedule(transferDate: endOfMonth, uidAmount: loanDiscount.round(2))
            loanInstance.addToLoanEIRSchedules(eirSchedule)
            println("theUIDdate now: "+theUIDdate)
            theUIDdate += 30 // date + 30         
            uidDays += 30
            calendar.add(Calendar.MONTH, 1)
            if (uidDays > advInterestDays && (uidDays - advInterestDays) != 30){
                println("if condition enter...")
                def solveRemaining = forRemainingValue - sumAllinLoop              
                def eirScheduleLast = new LoanEIRSchedule(transferDate:loanInstance.maturityDate, uidAmount: solveRemaining.round(2))
                loanInstance.addToLoanEIRSchedules(eirScheduleLast)            
            }     
        } // end of while
        println("================== EXIT GENERATE UID SCHEDULE IRR ======================")
    }
    // Used when UID schedule is not modified
    def saveEIRSchedules(Loan loanInstance) {
        HttpSession session = RequestContextHolder.currentRequestAttributes().getSession()

        for(eirSchedule in session["eirSchedules"]) {
            //eirSchedule.save flush:true
            loanInstance.addToLoanEIRSchedules(eirSchedule)            
        }
        session["eirSchedules"] = null
    }

    def initializeInstallment(LoanInstallment installment) {
        installment.normalInterestInstallmentAmount = installment?.interestInstallmentAmount 
        installment.penaltyInstallmentAmount = 0
        installment.pastDueInterestInstallmentAmount = 0
        installment.pastDuePenaltyInstallmentAmount = 0
        installment.taxInstallmentAmount = 0


        installment.principalInstallmentPaid = 0   
        installment.interestInstallmentPaid = 0
        installment.pastDueInterestInstallmentPaid = 0
        installment.penaltyInstallmentPaid = 0
        installment.pastDuePenaltyInstallmentPaid = 0
        installment.serviceChargeInstallmentPaid = 0
        installment.taxInstallmentPaid = 0

        installment.status = LoanInstallmentStatus.get(2)
    }

    def generateInstallmentSchedule(Loan loanInstance, Double installmentAmountOverride) {
        def amount = loanInstance?.grantedAmount ?: 0.00D
        def term = loanInstance?.term ?: 0
        def numInstallments = loanInstance?.numInstallments ?: 0
        def balloonInstallments = loanInstance?.balloonInstallments ?: 0
        def interestRate = (loanInstance?.interestRate ?: 0)  * 0.01
        def contractualRate = interestRate / 12
        def openingDate = loanInstance?.openingDate ?: null
        def interestStartDate = loanInstance?.interestStartDate ?: null
        def firstInstallmentDate = loanInstance?.firstInstallmentDate ?: null        
        def divisor = loanInstance?.interestIncomeScheme?.divisor ?: 0
        def gracePeriod = loanInstance?.interestIncomeScheme?.gracePeriod ?: 0  

        /*if (!loanInstance?.interestStartDate) {
            loanInstance.interestStartDate = loanInstance?.openingDate
        }*/
      
        def monthlyInstallment = 0.00D
        def principal
        def interest
        def serviceCharge
        def installmentAmount
        def balance
        def prevBalance
        def dueDate
        def prevDueDate 
        def installment   
        def baseDate
        amount = amount.round(2)
        
        def totalDeductions = 0.00D
        for(loanDeduction in loanInstance?.loanDeductions) {
            totalDeductions += loanDeduction?.amount.round(2)    
        }
        def totalDeductionsEir = 0.00D
        for(loanDeduction in loanInstance?.loanDeductions) {
            if (loanDeduction?.scheme?.hasEirMode == true) {
                totalDeductionsEir += loanDeduction?.amount.round(2)    
            }
        }
        def adv = 0.00D
        if (loanInstance?.interestIncomeScheme?.advInterestType?.id == 2) {
            adv = (amount * interestRate * term) / divisor    
        }  else if (loanInstance?.interestIncomeScheme?.advInterestType?.id == 3) {
            def advDays = loanInstance?.advInterestDays ?: 0
            adv = (amount * interestRate * advDays) / divisor
        } 
        //totalDeductions += adv.round(2)
        totalDeductions = totalDeductions.round(2) + adv.round(2)
        totalDeductionsEir += adv.round(2)
        def cashFlows = []
        cashFlows.add(amount - totalDeductionsEir)
        
        def installmentType = loanInstance?.interestIncomeScheme?.installmentType.id
        def installmentCalculation = loanInstance?.interestIncomeScheme?.installmentCalcType.id

        prevDueDate = firstInstallmentDate
        baseDate = firstInstallmentDate
        if (installmentType != 5 && installmentCalculation != 1 && installmentCalculation != 6) {
            for(int i = 1; i <= gracePeriod; i++) {
                //dueDate = loanInstance.getNextDueDate(prevDueDate)
                dueDate = getNextDueDate(prevDueDate, baseDate, loanInstance?.frequency.id.toInteger())
                cashFlows.add(0)

                installment = new LoanInstallment(sequenceNo: i, installmentDate: dueDate, principalInstallmentAmount: 0, 
                    interestInstallmentAmount: 0, serviceChargeInstallmentAmount: 0, totalInstallmentAmount: 0)
                initializeInstallment(installment)
                //installment.save flush:true
                loanInstance.addToLoanInstallments(installment)

                prevDueDate = dueDate
                baseDate = baseDate
            }
        }

        if (installmentCalculation == 1) {  // single payment   
            term = term + gracePeriod
            //dueDate = firstInstallmentDate ?: openingDate + term
            dueDate = openingDate + term
            //term = dueDate - (interestStartDate ?: openingDate)        

            //if (!loanInstance?.firstInstallmentDate) {
            //    loanInstance.firstInstallmentDate = dueDate
            //}
            loanInstance.firstInstallmentDate = dueDate
            principal = amount

            def advInterestType = loanInstance?.interestIncomeScheme?.advInterestType?.id

            if (advInterestType == 1) {
                interest = (amount * interestRate * term) / divisor    
            } else if (advInterestType == 2) {
                interest = 0D                
            } else if (advInterestType == 3) {
                def advInterestDays = loanInstance?.advInterestDays ?: 0
                interest = amount * interestRate * ((term - advInterestDays) / divisor)
            } 

            serviceCharge = getServiceCharge(loanInstance, principal)
            installmentAmount = principal + interest + serviceCharge                                       
            balance = amount - principal
            // add cash flow for eir
            /*
            if (advInterestType != 1) {
                def eirTerm = term
                for(int i = 1; i < eirTerm; i++) {
                    if ((i % 30) == 0) {
                        cashFlows.add(0)
                        println i
                    }
                }                   
            }
            */
            def eirTerm = term
            for(int i = 1; i < eirTerm; i++) {
                if ((i % 30) == 0) {
                    cashFlows.add(0)
                }
            }  
            cashFlows.add(installmentAmount * -1)

            installment = new LoanInstallment(sequenceNo: 1, installmentDate: dueDate, 
                    principalInstallmentAmount: principal.round(2), interestInstallmentAmount: interest.round(2), 
                    serviceChargeInstallmentAmount: serviceCharge.round(2), totalInstallmentAmount: installmentAmount.round(2))
            initializeInstallment(installment)
            //installment.save flush:true
            loanInstance.addToLoanInstallments(installment)
            //loanInstance.save flush:true                                        
        } else if (installmentType == 5 || installmentCalculation == 6) {  // manual                        
            HttpSession session = RequestContextHolder.currentRequestAttributes().getSession()
            Date startDate = openingDate

            prevBalance = amount
            for(int i = 1; i <= session["installments"].size(); i++) {
                /*def installments = session["installments"]
                installment = installments[i-1]*/
                installment = session["installments"].get(i-1)

                /*if (i == 1 && firstInstallmentDate) {
                    installment.installmentDate = firstInstallmentDate
                }*/

                dueDate = installment.installmentDate
                if (i == 1 && !loanInstance?.firstInstallmentDate) {
                    loanInstance.firstInstallmentDate = dueDate
                }

                principal = installment.principalInstallmentAmount
                interest = installment.interestInstallmentAmount
                
                // compute interest
                /*
                if (startDate < dueDate) {
                   interest = prevBalance * (dueDate - startDate) * interestRate.div(divisor) 
                } else {
                   interest = 0.00d 
                }
                */

                if (interestStartDate) {
                    if (dueDate > interestStartDate) {
                        interest = prevBalance * (interestRate / divisor) * (dueDate - interestStartDate)
                        interestStartDate = null
                    } else {
                        interest = 0D
                    }                            
                } else {
                    interest = prevBalance * (interestRate / divisor) * (dueDate - prevDueDate)
                }

                //serviceCharge = getServiceCharge(loanInstance, principal) modify manual service charge input
                if (installment.serviceChargeInstallmentAmount) {
                    serviceCharge = installment.serviceChargeInstallmentAmount.round(2)
                } else {
                    serviceCharge = 0.00d
                }
                
                installmentAmount = principal + interest + serviceCharge
                balance = prevBalance - principal

                cashFlows.add(installmentAmount * -1)

                installment.sequenceNo = i
                installment.principalInstallmentAmount = principal.round(2)
                installment.interestInstallmentAmount = interest.round(2)
                installment.serviceChargeInstallmentAmount = serviceCharge.round(2)
                installment.totalInstallmentAmount = installmentAmount.round(2)
                initializeInstallment(installment)
                installment.save flush:true

                loanInstance.addToLoanInstallments(installment)
                println installment
                //loanInstance.save flush:true                                        
                
                prevBalance = balance
                prevDueDate = dueDate
                baseDate = baseDate
                startDate = dueDate
            }
            session["installments"] = null
        } else if (installmentCalculation == 2) {  // declining fixed principal
            prevBalance = amount
            monthlyInstallment = amount / (numInstallments + balloonInstallments)
            monthlyInstallment = monthlyInstallment.round(2)
            for(int i = 1 + gracePeriod; i <= numInstallments + gracePeriod; i++) {
                if (i == 1 && firstInstallmentDate) {
                    dueDate = firstInstallmentDate
                    prevDueDate = loanInstance?.openingDate
                } else {
                    //dueDate = loanInstance.getNextDueDate(prevDueDate)
                    dueDate = getNextDueDate(prevDueDate, baseDate, loanInstance?.frequency.id.toInteger())
                }

                if (i == 1 && !loanInstance?.firstInstallmentDate) {
                    loanInstance.firstInstallmentDate = dueDate
                }

                principal = monthlyInstallment
                if (i == numInstallments + gracePeriod) {
                    principal = balance
                }
                    println i
                    println '---------------------------------------------'println principal
                    println balance
                    println prevBalance
                    
                def advInterestType = loanInstance?.interestIncomeScheme?.advInterestType?.id
                if (advInterestType == 3 && i - gracePeriod <= loanInstance?.advInterestPeriods) {
                    interest = 0D
                } else {
                    if (interestStartDate) {
                        if (dueDate >= interestStartDate) {
                            // interest = prevBalance * contractualRate
                            term = dueDate - prevDueDate
                            interest = prevBalance * term * interestRate.div(divisor)
                            interestStartDate = null
                        } else {
                            interest = 0D
                        }
                    } else {
                        //interest = prevBalance * contractualRate
                        term = dueDate - prevDueDate
                        interest = prevBalance * term * interestRate.div(divisor)
                    }
                }

                serviceCharge = getServiceCharge(loanInstance, principal)
                installmentAmount = principal + interest + serviceCharge                                       
                balance = prevBalance - principal

                cashFlows.add(installmentAmount * -1)

                installment = new LoanInstallment(sequenceNo: i, installmentDate: dueDate, 
                    principalInstallmentAmount: principal.round(2), interestInstallmentAmount: interest.round(2), 
                    serviceChargeInstallmentAmount: serviceCharge.round(2), totalInstallmentAmount: installmentAmount.round(2))
                initializeInstallment(installment)
                //installment.save flush:true
                loanInstance.addToLoanInstallments(installment)
                //loanInstance.save flush:true
                
                prevBalance = balance
                prevDueDate = dueDate
                baseDate = baseDate
            }
        } else if (installmentCalculation == 3) {  // annuity/mortgage
            def compoundingRate

            def frequency = loanInstance.frequency.id
            if (frequency == 1 || frequency == 2) {
                compoundingRate = contractualRate / 30
            } else if (frequency == 3) {
                compoundingRate = (contractualRate / 30) * 7
            } else if (frequency == 4) {
                compoundingRate = (contractualRate / 30) * 14
            } else if (frequency == 5) {
                compoundingRate = (contractualRate / 30) * 15
            } else if (frequency == 6 || frequency == 7) {
                compoundingRate = contractualRate
            } else if (frequency == 8) {
                compoundingRate = interestRate / 6
            } else if (frequency == 9) {
                compoundingRate = interestRate / 4
            } else if (frequency == 10) {
                compoundingRate = interestRate / 2
            } else if (frequency == 11) {
                compoundingRate = interestRate
            } else {
                compoundingRate = contractualRate
            }

            prevBalance = amount  

            if (!installmentAmountOverride) {
                monthlyInstallment = FinanceLib.pmt(compoundingRate, numInstallments, amount * -1, 0, false)
            } else {
                monthlyInstallment = installmentAmountOverride
            }
            monthlyInstallment = monthlyInstallment.round(2)

            for(int i = 1 + gracePeriod; i <= numInstallments + gracePeriod; i++) {               
                if (i == 1 && firstInstallmentDate) {
                    dueDate = firstInstallmentDate
                    prevDueDate = loanInstance?.openingDate
                } else {
                    //dueDate = loanInstance.getNextDueDate(prevDueDate)
                    dueDate = getNextDueDate(prevDueDate, baseDate, loanInstance?.frequency.id.toInteger())
                }

                if (i == 1 && !loanInstance?.firstInstallmentDate) {
                    loanInstance.firstInstallmentDate = dueDate
                }

                if (interestStartDate) {
                    if (dueDate >= interestStartDate) {
                        // interest = prevBalance * compoundingRate
                        term = dueDate - prevDueDate
                        interest = prevBalance * term * interestRate.div(divisor)                        
                        interestStartDate = null
                    } else {
                        interest = 0D
                    }
                } else {                    
                    if (loanInstance.frequency.id == 3) {  // weekly
                        // interest = prevBalance * compoundingRate
                        term = dueDate - prevDueDate
                        interest = prevBalance * term * interestRate.div(divisor)                        
                    } else {
                        // interest = prevBalance * contractualRate
                        term = dueDate - prevDueDate
                        interest = prevBalance * term * interestRate.div(divisor)                        
                    }  
                }
                interest = interest.round(2)
                
                if (i == numInstallments + gracePeriod) {
                    principal = prevBalance
                    monthlyInstallment = principal + interest
                } else {
                    principal = monthlyInstallment - interest    
                }                
                serviceCharge = (getServiceCharge(loanInstance, principal)).round(2)
                installmentAmount = monthlyInstallment + serviceCharge
                balance = prevBalance - principal

                cashFlows.add(installmentAmount * -1)
                
                installment = new LoanInstallment(sequenceNo: i, installmentDate: dueDate, 
                    principalInstallmentAmount: principal.round(2), interestInstallmentAmount: interest.round(2), 
                    serviceChargeInstallmentAmount: serviceCharge.round(2), totalInstallmentAmount: installmentAmount.round(2))
                initializeInstallment(installment)
                //installment.save flush:true
                loanInstance.addToLoanInstallments(installment)
                //loanInstance.save flush:true
                
                prevBalance = balance
                prevDueDate = dueDate
                baseDate = baseDate
            }
        } else if (installmentCalculation == 4) {  // rule of 78
            prevBalance = amount
            monthlyInstallment = amount / numInstallments
            monthlyInstallment = monthlyInstallment.round(2)
            def totalInterest = (amount * contractualRate * numInstallments).toDouble()
            for(int i = 1 + gracePeriod; i <= numInstallments + gracePeriod; i++) {
                if (i == 1 && firstInstallmentDate) {
                    dueDate = firstInstallmentDate
                } else {
                    //dueDate = loanInstance.getNextDueDate(prevDueDate)
                    dueDate = getNextDueDate(prevDueDate, baseDate, loanInstance?.frequency.id.toInteger())
                }

                if (i == 1 && !loanInstance?.firstInstallmentDate) {
                    loanInstance.firstInstallmentDate = dueDate
                }

                principal = monthlyInstallment
                
                if (interestStartDate) {
                    if (dueDate > interestStartDate) {
                        interest = ((numInstallments - i + 1) / 78) * totalInterest
                        interestStartDate = null
                    } else {
                        interest = 0D
                    }
                } else {
                    interest = ((numInstallments - i + 1) / 78) * totalInterest
                }

                serviceCharge = getServiceCharge(loanInstance, principal)
                installmentAmount = principal + interest + serviceCharge
                balance = prevBalance - principal

                cashFlows.add(installmentAmount * -1)

                installment = new LoanInstallment(sequenceNo: i, installmentDate: dueDate, 
                    principalInstallmentAmount: principal.round(2), interestInstallmentAmount: interest.round(2), 
                    serviceChargeInstallmentAmount: serviceCharge.round(2), totalInstallmentAmount: installmentAmount.round(2))
                initializeInstallment(installment)
                //installment.save flush:true
                loanInstance.addToLoanInstallments(installment)
                //loanInstance.save flush:true
                
                prevBalance = balance
                prevDueDate = dueDate
                baseDate = baseDate
            }
        } else if (installmentCalculation == 5) {  // straight/flat
            prevBalance = amount
            monthlyInstallment = amount / (numInstallments + balloonInstallments)
            monthlyInstallment = monthlyInstallment.round(2)
            interest = amount * contractualRate
            prevBalance = amount
            for(int i = 1 + gracePeriod; i <= numInstallments + gracePeriod; i++) {
                if (i == 1 && firstInstallmentDate) {
                    dueDate = firstInstallmentDate
                } else {
                    //dueDate = loanInstance.getNextDueDate(prevDueDate)
                    dueDate = getNextDueDate(prevDueDate, baseDate, loanInstance?.frequency.id.toInteger())
                }

                if (i == 1 && !loanInstance?.firstInstallmentDate) {
                    loanInstance.firstInstallmentDate = dueDate
                }                
                
                def advInterestType = loanInstance?.interestIncomeScheme?.advInterestType?.id
                if (advInterestType == 2 || (advInterestType == 3 && i - gracePeriod <= loanInstance?.advInterestPeriods)) {
                    interest = 0D
                } else {
                    if (interestStartDate) {
                        if (dueDate > interestStartDate) {
                            interest = amount * contractualRate
                            interestStartDate = null
                        } else {
                            interest = 0D
                        }
                    } else {
                        interest = amount * contractualRate
                    }
                }

                principal = monthlyInstallment
                if (i == numInstallments + gracePeriod) {
                    principal = balance
                    monthlyInstallment = balance
                }
                serviceCharge = getServiceCharge(loanInstance, principal)
                installmentAmount = monthlyInstallment + interest + serviceCharge                    
                balance = prevBalance - principal

                cashFlows.add(installmentAmount * -1)

                installment = new LoanInstallment(sequenceNo: i, installmentDate: dueDate, 
                    principalInstallmentAmount: principal.round(2), interestInstallmentAmount: interest.round(2), 
                    serviceChargeInstallmentAmount: serviceCharge.round(2), totalInstallmentAmount: installmentAmount.round(2))
                initializeInstallment(installment)
                //installment.save flush:true
                loanInstance.addToLoanInstallments(installment)
                //loanInstance.save flush:true
                
                prevBalance = balance
                prevDueDate = dueDate
                baseDate = baseDate
            }
        } else if (installmentCalculation == 7) {  // periodic nnuity/mortgage
            def compoundingRate

            def frequency = loanInstance.frequency.id
            if (frequency == 1 || frequency == 2) {
                compoundingRate = contractualRate / 30
            } else if (frequency == 3) {
                compoundingRate = (contractualRate / 30) * 7
            } else if (frequency == 4) {
                compoundingRate = (contractualRate / 30) * 14
            } else if (frequency == 5) {
                compoundingRate = (contractualRate / 30) * 15
            } else if (frequency == 6 || frequency == 7) {
                compoundingRate = contractualRate
            } else if (frequency == 8) {
                compoundingRate = interestRate / 6
            } else if (frequency == 9) {
                compoundingRate = interestRate / 4
            } else if (frequency == 10) {
                compoundingRate = interestRate / 2
            } else if (frequency == 11) {
                compoundingRate = interestRate
            } else {
                compoundingRate = contractualRate
            }

            prevBalance = amount  

            if (!installmentAmountOverride) {
                monthlyInstallment = FinanceLib.pmt(compoundingRate, numInstallments, amount * -1, 0, false)
            } else {
                monthlyInstallment = installmentAmountOverride
            }
            monthlyInstallment = monthlyInstallment.round(2)

            for(int i = 1 + gracePeriod; i <= numInstallments + gracePeriod; i++) {               
                if (i == 1 && firstInstallmentDate) {
                    dueDate = firstInstallmentDate
                    prevDueDate = loanInstance?.openingDate
                } else {
                    //dueDate = loanInstance.getNextDueDate(prevDueDate)
                    dueDate = getNextDueDate(prevDueDate, baseDate, loanInstance?.frequency.id.toInteger())
                }

                if (i == 1 && !loanInstance?.firstInstallmentDate) {
                    loanInstance.firstInstallmentDate = dueDate
                }

                if (interestStartDate) {
                    if (dueDate >= interestStartDate) {
                        // interest = prevBalance * compoundingRate
                        term = dueDate - prevDueDate
                        interest = prevBalance * term * interestRate.div(divisor)                        
                        interestStartDate = null
                    } else {
                        interest = 0D
                    }
                } else {                    
                    if (loanInstance.frequency.id == 3) {  // weekly
                        // interest = prevBalance * compoundingRate
                        term = dueDate - prevDueDate
                        //interest = prevBalance * term * interestRate.div(divisor)
                        interest = prevBalance * interestRate.div(52)
                    } else {
                        // interest = prevBalance * contractualRate
                        term = dueDate - prevDueDate
                        interest = prevBalance * term * interestRate.div(divisor)                        
                    }  
                }
                // weekly frequency
                if (frequency == 3) {
                    interest = prevBalance * interestRate.div(52)
                    println 'interests  ======>' + interest
                }
                // monthly and monthly 30
                if (frequency == 7 || frequency == 6){
                    interest = prevBalance * interestRate.div(12)
                }
                // semi monthly
                if (frequency == 5){
                    interest = prevBalance * interestRate.div(24)
                }
                interest = interest.round(2)
                println 'round interests  ======>' + interest
                
                if (i == numInstallments + gracePeriod) {
                    principal = prevBalance
                    monthlyInstallment = principal + interest
                } else {
                    principal = monthlyInstallment - interest    
                }                
                serviceCharge = (getServiceCharge(loanInstance, principal)).round(2)
                installmentAmount = monthlyInstallment + serviceCharge
                balance = prevBalance - principal

                cashFlows.add(installmentAmount * -1)
                
                installment = new LoanInstallment(sequenceNo: i, installmentDate: dueDate, 
                    principalInstallmentAmount: principal.round(2), interestInstallmentAmount: interest.round(2), 
                    serviceChargeInstallmentAmount: serviceCharge.round(2), totalInstallmentAmount: installmentAmount.round(2))
                initializeInstallment(installment)
                //installment.save flush:true
                loanInstance.addToLoanInstallments(installment)
                //loanInstance.save flush:true
                
                prevBalance = balance
                prevDueDate = dueDate
                baseDate = baseDate
            }
        }
        def irr
        //def irr = Irr.irr(cashFlows as Double[])
        //if (Nan(irr)) {
            irr = customIrr(cashFlows as double[], 0)
        //}
        

        if ((installmentCalculation == 3 || installmentCalculation == 7 ) && loanInstance.frequency.id == 3) {
            // annuity with weekly amort
            def period = 52
            def factor = 0
            if (numInstallments == 13) {
                factor = 13.div(3)
            } else if (numInstallments == 18) {
                factor = 18.div(4)
            } else if (numInstallments == 22) {
                factor = 22.div(5)
            } else if (numInstallments == 26) {
                factor = 26.div(6)
            } else if (numInstallments == 31) {
                factor = 31.div(7)
            } else if (numInstallments == 36) {
                factor = 36.div(8)
            } else if (numInstallments == 40) {
                factor = 40.div(9)
            } else if (numInstallments == 44) {
                factor = 44.div(10)
            } else if (numInstallments == 48) {
                factor = 48.div(11)
            } else {
                factor = 52.div(12)
            }           
            
            loanInstance.effectiveInterestRate = ((((1 + irr)**period) - 1) * 100D).round(5)        
            loanInstance.monthlyInterestRate = ((((1 + irr)**factor) - 1) * 100D).round(5)        
        } else if ((installmentCalculation == 3 || installmentCalculation == 7 ) && loanInstance.frequency.id == 5) {
            // semi-monthly installment
            loanInstance.effectiveInterestRate = ((((1 + irr)**24) - 1) * 100D).round(5)
            loanInstance.monthlyInterestRate = (irr * 100D).round(5)             
        } else {
            // loanInstance.effectiveInterestRate = ((((1 + irr)**numInstallments) - 1) * 100D).round(2)
            loanInstance.effectiveInterestRate = ((((1 + irr)**12) - 1) * 100D).round(5)
            loanInstance.monthlyInterestRate = (irr * 100D).round(5)    
        }       
        // EIR Calculation for manual installment
        if (installmentCalculation==6) {
            if (loanInstance.frequency.id == 3) {
                // annuity with weekly amort
                def period = 52
                def factor = 0
                if (numInstallments == 13) {
                    factor = 13.div(3)
                } else if (numInstallments == 18) {
                    factor = 18.div(4)
                } else if (numInstallments == 22) {
                    factor = 22.div(5)
                } else if (numInstallments == 26) {
                    factor = 26.div(6)
                } else if (numInstallments == 31) {
                    factor = 31.div(7)
                } else if (numInstallments == 36) {
                    factor = 36.div(8)
                } else if (numInstallments == 40) {
                    factor = 40.div(9)
                } else if (numInstallments == 44) {
                    factor = 44.div(10)
                } else if (numInstallments == 48) {
                    factor = 48.div(11)
                } else {
                    factor = 52.div(12)
                }           
            
                loanInstance.effectiveInterestRate = ((((1 + irr)**period) - 1) * 100D).round(5)        
                loanInstance.monthlyInterestRate = ((((1 + irr)**factor) - 1) * 100D).round(5)        
            } else if (loanInstance.frequency.id == 5) {
                // semi-monthly installment
                loanInstance.effectiveInterestRate = ((((1 + irr)**24) - 1) * 100D).round(5)
                loanInstance.monthlyInterestRate = (irr * 100D).round(5)             
            } else if (loanInstance.frequency.id == 7) {
                // loanInstance.effectiveInterestRate = ((((1 + irr)**numInstallments) - 1) * 100D).round(2)
                // monthly
                loanInstance.effectiveInterestRate = ((((1 + irr)**12) - 1) * 100D).round(5)
                loanInstance.monthlyInterestRate = (irr * 100D).round(5)    
             } else if (loanInstance.frequency.id == 9) {
                // loanInstance.effectiveInterestRate = ((((1 + irr)**numInstallments) - 1) * 100D).round(2)
                //quarterly
                loanInstance.effectiveInterestRate = ((((1 + irr)**4) - 1) * 100D).round(5)
                loanInstance.monthlyInterestRate = (irr * 100D).round(5)
            } else if (loanInstance.frequency.id == 10) {
                // loanInstance.effectiveInterestRate = ((((1 + irr)**numInstallments) - 1) * 100D).round(2)
                //semi-annual
                loanInstance.effectiveInterestRate = ((((1 + irr)**2) - 1) * 100D).round(5)
                loanInstance.monthlyInterestRate = (irr * 100D).round(5)                  
            } else {
                // revert to monthly which is default
                loanInstance.effectiveInterestRate = ((((1 + irr)**12) - 1) * 100D).round(5)
                loanInstance.monthlyInterestRate = (irr * 100D).round(5)                  
            }        
        }
        // force rounding
        loanInstance.effectiveInterestRate = loanInstance.effectiveInterestRate.round(5)
        loanInstance.monthlyInterestRate = loanInstance.monthlyInterestRate.round(5)    
        
        println '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'
        println irr
        println cashFlows
        println loanInstance.effectiveInterestRate
        println loanInstance.monthlyInterestRate
        println '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'
        
        
        loanInstance.totalNetProceeds = amount.round(2) - totalDeductions.round(2) 
        loanInstance.totalNetProceeds = loanInstance.totalNetProceeds.round(2)
        //loanInstance.maturityDate = dueDate
    
        // reset balances
        //loanInstance.balanceAmount = 0
        loanInstance.normalInterestAmount = 0
        loanInstance.interestBalanceAmount = 0
        loanInstance.penaltyBalanceAmount = 0
        loanInstance.serviceChargeBalanceAmount = 0

        //loanInstance.save flush:true        
    }    

// public static double getIRR(final double[] cashFlows)

     public static double customIrr(double[] values, double guess) {
         final int maxIterationCount = 2000;
         final double absoluteAccuracy = 1E-7;
 
         double x0 = guess;
         double x1;
 
         int i = 0;
         while (i < maxIterationCount) {

            // the value of the function (NPV) and its derivate can be calculated in the same loop
            final double factor = 1.0 + x0;
            int k = 0;
            double fValue = values[k];
            double fDerivative = 0;
            for (double denominator = factor; ++k < values.length; ) {
                final double value = values[k];
                fValue += value / denominator;
                denominator *= factor;
                fDerivative -= k * value / denominator;
            }

            // the essense of the Newton-Raphson Method
            x1 = x0 - fValue/fDerivative;

            if (Math.abs(x1 - x0) <= absoluteAccuracy) {
                return x1;
            }

            x0 = x1;
            ++i;
        }
        // maximum number of iterations is exceeded
       //return Double.NaN;
       return guess;
    }   
    // Used when installment schedule is not modified
    def saveInstallments(Loan loanInstance) {
        HttpSession session = RequestContextHolder.currentRequestAttributes().getSession()

        for(installment in session["installments"]) {
            //installment.save flush:true
            loanInstance.addToLoanInstallments(installment)            
        }
        session["installments"] = null
    }

    def writeOff(Loan loanInstance) {
        if (loanInstance?.loanApplication?.collaterals.size() > 0)
            loanInstance.grantedAmount = 0
        else
            loanInstance.balanceAmount = 1
           
            
         
        loanInstance.status = LoanAcctStatus.get(8)

        def type = LoanSpecialType.get(2)
        def action = ""
        def transferDate = new Date()
        if (loanInstance.special) {
            loanInstance.special.type = type
            loanInstance.special.action = action
            loanInstance.special.transferDate = transferDate
        } else {
            def special = new LoanSpecial(type: type, action: action, transferDate: transferDate)
            special.save flush:true
             
            loanInstance.special = special
        }

        loanInstance.save flush:true
    }

    def ropa(Loan loanInstance) {    
        def type = LoanSpecialType.get(3)
        def action = ""
        def transferDate = new Date()
        if (loanInstance.special) {
            loanInstance.special.type = type
            loanInstance.special.action = action
            loanInstance.special.transferDate = transferDate
        } else {
            def special = new LoanSpecial(type: type, action: action, transferDate: transferDate)
            special.save flush:true
             
            loanInstance.special = special
        }

        loanInstance.save flush:true

        //loanInstance.lock()
        saveServiceCharges(loanInstance)
        saveDeductions(loanInstance)      
        saveSweepAccounts(loanInstance)        
        saveInstallments(loanInstance)
        saveEIRSchedules(loanInstance)
        //loanInstance.merge()
        loanInstance.save flush:true
    }

    def commitLoanHistoryEntry(String activity) {
        HttpSession session = RequestContextHolder.currentRequestAttributes().getSession()
        
        if (session["loanHistory"]) {
            def loanHistory = session["loanHistory"].get(0)

            loanHistory.serviceCharges = session["newServiceCharges"]
            session["newServiceCharges"] = null
            loanHistory.loanDeductions = session["newDeductions"]
            session["newDeductions"] = null
            loanHistory.loanInstallments = session["newInstallments"]
            session["newInstallments"] = null
            loanHistory.loanEIRSchedules = session["newEIRSchedules"]
            session["newEIRSchedules"] = null
            //loanHistory.sweepAccounts = session["newSweepAccounts"]
            session["newSweepAccounts"] = null

            loanHistory.activity = activity
            loanHistory.dateModified = new Date()

            loanHistory.save flush:true 
            session["loanHistory"] = null                    
        }
    }

    def getMaturityDate(Loan loanInstance) {
        
        if(loanInstance?.interestIncomeScheme?.installmentType.id != 5 && loanInstance?.interestIncomeScheme?.installmentCalcType.id  != 1 && loanInstance?.firstInstallmentDate == null )
        {  
            def frequency = loanInstance?.frequency?.id
            def calendar = new GregorianCalendar()
            def next = new GregorianCalendar()
            def nextcal = new GregorianCalendar()
            calendar.setTime(loanInstance?.openingDate)
            next.setTime(loanInstance?.openingDate)
            nextcal.setTime(loanInstance?.openingDate)
            int max = 0
            int feb = 0
            nextcal.add(Calendar.MONTH, 1)
            max = nextcal.getActualMaximum(Calendar.DAY_OF_MONTH)       
                
                      switch(frequency) {
            case 1:  // daily
                calendar.add(Calendar.DAY_OF_MONTH, 1)
            break

            case 2:  // daily (no weekends)
                switch(calendar.get(Calendar.DAY_OF_WEEK)) {
                    case Calendar.FRIDAY:
                        calendar.add(Calendar.DAY_OF_MONTH, 3)
                    break

                    case Calendar.SATURDAY:
                        calendar.add(Calendar.DAY_OF_MONTH, 2)
                    break

                    default:
                        calendar.add(Calendar.DAY_OF_MONTH, 1)
                    break
                }
            break

            case 3:  // weekly
                calendar.add(Calendar.DAY_OF_MONTH, 7)
            break

            case 4:  // bi-weekly
                calendar.add(Calendar.DAY_OF_MONTH, 14)
            break

            case 5:  // semi-monthly
                calendar.add(Calendar.DAY_OF_MONTH, 15)
            break

            case 6:  // monthly (30 days)
                calendar.add(Calendar.DAY_OF_MONTH, 30)
            break

            case 7:  // monthly
             
             switch(next.get(Calendar.DAY_OF_MONTH)) {
                    case 31:
                         switch(calendar.get(Calendar.MONTH)){
                            case Calendar.JANUARY:
                                println max
                                        switch(max){
                                        case 28:
                                        calendar.add(Calendar.DAY_OF_MONTH, 28)
                                        break
                                        case 29:
                                             calendar.add(Calendar.DAY_OF_MONTH, 29)    
                                        break
                                    }
                             
                            break
                            case Calendar.FEBRUARY:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.MARCH:
                            calendar.add(Calendar.DAY_OF_MONTH, 30)
                            break
                            case Calendar.APRIL:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.MAY:
                            calendar.add(Calendar.DAY_OF_MONTH, 30)
                            break
                            case Calendar.JUNE:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.JULY:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.AUGUST:
                            calendar.add(Calendar.DAY_OF_MONTH, 30)
                            break
                            case Calendar.SEPTEMBER:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.OCTOBER:
                            calendar.add(Calendar.DAY_OF_MONTH, 30)
                            break
                            case Calendar.NOVEMBER:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.DECEMBER:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break    
                                }
                
                            break   
                    
                    case 30:
                        switch(calendar.get(Calendar.MONTH)){
                            case Calendar.JANUARY:
                                println max
                                         switch(max){
                                         case 28:
                                         calendar.add(Calendar.DAY_OF_MONTH, 29)
                                         break
                                         case 29:
                                         calendar.add(Calendar.DAY_OF_MONTH, 30)    
                                         break
                                    }
                            break
                            case Calendar.FEBRUARY:
                            calendar.add(Calendar.DAY_OF_MONTH, 30)
                            break
                            case Calendar.MARCH:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.APRIL:
                            calendar.add(Calendar.DAY_OF_MONTH, 30)
                            break
                            case Calendar.MAY:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.JUNE:
                            calendar.add(Calendar.DAY_OF_MONTH, 30)
                            break
                            case Calendar.JULY:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.AUGUST:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.SEPTEMBER:
                            calendar.add(Calendar.DAY_OF_MONTH, 30)
                            break
                            case Calendar.OCTOBER:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.NOVEMBER:
                            calendar.add(Calendar.DAY_OF_MONTH, 30)
                            break
                            case Calendar.DECEMBER:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break    
                                }
                            break
                            
                    case 29:
                       switch(calendar.get(Calendar.MONTH)){
                            case Calendar.JANUARY:
                                println max
                                         switch(max){
                                         case 28:
                                         calendar.add(Calendar.DAY_OF_MONTH, 30)
                                         break
                                         case 29:
                                         calendar.add(Calendar.DAY_OF_MONTH, 31)    
                                         break
                                    }
                            break
                            case Calendar.FEBRUARY:
                            calendar.add(Calendar.DAY_OF_MONTH, 29)
                            break
                            default:
                            calendar.add(Calendar.MONTH, 1)
                            break
                            }
                    break
                    default:
                    calendar.add(Calendar.MONTH, 1)
                    break
               
            
                }
            break
            case 8:  // bi-monthly
                calendar.add(Calendar.MONTH, 2)
            break

            case 9:  // quarterly
                calendar.add(Calendar.MONTH, 3)
            break

            case 10:  // semi-annually
                calendar.add(Calendar.MONTH, 6)
            break

            case 11:  // annually
                calendar.add(Calendar.YEAR, 1)
            break        
        }
           
           loanInstance?.firstInstallmentDate = calendar.getTime()                    
        } 
        def openingDate = loanInstance?.openingDate ?: null 
        def installmentType = loanInstance?.interestIncomeScheme?.installmentType.id
        def installmentCalculation = loanInstance?.interestIncomeScheme?.installmentCalcType.id 
        def term = loanInstance?.term ?: 0
        def numInstallments = loanInstance?.numInstallments ?: 0      
        def gracePeriod = loanInstance?.interestIncomeScheme?.gracePeriod ?: 0
        def firstInstallmentDate = loanInstance?.firstInstallmentDate ?: null
        def dueDate
        def prevDueDate = firstInstallmentDate 
        def baseDate = firstInstallmentDate       
        
        if (installmentType != 5 && installmentCalculation != 1 && installmentCalculation != 6) {
            for(int i = 1; i <= gracePeriod; i++) {
                //dueDate = loanInstance.getNextDueDate(prevDueDate)
                dueDate = getNextDueDate(prevDueDate, baseDate, loanInstance?.frequency.id.toInteger())
                prevDueDate = dueDate     
           
            }

        }

        if (installmentCalculation == 1) {  // single payment   
            term = term + gracePeriod
            //dueDate = firstInstallmentDate ?: openingDate + term   
            dueDate = openingDate + term  
        } else if (installmentType == 5 || installmentCalculation == 6) {  // manual
            HttpSession session = RequestContextHolder.currentRequestAttributes().getSession()

            def lastInstallment = session["installments"].get(session["installments"].size() - 1)
            dueDate = lastInstallment.installmentDate
        } else {  // others
            for(int i = 1 + gracePeriod; i <= numInstallments + gracePeriod; i++) {
                if (i == 1 && firstInstallmentDate) {
                    dueDate = firstInstallmentDate
                } else {
                    //dueDate = loanInstance.getNextDueDate(prevDueDate)
                    dueDate = getNextDueDate(prevDueDate, baseDate, loanInstance?.frequency.id.toInteger())
                }
                prevDueDate = dueDate
               
     
            }
        }

        return dueDate
    }
    
    def getServiceCharge(Loan loanInstance, Double principal) {
        Double totalServiceCharge = 0

        for(serviceCharge in loanInstance.serviceCharges) {
            if (serviceCharge?.scheme?.type?.id == 2) {  // rate based
                def rate = serviceCharge?.rate * 0.01
                totalServiceCharge += (principal * rate)
            } else {
                totalServiceCharge += serviceCharge?.amount    
            }
        }
        
        return totalServiceCharge
    }

    def getNextDueDate(Date prevDueDate,Date baseDate, int frequency) {
        
       
        def calendar = new GregorianCalendar()
        def next = new GregorianCalendar()
        def nextcal = new GregorianCalendar()
        int max = 0
        int feb = 0
        calendar.setTime(prevDueDate)
        next.setTime(baseDate)
        nextcal.setTime(prevDueDate)
        nextcal.add(Calendar.MONTH, 1)
        max = nextcal.getActualMaximum(Calendar.DAY_OF_MONTH)
        //feb = calendar.getActualMaximum(Calendar.DAY_OF_MONTH)
       
        
        switch(frequency) {
            case 1:  // daily
                calendar.add(Calendar.DAY_OF_MONTH, 1)
            break

            case 2:  // daily (no weekends)
                switch(calendar.get(Calendar.DAY_OF_WEEK)) {
                    case Calendar.FRIDAY:
                        calendar.add(Calendar.DAY_OF_MONTH, 3)
                    break

                    case Calendar.SATURDAY:
                        calendar.add(Calendar.DAY_OF_MONTH, 2)
                    break

                    default:
                        calendar.add(Calendar.DAY_OF_MONTH, 1)
                    break
                }
            break

            case 3:  // weekly
                calendar.add(Calendar.DAY_OF_MONTH, 7)
            break

            case 4:  // bi-weekly
                calendar.add(Calendar.DAY_OF_MONTH, 14)
            break

            case 5:  // semi-monthly
                calendar.add(Calendar.DAY_OF_MONTH, 15)
            break

            case 6:  // monthly (30 days)
                calendar.add(Calendar.DAY_OF_MONTH, 30)
            break

            case 7:  // monthly
             switch(next.get(Calendar.DAY_OF_MONTH)) {
                    case 31:
                         switch(calendar.get(Calendar.MONTH)){
                            case Calendar.JANUARY:
                                println max
                                        switch(max){
                                        case 28:
                                        calendar.add(Calendar.DAY_OF_MONTH, 28)
                                        break
                                        case 29:
                                             calendar.add(Calendar.DAY_OF_MONTH, 29)    
                                        break
                                    }
                             
                            break
                            case Calendar.FEBRUARY:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.MARCH:
                            calendar.add(Calendar.DAY_OF_MONTH, 30)
                            break
                            case Calendar.APRIL:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.MAY:
                            calendar.add(Calendar.DAY_OF_MONTH, 30)
                            break
                            case Calendar.JUNE:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.JULY:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.AUGUST:
                            calendar.add(Calendar.DAY_OF_MONTH, 30)
                            break
                            case Calendar.SEPTEMBER:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.OCTOBER:
                            calendar.add(Calendar.DAY_OF_MONTH, 30)
                            break
                            case Calendar.NOVEMBER:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.DECEMBER:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break    
                                }
                
                            break   
                    
                    case 30:
                        switch(calendar.get(Calendar.MONTH)){
                            case Calendar.JANUARY:
                                println max
                                         switch(max){
                                         case 28:
                                         calendar.add(Calendar.DAY_OF_MONTH, 29)
                                         break
                                         case 29:
                                         calendar.add(Calendar.DAY_OF_MONTH, 30)    
                                         break
                                    }
                            break
                            case Calendar.FEBRUARY:
                            calendar.add(Calendar.DAY_OF_MONTH, 30)
                            break
                            case Calendar.MARCH:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.APRIL:
                            calendar.add(Calendar.DAY_OF_MONTH, 30)
                            break
                            case Calendar.MAY:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.JUNE:
                            calendar.add(Calendar.DAY_OF_MONTH, 30)
                            break
                            case Calendar.JULY:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.AUGUST:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.SEPTEMBER:
                            calendar.add(Calendar.DAY_OF_MONTH, 30)
                            break
                            case Calendar.OCTOBER:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.NOVEMBER:
                            calendar.add(Calendar.DAY_OF_MONTH, 30)
                            break
                            case Calendar.DECEMBER:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break    
                                }
                            break
                            
                    case 29:
                       switch(calendar.get(Calendar.MONTH)){
                            case Calendar.JANUARY:
                                println max
                                         switch(max){
                                         case 28:
                                         calendar.add(Calendar.DAY_OF_MONTH, 30)
                                         break
                                         case 29:
                                         calendar.add(Calendar.DAY_OF_MONTH, 31)    
                                         break
                                    }
                            break
                            case Calendar.FEBRUARY:
                            calendar.add(Calendar.DAY_OF_MONTH, 29)
                            break
                            default:
                            calendar.add(Calendar.MONTH, 1)
                            break
                            }
                    break
                    default:
                    calendar.add(Calendar.MONTH, 1)
                    break
               
            
                }
            break
            case 8:  // bi-monthly
                calendar.add(Calendar.MONTH, 2)
            break

            case 9:  // quarterly
                calendar.add(Calendar.MONTH, 3)
            break

            case 10:  // semi-annually
                calendar.add(Calendar.MONTH, 6)
            break

            case 11:  // annually
                calendar.add(Calendar.YEAR, 1)
            break        
        }
       

        return calendar.getTime()
    }

    def getNumOfWeekends(Date startDate, Date endDate) {
        def numOfWeekends = 0;

        def date1 = startDate.clearTime()
        def date2 = endDate.clearTime()

        def calendar = new GregorianCalendar()
        calendar.setTime(date1)

        while(date1 < date2) {
            date1 = date1 + 1
            calendar.add(Calendar.DAY_OF_MONTH, 1)

            if (calendar.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY ||
                calendar.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY) {
                numOfWeekends++
            }                        
        }        

        return numOfWeekends
    }
}
