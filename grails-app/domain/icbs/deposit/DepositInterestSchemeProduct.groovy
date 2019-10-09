package icbs.deposit

import icbs.lov.ConfigItemStatus
import icbs.admin.Product


class DepositInterestSchemeProduct{
        DepositInterestScheme depositInterestScheme
        Product product
    static mapping = {
        id sqlType:'int', generator:'increment'
    	version false
    	depositInterestScheme sqlType: "int"
    	product sqlType: "int"
    }
    def beforeInsert(){
    }
    def beforeUpdate(){
        
    }
}
