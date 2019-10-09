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

class AccountsReceivableController {

    def index(Integer max) {
         params.max = Math.min(max ?: 10, 100)

        if (params.sort == null) {  // default ordering
            params.sort = "description"
        }

        if (params.query == null) {  // show all instances            
            def accountsReceivableList = AccountsReceivable.createCriteria().list(params) {
                and {
                    eq("branch", UserMaster.get(session.user_id).branch)
                }
            }
            respond accountsReceivableList, model:[params:params, AccountsReceivableInstanceCount: accountsReceivableList.totalCount]
        }
        else {    // show query results
            def accountsReceivableList = AccountsReceivable.createCriteria().list(params) {
                and {
                    eq("branch", UserMaster.get(session.user_id).branch)
                }
                or {                   
                    ilike("description", "%${params.query}%")
                    ilike("receivableName", "%${params.query}%")
                }
            }
            respond accountsReceivableList, model:[params:params, AccountsReceivableInstanceCount: accountsReceivableList.totalCount]
        }
    }
    
    def create(){
        respond new AccountsReceivable(params)
    }
    
    @Transactional
    def save(AccountsReceivable accountsReceivableInstance){
        if (accountsReceivableInstance == null) {
            notFound()
            return
        }
        accountsReceivableInstance.balance = 0.00D
        accountsReceivableInstance.requiredValuationReserves = 0.00
        
        if (accountsReceivableInstance.hasErrors()) {
            respond accountsReceivableInstance.errors, view:'create'
            return
        }  
        if (!accountsReceivableInstance.glContra) {
            flash.error = 'GL Account cannot be null|error|alert'
            respond accountsReceivableInstance.errors, view:'create'
            return              
        }
        if (!accountsReceivableInstance.description){
            flash.error = 'Description cannot be null|error|alert'
            respond accountsReceivableInstance.errors, view:'create'
            return              
        }
        
        accountsReceivableInstance.user = UserMaster.get(session.user_id)
        accountsReceivableInstance.status = ConfigItemStatus.get(2)
        accountsReceivableInstance.branch = UserMaster.get(session.user_id).branch
        accountsReceivableInstance.bookingDate = accountsReceivableInstance.branch.runDate
        accountsReceivableInstance.save(flush:true)
        // Log
        //def description = 'save Currency ' +  currencyInstance.name
        //auditLogService.insert('040', 'ADM00100', description, 'currency', null, null, null, currencyInstance.id)


        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'accountsReceivableInstance.label', default: 'Accounts Receivable'), accountsReceivableInstance.id])
                redirect accountsReceivableInstance
            }
            '*' { respond accountsReceivableInstance, [status: CREATED] }
        }        
    }
    def show(AccountsReceivable accountsReceivableInstance){
        respond accountsReceivableInstance
    }
    def viewTransactions(AccountsReceivable accountsReceivableInstance){
        println("accountsReceivableInstance: "+accountsReceivableInstance)
        respond accountsReceivableInstance
    }
    def arDebit(AccountsReceivable accountsReceivableInstance){
        respond accountsReceivableInstance
    }
    def savearDebit(AccountsReceivable accountsReceivableInstance){
        // new txnfile
        def amountCash  = params.debitAmt.toString().replace(',','').toDouble()
        
        def cibId = AccountsReceivable.get(params.arDebit.toInteger())
        def b = Branch.get(1)
        def t = TxnTemplate.get(params.txnType.toInteger())
        def tx  = new TxnFile(txnCode:t.code,txnDescription:t.description,txnDate:b.runDate,currency:cibId.currency,
            txnAmt:amountCash,txnRef:params.reference,status:ConfigItemStatus.get(2), branch:cibId.branch,
            txnTimestamp: new Date().toTimestamp(),txnParticulars:params.particulars,txnType:t.txnType,txnTemplate:t, 
            user:UserMaster.get(session.user_id))
        tx.save(flush:true, failOnError:true);
        def arLedger = new AccountsReceivableLedger(accountsReceivable:cibId, refDate:b.runDate, valueDate:b.runDate,
            reference:params.reference, particulars:params.particulars, debit:amountCash, credit:0.00D,
            balance:cibId.balance+amountCash, txnFile:tx)
        arLedger.save(flush:true)
        
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
        
       
        accountsReceivableInstance = cibId
        respond accountsReceivableInstance.errors, view:'show'
    }

    def arCredit(AccountsReceivable accountsReceivableInstance){
        respond accountsReceivableInstance
    }
    def savecrDebit(AccountsReceivable accountsReceivableInstance){
        // new txnfile
        def amountCash  = params.creditAmt.toString().replace(',','').toDouble()
        
        def cibId = AccountsReceivable.get(params.crCredit.toInteger())
        def b = Branch.get(1)
        def t = TxnTemplate.get(params.txnType.toInteger())
        def tx  = new TxnFile(txnCode:t.code,txnDescription:t.description,txnDate:b.runDate,currency:cibId.currency,
            txnAmt:amountCash,txnRef:params.reference,status:ConfigItemStatus.get(2), branch:cibId.branch,
            txnTimestamp: new Date().toTimestamp(),txnParticulars:params.particulars,txnType:t.txnType,txnTemplate:t, 
            user:UserMaster.get(session.user_id))
        tx.save(flush:true, failOnError:true);
        def arLedger = new AccountsReceivableLedger(accountsReceivable:cibId, refDate:b.runDate, valueDate:b.runDate,
            reference:params.reference, particulars:params.particulars, debit:0.00D, credit:amountCash,
            balance:cibId.balance-amountCash, txnFile:tx)
        arLedger.save(flush:true)
        
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
        
       
        accountsReceivableInstance = cibId
        respond accountsReceivableInstance.errors, view:'show'
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
    
}
