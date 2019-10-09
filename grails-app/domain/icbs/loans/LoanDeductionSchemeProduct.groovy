package icbs.loans

import icbs.admin.Product
import icbs.lov.ConfigItemStatus

class LoanDeductionSchemeProduct {	
	LoanDeductionScheme loanDeductionScheme
	Product product

	//ConfigItemStatus status

	//static belongsTo = [loanDeductionScheme: LoanDeductionScheme , product: Product]

    static mapping = {
    	version false
        id sqlType:'int', generator:'increment'
    	//id composite: ["loanDeductionScheme", "product"]
    	loanDeductionScheme sqlType: "int"
    	product sqlType: "int"
    }
}
