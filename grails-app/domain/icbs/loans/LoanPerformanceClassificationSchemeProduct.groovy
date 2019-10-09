package icbs.loans

import icbs.admin.Product
import icbs.lov.ConfigItemStatus

class LoanPerformanceClassificationSchemeProduct {	
	LoanPerformanceClassificationScheme loanPerformanceClassificationScheme
	Product product

	//ConfigItemStatus status

	//static belongsTo = [loanPerformanceClassification: LoanPerformanceClassification , product: Product]

    static mapping = {
    	version false
        id sqlType:'int', generator:'increment'
    	//id composite: ["loanPerformanceClassification", "product"]
    	loanPerformanceClassificationScheme sqlType: "int"
    	product sqlType: "int"
    }
}
