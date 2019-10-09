package icbs.tellering

import grails.transaction.Transactional
import javax.servlet.http.HttpSession
import org.springframework.web.context.request.RequestContextHolder
import icbs.lov.Designation
import icbs.admin.Branch
import icbs.admin.UserMaster

@Transactional
class IsTelleringActiveService {

    def disableTellering() {
        boolean active = false
    	HttpSession session = RequestContextHolder.currentRequestAttributes().getSession();
        
        def branch = UserMaster.get(session.user_id).branch

        branch.isTelleringActive = active
        branch.save(failOnError:true, validate:false)
    }
    
    def enableTellering() {
        boolean active = true
    	HttpSession session = RequestContextHolder.currentRequestAttributes().getSession();
        
        def branch = UserMaster.get(session.user_id).branch
        branch.isTelleringActive = active
        branch.save(failOnError:true, validate:false)
    }

}
