package icbs.gl

import accounting.bankpayables.ApTxnFile
import grails.transaction.Transactional
import icbs.gl.GlAccount
import icbs.lov.GlAcctType
import icbs.gl.GlBatch
import icbs.deposit.Deposit
import icbs.deposit.Cheque
import icbs.deposit.StopPaymentOrder
import icbs.lov.DepositStatus
import icbs.loans.Loan
import icbs.loans.LoanLedger
import icbs.loans.LoanReClassHist
import icbs.loans.LoanBranchTransfer
import icbs.gl.GlBatchHdr
import icbs.lov.GlBatchHdrStatus
import icbs.admin.Currency
import icbs.admin.Branch
import icbs.admin.UserMaster
import icbs.admin.Institution
import icbs.atm.AtmTxn
import icbs.atm.AtmTerminalMapping
import icbs.tellering.TxnBreakdown
import icbs.tellering.TxnLoanPaymentDetails
import icbs.tellering.TxnFile
import icbs.tellering.TxnDepositAcctLedger
import icbs.tellering.TxnDepositFundTransfer
import icbs.admin.TxnTemplate
import icbs.gl.CfgAcctGlTemplateDet
import icbs.lov.ConfigItemStatus
import icbs.lov.LoanAcctStatus
import icbs.lov.TxnType
import icbs.lov.CheckStatus
import java.text.DateFormat;
import java.text.SimpleDateFormat;

@Transactional
class GlTransactionService {
    def auditLogService
    
    // post entries  to GL for failed lines
    def postFailedBatch(Long id, Double amount, String batchID, UserMaster user, String errMsg) {
        def glUpdateList = GlBatch.get(id)
	//for (glUpdate in glUpdateList)
	def glBatchHdr = GlBatchHdr.findByBatchId(glUpdateList.batchId)
	//def glAccount = GlAccount.read(glCodeId)
        def fy = glBatchHdr.txnDate.format('yyyy')
        def ccy = glBatchHdr.batchCurrency
        def glCode = GlAccount.findByBranchAndCodeAndFinancialYearAndCurrency(glBatchHdr.branch, Institution.findByParamCode('GLS.60070').paramValue, fy, ccy)
        
        if (glUpdateList.batchType == '1' || glUpdateList.batchType == '3' || glUpdateList.batchType == '4') {
            glCode.debit += amount
            glCode.balance += amount
            glCode.debitToday += amount
            Double newBal = 0.00
            if (glCode.debit == glCode.credit) {
                glCode.debitBalance = 0.00
                glCode.creditBalance = 0.00
            } else {
                if (glCode.debit > glCode.credit) {
                    glCode.debitBalance = glCode.debit - glCode.credit
                    glCode.creditBalance = 0.00    
                    newBal = glCode.debitBalance
                } else {
                    glCode.creditBalance = glCode.credit - glCode.debit
                    glCode.debitBalance = 0.00     
                    newBal = glCode.creditBalance
                }
            }
            glCode.debit = glCode.debit.round(2)
            glCode.credit = glCode.credit.round(2)
            glCode.balance = glCode.balance.round(2)
            glCode.debitToday = glCode.debitToday.round(2)
            glCode.creditToday = glCode.creditToday.round(2)
            glCode.debitBalance = glCode.debitBalance.round(2)
            glCode.creditBalance = glCode.creditBalance.round(2)
            
            glCode.save(failOnError:true, flush:true)
        
            def glTxn = new GlTxnFile(branch:glBatchHdr.branch, glAccount:glCode, glAccountCode:glCode.code, debitAmt:amount,
                debitBal:glCode.debit, outstandingBal:glCode.balance, batchId:glUpdateList.batchId, glBatchHdrId:glBatchHdr,
                glBatchLine:glUpdateList.lineNo, batchParticulars:errMsg, txnDate:glBatchHdr.txnDate, 
                txnValueDate:glBatchHdr.valueDate, user:user)

            glTxn.save(flush:true,failOnError:true)
        }
        if (glUpdateList.batchType == '2' || glUpdateList.batchType == '5' || glUpdateList.batchType == '6') {
            glCode.credit += amount
            glCode.balance -= amount
            glCode.creditToday += amount
            Double newBal = 0
            if (glCode.debit == glCode.credit) {
                glCode.debitBalance = 0.00
                glCode.creditBalance = 0.00
            } else {
                if (glCode.debit > glCode.credit) {
                    glCode.debitBalance = glCode.debit - glCode.credit
                    glCode.creditBalance = 0.00  
                    newBal = glCode.debitBalance
                } else {
                    glCode.creditBalance = glCode.credit - glCode.debit
                    glCode.debitBalance = 0.00    
                    newBal = glCode.creditBalance
                }
            }
            glCode.debit = glCode.debit.round(2)
            glCode.credit = glCode.credit.round(2)
            glCode.balance = glCode.balance.round(2)
            glCode.debitToday = glCode.debitToday.round(2)
            glCode.creditToday = glCode.creditToday.round(2)
            glCode.debitBalance = glCode.debitBalance.round(2)
            glCode.creditBalance = glCode.creditBalance.round(2)            
            glCode.save(failOnError:true, flush:true)
        
            def glTxn = new GlTxnFile(branch:glBatchHdr.branch, glAccount:glCode, glAccountCode:glCode.code, creditAmt:amount,
            creditBal:glCode.credit, outstandingBal:glCode.balance, glBatchHdrId:glBatchHdr, glBatchLine:glUpdateList.lineNo,
            batchId:glUpdateList.batchId, batchParticulars:errMsg, txnDate:glBatchHdr.txnDate, txnValueDate:glBatchHdr.valueDate,
            user:user)

            glTxn.save(flush:true,failOnError:true)            
        }
    }
    /**
     * Debit the GL Account current balance
     */
    def debitGlAccount(String glCodeId, Double amount, Long id, UserMaster user ) {
       
        def glUpdateList = GlBatch.get(id)
	//for (glUpdate in glUpdateList)
	def glBatchHdr = GlBatchHdr.findByBatchId(glUpdateList.batchId)
	//def glAccount = GlAccount.read(glCodeId)
        def fy = glBatchHdr.txnDate.format('yyyy')
        def ccy = glBatchHdr.batchCurrency
        def glCode = GlAccount.findByBranchAndCodeAndFinancialYearAndCurrency(glBatchHdr.branch, glUpdateList.account, fy, ccy)
        
        if (!glCode) {
            glCode = GlAccount.findByBranchAndCodeAndFinancialYearAndCurrency(glBatchHdr.branch, Institution.findByParamCode('GLS.60070').paramValue, fy, ccy)
        }

        glCode.debit += amount
        glCode.balance += amount
        glCode.debitToday += amount
        Double newBal = 0.00
        if (glCode.debit == glCode.credit) {
            glCode.debitBalance = 0.00
            glCode.creditBalance = 0.00
        } else {
            if (glCode.debit > glCode.credit) {
                glCode.debitBalance = glCode.debit - glCode.credit
                glCode.creditBalance = 0.00    
                newBal = glCode.debitBalance
            } else {
                glCode.creditBalance = glCode.credit - glCode.debit
                glCode.debitBalance = 0.00     
                newBal = glCode.creditBalance
            }
        }
        glCode.debit = glCode.debit.round(2)
        glCode.credit = glCode.credit.round(2)
        glCode.balance = glCode.balance.round(2)
        glCode.debitToday = glCode.debitToday.round(2)
        glCode.creditToday = glCode.creditToday.round(2)
        glCode.debitBalance = glCode.debitBalance.round(2)
        glCode.creditBalance = glCode.creditBalance.round(2)        
        glCode.save(failOnError:true, flush:true)
        
        def glTxn = new GlTxnFile()
		
        glTxn.branch = glBatchHdr.branch
	glTxn.glAccount = glCode
	glTxn.glAccountCode = glUpdateList.account 
	glTxn.debitAmt = amount
	glTxn.debitBal = glCode.debit 
	glTxn.outstandingBal = glCode.balance
        
        /*
        if (glCode.debit == glCode.credit) {
            glTxn.outstandingBal = glCode.debit = 0.00
        } else {
            if (glCode.debit > glCode.credit) {
                glTxn.outstandingBal = glCode.debit - glCode.credit
            } else {
                glTxn.outstandingBal  = glCode.credit - glCode.debit
            }
        }
        */
       
        glTxn.batchId = glUpdateList.batchId
	glTxn.glBatchHdrId = glBatchHdr
	glTxn.glBatchLine = glUpdateList.lineNo 	
	glTxn.batchParticulars = glUpdateList.particulars
	glTxn.txnDate = glBatchHdr.branch.runDate
        glTxn.txnValueDate = glBatchHdr.valueDate
	glTxn.user = user
	glTxn.save(flush:true,failOnError:true)
        //def glAccountUpdate = GlAccount.findByCodeAndBranch(glUpdateList.account,glBatchHdr.branch)
        //glAccountUpdate.debit += amount
	//glAccountUpdate.debitBalance += amount
	//glAccountUpdate.debitToday += amount
	//glAccountUpdate.save(flush:true,failOnError:true)

        return
    }
    /**
     * Credit the GL Credit Balance
     */
    def creditGlAccount (String glCodeId, Double amount, Long id, UserMaster user ){
        
        def glUpdateList = GlBatch.get(id)
	//for (glUpdate in glUpdateList)
	def glBatchHdr = GlBatchHdr.findByBatchId(glUpdateList.batchId)        
        def fy = glBatchHdr.txnDate.format('yyyy')
        def ccy = glBatchHdr.batchCurrency
        def glCode = GlAccount.findByBranchAndCodeAndFinancialYearAndCurrency(glBatchHdr.branch, glUpdateList.account, fy, ccy)
        
        if (!glCode) {
            glCode = GlAccount.findByBranchAndCodeAndFinancialYearAndCurrency(glBatchHdr.branch, Institution.findByParamCode('GLS.60070').paramValue, fy, ccy)
        }
        
        glCode.credit += amount
        glCode.balance -= amount
        glCode.creditToday += amount
        Double newBal = 0
        if (glCode.debit == glCode.credit) {
            glCode.debitBalance = 0.00
            glCode.creditBalance = 0.00
        } else {
            if (glCode.debit > glCode.credit) {
                glCode.debitBalance = glCode.debit - glCode.credit
                glCode.creditBalance = 0.00  
                newBal = glCode.debitBalance
            } else {
                glCode.creditBalance = glCode.credit - glCode.debit
                glCode.debitBalance = 0.00    
                newBal = glCode.creditBalance
            }
        }
        glCode.debit = glCode.debit.round(2)
        glCode.credit = glCode.credit.round(2)
        glCode.balance = glCode.balance.round(2)
        glCode.debitToday = glCode.debitToday.round(2)
        glCode.creditToday = glCode.creditToday.round(2)
        glCode.debitBalance = glCode.debitBalance.round(2)
        glCode.creditBalance = glCode.creditBalance.round(2)        
        glCode.save(failOnError:true, flush:true)
        
        def glTxn = new GlTxnFile()
		
        glTxn.branch = glBatchHdr.branch
        glTxn.glAccount = glCode
	glTxn.glAccountCode = glCode.code
	glTxn.creditAmt = amount
	glTxn.creditBal = glCode.credit
        /*
        if (glCode.debit == glCode.credit) {
            glTxn.outstandingBal = glCode.debit = 0.00
        } else {
            if (glCode.debit > glCode.credit) {
                glTxn.outstandingBal = glCode.debit - glCode.credit
            } else {
                glTxn.outstandingBal  = glCode.credit - glCode.debit
            }
        }
        */
        glTxn.outstandingBal = glCode.balance
	glTxn.glBatchHdrId = glBatchHdr 
	glTxn.glBatchLine = glUpdateList.lineNo 	
	glTxn.batchId = glUpdateList.batchId
        glTxn.batchParticulars = glUpdateList.particulars
	glTxn.txnDate = glBatchHdr.branch.runDate
        glTxn.txnValueDate = glBatchHdr.valueDate
	glTxn.user = user
	glTxn.save(flush:true,failOnError:true)
	//glTxn.txnValueDate = glBatchHdr.valueDate
        //def glAccountUpdate = GlAccount.findByCodeAndBranch(glUpdateList.account,glBatchHdr.branch)
             
        //glAccountUpdate.credit += amount
	//glAccountUpdate.creditBalance += amount
	//glAccountUpdate.creditToday += amount
	//glAccountUpdate.save(flush:true,failOnError:true)	

        return
    }

    /**
     * Debit the Deposit Account
     */
    def debitDepositAccount (Long id, String depositAcctNo, Double amount, String txnPart, String batchId, UserMaster user){
        
        //acctNo
        def depositAcct = Deposit.findByAcctNo(depositAcctNo)

        // final check for failed txxn
        Boolean failed = false
        String lineStatus
        if (amount > depositAcct.availableBalAmt) {
            lineStatus = '99BAL - Insuficient available balance'
            failed = true
        } else if (depositAcct.status == DepositStatus.get(1)) {
            lineStatus = '99PEN - Deposit account pending'
            failed = true
        } else if (depositAcct.status == DepositStatus.get(6)) {
            lineStatus = '99LKD - Deposit account locked'
            failed = true
        }   else if (depositAcct.status == DepositStatus.get(7)) {
            lineStatus = '99CLS - Deposit account closed'
            failed = true
        } else if (depositAcct.status == DepositStatus.get(8)) {
            lineStatus = '99CNL - Deposit account cancelled'
            failed = true
        } else if (depositAcct.type.id == 3) {
            lineStatus = '99FDT - Batch transaction not allowed for FD'
            failed = true
        }
        if (failed) {
            lineStatus = 'DrDep ' + depositAcctNo + ' ' + lineStatus
            postFailedBatch(id, amount, batchId, user, lineStatus)
            return
        }
            
        // create txn
        def drTmp = TxnTemplate.get(Institution.findByParamCode('DEP.40121').paramValue.toInteger())
        def txnDep = new TxnFile(acctNo:depositAcct.acctNo, branch:depositAcct.branch, currency:depositAcct.product.currency,
               depAcct:depositAcct, status:ConfigItemStatus.get(2), txnAmt:amount, txnCode:drTmp.code, 
                txnDate:Branch.get(1).runDate, txnDescription:'GL Batch Debit', txnParticulars:txnPart,
                txnRef:'GL Batch '+batchId, txnTemplate:drTmp, txnTimestamp:new Date().toTimestamp(), 
                txnType:drTmp.txnType, user:user)
        txnDep.save(flush:true, failOnError:true)
        
        def txnLedDep = new TxnDepositAcctLedger(acct:depositAcct, acctNo:depositAcct.acctNo, bal:depositAcct.ledgerBalAmt - amount,
            branch:depositAcct.branch, ccurrency:depositAcct.product.currency, debitAmt:amount, passbookBal:0,
            status:depositAcct.status, txnCode:txnDep.txnCode, txnDate:txnDep.txnDate, txnFile:txnDep, txnRef:txnDep.txnRef,
            txnType:txnDep.txnType, user:user)
        txnLedDep.save(flush:true, failOnError:true)
        
        //Debit from current balance
        depositAcct.availableBalAmt -= amount
        depositAcct.ledgerBalAmt -= amount
        //depositAcct.interestBalAmt -= amount
        depositAcct.save(failOnError:true, flush:true)
        def glUpdateList = GlBatch.get(id)
	def glBatchHdr = GlBatchHdr.findByBatchId(glUpdateList.batchId)    
        def ccy = glBatchHdr.batchCurrency
        def fy = txnDep.txnDate.format('yyyy').toInteger()
        def depstatus = depositAcct.status.id
        if (depositAcct.status.id == 3) {
            depstatus = 2
        }
        def gla = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(depositAcct.glLink, '0', depstatus)
        def glCode = GlAccount.findByBranchAndCodeAndFinancialYearAndCurrency(depositAcct.branch, gla.glCode, fy, ccy)
        
        glCode.debit += amount
        glCode.balance += amount
        glCode.debitToday += amount
        Double newBal = glCode.balance + amount
        if (newBal == 0) {
            glCode.debitBalance = 0.00
            glCode.creditBalance = 0.00
        } else {
            if (newBal > 0) {
                glCode.debitBalance = newBal
                glCode.creditBalance = 0.00                
            } else {
                glCode.debitBalance = 0.00
                glCode.creditBalance = newBal * -1                  
            }
        }
        glCode.debit = glCode.debit.round(2)
        glCode.credit = glCode.credit.round(2)
        glCode.balance = glCode.balance.round(2)
        glCode.debitToday = glCode.debitToday.round(2)
        glCode.creditToday = glCode.creditToday.round(2)
        glCode.debitBalance = glCode.debitBalance.round(2)
        glCode.creditBalance = glCode.creditBalance.round(2)        
        glCode.save(failOnError:true, flush:true)
        
        def glTxn = new GlTxnFile(branch:depositAcct.branch, glAccount:glCode, glAccountCode:glCode.code,
            debitAmt:amount, debitBal:glCode.debit + amount, outstandingBal:glCode.balance, batchId:batchId,
            glBatchHdrId:glBatchHdr, glBatchLine:glUpdateList.lineNo, batchParticulars:glUpdateList.particulars,
            txnDate:glBatchHdr.txnDate, txnValueDate:glBatchHdr.valueDate, user:user)
	glTxn.save(flush:true, failOnError:true)        
        return

        //Ledger Balance Amount
    }

