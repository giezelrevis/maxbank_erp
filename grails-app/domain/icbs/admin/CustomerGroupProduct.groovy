package icbs.admin

import icbs.lov.ConfigItemStatus

class CustomerGroupProduct {

	CustomerGroup customerGroup
	Product product
    ConfigItemStatus configItemStatus

    static constraints = {
    	
    }

    static mapping = {
        id sqlType:'int', generator:'increment'
    	customerGroup sqlType:'smallint'
    	product sqlType:'int'
        configItemStatus sqlType:'smallint'
    }
}
