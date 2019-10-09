package icbs.gl



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class GlSortCodeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        if(params.offset==null){
            params.offset=0
        }
        if (params.query == null) {
            respond GlSortCode.list(params), model:[params:params,GlSortCodeInstanceCount:  GlSortCode.count()]
            return
        }
        else{
            def GlSortCodeList = GlSortCode.createCriteria().list (params) {
            or  {
                    ilike("sort_code", "%${params.query}%")
                    ilike("sort_name","%${params.query}%")
                }
                order("sort_code", "asc")                
            }
            respond GlSortCodeList, model:[params:params,GlSortCodeInstanceCount: GlSortCodeList.totalCount]
        }
        return
    }

    def show(GlSortCode glSortCodeInstance) {
        respond glSortCodeInstance
    }

    def create() {
        respond new GlSortCode(params)
    }

    @Transactional
    def save(GlSortCode glSortCodeInstance) {
        if (glSortCodeInstance == null) {
            notFound()
            return
        }

        if (glSortCodeInstance.hasErrors()) {
            respond glSortCodeInstance.errors, view:'create'
            return
        }
        
        def duplicateValue = GlSortCode.findAllWhere(sort_code:glSortCodeInstance.sort_code)
        if (duplicateValue) {
            flash.message = 'Duplicate sort code'
            respond glSortCodeInstance.errors, view:'create'
            return            
        }

        glSortCodeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'glSortCode.label', default: 'GlSortCode'), glSortCodeInstance.id])
                redirect glSortCodeInstance
            }
            '*' { respond glSortCodeInstance, [status: CREATED] }
        }
    }

    def edit(GlSortCode glSortCodeInstance) {
        respond glSortCodeInstance
    }

    @Transactional
    def update(GlSortCode glSortCodeInstance) {
        if (glSortCodeInstance == null) {
            notFound()
            return
        }

        if (glSortCodeInstance.hasErrors()) {
            respond glSortCodeInstance.errors, view:'edit'
            return
        }

        glSortCodeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'GlSortCode.label', default: 'GlSortCode'), glSortCodeInstance.id])
                redirect glSortCodeInstance
            }
            '*'{ respond glSortCodeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(GlSortCode glSortCodeInstance) {

        if (glSortCodeInstance == null) {
            notFound()
            return
        }

        glSortCodeInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'GlSortCode.label', default: 'GlSortCode'), glSortCodeInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'glSortCode.label', default: 'GlSortCode'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
