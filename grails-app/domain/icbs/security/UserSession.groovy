package icbs.security

import icbs.admin.UserMaster

class UserSession {

	UserMaster userMaster
	Date login
	Date logout

    static constraints = {
    	logout nullable:true
    }

    static mapping = {
        id sqlType:'int', generator:'increment'
    	userMaster sqlType:'int'
    }
}
