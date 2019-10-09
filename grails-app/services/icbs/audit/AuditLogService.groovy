package icbs.audit

import org.codehaus.groovy.grails.web.util.WebUtils
import javax.servlet.http.HttpSession
import org.springframework.web.context.request.RequestContextHolder
import grails.transaction.Transactional

import icbs.lov.AuditType
import icbs.admin.Module
import icbs.admin.UserMaster
import icbs.admin.Branch

@Transactional
class AuditLogService {
    static transactional = true

    def insert(String auditCode, String moduleCode, String description, String tableName, newDomainObj, oldDomainObj, String recordUrl, Long recordId) {
    	def webUtils = WebUtils.retrieveGrailsWebRequest()
    	def request = webUtils.getCurrentRequest()
    	def ipAddress = request.getRemoteAddr()
    	HttpSession session = RequestContextHolder.currentRequestAttributes().getSession()
    	
    	def auditLog = new AuditLog()
    	auditLog.auditType = AuditType.findByCode(auditCode)
        println auditLog.auditType
        println 'module code' + moduleCode
    	auditLog.module = Module.findByCode(moduleCode)
       // println auditLog.module
        auditLog.description = description
        println description
        auditLog.tableName = tableName
        println tableName
        //if(newDomainObj)
        //    auditLog.recordId = newDomainObj.id
    	auditLog.date = new Date()
        auditLog.runDate = Branch.get(1).runDate
        
        println auditLog.runDate
    	auditLog.userMaster = UserMaster.get(session.user_id)
    	auditLog.ipAddress = ipAddress
        println auditLog.ipAddress
    	auditLog.recordUrl = recordUrl
        println auditLog.recordUrl
        auditLog.recordId = recordId
        println auditLog.recordId
        
        if (auditLog.hasErrors()) {
            //respond auditLog.errors, view:'create'
            println auditLog.errors
            return
        }
        
    	auditLog.save(flush:true, validateOnError:true)
        println auditLog

        // Log Details
        // this.logDetails(auditLog, newDomainObj, oldDomainObj)
    }
}