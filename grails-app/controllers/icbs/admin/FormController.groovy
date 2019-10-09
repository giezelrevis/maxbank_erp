package icbs.admin



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import icbs.lov.ConfigItemStatus

@Transactional(readOnly = true)
class FormController {

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        if(params.offset==null){
            params.offset=0
        }
        if (params.query == null) {
            respond Form.list(params), model:[params:params,FormInstanceCount:  Form.count()]
            return
        }
        else{
            def FormList = Form.createCriteria().list (params) {
                
            }
            respond FormList, model:[params:params,FormInstanceCount: FormList.totalCount]
        }
        return
    }

    def show(Form formInstance) {
        respond formInstance
    }

    def create() {
        respond new Form(params)
    }

    @Transactional
    def save(Form formInstance) {
        formInstance.configItemStatus = ConfigItemStatus.get(2)
        
        def file = request.getFile('file')
        
        if(file.empty) {
            flash.message = "File cannot be empty"
        } else {
            formInstance.sourceFile = servletContext.getRealPath("/") + "reports/" + file.originalFilename
            file.transferTo(new File(formInstance.sourceFile))
        }

        if (formInstance == null) {
            notFound()
            return
        }

        if (formInstance.hasErrors()) {
            respond formInstance.errors, view:'create'
            return
        }

        formInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'form.label', default: 'Form'), formInstance.id])
                redirect formInstance
            }
            '*' { respond formInstance, [status: CREATED] }
        }
    }

    def edit(Form formInstance) {
        respond formInstance
    }

    @Transactional
    def update(Form formInstance) {
        def file = request.getFile('file')
        
        if(file.empty) {
            flash.message = "File cannot be empty"
        } else {
            formInstance.sourceFile = servletContext.getRealPath("/") + "reports/" + file.originalFilename
            file.transferTo(new File(formInstance.sourceFile))
        }

        if (formInstance == null) {
            notFound()
            return
        }

        if (formInstance.hasErrors()) {
            respond formInstance.errors, view:'edit'
            return
        }

        formInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Form.label', default: 'Form'), formInstance.id])
                redirect formInstance
            }
            '*'{ respond formInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Form formInstance) {
        formInstance.configItemStatus = ConfigItemStatus.get(3)

        if (formInstance == null) {
            notFound()
            return
        }

        formInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Form.label', default: 'Form'), formInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'form.label', default: 'Form'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
