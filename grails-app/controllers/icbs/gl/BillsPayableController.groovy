package icbs.gl
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import icbs.admin.UserMaster
import icbs.lov.ConfigItemStatus
import icbs.admin.Branch
import icbs.tellering.TxnFile
import icbs.admin.Currency
import icbs.admin.TxnTemplate
import icbs.lov.TxnType
import icbs.gl.GlAccount
import icbs.admin.Branch
import icbs.tellering.TxnBreakdown
import icbs.gl.BillsPayableLedger

class BillsPayableController {

    def index(Integer max) {
         params.max = Math.min(max ?: 10, 100)

        if (params.sort == null) {  // default ordering
            params.sort = "dateOpened"
        }

        if (params.query == null) {  // show all instances            
            def billsPayableList = BillsPayable.createCriteria().list(params) {
                and {
                    eq("branch", UserMaster.get(session.user_id).branch)
                }
            }
            respond billsPayableList, model:[params:params, billsPayableInstanceCount: billsPayableList.totalCount]
        }
        else {    // show query results
            def billsPayableList = BillsPayable.createCriteria().list(params) {
                and {
                    eq("branch", UserMaster.get(session.user_id).branch)
                }
                or {                   
                    ilike("creditorName", "%${params.query}%")
                    ilike("accountName", "%${params.query}%")
                }
            }
            respond billsPayableList, model:[params:params, billsPayableInstanceCount: billsPayableList.totalCount]
        }
    }
    
    def create(){
        respond new BillsPayable(params)
    }
    
