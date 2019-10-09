package icbs.gl



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class GlBatchHdrController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        if(params.offset==null){
            params.offset=0
        }
        if (params.query == null) {
            respond GlBatchHdr.list(params), model:[params:params,GlBatchHdrInstanceCount:  GlBatchHdr.count()]
            return
        }
        else{
            def GlBatchHdrList = GlBatchHdr.createCriteria().list (params) {
                
            }
            respond GlBatchHdrList, model:[params:params,GlBatchHdrInstanceCount: GlBatchHdrList.totalCount]
        }
        return
    }

    def show(GlBatchHdr glBatchHdrInstance) {
        respond glBatchHdrInstance
    }

    def create() {
        respond new GlBatchHdr(params)
    }

    @Transactional
    def save(GlBatchHdr glBatchHdrInstance) {
        if (glBatchHdrInstance == null) {
            notFound()
            return
        }

        if (glBatchHdrInstance.hasErrors()) {
            respond glBatchHdrInstance.errors, view:'create'
            return
        }

        glBatchHdrInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'glBatchHdr.label', default: 'GlBatchHdr'), glBatchHdrInstance.id])
                redirect glBatchHdrInstance
            }
            '*' { respond glBatchHdrInstance, [status: CREATED] }
        }
    }

    def edit(GlBatchHdr glBatchHdrInstance) {
        respond glBatchHdrInstance
    if (glBatchHdrInstance.isLocked == TRUE)
	{
		flash.message('Batch already updated')
		return
	}
    respond glBatchHdrInstance
    }
    

    @Transactional
    def update(GlBatchHdr glBatchHdrInstance) {
        if (glBatchHdrInstance == null) {
            notFound()
            return
        }

        if (glBatchHdrInstance.hasErrors()) {
            respond glBatchHdrInstance.errors, view:'edit'
            return
        }
        
        if (glBatchHdrInstance.isLocked == TRUE)
	{
		flash.message('Batch already updated')
		return
	}

        glBatchHdrInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'GlBatchHdr.label', default: 'GlBatchHdr'), glBatchHdrInstance.id])
                redirect glBatchHdrInstance
            }
            '*'{ respond glBatchHdrInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(GlBatchHdr glBatchHdrInstance) {

        if (glBatchHdrInstance == null) {
            notFound()
            return
        }

        glBatchHdrInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'GlBatchHdr.label', default: 'GlBatchHdr'), glBatchHdrInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'glBatchHdr.label', default: 'GlBatchHdr'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
