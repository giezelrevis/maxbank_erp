package icbs.audit

import icbs.admin.UserMaster

class LoginAttempt {

	UserMaster userMaster
	Date date
	String ipAddress
	Integer status

    static constraints = {
    }

    static mapping = {
        id sqlType:'int', generator:'increment'
    	status sqlType:'smallint'
    }
}
