package icbs.admin



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import icbs.lov.ConfigItemStatus

@Transactional(readOnly = true)
class ReportController {

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        if(params.offset==null){
            params.offset=0
        }
        if (params.query == null) {
            respond Report.list(params), model:[params:params,ReportInstanceCount:  Report.count()]
            return
        }
        else{
            def ReportList = Report.createCriteria().list (params) {
                
            }
            respond ReportList, model:[params:params,ReportInstanceCount: ReportList.totalCount]
        }
        return
    }

    def show(Report reportInstance) {
        respond reportInstance
    }

    def create() {
        respond new Report(params)
    }

    @Transactional
    def save(Report reportInstance) {
        reportInstance.configItemStatus = ConfigItemStatus.get(2)

        def file = request.getFile('file')

        if(file.empty) {
            flash.message = "File cannot be empty"
        } else {
            reportInstance.sourceFile = servletContext.getRealPath("/") + "reports/" + file.originalFilename
            file.transferTo(new File(reportInstance.sourceFile))
        }

        if (reportInstance == null) {
            notFound()
            return
        }

        if (reportInstance.hasErrors()) {
            respond reportInstance.errors, view:'create'
            return
        }

        reportInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'report.label', default: 'Report'), reportInstance.id])
                redirect reportInstance
            }
            '*' { respond reportInstance, [status: CREATED] }
        }
    }

    def edit(Report reportInstance) {
        respond reportInstance
    }

    @Transactional
    def update(Report reportInstance) {
        def file = request.getFile('file')
        
        if(file.empty) {
            flash.message = "File cannot be empty"
        } else {
            reportInstance.sourceFile = servletContext.getRealPath("/") + "reports/" + file.originalFilename
            file.transferTo(new File(reportInstance.sourceFile))
        }

        if (reportInstance == null) {
            notFound()
            return
        }

        if (reportInstance.hasErrors()) {
            respond reportInstance.errors, view:'edit'
            return
        }

        reportInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Report.label', default: 'Report'), reportInstance.id])
                redirect reportInstance
            }
            '*'{ respond reportInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Report reportInstance) {
        reportInstance.configItemStatus = ConfigItemStatus.get(3)

        if (reportInstance == null) {
            notFound()
            return
        }

        reportInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Report.label', default: 'Report'), reportInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'report.label', default: 'Report'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