    /**
     * Credit the Deposit Account
     */
    def creditDepositAccount (Long id, String depositAcctNo, Double amount, String txnPart, String batchId, UserMaster user){

        //acctNo
        def depositAcct = Deposit.findByAcctNo(depositAcctNo)
        
        // final check for failed txn
        Boolean failed = false
        String lineStatus
        if (depositAcct.status == DepositStatus.get(1)) {
            lineStatus = '99PEN - Deposit account pending'
            failed = true
        } else if (depositAcct.status == DepositStatus.get(6)) {
            lineStatus = '99LKD - Deposit account locked'
            failed = true
        } else if (depositAcct.status == DepositStatus.get(7)) {
            lineStatus = '99CLS - Deposit account closed'
            failed = true
        } else if (depositAcct.status == DepositStatus.get(8)) {
            lineStatus = '99CNL - Deposit account cancelled'
            failed = true
        }        
        if (failed) {
            lineStatus = 'CrDep ' + depositAcctNo + ' ' + lineStatus
            postFailedBatch(id, amount, batchId, user, lineStatus)
            return
        }        
        
        // create txn
        def crTmp = TxnTemplate.get(Institution.findByParamCode('DEP.40122').paramValue.toInteger())
        def txnDep = new TxnFile(acctNo:depositAcct.acctNo, branch:depositAcct.branch, currency:depositAcct.product.currency,
               depAcct:depositAcct, status:ConfigItemStatus.get(2), txnAmt:amount, txnCode:crTmp.code, 
                txnDate:Branch.get(1).runDate, txnDescription:'GL Batch Credit', txnParticulars:txnPart,
                txnRef:'GL Batch '+batchId, txnTemplate:crTmp, txnTimestamp:new Date().toTimestamp(), 
                txnType:crTmp.txnType, user:user)
        txnDep.save(flush:true, failOnError:true)
        
        def txnLedDep = new TxnDepositAcctLedger(acct:depositAcct, acctNo:depositAcct.acctNo, bal:depositAcct.ledgerBalAmt + amount,
            branch:depositAcct.branch, ccurrency:depositAcct.product.currency, creditAmt:amount, passbookBal:depositAcct.passbookBalAmt,
            status:depositAcct.status, txnCode:txnDep.txnCode, txnDate:txnDep.txnDate, txnFile:txnDep, txnRef:txnDep.txnRef,
            txnType:txnDep.txnType, user:user)
        txnLedDep.save(flush:true, failOnError:true)
        //Debit from current balance
        depositAcct.ledgerBalAmt += amount
        depositAcct.availableBalAmt += amount
        //depositAcct.interestBalAmt += amount
        depositAcct.save(failOnError:true, flush:true)
        
	//def glAccount = GlAccount.read(glCodeId)
        def fy = txnDep.txnDate.format('yyyy').toInteger()
        def glUpdateList = GlBatch.get(id)
	def glBatchHdr = GlBatchHdr.findByBatchId(glUpdateList.batchId)          
        def ccy = glBatchHdr.batchCurrency
        def depstatus = depositAcct.status.id
        if (depositAcct.status.id == 3) {
            depstatus = 2
        }
        println depstatus
        def gla = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(depositAcct.glLink, '0', depstatus)
        def glCode = GlAccount.findByBranchAndCodeAndFinancialYearAndCurrency(depositAcct.branch, gla.glCode, fy, ccy)
        
        glCode.credit += amount
        glCode.balance -= amount
        glCode.creditToday += amount
        Double newBal = glCode.balance - amount
        if (newBal == 0) {
            glCode.debitBalance = 0.00
            glCode.creditBalance = 0.00
        } else {
            if (newBal > 0) {
                glCode.debitBalance = newBal
                glCode.creditBalance = 0.00                
            } else {
                glCode.debitBalance = 0.00
                glCode.creditBalance = newBal * -1                  
            }
        }
        glCode.debit = glCode.debit.round(2)
        glCode.credit = glCode.credit.round(2)
        glCode.balance = glCode.balance.round(2)
        glCode.debitToday = glCode.debitToday.round(2)
        glCode.creditToday = glCode.creditToday.round(2)
        glCode.debitBalance = glCode.debitBalance.round(2)
        glCode.creditBalance = glCode.creditBalance.round(2)        
        glCode.save(failOnError:true, flush:true)
        def glTxn = new GlTxnFile(branch:glBatchHdr.branch, glAccount:glCode, glAccountCode:glCode.code, creditAmt:amount,
            creditBal:glCode.credit + amount, outstandingBal:glCode.balance, glBatchHdrId:glBatchHdr, glBatchLine:glUpdateList.lineNo,
            batchId:glUpdateList.batchId, batchParticulars:glUpdateList.particulars, 
            txnDate:glBatchHdr.txnDate, txnValueDate:glBatchHdr.valueDate, user:user)
        glTxn.save(failOnError:true, flush:true)
        return
    }
    /**
     * Debit Loan Account
     * 
     * Increase the balance amount (Principal Balance)
     * 
     */
    def debitLoanAccount (Long id, String loanAcctNo, Double amount, String txnPart, String batchId, UserMaster user){

        def loanAcct = Loan.findByAccountNo(loanAcctNo)
        def drLoanTxn = TxnTemplate.get(Institution.findByParamCode('LNS.50083').paramValue.toInteger())
        // final checking for failed
        Boolean failed = false
        String lineStatus
        if (loanAcct.status == LoanAcctStatus.get(1)) {
            lineStatus = '99APR - loan not yet approved - Pending'
            failed = true
        } else if (loanAcct.status == LoanAcctStatus.get(2)) {
            lineStatus = '99APR - loan not yet approved - Open'
            failed = true
        } else if (amount + loanAcct.totalDisbursementAmount > loanAcct.totalNetProceeds) {
            lineStatus = '99ODB - Over disbursement'
            failed = false                
        }        
        if (failed) {
            lineStatus = 'LnDep ' + loanAcctNo + ' ' + lineStatus
            postFailedBatch(id, amount, batchId, user, lineStatus)
            return
        }      
        
        def txnLn = new TxnFile(acctNo:loanAcct.accountNo, branch:loanAcct.branch, currency:loanAcct.product.currency,
               loanAcct:loanAcct, status:ConfigItemStatus.get(2), txnAmt:amount, txnCode:drLoanTxn.code, 
                txnDate:Branch.get(1).runDate, txnDescription:'GL Batch Debit', txnParticulars:txnPart,
                txnRef:'GL Batch '+batchId, txnTemplate:drLoanTxn, txnTimestamp:new Date().toTimestamp(), 
                txnType:drLoanTxn.txnType, user:user)
        txnLn.save(failOnError:true, flush:true)        
        
        loanAcct.balanceAmount += amount
        loanAcct.totalDisbursementAmount += amount
        loanAcct.lastTransactionDate = Branch.get(1).runDate
        loanAcct.save(failOnError:true)
        
        def ln = new LoanLedger(loan:loanAcct, principalDebit:amount, principalBalance: loanAcct.balanceAmount,
            txnCode:drLoanTxn.code, txnDate:txnLn.txnDate,
            txnFile:txnLn, txnParticulars:txnLn.txnParticulars, txnRef:batchId, txnTemplate:txnLn.txnTemplate,
            txnType:drLoanTxn.memoTxnType)
        ln.save(failOnError:true, flush:true)
        
	//def glAccount = GlAccount.read(glCodeId)
        def glUpdateList = GlBatch.get(id)
	def glBatchHdr = GlBatchHdr.findByBatchId(glUpdateList.batchId)          
        def fy = txnLn.txnDate.format('yyyy').toInteger()
        def ccy = glBatchHdr.batchCurrency              
        def gla = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loanAcct.glLink, '0', loanAcct.performanceClassification.id)
        def glCode = GlAccount.findByBranchAndCodeAndFinancialYearAndCurrency(loanAcct.branch, gla.glCode, fy, ccy)
        glCode.debit += amount
        glCode.balance += amount
        glCode.debitToday += amount
        Double newBal = glCode.balance + amount
        if (newBal == 0) {
            glCode.debitBalance = 0.00
            glCode.creditBalance = 0.00
        } else {
            if (newBal > 0) {
                glCode.debitBalance = newBal
                glCode.creditBalance = 0.00                
            } else {
                glCode.debitBalance = 0.00
                glCode.creditBalance = newBal * -1                  
            }
        }
        glCode.debit = glCode.debit.round(2)
        glCode.credit = glCode.credit.round(2)
        glCode.balance = glCode.balance.round(2)
        glCode.debitToday = glCode.debitToday.round(2)
        glCode.creditToday = glCode.creditToday.round(2)
        glCode.debitBalance = glCode.debitBalance.round(2)
        glCode.creditBalance = glCode.creditBalance.round(2)        
        glCode.save(failOnError:true, flush:true)
        
        def glTxn = new GlTxnFile(branch:loanAcct.branch, glAccount:glCode, glAccountCode:glCode.code,
            debitAmt:amount, debitBal:glCode.debit + amount, outstandingBal:glCode.balance, batchId:batchId,
            glBatchHdrId:glBatchHdr, glBatchLine:glUpdateList.lineNo, batchParticulars:glUpdateList.particulars,
            txnDate:glBatchHdr.txnDate, txnValueDate:glBatchHdr.valueDate, user:user)
	glTxn.save(flush:true,failOnError:true)        

