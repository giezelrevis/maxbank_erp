package icbs.loans
import grails.transaction.Transactional
import icbs.admin.UserMaster
import icbs.lov.DepositStatus
import icbs.tellering.TxnFile
import icbs.tellering.TxnLoanPaymentDetails
import icbs.admin.Currency
import icbs.admin.TxnTemplate
import icbs.lov.TxnType
import icbs.gl.GlAccount
import icbs.admin.Branch
import icbs.lov.ConfigItemStatus
import icbs.tellering.TxnBreakdown
import icbs.lov.LoanAcctStatus
import icbs.loans.ROPA
class RopaController {
    def loanService   
    def glTransactionService
    static allowedMethods = [save: "POST", update: ["PUT","POST"], delete: "DELETE"]
    
   def index(Integer max) {
        
        params.max = Math.min(max ?: 10, 100)
 
        def ColumnName = "id"
        def ColumnOrderBy = "desc"
        if (params.query == null) {  // show all instances  
           
            println("clickable sort column: "+params)
           if(params.sort==null){
                 ColumnName = "id"
                 ColumnOrderBy = "desc"
           }else{
                 ColumnName = params.sort
                 ColumnOrderBy = params.order
           }
           def RopaInstanceList = ROPA.createCriteria().list(params) {
               //order(ColumnName,ColumnOrderBy)
               
               
            }
            println("result value: "+RopaInstanceList)
            //respond GlContigentAccountList, model:[BranchInstanceCount: GlContigentAccountList.totalCount]
            [RopaInstanceList:RopaInstanceList,BranchInstanceCount: RopaInstanceList.totalCount,]
        }
        else{
           
              
             def RopaInstanceList = ROPA.createCriteria().list(params) {
                 or {
                    ilike("loanAcctNo", "%${params.query}%")
                    ilike("customerDisplayName", "%${params.query}%")
                }
            }
           [RopaInstanceList:RopaInstanceList,BranchInstanceCount: RopaInstanceList.totalCount]
        }  
    }
    
    def create(){
        respond new ROPA(params)
    } 
    
   @Transactional    
    def save(ROPA ropaInstance) {
        if (ropaInstance == null) {
            notFound()
            return
        }
        
        println("params: "+params)
        def loan = Loan.get(params.loanID.toInteger())
        ropaInstance.loan = loan
        ropaInstance.acquiredFrom = loan.customer
        ropaInstance.customerDisplayName = loan.customer.displayName
        ropaInstance.loanAcctNo = loan.accountNo
        ropaInstance.loanBalance = loan.balanceAmount
        ropaInstance.branch = loan.branch
        ropaInstance.dateCreated = loan.branch.runDate
        ropaInstance.createdBy = UserMaster.get(session.user_id)
        
        if (ropaInstance.hasErrors()) {
            println 'ERRORS'
            println ropaInstance.errors
            respond ropaInstance.errors, view:'create'
            return
        }     
        
        def ropaLoan = ROPA.findAllByLoan(loan)
        if (ropaLoan){
            flash.message = 'Loan already transferred to ROPA!|error|alert'
            respond ropaInstance.errors, view:'create'
            return            
        }
        
        ropaInstance.save(flush:true, failOnError:true)
        
        //createLoanHistoryEntry(loanInstance)
        def balance = loan.balanceAmount
        loan.status = LoanAcctStatus.get(7)
        def amount = balance  
        def credit = loan.balanceAmount - balance
        loan.balanceAmount = credit
        loan.statusChangedDate = loan.branch.runDate
        
        def t = TxnTemplate.get(params.txnType.toInteger())
        
        def txnFileInstance = new TxnFile(acctNo:loan.accountNo, loanAcct:loan,
            currency:loan.product.currency, user:UserMaster.get(session.user_id),
            branch:UserMaster.get(session.user_id).branch, txnAmt:balance,
            txnCode:t.code, txnDate:loan.branch.runDate, txnTimestamp:new Date().toTimestamp(),
            txnDescription:t.description, status:ConfigItemStatus.get(2),
            txnType:t.txnType, txnParticulars:params.particulars, txnRef:params.reference)
        
        txnFileInstance.save(flush:true,failOnError:true)
            
        def txnLoanPaymentDetailsInstance = new TxnLoanPaymentDetails(acct:loan, acctNo:loan.accountNo,
            balForwarded:balance, branch:loan.branch, currency:loan.product.currency,
            interestAmt:0.00D, interestBalAfterPayment:0.00D, paymentAmt:balance,
            penaltyAmt:0.00D, penaltyBalAfterPayment:0.00D, principalAmt:amount,
            principalBalAfterPayment:loan?.balanceAmount, serviceChargeAmt:0.00D,
            totalNetProceeds:loan?.totalNetProceeds, txnDate:loan.branch.runDate,
            txnFile:txnFileInstance, txnRef:params.reference, 
            user:UserMaster.get(session.user_id)) 
        txnLoanPaymentDetailsInstance.save(flush:true,failOnError:true)
        
        glTransactionService.saveTxnBreakdown(txnFileInstance.id)
            
        def loanLedgerEntry = new LoanLedger(loan: loan, txnFile: txnFileInstance, txnDate: loan.branch.runDate, 
            txnTemplate: t, txnRef: params.reference, principalCredit: amount,
            principalBalance: loan.balanceAmount, txnParticulars:params.particulars)
        loanLedgerEntry.save(flush:true,failOnError:true)
                
        //loanService.commitLoanHistoryEntry("Transfer to ROPA" )
        loan.save(flush:true,failOnError:true)
        
        redirect(action: "show", id: ropaInstance.id, params: [id: ropaInstance.id])
        /*request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'ropaInstance.label', default: 'ROPA'), ropaInstance.id])
                redirect ropaInstance
            }
            '*' { respond ropaInstance, [status: CREATED] }
        } */        
    }
    
