package icbs.loans

import icbs.lov.LoanCollateralType
import icbs.lov.LoanCollateralStatus
import icbs.cif.Customer

class Collateral {
	Customer owner
	LoanCollateralType collateralType
	Double appraisedValue
	String description
	LoanCollateralStatus status

	CollateralREM rem
	CollateralChattel chattel
	CollateralHoldout holdout
	//CollateralPDC pdc

	static hasMany = [pdcs: CollateralPDC, attachments: LoanAttachment, loanApplications: LoanApplication]
	static belongsTo = LoanApplication

	static constraints = {    	
		owner nullable: false
		collateralType nullable:false
	    appraisedValue nullable:false, min: 0d, scale:2
		description nullable:true
		status nullable:true

		rem nullable:true
		chattel nullable:true
		holdout nullable:true
		//pdc nullable:true
    }

    static mapping = {
		id sqlType: "int", generator: "increment"
		owner sqlType: "int"
		collateralType sqlType: "smallint"
		status sqlType: "smallint"
	}

	def beforeInsert(){
		// determine user rights first
		status = LoanCollateralStatus.get(1)
        
        return true
    }
}