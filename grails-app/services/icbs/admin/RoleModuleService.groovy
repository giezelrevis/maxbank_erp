package icbs.admin

import org.codehaus.groovy.grails.web.util.WebUtils
import grails.transaction.Transactional
import javax.servlet.http.HttpSession
import org.springframework.web.context.request.RequestContextHolder
import org.apache.commons.lang.StringUtils

import icbs.lov.ConfigItemStatus

class RoleModuleService {
	static transactional = false
        
    def canPerform(Module module) {
    	HttpSession session = RequestContextHolder.currentRequestAttributes().getSession();

    	def authorized = false

    	def roles = UserRole.findAllByUserMasterAndConfigItemStatus(UserMaster.get(session.user_id), ConfigItemStatus.get(2))
        
    	roles.each {
            if(RoleModule.findAllByRoleAndModule(it.role, module)) {
    		authorized = true
    		return
            }
    	}

    	return authorized
    }
    
    def hasPermission(Module module) {
    	HttpSession session = RequestContextHolder.currentRequestAttributes().getSession();

    	def authorized = false

    	def roles = UserRole.findAllByUserMasterAndConfigItemStatus(UserMaster.get(session.user_id), ConfigItemStatus.get(2))
        
    	roles.each {
    		if(RoleModule.findAllByRoleAndModule(it.role, module)) {
    			authorized = true
    			return
    		}
            
            // Checking if user has permission with parent modules
            def parentModule = Module.findByCodeAndIsOnMenu(module.parentModuleCode,true)
            //println "parentmodule ? "+parentModule
            while(parentModule) {
                if(RoleModule.findAllByRoleAndModule(it.role, parentModule)) {
                    authorized = true
                    return
                }
                parentModule = Module.findByCode(parentModule.parentModuleCode)
            }
    	}

    	return authorized
    }

    def getPermittedModules() {
        def webUtils = WebUtils.retrieveGrailsWebRequest()
        def request = webUtils.getCurrentRequest()
        HttpSession session = RequestContextHolder.currentRequestAttributes().getSession();

        def uri = request.forwardURI

        def i = 0
        def parsedUri = ''
        uri.each {
            if(it=='/') i++

            if(i > 1) parsedUri = parsedUri + it
        }
        if (parsedUri.endsWith("/")) {
            parsedUri = parsedUri.substring(0, parsedUri.length() - 1);
        }

        def module = Module.findByUri(parsedUri)

        if(module) {
            return Module.findAllByParentModuleCode(module.code) // TODO
        }
    }

    def getMenu(String parentModuleCode) {
       // println parentModuleCode
        def menu = []

        HttpSession session = RequestContextHolder.currentRequestAttributes().getSession();
        def authorized = false
        def userRoles = UserRole.findAllByUserMasterAndConfigItemStatus(UserMaster.get(session.user_id), ConfigItemStatus.get(2))

        def parentMenuAuthorized = RoleModule.findAllByRoleInListAndModule(userRoles.role, Module.findByCodeAndIsOnMenu(parentModuleCode, true))
        //println "? -- " + parentMenuAuthorized
        if(parentMenuAuthorized) {
            //println "return ?" + Module.findAllByParentModuleCode(parentModuleCode)
            return Module.findAllByParentModuleCodeAndIsOnMenu(parentModuleCode,true)
        }
        else {
            def subMenus = Module.findAllByParentModuleCode(parentModuleCode)
            //println "subs?"
            subMenus.each {
                if(RoleModule.findAllByRoleInListAndModule(userRoles.role, it)) {
                    menu.add(it)
                }
            }
            //println "return 2 ?? menu? "+menu
            return menu
        }
    }
}
