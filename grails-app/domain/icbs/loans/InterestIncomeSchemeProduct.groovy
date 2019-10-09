package icbs.loans

import icbs.admin.Product
import icbs.lov.ConfigItemStatus

class InterestIncomeSchemeProduct {	
	InterestIncomeScheme interestIncomeScheme
	Product product

	//ConfigItemStatus status

	//static belongsTo = [interestIncomeScheme: InterestIncomeScheme , product: Product]

    static mapping = {
    	version false
        id sqlType:'int', generator:'increment'
    	//id composite: ["interestIncomeScheme", "product"]
    	interestIncomeScheme sqlType: "int"
    	product sqlType: "int"
    }
}
