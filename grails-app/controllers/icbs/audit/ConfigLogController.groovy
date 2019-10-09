package icbs.audit

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

import icbs.lov.AuditType

class ConfigLogController {

    def index(Integer max) {
    	params.max = Math.min(max ?: 10, 100)
        if(params.offset==null){
            params.offset=0
        }
        if (params.query == null) {
            def AuditLogList = AuditLog.createCriteria().list (params) {
                and {
                    gt("auditType", AuditType.get(2))
                    lt("auditType", AuditType.get(15))
                }
                order("date", "desc")
            }
            respond AuditLogList, model:[params:params,AuditLogInstanceCount: AuditLogList.totalCount]
        }
        else{
            def AuditLogList = AuditLog.createCriteria().list (params) {
                or {
                    ilike("description", "%${params.query}%")
                }
            }
            respond AuditLogList, model:[params:params,AuditLogInstanceCount: AuditLogList.totalCount]
        }
        return
    }
}
