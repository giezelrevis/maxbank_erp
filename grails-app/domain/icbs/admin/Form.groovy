package icbs.admin

import icbs.lov.ConfigItemStatus

class Form {

	String name
	String sourceFile
	ConfigItemStatus configItemStatus

    static constraints = {
    	name maxSize:100, unique:true
    	sourceFile nullable:false
    }

    static mapping = {
    	id sqlType:'int'
    	configItemStatus sqlType:'smallint'
    }
}
