package icbs.deposit
import icbs.lov.CheckStatus
import icbs.lov.PassbookStatus
import icbs.lov.CertificateTimeDepositStatus
import icbs.lov.TxnType
import icbs.lov.SweepStatus
import icbs.deposit.CTD
import grails.transaction.Transactional
import grails.validation.ValidationException
import icbs.tellering.TxnFile
import icbs.tellering.TxnDepositAcctLedger
import icbs.tellering.TxnDepositFundTransfer
import icbs.admin.TxnTemplate
import icbs.admin.InwardClearingPointer
import icbs.tellering.TxnRemittance
import icbs.lov.ConfigItemStatus
import icbs.lov.RolloverStatus
import groovy.time.TimeCategory
import icbs.admin.Branch
import icbs.lov.DepositStatus
import icbs.admin.UserMaster
import icbs.admin.Institution
import java.text.SimpleDateFormat
import java.util.Formatter.DateTime

import org.springframework.web.context.request.RequestContextHolder
class DepositService {
    def glTransactionService
    def AuditLogService
    boolean transactional = false    
    @Transactional
    def inwardCheckClearing(inwardCheckClearingCommand cmd, Long userId){
        String errMsg = ''        
        def user = UserMaster.get(userId)
        def timestamp = new Date()
        def header = new DepositInwardClearingHeader(inwardHeaderId:timestamp,inwardBatch:timestamp)

        for(a in cmd.checks){
            def file = new DepositInwardClearingFile(inwardAcctNo:a.acctNo, inwardAmount:a.amt,inwardCheckNo:a.chequeNo,inwardBRSTN:a.brstn,inwardTranCd:a.trancd)
            if(!a.hasErrors()){
                def chequeInstance  = Cheque.findByChequeNo(a.chequeNo)
                if(chequeInstance){
                    def depositInstance = chequeInstance.chequebook.deposit
                    def chequebookInstance = chequeInstance.chequebook
                    file.deposit  = depositInstance
                    if(depositInstance.availableBalAmt< a.amt){
                        def sweepList = Sweep.createCriteria().list{
                            and{
                                eq("fundingDeposit",depositInstance)
                                eq("status",SweepStatus.read(2))   
                            }
                            order("ordinalNum", "asc")
                        }
                        def sweepRemAmt = a.amt
                        List<Deposit> depositTypeThreeSweep=[].withLazyDefault {new Deposit()}
                        for(sweep in sweepList){
                            def fundedDepositInstance  = sweep.fundedDeposit
                            if(sweep.rule.id==1){
                                if(fundedDepositInstance.availableBalAmt>=a.amt){
                                    fundedDepositInstance.availableBalAmt-=a.amt
                                    fundedDepositInstance.ledgerBalAmt-=a.amt
                                    chequeInstance.status = checkStatus.read(3)
                                    fundedDepositInstance.save()
                                    chequeInstance.save()
                                    break;
                                }
                                
                            }
                            if(sweep.rule.id==2){
                                if(fundedDepositInstance.ledgerBalAmt>=a.amt){
                                    fundedDepositInstance.availableBalAmt-=a.amt
                                    fundedDepositInstance.ledgerBalAmt-=a.amt
                                    chequeInstance.status = checkStatus.read(3)
                                    fundedDepositInstance.save()
                                    chequeInstance.save()
                                    break;
                                }
                            }
                            if(sweep.rule.id==3){
                               if(fundedDepositInstance.availableBalAmt>=a.amt){
                                    fundedDepositInstance.availableBalAmt-=a.amt
                                    fundedDepositInstance.ledgerBalAmt-=a.amt
                                    chequeInstance.status = checkStatus.read(3)
                                    fundedDepositInstance.save()
                                    chequeInstance.save()
                                    break;
                               }else{
                                    if(sweepTypeThreeAmt+fundedDepositInstance.availableBalAmt>=val){
                                       depositTypeThreeSweep.push(fundedDepositInstance)
                                        for(d in depositTypeThreeSweep){
                                            if(d.availableBalAmt<=sweepRemAmt){
                                               sweepRemAmt-=d.availableBalAmt
                                               d.availableBalAmt-= d.availableBalAmt
                                               d.ledgerBalAmt-=d.ledgerBalAmt
                                               d.save()
                                            }else{
                                               d.availableBalAmt-= sweepRemAmt
                                               d.availableBalAmt-=sweepRemAmt
                                               d.save()
                                            }
                                        }
                                        chequeInstance.status = checkStatus.read(3)
                                        fundedDepositInstance.save()
                                       break;
                                   }else{
                                       depositTypeThreeSweep.push(fundedDepositInstance)
                                   }
                               }
                            }
                            if(sweep.rule.id==4){
                                if(fundedDepositInstance.availableBalAmt*sweep.fundLimitPercentage>=a.amt){
                                    
                                    fundedDepositInstance.availableBalAmt-=a.amt
                                    fundedDepositInstance.ledgerBalAmt-=a.amt
                                    chequeInstance.status = checkStatus.read(3)
                                    fundedDepositInstance.save()
                                    chequeInstance.save()
                                    break;
                                }
                            }
                        }
                        // no sweep and no funds
                        if (!sweepList) {
                            def daifDesc = ''
                            if (a.amt > depositInstance.ledgerBalAmt) {
                                daifDesc = 'DAIF'
                            } else if (a.amt > depositInstance.availableBalAmt) {
                                daifDesc = 'DAUD'
                            }
                            def txnType = TxnTemplate.read(Institution.findByParamCode('GLS.60113').paramValue.toInteger())
                            def txnFile1 = new TxnFile(txnDate:Branch.get(1).runDate,txnParticulars:daifDesc,
                                currency:depositInstance.product.currency.id,txnType:txnType.txnType,status:ConfigItemStatus.read(2),
                                txnTimestamp:new Date().toTimestamp(),user:user,branch:depositInstance.branch,
                                txnCode:txnType.code, txnDescription:txnType.description,
                                acctNo:depositInstance.acctNo, txnAmt:a.amt,txnRef:daifDesc +' icc '+ a.chequeNo.toString(),
                                depAcct:depositInstance,txnTemplate:txnType)
                            txnFile1.save(flush:true,validate:false, failOnError:true)  
                            
                            def acctLedger1 = new TxnDepositAcctLedger(txnType:txnType.txnType,user:user,branch:depositInstance.branch,
                                currency:depositInstance.product.currency.id,status:depositInstance.status,txnDate:Branch.get(1).runDate,
                                txnFile:txnFile1,acct:depositInstance,acctNo:depositInstance.acctNo,debitAmt:a.amt,creditAmt:a.amt,
                                bal:depositInstance.ledgerBalAmt,txnRef:daifDesc +' icc '+ a.chequeNo.toString())
                            acctLedger1.save(flush:true, validate:false, failOnError:true)
                            file.txnFile = txnFile1
                            file.inwardReason = 'Insufficient Balance - ' + daifDesc                            
                        } 
                        header.addToClearingFiles(file)
                    }else{
                        // update txn file
                       def iccPointer = InwardClearingPointer.findByInwardBRSTN(file.inwardBRSTN)
                       def txnType
                       if (!iccPointer) {
                           txnType = TxnTemplate.read(Institution.findByParamCode('GLS.60112').paramValue.toInteger())
                       }  else {
                           txnType = iccPointer.txnTemplate
                       }
                       def txnFile1 = new TxnFile(txnDate:Branch.get(1).runDate,txnParticulars:'ICC',
                           currency:depositInstance.product.currency.id,txnType:txnType.txnType,status:ConfigItemStatus.read(2),
                           txnTimestamp:new Date().toTimestamp(),user:user,branch:depositInstance.branch,
                           txnCode:txnType.code, txnDescription:txnType.description,acctNo:depositInstance.acctNo,
                           txnAmt:a.amt,txnRef:'icc '+ a.chequeNo.toString(),depAcct:depositInstance,txnTemplate:txnType)
                       txnFile1.save(flush:true,validate:false, failOnError:true)
                       
                       depositInstance.availableBalAmt-=a.amt
                       depositInstance.ledgerBalAmt-=a.amt
                       chequeInstance.chequeAmt = a.amt
                       chequeInstance.isChequeClrOnUs = true
                       chequeInstance.status = CheckStatus.read(3)
                       chequebookInstance.chequesUsed += 1
                        
                       depositInstance.save(flush:true, failOnError:true)
                       chequeInstance.save(flush:true, failOnError:true)
                       chequebookInstance.save(flush:true, failOnError:true)
                        
                       // update ledger
                       def acctLedger1 = new TxnDepositAcctLedger(txnType:txnType.txnType,user:user,branch:depositInstance.branch,
                           currency:depositInstance.product.currency,status:depositInstance.status,txnDate:Branch.get(1).runDate,
                           txnFile:txnFile1,acct:depositInstance,acctNo:depositInstance.acctNo,debitAmt:a.amt,
                           bal:depositInstance.ledgerBalAmt,txnRef:'icc '+ a.chequeNo.toString())
                       acctLedger1.save(flush:true, validate:false, failOnError:true)                       
                       glTransactionService.saveInwardGl(txnFile1)
                       file.txnFile = txnFile1
                       header.addToClearingFiles(file)
                    }
                }   
                AuditLogService.insert('080', 'DEP01300', 'Process ICC '+header.id, 'DepositInwardClearingHeader', null, null, null, header.id)
            } else {
                // check errors
                if (a.errors.getFieldError('chequeNo')) {
                    errMsg = a.errors.getFieldError('chequeNo').code
                } else if (a.errors.getFieldError('amt')) {
                    errMsg = a.errors.getFieldError('amt').code
                }
                                
                file.inwardReason = errMsg
                header.addToClearingFiles(file)
            }
            header.save(flush:true,failOnError:true)
        }
    }
    @Transactional
     def memoRemittance(params){
        
        println params
        def result = [:]
        result.acct = Deposit.get(params.acct.id)
        //result.destinationAccount = Deposit.get(params.destinationAcct.id)
        def fail = { Map m ->
                if(m.error){
                    result.error = m.error
                }
                return result
        }   
        if (result.acct.status.id == 7 || result.acct.status.id == 8) {
            return fail(error:"Account Closed")
        }        
        double amount = params.amt.replace(',','').toDouble()
        
        def txnFile1
        def acctLedger1
        def txnRemittance
        def bal
        if(params.type.id.toInteger()==1){
            println "debit"
            bal = result.acct.ledgerBalAmt-amount
            result.acct.ledgerBalAmt-=amount
            result.acct.availableBalAmt-=amount
            result.acct.interestBalAmt-=amount
            txnFile1 = new TxnFile(txnDate:result.acct.branch.runDate,txnParticulars:params.txnDescription,currency:result.acct.product.currency.id,
                txnType:TxnType.read(),acctStatus:result.acct.status.id,status:ConfigItemStatus.read(2),txnTimestamp:new Date().toTimestamp(),
                user:params.user,branch:params.branch,txnCode:TxnTemplate.read(params.txnTemplate.id).code,
                txnDescription:TxnTemplate.read(params.txnTemplate.id).description,acctNo:result.acct.acctNo,txnAmt:amount,
                txnRef:params.txnRef,depAcct:result.acct,txnTemplate:params.txnTemplate.id)
            acctLedger1 = new TxnDepositAcctLedger(txnType:TxnType.read(7),user:params.user,branch:params.branch,
                currency:result.acct.product.currency.id,status:DepositStatus.read(2),txnDate:result.acct.branch.runDate,
                txnFile:txnFile1,acct:result.acct,acctNo:result.acct.acctNo,debitAmt:amount,bal:bal,txnRef:params.txnRef)
            }else if(params.type.id.toInteger()==2){
            println "credit"
            bal = result.acct.ledgerBalAmt+amount
            result.acct.ledgerBalAmt+=amount
            result.acct.availableBalAmt+=amount
            result.acct.interestBalAmt+=amount
            txnFile1 = new TxnFile(txnDate:result.acct.branch.runDate,txnParticulars:params.txnDescription,
                currency:result.acct.product.currency.id,txnType:TxnType.read(9),acctStatus:result.acct.status.id,
                status:ConfigItemStatus.read(2),txnTimestamp:new Date().toTimestamp(),user:params.user,branch:params.branch,
                txnCode:TxnTemplate.read(params.txnTemplate.id).code,txnDescription:TxnTemplate.read(params.txnTemplate.id).description,
                acctNo:result.acct.acctNo,txnAmt:amount,txnRef:params.txnRef,depAcct:result.acct,txnTemplate:params.txnTemplate.id)
            acctLedger1 = new TxnDepositAcctLedger(txnType:TxnType.read(9),user:params.user,branch:params.branch,
                currency:result.acct.product.currency.id,status:DepositStatus.read(2),txnDate:result.acct.branch.runDate,
                txnFile:txnFile1,acct:result.acct,acctNo:result.acct.acctNo,creditAmt:amount,bal:bal,txnRef:params.txnRef)
            //txn remittance
        }else{
            return fail(error:"Something went wrong")
        }
        if(!result.acct.save()||!txnFile1.save(flush:true,validate:false)||!acctLedger1.save(validate:false)){
            return fail(error:"Something went wrong")
        }
        glTransactionService.saveTxnBreakdown(txnFile1.id)
        result.txnFile = txnFile1
        return result
    }
    @Transactional
    def memoBillsPayment(params){
        println "pumasok dito sa test"
        def result = [:]
        result.acct = Deposit.get(params.acct.id)
        //result.destinationAccount = Deposit.get(params.destinationAcct.id)
        def fail = { Map m ->
                if(m.error){
                    result.error = m.error
                }
                return result
        }  
        if (result.acct.status.id == 7 || result.acct.status.id == 8) {
            return fail(error:"Account Closed")
        }
        def txnFile1
        def acctLedger1
        double amount = params.amt.replace(',','').toDouble()
        println "debited :" +amount
        //debit
        def bal
        bal = result.acct.ledgerBalAmt-amount
        result.acct.ledgerBalAmt-=amount
        result.acct.availableBalAmt-=amount
        result.acct.interestBalAmt-=amount
        
        def txnType = TxnTemplate.read(params.txnTemplate.id)
            txnFile1 = new TxnFile(txnDate:result.acct.branch.runDate,txnParticulars:params.txnDescription,currency:result.acct.product.currency.id,
                txnType:TxnType.read(7),acctStatus:result.acct.status.id,status:ConfigItemStatus.read(2),txnTimestamp:new Date().toTimestamp(),
                user:params.user,branch:params.branch,txnCode:TxnTemplate.read(params.txnTemplate.id).code,
                txnDescription:TxnTemplate.read(params.txnTemplate.id).description,acctNo:result.acct.acctNo,txnAmt:amount,txnRef:params.txnRef,
                depAcct:result.acct,txnTemplate:params.txnTemplate.id)
            acctLedger1 = new TxnDepositAcctLedger(txnType:TxnType.read(7),user:params.user,branch:params.branch,
                currency:result.acct.product.currency.id,status:DepositStatus.read(2),txnDate:result.acct.branch.runDate,
                txnFile:txnFile1,acct:result.acct,acctNo:result.acct.acctNo,debitAmt:amount,
                bal:bal,txnRef:params.txnRef)
            //bills payment wlang acct(deposit)
        //description missing in txnDepositAcctLedger
        if(!result.acct.save()||!txnFile1.save(flush:true,validate:false)||!acctLedger1.save(validate:false)){
            return fail(error:"Something went wrong")
        }
        glTransactionService.saveTxnBreakdown(txnFile1.id)
        result.txnFile = txnFile1
        return result
    }
    @Transactional
    def memoAdjustment(params){
        def result = [:]
        result.acct = Deposit.get(params.acct.id)
        //result.destinationAccount = Deposit.get(params.destinationAcct.id)
        def fail = { Map m ->
                if(m.error){
                    result.error = m.error
                }
                return result
        }   
        double amount = params.amt.replace(',','').toDouble()
        def txnFile1
        def acctLedger1
        def bal
        // allow only debit to closed
        if (result.acct.status.id == 7 || result.acct.status.id == 8) {
            if (params.type.toInteger()==2) {
                // cannot credit closed account
                return fail(error:"Account Closed")
            }
        }
        if (result.acct.ledgerBalAmt!=amount && params.type.toInteger()==1 &&  result.acct.type.id == 3 && result.acct.acrintAmt == 0 && result.acct.status.id == 7) {
            return fail(error:"Invalid debit Amount - Account already Closed")
        }
        // checking of txn template and txn type
        /*
        def t = TxnTemplate.get(params.txnTemplate.id)
        if (params.type.id.toInteger()==1) {
            if (t.txnType.id != 7) {
               return fail(error:"Invalid Debit Transaction Type Selected") 
            }
        }
        if(params.type.id.toInteger()==2) {
            if (t.txnType.id != 9) {
               return fail(error:"Invalid Credit Transaction Type Selected") 
            }            
        }
        */
        if(params.type.toInteger()==1 &&  result.acct.type.id != 3){
            bal = result.acct.ledgerBalAmt-amount            
            result.acct.ledgerBalAmt-=amount
            result.acct.availableBalAmt-=amount
            result.acct.interestBalAmt-=amount

            txnFile1 = new TxnFile(txnDate:result.acct.branch.runDate,txnParticulars:params.txnDescription,currency:result.acct.product.currency.id,
                txnType:TxnType.read(7),acctStatus:result.acct.status.id,status:ConfigItemStatus.read(2),
                txnTimestamp:new Date().toTimestamp(),user:params.user,branch:params.branch,txnCode:TxnTemplate.read(params.txnTemplate.id).code,
                txnDescription:TxnTemplate.read(params.txnTemplate.id).description,acctNo:result.acct.acctNo,txnAmt:amount,
                txnRef:params.txnRef,depAcct:result.acct,txnTemplate:params.txnTemplate.id)
            acctLedger1 = new TxnDepositAcctLedger(txnType:TxnType.read(7),user:params.user,branch:params.branch,
                currency:result.acct.product.currency.id,status:DepositStatus.read(2),txnDate:result.acct.branch.runDate,
                txnFile:txnFile1,acct:result.acct,acctNo:result.acct.acctNo,
                debitAmt:amount,bal:bal,txnRef:params.txnRef)
        } else if (params.type.toInteger()==1 &&  result.acct.type.id == 3 && result.acct.acrintAmt > 0){
            // fd interest wdl
            Double grossInt = 0
            Double taxAmt = 0
            Double intWdlAmt = 0
            Double totWdlAmt = 0
            Double NetRollInt = 0 
            
            //grossInt = depositInstance.acrintAmt
            taxAmt = result.acct?.currentRollover?.taxAmt1
            intWdlAmt = result.acct?.currentRollover?.normalInterestAmt
            totWdlAmt = intWdlAmt - taxAmt
 
            // post interest and tax transactions
            def intTxn = Institution.findByParamCode('DEP.40100').paramValue.toInteger()
            def taxTxn = Institution.findByParamCode('DEP.40110').paramValue.toInteger()
            
            def tfInt = new TxnFile(acctNo:result.acct.acctNo, branch:result.acct.branch, currency:result.acct.product.currency,
                depAcct:result.acct, status:ConfigItemStatus.read(2), txnTimestamp:new Date().toTimestamp(), txnDate:result.acct.branch.runDate,
                txnAmt:result.acct.currentRollover.normalInterestAmt, txnCode:TxnTemplate.get(intTxn).code, 
                txnType:TxnTemplate.get(intTxn).txnType, txnDescription:TxnTemplate.get(intTxn).description, 
                txnRef:result.acct.branch.runDate.toString() + ' Int Posting', txnTemplate:TxnTemplate.get(intTxn), user:params.user)
            tfInt.save(flush:true)	
                
            def dlInt = new TxnDepositAcctLedger(acct:result.acct, acctNo:result.acct.acctNo, 
                bal:result.acct.ledgerBalAmt + result.acct.currentRollover.normalInterestAmt, 
                creditAmt:result.acct.currentRollover.normalInterestAmt, currency:result.acct.product.currency,
                status:result.acct.status, txnDate:result.acct.branch.runDate, txnFile:tfInt, txnRef:result.acct.branch.runDate.toString() + ' Int Posting',
                txnType:TxnTemplate.get(intTxn).txnType, user:params.user, branch:result.acct.branch)	
            dlInt.save(flush:true)
            
            // post tax txn
            def tfTax = new TxnFile(acctNo:result.acct.acctNo, branch:result.acct.branch, currency:result.acct.product.currency,
                depAcct:result.acct, status:ConfigItemStatus.read(2), txnTimestamp:new Date().toTimestamp(),
                txnDate:result.acct.branch.runDate, txnAmt:taxAmt, txnCode:TxnTemplate.get(taxTxn).code, txnType:TxnTemplate.get(taxTxn).txnType,
                txnDescription:TxnTemplate.get(taxTxn).description, txnRef:result.acct.branch.runDate.toString() + ' Wholding Tax',
                txnTemplate:TxnTemplate.get(taxTxn), user:params.user)
                //tfTax.branch = branch
            tfTax.save(flush:true)	
                
            def dlTax = new TxnDepositAcctLedger(acct:result.acct, acctNo:result.acct.acctNo,
                bal:result.acct.ledgerBalAmt + intWdlAmt - taxAmt, debitAmt:taxAmt, currency:result.acct.product.currency,
                status:result.acct.status, txnDate:result.acct.branch.runDate, txnFile:tfTax, txnRef:result.acct.branch.runDate.toString() + ' Wholding Tax',
                txnType:TxnTemplate.get(taxTxn).txnType, user:params.user, branch:result.acct.branch)	
            dlTax.save(flush:true)     
                
            // update GL first for accruals before updating deposit account
            glTransactionService.saveTxnBreakdown(tfInt.id)
            glTransactionService.saveTxnBreakdown(tfTax.id)   
            
            result.acct.ledgerBalAmt=result.acct.ledgerBalAmt + intWdlAmt - taxAmt - amount
            result.acct.availableBalAmt=result.acct.ledgerBalAmt + intWdlAmt - taxAmt - amount
            result.acct.interestBalAmt==result.acct.ledgerBalAmt + intWdlAmt - taxAmt - amount

            txnFile1 = new TxnFile(txnDate:result.acct.branch.runDate,txnParticulars:params.txnDescription,currency:result.acct.product.currency.id,
                txnType:TxnType.read(7),acctStatus:result.acct.status.id,status:ConfigItemStatus.read(2),
                txnTimestamp:new Date().toTimestamp(),user:params.user,branch:params.branch,txnCode:TxnTemplate.read(params.txnTemplate.id).code,
                txnDescription:TxnTemplate.read(params.txnTemplate.id).description,acctNo:result.acct.acctNo,txnAmt:amount,
                txnRef:params.txnRef,depAcct:result.acct,txnTemplate:params.txnTemplate.id)
            acctLedger1 = new TxnDepositAcctLedger(txnType:TxnType.read(7),user:params.user,branch:params.branch,
                currency:result.acct.product.currency.id,status:DepositStatus.read(2),txnDate:result.acct.branch.runDate,
                txnFile:txnFile1,acct:result.acct,acctNo:result.acct.acctNo,
                debitAmt:amount,bal:result.acct.ledgerBalAmt,txnRef:params.txnRef) 
            
            result.acct.acrintAmt = 0.0
            result.acct.grossRolloverInterestAmt = 0.0
            result.acct.acrintDate = result.acct.branch.runDate
        }else if (params.type.toInteger()==1 &&  result.acct.type.id == 3 && result.acct.acrintAmt == 0) {
            // fd debit
            result.acct.ledgerBalAmt-=amount
            result.acct.availableBalAmt-=amount
            result.acct.interestBalAmt-=amount
            txnFile1 = new TxnFile(txnDate:result.acct.branch.runDate,txnParticulars:params.txnDescription,currency:result.acct.product.currency.id,
                txnType:TxnType.read(7),acctStatus:result.acct.status.id,status:ConfigItemStatus.read(2),
                txnTimestamp:new Date().toTimestamp(),user:params.user,branch:params.branch,txnCode:TxnTemplate.read(params.txnTemplate.id).code,
                txnDescription:TxnTemplate.read(params.txnTemplate.id).description,acctNo:result.acct.acctNo,txnAmt:amount,
                txnRef:params.txnRef,depAcct:result.acct,txnTemplate:params.txnTemplate.id)
            acctLedger1 = new TxnDepositAcctLedger(txnType:TxnType.read(7),user:params.user,branch:params.branch,
                currency:result.acct.product.currency.id,status:DepositStatus.read(2),txnDate:result.acct.branch.runDate,
                txnFile:txnFile1,acct:result.acct,acctNo:result.acct.acctNo,
                debitAmt:amount,bal:result.acct.ledgerBalAmt,txnRef:params.txnRef)            
        }else if(params.type.toInteger()==2){
            bal = result.acct.ledgerBalAmt+amount            
            result.acct.ledgerBalAmt+=amount
            result.acct.availableBalAmt+=amount
            result.acct.interestBalAmt+=amount

            txnFile1 = new TxnFile(txnDate:result.acct.branch.runDate,txnParticulars:params.txnDescription,currency:result.acct.product.currency.id,
                txnType:TxnType.read(9),acctStatus:result.acct.status.id,status:ConfigItemStatus.read(2),txnTimestamp:new Date().toTimestamp(),
                user:params.user,branch:params.branch,txnCode:TxnTemplate.read(params.txnTemplate.id).code,
                txnDescription:TxnTemplate.read(params.txnTemplate.id).description,acctNo:result.acct.acctNo,txnAmt:amount,
                txnRef:params.txnRef,depAcct:result.acct,txnTemplate:params.txnTemplate.id)
            acctLedger1 = new TxnDepositAcctLedger(txnType:TxnType.read(9),user:params.user,branch:params.branch,
                currency:result.acct.product.currency.id,status:DepositStatus.read(2),txnDate:result.acct.branch.runDate,txnFile:txnFile1,
                acct:result.acct,acctNo:result.acct.acctNo,creditAmt:amount,bal:bal,txnRef:params.txnRef)
            //description missing in txnDepositAcctLedger
        }else{
            return fail(error:"Something went wrong")
        }
        if(!result.acct.save()||!txnFile1.save(flush:true,validate:false)||!acctLedger1.save(validate:false)){
            return fail(error:"Something went wrong")
        }
        glTransactionService.saveTxnBreakdown(txnFile1.id)
        result.txnFile = txnFile1
        return result
    }
    @Transactional
    def fundTransfer(params, long user){
        println params
        def result = [:]
        result.fundingAcct = Deposit.get(params.fundingAcct.id)
        result.destinationAcct = Deposit.get(params.destinationAcct.id)
        result.txnTemplate = TxnTemplate.get(params.txnTemplate.id)
        def fail = { Map m ->
                status.setRollbackOnly()
                if(result.fundTransferInstance && m.field)
                    result.fundTransferInstance.errors.rejectValue(m.field, m.code)
                result.error = [ code: m.code, args: ["fundTransfer", params.id] ]
                return result
        }  
        
        if (params.fundingAcct == params.destinationAcct) { 
                result.error = [ code: result.fundingAcct, args: ["duplicate", params.id] ]
                return result            
        }
        
        if ((result.destinationAcct.statusId == 7) || (result.destinationAcct.statusId == 6)) { 
                result.error = [ code: result.fundingAcct, args: ["status", params.id] ]
                return result            
        }
        
        if (result.fundingAcct.product.productType.id == 3 || result.destinationAcct.product.productType.id == 3) {
                result.error = [ code: result.fundingAcct, args: ["FixedDeposit", params.id] ]
                return result            
        } 
        
        if (result.fundingAcct.product.currency != result.destinationAcct.product.currency) {
                result.error = [ code: result.fundingAcct, args: ["Currency", params.id] ]
                return result            
        }  
        def txnTmp = TxnTemplate.get(params.txnTemplate.id)
        if (result.fundingAcct.branch != result.destinationAcct.branch) {
            if (txnTmp.interbranchTxn.id != 1) {
                result.error = [ code: result.fundingAcct, args: ["InvalidInterbranch1", params.id] ]
                return result                   
            }         
        } else {
            if (txnTmp.interbranchTxn.id == 1) {
                result.error = [ code: result.fundingAcct, args: ["InvalidInterbranch2", params.id] ]
                return result                   
            }              
        } 
        double amount = params.amt.toDouble()
        
        //debit
        result.fundingAcct.ledgerBalAmt-=amount
        result.fundingAcct.availableBalAmt-=amount
        result.fundingAcct.interestBalAmt-=amount
        
  
        //credit
        result.destinationAcct.ledgerBalAmt+=amount
        result.destinationAcct.availableBalAmt+=amount
        result.destinationAcct.interestBalAmt+=amount
       
        
        // def txnTemplate = TxnTemplate.findByCode("008001")
       
        def fundDr = TxnTemplate.get(Institution.findByParamCode('DEP.40121').paramValue.toInteger())
        def fundCr = TxnTemplate.get(Institution.findByParamCode('DEP.40122').paramValue.toInteger())
        
        def acctLedger1 
        def acctLedger2
        def txnFile1 = new TxnFile(txnDate:result.fundingAcct.branch.runDate,txnParticulars:params.txnDescription,
            txnTemplate:fundDr.id,txnCode:fundDr.code,txnDescription:fundDr.codeDescription,
            txnType:fundDr.txnType.id,currency:result.fundingAcct.product.currency.id,
            acctStatus:result.fundingAcct.status.id,status:ConfigItemStatus.read(2),
            txnTimestamp:new Date().toTimestamp(),user:UserMaster.get(user),
            branch:result.fundingAcct.branch.id,acctNo:result.fundingAcct.acctNo,txnAmt:amount,
            txnRef:params.txnRef,depAcct:result.fundingAcct)
        def txnFile2 = new TxnFile(txnDate:result.fundingAcct.branch.runDate,txnParticulars:params.txnDescription,
            txnTemplate:fundCr.id,txnCode:fundCr.code,txnDescription:fundCr.codeDescription,
            txnType:fundCr.txnType.id,currency:result.destinationAcct.product.currency.id,
            acctStatus:result.destinationAcct.status.id,status:ConfigItemStatus.read(2),
            txnTimestamp:new Date().toTimestamp(),user:UserMaster.get(user),
            branch:result.destinationAcct.branch.id,acctNo:result.destinationAcct.acctNo,
            txnAmt:amount,txnRef:params.txnRef,depAcct:result.destinationAcct)
        
        acctLedger1 = new TxnDepositAcctLedger(txnType:fundDr.txnType.id,user:UserMaster.get(user),
            branch:result.fundingAcct.branch,currency:result.fundingAcct.product.currency.id,
            status:ConfigItemStatus.read(2),txnDate:result.fundingAcct.branch.runDate,
            txnFile:txnFile1,acct:result.fundingAcct,acctNo:result.fundingAcct.acctNo,
            txnRef:params.txnRef,debitAmt:amount,bal:result.fundingAcct.ledgerBalAmt)
        acctLedger2 = new TxnDepositAcctLedger(txnType:fundCr.txnType.id,user:UserMaster.get(user),
            branch:result.destinationAcct.branch,currency:result.destinationAcct.product.currency.id,
            status:ConfigItemStatus.read(2),txnDate:result.fundingAcct.branch.runDate,
            txnFile:txnFile2,acct:result.destinationAcct,txnRef:params.txnRef,
            acctNo:result.destinationAcct.acctNo,creditAmt:amount,bal:result.destinationAcct.ledgerBalAmt)
        
         //txn description missing in acctLedger
        //txn fund transfer missing
        if(!result.fundingAcct.save()||!result.destinationAcct.save()||!txnFile1.save(flush:true,validate:false)||!txnFile2.save(flush:true,validate:false)||!acctLedger1.save(flush:true,validate:false)||!acctLedger2.save(flush:true,validate:false)){
            //||!acctLedger1.save()||!acctLedger2.save()
            return fail(code:"default.save.failure")
        }
        def txnFt = new TxnDepositFundTransfer(branch: UserMaster.get(user).branch,
            drDeposit:result.fundingAcct, crDeposit:result.destinationAcct,
            drTxn:txnFile1, crTxn:txnFile2, fundTransferAmt:amount, txnParticulars:params.txnDescription,
            txnRef:params.txnRef, currency:result.fundingAcct.product.currency.id,
            txnDate:result.fundingAcct.branch.runDate, user:UserMaster.get(user), txnTemplate:params.txnTemplate)
        txnFt.save(flush:true)
        
        //glTransactionService.saveTxnBreakdown(txnFile1.id)
        //glTransactionService.saveTxnBreakdown(txnFile2.id)
        glTransactionService.saveDepositFundTransferGl(txnFt.id)
        
        return result
    }
    def saveSweep(params){
        Sweep.withTransaction { status ->
            def result = [:]
            def fail = { Map m ->
                status.setRollbackOnly()
                if(result.sweepInstance && m.field)
                    result.sweepInstance.errors.rejectValue(m.field, m.code)
                result.error = [ code: m.code, args: ["Sweep", params.id] ]
                return result
            }
            if (params.fundedDeposit == params.fundingDeposit) {
                println "duplicate account"    
                result.error = [ code: params.fundingDeposit, args: ["SweepAccount", params.id] ]
                return result            
            }  
            /*
            if (params.fundingDeposit.status.id == 1) {
                println "pending account"    
                result.error = [ code: params.fundingDeposit, args: ["SweepPending", params.id] ]
                return result            
            }  
            if (params.fundingDeposit.status.id >= 5) {
                println "account status"    
                result.error = [ code: params.fundingDeposit, args: ["SweepAcctStatus", params.id] ]
                return result            
            } 
            */
            result.sweepInstance = new Sweep()
            result.sweepInstance.properties = params
            result.sweepInstance.createdBy = UserMaster.get(params.userId)
            
            if(!result.sweepInstance.validate()){
                return fail(code:"default.save.failure")
            }
            result.sweepInstance.dateCreated = Branch.get(1).runDate
            result.sweepInstance.save()
            println '-------------------------------'
            println result.sweepInstance.dateCreated
            println '-------------------------------'
            AuditLogService.insert('080', 'DEP01501','saveSweep ' + result.sweepInstance.id, 'Sweep', null, null, null, result.sweepInstance.id)
            return result
        }
    }
    def updateSweep(params,includeList=null){
        Sweep.withTransaction { status ->
            def result = [:]
            def fail = { Map m ->
                status.setRollbackOnly()
                if(result.sweepInstance && m.field)
                    result.sweepInstance.errors.rejectValue(m.field, m.code)
                result.error = [ code: m.code, args: ["Sweep", params.id] ]
                return result
            }
            result.sweepInstance = Sweep.get(params.id)
            if(!result.sweepInstance){
                return fail(code:"default.not.found")
            }
            // Optimistic locking check.
            if(params.version) {
                if(result.sweepInstance.version > params.version.toLong())
                    return fail(field:"version", code:"default.optimistic.locking.failure")
            }
            if(!includeList){
                result.sweepInstance.properties=params
            }
            else{
                result.sweepInstance.properties[includeList]=params
            }
            if(!includeList){
                if(!result.sweepInstance.validate()){    
                    return fail(code:"default.update.failure")
                }
            }else{
                if(!result.sweepInstance.validate([includeList])){    
                    return fail(code:"default.update.failure")
                }
            }
            result.sweepInstance.save()  
            AuditLogService.insert('080', 'DEP01502','updateSweep ' + result.sweepInstance.id, 'Sweep', null, null, null, result.sweepInstance.id)
            // Success.
            return result
        } //end withTransaction
    }
    
