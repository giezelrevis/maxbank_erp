package icbs.loans

import icbs.admin.Product
import icbs.lov.ConfigItemStatus

class AmortizedChargeSchemeProduct {	
	AmortizedChargeScheme amortizedChargeScheme
	Product product

	//ConfigItemStatus status

	//static belongsTo = [amortizedChargeScheme: AmortizedChargeScheme , product: Product]

    static mapping = {
    	version false
    	//id composite: ["amortizedChargeScheme", "product"]
        id sqlType:'int', generator:'increment'
    	amortizedChargeScheme sqlType: "int"
    	product sqlType: "int"
    }
}
