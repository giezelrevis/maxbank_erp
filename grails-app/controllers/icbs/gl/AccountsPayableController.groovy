package icbs.gl

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import icbs.admin.UserMaster
import icbs.lov.DepositStatus
import icbs.tellering.TxnFile
import icbs.admin.Currency
import icbs.admin.TxnTemplate
import icbs.lov.TxnType
import icbs.gl.GlAccount
import icbs.admin.Branch
import icbs.lov.ConfigItemStatus
import icbs.tellering.TxnBreakdown
import icbs.gl.AccountsPayableLedger
class AccountsPayableController {

    def index(Integer max) {
         params.max = Math.min(max ?: 10, 100)

        if (params.sort == null) {  // default ordering
            params.sort = "bookingDate"
        }

        if (params.query == null) {  // show all instances            
            def accountsPayableList = AccountsPayable.createCriteria().list(params) {
                and {
                    eq("branch", UserMaster.get(session.user_id).branch)
                }
            }
            respond accountsPayableList, model:[params:params, accountsPayableInstanceCount: accountsPayableList.totalCount]
        }
        else {    // show query results
            def accountsPayableList = AccountsPayable.createCriteria().list(params) {
                and {
                    eq("branch", UserMaster.get(session.user_id).branch)
                }
                or {                   
                    ilike("payable", "%${params.query}%")
                }
            }
            respond accountsPayableList, model:[params:params, accountsPayableInstanceCount: accountsPayableList.totalCount]
        }
    }
    
    def create(){
        respond new AccountsPayable(params)
    }
    
    @Transactional
    def save(AccountsPayable accountsPayableInstance){
        if (accountsPayableInstance == null) {
            notFound()
            return
        }
        accountsPayableInstance.balance = 0.00D
        
        if (accountsPayableInstance.hasErrors()) {
            respond accountsPayableInstance.errors, view:'create'
            return
        }  
        if (!accountsPayableInstance.glContra) {
            flash.error = 'GL Account cannot be null|error|alert'
            respond accountsPayableInstance.errors, view:'create'
            return              
        }
        if (!accountsPayableInstance.payable){
            flash.error = 'Payable cannot be null|error|alert'
            respond accountsPayableInstance.errors, view:'create'
            return              
        }
        
        accountsPayableInstance.user = UserMaster.get(session.user_id)
        accountsPayableInstance.status = ConfigItemStatus.get(2)
        accountsPayableInstance.branch = UserMaster.get(session.user_id).branch
        accountsPayableInstance.bookingDate = accountsPayableInstance.branch.runDate
        accountsPayableInstance.save(flush:true)
        // Log
        //def description = 'save Currency ' +  currencyInstance.name
        //auditLogService.insert('040', 'ADM00100', description, 'currency', null, null, null, currencyInstance.id)


        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'accountsPayableInstance.label', default: 'Accounts Payable'), accountsPayableInstance.id])
                redirect accountsPayableInstance
            }
            '*' { respond accountsPayableInstance, [status: CREATED] }
        }        
    }
    
    def show(AccountsPayable accountsPayableInstance){
        respond accountsPayableInstance
    }
    
    def edit(AccountsPayable accountsPayableInstance){
        respond accountsPayableInstance
    }
    
    @Transactional
    def update(AccountsPayable accountsPayableInstance){
        if (accountsPayableInstance == null) {
            notFound()
            return
        }
        
        if (accountsPayableInstance.hasErrors()) {
            respond accountsPayableInstance.errors, view:'create'
            return
        }  
        if (!accountsPayableInstance.glContra) {
            flash.error = 'GL Account cannot be null|error|alert'
            respond accountsPayableInstance.errors, view:'create'
            return              
        }
        if (!accountsPayableInstance.payable){
            flash.error = 'Payable cannot be null|error|alert'
            respond accountsPayableInstance.errors, view:'create'
            return              
        }
        
        accountsPayableInstance.save(flush:true)
        // Log
        //def description = 'save Currency ' +  currencyInstance.name
        //auditLogService.insert('040', 'ADM00100', description, 'currency', null, null, null, currencyInstance.id)


        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'accountsPayableInstance.label', default: 'Accounts Payable'), accountsPayableInstance.id])
                redirect accountsPayableInstance
            }
            '*' { respond accountsPayableInstance, [status: MODIFIED] }
        }        
    }
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'accountsPayable.label', default: 'Cash in Bank'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }    
    def viewTransactions(AccountsPayable accountsPayableInstance){
        respond accountsPayableInstance
    }
    def apTxnView(AccountsPayable accountsPayableInstance){
        respond accountsPayableInstance   
    }
    def apDebit(AccountsPayable accountsPayableInstance){
        respond accountsPayableInstance
    }
    def apCredit(AccountsPayable accountsPayableInstance){
        respond accountsPayableInstance
    }
    def saveapDebit(AccountsPayable accountsPayableInstance){
        // new txnfile
        def amountCash  = params.debitAmt.toString().replace(',','').toDouble()
        def cibId = AccountsPayable.get(params.apDebit.toInteger())
        if (amountCash > cibId.balance)
        {
            flash.message = "Invalid Withdrawal Amount|error|alert"
            render(view:'/accountsPayable/apCredit', model: [accountsPayableInstance:cibId])
            return  
        }
        
        def b = Branch.get(1)
        def t = TxnTemplate.get(params.txnType.toInteger())
        def tx  = new TxnFile(txnCode:t.code,txnDescription:t.description,txnDate:b.runDate,currency:cibId.currency,
            txnAmt:amountCash,txnRef:params.reference,status:ConfigItemStatus.get(2), branch:cibId.branch,
            txnTimestamp: new Date().toTimestamp(),txnParticulars:params.particulars,txnType:t.txnType,txnTemplate:t, 
            user:UserMaster.get(session.user_id))
        tx.save(flush:true, failOnError:true);
        def apLedger = new AccountsPayableLedger(accountsPayable:cibId, refDate:b.runDate, valueDate:b.runDate,
            reference:params.reference, particulars:params.particulars, debit:amountCash, credit:0.00D,
            balance:cibId.balance-amountCash, txnFile:tx)
        apLedger.save(flush:true)
    
    
        cibId.balance = cibId.balance - amountCash 
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
        
       
        accountsPayableInstance = cibId
        respond accountsPayableInstance.errors, view:'show'
    }
    
     def saveapCredit(AccountsPayable accountsPayableInstance){
        // new txnfile
        def amountCash  = params.creditAmt.toString().replace(',','').toDouble()
        
        def cibId = AccountsPayable.get(params.apCredit.toInteger())
        def b = Branch.get(1)
        def t = TxnTemplate.get(params.txnType.toInteger())
        def tx  = new TxnFile(txnCode:t.code,txnDescription:t.description,txnDate:b.runDate,currency:cibId.currency,
            txnAmt:amountCash,txnRef:params.reference,status:ConfigItemStatus.get(2), branch:cibId.branch,
            txnTimestamp: new Date().toTimestamp(),txnParticulars:params.particulars,txnType:t.txnType,txnTemplate:t, 
            user:UserMaster.get(session.user_id))
        tx.save(flush:true, failOnError:true);
        def apLedger = new AccountsPayableLedger(accountsPayable:cibId, refDate:b.runDate, valueDate:b.runDate,
            reference:params.reference, particulars:params.particulars, debit:0.00D, credit:amountCash,
            balance:cibId.balance+amountCash, txnFile:tx)
        apLedger.save(flush:true)
    
    
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
        
       
        accountsPayableInstance = cibId
        respond accountsPayableInstance.errors, view:'show'
    }																  
}
