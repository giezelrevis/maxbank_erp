package icbs.loans

import icbs.admin.Product
import icbs.lov.ConfigItemStatus

class PenaltyIncomeSchemeProduct {	
	PenaltyIncomeScheme penaltyIncomeScheme
	Product product

	//ConfigItemStatus status

	//static belongsTo = [penaltyIncomeScheme: PenaltyIncomeScheme , product: Product]

    static mapping = {
    	version false
        id sqlType:'int', generator:'increment'
    	//id composite: ["penaltyIncomeScheme", "product"]
    	penaltyIncomeScheme sqlType: "int"
    	product sqlType: "int"
    }
}