    /***Stop Payment Order***/
    def saveStopPaymentOrder(params){
        StopPaymentOrder.withTransaction { status ->
            def result = [:]
            def fail = { Map m ->
                status.setRollbackOnly()
                if(result.stopPaymentOrderInstance && m.field)
                    result.stopPaymentOrderInstance.errors.rejectValue(m.field, m.code)
                result.error = [ code: m.code, args: ["StopPaymentOrder", params.id] ]
                return result
            }
            result.stopPaymentOrderInstance = new StopPaymentOrder()
            result.stopPaymentOrderInstance.properties = params
            if(!result.stopPaymentOrderInstance.validate()){
                return fail(code:"default.save.failure")
            }
            result.stopPaymentOrderInstance.cheque = Cheque.find{chequeNo==result.stopPaymentOrderInstance.chequeNo}
            result.stopPaymentOrderInstance.stopAt = result.stopPaymentOrderInstance.deposit.branch.runDate
            result.stopPaymentOrderInstance.save()
            AuditLogService.insert('080', 'DEP01401','saveStopPaymentOrder ' + result.stopPaymentOrderInstance.id, 'StopPaymentOrder', null, null, null, result.stopPaymentOrderInstance.id)
            return result
        }
    }
    def updateStopPaymentOrder(params,includeList=null){
        StopPaymentOrder.withTransaction { status ->
            def result = [:]
            def fail = { Map m ->
                status.setRollbackOnly()
                if(result.stopPaymentOrderInstance && m.field)
                    result.stopPaymentOrderInstance.errors.rejectValue(m.field, m.code)
                result.error = [ code: m.code, args: ["StopPaymentOrder", params.id] ]
                return result
            }
            result.stopPaymentOrderInstance = StopPaymentOrder.get(params.id)
            if(!result.stopPaymentOrderInstance){
                return fail(code:"default.not.found")
            }
            // Optimistic locking check.
            if(params.version) {
                if(result.stopPaymentOrderInstance.version > params.version.toLong())
                    return fail(field:"version", code:"default.optimistic.locking.failure")
            }
            if(!includeList){
                result.stopPaymentOrderInstance.properties=params
            }
            else{
                result.stopPaymentOrderInstance.properties[includeList]=params
            }
            if(!includeList){
                if(!result.stopPaymentOrderInstance.validate()){    
                    return fail(code:"default.update.failure")
                }
            }else{
                if(!result.stopPaymentOrderInstance.validate([includeList])){    
                    return fail(code:"default.update.failure")
                }
            }
            result.stopPaymentOrderInstance.save()  
            AuditLogService.insert('080', 'DEP01402','updateStopPaymentOrder ' + result.stopPaymentOrderInstance.id, 'StopPaymentOrder', null, null, null, result.stopPaymentOrderInstance.id)
            // Success.
            return result
        } //end withTransaction
    }
    /***Standing Order****/
    def saveStandingOrder(params){
        println params
        StandingOrder.withTransaction { status ->
            def result = [:]
            def fail = { Map m ->
                status.setRollbackOnly()
                if(result.standingOrderInstance && m.field)
                    result.standingOrderInstance.errors.rejectValue(m.field, m.code)
                result.error = [ code: m.code, args: ["StandingOrder", params.id] ]
                return result
            }
            result.standingOrderInstance = new StandingOrder()
            result.standingOrderInstance.properties = params
            if(!result.standingOrderInstance.validate()){
                return fail(code:"default.save.failure")
            }
            // check if same account
            if (params.fundedDeposit == params.fundingDeposit) {
                println 'duplicte account'
                return fail(code:"default.save.failure-duplicate Account")               
            }            
            result.standingOrderInstance.save(failOnError:true)
            AuditLogService.insert('080', 'DEP00901','saveStandingOrder ' + result.standingOrderInstance.id, 'StandingOrder', null, null, null, result.standingOrderInstance.id)
            return result
        }
    }
    def updateStandingOrder(params,includeList=null){
        StandingOrder.withTransaction { status ->
            def result = [:]
            def fail = { Map m ->
                status.setRollbackOnly()
                if(result.standingOrderInstance && m.field)
                    result.standingOrderInstance.errors.rejectValue(m.field, m.code)
                result.error = [ code: m.code, args: ["StandingOrder", params.id] ]
                return result
            }
            result.standingOrderInstance = StandingOrder.get(params.id)
            if(!result.standingOrderInstance){
                return fail(code:"default.not.found")
            }
            // Optimistic locking check.
            if(params.version) {
                if(result.standingOrderInstance.version > params.version.toLong())
                    return fail(field:"version", code:"default.optimistic.locking.failure")
            }
            if(!includeList){
                result.standingOrderInstance.properties=params
            }
            else{
                result.standingOrderInstance.properties[includeList]=params
            }
            if(!includeList){
                if(!result.standingOrderInstance.validate()){    
                    return fail(code:"default.update.failure")
                }
            }else{
                if(!result.standingOrderInstance.validate([includeList])){    
                    return fail(code:"default.update.failure")
                }
            }
            result.standingOrderInstance.save()  
            AuditLogService.insert('080', 'DEP00902','updateStandingOrder ' + result.standingOrderInstance.id, 'StandingOrder', null, null, null, result.standingOrderInstance.id)
            // Success.
            return result
        } //end withTransaction
    }
    /*********Hold*****/
    def saveHold(params){
       // println "save hold enter 1"
       // println "save hold enter 1 params "+params
        Hold.withTransaction { status ->
            def result = [:]
            def fail = { Map m ->
                status.setRollbackOnly()
                if(result.holdInstance && m.field)
                {
                    result.holdInstance.errors.rejectValue(m.field, m.code)
                 //   println "save hold enter 2"
                }
                result.error = [ code: m.code, args: ["Hold", params.id] ]
                return result
            }
            result.holdInstance = new Hold()
            
            result.holdInstance.properties = params
          //  result.holdInstance.heldBy = UserMaster.get(session.user_id)
            if(!result.holdInstance.validate()){
              //  println "save hold enter 3"
                return fail(code:"default.save.failure")
            }
            if (result.holdInstance.maturityDate <= Branch.get(1).runDate) {
                return fail(code:"save.InvalidMaturityDate.fail")
            }
            // do not allow cancelled or removed status for new hold
            if(result.holdInstance.status?.id>2){
              return fail(code:"save.InvalidStatus.fail")  
            }
            def value
            if(result.holdInstance.type?.id==1){
                value = result.holdInstance.amt
            }
            else if(result.holdInstance.type?.id==2){
                value = result.holdInstance.deposit.availableBalAmt*(result.holdInstance.percent/100)
                result.holdInstance.amt = value
            }
            println value
            println result.holdInstance.status?.id
            if(result.holdInstance.status?.id<3){
                if (result.holdInstance.status?.id==2) {
                    if (result.holdInstance.amt > result.holdInstance.deposit.availableBalAmt) {
                        return fail(code:"save.holdAmtGreaterThanAvailableBalance")
                    } 
                    if(result.holdInstance.type?.id==1){
                        result.holdInstance.deposit.availableBalAmt -= value
                        result.holdInstance.deposit.holdBalAmt+= value
                        result.holdInstance.deposit.save(validate:false,failOnError:true)
                    }
                    if(result.holdInstance.type?.id==2){
                        result.holdInstance.deposit.availableBalAmt -=value
                        result.holdInstance.deposit.holdBalAmt+=value
                        result.holdInstance.deposit.save(validate:false,failOnError:true)
                    }
                }
            }else{
                result.holdInstance.amt = value
                result.holdInstance.deposit.availableBalAmt +=value
                result.holdInstance.deposit.holdBalAmt -=value
                result.holdInstance.deposit.save(validate:false,failOnError:true)            
            }
          //  println "save hold enter 4"
            println result.holdInstance.status?.id
            result.holdInstance.save(failOnError:true)
            AuditLogService.insert('080', 'DEP00801','saveHold ' + result.holdInstance.id, 'Hold', null, null, null, result.holdInstance.id)
            return result
        }
    }
    def updateHold(params,includeList=null){
         println 'updateHold'
        Hold.withTransaction { status ->
            def result = [:]
            def fail = { Map m ->
                status.setRollbackOnly()
                if(result.holdInstance && m.field)
                    result.holdInstance.errors.rejectValue(m.field, m.code)
                result.error = [ code: m.code, args: ["Hold", params.id] ]
                return result
            }
            result.holdInstance = Hold.get(params.id)
            println 'hold instance '+result.holdInstance
            if(!result.holdInstance){
                 println 'err-2'
                return fail(code:"default.not.found")
            }
            // Optimistic locking check.
            if(params.version) {
                 println 'err-1'
                if(result.holdInstance.version > params.version.toLong())
                    return fail(field:"version", code:"default.optimistic.locking.failure")
            }
            if(!includeList){
                result.holdInstance.properties=params
            }
            else{
                result.holdInstance.properties[includeList]=params
            }
            if(!includeList){
                 println 'err1'
                if(!result.holdInstance.validate()){    
                    return fail(code:"default.update.failure")
                }
            }else{
                println 'err2'
                if(!result.holdInstance.validate([includeList])){    
                    return fail(code:"default.update.failure")
                }
            }
            // change in maturity date
            if(result.holdInstance.getPersistentValue('maturityDate') != result.holdInstance.maturityDate) {
               if (result.holdInstance.maturityDate <= Branch.get(1).runDate) {
                   return fail(code:"default.update.failure-invalid Matutiry Date") 
               }  
            }            
            // do not allow active hold to become pending
            if(result.holdInstance.getPersistentValue('status')?.id==2 && result.holdInstance.status?.id==1) {
               return fail(code:"default.update.failure-Cannot set to pending") 
            }
            if(result.holdInstance.getPersistentValue('status')?.id==1 && result.holdInstance.status?.id==2){
                if (result.holdInstance.amt > result.holdInstance.deposit.availableBalAmt) {
                    return fail(code:"save.holdAmtGreaterThanAvailableBalance")
                }                
                if(result.holdInstance.type?.id==1){
                    result.holdInstance.deposit.availableBalAmt -=result.holdInstance.amt
                    result.holdInstance.deposit.holdBalAmt+= result.holdInstance.amt
                    result.holdInstance.deposit.save(validate:false,failOnError:true)
                 }
                if(result.holdInstance.type?.id==2){
                    result.holdInstance.deposit.availableBalAmt -=result.holdInstance.amt
                    result.holdInstance.deposit.holdBalAmt+=result.holdInstance.amt
                    result.holdInstance.deposit.save(validate:false,failOnError:true)
                }
               
            }
            // editing of hold amount
            if(result.holdInstance.getPersistentValue('amt') != result.holdInstance.amt && result.holdInstance.status?.id==2){
                def newHoldAmt = result.holdInstance.amt - result.holdInstance.getPersistentValue('amt') 
                if(result.holdInstance.type?.id==1){
                    result.holdInstance.deposit.availableBalAmt -=newHoldAmt
                    result.holdInstance.deposit.holdBalAmt+= newHoldAmt
                    result.holdInstance.deposit.save(validate:false,failOnError:true)
                 }
                if(result.holdInstance.type?.id==2){
                    result.holdInstance.deposit.availableBalAmt -=newHoldAmt
                    result.holdInstance.deposit.holdBalAmt+=newHoldAmt
                    result.holdInstance.deposit.save(validate:false,failOnError:true)
                }
               
            }
            
            //cancel hold value
            if(result.holdInstance.getPersistentValue('status')?.id==2 && result.holdInstance.status?.id>=3){
                println 'cancel hold'
                result.holdInstance.deposit.availableBalAmt = result.holdInstance.deposit.availableBalAmt+result.holdInstance.amt
                result.holdInstance.deposit.holdBalAmt = result.holdInstance.deposit.holdBalAmt-result.holdInstance.amt
                result.holdInstance.deposit.save(validate:false,failOnError:true)
            }
            result.holdInstance.save(failOnError:true)
            AuditLogService.insert('080', 'DEP00802','updateHold ' + result.holdInstance.id, 'Hold', null, null, null, result.holdInstance.id)
            // Success.
            return result
        } //end withTransaction
    }
    /****CTD****/
     def saveCTD(params){
        IssueCTD.withTransaction { status ->
            println "pumasok sa save CTD transaction"
            def result = [:]
            def fail = { Map m ->
                status.setRollbackOnly()
                if(result.issueCTDInstance && m.field)
                    result.issueCTDInstance.errors.rejectValue(m.field, m.code)
                result.error = [ code: m.code, args: ["IssueCTD", params.id] ]
                return result
            }
            // check branch
            def ctdBr = CTD.findByCtdNo(params.ctdNo)
            def depBr = Deposit.get(params.deposit.id)
            if (ctdBr.docInventory.branch != depBr.branch) {
                result.error = [ code: 'invalid branch', args: ["IssuePassbook", params.id] ]
                return result                
            }
            
            result.issueCTDInstance = new IssueCTD()
            result.issueCTDInstance.properties = params

            if(!result.issueCTDInstance.validate()){
                return fail(code:"default.save.failure")
            }
            
            //result.issueCTDInstance.ctd = CTD.find(ctdNo==result.issueCTDInstance.ctdId)
            result.issueCTDInstance.ctd = CTD.findByCtdNo(result.issueCTDInstance.ctdNo)
            result.issueCTDInstance.ctd.interestRate = result.issueCTDInstance.deposit.depositInterestScheme?.interestRate
            result.issueCTDInstance.ctd.term = result.issueCTDInstance.deposit.fixedDepositTermScheme.value
            result.issueCTDInstance.ctd.principalAmt = result.issueCTDInstance.deposit.availableBalAmt
            result.issueCTDInstance.ctd.dateOpened = result.issueCTDInstance.deposit.dateOpened
            result.issueCTDInstance.ctd.maturityDate = result.issueCTDInstance.deposit.currentRollover.endDate
            result.issueCTDInstance.save(flush:true,failOnError:true)
            
            result.issueCTDInstance.ctd.status = CertificateTimeDepositStatus.read(2)
           
            
            result.issueCTDInstance.ctd.issueCTD = result.issueCTDInstance
            result.issueCTDInstance.ctd.docInventory.usageCount+=1
            
            if(result.issueCTDInstance.ctd.save(failOnError:true)&&result.issueCTDInstance.ctd.docInventory.save(failOnError:true)){
                println "lumabas sa save CTD transaction"
                AuditLogService.insert('080', 'DEP00701','saveCTD ' + result.issueCTDInstance.id, 'CTD', null, null, null, result.issueCTDInstance.id)
                return result
            }else{
                return fail(code:"Save Error")
            }
        }
    }
    def updateCTD(params,includeList=null){
        IssueCTD.withTransaction { status ->
            def result = [:]
            def fail = { Map m ->
                status.setRollbackOnly()
                if(result.issueCTDInstance && m.field)
                    result.issueCTDInstance.errors.rejectValue(m.field, m.code)
                result.error = [ code: m.code, args: ["IssueCTD", params.id] ]
                return result
            }
            result.issueCTDInstance = IssueCTD.get(params.id)
            if(!result.issueCTDInstance){
                return fail(code:"default.not.found")
            }
            // Optimistic locking check.
            if(params.version) {
                if(result.issueCTDInstance.version > params.version.toLong())
                    return fail(field:"version", code:"default.optimistic.locking.failure")
            }
            if(!includeList){
                result.issueCTDInstance.properties=params
            }
            else{
                result.issueCTDInstance.properties[includeList]=params
            }
            if(!includeList){
                if(!result.issueCTDInstance.validate()){    
                    return fail(code:"default.update.failure")
                }
            }else{
                if(!result.issueCTDInstance.validate([includeList])){    
                    return fail(code:"default.update.failure")
                }
            }
            result.issueCTDInstance.save(failOnError:true)  
            AuditLogService.insert('080', 'DEP00701','updateCTD ' + result.issueCTDInstance.id, 'CTD', null, null, null, result.issueCTDInstance.id)
            // Success.
            return result
        } //end withTransaction
    }
    def saveManualRollover(params, Long userId){
        Rollover.withTransaction { status ->
            println "pumasok sa save Manual Rollover transaction"
            def result = [:]
            def fail = { Map m ->
                status.setRollbackOnly()
                if(result.rolloverInstance && m.field)
                    result.rolloverInstance.errors.rejectValue(m.field, m.code)
                result.error = [ code: m.code, args: ["Rollover", params.id] ]
                return result
            } 
            /*
            result.rolloverInstance = new Rollover()
            result.rolloverInstance.properties = params
            result.rolloverInstance.type = result.rolloverInstance.deposit.currentRollover.type
            if(!result.rolloverInstance.validate()){
                return fail(code:"default.save.failure")
            }
            //result.rolloverInstance.save(flush:true,failOnError:true)
            result.rolloverInstance.save()
            result.rolloverInstance.deposit.addToRollovers(result.rolloverInstance)
            result.rolloverInstance.deposit.currentRollover =result.rolloverInstance
            result.rolloverInstance.deposit.save(flush:true)
            */
            def user = UserMaster.get(userId)
            def fd = Deposit.get(params.deposit)

            // interest and tax posting
            processFdManualRollover(fd, user)
            
            Date endDate = new SimpleDateFormat("MM/dd/yyyy").parse(params.endDate)
            if(fd.currentRollover.interestPaymentMode.id==1){
                def rolloverInstance = new Rollover(
                    principalAmt:fd.ledgerBalAmt,
                    type:fd.currentRollover.type,deposit:fd,
                    ctd:fd.currentRollover.ctd,
                    startDate:Branch.get(1).runDate,
                    endDate:endDate,
                    status:RolloverStatus.get(1),
                    interestPaymentMode:fd.currentRollover.interestPaymentMode,
                    fundedDeposit:fd.currentRollover.fundedDeposit,
                    postMaturityInterestRate:fd.currentRollover.postMaturityInterestRate,
                    normalInterestAmt:fd.grossRolloverInterestAmt, preTermInterestAmt:0, 
                    taxAmt1:fd.taxWithheld, taxAmt2:0)    
                    fd.currentRollover.endDate = fd.branch.runDate
                    fd.currentRollover.status = RolloverStatus.get(2)
                    fd.currentRollover.save(failOnError:true)
                    fd.save(flush:true)
                    fd.addToRollovers(rolloverInstance).save(flush: true)
                    fd.currentRollover = rolloverInstance 
                    fd.save(flush:true) 
                    fd.currentRollover.taxAmt1 = fd.taxWithheld
                    fd.save(flush:true) 
            }
            if(fd.currentRollover.interestPaymentMode.id==2){
                def nextDate = getNextDate(Branch.get(1).runDate,Branch.get(1).runDate,fd.maturityDate)
                def rolloverInstance = new Rollover(
                    principalAmt:fd.ledgerBalAmt,
                    type:fd.currentRollover.type,deposit:fd,
                    ctd:fd.currentRollover.ctd,
                    startDate:Branch.get(1).runDate,
                    endDate:( (fd.depositInterestScheme.fdMonthlyTransfer == true) ? nextDate : endDate ) ,
                    status:RolloverStatus.get(1),
                    interestPaymentMode:fd.currentRollover.interestPaymentMode,
                    fundedDeposit:fd.currentRollover.fundedDeposit,
                    postMaturityInterestRate:fd.currentRollover.postMaturityInterestRate,
                    normalInterestAmt:0, preTermInterestAmt:0, 
                    taxAmt1:0, taxAmt2:0
                )                        
                
                fd.addToRollovers(rolloverInstance).save(flush: true)
                fd.currentRollover = rolloverInstance                
                fd.acrintAmt = 0.00
                fd.save(flush:true)                
            }
            if(fd.currentRollover.type.id==3){
                def rolloverInstance = new Rollover(
                    principalAmt:fd.ledgerBalAmt,
                    type:fd.currentRollover.type,deposit:fd,
                    ctd:fd.currentRollover.ctd,
                    startDate:Branch.get(1).runDate,
                    endDate:endDate,
                    status:RolloverStatus.get(1),
                    interestPaymentMode:fd.currentRollover.interestPaymentMode,
                    fundedDeposit:fd.currentRollover.fundedDeposit,
                    postMaturityInterestRate:fd.currentRollover.postMaturityInterestRate,
                    normalInterestAmt:0, preTermInterestAmt:0, 
                    taxAmt1:0, taxAmt2:0
                )   
                fd.addToRollovers(rolloverInstance).save(flush: true)
                fd.currentRollover = rolloverInstance                                      
                fd.acrintAmt = 0.00
                fd.interestBalAmt = 0.00
                fd.acrintDate = Branch.get(1).runDate
                fd.save(flush:true)                 
            }
            /*
            def rolloverInstance = new Rollover(
                principalAmt:fd.ledgerBalAmt,
                type:fd.currentRollover.type,deposit:fd,
                ctd:fd.currentRollover.ctd,
                startDate:Branch.get(1).runDate,
                endDate:endDate,
                status:RolloverStatus.get(1),
                interestPaymentMode:params.interestPaymentMode,
                fundedDeposit:fd.currentRollover.fundedDeposit,
                postMaturityInterestRate:fd.currentRollover.postMaturityInterestRate)
            fd.addToRollovers(rolloverInstance).save(flush: true)
            fd.currentRollover = rolloverInstance  
            fd.maturityDate = endDate
            fd.lastTxnDate = Branch.get(1).runDate
            fd.save(flush:true) 
            */
           
            //result.rolloverInstance = rolloverInstance
            result.rolloverInstance = fd.currentRollover
            AuditLogService.insert('080', 'DEP01800','saveManualRollover ' + fd.currentRollover.id, 'Rollover', null, null, null, fd.currentRollover.id)
            return result
        }
    }
    
