package icbs.security

import icbs.admin.UserMaster
import icbs.admin.Branch
import icbs.admin.Institution
import icbs.admin.PolicyTemplate
import icbs.security.UserSession
import java.net.NetworkInterface
import icbs.tellering.TxnTellerBalance
import icbs.admin.TxnTemplate


import icbs.lov.ConfigItemStatus

class AuthenticationController {

    def auditLogService
    def loginAttemptService
    def userMasterService
    def policyService

    def index() { }

    def login() {
        if(session.user) {
            redirect(controller:"home", action:"landing")
        }
    }

    def authenticate() {
        // Unauthorized access to action
        if(!params.username) {
            redirect(action:"login")
            return
        }
        
        // do not allow login if system is locked
        def sysLocked = Institution.findByParamCode('GEN.10250').paramValue
        if(sysLocked == 'TRUE') {
            flash.error = "System is locked for periodic operations. Contact Administrator."
            redirect(action:"login")
            return
        }
        
    	// Validate username
        def validUsername = UserMaster.findByUsername(params.username)
        def user = null

        // Valid username
        if(validUsername) {
            user = UserMaster.findByUsernameAndPassword(params.username, params.password.encodeAsMD5())

            // Invalid password
            if(!user) {
                loginAttemptService.insert(validUsername, 0)

                // Check number of attempts
                def validAttempts = loginAttemptService.checkAttempts(validUsername)

                if(!validAttempts) {
                    validUsername.hasExceededMaxLogin = true
                    validUsername.save flush:true
                    println 'd username'+ params.username
                    // Log
                    auditLogService.insert('010', 'BAS00200', 'User '+ params.username+ ' has been Locked for exceeding max login attempts' , 'userMaster', null, null, null, UserMaster.findByUsername(params.username).id)
            
                    flash.error = "User is locked because of exceeding maximum number of login attempts. Contact Administrator."
                    redirect(action:"login")
                    return
                }

                flash.error = "Invalid username or password. Please try again."
                redirect(action:"login")
                return
            }
        }

        // Valid user
        if(user) {
            // Check if user is deleted
            if(user.configItemStatus == ConfigItemStatus.get(3)) {
                flash.error = "Invalid user."
                auditLogService.insert('010', 'BAS00100', 'Attemted Login ' + params.username, '', null, null, null,null)
                redirect(action:"login")
                return
            }

            // Check if user password has expired
            if(user.expiryDate <= Branch.get(1).runDate) {
                flash.error = "User access has expired. Contact Administrator."
                auditLogService.insert('010', 'BAS00100', 'Attemted Login ' + params.username, '', null, null, null,null)
                redirect(action:"login")
                return
            }

            // Check if locked
            if(user.isLocked) {
                flash.error = "User is locked. Contact Administrator."
                auditLogService.insert('010', 'BAS00100', 'Attemted Login ' + params.username, '', null, null, null,null)
                redirect(action:"login")
                return
            }

            // Check if locked because of exceeding maximum attempt
            if(user.hasExceededMaxLogin) {
                flash.error = "User is locked because of exceeding maximum number of login attempts. Contact Administrator."
                auditLogService.insert('010', 'BAS00100', 'Attemted Login ' + params.username, '', null, null, null,null)
                redirect(action:"login")
                return
            }

            // Check if logged in other terminal
            def loggedInOtherTerminal = UserSession.createCriteria().list {
                 eq("userMaster", user)
                 isNull("logout")
                }
            if(loggedInOtherTerminal.size() > 0) {
       
                    flash.error = "You are logged in other terminal."
                    auditLogService.insert('010', 'BAS00100', 'Attemted Login ' + params.username, '', null, null, null,null)
                    redirect(action:"login")
                    return
	        }
                
           // force logout
           /*
           if(loggedInOtherTerminal.size() > 0) {
                for (login in loggedInOtherTerminal){
                    login.logout = new Date().toTimestamp()
                    login.save(Flush:true)
                    }
                 } 
                 */

            // User session
            def userSession = new UserSession(userMaster:user, login:new Date()).save()

        	// session.user = user
            session.user_id = user.id
            String name1 = ''
            String name2 = ''
            String name3 = ''
            if (user.name1) {
                name1 = user.name1
            }
            if (user.name2) {
                name2 = user.name2
            }
            if (user.name3) {
                name3 = user.name3
            }            
            session.user = name1 + " " + name2 + " " + name3 + " (" + user.username + ")"
            session.branch = user.branch.name
            session.branch_id = user.branchId
            session.session_id =userSession.id
            session.session_timeout = Institution.findByParamCode('SEC.20080').paramValue

            // init tellerbalance
            
            
            //if(!TxnTellerBalance.findAllByUserAndTxnDate(user,Branch.get(user.branchId).runDate))
            //{
            //    println "not yet inserted in tellerbalance"
            userMasterService.initTellerBalance()
                //initTellerBalance()
           // }
            // Successful Login Attempt
            loginAttemptService.insert(user, 1)

            // Log
            println session.session_id
            auditLogService.insert('020', 'BAS00100', 'Login ' + session.user, 'session', null, null, null,session.session_id)

            // Check if first login
            if(user.isFirstLogin) {
                redirect(controller:"userMaster", action:"changePassword")
                return
            }
            
            // Check if password is about to expire
            //println(session.branch_id)
            
            def branchRunDate = Branch.findById(session.branch_id).runDate
            
            if((user.expiryPwdDate - branchRunDate) <= 7) {
                flash.error = "Password will expire in " + (user.expiryPwdDate - branchRunDate) + " days. Change your password to avoid locking of account."
                redirect(controller:"userMaster", action:"changePassword")
                return
            }
            
            redirect(controller:"home", action:"landing")	
        }
        else{
	        flash.error = "Invalid username or password. Please try again."
	        redirect(action:"login")
        }
    }

