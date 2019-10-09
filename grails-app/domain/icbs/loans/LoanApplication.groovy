package icbs.loans

import icbs.cif.Customer
import icbs.admin.Product
import icbs.admin.Branch
import icbs.admin.Currency
import icbs.admin.UserMaster
import icbs.lov.LoanApplicationStatus

class LoanApplication {
	Customer customer
        Product product
	Branch branch
	Currency currency
    Double amount
    Integer term
    String purpose
    String accountOfficer
    Date applicationDate    
    LoanApplicationStatus approvalStatus
	UserMaster approvedBy
	UserMaster rejectedBy
	Date dateApproved
	Date dateRejected
    
    List financialDetails = [].withLazyDefault {new FinancialDetail()}
    
	static hasMany = [financialDetails: FinancialDetail, 
                      //comakers: LoanApplicationComaker, 
                      collaterals: Collateral]

    static constraints = {    	
        customer nullable: false  
        product nullable: false
        branch nullable: true
        currency nullable: false
        amount nullable: false, blank: false, min:0d, scale:2
        term nullable: false, blank: false, min:0
        purpose nullable: false, blank: false
        accountOfficer nullable: false
        applicationDate nullable: true
        approvalStatus nullable: true
        approvedBy nullable: true
        rejectedBy nullable: true
        dateApproved nullable: true
        dateRejected nullable: true
    }

    static mapping = {
		id sqlType: "int", generator: "increment"
		customer sqlType: "int"
      
		product sqlType: "int"
		branch sqlType: "int"
		currency sqlType: "int"
		term sqlType: "smallint"
		approvalStatus sqlType: "smallint"
		approvedBy sqlType: "int"
		rejectedBy sqlType: "int"
        financialDetails  cascade:"all-delete-orphan"
	}
	
    def beforeValidate() {
        //this.branch = this?.customer?.branch
        this.currency =  this?.product?.currency

        // process financial details
        /*def tempFinancialDetails = []
        tempFinancialDetails.addAll(financialDetails)
        for (financialDetail in tempFinancialDetails) {
            if (financialDetail) {
                financialDetail.dateCreated = new Date()
                if (!financialDetail.type) {
                    this.removeFromFinancialDetails(financialDetail)
                }
            }
        }*/

        return true
    }

	def beforeInsert(){
		// determine user rights first
		approvalStatus = LoanApplicationStatus.get(1)
        
        return true
    }    
}	