        return
        
    }
    def creditLoanAccount (Long id, String loanAcctNo, Double amount, Double principal, Double interest, Double penalty, Double serviceCharge, String  particulars, String batchId, UserMaster user){

        def loanAcct = Loan.findByAccountNo(loanAcctNo)
        def crLoanTxn = Institution.findByParamCode('LNS.50073').paramValue.toInteger()
        // final checking for failed
        Boolean failed = false
        String lineStatus
        if (loanAcct.status == LoanAcctStatus.get(1)) {
            lineStatus = '99APR - loan not yer approved - Pending'
            failed = true
        } else if (loanAcct.status == LoanAcctStatus.get(2)) {
             lineStatus = '99APR - loan not yer approved - Open'
             failed = true
        } else if (loanAcct.status == LoanAcctStatus.get(6)) {
            lineStatus = '99CLS - Loan Closed'
            failed = true
        }  else if (loanAcct.status == LoanAcctStatus.get(7)) {
            lineStatus = '99CLS - Loan written off'
            failed = true
        }  else if (loanAcct.status == LoanAcctStatus.get(7)) {
            lineStatus = '99CLS - Loan already transferred to ROPA'
            failed = true
        } else if ((principal) && (principal > loanAcct.balanceAmount)) {
            lineStatus = '99OVP - Princial Payment Amount greater than Loan Balance'
            failed = true            
        }       
        if (failed) {
            lineStatus = 'LnCr ' + loanAcctNo + ' ' + lineStatus
            postFailedBatch(id, amount, batchId, user, lineStatus)
            return
        }
        def txnAmt = amount
        //Manual Computation
        if(principal == null && interest == null && penalty == null && serviceCharge == null ){
            
            if (amount >= loanAcct.serviceChargeBalanceAmount) {
                amount -= loanAcct.serviceChargeBalanceAmount
                serviceCharge = loanAcct.serviceChargeBalanceAmount
                loanAcct.serviceChargeBalanceAmount = 0.00
            } else {
                loanAcct.serviceChargeBalanceAmount -= amount
                serviceCharge = amount
                amount = 0.00
            }
            if (amount >= loanAcct.penaltyBalanceAmount) {
                amount -= loanAcct.penaltyBalanceAmount
                penalty = loanAcct.penaltyBalanceAmount
                loanAcct.penaltyBalanceAmount = 0.00
            } else {
                loanAcct.penaltyBalanceAmount -= amount
                penalty = amount
                amount = 0.00
            }       
            if (amount >= loanAcct.interestBalanceAmount) {
                amount -= loanAcct.interestBalanceAmount
                interest = loanAcct.interestBalanceAmount
                loanAcct.interestBalanceAmount = 0.00
            } else {
                loanAcct.interestBalanceAmount -= amount
                interest = amount
                amount = 0.00
            }      
            if (amount >= loanAcct.balanceAmount) {
                amount -= loanAcct.balanceAmount
                principal = loanAcct.balanceAmount
                loanAcct.balanceAmount = 0.00
            } else {
                loanAcct.balanceAmount -= amount
                principal = amount
                amount = 0.00
            } 
            // reject for overpayment as will result in unbalanced batch
            if (amount > 0.00) {
                lineStatus = 'LnCr ' + loanAcctNo + ' overpayment - For manual adjustment' 
                postFailedBatch(id, amount, batchId, user, lineStatus)
                //return
            }
            /*
            loanAcct.serviceChargeBalanceAmount -= amount
            amount = updateAmount(amount,loanAcct.serviceChargeBalanceAmount)
            
            loanAcct.penaltyAmount -= amount
            amount = updateAmount(amount,loanAcct.penaltyAmount)

            loanAcct.interestBalanceAmount -= amount
            amount = updateAmount(amount,loanAcct.interestBalanceAmount)

            loanAcct.balanceAmount -= amount
            */
        } else {            
            //Specific Computation
            if (serviceCharge > 0.00) {
                loanAcct.serviceChargeBalanceAmount -= serviceCharge
            }
            if (penalty > 0.00) {
                loanAcct.penaltyBalanceAmount -= penalty
            }
            if (interest > 0.00) {
                loanAcct.interestBalanceAmount -= interest
            }
            if (principal > 0.00) {
                loanAcct.balanceAmount -= principal
            }     
        }
        loanAcct.save(failOnError:true, flush:true)
        
        // save txnFile and LoanLedger
        // do not create transaction file and ledger in case of line status error
        if (lineStatus != "") {
            def tfCr = new TxnFile(acctNo:loanAcct.accountNo, loanAcct:loanAcct,
                currency:loanAcct.product.currency, user:user, branch:loanAcct.branch,
                txnAmt:txnAmt, txnCode:TxnTemplate.get(crLoanTxn).code, txnType:TxnTemplate.get(crLoanTxn).txnType,
                txnDate:Branch.get(1).runDate, txnTimestamp:new Date().toTimestamp(), status:ConfigItemStatus.get(2),
                txnDescription:'GL Batch Loan Credit', txnRef:Branch.get(1).runDate.toString() + ' Loan GL Batch Cr',
                txnTemplate:TxnTemplate.get(crLoanTxn), txnParticulars:'GL Batch Loan Credit') 
            tfCr.save(flush:true,failOnError:true)
                        
            def lnPayDet = new TxnLoanPaymentDetails(acct:loanAcct, acctNo:loanAcct.accountNo, balForwarded:loanAcct.balanceAmount,
                branch:loanAcct.branch, currency:loanAcct.product.currency, interestAmt:interest, 
                interestBalAfterPayment:loanAcct.interestBalanceAmount, paymentAmt:txnAmt, 
                penaltyAmt:penalty, penaltyBalAfterPayment:loanAcct.penaltyBalanceAmount,
                principalAmt:principal, principalBalAfterPayment:loanAcct.balanceAmount,
                serviceChargeAmt:serviceCharge, txnDate:Branch.get(1).runDate, txnFile:tfCr, txnRef:tfCr.txnRef, user:user)
            lnPayDet.save(flush:true,failOnError:true)
                        
            def loanLedgerEntry = new LoanLedger(loan: loanAcct, txnFile: tfCr, txnDate: Branch.get(1).runDate, 
                txnTemplate: TxnTemplate.get(crLoanTxn), txnRef: tfCr.txnRef, principalCredit: principal, 
                principalBalance: loanAcct.balanceAmount, interestCredit: interest, 
                interestBalance: loanAcct.interestBalanceAmount, penaltyCredit: penalty, 
                penaltyBalance: loanAcct.penaltyBalanceAmount, chargesCredit: serviceCharge)
            loanLedgerEntry.save(flush:true,failOnError:true)             
        }
        
        
        def glUpdateList = GlBatch.get(id)
	def glBatchHdr = GlBatchHdr.findByBatchId(glUpdateList.batchId)
        Double newBal
        def fy = tfCr.txnDate.format('yyyy').toInteger()
        def ccy = glBatchHdr.batchCurrency
        
        if (principal > 0) {
            // update loan principal GL
            def gla = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loanAcct.glLink, '0', loanAcct.performanceClassification.id)
            def glCode = GlAccount.findByBranchAndCodeAndFinancialYearAndCurrency(loanAcct.branch, gla.glCode, fy, ccy)
        
            glCode.credit += principal
            glCode.balance -= principal
            glCode.creditToday += principal
            newBal = glCode.balance - principal
            if (newBal == 0) {
                glCode.debitBalance = 0.00d
                glCode.creditBalance = 0.00d
            } else {
                if (newBal > 0) {
                    glCode.debitBalance = newBal
                    glCode.creditBalance = 0.00d              
                } else {
                    glCode.debitBalance = 0.00d
                    glCode.creditBalance = newBal * -1                  
                }
            }
            glCode.debit = glCode.debit.round(2)
            glCode.credit = glCode.credit.round(2)
            glCode.balance = glCode.balance.round(2)
            glCode.debitToday = glCode.debitToday.round(2)
            glCode.creditToday = glCode.creditToday.round(2)
            glCode.debitBalance = glCode.debitBalance.round(2)
            glCode.creditBalance = glCode.creditBalance.round(2)
            
            glCode.save(flush:true,failOnError:true)
            def glTxn = new GlTxnFile(branch:glBatchHdr.branch, glAccount:glCode, glAccountCode:glCode.code, creditAmt:principal,
                creditBal:glCode.credit + principal, outstandingBal:glCode.balance, glBatchHdrId:glBatchHdr, glBatchLine:glUpdateList.lineNo,
                batchId:glUpdateList.batchId, batchParticulars:glUpdateList.particulars, 
                txnDate:glBatchHdr.txnDate, txnValueDate:glBatchHdr.valueDate, user:user)
            glTxn.save(flush:true,failOnError:true)            
        }
        if (interest > 0) {
            // update loan interest GL      
            def glaInt = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loanAcct.glLink, '2', loanAcct.performanceClassification.id)
            def glCodeInt = GlAccount.findByBranchAndCodeAndFinancialYearAndCurrency(loanAcct.branch, glaInt.glCode, fy, ccy)
            glCodeInt.credit += interest
            glCodeInt.balance -= interest
            glCodeInt.creditToday += interest
            newBal = glCodeInt.balance - interest
            if (newBal == 0) {
                glCodeInt.debitBalance = 0.00d
                glCodeInt.creditBalance = 0.00d
            } else {
                if (newBal > 0) {
                    glCodeInt.debitBalance = newBal
                    glCodeInt.creditBalance = 0.00d                
                } else {
                    glCodeInt.debitBalance = 0.00d
                    glCodeInt.creditBalance = newBal * -1                  
                }
            }
            glCodeInt.debit = glCodeInt.debit.round(2)
            glCodeInt.credit = glCodeInt.credit.round(2)
            glCodeInt.balance = glCodeInt.balance.round(2)
            glCodeInt.debitToday = glCodeInt.debitToday.round(2)
            glCodeInt.creditToday = glCodeInt.creditToday.round(2)
            glCodeInt.debitBalance = glCodeInt.debitBalance.round(2)
            glCodeInt.creditBalance = glCodeInt.creditBalance.round(2)            
            glCodeInt.save(flush:true,failOnError:true)
            def crIntBal = glCodeInt.credit + interest
            def glTxn = new GlTxnFile(branch:glBatchHdr.branch, glAccount:glCodeInt, glAccountCode:glCodeInt.code, creditAmt:interest,
                creditBal:crIntBal, outstandingBal:glCodeInt.balance, glBatchHdrId:glBatchHdr, glBatchLine:glUpdateList.lineNo,
                batchId:glUpdateList.batchId, batchParticulars:glUpdateList.particulars, 
                txnDate:glBatchHdr.txnDate, txnValueDate:glBatchHdr.valueDate, user:user)
            glTxn.save(flush:true,failOnError:true)              
        }
        if (penalty > 0) {
            // update loan penalty GL
            def glaPen = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loanAcct.glLink, '4', loanAcct.performanceClassification.id)
            def glCodePen = GlAccount.findByBranchAndCodeAndFinancialYearAndCurrency(loanAcct.branch, glaPen.glCode, fy, ccy)            
            glCodePen.credit += penalty
            glCodePen.balance -= penalty
            glCodePen.creditToday += penalty
            newBal = glCodePen.balance - penalty
            if (newBal == 0) {
                glCodePen.debitBalance = 0.00d
                glCodePen.creditBalance = 0.00d
            } else {
                if (newBal > 0) {
                    glCodePen.debitBalance = newBal
                    glCodePen.creditBalance = 0.00d                
                } else {
                    glCodePen.debitBalance = 0.00d
                    glCodePen.creditBalance = newBal * -1                  
                }
            }
            glCodePen.debit = glCodePen.debit.round(2)
            glCodePen.credit = glCodePen.credit.round(2)
            glCodePen.balance = glCodePen.balance.round(2)
            glCodePen.debitToday = glCodePen.debitToday.round(2)
            glCodePen.creditToday = glCodePen.creditToday.round(2)
            glCodePen.debitBalance = glCodePen.debitBalance.round(2)
            glCodePen.creditBalance = glCodePen.creditBalance.round(2)            
            
            glCodePen.save(flush:true,failOnError:true)
            def glTxn = new GlTxnFile(branch:glBatchHdr.branch, glAccount:glCodePen, glAccountCode:glCodePen.code, creditAmt:penalty,
                creditBal:glCodePen.credit + penalty, outstandingBal:glCodePen.balance, glBatchHdrId:glBatchHdr, glBatchLine:glUpdateList.lineNo,
                batchId:glUpdateList.batchId, batchParticulars:glUpdateList.particulars, 
                txnDate:glBatchHdr.txnDate, txnValueDate:glBatchHdr.valueDate, user:user)
            glTxn.save(flush:true,failOnError:true)             
        }
        if (serviceCharge > 0) {
            // update loan service charge GL
            def glaSc = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loanAcct.glLink, '6', loanAcct.performanceClassification.id)
            glCodeSc = GlAccount.findByBranchAndCodeAndFinancialYearAndCurrency(loanAcct.branch, glaSc.glCode, fy, ccy)   
            glCodeSc.credit += serviceCharge
            glCodeSc.balance -= serviceCharge
            glCodeSc.creditToday += serviceCharge
            newBal = glCodeSc.balance - serviceCharge
            if (newBal == 0) {
                glCodeSc.debitBalance = 0.00d
                glCodeSc.creditBalance = 0.00d
            } else {
                if (newBal > 0) {
                    glCodeSc.debitBalance = newBal
                    glCodeSc.creditBalance = 0.00d              
                } else {
                    glCodeSc.debitBalance = 0.00d
                    glCodeSc.creditBalance = newBal * -1                  
                }
            }
            glCodeSc.debit = glCodeSc.debit.round(2)
            glCodeSc.credit = glCodeSc.credit.round(2)
            glCodeSc.balance = glCodeSc.balance.round(2)
            glCodeSc.debitToday = glCodeSc.debitToday.round(2)
            glCodeSc.creditToday = glCodeSc.creditToday.round(2)
            glCodeSc.debitBalance = glCodeSc.debitBalance.round(2)
            glCodeSc.creditBalance = glCodeSc.creditBalance.round(2)            
            
            glCodeSc.save(flush:true,failOnError:true)
            def glTxn = new GlTxnFile(branch:glBatchHdr.branch, glAccount:glCodeSc, glAccountCode:glCodeSc.code, creditAmt:serviceCharge,
                creditBal:glCodeSc.credit + serviceCharge, outstandingBal:glCodeSc.balance, glBatchHdrId:glBatchHdr, glBatchLine:glUpdateList.lineNo,
                batchId:glUpdateList.batchId, batchParticulars:glUpdateList.particulars, 
                txnDate:glBatchHdr.txnDate, txnValueDate:glBatchHdr.valueDate, user:user)
            glTxn.save(flush:true,failOnError:true)              
        }
        
    }

    /**
     * Deposit Account ICC // Debit or Credit
     */
    def depositAcctIcc (long id, String depositAcctNo, Double amount, String checkNo, UserMaster user) {
        def depositInstance = Deposit.findByAcctNo(depositAcctNo)
        def chequeInstance  = Cheque.findByChequeNo(checkNo.toInteger())
        def chequebookInstance = chequeInstance.chequebook
        
        // final check for failed txn
        Boolean failed = false
        String lineStatus
        
        if (chequeInstance) {
            def depAcct = chequeInstance.chequebook.deposit
            def stopChq = StopPaymentOrder.findByChequeAndStatus(chequeInstance,ConfigItemStatus.read(2))
                    
            if (depositInstance != depAcct) {
                lineStatus = '99ACC - Account and Check does not match'
                failed = true
            } else if (amount > depositInstance.availableBalAmt) {
                lineStatus = '99BAL - Insuficient available balance'
                failed = true
            } else if (depositInstance.status.id == 1) {
                lineStatus = '99PEN - Deposit account pending'
                failed = true
            } else if (depositInstance.status.id > 4) {
                lineStatus = '99PEN - Deposit account dormant/closed/cancelled'
                failed = true
            } else if(chequeInstance.status.id!=2){   
                lineStatus = '99CKU - Check already used'
                failed = true
            } else if (stopChq) {
                lineStatus = '99CKS - Check stopped'
                failed = true
            }               
        } else {
            lineStatus = '99UKC - Unknown Check'
            failed = true
        }        
        if (failed) {
            lineStatus = 'IccDr ' + depositAcctNo + ' - Chq#' + checkNo + ' ' + lineStatus
            postFailedBatch(id, amount, batchId, user, lineStatus)
            return
        }            
        def txnType = TxnTemplate.read(Institution.findByParamCode('GLS.60112').paramValue.toInteger())
        def txnFile1 = new TxnFile(txnDate:Branch.get(1).runDate,txnParticulars:'ICC',
                currency:depositInstance.product.currency.id,txnType:txnType.txnType,status:ConfigItemStatus.read(2),
                txnTimestamp:new Date().toTimestamp(),user:user,branch:depositInstance.branch,
                txnCode:txnType.code, txnDescription:txnType.description,acctNo:depositInstance.acctNo,
                txnAmt:amount,txnRef:'inward '+ checkNo,depAcct:depositInstance,txnTemplate:txnType)
                txnFile1.save(flush:true,validate:false, failOnError:true)
                       
        depositInstance.availableBalAmt-=amount
        depositInstance.ledgerBalAmt-=amount
        chequeInstance.chequeAmt = amount
        chequeInstance.isChequeClrOnUs = true
        chequeInstance.status = CheckStatus.read(3)
        chequebookInstance.chequesUsed += 1
        
        depositInstance.save(flush:true, failOnError:true)
        chequeInstance.save(flush:true, failOnError:true)
        chequebookInstance.save(flush:true, failOnError:true)
        
        // update ledger
        def acctLedger1 = new TxnDepositAcctLedger(txnType:txnType.txnType,user:user,branch:depositInstance.branch,
            currency:depositInstance.product.currency,status:depositInstance.status,txnDate:Branch.get(1).runDate,
            txnFile:txnFile1,acct:depositInstance,acctNo:depositInstance.acctNo,debitAmt:amount,
            bal:depositInstance.ledgerBalAmt,txnRef:'inward '+ checkNo)
        acctLedger1.save(flush:true, validate:false, failOnError:true)    
        
        def glUpdateList = GlBatch.get(id)
	def glBatchHdr = GlBatchHdr.findByBatchId(glUpdateList.batchId)    
        def ccy = glBatchHdr.batchCurrency
        def fy = txnFile1.txnDate.format('yyyy').toInteger()
        def depstatus = depositInstance.status.id
        if (depositInstance.status.id == 3) {
            depstatus = 2
        }
        def gla = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(depositInstance.glLink, '0', depstatus)
        def glCode = GlAccount.findByBranchAndCodeAndFinancialYearAndCurrency(depositInstance.branch, gla.glCode, fy, ccy)
        
        glCode.debit += amount
        glCode.balance += amount
        glCode.debitToday += amount
        Double newBal = glCode.balance + amount
        if (newBal == 0) {
            glCode.debitBalance = 0.00
            glCode.creditBalance = 0.00
        } else {
            if (newBal > 0) {
                glCode.debitBalance = newBal
                glCode.creditBalance = 0.00                
            } else {
                glCode.debitBalance = 0.00
                glCode.creditBalance = newBal * -1                  
            }
        }
        glCode.debit = glCode.debit.round(2)
        glCode.credit = glCode.credit.round(2)
        glCode.balance = glCode.balance.round(2)
        glCode.debitToday = glCode.debitToday.round(2)
        glCode.creditToday = glCode.creditToday.round(2)
        glCode.debitBalance = glCode.debitBalance.round(2)
        glCode.creditBalance = glCode.creditBalance.round(2)            
        
        glCode.save(failOnError:true, flush:true)
        
        def glTxn = new GlTxnFile(branch:depositInstance.branch, glAccount:glCode, glAccountCode:glCode.code,
            debitAmt:amount, debitBal:glCode.debit + amount, outstandingBal:glCode.balance, batchId:glBatchHdr.batchId,
            glBatchHdrId:glBatchHdr, glBatchLine:glUpdateList.lineNo, batchParticulars:glUpdateList.particulars,
            txnDate:glBatchHdr.txnDate, txnValueDate:glBatchHdr.valueDate, user:user)
	glTxn.save(flush:true, failOnError:true)        

        return
    }

    /**
     * Update amount for Specific Computation of Loan
     */
    private updateAmount (Double amount, Double remaining){

        amount -= remaining

        return amount

    }


    def saveBatchEntry (params) { 
        String lineStatus = ''
        Boolean lineOk = true
        // txnFile1 = new TxnFile(txnCode:TxnTemplate.read(params.txnTemplate.id).code,acctNo:result.acct.acctNo,txnAmt:amount,txnRef:params.ref)

        // Copy to GL Transactions
        // Policy override needed
        def p = new GlBatch (
            lineNo: params.lineNo, 
            batchName: params.batchName, 
            batchId: params.batchId, 
            batchType: params.transaction, 
            txnType: params.txnType, 
            recordDate: new Date(),
            account: params.account, 
            currency: params.currency, 
            reference: params.transactionReference, 
            particulars: params.transactionParticulars,
            debit: params.debit,
            credit: params.credit,
            debitAccount: params.debitAccount,
            creditAccount: params.creditAccount,
            amount: params.amount,
            checkNo: params.checkNo,
            accountName: params.glName,
            principal: params.principal,
            interest: params.interest,
            penalty: params.penalty,
            serviceCharge: params.serviceCharge
        )
        
        if (params.transaction == '1') {
            // debit deposit account
            def deposit = Deposit.findByAcctNo(params.account)
            if (params.debit > deposit.availableBalAmt) {
                lineStatus = '99BAL - Insuficient available balance'
                lineOk = false
            } else if (deposit.status == DepositStatus.get(1)) {
                lineStatus = '99PEN - Deposit account pending'
                lineOk = false
            } else if (deposit.status == DepositStatus.get(6)) {
                lineStatus = '99LKD - Deposit account locked'
                lineOk = false
            }   else if (deposit.status == DepositStatus.get(7)) {
                lineStatus = '99CLS - Deposit account closed'
                lineOk = false
            } else if (deposit.status == DepositStatus.get(8)) {
                lineStatus = '99CNL - Deposit account cancelled'
                lineOk = false
            } else if (deposit.type.id == 3) {
                lineStatus = '99FDT - Batch transaction not allowed for FD'
                lineOk = false
            }          
        } 
        
        if (params.transaction == '2') {
            // credit deposit account
            def deposit = Deposit.findByAcctNo(params.account)
            if (deposit.status == DepositStatus.get(1)) {
                lineStatus = '99PEN - Deposit account pending'
                lineOk = false
            } else if (deposit.status == DepositStatus.get(6)) {
                lineStatus = '99LKD - Deposit account locked'
                lineOk = false
            }   else if (deposit.status == DepositStatus.get(7)) {
                lineStatus = '99CLS - Deposit account closed'
                lineOk = false
            } else if (deposit.status == DepositStatus.get(8)) {
                lineStatus = '99CNL - Deposit account cancelled'
                lineOk = false
            } else if (deposit.type.id == 3) {
                if (deposit.currentRollover.startDate != deposit.branch.runDate) {
                    lineStatus = '99FDT - Batch transaction not allowed for FD - Not opening/roll Date'
                    lineOk = false                    
                }
            }              
        }
        
        if (params.transaction == '3') {
            // debit deposit account ICC
            def deposit = Deposit.findByAcctNo(params.account)
            def chequeInstance  = Cheque.findByChequeNo(params.checkNo.toInteger())
            if (chequeInstance) {
                def depAcct = chequeInstance.chequebook.deposit
                def stopChq = StopPaymentOrder.findByChequeAndStatus(chequeInstance,ConfigItemStatus.read(2))
                    
                if (deposit != depAcct) {
                    lineStatus = '99ACC - Account and Check does not match'
                    lineOk = false                    
                } else if (params.debit.toDouble() > deposit.availableBalAmt) {
                    lineStatus = '99BAL - Insuficient available balance'
                    lineOk = false
                } else if (deposit.status.id == 1) {
                    lineStatus = '99PEN - Deposit account pending'
                    lineOk = false
                } else if (deposit.status.id > 4) {
                    lineStatus = '99PEN - Deposit account dormant/closed/cancelled'
                    lineOk = false
                } else if(chequeInstance.status.id!=2){   
                    lineStatus = '99CKU - Check already used'
                    lineOk = false                    
                } else if (stopChq) {
                    lineStatus = '99CKS - Check stopped'
                    lineOk = false  
                }               
            } else {
                lineStatus = '99UKC - Check stopped'
                lineOk = false 
            }
   
        }
        
        if (params.transaction == '4') {
            // debit loan account
            def loan = Loan.findByAccountNo(params.account)
            if (loan.status == LoanAcctStatus.get(1)) {
                lineStatus = '99APR - loan not yet approved - Pending'
                lineOk = false                  
            } else if (loan.status == LoanAcctStatus.get(2)) {
                lineStatus = '99APR - loan not yet approved - Open'
                lineOk = false                 
            } else if (params.debit + loan.totalDisbursementAmount > loan.totalNetProceeds) {
                lineStatus = '99ODB - Over disbursement'
                lineOk = false                
            }
        }
        
        if (params.transaction == '5') {
            // credit loan account
            def loan = Loan.findByAccountNo(params.account)
            if (loan.status == LoanAcctStatus.get(1)) {
                lineStatus = '99APR - loan not yer approved - Pending'
                lineOk = false                  
            } else if (loan.status == LoanAcctStatus.get(2)) {
                lineStatus = '99APR - loan not yer approved - Open'
                lineOk = false                 
            } else if (loan.status == LoanAcctStatus.get(6)) {
                lineStatus = '99CLS - Loan Closed'
                lineOk = false                
            }  else if (loan.status == LoanAcctStatus.get(7)) {
                lineStatus = '99CLS - Loan written off'
                lineOk = false
            }  else if (loan.status == LoanAcctStatus.get(7)) {
                lineStatus = '99CLS - Loan already transferred to ROPA'
                lineOk = false
            }    
        } 
        
        if (params.transaction == '6') {
            // credit loan account specified
        }    
        if (lineOk) {
            lineStatus = ''
        }

       p.lineStatus = lineStatus
       p.save(failOnError:true, flush:true)

       //println "Transaction saved!"
    
    }

    def saveBatchHeader (params) {
        
        //def loan_id = Loan.findByAccountNo(params.loanAcct).id

        //println loan_id
        println params.valueDate
        def newBatch = new GlBatchHdr (
            batchId: params.batchId,
            batchName: params.batchName,
            batchCurrency: params.currency,
            totalDebit: params.totalDebit,
            totalCredit: params.totalCredit,
            branch: params.branch,
            isLocked: 0,
            isBalanced: params.totalCredit == params.totalDebit ? 1 : 0,
            batchType: params.template,
            txnDate: Branch.get(1).runDate,
            loanId: params.loanAcct,
            status: GlBatchHdrStatus.get(1),
            valueDate: params.valueDate
        )

        newBatch.save(flush:true, failOnError:true)
        auditLogService.insert('140', 'GEN00500', 'Create GL Batch '+params.batchId, 'glBatchHdr', null, null, null, newBatch.id)

        //println(newBatch)
        //println "Header saved!"

    }

   def updateBatchHeader (id, params) {
       
        String string = params.valueDate;
        DateFormat format = new SimpleDateFormat("MM/dd/yyyy", Locale.ENGLISH);
        Date vDate = format.parse(string);

        def p = GlBatchHdr.findByBatchId(id)
        p.batchId = params.batchId
        p.batchName = params.batchName
        p.batchCurrency = Currency.get(params.currency)
        p.totalDebit = params.totalDebit
        p.totalCredit = params.totalCredit
        p.branch =  Branch.get(params.branch)
        p.isLocked = 0
        p.isBalanced = params.totalCredit == params.totalDebit ? 1 : 0
        p.status = GlBatchHdrStatus.get(1)
        p.valueDate = vDate

        p.save(flush:true, failOnError:true)
        auditLogService.insert('140', 'GEN00800', 'Update GL Batch '+params.batchId, 'glBatchHdr', null, null, null, p.id)
   }

   def updateBatchEntry (id, params) {
        String lineStatus = ''
        Boolean lineOk = true
        
        def p = GlBatch.findByBatchId(id)

        p.lineNo = params.lineNo
        p.batchName = params.batchName
        p.batchId = params.batchId
        p.batchType = params.transaction
        p.txnType = params.txnType
        p.recordDate = new Date() 
        p.account = params.account
        p.currency = Currency.get(params.currency)
        p.reference = params.transactionReference 
        p.particulars = params.transactionParticulars
        p.debit = params.debit
        p.credit = params.credit
        p.debitAccount = params.debitAccount
        p.creditAccount = params.creditAccount
        p.amount = params.amount
        p.checkNo = params.checkNo
        p.accountName = params.glName
        p.principal = params.principal
        p.interest = params.interest
        p.penalty = params.penalty
        p.serviceCharge = params.serviceCharge
        
        if (params.transaction == '1') {
            // debit deposit account
            def deposit = Deposit.findByAcctNo(params.account)
            if (params.debit > deposit.availableBalAmt) {
                lineStatus = '99BAL - Insuficient available balance'
                lineOk = false
            } else if (deposit.status == DepositStatus.get(1)) {
                lineStatus = '99PEN - Deposit account pending'
                lineOk = false
            } else if (deposit.status == DepositStatus.get(6)) {
                lineStatus = '99LKD - Deposit account locked'
                lineOk = false
            }   else if (deposit.status == DepositStatus.get(7)) {
                lineStatus = '99CLS - Deposit account closed'
                lineOk = false
            } else if (deposit.status == DepositStatus.get(8)) {
                lineStatus = '99CNL - Deposit account cancelled'
                lineOk = false
            } else if (deposit.type.id == 3) {
                lineStatus = '99FDT - Batch transaction not allowed for FD'
                lineOk = false
            }          
        } 
        
        if (params.transaction == '2') {
            // credit deposit account
            def deposit = Deposit.findByAcctNo(params.account)
            if (deposit.status == DepositStatus.get(1)) {
                lineStatus = '99PEN - Deposit account pending'
                lineOk = false
            } else if (deposit.status == DepositStatus.get(6)) {
                lineStatus = '99LKD - Deposit account locked'
                lineOk = false
            }   else if (deposit.status == DepositStatus.get(7)) {
                lineStatus = '99CLS - Deposit account closed'
                lineOk = false
            } else if (deposit.status == DepositStatus.get(8)) {
                lineStatus = '99CNL - Deposit account cancelled'
                lineOk = false
            }              
        }
        
        if (params.transaction == '3') {
            // debit deposit account ICC
            def deposit = Deposit.findByAcctNo(params.account)
            def chequeInstance  = Cheque.findByChequeNo(checkNo.toInteger())
            if (chequeInstance) {
                def depAcct = chequeInstance.chequebook.deposit
                def stopChq = StopPaymentOrder.findByChequeAndStatus(cheque,ConfigItemStatus.read(2))
                    
                if (deposit != depAcct) {
                    lineStatus = '99ACC - Account and Check does not match'
                    lineOk = false                    
                } else if (params.debit > deposit.availableBalAmt) {
                    lineStatus = '99BAL - Insuficient available balance'
                    lineOk = false
                } else if (deposit.status == DepositStatus.get(1)) {
                    lineStatus = '99PEN - Deposit account pending'
                    lineOk = false
                } else if (deposit.status > DepositStatus.get(4)) {
                    lineStatus = '99PEN - Deposit account dormant/closed/cancelled'
                    lineOk = false
                } else if(chequeInstance.status.id!=2){   
                    lineStatus = '99CKU - Check already used'
                    lineOk = false                    
                } else if (stopChq) {
                    lineStatus = '99CKS - Check stopped'
                    lineOk = false  
                }               
            }   
        }
        
        if (params.transaction == '4') {
            // debit loan account
            def loan = Loan.findByAccountNo(params.account)
            if (loan.status == LoanAcctStatus.get(1)) {
                lineStatus = '99APR - loan not yet approved - Pending'
                lineOk = false                  
            } else if (loan.status == LoanAcctStatus.get(2)) {
                lineStatus = '99APR - loan not yet approved - Open'
                lineOk = false                 
            } else if (params.debit + loan.totalDisbursementAmount > loan.totalNetProceeds) {
                lineStatus = '99ODB - Over disbursement'
                lineOk = false                
            }
        }
        
        if (params.transaction == '5') {
            // credit loan account
            def loan = Loan.findByAccountNo(params.account)
            if (loan.status == LoanAcctStatus.get(1)) {
                lineStatus = '99APR - loan not yer approved - Pending'
                lineOk = false                  
            } else if (loan.status == LoanAcctStatus.get(2)) {
                lineStatus = '99APR - loan not yer approved - Open'
                lineOk = false                 
            } else if (loan.status == LoanAcctStatus.get(6)) {
                lineStatus = '99CLS - Loan Closed'
                lineOk = false                
            }  else if (loan.status == LoanAcctStatus.get(7)) {
                lineStatus = '99CLS - Loan written off'
                lineOk = false
            }  else if (loan.status == LoanAcctStatus.get(7)) {
                lineStatus = '99CLS - Loan already transferred to ROPA'
                lineOk = false
            }    
        } 
        
        if (params.transaction == '6') {
            // credit loan account specified
        }    
        if (lineOk) {
            lineStatus = ''
        }

        p.lineStatus = lineStatus
        p.save(failOnError:true, flush:true)

   }

   def deleteAllBatchEntries (id) {

        GlBatch.executeUpdate("delete GlBatch g where g.batchId=?",[id])

   }

   def saveGlAccountsToMultipleBranches (params){
       
        def branches = Branch.list()
        def ccy = Currency.list()
        for (b in branches)
        { 
          def dfGl = b.dueFromGl
          for(c in ccy) {
            def gl = new GlAccount(
                name: params.name,
                shortName: params.shortName,
                code:params.code,
                branch: b,
                type: params.type,
                parent: params.parent,
                currency: c,
                financialYear: Branch.get(1).runDate.format('yyyy').toInteger()
            )
            gl.save(flush:true, failOnError:true)              
          }  
          b.dueFromGl = dfGl
          b.save(flush:true)     
        }
        
        def gl = GlAccount.findAllByCode(params.code)
        for (daily in gl) {
            def gld = new GlDailyFile(glAcct:daily, currency:daily.currency, branch:daily.branch,
                    code:daily.code, name:daily.name, refDate:daily.branch.runDate.minus(1), 
                    debitToday:0.00D, creditToday:0.00D, debitBalance:0.00D,
                    creditBalance:0.00D, financialYear:daily.branch.runDate.format('yyyy').toInteger())
            gld.save(flush:true, failOnError:true)                            
        }
   }
  
    def PeriodicGlEntries(Date currentDate, UserMaster user) {
        // updating of gl
        Integer nLine
        Double batchDr
        Double batchCr
        def gHdr
        def gLine
        def postBatch
        
        // return //------------------------------------------ to be removed when id issue is resolved
        
        def bl = Branch.list()
        for (b in bl) {            
            def ccy = Currency.list()
            for(bc in ccy) {
                def glTxn = TxnBreakdown.createCriteria().list{
                    and {
                        eq("txnDate", currentDate)
                        eq("branch",b)
                        eq("currency",bc)                        
                    }
                }   
                // check for values then create gl batch
                if (glTxn){
                    nLine = 0
                    batchDr = 0.00
                    batchCr = 0.00
                    // create batch header
                    gHdr = new GlBatchHdr()
                    gHdr.batchId = bc.code + '-EOD-' + b.name +'-'+ currentDate.getTime().toString()
                    gHdr.batchName = 'EOD Automatic Batch - ' + b.name + ' - ' + bc.name
                    gHdr.batchCurrency = bc
                    gHdr.branch = b
                    gHdr.batchType = '1'
                    gHdr.totalDebit = batchDr
                    gHdr.totalCredit = batchCr
                    gHdr.isLocked = true
                    gHdr.isBalanced = false
                    gHdr.txnDate = currentDate
                    gHdr.save(flush:true,validateOnError:true)                         
                    //session.flush()
                    
                    println gHdr     // object not yet saved, problem for batchid
                    // create batch entries
                    for (glt in glTxn) {
                        if (glt.debitAmt > 0) {
                            batchDr += glt.debitAmt
                            gLine = GlBatch.findWhere(batchId:gHdr.batchId, debitAccount:glt.debitAcct)
                            if (gLine) {
                                gLine.amount += glt.debitAmt
                                gLine.debit += glt.debitAmt
                                gLine.save(flush:true,validateOnError:true)
                                //session.flush()
                            } else {
                                nLine++
                                gLine = new GlBatch(batchId:gHdr.batchId, batchType:'7', recordDate:currentDate,
                                    amount:glt.debitAmt, particulars:'EOD GL Entries', currency:bc, debitAccount:glt.debitAcct,
                                    debit:glt.debitAmt, account:glt.debitAcct, reference:'EOD Debit '+glt.debitAcct, lineNo:nLine.toString())
                                gLine.save(flush:true,validateOnError:true)
                                //session.flush()
                            }                            
                        } else if (glt.creditAmt > 0){
                            batchCr += glt.creditAmt
                            gLine = GlBatch.findWhere(batchId:gHdr.batchId, creditAccount:glt.creditAcct)
                            if (gLine) {
                                gLine.amount += glt.creditAmt
                                gLine.credit += glt.creditAmt
                                gLine.save(flush:true,validateOnError:true)
                                //session.flush()
                            } else {
                                nLine++
                                gLine = new GlBatch(batchId:gHdr.batchId, batchType:'8', recordDate:currentDate,
                                    amount:glt.creditAmt, particulars:'EOD GL Entries', currency:bc, creditAccount:glt.creditAcct,
                                    credit:glt.creditAmt, account:glt.creditAcct, reference:'EOD Credit '+glt.creditAcct, lineNo:nLine.toString())
                                gLine.save(flush:true,validateOnError:true)
                                //session.flush()
                            }                             
                        }                           
                    }
                    // post batch lines
                    postBatch = GlBatch.findAllByBatchId(gHdr.batchId)
                    for (pb in postBatch) {
                        if (pb.batchType == '7') {
                            this.debitGlAccount(pb.debitAccount, pb.amount, pb.id, user)
                        } else {
                            this.creditGlAccount(pb.creditAccount, pb.amount, pb.id, user)
                        }                        
                    }
                    // update header
                    gHdr.isBalanced = true
                    gHdr.isLocked = true
                    gHdr.totalDebit = batchDr
                    gHdr.totalCredit = batchCr
                    gHdr.status = GlBatchHdrStatus.get(3)
                    gHdr.save(flush:true,validateOnError:true)  
                    //session.flush()
                }                                  

            } // next currency
        } // next branch    
    }
    
