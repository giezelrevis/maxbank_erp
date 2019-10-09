package icbs.admin



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import icbs.lov.ConfigItemStatus

@Transactional(readOnly = true)
class ClearingBankController {
    
    def auditLogService
    
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        if(params.offset==null){
            params.offset=0
        }
        if (params.query == null) {
            respond ClearingBank.list(params), model:[params:params,ClearingBankInstanceCount:  ClearingBank.count()]
            return
        }
        else{
            def ClearingBankList = ClearingBank.createCriteria().list (params) {
                or {
                    ilike("code", "%${params.query}%")
                    ilike("name", "%${params.query}%")
                    ilike("shortName", "%${params.query}%")
                }
            }
            respond ClearingBankList, model:[params:params,ClearingBankInstanceCount: ClearingBankList.totalCount]
        }
        return
    }

    def show(ClearingBank clearingBankInstance) {
        respond clearingBankInstance
    }

    def create() {
        respond new ClearingBank(params)
    }

    @Transactional
    def save(ClearingBank clearingBankInstance) {
        clearingBankInstance.configItemStatus = ConfigItemStatus.get(2)

        if (clearingBankInstance == null) {
            notFound()
            return
        }

        if (clearingBankInstance.hasErrors()) {
            respond clearingBankInstance.errors, view:'create'
            return
        }

        clearingBankInstance.save flush:true

        // params.branches.each {
        //     BranchClearingBank bcb = new BranchClearingBank(branch:it, clearingBank:clearingBankInstance, configItemStatus:ConfigItemStatus.get(2)).save(flush:true)
        // }


        // Log
        def description = 'save new Clearing Bank ' +  clearingBankInstance.shortName
        auditLogService.insert('040', 'CFG00300', description, 'clearingBank', null, null, null, clearingBankInstance.id)


        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'clearingBank.label', default: 'ClearingBank'), clearingBankInstance.id])
                redirect clearingBankInstance
            }
            '*' { respond clearingBankInstance, [status: CREATED] }
        }
    }

    def edit(ClearingBank clearingBankInstance) {
        respond clearingBankInstance
    }

    @Transactional
    def update(ClearingBank clearingBankInstance) {
        if (clearingBankInstance == null) {
            notFound()
            return
        }

        if (clearingBankInstance.hasErrors()) {
            respond clearingBankInstance.errors, view:'edit'
            return
        }

        clearingBankInstance.save flush:true

        // params.branches.each {
        //     def bcb = BranchClearingBank.findAllByBranchAndClearingBank(Branch.get(it),clearingBankInstance)

        //     if(!bcb) {
        //         BranchClearingBank newBCB = new BranchClearingBank(branch:it, clearingBank:clearingBankInstance, configItemStatus:ConfigItemStatus.get(2)).save(flush:true)
        //     }
        // }


        // Log
        def description = 'update Clearing Bank ' +  clearingBankInstance.shortName
        auditLogService.insert('040', 'CFG00300', description, 'clearingBank', null, null, null, clearingBankInstance.id)


        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'ClearingBank.label', default: 'ClearingBank'), clearingBankInstance.id])
                redirect clearingBankInstance
            }
            '*'{ respond clearingBankInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(ClearingBank clearingBankInstance) {
        clearingBankInstance.configItemStatus = ConfigItemStatus.get(3)

        if (clearingBankInstance == null) {
            notFound()
            return
        }

        clearingBankInstance.save flush:true

        // Log
        def description = 'delete Clearing Bank ' +  clearingBankInstance.shortName
        auditLogService.insert('040', 'CFG00300', description, 'clearingBank', null, null, null, clearingBankInstance.id)


        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'ClearingBank.label', default: 'ClearingBank'), clearingBankInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'clearingBank.label', default: 'ClearingBank'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