    def processFdManualRollover(Deposit fd, UserMaster user) {
        def intTxn = Institution.findByParamCode("DEP.40100").paramValue.toInteger()
        def taxTxn = Institution.findByParamCode("DEP.40110").paramValue.toInteger()  
        
        if(fd.currentRollover.type.id==1){
            //update status
            fd.currentRollover.endDate = fd.branch.runDate
            fd.currentRollover.status = RolloverStatus.get(2)
            fd.currentRollover.save(failOnError:true)            
            fd.acrintAmt = fd.currentRollover.normalInterestAmt
            fd.acrintDate = fd.branch.runDate
            fd.taxWithheld = fd.currentRollover.taxAmt1
            fd.save(flush:true)
        }  
        if(fd.currentRollover.type.id==2){
            //send principal
            if(fd.currentRollover.interestPaymentMode.id==1){
                //withdrawal from amount
                        
                def tax = 0
                if (fd.grossRolloverInterestAmt) {
                    fd.grossRolloverInterestAmt += fd.currentRollover.normalInterestAmt
                } else {
                    fd.grossRolloverInterestAmt = fd.currentRollover.normalInterestAmt  
                }
                if (fd.netRolloverInterestAmt) {
                    fd.netRolloverInterestAmt += (fd.currentRollover.normalInterestAmt - fd.currentRollover.taxAmt1)  
                } else {
                    fd.netRolloverInterestAmt = (fd.currentRollover.normalInterestAmt - fd.currentRollover.taxAmt1)
                }
                //fd.currentRollover.normalInterestAmt = fd.acrintAmt
               // manual rollover, add new gross rollover interest amount to acrint 
               fd.currentRollover.endDate = fd.branch.runDate
               fd.currentRollover.status = RolloverStatus.get(2)
               fd.currentRollover.save(failOnError:true)  
               fd.save(flush:true)
            }
            if(fd.currentRollover.interestPaymentMode.id==2){
                // principal rollover with interest to funded account 
                def tax = 0
                fd.grossRolloverInterestAmt = 0.00
                fd.netRolloverInterestAmt = 0.00
                //fd.currentRollover.normalInterestAmt = fd.acrintAmt

                def intTxnTmp = TxnTemplate.get(intTxn)
                def taxTxnTmp = TxnTemplate.get(taxTxn)
                //credit interest
                def txnFile1 = new TxnFile(txnParticulars:"Interest Credit",currency:fd.product.currency,txnType:intTxnTmp.txnType,status:ConfigItemStatus.read(2),
                    txnTimestamp:new Date().toTimestamp(),user:user,branch:fd.branch,txnCode:intTxnTmp.code,acctNo:fd.acctNo,
                    txnAmt:fd.currentRollover.normalInterestAmt,txnRef:"int",depAcct:fd,txnDate:fd.branch.runDate, txnTemplate:intTxnTmp,
                    txnDescription:intTxnTmp.description)
                def acctLedger1 = new TxnDepositAcctLedger(txnType:intTxnTmp.txnType,user:user,branch:fd.branch,currency:fd.product.currency,
                    status:fd.status,txnDate:fd.branch.runDate,acct:fd,acctNo:fd.acctNo,creditAmt:fd.currentRollover.normalInterestAmt,
                    bal:fd.ledgerBalAmt+fd.currentRollover.normalInterestAmt,txnRef:"FD Rollover Int "+fd.currentRollover.id,debitAmt:fd.currentRollover.normalInterestAmt,
                    txnFile:txnFile1, txnCode:txnFile1.txnCode)
                //debit tax
                def txnFile2 = new TxnFile(txnParticulars:"Tax debit",currency:fd.product.currency,txnType:taxTxnTmp.txnType,status:ConfigItemStatus.read(2),
                    txnTimestamp:new Date().toTimestamp(),user:user,branch:fd.branch,txnCode:taxTxnTmp.code,acctNo:fd.acctNo,
                    txnAmt:fd.currentRollover.taxAmt1,txnRef:"tax",depAcct:fd,txnDate:fd.branch.runDate, txnTemplate:taxTxnTmp,
                    txnDescription:taxTxnTmp.description)                        
                def acctLedger2 = new TxnDepositAcctLedger(txnType:taxTxnTmp.txnType,user:user,branch:fd.branch,currency:fd.product.currency,
                    status:fd.status,txnDate:fd.branch.runDate,acct:fd,acctNo:fd.acctNo,debitAmt:fd.currentRollover.taxAmt1,
                    bal:fd.ledgerBalAmt+fd.currentRollover.normalInterestAmt-fd.currentRollover.taxAmt1,
                    txnRef:"FD Rollover Tax "+fd.currentRollover.id, creditAmt:fd.currentRollover.taxAmt1,
                    txnFile:txnFile2, txnCode:txnFile2.txnCode)
                txnFile1.save(failOnError:true,flush:true,validate:false)
                acctLedger1.save(failOnError:true,flush:true,validate:false)
                txnFile2.save(failOnError:true,flush:true,validate:false)
                acctLedger2.save(failOnError:true,flush:true,validate:false)

                def ft = TxnTemplate.get(Institution.findByParamCode('DEP.40121').paramValue.toInteger())    
                def txnFile4 = new TxnFile(txnParticulars:"Int Tr debit",currency:fd.product.currency,txnType:ft.txnType,
                    status:ConfigItemStatus.read(2),
                    txnTimestamp:new Date().toTimestamp(),user:user,branch:fd.branch,txnCode:ft.code,acctNo:fd.acctNo,
                    txnAmt:fd.currentRollover.normalInterestAmt - fd.currentRollover.taxAmt1,txnRef:"Transfer Int ",
                    depAcct:fd,txnDate:fd.branch.runDate, txnTemplate:ft,
                    txnDescription:taxTxnTmp.description)                        
                def acctLedger4 = new TxnDepositAcctLedger(txnType:ft.txnType,user:user,branch:fd.branch,currency:fd.product.currency,
                    status:fd.status,txnDate:fd.branch.runDate,acct:fd,acctNo:fd.acctNo,
                    debitAmt:fd.currentRollover.normalInterestAmt - fd.currentRollover.taxAmt1,
                    bal:fd.ledgerBalAmt,txnRef:"Int Tr debit", creditAmt:0,
                    txnFile:txnFile4, txnCode:txnFile4.txnCode)  
                
                txnFile4.save(failOnError:true,flush:true,validate:false)
                acctLedger4.save(failOnError:true,flush:true,validate:false)  
                
                glTransactionService.saveTxnBreakdown(txnFile1.id)
                glTransactionService.saveTxnBreakdown(txnFile2.id)    
                glTransactionService.saveTxnBreakdown(txnFile4.id) 
                //credit to account
                fd.currentRollover.fundedDeposit.ledgerBalAmt+=(fd.currentRollover.normalInterestAmt-fd.currentRollover.taxAmt1)
                fd.currentRollover.fundedDeposit.availableBalAmt+=(fd.currentRollover.normalInterestAmt-fd.currentRollover.taxAmt1)
                //fd.currentRollover.fundedDeposit.interestBalAmt+=amount
                def txnFile3 = new TxnFile(txnParticulars:"Interest Credit from FD",currency:fd.product.currency,txnType:intTxnTmp.txnType,
                    status:ConfigItemStatus.read(2),txnTimestamp:new Date().toTimestamp(),user:user,branch:fd.currentRollover.fundedDeposit.branch,
                    txnCode:intTxnTmp.code, acctNo:fd.currentRollover.fundedDeposit.acctNo,
                    txnAmt:fd.currentRollover.normalInterestAmt-fd.currentRollover.taxAmt1, txnRef:fd.acctNo,
                    depAcct:fd.currentRollover.fundedDeposit,txnDate:fd.branch.runDate, 
                    txnTemplate:intTxnTmp, txnDescription:"Interest Credit from FD")
                def acctLedger3 = new TxnDepositAcctLedger(txnType:intTxnTmp.txnType,user:user,branch:fd.currentRollover.fundedDeposit.branch,
                    currency:fd.product.currency, status:fd.currentRollover.fundedDeposit.status,txnDate:fd.branch.runDate,
                    acct:fd.currentRollover.fundedDeposit, acctNo:fd.currentRollover.fundedDeposit.acctNo, 
                    creditAmt:fd.currentRollover.normalInterestAmt-fd.currentRollover.taxAmt1,
                    bal:fd.currentRollover.fundedDeposit.ledgerBalAmt,
                    txnRef:"int from FD "+fd.currentRollover.id, txnFile:txnFile3, txnCode:txnFile3.txnCode)
             
                txnFile3.save(failOnError:true,flush:true,validate:false)
                acctLedger3.save(failOnError:true,flush:true,validate:false)
                glTransactionService.saveTxnBreakdown(txnFile3.id)  
                                    
                fd.currentRollover.fundedDeposit.save(failOnError:true,flush:true,validate:false)                       
                fd.currentRollover.status = RolloverStatus.get(2)     
                fd.currentRollover.endDate = fd.branch.runDate 
                fd.currentRollover.fundedDeposit.save(flush:true, failOnError:true)
                fd.currentRollover.save(failOnError:true, flush:true)
                fd.save(flush:true, failOnError:true)
                                                
                //net
                fd.acrintAmt = 0.00
                fd.interestBalAmt = 0.00
            }
            fd.acrintDate = fd.branch.runDate
            fd.save(flush:true)  
        }
        if(fd.currentRollover.type.id==3){
            //P+I rollover
            if(fd.currentRollover.interestPaymentMode.id==3){
                def tax = fd.currentRollover.taxAmt1
                def oldBal = fd.ledgerBalAmt
                fd.grossRolloverInterestAmt = fd.currentRollover.normalInterestAmt
                fd.netRolloverInterestAmt = fd.currentRollover.normalInterestAmt - tax
                //fd.currentRollover.normalInterestAmt = fd.acrintAmt
                fd.ledgerBalAmt += (fd.currentRollover.normalInterestAmt - fd.currentRollover.taxAmt1)
                fd.availableBalAmt += (fd.currentRollover.normalInterestAmt - fd.currentRollover.taxAmt1)

                def intTxnTmp = TxnTemplate.get(intTxn)
                def taxTxnTmp = TxnTemplate.get(taxTxn)
                //credit interest
                def txnFile1 = new TxnFile(txnParticulars:"Interest Credit",currency:fd.product.currency,txnType:intTxnTmp.txnType,status:ConfigItemStatus.read(2),
                    txnTimestamp:new Date().toTimestamp(),user:user,branch:fd.branch,txnCode:intTxnTmp.code,acctNo:fd.acctNo,
                    txnAmt:fd.grossRolloverInterestAmt,txnRef:"FD Rollover Interest "+fd.currentRollover.id,
                    depAcct:fd,txnDate:fd.branch.runDate, txnTemplate:intTxnTmp, txnDescription:intTxnTmp.description)
                def acctLedger1 = new TxnDepositAcctLedger(txnType:intTxnTmp.txnType,user:user,branch:fd.branch,currency:fd.product.currency,
                    status:fd.status,txnDate:fd.branch.runDate,acct:fd,acctNo:fd.acctNo,creditAmt:fd.currentRollover.normalInterestAmt,
                    bal:oldBal+fd.currentRollover.normalInterestAmt,txnRef:"FD Rollover Interest "+fd.currentRollover.id,
                    txnFile:txnFile1, txnCode:txnFile1.txnCode)
                //debit tax
                def txnFile2 = new TxnFile(txnParticulars:"Tax debit",currency:fd.product.currency,txnType:taxTxnTmp.txnType,status:ConfigItemStatus.read(2),
                    txnTimestamp:new Date().toTimestamp(),user:user,branch:fd.branch,txnCode:taxTxnTmp.code,acctNo:fd.acctNo,
                    txnAmt:fd.currentRollover.taxAmt1,txnRef:"tax",depAcct:fd,txnDate:fd.branch.runDate, txnTemplate:taxTxnTmp,
                    txnDescription:taxTxnTmp.description)                        
                def acctLedger2 = new TxnDepositAcctLedger(txnType:taxTxnTmp.txnType,user:user,branch:fd.branch,currency:fd.product.currency,
                    status:fd.status,txnDate:fd.branch.runDate,acct:fd,acctNo:fd.acctNo,debitAmt:fd.currentRollover.taxAmt1,
                    bal:oldBal+(fd.currentRollover.normalInterestAmt-fd.currentRollover.taxAmt1),
                    txnRef:"FD Rollover Tax "+fd.currentRollover.id, txnFile:txnFile2, txnCode:txnFile2.txnCode)
                txnFile1.save(failOnError:true,flush:true,validate:false)
                acctLedger1.save(failOnError:true,flush:true,validate:false)
                txnFile2.save(failOnError:true,flush:true,validate:false)
                acctLedger2.save(failOnError:true,flush:true,validate:false)
                        
                glTransactionService.saveTxnBreakdown(txnFile1.id)
                glTransactionService.saveTxnBreakdown(txnFile2.id)                                                  
                        
                fd.currentRollover.status = RolloverStatus.get(2)
                fd.currentRollover.endDate = fd.branch.runDate 
                fd.currentRollover.save(failOnError:true, flush:true)
                        
                fd.acrintAmt = 0.00
                fd.interestBalAmt = 0.00
                fd.acrintDate = fd.branch.runDate
                fd.save(flush:true)   
            }           
        }
        println 'FINISHED def processFdManualRollover(Deposit fd, UserMaster user)'
    }
    
