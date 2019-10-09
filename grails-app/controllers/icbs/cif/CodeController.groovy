package icbs.cif



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CodeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        if(params.offset==null){
            params.offset=0
        }
        if (params.query == null) {
            respond Code.list(params), model:[params:params,CodeInstanceCount:  Code.count()]
            return
        }
        else{
            def CodeList = Code.createCriteria().list (params) {
                
            }
            respond CodeList, model:[params:params,CodeInstanceCount: CodeList.totalCount]
        }
        return
    }

    def show(Code codeInstance) {
        respond codeInstance
    }

    def create() {
        respond new Code(params)
    }

    @Transactional
    def save(Code codeInstance) {
        if (codeInstance == null) {
            notFound()
            return
        }

        if (codeInstance.hasErrors()) {
            respond codeInstance.errors, view:'create'
            return
        }

        codeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'code.label', default: 'Code'), codeInstance.id])
                redirect codeInstance
            }
            '*' { respond codeInstance, [status: CREATED] }
        }
    }

    def edit(Code codeInstance) {
        respond codeInstance
    }

    @Transactional
    def update(Code codeInstance) {
        if (codeInstance == null) {
            notFound()
            return
        }

        if (codeInstance.hasErrors()) {
            respond codeInstance.errors, view:'edit'
            return
        }

        codeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Code.label', default: 'Code'), codeInstance.id])
                redirect codeInstance
            }
            '*'{ respond codeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Code codeInstance) {

        if (codeInstance == null) {
            notFound()
            return
        }

        codeInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Code.label', default: 'Code'), codeInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'code.label', default: 'Code'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
