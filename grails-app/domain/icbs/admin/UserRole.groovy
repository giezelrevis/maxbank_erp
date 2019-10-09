package icbs.admin

import icbs.lov.ConfigItemStatus

class UserRole {

	UserMaster userMaster
	Role role
	ConfigItemStatus configItemStatus

    static constraints = {
    }

    static mapping = {
    	id sqlType:'int', generator:'increment'
    	userMaster sqlType:'int'
    	role sqlType:'smallint'
    	configItemStatus sqlType:'smallint'
    }
}
