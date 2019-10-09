package icbs.gl



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class TxnGlLinkController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def index(Integer max) {
        params.max = Math.min(max ?: 25, 100)
        if(params.offset==null){
            params.offset=0
        }
        if (params.query == null) {
            respond TxnGlLink.list(params), model:[params:params,TxnGlLinkInstanceCount:  TxnGlLink.count()]
            return
        }
        else{
            def TxnGlLinkList = TxnGlLink.createCriteria().list (params) {
                
            }
            respond TxnGlLinkList, model:[params:params,TxnGlLinkInstanceCount: TxnGlLinkList.totalCount]
        }
        return
    }

    def show(TxnGlLink txnGlLinkInstance) {
        respond txnGlLinkInstance
    }

    def create() {
        respond new TxnGlLink(params)
    }

    @Transactional
    def save(TxnGlLink txnGlLinkInstance) {
        if (txnGlLinkInstance == null) {
            notFound()
            return
        }

        if (txnGlLinkInstance.hasErrors()) {
            respond txnGlLinkInstance.errors, view:'create'
            return
        }

        txnGlLinkInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'txnGlLink.label', default: 'TxnGlLink'), txnGlLinkInstance.id])
                redirect txnGlLinkInstance
            }
            '*' { respond txnGlLinkInstance, [status: CREATED] }
        }
    }

    def edit(TxnGlLink txnGlLinkInstance) {
        respond txnGlLinkInstance
    }

    @Transactional
    def update(TxnGlLink txnGlLinkInstance) {
        if (txnGlLinkInstance == null) {
            notFound()
            return
        }

        if (txnGlLinkInstance.hasErrors()) {
            respond txnGlLinkInstance.errors, view:'edit'
            return
        }

        txnGlLinkInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'TxnGlLink.label', default: 'TxnGlLink'), txnGlLinkInstance.id])
                redirect txnGlLinkInstance
            }
            '*'{ respond txnGlLinkInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(TxnGlLink txnGlLinkInstance) {

        if (txnGlLinkInstance == null) {
            notFound()
            return
        }

        txnGlLinkInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'TxnGlLink.label', default: 'TxnGlLink'), txnGlLinkInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'txnGlLink.label', default: 'TxnGlLink'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
