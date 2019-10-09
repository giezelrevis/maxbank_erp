package icbs.audit

import icbs.admin.UserMaster
import icbs.admin.Module
import icbs.lov.AuditType

class AuditLog {

	AuditType auditType
	Module module
        String tableName
        Integer recordId
	Date date
        Date runDate
	UserMaster userMaster
	String ipAddress
	String recordUrl
	String description

    static constraints = {
    	recordUrl nullable:true
    	description nullable:true
        tableName nullable:true
        recordId nullable:true
    }

    static mapping = {
    	id sqlType:'bigint', generator:'increment'
    	auditType sqlType:'smallint'
    	module sqlType:'int'
    	userMaster sqlType:'int'
    }
}