    /*****Passbook****/
    def savePassbook(params){
        IssuePassbook.withTransaction { status ->
            println "pumasok sa save passbook transaction" + params
          
            def result = [:]
            def fail = { Map m ->
                status.setRollbackOnly()
                if(result.issuePassbookInstance && m.field)
                    result.issuePassbookInstance.errors.rejectValue(m.field, m.code)
                result.error = [ code: m.code, args: ["IssuePassbook", params.id] ]
                return result
            }
            
            // retrieve all passbook assign to id, and set properties to status_id value 2 to cancelled otherwise
            // status_id is preserved
            def prevPassbookInstance = IssuePassbook.findAllByDeposit(Deposit.get(params.deposit.id.toInteger()))
            def deposit = Deposit.get(params.deposit.id.toInteger())
            def pbk = Passbook.findByPassbookNo(params.passbookNo)
            // check types
            if (deposit.type.id == 1 && pbk.docInventory.type.id != 2) {
                result.error = [ code: 'invalid type', args: ["IssuePassbook", params.id] ]
                return result    
            }
            if (deposit.type.id == 2 && pbk.docInventory.type.id != 4) {
                result.error = [ code: 'invalid type', args: ["IssuePassbook", params.id] ]
                return result    
            }            
            if (deposit.type.id == 3 && pbk.docInventory.type.id != 5) {
                result.error = [ code: 'invalid type', args: ["IssuePassbook", params.id] ]
                return result    
            }            
            // check branch
            if (pbk.docInventory.branch != deposit.branch) {
                result.error = [ code: 'invalid branch', args: ["IssuePassbook", params.id] ]
                return result                
            }
            // change any passbook with status 2 (issued) to cancelled,
            // all else ignored to keep their status
            def FailedExit = 0
            prevPassbookInstance.each{ psbookInstance ->
               // println psbookInstance.passbook.status.id
                //if(psbookInstance.passbook.docInventory.status.id == 4)
               // {
                //     psbookInstance.passbook.status = PassbookStatus.read(3)
                //     psbookInstance.save flush:true
                //     FailedExit = 1
               // } else {
                    if(psbookInstance.passbook.status.id == 2)
                    {
                        psbookInstance.passbook.status = PassbookStatus.read(3)
                        psbookInstance.save flush:true
                    }
              //  }
                
            }
          //  if(FailedExit == 1)
           // {
           //     return fail(code:"default.save.failure") 
          //  }
           // println "prev passbook"
           // println prevPassbookInstance
            
            result.issuePassbookInstance = new IssuePassbook()
            
            result.issuePassbookInstance.properties = params
            result.issuePassbookInstance.issuedBy = UserMaster.get(params.UserID)
            
            if(!result.issuePassbookInstance.validate()){
                return fail(code:"default.save.failure")
            }
            // result.issuePassbookInstance.passbook = Passbook.get(result.issuePassbookInstance.passbookNo) // .find{result.issuePassbookInstance.passbookNo}
            result.issuePassbookInstance.save(flush:true,failOnError:true)
            def pb = Passbook.findByPassbookNo(result.issuePassbookInstance.passbookNo)
            pb.status = PassbookStatus.read(2)
            pb.issuePassbook = result.issuePassbookInstance
            pb.save(flush:true, failOnError:true)
            result.issuePassbookInstance.passbook = pb
            
//            if(result.issuePassbookInstance.passbook.docInventory.usageCount == null){
//                result.issuePassbookInstance.passbook.docInventory.usageCount = 0
//            }

            
            result.issuePassbookInstance.passbook.docInventory.usageCount+=1
            result.issuePassbookInstance.passbook.docInventory.save(failOnError:true)
            
            deposit.passBookNo = pb.passbookNo
            deposit.save(flush:true)
            
            if( result.issuePassbookInstance.passbook.save(failOnError:true)&&  result.issuePassbookInstance.passbook.docInventory.save(failOnError:true)){
                println "lumabas sa save passbook transaction"
                AuditLogService.insert('080', 'DEP00601','savePassbook ' + result.issuePassbookInstance.id, 'IssuePassbook', null, null, null, result.issuePassbookInstance.id)
                return result
            
            }else{
                return fail(code:"Save Error")
            }
        }
    }
    def updatePassbook(params){
        println "update passbook service call"
        println params
        
        
        IssuePassbook.withTransaction { status ->
            
            def result = [:]
            def fail = { Map m ->
                status.setRollbackOnly()
                if(result.issuePassbookInstance && m.field)
                    result.issuePassbookInstance.errors.rejectValue(m.field, m.code)
                result.error = [ code: m.code, args: ["IssuePassbook", params.id] ]
                return result
            }
            
            
            
            result.issuePassbookInstance = IssuePassbook.get(params.id)
            if(!result.issuePassbookInstance){
                return fail(code:"default.not.found")
            }
            // Optimistic locking check.
            if(params.version) {
                if(result.issuePassbookInstance.version > params.version.toLong())
                    return fail(field:"version", code:"default.optimistic.locking.failure")
            }
//            if(!includeList){
                result.issuePassbookInstance.properties=params
                println "OUTPUT :" + result.issuePassbookInstance
//            }
//            else{
//                result.issuePassbookInstance.properties[includeList]=params
//                println "OUTPUT TWO :" + result.issuePassbookInstance
//                println "OUTPUT params :" + params
//            }
//            if(!includeList){
                if(!result.issuePassbookInstance.validate()){    
                    return fail(code:"default.update.failure")
                }
//            }else{
//                if(!result.issuePassbookInstance.validate([includeList])){    
//                    return fail(code:"default.update.failure")
//                }
//            }

            // ito ung magremove nung status na issued sa old id
            result.issuePassbookInstance.passbook = Passbook.get(result.issuePassbookInstance.passbook.passbookNo)
            result.issuePassbookInstance.passbook.status = PassbookStatus.read(1)
            result.issuePassbookInstance.passbook.issuePassbook = null
            result.issuePassbookInstance.passbook.save(failOnError:true)
            
            result.issuePassbookInstance.passbook = Passbook.get(result.issuePassbookInstance.passbookNo) // .find{result.issuePassbookInstance.passbookNo}
            //result.issuePassbookInstance.save()  
            result.issuePassbookInstance.save(flush:true,failOnError:true)
            result.issuePassbookInstance.passbook.status = PassbookStatus.read(2)
            result.issuePassbookInstance.passbook.issuePassbook = result.issuePassbookInstance
            result.issuePassbookInstance.passbook.save(failOnError:true)
            
            //result.issuePassbookInstance.save()  
            AuditLogService.insert('080', 'DEP00602','updatePassbook ' + result.issuePassbookInstance.id, 'IssuePassbook', null, null, null, result.issuePassbookInstance.id)
            // Success.
            return result
        } //end withTransaction
    }
    /*****Chequebook****/
    
