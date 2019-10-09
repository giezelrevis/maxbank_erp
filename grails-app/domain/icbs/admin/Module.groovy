package icbs.admin

import icbs.lov.ConfigItemStatus

class Module {

	String name
    String code
	String parentModuleCode
	boolean isOnMenu
	Integer menuOrder
	String uri
	ConfigItemStatus configItemStatus

    // static belongsTo = [Role]

    static hasMany = [roles: Role]

    static constraints = {
    	name maxSize:50, unique:true
        code unique:true
    	parentModuleCode nullable:true
    	menuOrder nullable:true
    	uri nullable:true
    }

    static mapping = {
        roles joinTable: [name:'role_module', key:'module_id']
    	id sqlType:'int', generator:'increment'
    	menuOrder sqlType:'int'
    	configItemStatus sqlType:'smallint'
    }
}