    @Transactional
    def save(BillsPayable billsPayableInstance){
        if (billsPayableInstance == null) {
            notFound()
            return
        }      
        
        if (billsPayableInstance.hasErrors()) {
            respond billsPayableInstance.errors, view:'create'
            return
        }       
        
        if (!billsPayableInstance.glContra) {
            flash.error = 'GL Account cannot be null|error|alert'
            respond billsPayableInstance.errors, view:'create'
            return              
        }    
        if (!billsPayableInstance.accountName) {
            flash.error = 'Account Name cannot be null|error|alert'
            respond billsPayableInstance.errors, view:'create'
            return              
        }          
        if (!billsPayableInstance.creditorName) {
            flash.error = 'Creditor Name cannot be null|error|alert'
            respond billsPayableInstance.errors, view:'create'
            return              
        }  
        
        if (!billsPayableInstance.dateOpened) {
            flash.error = 'Date Opened cannot be null|error|alert'
            respond billsPayableInstance.errors, view:'create'
            return              
        }    
        if (!billsPayableInstance.dueDate) {
            flash.error = 'Date Opened cannot be null|error|alert'
            respond billsPayableInstance.errors, view:'create'
            return              
        } else {
            if (billsPayableInstance.dueDate <= billsPayableInstance.dateOpened) {
                flash.error = 'Maturity date cannot be same or earlier than opening date|error|alert'
                respond billsPayableInstance.errors, view:'create'
                return                 
            }
        }      
        
        // initialize other values
        billsPayableInstance.principal = 0.00D
        billsPayableInstance.interestAmt = 0.00D
        billsPayableInstance.createdBy = UserMaster.get(session.user_id)
        billsPayableInstance.branch = billsPayableInstance.createdBy.branch
        billsPayableInstance.dateCreated = billsPayableInstance.branch.runDate
        billsPayableInstance.status = ConfigItemStatus.get(2)
        
        billsPayableInstance.save(flush:true)
        
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'billsPayableInstance.label', default: 'Bills Payable'), billsPayableInstance.id])
                redirect billsPayableInstance
            }
            '*' { respond billsPayableInstance, [status: CREATED] }
        }        
    }
    def show(BillsPayable billsPayableInstance){
        respond billsPayableInstance
    }    
    
    def edit(BillsPayable billsPayableInstance) {
        respond billsPayableInstance
    }
    def viewTransactions(BillsPayable billsPayableInstance){
        respond billsPayableInstance
    }															
    
    @Transactional
    def update(BillsPayable billsPayableInstance) {
        if (billsPayableInstance == null) {
            notFound()
            return
        }      
        
        if (billsPayableInstance.hasErrors()) {
            respond billsPayableInstance.errors, view:'create'
            return
        }       
        
        if (!billsPayableInstance.glContra) {
            flash.error = 'GL Account cannot be null|error|alert'
            respond billsPayableInstance.errors, view:'create'
            return              
        }    
        if (!billsPayableInstance.accountName) {
            flash.error = 'Account Name cannot be null|error|alert'
            respond billsPayableInstance.errors, view:'create'
            return              
        }          
        if (!billsPayableInstance.creditorName) {
            flash.error = 'Creditor Name cannot be null|error|alert'
            respond billsPayableInstance.errors, view:'create'
            return              
        }  
        
        if (!billsPayableInstance.dateOpened) {
            flash.error = 'Date Opened cannot be null|error|alert'
            respond billsPayableInstance.errors, view:'create'
            return              
        }    
        if (!billsPayableInstance.dueDate) {
            flash.error = 'Date Opened cannot be null|error|alert'
            respond billsPayableInstance.errors, view:'create'
            return              
        } else {
            if (billsPayableInstance.dueDate <= billsPayableInstance.dateOpened) {
                flash.error = 'Maturity date cannot be same or earlier than opening date|error|alert'
                respond billsPayableInstance.errors, view:'create'
                return                 
            }
        }      
        
        // initialize other values
        billsPayableInstance.save(flush:true)
        
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'billsPayableInstance.label', default: 'Bills Payable'), billsPayableInstance.id])
                redirect billsPayableInstance
            }
            '*' { respond billsPayableInstance, [status: UPDATED] }
        }        
        
    }
	    def bpDebit(BillsPayable billsPayableInstance){
        respond billsPayableInstance
    }
    
    def savebpDebit(BillsPayable billsPayableInstance){
        // new txnfile
        def amountCash  = params.debitAmt.toString().replace(',','').toDouble()
        def bpId = BillsPayable.get(params.bpDebitId.toInteger())
        if (amountCash > bpId.principal)
        {
            flash.message = "Invalid Withdrawal Amount|error|alert"
            render(view:'/billsPayable/bpDebit', model: [billsPayableInstance:bpId])
            return  
        }
        
        def b = Branch.get(1)
        def t = TxnTemplate.get(params.txnType.toInteger())
        def txtFile  = new TxnFile(txnCode:t.code,txnDescription:t.description,txnDate:b.runDate,currency:bpId.currency,
            txnAmt:amountCash,txnRef:params.reference,status:ConfigItemStatus.get(2), branch:bpId.branch,
            txnTimestamp: new Date().toTimestamp(),txnParticulars:params.particulars,txnType:t.txnType,txnTemplate:t, 
            user:UserMaster.get(session.user_id))
        txtFile.save(flush:true, failOnError:true);
        
        def bpLedger = new BillsPayableLedger(billsPayable:bpId, refDate:b.runDate, valueDate:b.runDate,
            reference:params.reference, particulars:params.particulars, debit:amountCash, credit:0.00D,
            balance:bpId.principal-amountCash, txnFile:txtFile)
        bpLedger.save(flush:true)
  
        bpId.principal = bpId.principal - amountCash 
        bpId.save(flush:true)
        
        def txnDeb = new TxnBreakdown(branch:b, currency:bpId.currency,debitAcct:bpId.glContra,
            debitAmt:amountCash, txnCode:t.code, txnDate:b.runDate, txnFile:txtFile, user:UserMaster.get(session.user_id))
        txnDeb.save(flush:true)
        
        if (amountCash > 0.00D) {
            def cashGl = UserMaster.get(session.user_id).cash.code
            def txnCrCash = new TxnBreakdown(branch:b, currency:bpId.currency,creditAcct:t.defContraAcct,
                creditAmt:amountCash, txnCode:t.code, txnDate:b.runDate, txnFile:txtFile, user:UserMaster.get(session.user_id))      
        txnCrCash.save(flush:true)
        }
            println('ito na: '+txtFile)
        
       
        billsPayableInstance = bpId
        respond billsPayableInstance.errors, view:'show'
    }
    def bpCredit(BillsPayable billsPayableInstance){
        respond billsPayableInstance
    }
    def savebpCredit(BillsPayable billsPayableInstance){
        // new txnfile
        def amountCash  = params.creditAmt.toString().replace(',','').toDouble()
        
        def bpCId = BillsPayable.get(params.bpCreditId.toInteger())
        def b = Branch.get(1)
        def t = TxnTemplate.get(params.txnType.toInteger())
        def tx  = new TxnFile(txnCode:t.code,txnDescription:t.description,txnDate:b.runDate,currency:bpCId.currency,
            txnAmt:amountCash,txnRef:params.reference,status:ConfigItemStatus.get(2), branch:bpCId.branch,
            txnTimestamp: new Date().toTimestamp(),txnParticulars:params.particulars,txnType:t.txnType,txnTemplate:t, 
            user:UserMaster.get(session.user_id))
        tx.save(flush:true, failOnError:true);
        
        def bpCLedger = new BillsPayableLedger(billsPayable:bpCId, refDate:b.runDate, valueDate:b.runDate,
            reference:params.reference, particulars:params.particulars, debit:0.00D, credit:amountCash,
            balance:bpCId.principal+amountCash, txnFile:tx)
        bpCLedger.save(flush:true)
    
    
        bpCId.principal = bpCId.principal + amountCash 
        bpCId.save(flush:true)
        
        def txnDr = new TxnBreakdown(branch:b, currency:bpCId.currency,debitAcct:bpCId.glContra,
            debitAmt:amountCash, txnCode:t.code, txnDate:b.runDate, txnFile:tx, user:UserMaster.get(session.user_id))
        txnDr.save(flush:true)
        
        if (amountCash > 0.00D) {
            def cashGl = UserMaster.get(session.user_id).cash.code
            def txnCrCash = new TxnBreakdown(branch:b, currency:bpCId.currency,creditAcct:t.defContraAcct,
                creditAmt:amountCash, txnCode:t.code, txnDate:b.runDate, txnFile:tx, user:UserMaster.get(session.user_id))      
        txnCrCash.save(flush:true)
        }
            println('ito na: '+tx)
        
       
        billsPayableInstance = bpCId
        respond billsPayableInstance.errors, view:'show'
    }
}
