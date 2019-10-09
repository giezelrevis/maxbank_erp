package icbs.admin

import icbs.lov.ConfigItemStatus

class RoleModule {

	Role role
	Module module
	ConfigItemStatus configItemStatus

    static constraints = {
    }

    static mapping = {
        id sqlType:'int', generator:'increment'
    	role sqlType:'smallint'
    	module sqlType:'smallint'
    	configItemStatus sqlType:'smallint'
    }
}