    def show(ROPA ropaInstance){
        println("params: "+params)
        println("ropaInstance: "+ropaInstance)
       [ropaInstance:ropaInstance]
    }
    
    def edit(ROPA ropaInstance){
        //respond ropaInstance
        [ropaInstance:ropaInstance]
    }
    
    @Transactional  
    def updateRopa(ROPA ropaInstance){
        
        println("params: "+params)
        println("ropaInstance: "+ropaInstance)
        println("ropaBranch: "+ropaInstance.branch)
        
        ropaInstance = ROPA.get(params.ropaId.toInteger())
    
        ropaInstance.landArea = params.landArea ? (params.landArea.replaceAll(",","")).toDouble() : null
        ropaInstance.otherAppraisal = params.otherAppraisal ? (params.otherAppraisal.replaceAll(",","")).toDouble() : null
        ropaInstance.location = params.location
        ropaInstance.dateOfAppraisal = params.dateOfAppraisal ? new Date().parse("MM/dd/yyyy", params.dateOfAppraisal) : null
        ropaInstance.dateOfCertificateRegistration = params.dateOfCertificateRegistration ? new Date().parse("MM/dd/yyyy", params.dateOfCertificateRegistration) : null
        ropaInstance.appraisedBy = params.appraisedBy
        
        ropaInstance.accumulatedDepreciationBuilding = params.accumulatedDepreciationBuilding ? (params.accumulatedDepreciationBuilding.replaceAll(",","")).toDouble() : null
        ropaInstance.otherCosts = params.otherCosts ? (params.otherCosts.replaceAll(",","")).toDouble() : null
        ropaInstance.fireInsurancePolicyNo = params.fireInsurancePolicyNo ? (params.fireInsurancePolicyNo.replaceAll(",","")).toDouble() : null
        ropaInstance.newTct = params.newTct
        ropaInstance.allocatedBookValueLand = params.allocatedBookValueLand ? (params.allocatedBookValueLand.replaceAll(",","")).toDouble() : null
        ropaInstance.allowanceOthers = params.allowanceOthers ? (params.allowanceOthers.replaceAll(",","")).toDouble() : null
        ropaInstance.allowanceBuilding = params.allowanceBuilding ? (params.allowanceBuilding.replaceAll(",","")).toDouble() : null
        ropaInstance.provisionAmt = params.provisionAmt ? (params.provisionAmt.replaceAll(",","")).toDouble() : null
        ropaInstance.formerTitle = params.formerTitle
        ropaInstance.costsCapitalized = params.costsCapitalized ? (params.costsCapitalized.replaceAll(",","")).toDouble() : null
        ropaInstance.buildingAppraisal = params.buildingAppraisal ? (params.buildingAppraisal.replaceAll(",","")).toDouble() : null
        ropaInstance.landAppraisal = params.landAppraisal ? (params.landAppraisal.replaceAll(",","")).toDouble() : null
        ropaInstance.kindOfLand = params.kindOfLand
        ropaInstance.provisionRate = params.provisionRate ? (params.provisionRate.replaceAll(",","")).toDouble() : null
        ropaInstance.provisionForFireInsurance = params.provisionForFireInsurance ? (params.provisionForFireInsurance.replaceAll(",","")).toDouble() : null
        ropaInstance.fireInsuranceAmt = params.fireInsuranceAmt ? (params.fireInsuranceAmt.replaceAll(",","")).toDouble() : null
        ropaInstance.fireInsuranceDate = params.fireInsuranceDate ? new Date().parse("MM/dd/yyyy", params.fireInsuranceDate) : null
        ropaInstance.dateConsolidated = params.dateConsolidated ? new Date().parse("MM/dd/yyyy", params.dateConsolidated) : null
        ropaInstance.allocatedBookValueBuilding = params.allocatedBookValueBuilding ? (params.allocatedBookValueBuilding.replaceAll(",","")).toDouble() : null
        ropaInstance.dateOfCertificate = params.dateOfCertificate ? new Date().parse("MM/dd/yyyy", params.dateOfCertificate) : null
        /*if (ropaInstance == null) {
            notFound()
            return
        }
        
        if (ropaInstance.hasErrors()) {
            respond ropaInstance.errors, view:'edit'
            return
        }*/ 
        
        ropaInstance.save(flush:true)
        redirect(action: "show", id: ropaInstance.id, params: [id: ropaInstance.id])
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
}