def forexRevaluation(){
    // forex revaluation entries
    def baseCur = Currency.findByCode(Institution.findByParamCode('GLS.60010').paramValue)
    /*
    def glFx = glAccount.createCriteria().list{
        and{
            ne("",DepositType.read(3))
            eq("status",DepositStatus.read(2))
            eq("branch",branch)
        }
    */    
}
    def saveInwardGl(TxnFile tf) {
        println tf
        def tmp = TxnTemplate.findByCode(tf.txnCode)
        def fy = tf.txnDate.format('yyyy').toInteger()
       
        def tbDr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)
        def tbCr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)
        def deposit = tf.depAcct
        def depStatus = deposit.status.id
        if (deposit.status.id == 3) {
            depStatus = 2
        }
        def debitGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '0', depStatus)
        def debitGl = GlAccount.findByCodeAndBranchAndFinancialYear(debitGlPtr.glCode,tf.branch, fy)
        //def creditGl = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60114').paramValue, tf.branch,fy)
        def creditGl
        def iccCreditGl
        if (tmp) {
            iccCreditGl = tmp.defContraAcct
            creditGl = GlAccount.findByCodeAndBranchAndFinancialYear(iccCreditGl, tf.branch,fy)  
        } else {
            iccCreditGl = deposit.branch.iccContra
            creditGl = GlAccount.findByCodeAndBranchAndFinancialYear(iccCreditGl.code, tf.branch,fy)        
        }
        tbCr.creditAcct = creditGl.code        
        tbCr.creditAmt = tf.txnAmt           
        tbDr.debitAcct = debitGl.code
        tbDr.debitAmt = tf.txnAmt            

        if (!creditGl){
            tbCr.creditAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
        }
        if (!debitGl){
            tbDr.debitAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
        }           
        tbDr.save()
        tbCr.save()        
    
    }    
    
    def saveOnusGl(TxnFile tf) {
        println tf
        def tmp = TxnTemplate.findByCode(tf.txnCode)
        def fy = tf.txnDate.format('yyyy').toInteger()
       
        def tbDr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)
        def tbCr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)
        def deposit = tf.depAcct
        def depStatus = deposit.status.id
        if (deposit.status.id == 3) {
            depStatus = 2
        }
        def debitGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '0', depStatus)
        def debitGl = GlAccount.findByCodeAndBranchAndFinancialYear(debitGlPtr.glCode,tf.branch, fy)
        def creditGl = GlAccount.get(tf.user.coci.id)
    
        tbCr.creditAcct = creditGl.code
        tbCr.creditAmt = tf.txnAmt           
        tbDr.debitAcct = debitGl.code
        tbDr.debitAmt = tf.txnAmt            

        if (!creditGl){
            tbCr.creditAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
        }
        if (!debitGl){
            tbDr.debitAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
        }           
        tbDr.save()
        tbCr.save()        
    
    }
    def cashVaultTxn(TxnFile tf, TxnTemplate tmp, Integer fy) {
           def tbDr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)
           def tbCr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)

           def userCash = UserMaster.get(tf.user.id)
           def debitGl
           def creditGl
           if (tmp.txnType.id == 1) {
                debitGl =  GlAccount.get(userCash.cash.id)
                creditGl = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60100').paramValue,tf.branch, fy)
           } else {
                debitGl =  GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60100').paramValue,tf.branch, fy)
                creditGl = GlAccount.get(userCash.cash.id)                   
           }
           tbDr.debitAcct = debitGl.code
           tbCr.creditAcct = creditGl.code
           tbDr.debitAmt = tf.txnAmt
           tbCr.creditAmt = tf.txnAmt
           if (!creditGl){
               tbCr.creditAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }
           if (!debitGl){
               tbDr.debitAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }           
           tbDr.save(flush:true, failOnError: true)
           tbCr.save(flush:true, failOnError: true)
        
    }
    
    def tellerCashTransfer(TxnFile tf, TxnTemplate tmp, Integer fy){
           def tbDr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)
           def tbCr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)         
           
           def userCash = UserMaster.get(tf.user.id)
           def debitGl =  GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60110').paramValue,tf.branch, fy)         
           tbDr.debitAcct = debitGl.code
           tbDr.debitAmt = tf.txnAmt           
           
           def creditGl = GlAccount.get(userCash.cash.id)           
           tbCr.creditAcct = creditGl.code
           tbCr.creditAmt = tf.txnAmt
           
           tbDr.save(flush:true,failOnError:true) 
           tbCr.save(flush:true,failOnError:true)
           /*
           def tboDr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)
           def tboCr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)              
           
           def debitGlo =  GlAccount.get(userCash.cash.id)         
           tboDr.debitAcct = debitGlo.code
           tboDr.debitAmt = tf.txnAmt           
           
           def creditGlo = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60110').paramValue,tf.branch, fy)          
           tboCr.creditAcct = creditGlo.code
           tboCr.creditAmt = tf.txnAmt
           
           tboDr.save(flush:true, failOnError: true)
           tboCr.save(flush:true, failOnError: true)
           
           if (!creditGl){
               tbCr.creditAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }
           if (!debitGl){
               tbDr.debitAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }          
           //tb.save(flush:true, failOnError: true)
           */
           println 'saved!'
        
    }
   def tellerCashTransferReceive(TxnFile tf, TxnTemplate tmp, Integer fy){

           def tboDr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)
           def tboCr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)              
           
           def userCash = UserMaster.get(tf.user.id)
           
           def debitGlo =  GlAccount.get(userCash.cash.id)         
           tboDr.debitAcct = debitGlo.code
           tboDr.debitAmt = tf.txnAmt           
           
           def creditGlo = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60110').paramValue,tf.branch, fy)          
           tboCr.creditAcct = creditGlo.code
           tboCr.creditAmt = tf.txnAmt
           
           tboDr.save(flush:true, failOnError: true)
           tboCr.save(flush:true, failOnError: true)
           
           //tb.save(flush:true, failOnError: true)
           println 'saved!'
        
    }
    
    def checksToCoci(TxnFile tf, TxnTemplate tmp, Integer fy) {
           def tbDr = new TxnBreakdown(currency:tf.currency, txnDate:tf.txnDate, txnFile:tf, user:tf.user, branch:tf.branch)
           def tbCr = new TxnBreakdown(currency:tf.currency, txnDate:tf.txnDate, txnFile:tf, user:tf.user, branch:tf.branch)          
            
           //def userCash = tf.user
           def debitGl
           def creditGl
 
           debitGl =  GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60200').paramValue,tf.branch, fy)
           creditGl = tf.user.coci                 
           
           tbDr.debitAcct = debitGl.code
           tbCr.creditAcct = creditGl.code
           tbDr.debitAmt = tf.txnAmt
           tbCr.creditAmt = tf.txnAmt
           if (!creditGl){
               tbCr.creditAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }
           if (!debitGl){
               tbDr.debitAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }           
           tbDr.save(flush:true, failOnError: true)
           tbCr.save(flush:true, failOnError: true)
        
    }
    
    def otherCashCheckReceived(TxnFile tf, TxnTemplate tmp, Integer fy) {
           def tbDr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)
           def tbCr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)
            
           def userCash = UserMaster.get(tf.user.id)
           def debitGl
           
           if (tmp.txnType.id == 20) {
             debitGl =  GlAccount.get(userCash.coci.id)  
           } else {
             debitGl =  GlAccount.get(userCash.cash.id)  
           }
                         
           tbDr.debitAcct = debitGl.code
           tbDr.debitAmt = tf.txnAmt
                      
           def creditGl = GlAccount.findByCodeAndBranchAndFinancialYear(tmp.defContraAcct,tf.branch, fy)
           
           tbCr.creditAcct = creditGl.code
           tbCr.creditAmt = tf.txnAmt
           if (!creditGl){
               tbCr.creditAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }
           if (!debitGl){
               tbDr.debitAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }          
           tbDr.save(flush:true, failOnError: true)
           tbCr.save(flush:true, failOnError: true)        
    }
    
    def otherCashPayment(TxnFile tf, TxnTemplate tmp, Integer fy) {
           def tbDr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)
           def tbCr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)
           
           def userCash = UserMaster.get(tf.user.id)
           
           def debitGl =  GlAccount.findByCodeAndBranchAndFinancialYear(tmp.defContraAcct,tf.branch, fy)
                         
           tbDr.debitAcct = debitGl.code
           tbDr.debitAmt = tf.txnAmt
                      
           def creditGl = GlAccount.get(userCash.cash.id)
           
           tbCr.creditAcct = creditGl.code
           tbCr.creditAmt = tf.txnAmt
           if (!creditGl){
               tbCr.creditAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }
           if (!debitGl){
               tbDr.debitAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }           
           tbDr.save(flush:true, failOnError:true)
           tbCr.save(flush:true, failOnError:true)
           println 'saved!'        
    }
    def getGlErrorAccount() {
        def errorGl = GlAccount.findByCode(Institution.findByParamCode('GLS.60070').paramValue)
        return errorGl
    }
    
    def cashDeposit(TxnFile tf, TxnTemplate tmp, Integer fy) {
           def tbDr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)
           def tbCr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)

           def userCash = UserMaster.get(tf.user.id)
           def debitGl
           def deposit = tf.depAcct
           def depStatus = deposit.status.id
                if (deposit.status.id == 3) {
                    depStatus = 2
                }           
           if (tmp.txnType.id == 3) {
             debitGl =  GlAccount.get(userCash.cash.id) 
           } else {
             debitGl =  GlAccount.get(userCash.coci.id) 
           }
          
           tbDr.debitAcct = debitGl.code
           tbDr.debitAmt = tf.txnAmt
           
           def creditGlPtr
           def creditGl

           if (tmp.interbranchTxn.id == 1) {
               creditGl = GlAccount.findByCodeAndBranchAndFinancialYear(tf.branch.dueToGl.code,tf.branch, fy)
           }  else {
               creditGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '0', depStatus)
               if (!creditGlPtr) {
                   creditGlPtr
               }
               creditGl = GlAccount.findByCodeAndBranchAndFinancialYear(creditGlPtr.glCode,tf.branch, fy)
           }
           tbCr.creditAcct = creditGl.code
           tbCr.creditAmt = tf.txnAmt
           if (!creditGl){
               tbCr.creditAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }
           if (!debitGl){
               tbDr.debitAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }           
           tbDr.save(flush:true, failOnError: true)
           tbCr.save(flush:true, failOnError: true)
           
           if (tmp.interbranchTxn.id == 1) {
               def drTbi = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, branch:deposit.branch, user:UserMaster.get(tf.user.id))
               def crTbi = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, branch:deposit.branch, user:UserMaster.get(tf.user.id))
               
               def tbiDr = GlAccount.findByCodeAndBranchAndFinancialYear(deposit.branch.dueFromGl.code,deposit.branch, fy)
               drTbi.debitAcct = tbiDr.code
               drTbi.debitAmt = tf.txnAmt
               drTbi.save(flush:true)
               
                println deposit.glLink.id
                println deposit.status.id
               def tbiCrPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '0', depStatus)
               println "tbiCrPtr  ?? "+tbiCrPtr 
               def tbiCr = GlAccount.findByCodeAndBranchAndFinancialYear(tbiCrPtr.glCode,tf.branch, fy)               
               crTbi.creditAcct = tbiCr.code
               crTbi.creditAmt = tf.txnAmt
               crTbi.save(flush:true)
           }           
    }

    def cashWdl(TxnFile tf, TxnTemplate tmp, Integer fy) {
           def tbDr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)
           def tbCr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)          
           
           def userCash = UserMaster.get(tf.user.id)
           def deposit = tf.depAcct
           def depStatus = deposit.status.id
                if (deposit.status.id == 3) {
                    depStatus = 2
                }            
           def creditGl   
           if (tmp.atmOnlyTxn.id == 1) {
                creditGl =  GlAccount.get(userCash.cash.id)  // should be cash-in-atm
           } else {
                creditGl =  GlAccount.get(userCash.cash.id)                 
           }
           tbCr.creditAcct = creditGl.code
           tbCr.creditAmt = tf.txnAmt
           
           def debitGlPtr
           def debitGl
           if (tmp.interbranchTxn.id == 1) {
               debitGl = GlAccount.findByCodeAndBranchAndFinancialYear(deposit.branch.dueFromGl.code,tf.branch, fy)
           }  else {
               if (depStatus == 7) {
                   // for closed accounts force status to active
                   depStatus = 2
               }               
               debitGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '0', depStatus)
               debitGl = GlAccount.findByCodeAndBranchAndFinancialYear(debitGlPtr.glCode,tf.branch, fy)
           }        
           tbDr.debitAcct = debitGl.code
           tbDr.debitAmt = tf.txnAmt            

           if (!creditGl){
               tbCr.creditAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }
           if (!debitGl){
               tbDr.debitAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }           
           tbDr.save(flush:true, failOnError: true)
           tbCr.save(flush:true, failOnError: true)
           
           if (tmp.interbranchTxn.id == 1) {
               def drTbi = new TxnBreakdown(branch:deposit.branch, user:UserMaster.get(tf.user.id), currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf)
               def crTbi = new TxnBreakdown(branch:deposit.branch, user:UserMaster.get(tf.user.id), currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf)
               if (depStatus == 7) {
                   // for closed accounts force status to active
                   depStatus = 2
               }              
               def tbiDrPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '0', depStatus)
               def tbiDr = GlAccount.findByCodeAndBranchAndFinancialYear(tbiDrPtr.glCode,deposit.branch,fy)

               drTbi.debitAcct = tbiDr.code
               drTbi.debitAmt = tf.txnAmt
               drTbi.save(flush:true)
               
               def tbiCr = GlAccount.findByCodeAndBranchAndFinancialYear(deposit.branch.dueToGl.code,deposit.branch, fy)
               crTbi.creditAcct = tbiCr.code
               crTbi.creditAmt = tf.txnAmt
               crTbi.save(flush:true)               
           }         
    }
    def atmCashWdl(TxnFile tf, TxnTemplate tmp, Integer fy) {
        def tbDr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)
        def tbCr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)          
           
        def onUs = true
        def userCash = UserMaster.get(tf.user.id)
        def deposit = tf.depAcct
        def depStatus = deposit.status.id
            if (deposit.status.id == 3) {
                depStatus = 2
            }            
           
        def debitGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '0', depStatus)
        def debitGl = GlAccount.findByCodeAndBranchAndFinancialYear(debitGlPtr.glCode,tf.branch, fy)
        
        def atmTxnInstance = AtmTxn.findByTxnFile1(tf.id)
        def creditGl
        if (atmTxnInstance.atmTerminal) {
            def atmTerminal = AtmTerminalMapping.findByTerminalCode(atmTxnInstance.atmTerminal)
            if (atmTerminal) {
                if (atmTerminal.branch == tf.branch) {
                    // onus transaction                   
                    tbDr.debitAcct = debitGl.code
                    tbDr.debitAmt = tf.txnAmt 
                    
                    creditGl =  GlAccount.get(userCash.cash.id)
                    tbCr.creditAcct = creditGl.code
                    tbCr.creditAmt = tf.txnAmt
            
                    tbDr.save(flush:true, failOnError: true)
                    tbCr.save(flush:true, failOnError: true)                
                } else {
                    // other branch transaction
                    tbDr.debitAcct = debitGl.code
                    tbDr.debitAmt = tf.txnAmt
                    creditGl =  tf.branch.dueToGl
                    tbCr.creditAcct = creditGl.code
                    tbCr.creditAmt = tf.txnAmt
                    
                    tbDr.save(flush:true, failOnError: true)
                    tbCr.save(flush:true, failOnError: true) 
                    
                    def tbDrIbt = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:atmTerminal.branch)
                    def tbCrIbt = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:atmTerminal.branch)          
                    tbDrIbt.debitAcct = atmTerminal.branch.dueFromGl.code
                    tbDrIbt.debitAmt = tf.txnAmt
                    creditGlIbt = GlAccount.get(userCash.cash.id) 
                    tbCrIbt.creditAcct = creditGlIbt.code
                    tbCrIbt.creditAmt = tf.txnAmt
                    
                    tbDrIbt.save(flush:true, failOnError: true)
                    tbDrIbt.save(flush:true, failOnError: true)                    
                    
                }
            } else {
                // undefined terminal, default to bancnet  
                creditGl =  GlAccount.get(Institution.findByParamCode('DEP.40140').paramValue.toInteger())
                tbDr.debitAcct = debitGl.code
                tbDr.debitAmt = tf.txnAmt 
            
                tbCr.creditAcct = creditGl.code
                tbCr.creditAmt = tf.txnAmt
            
                tbDr.save(flush:true, failOnError: true)
                tbCr.save(flush:true, failOnError: true)
            }
        } else {
            // no terminal, so issuer transaction
            creditGl =  GlAccount.get(Institution.findByParamCode('DEP.40140').paramValue.toInteger())
            tbDr.debitAcct = debitGl.code
            tbDr.debitAmt = tf.txnAmt 
            
            tbCr.creditAcct = creditGl.code
            tbCr.creditAmt = tf.txnAmt
            
            tbDr.save(flush:true, failOnError: true)
            tbCr.save(flush:true, failOnError: true)
        }
    }
    def saveDepositFundTransferGl(Long ftId){
        
        def ft = TxnDepositFundTransfer.get(ftId)
        def tf1 = ft.drTxn
        def fy = tf1.txnDate.format('yyyy').toInteger()
        
        // memo debit
        def tbDr = new TxnBreakdown(currency:Currency.get(tf1.currency.id), txnDate:tf1.txnDate, txnFile:tf1, user:UserMaster.get(tf1.user.id), branch:tf1.branch)
        def tbCr = new TxnBreakdown(currency:Currency.get(tf1.currency.id), txnDate:tf1.txnDate, txnFile:tf1, user:UserMaster.get(tf1.user.id), branch:tf1.branch)          
           
        def deposit = tf1.depAcct
        def depStatus = deposit.status.id
            if (deposit.status.id == 3) {
                depStatus = 2
            }            
        def creditGl
        if (ft.txnTemplate.interbranchTxn.id == 1) {
            creditGl = GlAccount.findByCodeAndBranchAndFinancialYear(deposit.branch.dueFromGl,tf1.branch, fy)
        } else {
            creditGl =  GlAccount.findByCodeAndBranchAndFinancialYear(tf1.txnTemplate.defContraAcct,deposit.branch,fy) 
        }        
        tbCr.creditAcct = creditGl.code
        tbCr.creditAmt = tf1.txnAmt
           
        def debitGlPtr
        def debitGl
        if (depStatus == 7) {
            // for closed accounts force status to active
            depStatus = 2
        }               
        debitGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '0', depStatus)
        debitGl = GlAccount.findByCodeAndBranchAndFinancialYear(debitGlPtr.glCode,tf1.branch, fy)
                     
        tbDr.debitAcct = debitGl.code
        tbDr.debitAmt = tf1.txnAmt            

        if (!creditGl){
            tbCr.creditAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf1.branch, fy)
        }
        if (!debitGl){
            tbDr.debitAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf1.branch, fy)
        }           
        tbDr.save(flush:true, failOnError: true)
        tbCr.save(flush:true, failOnError: true)         

        // memo credit
        def tf2 = ft.crTxn
        def tbDr2 = new TxnBreakdown(currency:Currency.get(tf2.currency.id), txnDate:tf2.txnDate, txnFile:tf2, user:UserMaster.get(tf2.user.id), branch:tf2.branch)
        def tbCr2 = new TxnBreakdown(currency:Currency.get(tf2.currency.id), txnDate:tf2.txnDate, txnFile:tf2, user:UserMaster.get(tf2.user.id), branch:tf2.branch)

        def debitGl2
        def deposit2 = tf2.depAcct
        def depStatus2 = deposit2.status.id
        if (deposit2.status.id == 3) {
            depStatus2 = 2
        }             
         
        if (ft.txnTemplate.interbranchTxn.id == 1) {
            debitGl2 = GlAccount.findByCodeAndBranchAndFinancialYear(deposit2.branch.dueToGl.code,tf2.branch, fy)
        } else {
            debitGl2 =  GlAccount.findByCodeAndBranchAndFinancialYear(tf2.txnTemplate.defContraAcct, tf2.branch, fy)
        }       
        tbDr2.debitAcct = debitGl2.code
        tbDr2.debitAmt = tf2.txnAmt
           
        def creditGlPtr2
        def creditGl2
        creditGlPtr2 = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit2.glLink, '0', depStatus2)
        creditGl2 = GlAccount.findByCodeAndBranchAndFinancialYear(creditGlPtr2.glCode,tf2.branch, fy)      
            
        tbCr2.creditAcct = creditGl2.code
        tbCr2.creditAmt = tf2.txnAmt
        if (!creditGl2){
            tbCr2.creditAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf2.branch, fy)
        }
        if (!debitGl2){
            tbDr2.debitAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf2.branch, fy)
        }           
        tbDr2.save(flush:true, failOnError: true)
        tbCr2.save(flush:true, failOnError: true)
                   
    }
    def saveLoanTransferBranchEntry(LoanBranchTransfer loanTr){
        def tfDr = loanTr.loanDr
        def tfCr = loanTr.loanCr
        def fy = tfDr.txnDate.format('yyyy').toInteger()
        
        // loan payment/credit
        def tbDr = new TxnBreakdown(currency:Currency.get(tfCr.currency.id), txnDate:tfCr.txnDate, txnFile:tfCr, user:UserMaster.get(tfCr.user.id), branch:tfCr.branch)
        def tbCr = new TxnBreakdown(currency:Currency.get(tfCr.currency.id), txnDate:tfCr.txnDate, txnFile:tfCr, user:UserMaster.get(tfCr.user.id), branch:tfCr.branch)     
           
        def debitGl
        def loan = tfCr.loanAcct
        debitGl =  GlAccount.findByCodeAndFinancialYear(tfCr.branch.dueFromGl.code, fy) 
        
        tbDr.debitAcct = debitGl.code
        tbDr.debitAmt = tfCr.txnAmt
           
        def creditGl
        def creditGlPtr
        creditGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loan.glLink, '0', loan.loanPerformanceId.id)
        creditGl = GlAccount.findByCodeAndBranchAndFinancialYear(creditGlPtr.glCode,tfCr.branch, fy)
        
        tbCr.creditAcct = creditGl.code
        tbCr.creditAmt = tfCr.txnAmt
           
        if (!creditGl){
            tbCr.creditAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tfCr.branch, fy)
        }
        if (!debitGl){
            tbDr.debitAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tfCr.branch, fy)
        }           
        tbDr.save(flush:true, failOnError: true)
        tbCr.save(flush:true, failOnError: true)

        // transfer to new branch entries
        def tbDrNew = new TxnBreakdown(currency:Currency.get(tfDr.currency.id), txnDate:tfDr.txnDate, txnFile:tfDr, user:UserMaster.get(tfDr.user.id), branch:tfDr.branch)
        def tbCrNew = new TxnBreakdown(currency:Currency.get(tfDr.currency.id), txnDate:tfDr.txnDate, txnFile:tfDr, user:UserMaster.get(tfDr.user.id), branch:tfDr.branch)     
        
        def debitGlPtrNew = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loan.glLink, '0', loan.loanPerformanceId.id)
        def debitGlNew = GlAccount.findByCodeAndBranchAndFinancialYear(debitGlPtrNew.glCode,tfDr.branch, fy)
        tbDrNew.debitAcct = debitGlNew.code
        tbDrNew.debitAmt = tfDr.txnAmt
        
        def creditGlNew =  GlAccount.findByCodeAndFinancialYear(tfDr.branch.dueToGl.code, fy)
        tbCrNew.creditAcct = creditGlNew.code
        tbCrNew.creditAmt = tfDr.txnAmt
        
        if (!creditGlNew){
            tbCrNew.creditAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tfDr.branch, fy)
        }
        if (!debitGlNew){
            tbDrNew.debitAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tfDr.branch, fy)
        }           
        tbDrNew.save(flush:true, failOnError: true)
        tbCrNew.save(flush:true, failOnError: true)        
        
    }
    
    def saveTxnBreakdown (Long txnId){
        println("txnId: "+txnId)
       def tf = TxnFile.get(txnId)
       println("tf.txnCode: "+tf.txnCode)
       def tmp = TxnTemplate.findByCode(tf.txnCode)
       println("tmp: "+tmp)
       def fy = tf.txnDate.format('yyyy').toInteger()
       // atm transaction
       if (tmp.atmOnlyTxn.id == 1) {
           
           if (tmp.txnType.id == 5) {
               // cash withdrawal
               def posted = atmCashWdl(tf, tmp, fy) 
           } else {
               // other debit
           }
           return
       }
        // cash from vault and cash to vault
        if (tmp.txnType.id == 1 || tmp.txnType.id == 23){
            
           def posted = cashVaultTxn(tf, tmp, fy) 
            
        }
        // Teller Cash Transfer
        if (tmp.txnType.id == 2){
            if (tf.txnParticulars == 'Receive Cash Transfer') {
                def posted = tellerCashTransferReceive(tf, tmp, fy)
            } else {
                def posted = tellerCashTransfer(tf, tmp, fy)
            }
        }     
        // Checks to COCI
        if (tmp.txnType.id == 22){
            def posted = checksToCoci(tf, tmp, fy)
        }
        // other cash/other check receipt transactions
        if (tmp.txnType.id == 19 || tmp.txnType.id == 20){
            def posted = otherCashCheckReceived(tf, tmp, fy)
        }
        
         // other cash payment transactions
        if (tmp.txnType.id == 21){
            def posted = otherCashPayment(tf, tmp, fy)
        }
        
        // cash and check deposit
        if (tmp.txnType.id == 3 || tmp.txnType.id == 4){
            def posted = cashDeposit(tf, tmp, fy) 
        }     
        // memo credit
        if (tmp.txnType.id == 9){
           def tbDr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)
           def tbCr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)

           def userCash = UserMaster.get(tf.user.id)
           def debitGl
           def deposit = tf.depAcct
           def depStatus = deposit.status.id
                if (deposit.status.id == 3) {
                    depStatus = 2
                }             
           debitGl =  GlAccount.findByCodeAndBranchAndFinancialYear(tmp.defContraAcct, tf.branch, fy)  
              
           tbDr.debitAcct = debitGl.code
           tbDr.debitAmt = tf.txnAmt
           
           def creditGlPtr
           def creditGl
           if (tmp.interbranchTxn.id == 1) {
               creditGl = GlAccount.findByCodeAndBranchAndFinancialYear(deposit.branch.dueToGl.code,tf.branch, fy)
           }  else {
               creditGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '0', depStatus)
               creditGl = GlAccount.findByCodeAndBranchAndFinancialYear(creditGlPtr.glCode,tf.branch, fy)
           }        
            
           tbCr.creditAcct = creditGl.code
           tbCr.creditAmt = tf.txnAmt
           if (!creditGl){
               tbCr.creditAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }
           if (!debitGl){
               tbDr.debitAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }           
           tbDr.save(flush:true, failOnError: true)
           tbCr.save(flush:true, failOnError: true)
           
           if (tmp.interbranchTxn.id == 1) {
               def drTbi = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, branch:deposit.branch, user:UserMaster.get(tf.user.id))
               def crTbi = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, branch:deposit.branch, user:UserMaster.get(tf.user.id))
               
               def tbiDr = GlAccount.findByCodeAndBranchAndFinancialYear(deposit.branch.dueFromGl.code,deposit.branch, fy)
               drTbi.debitAcct = tbiDr.code
               drTbi.debitAmt = tf.txnAmt
               drTbi.save(flush:true)
               
               def tbiCrPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '0', depStatus)
               def tbiCr = GlAccount.findByCodeAndBranchAndFinancialYear(tbiCrPtr.glCode,tf.branch, fy)               
               crTbi.creditAcct = tbiCr.code
               crTbi.creditAmt = tf.txnAmt
               crTbi.save(flush:true)
           } 
        }     
        
        // cash withdrawal, check encashment, td int wdl and TD preterm
        if (tmp.txnType.id == 5 || tmp.txnType.id == 6 || tmp.txnType.id == 17 || tmp.txnType.id == 18){
             def posted = cashWdl(tf, tmp, fy)            
        }
        
        // memo debit
        if (tmp.txnType.id == 7 || tmp.txnType.id == 33){
           def tbDr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)
           def tbCr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)          
           
           def userCash = UserMaster.get(tf.user.id)
           def deposit = tf.depAcct
           def depStatus = deposit.status.id
                if (deposit.status.id == 3) {
                    depStatus = 2
                }            
           def creditGl   
           if (tmp.atmOnlyTxn.id == 1) {
                creditGl =  GlAccount.get(userCash.cash.id)  // should be cash-in-atm
           } else {
                creditGl =  GlAccount.findByCodeAndBranchAndFinancialYear(tmp.defContraAcct,deposit.branch,fy)                 
           }
           tbCr.creditAcct = creditGl.code
           tbCr.creditAmt = tf.txnAmt
           
           def debitGlPtr
           def debitGl
           if (tmp.interbranchTxn.id == 1) {
               debitGl = GlAccount.findByCodeAndBranchAndFinancialYear(deposit.branch.dueFromGl,tf.branch, fy)
           }  else {
               if (depStatus == 7) {
                   // for closed accounts force status to active
                   depStatus = 2
               }               
               debitGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '0', depStatus)
               debitGl = GlAccount.findByCodeAndBranchAndFinancialYear(debitGlPtr.glCode,tf.branch, fy)
           }        
           tbDr.debitAcct = debitGl.code
           tbDr.debitAmt = tf.txnAmt            

           if (!creditGl){
               tbCr.creditAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }
           if (!debitGl){
               tbDr.debitAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }           
           tbDr.save(flush:true, failOnError: true)
           tbCr.save(flush:true, failOnError: true)
           
           if (tmp.interbranchTxn.id == 1) {
               def drTbi = new TxnBreakdown(branch:deposit.branch, user:UserMaster.get(tf.user.id), currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf)
               def crTbi = new TxnBreakdown(branch:deposit.branch, user:UserMaster.get(tf.user.id), currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf)
               
               def tbiDrPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '0', depStatus)
               def tbiDr = GlAccount.findByCodeAndBranchAndFinancialYear(tbiDrPtr.glCode,deposit.branch,fy)

               drTbi.debitAcct = tbiDr.code
               drTbi.debitAmt = tf.txnAmt
               drTbi.save(flush:true)
               
               def tbiCr = GlAccount.findByCodeAndBranchAndFinancialYear(deposit.branch.dueToGl.code,deposit.branch, fy)
               crTbi.creditAcct = tbiCr.code
               crTbi.creditAmt = tf.txnAmt
               crTbi.save(flush:true)               
           }            
        }        
        // Loan cash and check regular payments and specified payments
        if (tmp.txnType.id == 12 || tmp.txnType.id == 13 || tmp.txnType.id == 14 || tmp.txnType.id == 15){
           def tbDr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)
           def tbCr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)     
           
           def userCash = UserMaster.get(tf.user.id)
           def debitGl
           def loan = tf.loanAcct
           
           if (tmp.txnType.id == 13 || tmp.txnType.id == 15) {
             debitGl =  GlAccount.get(userCash.coci.id)  
           } else {
             debitGl =  GlAccount.get(userCash.cash.id)  
           }
                         
           tbDr.debitAcct = debitGl.code
           tbDr.debitAmt = tf.txnAmt
           
           def creditGl
           def creditGlPtr
           def lnPay = TxnLoanPaymentDetails.findByTxnFile(tf) 
           if (tmp.interbranchTxn.id == 1) {
               creditGl = GlAccount.findByCodeAndBranchAndFinancialYear(loan.branch.dueToGl.code,tf.branch, fy)
               tbCr.creditAmt = tf.txnAmt
           }  else {
               creditGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loan.glLink, '0', loan.loanPerformanceId.id)
               creditGl = GlAccount.findByCodeAndBranchAndFinancialYear(creditGlPtr.glCode,tf.branch, fy)
               tbCr.creditAmt = lnPay.principalAmt
           }        
           
           tbCr.creditAcct = creditGl.code
           
           if (!creditGl){
               tbCr.creditAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }
           if (!debitGl){
               tbDr.debitAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }           
           tbDr.save(flush:true, failOnError: true)
           tbCr.save(flush:true, failOnError: true)
           
           if (tmp.interbranchTxn.id == 1) {
                // additional debit
                def tbDrItx = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:loan.branch)
                def  drGlItx = GlAccount.findByCodeAndBranchAndFinancialYear(loan.branch.dueFromGl.code,tf.branch, fy)
                tbDrItx.debitAcct = drGlItx.code
                tbDrItx.debitAmt = tf.txnAmt
                tbDrItx.save(flush:true)
                // credit to principal
                def tbCrPri = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:loan.branch)
  
                def crGlPriPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loan.glLink, '0', loan.loanPerformanceId.id)
                def crGlPri = GlAccount.findByCodeAndBranchAndFinancialYear(crGlPriPtr.glCode,loan.branch, fy)
                tbCrPri.creditAcct = crGlPri.code
                tbCrPri.creditAmt = lnPay.principalAmt
                tbCrPri.save(flush:true)                
           } 
           
           if (lnPay.interestAmt > 0) {
                def tbCrInt = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:loan.branch)
    
                def crGlIPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loan.glLink, '2', loan.loanPerformanceId.id)
                def crGlI = GlAccount.findByCodeAndBranchAndFinancialYear(crGlIPtr.glCode,loan.branch, fy)
                tbCrInt.creditAcct = crGlI.code
                tbCrInt.creditAmt = lnPay.interestAmt
                tbCrInt.save(flush:true)
            } 
           if (lnPay.penaltyAmt > 0) {
                def tbCrPen = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:loan.branch)   
                def crGlPenPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loan.glLink, '4', loan.loanPerformanceId.id)
                def crGlPen = GlAccount.findByCodeAndBranchAndFinancialYear(crGlPenPtr.glCode,loan.branch, fy)                
                tbCrPen.creditAcct = crGlPen.code
                tbCrPen.creditAmt = lnPay.penaltyAmt
                tbCrPen.save(flush:true)
            }       
           if (lnPay.serviceChargeAmt > 0) {
                def tbCrSc = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:loan.branch) 
                def crGlScPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loan.glLink, '6', loan.loanPerformanceId.id)
                def crGlSc = GlAccount.findByCodeAndBranchAndFinancialYear(crGlScPtr.glCode,loan.branch, fy)    
                tbCrSc.creditAcct = crGlSc.code
                tbCrSc.creditAmt = lnPay.serviceChargeAmt
                tbCrSc.save(flush:true)
            }                               
                     
        }      
        // loan memo payment / ROPA 
        if ((tmp.txnType.id == 16 || tmp.txnType.id == 38) && (tmp.memoTxnType.id == 4 || tmp.memoTxnType.id == 7 || tmp.memoTxnType.id == 10)){
           def tbDr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)
           def tbCr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)     
           
           def userCash = UserMaster.get(tf.user.id)
           def debitGl
           def loan = tf.loanAcct
           debitGl =  GlAccount.findByCodeAndFinancialYear(tmp.defContraAcct, fy) 
                         
           tbDr.debitAcct = debitGl.code
           tbDr.debitAmt = tf.txnAmt
           
           def creditGl
           def creditGlPtr
           def lnPay = TxnLoanPaymentDetails.findByTxnFile(tf) 
           if (tmp.interbranchTxn.id == 1) {
               creditGl = GlAccount.findByCodeAndBranchAndFinancialYear(loan.branch.dueToGl.code,tf.branch, fy)
               tbCr.creditAmt = tf.txnAmt
           }  else {
               creditGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loan.glLink, '0', loan.loanPerformanceId.id)
               creditGl = GlAccount.findByCodeAndBranchAndFinancialYear(creditGlPtr.glCode,tf.branch, fy)
               if (tmp.memoTxnType.id == 7) {
                   // memo credit so no payment record
                    tbCr.creditAmt = tf.txnAmt
               } else {
                    tbCr.creditAmt = lnPay.principalAmt
               }
               
           }        
           
           tbCr.creditAcct = creditGl.code
           
           if (!creditGl){
               tbCr.creditAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }
           if (!debitGl){
               tbDr.debitAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }           
           tbDr.save(flush:true, failOnError: true)
           tbCr.save(flush:true, failOnError: true)
           if (tmp.interbranchTxn.id == 1) {
                // additional debit
                def tbDrItx = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:loan.branch)
                def  drGlItx = GlAccount.findByCodeAndBranchAndFinancialYear(loan.branch.dueFromGl.code,tf.branch, fy)
                tbDrItx.debitAcct = drGlItx.code
                tbDrItx.debitAmt = tf.txnAmt
                
                // credit to principal
                def tbCrPri = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:loan.branch)
  
                def crGlPriPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loan.glLink, '0', loan.loanPerformanceId.id)
                def crGlPri = GlAccount.findByCodeAndBranchAndFinancialYear(crGlPriPtr.glCode,loan.branch, fy)
                tbCrPri.creditAcct = crGlPri.code
                tbCrPri.creditAmt = lnPay.principalAmt
                tbCrPri.save(flush:true)                
           } 
           // post interest and penalties
           if (tmp.memoTxnType.id == 4) {
            if (lnPay.interestAmt > 0) {
                def tbCrInt = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:loan.branch)
    
                def crGlIPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loan.glLink, '2', loan.loanPerformanceId.id)
                def crGlI = GlAccount.findByCodeAndBranchAndFinancialYear(crGlIPtr.glCode,loan.branch, fy)
                tbCrInt.creditAcct = crGlI.code
                tbCrInt.creditAmt = lnPay.interestAmt
                tbCrInt.save(flush:true)
            } 
            if (lnPay.penaltyAmt > 0) {
                def tbCrPen = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:loan.branch)   
                def crGlPenPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loan.glLink, '4', loan.loanPerformanceId.id)
                def crGlPen = GlAccount.findByCodeAndBranchAndFinancialYear(crGlPenPtr.glCode,loan.branch, fy)                
                tbCrPen.creditAcct = crGlPen.code
                tbCrPen.creditAmt = lnPay.penaltyAmt
                tbCrPen.save(flush:true)
            }       
            if (lnPay.serviceChargeAmt > 0) {
                def tbCrSc = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:loan.branch) 
                def crGlScPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loan.glLink, '6', loan.loanPerformanceId.id)
                def crGlSc = GlAccount.findByCodeAndBranchAndFinancialYear(crGlScPtr.glCode,loan.branch, fy)    
                tbCrSc.creditAcct = crGlSc.code
                tbCrSc.creditAmt = lnPay.serviceChargeAmt
                tbCrSc.save(flush:true)
            }                               
           }
        }         
        // loan write-off 
        if (tmp.txnType.id == 35){
           def tbDr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)
           def tbCr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)     
           
           def userCash = UserMaster.get(tf.user.id)
           def debitGl
           def loan = tf.loanAcct
           debitGl =  GlAccount.findByCodeAndFinancialYear(tmp.defContraAcct, fy) 
                         
           tbDr.debitAcct = debitGl.code
           tbDr.debitAmt = tf.txnAmt
           
           def creditGl
           def creditGlPtr
           def lnPay = TxnLoanPaymentDetails.findByTxnFile(tf) 
           if (tmp.interbranchTxn.id == 1) {
               creditGl = GlAccount.findByCodeAndBranchAndFinancialYear(loan.branch.dueToGl.code,tf.branch, fy)
               tbCr.creditAmt = tf.txnAmt
           }  else {
               creditGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loan.glLink, '0', loan.loanPerformanceId.id)
               creditGl = GlAccount.findByCodeAndBranchAndFinancialYear(creditGlPtr.glCode,tf.branch, fy)
               tbCr.creditAmt = lnPay.principalAmt
           }        
           
           tbCr.creditAcct = creditGl.code
           
           if (!creditGl){
               tbCr.creditAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }
           if (!debitGl){
               tbDr.debitAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }           
           tbDr.save(flush:true, failOnError: true)
           tbCr.save(flush:true, failOnError: true)
           
           if (tmp.interbranchTxn.id == 1) {
                // additional debit
                def tbDrItx = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:loan.branch)
                def  drGlItx = GlAccount.findByCodeAndBranchAndFinancialYear(loan.branch.dueFromGl.code,tf.branch, fy)
                tbDrItx.debitAcct = drGlItx.code
                tbDrItx.debitAmt = tf.txnAmt
                
                // credit to principal
                def tbCrPri = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:loan.branch)
  
                def crGlPriPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loan.glLink, '0', loan.loanPerformanceId.id)
                def crGlPri = GlAccount.findByCodeAndBranchAndFinancialYear(crGlPriPtr.glCode,loan.branch, fy)
                tbCrPri.creditAcct = crGlPri.code
                tbCrPri.creditAmt = lnPay.principalAmt
                tbCrPri.save(flush:true)                
           } 
           
           if (lnPay.interestAmt > 0) {
                def tbCrInt = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:loan.branch)
    
                def crGlIPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loan.glLink, '2', loan.loanPerformanceId.id)
                def crGlI = GlAccount.findByCodeAndBranchAndFinancialYear(crGlIPtr.glCode,loan.branch, fy)
                tbCrInt.creditAcct = crGlI.code
                tbCrInt.creditAmt = lnPay.interestAmt
                tbCrInt.save(flush:true)
            } 
           if (lnPay.penaltyAmt > 0) {
                def tbCrPen = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:loan.branch)   
                def crGlPenPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loan.glLink, '4', loan.loanPerformanceId.id)
                def crGlPen = GlAccount.findByCodeAndBranchAndFinancialYear(crGlPenPtr.glCode,loan.branch, fy)                
                tbCrPen.creditAcct = crGlPen.code
                tbCrPen.creditAmt = lnPay.penaltyAmt
                tbCrPen.save(flush:true)
            }       
           if (lnPay.serviceChargeAmt > 0) {
                def tbCrSc = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:loan.branch) 
                def crGlScPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loan.glLink, '6', loan.loanPerformanceId.id)
                def crGlSc = GlAccount.findByCodeAndBranchAndFinancialYear(crGlScPtr.glCode,loan.branch, fy)    
                tbCrSc.creditAcct = crGlSc.code
                tbCrSc.creditAmt = lnPay.serviceChargeAmt
                tbCrSc.save(flush:true)
            }                               
                    
        }         
        // loan proceeds disbursement
        if (tmp.txnType.id == 11){
           def tbDr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)
           def tbCr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)

           def userCash = UserMaster.get(tf.user.id)
           def loan = tf.loanAcct
           
           def creditGl = GlAccount.get(userCash.cash.id) 
           tbCr.creditAcct = creditGl.code
           tbCr.creditAmt = tf.txnAmt
           
           def debitGl   
           def debitGlPtr
           if (tmp.interbranchTxn.id == 1) {
               debitGl = GlAccount.findByCodeAndBranchAndFinancialYear(tf.branch.dueFromGl.code,tf.branch, fy)
           }  else {
               debitGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loan.glLink, '0', loan.loanPerformanceId.id)
               debitGl = GlAccount.findByCodeAndBranchAndFinancialYear(debitGlPtr.glCode,tf.branch, fy)
           }        
           tbDr.debitAcct = debitGl.code
           tbDr.debitAmt = tf.txnAmt            

           if (!creditGl){
               tbCr.creditAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }
           if (!debitGl){
               tbDr.debitAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }           
           tbDr.save(flush:true, failOnError: true)
           tbCr.save(flush:true, failOnError: true)
           
           if (tmp.interbranchTxn.id == 1) {
               def drTbi = new TxnBreakdown(branch:loan.branch, user:UserMaster.get(tf.user.id), currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf)
               def crTbi = new TxnBreakdown(branch:loan.branch, user:UserMaster.get(tf.user.id), currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf)
               
               def tbiDrPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loan.glLink, '0', loan.loanPerformanceId.id)
               def tbiDr = GlAccount.findByCodeAndBranchAndFinancialYear(tbiDrPtr.glCode,tf.branch, fy)
             
               drTbi.debitAcct = tbiDr.code
               drTbi.debitAmt = tf.txnAmt
               drTbi.save(flush:true)
               
               def tbiCr = GlAccount.findByCodeAndBranchAndFinancialYear(loan.branch.dueToGl.code,loan.branch, fy)
               crTbi.creditAcct = tbiCr.code
               crTbi.creditAmt = tf.txnAmt
               crTbi.save(flush:true)               
           }            
        }        
        // loan proceeds disbursement
        if (tmp.txnType.id == 16 && tmp.memoTxnType.id == 5){
           def tbDr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)
           def tbCr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)

           def loan = tf.loanAcct
           
           def creditGl = GlAccount.findByCodeAndFinancialYear(tmp.defContraAcct, fy)
           tbCr.creditAcct = creditGl.code
           tbCr.creditAmt = tf.txnAmt
           
           def debitGl   
           def debitGlPtr
           if (tmp.interbranchTxn.id == 1) {
               debitGl = GlAccount.findByCodeAndBranchAndFinancialYear(tf.branch.dueFromGl.code,tf.branch, fy)
           }  else {
               debitGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loan.glLink, '0', loan.loanPerformanceId.id)
               debitGl = GlAccount.findByCodeAndBranchAndFinancialYear(debitGlPtr.glCode,tf.branch, fy)
           }        
           tbDr.debitAcct = debitGl.code
           tbDr.debitAmt = tf.txnAmt            

           if (!creditGl){
               tbCr.creditAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }
           if (!debitGl){
               tbDr.debitAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }           
           tbDr.save(flush:true, failOnError: true)
           tbCr.save(flush:true, failOnError: true)
           
           if (tmp.interbranchTxn.id == 1) {
               def drTbi = new TxnBreakdown(branch:loan.branch, user:UserMaster.get(tf.user.id), currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf)
               def crTbi = new TxnBreakdown(branch:loan.branch, user:UserMaster.get(tf.user.id), currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf)
               
               def tbiDrPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loan.glLink, '0', loan.loanPerformanceId.id)
               def tbiDr = GlAccount.findByCodeAndBranchAndFinancialYear(tbiDrPtr.glCode,tf.branch, fy)
             
               drTbi.debitAcct = tbiDr.code
               drTbi.debitAmt = tf.txnAmt
               drTbi.save(flush:true)
               
               def tbiCr = GlAccount.findByCodeAndBranchAndFinancialYear(loan.branch.dueToGl.code,loan.branch, fy)
               crTbi.creditAcct = tbiCr.code
               crTbi.creditAmt = tf.txnAmt
               crTbi.save(flush:true)               
           }            
        }  
        // loan memo debit to principal
        if (tmp.txnType.id == 16 && tmp.memoTxnType.id == 6){
           def tbDr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)
           def tbCr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)

           def loan = tf.loanAcct
           
           def creditGl = GlAccount.findByCodeAndFinancialYear(tmp.defContraAcct, fy)
           tbCr.creditAcct = creditGl.code
           tbCr.creditAmt = tf.txnAmt
           
           def debitGl   
           def debitGlPtr
           if (tmp.interbranchTxn.id == 1) {
               debitGl = GlAccount.findByCodeAndBranchAndFinancialYear(tf.branch.dueFromGl.code,tf.branch, fy)
           }  else {
               debitGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loan.glLink, '0', loan.loanPerformanceId.id)
               debitGl = GlAccount.findByCodeAndBranchAndFinancialYear(debitGlPtr.glCode,tf.branch, fy)
           }        
           tbDr.debitAcct = debitGl.code
           tbDr.debitAmt = tf.txnAmt            

           if (!creditGl){
               tbCr.creditAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }
           if (!debitGl){
               tbDr.debitAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }           
           tbDr.save(flush:true, failOnError: true)
           tbCr.save(flush:true, failOnError: true)
           
           if (tmp.interbranchTxn.id == 1) {
               def drTbi = new TxnBreakdown(branch:loan.branch, user:UserMaster.get(tf.user.id), currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf)
               def crTbi = new TxnBreakdown(branch:loan.branch, user:UserMaster.get(tf.user.id), currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf)
               
               def tbiDrPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loan.glLink, '0', loan.loanPerformanceId.id)
               def tbiDr = GlAccount.findByCodeAndBranchAndFinancialYear(tbiDrPtr.glCode,tf.branch, fy)
             
               drTbi.debitAcct = tbiDr.code
               drTbi.debitAmt = tf.txnAmt
               drTbi.save(flush:true)
               
               def tbiCr = GlAccount.findByCodeAndBranchAndFinancialYear(loan.branch.dueToGl.code,loan.branch, fy)
               crTbi.creditAcct = tbiCr.code
               crTbi.creditAmt = tf.txnAmt
               crTbi.save(flush:true)               
           }            
        }        
        // loan deductions processing
        if (tmp.txnType.id == 29){
           def tbDr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.loanAcct.branch)
           
           def loan = tf.loanAcct
           def debitGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loan.glLink, '0', loan.loanPerformanceId.id)
           def debitGl = GlAccount.findByCodeAndBranchAndFinancialYear(debitGlPtr.glCode,tf.loanAcct.branch, fy)   
           
           tbDr.debitAcct = debitGl.code
           tbDr.debitAmt = tf.txnAmt           
           if (!debitGl){
               tbDr.debitAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.loanAcct.branch, fy)
           }  
           tbDr.save(flush:true, failOnError: true)
           
           def tbCr
           def creditGl
           def creditCode
           def dedns = loan.loanDeductions.toList()
           for (ded in dedns) {
               tbCr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:loan.branch) 
               creditCode = ded.scheme.contraAcct
               creditGl = GlAccount.findByCodeAndBranchAndFinancialYear(creditCode.code,tf.branch, fy)
               tbCr.creditAcct = creditGl.code
               tbCr.creditAmt = ded.amount 
               tbCr.save(flush:true, failOnError: true)
           }    
           if (loan.advInterest > 0) {               
               tbCr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:loan.branch) 
               def advIntPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loan.glLink, '9', loan.loanPerformanceId.id)
               def AdvIntCr = GlAccount.findByCodeAndBranchAndFinancialYear(advIntPtr.glCode,tf.branch, fy)               
               tbCr.creditAcct = AdvIntCr.code
               tbCr.creditAmt = loan.advInterest
               tbCr.save(flush:true, failOnError: true)               
           }
        }   
        // deposit interest posting from FD
        if (tmp.txnType.id == 31 && tf.txnDescription=="Interest Credit from FD") {
           def tbDr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)
           def tbCr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)           
           
           def deposit = tf.depAcct
           def fd = Deposit.findByAcctNo(tf.txnRef)
           def depStatus = deposit.status.id
                if (deposit.status.id == 3) {
                    depStatus = 2
                }     
                
           //def debitGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(fd.glLink, '0', fd.status.id)
           def debitGlPtr = TxnTemplate.get(Institution.findByParamCode('DEP.40122').paramValue.toInteger())
           
           if (!debitGlPtr) {
               debitGlPtr = getGlErrorAccount
           }
           def debitGl = GlAccount.findByCodeAndBranchAndFinancialYearAndCurrency(debitGlPtr.defContraAcct,tf.branch, fy,fd.product.currency)
           tbDr.debitAmt = tf.txnAmt
           tbDr.debitAcct = debitGl.code           
           tbDr.save(flush:true)   
               
           def creditGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '0', depStatus)
           if (!creditGlPtr) {
              creditGlPtr = getGlErrorAccount 
           }
           def creditGl = GlAccount.findByCodeAndBranchAndFinancialYearAndCurrency(creditGlPtr.glCode,tf.branch, fy, deposit.product.currency)    
            
           tbCr.creditAcct = creditGl.code
           tbCr.creditAmt = tf.txnAmt
           if (!creditGl){
               tbCr.creditAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }

           tbCr.save(flush:true, failOnError: true)
        }
        
        // deposit interest posting
        if (tmp.txnType.id == 31 && tf.txnDescription != "Interest Credit from FD"){
           def tbDr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)
           def tbCr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)           
           
           def deposit = tf.depAcct
           def depStatus = deposit.status.id
                if (deposit.status.id == 3 || deposit.status.id == 7) {
                    depStatus = 2
                }            
           deposit.depositInterestScheme.attach()     
           if ((deposit.accruedIntPayable > 0) && (deposit.depositInterestScheme.depositCapitalizationFreq.id != 1)) {
               // debit AIP for accrued amount during EOM
               def debitGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '1', depStatus)
                if (!debitGlPtr) {
                    debitGlPtr = getGlErrorAccount
                }

               def debitGl = GlAccount.findByCodeAndBranchAndFinancialYear(debitGlPtr.glCode,tf.branch, fy) 
               tbDr.debitAmt = deposit.accruedIntPayable
               tbDr.debitAcct = debitGl.code           
               tbDr.save(flush:true)
               
               // credit interest expense for accrued amount during EOM 
               def tbCrExp = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)             
               def intExpCrGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '2', depStatus)
                if (!intExpCrGlPtr) {
                    intExpCrGlPtr = getGlErrorAccount 
                }               
               def intExpCrGl = GlAccount.findByCodeAndBranchAndFinancialYear(intExpCrGlPtr.glCode,tf.branch, fy) 
               tbCrExp.creditAcct = intExpCrGl.code
               tbCrExp.creditAmt = deposit.accruedIntPayable
               tbCrExp.save(flush:true)
               
                // debit interest expense for full amount
               def tbDrExp = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)             
               def intExpGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '2', depStatus)
                if (!intExpGlPtr) {
                    intExpGlPtr = getGlErrorAccount 
                }               
               def intExpGl = GlAccount.findByCodeAndBranchAndFinancialYear(intExpGlPtr.glCode,tf.branch, fy) 
               tbDrExp.debitAcct = intExpGl.code
               tbDrExp.debitAmt = tf.txnAmt
               tbDrExp.save(flush:true)
           } else {
               // debit interest expense full amount
               def debitGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '2', depStatus)
                if (!debitGlPtr) {
                    debitGlPtr = getGlErrorAccount
                }               
               def debitGl = GlAccount.findByCodeAndBranchAndFinancialYear(debitGlPtr.glCode,tf.branch, fy)
               tbDr.debitAmt = tf.txnAmt
               tbDr.debitAcct = debitGl.code           
               tbDr.save(flush:true)              
           }
           // credit deposit liab for full amount
           def creditGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '0', depStatus)
                if (!creditGlPtr) {
                    creditGlPtr = getGlErrorAccount
                }            
           def creditGl = GlAccount.findByCodeAndBranchAndFinancialYear(creditGlPtr.glCode,tf.branch, fy)    
            
           tbCr.creditAcct = creditGl.code
           tbCr.creditAmt = tf.txnAmt
           if (!creditGl){
               tbCr.creditAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }

           tbCr.save(flush:true, failOnError: true)         
        }     
        // withholding tax
        if (tmp.txnType.id == 32){
           def tbDr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)
           def tbCr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)           
           
           def deposit = tf.depAcct
           def depStatus = deposit.status.id
                if (deposit.status.id == 3 || deposit.status.id == 7) {
                    depStatus = 2
                }            
           def debitGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '0', depStatus)
           def debitGl = GlAccount.findByCodeAndBranchAndFinancialYear(debitGlPtr.glCode,tf.branch, fy)                
           tbDr.debitAcct = debitGl.code
           tbDr.debitAmt = tf.txnAmt
           if (!debitGl){
               tbDr.debitAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
           }

           tbDr.save(flush:true, failOnError: true)
           
           if (deposit.accruedTaxPayable > 0) {
               // credit withholding tax full amount
               def creditGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '3', depStatus)
               def creditGl = GlAccount.findByCodeAndBranchAndFinancialYear(creditGlPtr.glCode,tf.branch, fy) 
               tbCr.creditAmt = tf.txnAmt
               tbCr.creditAcct = creditGl.code           
               tbCr.save(flush:true)
               
               //  debit withholding tax for accrued amount during EOM
               def tbDrExp = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)             
               def intExpGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '3', depStatus)
               def intExpGl = GlAccount.findByCodeAndBranchAndFinancialYear(intExpGlPtr.glCode,tf.branch, fy) 
               tbDrExp.debitAcct = intExpGl.code
               tbDrExp.debitAmt = deposit.accruedTaxPayable
               tbDrExp.save(flush:true)
               
               // credit AIP for accrued amount during EOM
               def tbCrExp = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)             
               def intExpCrGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '1', depStatus)
               def intExpCrGl = GlAccount.findByCodeAndBranchAndFinancialYear(intExpCrGlPtr.glCode,tf.branch, fy) 
               tbCrExp.creditAcct = intExpCrGl.code
               tbCrExp.creditAmt = deposit.accruedTaxPayable
               tbCrExp.save(flush:true)
            } else {
                // credit tax for full amount
               def creditGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '3', depStatus)
               def creditGl = GlAccount.findByCodeAndBranchAndFinancialYear(creditGlPtr.glCode,tf.branch, fy)
               tbCr.creditAmt = tf.txnAmt
               tbCr.creditAcct = creditGl.code           
               tbCr.save(flush:true)              
           }           
        }     
        // account reclass (active/dormant)
        if (tmp.txnType.id == 30) {
            if (tf.depAcct) {
                def tbDr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch, debitAmt:tf.txnAmt)
                def tbCr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch, creditAmt:tf.txnAmt)
                
                def deposit = tf.depAcct
                if (deposit.status == DepositStatus.get(3)) {
                    // debit dormant credit current
                    println 'debit dormant credit current'
                    def debitGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '0', '5')
                    def debitGl = GlAccount.findByCodeAndBranchAndFinancialYearAndCurrency(debitGlPtr.glCode,deposit.branch, fy, deposit.product.currency)
                    def creditGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '0', '2')
                    def creditGl = GlAccount.findByCodeAndBranchAndFinancialYearAndCurrency(creditGlPtr.glCode,deposit.branch, fy, deposit.product.currency)
                    tbDr.debitAcct = debitGl.code
                    tbCr.creditAcct = creditGl.code
                } else {
                    println 'debit current credit dormant'
                    def debitGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '0', '2')
                    def debitGl = GlAccount.findByCodeAndBranchAndFinancialYearAndCurrency(debitGlPtr.glCode,deposit.branch, fy, deposit.product.currency)
                    def creditGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '0', '5')
                    def creditGl = GlAccount.findByCodeAndBranchAndFinancialYearAndCurrency(creditGlPtr.glCode,deposit.branch, fy, deposit.product.currency)                
                    tbDr.debitAcct = debitGl.code
                    tbCr.creditAcct = creditGl.code
                }

                tbDr.save(flush:true)
                tbCr.save(flush:true)
                
            } else {
                // loan reclass
                def tbDr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch, debitAmt:tf.txnAmt)
                def tbCr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch, creditAmt:tf.txnAmt)
                
                def loan = tf.loanAcct
                def rc = LoanReClassHist.findByTxnFile(tf)
                
                if (rc) {
                    def debitGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loan.glLink, '0', rc.newClass.id)
                    def debitGl = GlAccount.findByCodeAndBranchAndFinancialYearAndCurrency(debitGlPtr.glCode,loan.branch, fy, loan.product.currency)
                    def creditGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loan.glLink, '0', rc.oldClass.id)
                    def creditGl = GlAccount.findByCodeAndBranchAndFinancialYearAndCurrency(creditGlPtr.glCode,loan.branch, fy, loan.product.currency)   
                    
                    if (debitGl && creditGl) {
                        tbDr.debitAcct = debitGl.code
                        tbCr.creditAcct = creditGl.code
                    } else {
                        tbDr.debitAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
                        tbCr.creditAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
                    }
                    
                    tbDr.save(flush:true)
                    tbCr.save(flush:true)                     
                }
               
            }
        }
        // change gl classification
        if (tmp.txnType.id == 40) {
            if (tf.loanAcct) {
                def loan = tf.loanAcct
                def tbDr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch, debitAmt:tf.txnAmt)
                def tbCr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch, creditAmt:tf.txnAmt)

                def debitGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loan.glLink, '0', loan.loanPerformanceId.id)
                def debitGl = GlAccount.findByCodeAndBranchAndFinancialYearAndCurrency(debitGlPtr.glCode,loan.branch, fy, loan.product.currency)
                def creditGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(loan.prevGLLink, '0', loan.loanPerformanceId.id)
                def creditGl = GlAccount.findByCodeAndBranchAndFinancialYearAndCurrency(creditGlPtr.glCode,loan.branch, fy, loan.product.currency)   
                    
                tbDr.debitAcct = debitGl.code
                tbCr.creditAcct = creditGl.code
                
                tbDr.save(flush:true)
                tbCr.save(flush:true)                 
            }
            if (tf.depAcct) {
                def dep = tf.depAcct
                def tbDr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch, debitAmt:tf.txnAmt)
                def tbCr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch, creditAmt:tf.txnAmt)
                
                def oldGl = CfgAcctGlTemplate.get(tf.txnRef.toInteger())
                def newGl = CfgAcctGlTemplate.get(tf.txnParticulars.toInteger())
                
                def depStatus = dep.status.id
                if (dep.status.id == 3 || dep.status.id == 7) {
                   depStatus = 2 
                }
                def debitGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(oldGl, '0', depStatus)
                def debitGl = GlAccount.findByCodeAndBranchAndFinancialYearAndCurrency(debitGlPtr.glCode, dep.branch, fy, dep.product.currency)
                def creditGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(newGl, '0', depStatus)
                def creditGl = GlAccount.findByCodeAndBranchAndFinancialYearAndCurrency(creditGlPtr.glCode, dep.branch, fy, dep.product.currency)   
                    
                tbDr.debitAcct = debitGl.code
                tbCr.creditAcct = creditGl.code
                
                tbDr.save(flush:true)
                tbCr.save(flush:true)                   
            }
        }
        
    }

    def fdInterestAccrual(TxnFile tf, TxnFile tfTax) {
        def fy = tf.txnDate.format('yyyy').toInteger()
        def tbDr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)
        def tbCr = new TxnBreakdown(currency:Currency.get(tf.currency.id), txnDate:tf.txnDate, txnFile:tf, user:UserMaster.get(tf.user.id), branch:tf.branch)           
           
        def deposit = tf.depAcct
        def depStatus = deposit.status.id
        if (deposit.status.id == 3 || deposit.status.id == 7) {
            depStatus = 2
        }            
        def debitGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '2', depStatus)
        if (!debitGlPtr) {
            debitGlPtr = getGlErrorAccount
        }
        def debitGl = GlAccount.findByCodeAndBranchAndFinancialYear(debitGlPtr.glCode,tf.branch, fy) 
        tbDr.debitAmt = deposit.accruedIntForTheMonth
        tbDr.debitAcct = debitGl.code           
        tbDr.save()
               
        def creditGlPtr = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '1', depStatus)
        if (!creditGlPtr) {
            creditGlPtr = getGlErrorAccount
        }            
        def creditGl = GlAccount.findByCodeAndBranchAndFinancialYear(creditGlPtr.glCode,tf.branch, fy)    
            
        tbCr.creditAcct = creditGl.code
        tbCr.creditAmt = tf.txnAmt
        if (!creditGl){
           tbCr.creditAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
        }
        tbCr.save()         
           
        // tax posting
        def tbDrTax = new TxnBreakdown(currency:Currency.get(tfTax.currency.id), txnDate:tfTax.txnDate, txnFile:tfTax, user:UserMaster.get(tfTax.user.id), 
            branch:tfTax.branch)
        def tbCrTax = new TxnBreakdown(currency:Currency.get(tfTax.currency.id), txnDate:tfTax.txnDate, txnFile:tfTax, user:UserMaster.get(tfTax.user.id), 
            branch:tfTax.branch)           
           
        def debitGlPtrTax = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '1', depStatus)
        def debitGlTax = GlAccount.findByCodeAndBranchAndFinancialYear(debitGlPtrTax.glCode,tf.branch, fy)                
        tbDrTax.debitAcct = debitGlTax.code
        tbDrTax.debitAmt = tfTax.txnAmt
        if (!debitGl){
            tbDr.debitAcct = GlAccount.findByCodeAndBranchAndFinancialYear(Institution.findByParamCode('GLS.60070').paramValue,tf.branch, fy)
        }

        tbDrTax.save()
        def creditGlPtrTax = CfgAcctGlTemplateDet.findByGlTemplateAndOrdinalPosAndStatus(deposit.glLink, '3', depStatus)
        def creditGlTax = GlAccount.findByCodeAndBranchAndFinancialYear(creditGlPtrTax.glCode,tf.branch, fy)
        tbCrTax.creditAmt = tfTax.txnAmt
        tbCrTax.creditAcct = creditGlTax.code           
        tbCrTax.save()                         
    }
    
    def reverseTxn(TxnFile tf) {
        
        def glEntries = TxnBreakdown.findAllByTxnFile(tf)
        for (g in glEntries) {
            def newGl = new TxnBreakdown(branch:g.branch, creditAcct:g.debitAcct, creditAmt:g.debitAmt,
                currency:g.currency, debitAcct:g.creditAcct, debitAmt:g.creditAmt, txnCode:g.txnCode,
                txnDate:g.txnDate, txnFile:g.txnFile, user:g.user)
            newGl.save(flush:true)
        }
    }
    
    // start of year processing
    def startOfYear(Date newYearDate, UserMaster user) {
    
        def newFinYear = newYearDate.format('yyyy').toInteger()
        def oldFinYear = newFinYear - 1
        Integer lineNo = 0 
        Double totDebits = 0.00
        Double totCredits = 0.00
        // create entries for zeroing out income and expenses
        def glCcy = Currency.list()
        for (ccy in glCcy) {
            def bList = Branch.list()
            for (b in bList) {
                def incAndExp = GlAccount.createCriteria().list{
                        and{
                            'in'("type",[GlAcctType.read(4),GlAcctType.read(5)])
                            eq("financialYear",oldFinYear)
                            eq("currency",ccy)
                            ne("balance",0D)
                            eq("branch",b)
                            }
                    }
                def eoyHdr = new GlBatchHdr(batchId:ccy.code+'-EOY-'+b.name+'-'+newYearDate.getTime().toString(), 
                    batchName:b.name+'-'+ccy.code+'-EOY-'+oldFinYear.toString(), batchType:'1',
                    batchCurrency:ccy, branch:b, txnDate:newYearDate, isBalanced:false, isLocked:true,
                    totalCredit:0.00, totalDebit:0.00, valueDate:newYearDate.minus(1))
                eoyHdr.save(flush:true)
                lineNo = 0
                totDebits = 0.00
                totCredits = 0.00
                
                for (gl in incAndExp) {
                    lineNo++
                    def bLine = new GlBatch(batchId:eoyHdr.batchId, recordDate:newYearDate,
                            particulars:b.name + ' EOY Closing Entries', currency:ccy, lineNo:lineNo.toString())
                    bLine.account = gl.code
                    if (gl.balance > 0) {
                        // create credit entry
                        bLine.creditAccount = gl.code
                        bLine.reference = 'EOY Credit '+gl.code
                        bLine.credit = gl.balance 
                        bLine.batchType = '8'
                        bLine.amount = gl.balance
                        totCredits += gl.balance 
                    } else {
                        // create debit entry
                        bLine.debitAccount = gl.code
                        bLine.reference = 'EOY Debit '+gl.code
                        bLine.debit = gl.balance * -1
                        bLine.batchType = '7'
                        bLine.amount = gl.balance * -1
                        totDebits += gl.balance * -1
                    }
                    println '----- EOY Checking Start -----'
                    println bLine.lineNo
                    println bLine.account
                    println bLine.batchType
                    println bLine.amount
                    println '----- EOY Checking End -----'
                    bLine.save(flush:true, failOnError:true)    
                }  
                if (lineNo > 0) {
                    // balancing entry
                    lineNo++
                    def surplus = new GlBatch(batchId:eoyHdr.batchId, recordDate:newYearDate,
                            particulars:b.name + ' EOY Closing Entry - Balancing Acct', currency:ccy, lineNo:lineNo.toString())
                    //def surplusGl = GlAccount.findByCodeAndBranch(Institution.findByParamCode('GLS.60090').paramValue,b)  
                    def surplusGl = b.yearEndClosingGl
                    //surplus.account = surplusGl.code
                    double diff = 0.00
                    if (totDebits == totCredits) {
                        surplus.debitAccount = surplusGl.code
                        surplus.debit = 0.00
                        surplus.amount = 0.00
                        surplus.batchType = '7'
                    } else {
                        if (totDebits > totCredits) {
                            surplus.creditAccount = surplusGl.code
                            surplus.credit = totDebits - totCredits
                            surplus.amount = totDebits - totCredits 
                            surplus.batchType = '8'  
                            diff = totDebits - totCredits
                            totCredits += diff
                        } else {
                            surplus.debitAccount = surplusGl.code
                            surplus.debit = totCredits - totDebits
                            surplus.amount = totCredits - totDebits                            
                            surplus.batchType = '7'                  
                            diff = totCredits - totDebits
                            totDebits += diff
                        }
                    } 
                    surplus.save(flush:true)
                }
                    
                eoyHdr.totalDebit = totDebits
                eoyHdr.totalCredit = totCredits
                eoyHdr.isBalanced = true
                eoyHdr.isLocked = true
                eoyHdr.save(flush:true)
                
                // update batch   
                if (totDebits > 0 || totCredits > 0) {
                    def gBatch = GlBatch.findAllByBatchId(eoyHdr.batchId)
                    for (gLine in gBatch) {
                        if(!gLine.isAttached()) {
                            gLine.attach()
                        }
                        if (gLine.batchType == '7') {
                            this.debitGlAccountPrevYear(gLine.debitAccount, gLine.amount, gLine.id, user, oldFinYear)
                        } else {
                            this.creditGlAccountPrevYear(gLine.creditAccount, gLine.amount, gLine.id, user, oldFinYear)
                        }
                    }                    
                }

                // update batch header
                eoyHdr.status = GlBatchHdrStatus.get(3)
                eoyHdr.save(flush:true,validateOnError:true)  
                //session.flush()
            }             
        }
   
        // create new financial year accounts
        def newGl = GlAccount.createCriteria().list{
                        and{
                            eq("financialYear",oldFinYear)
                            }
                    }
        for (n in newGl) {
            def newGlAcct = new GlAccount(type:n.type, currency:n.currency, branch:n.branch, code:n.code,
                name:n.name, shortName:n.shortName, parent:n.parent, batchUpdate:n.batchUpdate, balance:n.balance,
                financialYear:newFinYear)
            if ((n.type == GlAcctType.read(4)) || (n.type == GlAcctType.read(5))) {
                // income and expense
                newGlAcct.debit = 0.00
                newGlAcct.credit = 0.00
                newGlAcct.debitBalance = 0.00
                newGlAcct.creditBalance = 0.00                
                newGlAcct.balance = 0.00
            } else {
                // balance sheet accounts
                newGlAcct.debit = n.debit
                newGlAcct.credit = n.credit
                newGlAcct.balance = n.balance
                if (n.debit > n.credit) {
                    newGlAcct.debitBalance = n.balance
                    newGlAcct.creditBalance = 0.00
                } else {
                    newGlAcct.debitBalance = 0.00
                    if (n.balance == 0.00) {
                        newGlAcct.creditBalance = 0.00
                    } else {
                        newGlAcct.creditBalance = n.balance * -1
                    }
                }
            }
            newGlAcct.save(flush:true, failOnError:true)
        }            
    }   
    /**
     * Debit the GL Account current balance
     */
    def debitGlAccountPrevYear(String glCodeId, Double amount, Long id, UserMaster user, int prevYear ) {

        def glUpdateList = GlBatch.get(id)
	//for (glUpdate in glUpdateList)
	def glBatchHdr = GlBatchHdr.findByBatchId(glUpdateList.batchId)
	//def glAccount = GlAccount.read(glCodeId)
        def fy = prevYear
        def ccy = glBatchHdr.batchCurrency
        def glCode = GlAccount.findByBranchAndCodeAndFinancialYearAndCurrency(glBatchHdr.branch, glUpdateList.account, fy, ccy)

        if (!glCode) {
            glCode = GlAccount.findByBranchAndCodeAndFinancialYearAndCurrency(glBatchHdr.branch, Institution.findByParamCode('GLS.60070').paramValue, fy, ccy)
        }
        // posting check
        println '+++++ EOY POSTING CHECK +++++'
        println glBatchHdr.branch
        println glUpdateList.account
        println fy
        println ccy
        println '+++++ +++++++++++++++++ +++++'
        glCode.debit += amount
        glCode.balance += amount
        glCode.debitToday += amount
        Double newBal = 0.00
        if (glCode.debit == glCode.credit) {
            glCode.debitBalance = 0.00
            glCode.creditBalance = 0.00
        } else {
            if (glCode.debit > glCode.credit) {
                glCode.debitBalance = glCode.debit - glCode.credit
                glCode.creditBalance = 0.00
                newBal = glCode.debitBalance
            } else {
                glCode.creditBalance = glCode.credit - glCode.debit
                glCode.debitBalance = 0.00
                newBal = glCode.creditBalance
            }
        }
        glCode.debit = glCode.debit.round(2)
        glCode.credit = glCode.credit.round(2)
        glCode.balance = glCode.balance.round(2)
        glCode.debitToday = glCode.debitToday.round(2)
        glCode.creditToday = glCode.creditToday.round(2)
        glCode.debitBalance = glCode.debitBalance.round(2)
        glCode.creditBalance = glCode.creditBalance.round(2)
        glCode.save(failOnError:true, flush:true)

        def glTxn = new GlTxnFile()

        glTxn.branch = glBatchHdr.branch
	glTxn.glAccount = glCode
	glTxn.glAccountCode = glUpdateList.account
	glTxn.debitAmt = amount
	glTxn.debitBal = glCode.debit
	glTxn.outstandingBal = glCode.balance

        /*
        if (glCode.debit == glCode.credit) {
            glTxn.outstandingBal = glCode.debit = 0.00
        } else {
            if (glCode.debit > glCode.credit) {
                glTxn.outstandingBal = glCode.debit - glCode.credit
            } else {
                glTxn.outstandingBal  = glCode.credit - glCode.debit
            }
        }
        */

        glTxn.batchId = glUpdateList.batchId
	glTxn.glBatchHdrId = glBatchHdr
	glTxn.glBatchLine = glUpdateList.lineNo
	glTxn.batchParticulars = glUpdateList.particulars
	glTxn.txnDate = glBatchHdr.txnDate.minus(1)
        glTxn.txnValueDate = glBatchHdr.valueDate
	glTxn.user = user
	glTxn.save(flush:true,failOnError:true)
        //def glAccountUpdate = GlAccount.findByCodeAndBranch(glUpdateList.account,glBatchHdr.branch)
        //glAccountUpdate.debit += amount
	//glAccountUpdate.debitBalance += amount
	//glAccountUpdate.debitToday += amount
	//glAccountUpdate.save(flush:true,failOnError:true)

        return
    }
    /**
     * Credit the GL Credit Balance
     */
    def creditGlAccountPrevYear (String glCodeId, Double amount, Long id, UserMaster user, int prevYear ){

        def glUpdateList = GlBatch.get(id)
	//for (glUpdate in glUpdateList)
	def glBatchHdr = GlBatchHdr.findByBatchId(glUpdateList.batchId)
        def fy = prevYear
        def ccy = glBatchHdr.batchCurrency
        def glCode = GlAccount.findByBranchAndCodeAndFinancialYearAndCurrency(glBatchHdr.branch, glUpdateList.account, fy, ccy)

        if (!glCode) {
            glCode = GlAccount.findByBranchAndCodeAndFinancialYearAndCurrency(glBatchHdr.branch, Institution.findByParamCode('GLS.60070').paramValue, fy, ccy)
        }

        glCode.credit += amount
        glCode.balance -= amount
        glCode.creditToday += amount
        Double newBal = 0
        if (glCode.debit == glCode.credit) {
            glCode.debitBalance = 0.00
            glCode.creditBalance = 0.00
        } else {
            if (glCode.debit > glCode.credit) {
                glCode.debitBalance = glCode.debit - glCode.credit
                glCode.creditBalance = 0.00
                newBal = glCode.debitBalance
            } else {
                glCode.creditBalance = glCode.credit - glCode.debit
                glCode.debitBalance = 0.00
                newBal = glCode.creditBalance
            }
        }
        glCode.debit = glCode.debit.round(2)
        glCode.credit = glCode.credit.round(2)
        glCode.balance = glCode.balance.round(2)
        glCode.debitToday = glCode.debitToday.round(2)
        glCode.creditToday = glCode.creditToday.round(2)
        glCode.debitBalance = glCode.debitBalance.round(2)
        glCode.creditBalance = glCode.creditBalance.round(2)
        glCode.save(failOnError:true, flush:true)

        def glTxn = new GlTxnFile()

        glTxn.branch = glBatchHdr.branch
        glTxn.glAccount = glCode
	glTxn.glAccountCode = glCode.code
	glTxn.creditAmt = amount
	glTxn.creditBal = glCode.credit
        /*
        if (glCode.debit == glCode.credit) {
            glTxn.outstandingBal = glCode.debit = 0.00
        } else {
            if (glCode.debit > glCode.credit) {
                glTxn.outstandingBal = glCode.debit - glCode.credit
            } else {
                glTxn.outstandingBal  = glCode.credit - glCode.debit
            }
        }
        */
        glTxn.outstandingBal = glCode.balance
	glTxn.glBatchHdrId = glBatchHdr
	glTxn.glBatchLine = glUpdateList.lineNo
	glTxn.batchId = glUpdateList.batchId
        glTxn.batchParticulars = glUpdateList.particulars
	glTxn.txnDate = glBatchHdr.txnDate.minus(1)
        glTxn.txnValueDate = glBatchHdr.valueDate
	glTxn.user = user
	glTxn.save(flush:true,failOnError:true)
	//glTxn.txnValueDate = glBatchHdr.valueDate
        //def glAccountUpdate = GlAccount.findByCodeAndBranch(glUpdateList.account,glBatchHdr.branch)

        //glAccountUpdate.credit += amount
	//glAccountUpdate.creditBalance += amount
	//glAccountUpdate.creditToday += amount
	//glAccountUpdate.save(flush:true,failOnError:true)

        return
    }

    /**
     * Debit the AP GL Account current balance
     */
    def debitAPGlAccount(String glCodeId, Double amount, Long id, UserMaster user ) {
       
        def glUpdateList = GlBatch.get(id)
        //for (glUpdate in glUpdateList)
        
        def glBatchHdr = GlBatchHdr.findByBatchId(glUpdateList.batchId)
        //def glAccount = GlAccount.read(glCodeId)

        def fy = glBatchHdr.txnDate.format('yyyy')

        def ccy = glBatchHdr.batchCurrency

        def glCode = GlAccount.findByBranchAndCodeAndFinancialYearAndCurrency(glBatchHdr.branch, glUpdateList.account, fy, ccy)
        
        println "*****Debit AP*****"
        println "Gl Update List:" +glUpdateList
        println "Gl Batch header:" +glBatchHdr    
        println "financialYear:"+fy
        println "Currency:"+ccy
        println "Gl code query:"+glCode
        println "*****END Debit AP*****"
        println "*****CHECKING IF NOT GLCODE*****"
        if (!glCode) {
            println "*****NOT EQUAL TO GL CODE****"
            glCode = GlAccount.findByBranchAndCodeAndFinancialYearAndCurrency(glBatchHdr.branch, Institution.findByParamCode('GLS.60070').paramValue, fy, ccy)
        }
        println "*****END OF CHECK*****"

        println "*****GL OLD VAL*****"
        println "current debit amount:" + glCode.debit
        println "current balance amount:" + glCode.balance
        println "current debit Today:" + glCode.debitToday
        println "*****END GL OLD VAL*****"
        glCode.debit += amount
        glCode.balance -= amount
        glCode.debitToday += amount
        Double newBal = 0.00
        if (glCode.debit == glCode.credit) {
            println "!!!!!!!!!DEBIT EQUAL TO CREDIT"
            glCode.debitBalance = 0.00
            glCode.creditBalance = 0.00
        } else {
            println "!!!!!!!!!DEBIT NOT EQUAL TO CREDIT"
            if (glCode.debit > glCode.credit) {
                glCode.debitBalance = glCode.debit - glCode.credit
                glCode.creditBalance = 0.00    
                newBal = glCode.debitBalance
            } else {
                glCode.creditBalance = glCode.credit - glCode.debit
                glCode.debitBalance = 0.00     
                newBal = glCode.creditBalance
            }
        }
        glCode.debit = glCode.debit.round(2)
        glCode.credit = glCode.credit.round(2)
        glCode.balance = glCode.balance.round(2)
        glCode.debitToday = glCode.debitToday.round(2)
        glCode.creditToday = glCode.creditToday.round(2)
        glCode.debitBalance = glCode.debitBalance.round(2)
        glCode.creditBalance = glCode.creditBalance.round(2)        
        glCode.save(failOnError:true, flush:true)

        println "*****GL ACCOUNT UPDATE ENTRIES*****"
        println "DEBIT:" +glCode.debit
        println "CREDIT:" +glCode.credit  
        println "BALANCE:"+glCode.balance  
        println "DEBIT TODAY:"+glCode.debitToday  
        println "CREDIT TODAY:"+glCode.creditToday  
        println "DEBIT BALANCE:"+glCode.debitBalance
        println "CREDIT BALANCE:"+glCode.creditBalance
        println "*****END Debit AP*****"
        
        def glTxn = new GlTxnFile()
        
        glTxn.branch = glBatchHdr.branch
        glTxn.glAccount = glCode
        glTxn.glAccountCode = glUpdateList.account 
        glTxn.debitAmt = amount
        glTxn.debitBal = glCode.debit 
        glTxn.outstandingBal = glCode.balance
        
        /*
        if (glCode.debit == glCode.credit) {
            glTxn.outstandingBal = glCode.debit = 0.00
        } else {
            if (glCode.debit > glCode.credit) {
                glTxn.outstandingBal = glCode.debit - glCode.credit
            } else {
                glTxn.outstandingBal  = glCode.credit - glCode.debit
            }
        }
        */
       
        glTxn.batchId = glUpdateList.batchId
        glTxn.glBatchHdrId = glBatchHdr
        glTxn.glBatchLine = glUpdateList.lineNo     
        glTxn.batchParticulars = glUpdateList.particulars
        glTxn.txnDate = glBatchHdr.branch.runDate
        glTxn.txnValueDate = glBatchHdr.valueDate
        glTxn.user = user
        glTxn.save(flush:true,failOnError:true)
        //def glAccountUpdate = GlAccount.findByCodeAndBranch(glUpdateList.account,glBatchHdr.branch)
        //glAccountUpdate.debit += amount
    //glAccountUpdate.debitBalance += amount
    //glAccountUpdate.debitToday += amount
    //glAccountUpdate.save(flush:true,failOnError:true)
        def apTxn = new ApTxnFile()

        apTxn.branch = glBatchHdr.branch
        apTxn.glAccount = glCode
        apTxn.glAccountCode = glUpdateList.account 
        apTxn.debitAmt = amount
        apTxn.debitBal = glCode.debit 
        apTxn.outstandingBal = glCode.balance
        apTxn.batchId = glUpdateList.batchId
        apTxn.glBatchHdrId = glBatchHdr
        apTxn.glBatchLine = glUpdateList.lineNo     
        apTxn.batchParticulars = glUpdateList.particulars
        apTxn.txnDate = glBatchHdr.branch.runDate
        apTxn.txnValueDate = glBatchHdr.valueDate
        apTxn.user = user
        apTxn.save(flush:true,failOnError:true)

        return
    }
    /**
     * Credit the AP GL Credit Balance
     */
    def creditAPGlAccount (String glCodeId, Double amount, Long id, UserMaster user ){
        
        def glUpdateList = GlBatch.get(id)
    //for (glUpdate in glUpdateList)
        def glBatchHdr = GlBatchHdr.findByBatchId(glUpdateList.batchId)        
        def fy = glBatchHdr.txnDate.format('yyyy')
        def ccy = glBatchHdr.batchCurrency
        def glCode = GlAccount.findByBranchAndCodeAndFinancialYearAndCurrency(glBatchHdr.branch, glUpdateList.account, fy, ccy)
        
        if (!glCode) {
            glCode = GlAccount.findByBranchAndCodeAndFinancialYearAndCurrency(glBatchHdr.branch, Institution.findByParamCode('GLS.60070').paramValue, fy, ccy)
        }
        
        println "*****Credit AP*****"
        println "Gl Update List:" +glUpdateList
        println "Gl Batch header:" +glBatchHdr    
        println "financialYear:"+fy
        println "Currency:"+ccy
        println "Gl code query:"+glCode
        println "*****END Credit AP*****"
        glCode.credit += amount
        glCode.balance += amount
        glCode.creditToday += amount
        Double newBal = 0
        if (glCode.debit == glCode.credit) {
            glCode.debitBalance = 0.00
            glCode.creditBalance = 0.00
        } else {
            if (glCode.debit > glCode.credit) {
                glCode.debitBalance = glCode.debit - glCode.credit
                glCode.creditBalance = 0.00  
                newBal = glCode.debitBalance
            } else {
                glCode.creditBalance = glCode.credit - glCode.debit
                glCode.debitBalance = 0.00    
                newBal = glCode.creditBalance
            }
        }
        glCode.debit = glCode.debit.round(2)
        glCode.credit = glCode.credit.round(2)
        glCode.balance = glCode.balance.round(2)
        glCode.debitToday = glCode.debitToday.round(2)
        glCode.creditToday = glCode.creditToday.round(2)
        glCode.debitBalance = glCode.debitBalance.round(2)
        glCode.creditBalance = glCode.creditBalance.round(2)        
        glCode.save(failOnError:true, flush:true)
        
        def glTxn = new GlTxnFile()
        
        glTxn.branch = glBatchHdr.branch
        glTxn.glAccount = glCode
        glTxn.glAccountCode = glCode.code
        glTxn.creditAmt = amount
        glTxn.creditBal = glCode.credit
        /*
        if (glCode.debit == glCode.credit) {
            glTxn.outstandingBal = glCode.debit = 0.00
        } else {
            if (glCode.debit > glCode.credit) {
                glTxn.outstandingBal = glCode.debit - glCode.credit
            } else {
                glTxn.outstandingBal  = glCode.credit - glCode.debit
            }
        }
        */
        glTxn.outstandingBal = glCode.balance
        glTxn.glBatchHdrId = glBatchHdr 
        glTxn.glBatchLine = glUpdateList.lineNo     
        glTxn.batchId = glUpdateList.batchId
        glTxn.batchParticulars = glUpdateList.particulars
        glTxn.txnDate = glBatchHdr.branch.runDate
        glTxn.txnValueDate = glBatchHdr.valueDate
        glTxn.user = user
        glTxn.save(flush:true,failOnError:true)
    //glTxn.txnValueDate = glBatchHdr.valueDate
        //def glAccountUpdate = GlAccount.findByCodeAndBranch(glUpdateList.account,glBatchHdr.branch)
             
        //glAccountUpdate.credit += amount
    //glAccountUpdate.creditBalance += amount
    //glAccountUpdate.creditToday += amount
    //glAccountUpdate.save(flush:true,failOnError:true)
        def apTxn = new ApTxnFile()

        apTxn.branch = glBatchHdr.branch
        apTxn.glAccount = glCode
        apTxn.glAccountCode = glCode.code
        apTxn.creditAmt = amount
        apTxn.creditBal = glCode.credit
        apTxn.outstandingBal = glCode.balance
        apTxn.glBatchHdrId = glBatchHdr 
        apTxn.glBatchLine = glUpdateList.lineNo     
        apTxn.batchId = glUpdateList.batchId
        apTxn.batchParticulars = glUpdateList.particulars
        apTxn.txnDate = glBatchHdr.branch.runDate
        apTxn.txnValueDate = glBatchHdr.valueDate
        apTxn.user = user
        apTxn.save(flush:true,failOnError:true)

        return
    }
    
}
