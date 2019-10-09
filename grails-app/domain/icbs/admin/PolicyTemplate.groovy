package icbs.admin

import icbs.lov.ConfigItemStatus

class PolicyTemplate {

    enum Type {
        PROCESS,
        TXN
    }

    String code
	String description
	Type type
	String reference // can be removed
    ConfigItemStatus configItemStatus

    static constraints = {
        code maxSize:50, unique:true
    	description maxSize:100, unique:true
    	reference maxSize:100, nullable:true
    }

    static mapping = {
    	id sqlType:'smallint', generator:'increment'
        configItemStatus sqlType:'smallint'
    }
}
