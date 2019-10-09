package icbs.admin



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PolicyExceptionController {

    def auditLogService
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        println 'policy in'
        println("params of search: "+params)
        //HttpSession session = RequestContextHolder.currentRequestAttributes().getSession()
        
        if(params.offset==null){
            params.offset=0
        }
        if (params.query == null) {
           
            def policyInstance = PolicyException.createCriteria().list (params) {
                and {
                    eq("requestingUser",UserMaster.get(session.user_id))
                }
                order("dateOfRequest", "desc")
            }
            respond policyInstance, model:[params:params,PolicyExceptionInstanceCount:  policyInstance.totalCount]  
        }
        else{
            def PolicyExceptionList = PolicyException.createCriteria().list (params) {
                and {
                    eq("requestingUser",UserMaster.get(session.user_id))
                }
                or {
                    ilike("recordUrl", "%${params.query}%")
                }
                order("dateOfRequest", "desc")
            }
            respond PolicyExceptionList, model:[params:params,PolicyExceptionInstanceCount: PolicyExceptionList.totalCount]
        }
        return
    }

    def show(PolicyException policyExceptionInstance) {
        respond policyExceptionInstance
    }

    def create() {
        respond new PolicyException(params)
    }

    @Transactional
    def save(PolicyException policyExceptionInstance) {
        if (policyExceptionInstance == null) {
            notFound()
            return
        }

        if (policyExceptionInstance.hasErrors()) {
            respond policyExceptionInstance.errors, view:'create'
            return
        }

        policyExceptionInstance.save flush:true


        // Log
        def description = 'save Policy Exception ' 
        auditLogService.insert('040', 'AUD00400', description, 'policyException', null, null, null)


        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'policyException.label', default: 'PolicyException'), policyExceptionInstance.id])
                redirect policyExceptionInstance
            }
            '*' { respond policyExceptionInstance, [status: CREATED] }
        }
    }

    def edit(PolicyException policyExceptionInstance) {
        respond policyExceptionInstance
    }

    @Transactional
    def update(PolicyException policyExceptionInstance) {
        if (policyExceptionInstance == null) {
            notFound()
            return
        }

        if (policyExceptionInstance.hasErrors()) {
            respond policyExceptionInstance.errors, view:'edit'
            return
        }

        policyExceptionInstance.save flush:true


        // Log
        def description = 'update Policy Exception ' +  
        auditLogService.insert('040', 'AUD00400', description, 'policyException', null, null, null)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PolicyException.label', default: 'PolicyException'), policyExceptionInstance.id])
                redirect policyExceptionInstance
            }
            '*'{ respond policyExceptionInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(PolicyException policyExceptionInstance) {

        if (policyExceptionInstance == null) {
            notFound()
            return
        }

        policyExceptionInstance.delete flush:true


        // Log
        def description = 'delete Policy Exception ' 
        auditLogService.insert('040', 'AUD00400', description, 'policyException', null, null, null)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'PolicyException.label', default: 'PolicyException'), policyExceptionInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'policyException.label', default: 'PolicyException'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
