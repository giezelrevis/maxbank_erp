package icbs.admin



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import icbs.lov.ConfigItemStatus

@Transactional(readOnly = true)
class CustomerGroupController {
    
    def auditLogService
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
         params.max = Math.min(max ?: 10, 100)

        if (params.sort == null) {  // default ordering
            params.sort = "code"
        }

        if (params.query == null) {  // show all instances            
            respond CustomerGroup.list(params), model:[CustomerGroupInstanceCount: CustomerGroup.count()]
        }
        else {    // show query results
            def customerGroupList = CustomerGroup.createCriteria().list(params) {
                or {
                    ilike("code", "%${params.query}%")
                    ilike("name", "%${params.query}%")
                }
            }
            respond customerGroupList, model:[CustomerGroupInstanceCount: customerGroupList.totalCount]
        }
    }

    def show(CustomerGroup customerGroupInstance) {
        respond customerGroupInstance
    }

    def create() {
        respond new CustomerGroup(params)
    }

    @Transactional
    def save(CustomerGroup customerGroupInstance) {
        customerGroupInstance.configItemStatus = ConfigItemStatus.get(2)

        if (customerGroupInstance == null) {
            notFound()
            return
        }

        if (customerGroupInstance.hasErrors()) {
            respond customerGroupInstance.errors, view:'create'
            return
        }

        customerGroupInstance.save flush:true

        // Log
        def description = 'save new Customer Group ' +  customerGroupInstance.name
        auditLogService.insert('040', 'CFG00600', description, 'customerGroup', null, null, null, customerGroupInstance.id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'customerGroup.label', default: 'CustomerGroup'), customerGroupInstance.id])
                redirect customerGroupInstance
            }
            '*' { respond customerGroupInstance, [status: CREATED] }
        }
    }

    def edit(CustomerGroup customerGroupInstance) {
        respond customerGroupInstance
    }

    @Transactional
    def update(CustomerGroup customerGroupInstance) {
        if (customerGroupInstance == null) {
            notFound()
            return
        }

        if (customerGroupInstance.hasErrors()) {
            respond customerGroupInstance.errors, view:'edit'
            return
        }

        customerGroupInstance.save flush:true

        // Log
        def description = 'update Customer Group ' +  customerGroupInstance.name
        auditLogService.insert('040', 'CFG00600', description, 'customerGroup', null, null, null, customerGroupInstance.id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'CustomerGroup.label', default: 'CustomerGroup'), customerGroupInstance.id])
                redirect customerGroupInstance
            }
            '*'{ respond customerGroupInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(CustomerGroup customerGroupInstance) {
        customerGroupInstance.configItemStatus = ConfigItemStatus.get(3)

        if (customerGroupInstance == null) {
            notFound()
            return
        }

        customerGroupInstance.save flush:true

        // Log
        def description = 'delete Customer Group ' +  customerGroupInstance.name
        auditLogService.insert('040', 'CFG00600', description, 'customerGroup', null, null, null, customerGroupInstance.id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'CustomerGroup.label', default: 'CustomerGroup'), customerGroupInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'customerGroup.label', default: 'CustomerGroup'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
