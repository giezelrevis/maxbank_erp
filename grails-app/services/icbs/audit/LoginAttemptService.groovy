package icbs.audit

import org.codehaus.groovy.grails.web.util.WebUtils
import javax.servlet.http.HttpSession
import org.springframework.web.context.request.RequestContextHolder
import grails.transaction.Transactional
import static java.util.Calendar.*
import groovy.time.*

import icbs.admin.UserMaster
import icbs.admin.Institution

@Transactional
class LoginAttemptService {

    def insert(UserMaster userMaster, Integer status) {
    	def webUtils = WebUtils.retrieveGrailsWebRequest()
    	def request = webUtils.getCurrentRequest()
    	def ipAddress = request.getRemoteAddr()

    	def loginAttempt = new LoginAttempt()
    	loginAttempt.date = new Date()
    	loginAttempt.userMaster = userMaster
    	loginAttempt.ipAddress = ipAddress
    	loginAttempt.status = status
    	loginAttempt.save(flush:true)
    }

    def checkAttempts(UserMaster userMaster) {
        def maxAttempts = Institution.findByParamCode("SEC.20060").paramValue.toInteger()
        def invalidPeriod = new TimeDuration(0, 3, 0, 0) // 3 min. If consecutive attempts is within 3min, account is locked.

    	def attempts = LoginAttempt.findAllByUserMaster(userMaster, [max:maxAttempts, sort:"date", order:"desc"])

        def hasValidLogin = false

        if(attempts.size() < maxAttempts) {
            return true
        }

        for(int i=0; i<attempts.size(); i++) {
            if(attempts[i].status == 1) {
                hasValidLogin = true
                break
            }
        }

        if(hasValidLogin) {
            return true
        }

        TimeDuration timeElapsed = TimeCategory.minus( attempts[0].date.toTimestamp(), attempts[attempts.size()-1].date.toTimestamp() )
        
        if (timeElapsed < invalidPeriod) {
            return false
        }
        else {
            return true
        }
    }
}