    // no longer being user 
    def logout() {                
        if(session.user) {
            // Check if user is a teller and if balanced
            
            // this menu has been changed to teller balancing
            // logout is performed using conditional logout function
            //if(!userMasterService.checkIfTellerBalanced()) {
                println 'redirect'
                redirect(controller:"tellering", action:"viewTellerBalancing")
                return
            //}

            // User session
            def userSession = UserSession.findByUserMasterAndLogout(UserMaster.get(session.user_id), null)
            if(userSession) {
                userSession.logout = new Date()
                userSession.save(flush:true)
            }

            flash.success = "You have successfully logged out."
            session.user = null

            // Log
            auditLogService.insert('160', 'BAS00200', 'Logout ' + UserMaster.get(session.user_id).username, 'session', null, null, null, session.session_id)
            // auditLogService.insert('160', 'BAS00200', null, null, null)
        } 
        redirect(action:"login")
    }
    
    def forcelogout()
    {
        if(session.user) {
            // Check if user is a teller and if balanced
            
            // User session
            def userSession = UserSession.findByUserMasterAndLogout(UserMaster.get(session.user_id), null)
            if(userSession) {
                userSession.logout = new Date()
                userSession.save(flush:true)
            }

            // Log
            auditLogService.insert('160', 'BAS00100', 'Force Logout ' + session.user, 'session', null, null, null,session.session_id)
            //auditLogService.insert('170', 'BAS00200', 'Forced Logout ' + UserMaster.get(session.user_id).username, 'session', null, null, null, session.session_id)
            // auditLogService.insert('160', 'BAS00200', null, null, null)
            
            flash.success = "Forced logged out."
            session.user = null
        } 
        redirect(action:"login")
        
    }
    def conditionallogout(){
        // check if last user and system locked
        println("checking system lock status....")
        def sysLocked = Institution.findByParamCode('GEN.10250').paramValue
        if(sysLocked == 'TRUE') {
            println("system lock status: TRUE")
            def lastSession = UserSession.findAllByLogoutIsNull()
            Integer sCount = 0
            for (ls in lastSession) {
                sCount++
            }
            if (sCount == 1){
                flash.error = "System is locked for periodic operations. Cannot Logout."
                redirect(controller:"periodicOps", action:"index")                
                return
            }          
        }
        println("system lock status: FALSE")
        if(session.user) {
            // Check if user is a teller and if balanced
            
            // User session
            def userSession = UserSession.findByUserMasterAndLogout(UserMaster.get(session.user_id), null)
            if(userSession) {
                userSession.logout = new Date()
                userSession.save(flush:true)
            }

            // Log
            auditLogService.insert('160', 'BAS00100', 'logout ' + session.user, 'session', null, null, null,session.session_id)
            //auditLogService.insert('180', 'BAS00200', 'User Logout ' + UserMaster.get(session.user_id).username, 'session', null, null, null, session.session_id)
            // auditLogService.insert('160', 'BAS00200', null, null, null)
            
            flash.success = "User Logout Completed"
            session.user = null            
        } 
        redirect(action:"login")
        
    }

    def overrideAuthenticate() {
        def message = ''
        def isAllowed = true
        def user = UserMaster.findByUsernameAndPassword(params.username, params.password.encodeAsMD5())

        def policydetails = PolicyTemplate.findByCode(params.policyCode)
        //println 'overrideAuthenticate params:' + policydetails.description
        if (!policydetails) {
            // assume transaction based override
            def txnPolicy = TxnTemplate.findByCode(params.policyCode)
            if (!txnPolicy) {
                message = 'Policy configuration error!!!'
                isAllowed = false                
            } else {
                def policyDesc = txnPolicy.description
                def isAllowedToOverride = policyService.isAllowedToOverrideTxn(params.policyCode, 0, user);
                if(!isAllowedToOverride) {
                    message = 'No permission to override.'
                    isAllowed = false
                }
                else {
                    //log of override process/transaction
                    println 'auditLogService.insert'
                    def moduleCode = 'TLR00000'
                    auditLogService.insert('170', moduleCode, params.username+ ' authorized processing of '+ policyDesc +' requested by ' + UserMaster.get(session.user_id).username, null, null, null, null, null)
                }            
            }
        } else {
            def policyDesc = policydetails.description
            def isAllowedToOverride = policyService.isAllowedToOverride(params.policyCode, user);
            if(!isAllowedToOverride) {
                message = 'No permission to override.'
                isAllowed = false
            }
            else{
                //log of override process/transaction
                auditLogService.insert('170', params.policyCode.take(3)+'00000', params.username+ ' authorized processing of '+ policyDesc +' requested by ' + UserMaster.get(session.user_id).username, null, null, null, null, null)
            }           
        }
        if(!user) {
            message = 'Invalid user credentials.'
            isAllowed = false
        }



        response.setContentType("application/json")
        render '{"isAllowed":"' + isAllowed + '", "message":"' + message +'"}'
    }
}
