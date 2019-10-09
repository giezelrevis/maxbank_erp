package icbs.deposit

import icbs.lov.ConfigItemStatus
import icbs.admin.Product
class FixedDepositTermSchemeProduct {
    FixedDepositTermScheme fixedDepositTermScheme
    Product product

    static mapping = {
        id sqlType:'int', generator:'increment'
    	version false
    	fixedDepositTermScheme sqlType: "int"
    	product sqlType: "int"
    }
}
