package icbs.deposit

import icbs.admin.Product
import icbs.lov.ConfigItemStatus

class FixedDepositPreTermSchemeProduct{
    FixedDepositPreTermScheme fixedDepositPreTermScheme
    Product product
    static mapping = {
        id sqlType:'int', generator:'increment'
    	version false
    	fixedDepositPreTermScheme sqlType: "int"
    	product sqlType: "int"
    }
}
