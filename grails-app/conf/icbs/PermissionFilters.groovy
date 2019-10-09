package icbs

import icbs.admin.Module
import org.apache.commons.lang.StringUtils

class PermissionFilters {

    def roleModuleService

    def filters = {
        all(controller:'*', action:'*', controllerExclude: 'assets', actionExclude:'login|authenticate|logout|landing|changePassword|saveChangePassword') {
            before = {
               // def uri = request.forwardURI
                def uri = (request.requestURI).replace('.dispatch','').replace('/icbs/','/').replace('/grails/','/')
               // //println "Forward URI? " +  uri 
               // println "Request URI? " + (request.requestURI).replace('.dispatch','').replace('/icbs/grails/','/')
               // println "REquest Qry? " + request.queryString

                def i = 0
                def parsedUri = ''
                uri.each {
                    if(it=='/') i++

                    if(i > 1) parsedUri = parsedUri + it
                }
                if (parsedUri.endsWith("/")) {
                    parsedUri = parsedUri.substring(0, parsedUri.length() - 1);
                }
                
              //  println "URI? " +  parsedUri
                //println "uri? "+uri
                def module = Module.findByUri(uri)
                // 
                
                // 
                if(module) { // for testing only
                   // println "module is on menu : "+module.isOnMenu
                    // - reyjieroque
                    // if the module (isOnMenu) set to false, the system will not allow access to the said module
                    if(module.isOnMenu)
                    {
                        if(!roleModuleService.hasPermission(module)) {
                            flash.error = "You are not authorized to access the " + module.name + " module."
                            redirect(controller:'home', action:'landing')
                            return false
                        }
                    } else {
                       
                        if(!roleModuleService.hasPermission(module)) {
                            flash.error = "You are not authorized to access the " + module.name + " module."
                            redirect(controller:'home', action:'landing')
                            return false
                        }                        
                            //flash.error = "You are not authorized to access the " + module.name + " module. (disabled)"
                            //redirect(controller:'home', action:'landing')
                            //return false
                     
                    }
                    
                } 
            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }
    }
}
