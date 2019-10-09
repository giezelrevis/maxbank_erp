package icbs.loans

import icbs.lov.LoanFinancialInfoType
import icbs.admin.Branch
class FinancialDetail {
    LoanFinancialInfoType type
	String description
	Double value	
    Date dateCreated

    static belongsTo = [loanApplication:LoanApplication]

    static constraints = {
        type nullable: false
    	description nullable: false, blank: false    	
        value scale: 2, nullable: false, blank: false        
        dateCreated nullable: false
        loanApplication nullable:true
    }

	static mapping = {
        version false
    	id sqlType: "int", generator: "increment"
    	type sqlType: "smallint"
    }

    def beforeValidate(){
        dateCreated = Branch.get(1).runDate
    }
}
