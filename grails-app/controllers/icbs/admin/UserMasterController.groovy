package icbs.admin

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import icbs.lov.ConfigItemStatus
import icbs.security.UserSession
import org.apache.commons.lang.RandomStringUtils

@Transactional(readOnly = true)
class UserMasterController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def auditLogService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        def branch = UserMaster.get(session.user_id).branch

        if (params.sort == null) {  // default ordering
            params.sort = "username"
        }

        if (params.query == null) {  // show all instances
            if(branch.dataCenter) {
                respond UserMaster.list(params), model:[UserMasterInstanceCount: UserMaster.count()]
            }
            else {
                respond UserMaster.findAllByBranch(branch), model:[UserMasterInstanceCount: UserMaster.count()]
            }
        }
        else {    // show query results
            def userList = UserMaster.createCriteria().list(params) {
                or {
                    ilike("username", "%${params.query}%")
                    ilike("name1", "%${params.query}%")
                    ilike("name2", "%${params.query}%")
                    ilike("name3", "%${params.query}%")
                }
                and {
                    if(!branch.dataCenter) eq("branch", branch)
                }
            }
            respond userList, model:[UserMasterInstanceCount: userList.totalCount]
        }
    }

    def show(UserMaster userMasterInstance) {
        respond userMasterInstance
    }

    def create() {
        def passwordValidity = Institution.findByParamCode('SEC.20040').paramValue.toInteger()
        
        def accessValidity = Institution.findByParamCode('SEC.20050').paramValue.toInteger()
        
        def branchRunDate = Branch.findById(session.branch_id).runDate
        
        println (branchRunDate)
        println (passwordValidity)
        
        respond new UserMaster(params), model:[accessValidity:accessValidity, branchRunDate:branchRunDate, passwordValidity:passwordValidity]
    }

    @Transactional
    def save(UserMaster userMasterInstance) {
        def accessValidity = Institution.findByParamCode('SEC.20050').paramValue.toInteger()
        
        def passwordValidity = Institution.findByParamCode('SEC.20040').paramValue.toInteger()
         
        def branchRunDate = Branch.findById(session.branch_id).runDate
        
        if (userMasterInstance == null) {
            notFound()
            return
        }

        if (userMasterInstance.hasErrors()) {
            respond userMasterInstance.errors, view:'create', model:[accessValidity:accessValidity, branchRunDate:branchRunDate, passwordValidity:passwordValidity]
            return
        }

        if (userMasterInstance.birthdate  >= Branch.get(1).runDate) {
            flash.message = 'Date of birth cannot be greater than system date|error|alert'
            respond userMasterInstance.errors, view:'create', model:[accessValidity:accessValidity, branchRunDate:branchRunDate, passwordValidity:passwordValidity]
            return
        }
        
        if (userMasterInstance.dateHired  >= Branch.get(1).runDate) {
            flash.message = 'Date of hiring cannot be greater than system date|error|alert'
            respond userMasterInstance.errors, view:'create', model:[accessValidity:accessValidity, branchRunDate:branchRunDate, passwordValidity:passwordValidity]
            return
        }
        if (userMasterInstance.expiryDate < Branch.get(1).runDate) {
            flash.message = 'User Access Expiry cannot be less than system date|error|alert'
            respond userMasterInstance.errors, view:'create', model:[accessValidity:accessValidity, branchRunDate:branchRunDate, passwordValidity:passwordValidity]
            return
        }        
        userMasterInstance.configItemStatus = ConfigItemStatus.get(2)
        userMasterInstance.isLocked = false
        userMasterInstance.isFirstLogin = true
        userMasterInstance.password = userMasterInstance.password.encodeAsMD5()
        userMasterInstance.expiryPwdDate = branchRunDate.plus(passwordValidity)
        
        userMasterInstance.save flush:true
        def roles = params.list('roles')       
        roles.each {
            UserRole ur = new UserRole(role:it, userMaster:userMasterInstance, configItemStatus:ConfigItemStatus.get(2)).save(flush:true)
        }

        // Password History
        PasswordHistory ph = new PasswordHistory(userMaster:userMasterInstance, password:userMasterInstance.password.encodeAsMD5(), dateUsed:new Date()).save(flush:true)

        // Log
        def description = 'Add user ' + userMasterInstance.name1 + ' ' + userMasterInstance.name2
        auditLogService.insert('040', 'ADM00502', description, 'userMaster', null, null, 'userMaster/show/'+userMasterInstance.id, userMasterInstance.id)

        request.withFormat {
            form multipartForm {
                //flash.message = message(code: 'default.created.message', args: [message(code: 'userMaster.label', default: 'User: '), userMasterInstance.username])
                flash.message = 'User successfully added.|success|alert'
                redirect userMasterInstance
            }
            '*' { respond userMasterInstance, [status: CREATED] }
        }
        flash.message = 'User successfully added.|success|alert'
    }

    def edit(UserMaster userMasterInstance) {
        respond userMasterInstance
    }
    
    @Transactional
    def forceLogout(UserMaster userMasterInstance)
    {
        // User session
        def userSession = UserSession.findByUserMasterAndLogout(userMasterInstance, null)
        if(userSession) {
            userSession.logout = new Date()
            userSession.save(flush:true)
        }

        flash.message = "Forced logged out successful.|success|alert"

        // Log
        auditLogService.insert('170', 'BAS00200', 'Forced Logout ' + userMasterInstance.username, 'session', null, null, null, session.session_id)
        // auditLogService.insert('160', 'BAS00200', null, null, null)
        redirect(controller:"UserMaster")
    }

    @Transactional
    def update(UserMaster userMasterInstance) {
        if (userMasterInstance == null) {
            notFound()
            return
        }

        if (userMasterInstance.hasErrors()) {
            respond userMasterInstance.errors, view:'edit'
            return
        }
        if (userMasterInstance.birthdate  >= Branch.get(1).runDate) {
            flash.message = 'Date of birth cannot be greater than system date|error|alert'
            respond userMasterInstance.errors, view:'edit'
            return
        }
        
        if (userMasterInstance.dateHired  >= Branch.get(1).runDate) {
            flash.message = 'Date of hiring cannot be greater than system date|error|alert'
            respond userMasterInstance.errors, view:'edit'
            return
        }
        if (userMasterInstance.expiryDate < Branch.get(1).runDate) {
            flash.message = 'User Access Expiry cannot be less than system date|error|alert'
            //userMasterInstance.errors.rejectValue('expiryDate', 'invalidExpiryDate')
            respond userMasterInstance.errors, view:'edit'
            return
        }         
        userMasterInstance.save flush:true

        def roles = params.list('roles')

        updateRoles(userMasterInstance, roles)

        roles.each {
            def ur = UserRole.findAllByUserMasterAndRole(userMasterInstance, Role.get(it))

            if(!ur) {
                UserRole newUR = new UserRole(role:it, userMaster:userMasterInstance, configItemStatus:ConfigItemStatus.get(2)).save(flush:true)
            }
        }

        // Log
        def description = 'Edit user ' + userMasterInstance.name1 + ' ' + userMasterInstance.name2
        println 'Updated UserInstanceId ' + userMasterInstance.id
        auditLogService.insert('040', 'ADM00503', description, 'userMaster', null, null, 'userMaster/show/'+userMasterInstance.id, userMasterInstance.id)

        request.withFormat {
            form multipartForm {
                //flash.message = message(code: 'default.updated.message', args: [message(code: 'UserMaster.label', default: 'UserMaster'), userMasterInstance.id])
                flash.message = "Update complete .. |success|alert"
                redirect userMasterInstance
            }
            '*'{ respond userMasterInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(UserMaster userMasterInstance) {
        userMasterInstance.configItemStatus = ConfigItemStatus.get(3)

        if (userMasterInstance == null) {
            notFound()
            return
        }

        userMasterInstance.save flush:true

        // Log
        def description = 'Delete user ' + userMasterInstance.name1 + ' ' + userMasterInstance.name2
        auditLogService.insert('040', 'ADM00504', description, 'userMaster', null, null, 'userMaster/show/'+userMasterInstance.id, userMasterInstance.id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'UserMaster.label', default: 'UserMaster'), userMasterInstance.id])
                
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    @Transactional
    def lock(UserMaster userMasterInstance) {
        userMasterInstance.isLocked = true

        if (userMasterInstance == null) {
            notFound()
            return
        }

        userMasterInstance.save flush:true

        // Log
        def description = 'Lock user ' + userMasterInstance.name1 + ' ' + userMasterInstance.name2
        auditLogService.insert('040', 'ADM00506', description, null, null, null, 'userMaster/show/'+userMasterInstance.id, userMasterInstance.id)

        request.withFormat {
            form multipartForm {
                //flash.message = message(code: 'default.updated.message', args: [message(code: 'UserMaster.label', default: 'UserMaster'), userMasterInstance.id])
                flash.message = "User update complete..Locked (id : ${userMasterInstance.id}) |success|alert"
                redirect userMasterInstance
            }
            '*'{ respond userMasterInstance, [status: OK] }
        }
    }

    @Transactional
    def unlock(UserMaster userMasterInstance) {
        userMasterInstance.isLocked = false
        userMasterInstance.hasExceededMaxLogin = false

        if (userMasterInstance == null) {
            notFound()
            return
        }

        userMasterInstance.save flush:true

        // Log
        def description = 'Unlock user ' + userMasterInstance.name1 + ' ' + userMasterInstance.name2
        auditLogService.insert('040', 'ADM00506', description, null, null, null, 'userMaster/show/'+userMasterInstance.id, userMasterInstance.id)

        request.withFormat {
            form multipartForm {
                //flash.message = message(code: 'default.updated.message', args: [message(code: 'UserMaster.label', default: 'UserMaster'), userMasterInstance.id])
                flash.message = "User update complete..Unlocked (id : ${userMasterInstance.id}) |success|alert"
                redirect userMasterInstance
            }
            '*'{ respond userMasterInstance, [status: OK] }
        }
    }

    def resetPassword(UserMaster userMasterInstance) {
        respond userMasterInstance
    }

    @Transactional
    def saveResetPassword(UserMaster userMasterInstance) {

        if (userMasterInstance == null) {
            notFound()
            return
        }
        
        if (userMasterInstance.password == null) {
            flash.message = 'Password is blank ! |error|alert'
            respond userMasterInstance.errors, view:'resetPassword'
            return
        }

        // Password Expiry
        def passwordValidity = Institution.findByParamCode('SEC.20040').paramValue.toInteger()
                 
        def branchRunDate = Branch.findById(session.branch_id).runDate
        
        userMasterInstance.expiryPwdDate = branchRunDate.plus(passwordValidity)
        
        //userMasterInstance.expiryDate = new Date().plus(passwordValidity)

        // Redirect to change password
        userMasterInstance.isFirstLogin = true

        userMasterInstance.password = userMasterInstance.password.encodeAsMD5()
        
        userMasterInstance.save flush:true

        // Log
        def description = 'Reset password for ' + userMasterInstance.name1 + ' ' + userMasterInstance.name2
        auditLogService.insert('040', 'ADM00505', description, null, null, null, null, userMasterInstance.id)

        // Password History
        PasswordHistory ph = new PasswordHistory(userMaster:userMasterInstance, password:userMasterInstance.password.encodeAsMD5(), dateUsed:new Date()).save(flush:true)

        request.withFormat {
            form multipartForm {
                //flash.message = message(code: 'default.reset.message', default:'Password reset successful.', args: [message(code: 'UserMaster.label', default: 'UserMaster'), userMasterInstance.id])
                flash.message = 'Password reset successful.|success|alert'
                redirect userMasterInstance
            }
            '*'{ respond userMasterInstance, [status: OK] }
        }
    }

    def generatePassword() {
        String charset = (('A'..'Z') + ('a'..'z') + ('0'..'9')).join()
        Integer length = Institution.findByParamCode('SEC.20020').paramValue.toInteger()
        String randomString = RandomStringUtils.random(length, charset.toCharArray())

        def data = [password:randomString]

        render(contentType:'text/json') {
           data
        }
    }

    def changePassword() {
        println params.msg
        //respond flash.message
        def var = params.msg
        render(view: "changePassword", model: [msg: var])
    }

    @Transactional
    def saveChangePassword() {
        def userMasterInstance = UserMaster.get(session.user_id)

        def minLength = Institution.findByParamCode('SEC.20020').paramValue.toInteger()
        def pwd = params.newPassword

        if(userMasterInstance.password != params.password.encodeAsMD5()) {
            flash.message = "Current password is incorrect.|error|alert"
            redirect(action:"changePassword", params: [msg: flash.message])
            return
        }

        if(params.newPassword != params. confirmNewPassword) {
            flash.message = "Passwords do not match.|error|alert"
            redirect(action:"changePassword", params: [msg: flash.message])
            return
        }

        // Check if valid password
        if(params.newPassword.length() < minLength) {
            flash.message = "Minimum password length is " + minLength + " characters.|error|alert"
            redirect(action:"changePassword", params: [msg: flash.message])
            return
        }

        // Check if recently used
        def recentlyUsedPassword = PasswordHistory.findAllByUserMaster(userMasterInstance, [max:4, sort:"id", order:"desc"]).password
        if(params.newPassword.encodeAsMD5() in recentlyUsedPassword) {
            flash.message = "Password already used before. Create a new one.|error|alert"
            redirect(action:"changePassword", params: [msg: flash.message])
            return
        }

        // Check password complexity
        if(!(pwd.find(/[A-Z]/) && pwd.find(/[a-z]/) && pwd.find(/[0-9]/))) {
            flash.message = "Password must contain at least one uppercase, lowercase, and numeric character.|error|alert"
            redirect(action:"changePassword", params: [msg: flash.message])
            return
        }
        // special characters
        if (Institution.findByParamCode('SEC.20035').paramValue == 'TRUE') {
            if(!(pwd.find(/[A-Z]/) && pwd.find(/[a-z]/) && pwd.find(/[~!@#$%^&*()-+]/) && pwd.find(/[0-9]/))) {
                flash.message = "Password must contain at least one uppercase, lowercase, numeric and special characters.|error|alert"
                redirect(action:"changePassword", params: [msg: flash.message])
                return
            }               
        }

        // Password Expiry
        def passwordValidity = Institution.findByParamCode('SEC.20040').paramValue.toInteger()
        
        def branchRunDate = Branch.findById(session.branch_id).runDate
        
        userMasterInstance.expiryPwdDate = branchRunDate.plus(passwordValidity)
        //userMasterInstance.expiryDate = new Date().plus(passwordValidity)

        userMasterInstance.password = params.newPassword.encodeAsMD5()
        userMasterInstance.isFirstLogin = false
        userMasterInstance.save flush:true

        flash.message = "You have successfully updated your password.|success|alert"

        // Password History
        PasswordHistory ph = new PasswordHistory(userMaster:userMasterInstance, password:params.newPassword.encodeAsMD5(), dateUsed:new Date()).save(flush:true)

        // Log
        auditLogService.insert('040', 'BAS00300', 'Change Password - ' + userMasterInstance.username, null, null, null, null, userMasterInstance.id)

        //redirect(controller:'home')
         //redirect(action:"changePassword")
         redirect(action:"PasswordSuccess")
                return
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'userMaster.label', default: 'UserMaster'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    def PasswordSuccess() {
        // render new page
        def userMasterInstance = UserMaster.get(session.user_id)
        respond userMasterInstance
    }
    
    def updateRoles(UserMaster userMasterInstance, def roles) {

        println "rolesssss : " + roles;
        // add items that are selected
        for (id in roles) {
            def role = Role.get(id) 
            def link = UserRole.findByUserMasterAndRole(userMasterInstance, role)

            println role //+ ' - ' + userMasterInstance
            
            if (!link) {
                (new UserRole(userMaster:userMasterInstance, role:role, configItemStatus:ConfigItemStatus.get(2))).save flush:true
            }
        }
        
        // remove items not selected
        for (role in userMasterInstance.roles) {
            if (role) {
                if (!(roles.contains(role.id.toString()))) {  // if existing, delete
                    def link = UserRole.findByUserMasterAndRole(userMasterInstance, role)
                    link.delete flush:true   
                }
            } else {  // if there are no selected items, delete every item
                def link = UserRole.findByUserMasterAndRole(userMasterInstance, role)
                link.delete flush:true   
            }
        }
    }

    // Generate list of users
    def createReport = {

        def users = UserMaster.list()
        println users
        chain(controller:'jasper',action:'index',model:[data:users],params:params)

    }
}