    def saveChequebook(params){
        Chequebook.withTransaction { status ->
            def result = [:]
            def fail = { Map m ->
                status.setRollbackOnly()
                if(result.chequebookInstance && m.field)
                    result.chequebookInstance.errors.rejectValue(m.field, m.code)
                result.error = [ code: m.code, args: ["Chequebook", params.id] ]
                return result
            }
            result.chequebookInstance = new Chequebook()
            result.chequebookInstance.properties = params
            if(!result.chequebookInstance.validate()){
                return fail(code:"default.save.failure")
            }
            if(result.chequebookInstance.chequesUsed != 0 ) {
                result.error = [ code: 'Checbook Used', args: ["Chequebook", params.id] ]
                return result                
            }                      
            result.chequebookInstance.save(flush:true,failOnError:true)
            for(def i =result.chequebookInstance.seriesStart;i<=result.chequebookInstance.seriesEnd;i++){
                def chequeInstance = Cheque.find{chequeNo==i.toString()}
                chequeInstance.chequebook =  result.chequebookInstance
                chequeInstance.status = CheckStatus.read(2)
                chequeInstance.save()
            }
            AuditLogService.insert('080', 'DEP01201','saveChequebook ' + result.chequebookInstance.id, 'Chequebook', null, null, null, result.chequebookInstance.id)
            return result
        
        }
    }
    def updateChequebook(params){
        Chequebook.withTransaction { status ->
            def result = [:]
            def fail = { Map m ->
                status.setRollbackOnly()
                if(result.chequebookInstance && m.field && jList.cheques_used == 0)
                    result.chequebookInstance.errors.rejectValue(m.field, m.code)
                result.error = [ code: m.code, args: ["Chequebook", params.id] ]
                return result
            }
          
            result.chequebookInstance = Chequebook.get(params.id)
            if(result.chequebookInstance.chequesUsed != 0 ) {
                result.error = [ code: 'Checbook Used', args: ["Chequebook", params.id] ]
                return result                
            }              
            //change status of old check to unused
            for(int i =result.chequebookInstance.seriesStart;i<=result.chequebookInstance.seriesEnd;i++){
                def chequeInstance = Cheque.find{chequeNo==i.toString()}
                chequeInstance.chequebook =  null
                chequeInstance.status = CheckStatus.read(1)
                chequeInstance.save()
            }
            
            if(!result.chequebookInstance){
                return fail(code:"default.not.found")
            }
            
            // Optimistic locking check.
            if(params.version) {
                if(result.chequebookInstance.version > params.version.toLong())
                    return fail(field:"version", code:"default.optimistic.locking.failure")
            }
//            if(!includeList && !includeList1 && !includeList2){
                result.chequebookInstance.properties=params
//            }
//            else{
//                println "2" + includeList
//                result.chequebookInstance.properties[includeList]=params
//                result.chequebookInstance.properties[includeList1]=params
//                result.chequebookInstance.properties[includeList2]=params
//                println "TEST : " + result.chequebookInstance.properties[includeList]
//                println "TEST 1: " + result.chequebookInstance.properties[includeList1]
//                println "TEST 2: " + result.chequebookInstance.properties[includeList2]
//            }
//            if(!includeList){
                if(!result.chequebookInstance.validate()){    
                    return fail(code:"default.update.failure")
                }
//            }else{
//                if(!result.chequebookInstance.validate([includeList])){    
//                    return fail(code:"default.update.failure")
//                }
//            }

            
            result.chequebookInstance.save()  
            //save new status of used checks
            for(int i =result.chequebookInstance.seriesStart;i<=result.chequebookInstance.seriesEnd;i++){
                def chequeInstance = Cheque.find{chequeNo==i.toString()}
                chequeInstance.chequebook =  result.chequebookInstance
                chequeInstance.status = CheckStatus.read(2)
                chequeInstance.save()
            }
            
            // Success.
            AuditLogService.insert('080', 'DEP01202','updateChequebook ' + result.chequebookInstance.id, 'Chequebook', null, null, null, result.chequebookInstance.id)
            return result
        } //end withTransaction
    }
    def cancelChequebook(params) {
        Chequebook.withTransaction { status ->
            def result = [:]
            def fail = { Map m ->
                status.setRollbackOnly()
                if(result.chequebookInstance && m.field && jList.cheques_used == 0)
                    result.chequebookInstance.errors.rejectValue(m.field, m.code)
                result.error = [ code: m.code, args: ["Chequebook", params.id] ]
                println "DS : error 1 "+result.error
                return result
            }
            
            result.chequebookInstance = Chequebook.get(params.id)
            
            if (result.chequebookInstance.chequesUsed != 0) {
                result.error = [ code: 'Series Used', args: ["Chequebook", params.id] ]
                println "DS : error 2 "+result.error
                return result                
            }

            for(int i = result.chequebookInstance.seriesStart;i<=result.chequebookInstance.seriesEnd;i++){
                println i 
                def chequeInstance = Cheque.find{chequeNo==i}
                if (chequeInstance.status.id > 2) {
                    result.error = [ code: i.toString() + '-Check used', args: ["Chequebook", params.id] ]
                    println "DS : error 3 "+result.error
                    return result
                }
            }
            
            if(!result.chequebookInstance){
                return fail(code:"default.not.found")
            }
            
            // Optimistic locking check.
            if(params.version) {
                if(result.chequebookInstance.version > params.version.toLong())
                    return fail(field:"version", code:"default.optimistic.locking.failure")
            }
//            if(!includeList && !includeList1 && !includeList2){
                result.chequebookInstance.properties=params
//            }
//            else{
//                println "2" + includeList
//                result.chequebookInstance.properties[includeList]=params
//                result.chequebookInstance.properties[includeList1]=params
//                result.chequebookInstance.properties[includeList2]=params
//                println "TEST : " + result.chequebookInstance.properties[includeList]
//                println "TEST 1: " + result.chequebookInstance.properties[includeList1]
//                println "TEST 2: " + result.chequebookInstance.properties[includeList2]
//            }
//            if(!includeList){
                if(!result.chequebookInstance.validate()){    
                    return fail(code:"default.update.failure")
                }
//            }else{
//                if(!result.chequebookInstance.validate([includeList])){    
//                    return fail(code:"default.update.failure")
//                }
//            }

            
            // result.chequebookInstance.save()  
            // save new status of used checks
            for(int i =result.chequebookInstance.seriesStart;i<=result.chequebookInstance.seriesEnd;i++){
                println 'delete'
                println i 
                def chequeInstance = Cheque.find{chequeNo==i}
                chequeInstance.chequebook =  null
                chequeInstance.status = CheckStatus.read(1)
                chequeInstance.save()
            }
            AuditLogService.insert('080', 'DEP01202','cancelChequebook ' + result.chequebookInstance.id, 'Chequebook', null, null, null, null)
            result.chequebookInstance.delete(flush:true)
            // Success.
            return result
        } //end withTransaction
        
    }
    def getNextDate(Date prevDueDate, Date baseDate, Date matDate){
        def result        
        if (prevDueDate == matDate){
            result = prevDueDate.plus(30)
        } else {
            result = prevDueDate.plus(30)
            if (result > matDate) {
                result = matDate
            }
        }
        return result
    }
    /*
    def getNextDate(Date prevDueDate, Date baseDate, Date matDate){
        
        def calendar = new GregorianCalendar()
        def next = new GregorianCalendar()
        def nextcal = new GregorianCalendar()
        int max = 0
        int feb = 0
        def reSult
        
        calendar.setTime(prevDueDate)
        next.setTime(baseDate)
        nextcal.setTime(prevDueDate)
        nextcal.add(Calendar.MONTH, 1)
        max = nextcal.getActualMaximum(Calendar.DAY_OF_MONTH)        
        
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
                
        if(matDate != null){  
           if (matDate < calendar.getTime()){
               reSult = matDate
           }
           else{
               reSult = calendar.getTime()
           }
        }
        else{
            reSult = calendar.getTime()
        }
        
        return reSult
    }
    */
    private buildAcctNo(Deposit depositInstance){
        int[] piArray = [1,4,1,5,9,2,6,5,3,5,8]
        //int serialCount = Deposit.countByBranchAndProduct(depositInstance.branch,depositInstance.product)
        String acctNo
        String branchCode = depositInstance.branch.code
        String productCode = depositInstance.product.code
        def result = Deposit.executeQuery("select max(SUBSTRING(acctNo, 9,5))from Deposit where SUBSTRING(acctNo, 1,7) = CONCAT(:branch,'-',:prod))", [branch: String.format("%03d", depositInstance?.branch?.code), prod: String.format("%03d", depositInstance?.product?.code)])
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

        branchCode= String.format("%03d", depositInstance.branch.code)
        productCode = String.format("%03d", depositInstance.product.code)
        String serialCode = String.format("%05d", serialNum);
        
        acctNo = branchCode+productCode+serialCode
        
        def piTotal = 0
        for (int i = acctNo.length()-1; i >= 0; i--){
            int c =  Character.getNumericValue(acctNo.charAt(i))
            println c
            piTotal += c*piArray[i]    
        }
        String checkBit = (piTotal%10).toString()
        depositInstance.acctNo = branchCode+"-"+productCode +"-"+serialCode+"-"+checkBit
        depositInstance.dateOpened = Branch?.get(1).runDate
   
        
        depositInstance.save(failOnError:true)
    }
//    def memoDebit(Deposit depositInstance,Double Amount, TxnFile tf){
//        
//        tc = new TxnDepositAcctLedger()
//        
//        tf.acctNo = depositInstance.acctNo
//        tf.depAcct = depositInstance
//        tf.currency = Currency.get(depositInstance.product.currencyId)
//        tf.user = UserMaster.get(session.user_id)
//        tf.branch = branch
//        tf.txnAmt = totWdlAmt
//        tf.txnCode = txnTemp.code
//        tf.txnDate = branch.runDate
//        tf.txnTimestamp = new Date().toTimestamp()
//        tf.txnDescription = txnTemp.codeDescription
//        tf.txnRef = params.txnRef
//        tf.status = ConfigItemStatus.get(2)
//        tf.txnType = txnTemp.txnType
//        tf.save(flush:true,failOnError:true)
//            
//        tc.acct = depositInstance
//        tc.txnType = tf.txnTemplate.txnType
//        tc.acctNo = depositInstance.acctNo
//        tc.bal = depositInstance.ledgerBalAmt
//        tc.branch = branch
//        tc.txnType = tf.txnTemplate.txnType
//        tc.txnRef = params.txnRef
//        tc.debitAmt = intWdlAmt
//        tc.currency = Currency.get(depositInstance.product.currencyId)
//        tc.txnDate = branch.runDate
//        tc.user = UserMaster.get(session.user_id)
//        tc.status = DepositStatus.get(2)
//        tc.txnFile = tf
//        tc.save(flush:true,failOnError:true)
//    }
}
