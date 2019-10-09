package icbs.gl

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import icbs.admin.UserMaster
import icbs.lov.DepositStatus
import icbs.lov.CheckStatus
import icbs.tellering.TxnFile
import icbs.admin.Currency
import icbs.admin.TxnTemplate
import icbs.lov.TxnType
import icbs.gl.GlAccount
import icbs.admin.Branch
import icbs.lov.ConfigItemStatus
import icbs.tellering.TxnBreakdown	
import icbs.lov.CheckStatus
import icbs.gl.CashInBankCheckbook
import java.text.DateFormat
import java.text.SimpleDateFormat
import grails.converters.*
import java.lang.*


class CashInBankController {

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        if (params.sort == null) {  // default ordering
            params.sort = "branch"
        }

        if (params.query == null) {  // show all instances 
            def cashInBankList = CashInBank.createCriteria().list(params) {
                and {
                    eq("branch", UserMaster.get(session.user_id).branch)
                }  
            }
            respond cashInBankList, model:[CashInBankInstanceCount: cashInBankList.totalCount]            
            // respond CashInBank.list(params), model:[CashInBankInstanceCount: CashInBank.count()]
        }
        else {    // show query results
            def cashInBankList = CashInBank.createCriteria().list(params) {
                and {
                    eq("branch", UserMaster.get(session.user_id).branch)
                }
                or {
                    
                    ilike("bankName", "%${params.query}%")
                    ilike("bankBranch", "%${params.query}%")
                    ilike("acctNo", "%${params.query}%")
                }
            }
            respond cashInBankList, model:[CashInBankInstanceCount: cashInBankList.totalCount]
        }
    }
    
    def create(){
        respond new CashInBank(params)
    }
    
    @Transactional
    def save(CashInBank cashInBankInstance){
        
        if (cashInBankInstance == null) {
            notFound()
            return
        }

        if (cashInBankInstance.hasErrors()) {
            respond cashInBankInstance.errors, view:'create'
            return
        }
        
        if (!cashInBankInstance.bankName){
            flash.error = 'Bank name cannot be null|error|alert'
            respond cashInBankInstance.errors, view:'create'
            return            
        }
        if (!cashInBankInstance.acctNo){
            flash.error = 'Bank name cannot be null|error|alert'
            respond cashInBankInstance.errors, view:'create'
            return            
        }        
        if (cashInBankInstance.type.id == 3) {
            if (!cashInBankInstance.maturityDate) {
                flash.error = 'Maturity Date cannot be null|error|alert'
                respond cashInBankInstance.errors, view:'create'
                return                
            }
            if (cashInBankInstance.maturityDate <= cashInBankInstance.openDate){
                flash.error = 'Maturity Date cannot be less than opening date|error|alert'
                respond cashInBankInstance.errors, view:'create'
                return                    
            }
        }
        
        // initialize other values
        cashInBankInstance.user = UserMaster.get(session.user_id)
        cashInBankInstance.status = DepositStatus.get(2)
        cashInBankInstance.balance = 0.00D
        
        cashInBankInstance.branch = UserMaster.get(session.user_id).branch
        cashInBankInstance.createDate = cashInBankInstance.branch.runDate
        
        cashInBankInstance.save flush:true
  
        // Log
        //def description = 'save Currency ' +  currencyInstance.name
        //auditLogService.insert('040', 'ADM00100', description, 'currency', null, null, null, currencyInstance.id)


        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'cashInBank.label', default: 'Cash in Bank'), cashInBankInstance.id])
                redirect cashInBankInstance
            }
            '*' { respond cashInBankInstance, [status: CREATED] }
        }
             
    }
    
    def show(CashInBank cashInBankInstance){
        respond cashInBankInstance
    }
    
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'cashInBank.label', default: 'Cash in Bank'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    
    def edit(CashInBank cashInBankInstance){
        respond cashInBankInstance
    } 
    
    @Transactional
    def update(CashInBank cashInBankInstance){
        if (cashInBankInstance == null) {
            notFound()
            return
        }

        if (cashInBankInstance.hasErrors()) {
            respond cashInBankInstance.errors, view:'edit'
            return
        }
        
        if (!cashInBankInstance.bankName){
            flash.error = 'Bank name cannot be null|error|alert'
            respond cashInBankInstance.errors, view:'edit'
            return            
        }
        if (!cashInBankInstance.acctNo){
            flash.error = 'Bank name cannot be null|error|alert'
            respond cashInBankInstance.errors, view:'edit'
            return            
        }        
        if (cashInBankInstance.type.id == 3) {
            if (!cashInBankInstance.maturityDate) {
                flash.error = 'Maturity Date cannot be null|error|alert'
                respond cashInBankInstance.errors, view:'edit'
                return                
            }
            if (cashInBankInstance.maturityDate <= cashInBankInstance.openDate){
                flash.error = 'Maturity Date cannot be less than opening date|error|alert'
                respond cashInBankInstance.errors, view:'edit'
                return                    
            }
        } else {
            cashInBankInstance.maturityDate = null
        }
        
        
        cashInBankInstance.save flush:true
  
        // Log
        //def description = 'save Currency ' +  currencyInstance.name
        //auditLogService.insert('040', 'ADM00100', description, 'currency', null, null, null, currencyInstance.id)


        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'cashInBank.label', default: 'Cash in Bank'), cashInBankInstance.id])
                redirect cashInBankInstance
            }
            '*' { respond cashInBankInstance, [status: CREATED] }
        }
                  
    }
    
    def viewTransactions(CashInBank cashInBankInstance){
        respond cashInBankInstance
    }
    
    def checkbookList(CashInBank cashInBankInstance){
       println(cashInBankInstance.list())
       respond cashInBankInstance
       
    }
    
    def createCb(CashInBank cashInBankInstance){
        respond cashInBankInstance
    }
    def cashWithdrawal(CashInBank cashInBankInstance){
        respond cashInBankInstance
    }    
    def creditAdjustment(CashInBank cashInBankInstance){
        respond cashInBankInstance
    }
    def cibDebit(CashInBank cashInBankInstance){
        respond cashInBankInstance
    }	
    def saveCb(CashInBank cashInBankInstance){
        println params
        if (cashInBankInstance == null) {
            notFound()
            return
        }
        
        if (!params.seriesStart){
            flash.error = 'Series start cannot be null|error|alert'
            respond cashInBankInstance.errors, view:'edit'
            return            
        }
        
        if (!params.seriesEnd){
            flash.error = 'Series end cannot be null|error|alert'
            respond cashInBankInstance.errors, view:'edit'
            return            
        }     
        
        def i = params.seriesStart.toInteger()
        def j = params.seriesEnd.toInteger()
        
        if (j <= i) {
            flash.error = 'Series end cannot be less than/equal to series start|error|alert'
            respond cashInBankInstance.errors, view:'edit'
            return              
        }
        
        def chkBookStart = CashInBankCheckbook.findByCheckNo(i)
        def chkBookEnd = CashInBankCheckbook.findByCheckNo(j)
        
        if (chkBookStart || chkBookEnd) {
            flash.error = 'duplicate series|error|alert'
            respond cashInBankInstance.errors, view:'edit'
            return              
        }
        
        for (int x=i;x<=j;x++) {
            def newCb = new CashInBankCheckbook(cashInBank:cashInBankInstance, checkNo:x,
                createdBy:UserMaster.get(session.user_id), createDate:cashInBankInstance.branch.runDate,
                checkStatus:CheckStatus.get(1))
            newCb.save(flush:true, failOnError:true)
            println newCb
        }
        
        respond cashInBankInstance, view:"checkbookList"
    }
   
    def chkDetails(CashInBankCheckbook cashInBankCheckbookInstance){
        respond cashInBankCheckbookInstance
    }
    
    def cashAndCheckDeposit(CashInBank cashInBankInstance){
        respond cashInBankInstance
    }
    
    def saveDeposit(CashInBank cashInBankInstance){
        println params
        // new txnfile
        def amountCash  = params.cashDeposit.toString().replace(',','').toDouble()
        def amountChk = params.checkDeposit.toString().replace(',','').toDouble()
		 
        
        def cibId = CashInBank.get(params.cashInBankId.toInteger())
        def b = Branch.get(1)
        def t = TxnTemplate.get(params.txnType.toInteger())
        def tx  = new TxnFile(txnCode:t.code,txnDescription:t.description,txnDate:b.runDate,currency:cibId.currency,
            txnAmt:amountCash+amountChk,txnRef:params.reference,status:ConfigItemStatus.get(2), branch:cibId.branch,
            txnTimestamp: new Date().toTimestamp(),txnParticulars:params.particulars,txnType:t.txnType,txnTemplate:t, 
            user:UserMaster.get(session.user_id))
        tx.save(flush:true, failOnError:true);
        def cibLedger = new CashInBankLedger(cashInBank:cibId, txnDate:b.runDate, valueDate:b.runDate,
            reference:params.reference, particulars:params.particulars, debitAmt:amountCash+amountChk, creditAmt:0.00D,
            balanceAmt:cibId.balance+amountCash+amountChk, txnFile:tx)
        cibLedger.save(flush:true)
        
        cibId.balance = cibId.balance + amountCash + amountChk
        cibId.save(flush:true)	  
        
        def txnDr = new TxnBreakdown(branch:b, currency:cibId.currency,debitAcct:cibId.glContra,
            debitAmt:amountCash + amountChk, txnCode:t.code, txnDate:b.runDate, txnFile:tx, user:UserMaster.get(session.user_id))
        txnDr.save(flush:true)
        
        if (amountCash > 0.00D) {
            def cashGl = UserMaster.get(session.user_id).cash.code
            def txnCrCash = new TxnBreakdown(branch:b, currency:cibId.currency,creditAcct:cashGl,
                creditAmt:amountCash, txnCode:t.code, txnDate:b.runDate, txnFile:tx, user:UserMaster.get(session.user_id))      
        txnCrCash.save(flush:true)
        }
        if (amountChk>0.00D) {
            def chkGl = UserMaster.get(session.user_id).coci.code
            def txnCrChk = new TxnBreakdown(branch:b, currency:cibId.currency,creditAcct:chkGl,
                creditAmt:amountChk, txnCode:t.code, txnDate:b.runDate, txnFile:tx, user:UserMaster.get(session.user_id))      
        txnCrChk.save(flush:true)            
        }
      
            println('ito na: '+tx)
        
       
        cashInBankInstance = cibId
        respond cashInBankInstance.errors, view:'show'
    }
    def savecibDebit(CashInBank cashInBankInstance){
        println params
        // new txnfile
        def amountCash  = params.debitAdjustment.toString().replace(',','').toDouble()
        
        def cibId = CashInBank.get(params.cibDebit.toInteger())
        def b = Branch.get(1)
        def t = TxnTemplate.get(params.txnType.toInteger())
        def tx  = new TxnFile(txnCode:t.code,txnDescription:t.description,txnDate:b.runDate,currency:cibId.currency,
            txnAmt:amountCash,txnRef:params.reference,status:ConfigItemStatus.get(2), branch:cibId.branch,
            txnTimestamp: new Date().toTimestamp(),txnParticulars:params.particulars,txnType:t.txnType,txnTemplate:t, 
            user:UserMaster.get(session.user_id))
        tx.save(flush:true, failOnError:true);
        def cibLedger = new CashInBankLedger(cashInBank:cibId, txnDate:b.runDate, valueDate:b.runDate,
            reference:params.reference, particulars:params.particulars, debitAmt:amountCash, creditAmt:0.00D,
            balanceAmt:cibId.balance+amountCash, txnFile:tx)
        cibLedger.save(flush:true)
        println ('Debit')
        cibId.balance = cibId.balance + amountCash 
        cibId.save(flush:true)
        
        def txnDr = new TxnBreakdown(branch:b, currency:cibId.currency,debitAcct:cibId.glContra,
            debitAmt:amountCash, txnCode:t.code, txnDate:b.runDate, txnFile:tx, user:UserMaster.get(session.user_id))
        txnDr.save(flush:true)
        
        if (amountCash > 0.00D) {
            def cashGl = UserMaster.get(session.user_id).cash.code
            def txnCrCash = new TxnBreakdown(branch:b, currency:cibId.currency,creditAcct:t.defContraAcct,
                creditAmt:amountCash, txnCode:t.code, txnDate:b.runDate, txnFile:tx, user:UserMaster.get(session.user_id))      
        txnCrCash.save(flush:true)
        }
            println('ito na: '+tx)
        
       
        cashInBankInstance = cibId
        respond cashInBankInstance.errors, view:'show'
    }
    def saveWithdrawal(CashInBank cashInBankInstance){
        println params
        // new txnfile
        def amountCash  = params.cashWithdrawal.toString().replace(',','').toDouble()
        def cashInBankIDID = CashInBank.get(params.cashInBankId.toInteger()) 
        if (amountCash > cashInBankIDID.balance)
        {
            flash.message = "Invalid Withdrawal Amount|error|alert"
            render(view:'/cashInBank/cashWithdrawal', model: [cashInBankInstance:cashInBankIDID])
            return  
        }
        
        def b = Branch.get(1)
        def t = TxnTemplate.get(params.txnType.toInteger())
        def tx  = new TxnFile(txnCode:t.code,txnDescription:t.description,txnDate:b.runDate,currency:cashInBankIDID.currency,
            txnAmt:amountCash,txnRef:params.reference,status:ConfigItemStatus.get(2), branch:cashInBankIDID.branch,
            txnTimestamp: new Date().toTimestamp(),txnParticulars:params.particulars,txnType:t.txnType,txnTemplate:t, 
            user:UserMaster.get(session.user_id))
        
            tx.save(flush:true, failOnError:true);
        
        def cibLedger = new CashInBankLedger(cashInBank:cashInBankIDID, txnDate:b.runDate, valueDate:b.runDate,
            reference:params.reference, particulars:params.particulars, debitAmt:0.00D, creditAmt:amountCash,
            balanceAmt:cashInBankIDID.balance-amountCash, txnFile:tx)
        cibLedger.save(flush:true)
        
        cashInBankIDID.balance = cashInBankIDID.balance - amountCash 
        cashInBankIDID.save(flush:true)
        
        def txnDr = new TxnBreakdown(branch:b, currency:cashInBankIDID.currency,creditAcct:cashInBankIDID.glContra,
            creditAmt:amountCash, txnCode:t.code, txnDate:b.runDate, txnFile:tx, user:UserMaster.get(session.user_id))
        txnDr.save(flush:true)
       
        if (amountCash > 0.00D) {
            def cashGl = UserMaster.get(session.user_id).cash.code
            def txnCrCash = new TxnBreakdown(branch:b, currency:cashInBankIDID.currency,debitAcct:cashGl,
                debitAmt:amountCash, txnCode:t.code, txnDate:b.runDate, txnFile:tx, user:UserMaster.get(session.user_id))      
            txnCrCash.save(flush:true)
        }
        cashInBankInstance = cashInBankIDID
        respond cashInBankInstance.errors, view:'show' 
    }
    def savecreditAdjustment(CashInBank cashInBankInstance){
        println params
        // new txnfile
        def amountCash  = params.creditAmt.toString().replace(',','').toDouble()
       
        def cashInBankIDID = CashInBank.get(params.creditAdjustmentId.toInteger()) 
        if (amountCash > cashInBankIDID.balance)
        {
            flash.message = "Invalid Withdrawal Amount|error|alert"
            render(view:'/cashInBank/cashWithdrawal', model: [cashInBankInstance:cashInBankIDID])
            return  
        }
      
        def b = Branch.get(1)
        def t = TxnTemplate.get(params.txnType.toInteger())
        def tx  = new TxnFile(txnCode:t.code,txnDescription:t.description,txnDate:b.runDate,currency:cashInBankIDID.currency,
            txnAmt:amountCash,txnRef:params.reference,status:ConfigItemStatus.get(2), branch:cashInBankIDID.branch,
            txnTimestamp: new Date().toTimestamp(),txnParticulars:params.particulars,txnType:t.txnType,txnTemplate:t, 
            user:UserMaster.get(session.user_id))
        
            tx.save(flush:true, failOnError:true);
        
        def cibLedger = new CashInBankLedger(cashInBank:cashInBankIDID, txnDate:b.runDate, valueDate:b.runDate,
            reference:params.reference, particulars:params.particulars, debitAmt:0.00D, creditAmt:amountCash,
            balanceAmt:cashInBankIDID.balance-amountCash, txnFile:tx)
        cibLedger.save(flush:true)
        
        cashInBankIDID.balance = cashInBankIDID.balance - amountCash 
        cashInBankIDID.save(flush:true)
        
        def txnDr = new TxnBreakdown(branch:b, currency:cashInBankIDID.currency, txnCode:t.code, txnDate:b.runDate, debitAcct:t.defContraAcct,
                debitAmt:amountCash,txnFile:tx, user:UserMaster.get(session.user_id))
        txnDr.save(flush:true)
        
        if (amountCash > 0.00D) {
            def cashGl = UserMaster.get(session.user_id).cash.code
            def txnCrCash = new TxnBreakdown(branch:b, currency:cashInBankIDID.currency,creditAcct:cashInBankIDID.glContra,
            creditAmt:amountCash, txnCode:t.code, txnDate:b.runDate, txnFile:tx, user:UserMaster.get(session.user_id))      
            txnCrCash.save(flush:true)
        }
        cashInBankInstance = cashInBankIDID
        respond cashInBankInstance.errors, view:'show' 
    }
    def cibClose(CashInBank cashInBankInstance){
        respond cashInBankInstance
    }    
    
    def saveCibClose(CashInBank cashInBankInstance){
        if (cashInBankInstance.balance != 0.00D){
            flash.message = "Account Balance not zero|error|alert"
            render(view:'/cashInBank/cibClose', model: [cashInBankInstance:cashInBankIDID])
            return  
        }
        if (cashInBankInstance.status.id == 7){
            flash.message = "Account alredy closed|error|alert"
            render(view:'/cashInBank/cibClose', model: [cashInBankInstance:cashInBankIDID])
            return  
        }        
        
        cashInBankInstance.status = DepositStatus.get(7)
        cashInBankInstance.save(flush:true, failOnError:true)
        
        respond cashInBankInstance, view:'show'
    }
    def createCheckTransaction(CashInBank cashInBankInstance){
        respond cashInBankInstance
    }   
    
    @Transactional
    def saveChkTransaction(CashInBank cashInBankInstance){
        println('pumasok')
        if (cashInBankInstance == null) {
            notFound()
            return
        }

        if (cashInBankInstance.hasErrors()) {
            respond cashInBankInstance.errors, view:'create'
            return
        }
        
        if (!params.checkNo){
            flash.error = 'Check No cannot be null|error|alert'
            respond cashInBankInstance.errors, view:'create'
            return            
        }  
        // initialize other values
        println ('params: '+ params)
        def cashInBankCheckTransacInstance  = new CashInBankCheckbook(params)
        def cDate = dateconvert(params.checkDate + " 00:00:00")
        def test = Date.parse("yyyy-MM-dd",cDate)
        cashInBankCheckTransacInstance.checkNo = params.checkNo.toString().replace(',','').toDouble()
        cashInBankCheckTransacInstance.reference = params.reference
        cashInBankCheckTransacInstance.checkVoucherNo = params.checkVoucherNo
        cashInBankCheckTransacInstance.checkDate = test
        cashInBankCheckTransacInstance.payee = params.payee
        cashInBankCheckTransacInstance.particulars = params.particulars
        cashInBankCheckTransacInstance.checkAmt = params.checkAmt.toString().replace(',','').toDouble()
        cashInBankCheckTransacInstance.checkStatus = CheckStatus.get(2)
        cashInBankCheckTransacInstance.issuedBy = UserMaster.get(session.user_id)
        cashInBankCheckTransacInstance.cashInBank = CashInBank.get(params.cashInBankInstanceChkT.toInteger()) 
        
        cashInBankCheckTransacInstance.save(flush:true)
        println('cashInBankCheckTransacInstance: '+ cashInBankCheckTransacInstance)
       
        def amountChk  = params.checkAmt.toString().replace(',','').toDouble()
        def cashInBankChk = CashInBank.get(params.cashInBankInstanceChkT.toInteger()) 
        if (amountChk > cashInBankChk.balance)
        {
            flash.message = "Invalid Withdrawal Amount|error|alert"
            render(view:'/cashInBank/createCheckTransaction', model: [cashInBankInstance:cashInBankChk])
            return  
        }
	def b = Branch.get(1)	
	def t = TxnTemplate.get(params.txnType.toInteger())
        def tx  = new TxnFile(txnCode:t.code,txnDescription:t.description,txnDate:b.runDate,currency:cashInBankChk.currency,
            txnAmt:amountChk,txnRef:params.reference,status:ConfigItemStatus.get(2), branch:cashInBankChk.branch,
            txnTimestamp: new Date().toTimestamp(),txnParticulars:params.particulars,txnType:t.txnType,txnTemplate:t, 
            user:UserMaster.get(session.user_id))
        
            tx.save(flush:true, failOnError:true);
        
        def cibLedger = new CashInBankLedger(cashInBank:cashInBankChk, txnDate:b.runDate, valueDate:b.runDate,
            reference:params.reference, particulars:params.particulars, debitAmt:amountChk, creditAmt:0.00D,
            balanceAmt:cashInBankChk.balance-amountChk, txnFile:tx)
        cibLedger.save(flush:true)
        
        cashInBankChk.balance = cashInBankChk.balance - amountChk 
        cashInBankChk.save(flush:true)
        
        println("cashInBankChk : " + cashInBankChk)
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'cashInBank.label', default: 'Cash in Bank'), cashInBankInstance.id])
                println('aasa pa')
               
                render(view:"checkbookList", model:[cashInBankInstance:cashInBankInstance])
            }
           '*' { respond view:'checkbookList',[status: CREATED] }
        }
    }
    public def dateconvert(String xxdate){
                
                def functiondate
                DateFormat yinputDF  = new SimpleDateFormat("MM/dd/yy HH:mm:ss");
                Date dat3 = yinputDF.parse(xxdate)
                Calendar ynow = Calendar.getInstance();
                ynow.setTime(dat3);
                int years = ynow.get(Calendar.YEAR);
                int months = ynow.get(Calendar.MONTH) + 1; // Note: zero based!
                int days = ynow.get(Calendar.DAY_OF_MONTH);
                
               // functiontime = years + "-"+ months +"-"+days + " " + hours +":"+ minutes + ":00";
                functiondate = years + "-"+ months +"-"+ days 
                return functiondate
        
    }
}
