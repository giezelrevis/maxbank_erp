package icbs.admin

import icbs.lov.ConfigItemStatus

class Currency {

	String code
	String name
	ConfigItemStatus configItemStatus

    static constraints = {
    	code maxSize:5, unique:true
    	name maxSize:50, unique:true
        configItemStatus blank:true, nullable:false
    }

    static mapping = {
    	id sqlType:'int', generator:'increment'
        configItemStatus sqlType:'smallint'
    }
}
