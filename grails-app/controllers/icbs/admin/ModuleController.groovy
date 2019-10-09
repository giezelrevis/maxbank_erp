package icbs.admin



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ModuleController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def index(Integer max) {
        params.max = Math.min(max ?: 200, 300)
        if(params.offset==null){
            params.offset=0
        }
        if (params.query == null) {
            respond Module.list(params), model:[params:params,ModuleInstanceCount:  Module.count()]
            return
        }
        else{
            def ModuleList = Module.createCriteria().list (params) {
                
            }
            respond ModuleList, model:[params:params,ModuleInstanceCount: ModuleList.totalCount]
        }
        return
    }

    // def show(Module moduleInstance) {
    //     respond moduleInstance
    // }

    // def create() {
    //     respond new Module(params)
    // }

    // @Transactional
    // def save(Module moduleInstance) {
    //     if (moduleInstance == null) {
    //         notFound()
    //         return
    //     }

    //     if (moduleInstance.hasErrors()) {
    //         respond moduleInstance.errors, view:'create'
    //         return
    //     }

    //     moduleInstance.save flush:true

    //     request.withFormat {
    //         form multipartForm {
    //             flash.message = message(code: 'default.created.message', args: [message(code: 'module.label', default: 'Module'), moduleInstance.id])
    //             redirect moduleInstance
    //         }
    //         '*' { respond moduleInstance, [status: CREATED] }
    //     }
    // }

    // def edit(Module moduleInstance) {
    //     respond moduleInstance
    // }

    // @Transactional
    // def update(Module moduleInstance) {
    //     if (moduleInstance == null) {
    //         notFound()
    //         return
    //     }

    //     if (moduleInstance.hasErrors()) {
    //         respond moduleInstance.errors, view:'edit'
    //         return
    //     }

    //     moduleInstance.save flush:true

    //     request.withFormat {
    //         form multipartForm {
    //             flash.message = message(code: 'default.updated.message', args: [message(code: 'Module.label', default: 'Module'), moduleInstance.id])
    //             redirect moduleInstance
    //         }
    //         '*'{ respond moduleInstance, [status: OK] }
    //     }
    // }

    // @Transactional
    // def delete(Module moduleInstance) {

    //     if (moduleInstance == null) {
    //         notFound()
    //         return
    //     }

    //     moduleInstance.delete flush:true

    //     request.withFormat {
    //         form multipartForm {
    //             flash.message = message(code: 'default.deleted.message', args: [message(code: 'Module.label', default: 'Module'), moduleInstance.id])
    //             redirect action:"index", method:"GET"
    //         }
    //         '*'{ render status: NO_CONTENT }
    //     }
    // }

    // protected void notFound() {
    //     request.withFormat {
    //         form multipartForm {
    //             flash.message = message(code: 'default.not.found.message', args: [message(code: 'module.label', default: 'Module'), params.id])
    //             redirect action: "index", method: "GET"
    //         }
    //         '*'{ render status: NOT_FOUND }
    //     }
    // }
}
