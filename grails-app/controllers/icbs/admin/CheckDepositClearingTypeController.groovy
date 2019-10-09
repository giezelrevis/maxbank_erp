package icbs.admin



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import icbs.lov.ConfigItemStatus
import icbs.lov.BranchRunStatus
import icbs.admin.Branch

@Transactional(readOnly = true)
class CheckDepositClearingTypeController {
    def auditLogService
    
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        if (params.sort == null) {  // default ordering
            params.sort = "code"
        }

        if (params.query == null) {  // show all instances            
            respond CheckDepositClearingType.list(params), model:[CheckDepositClearingTypeInstanceCount: CheckDepositClearingType.count()]
        }
        else {    // show query results
            def checkDepositClearingTypeList = CheckDepositClearingType.createCriteria().list(params) {
                or {
                    ilike("code", "%${params.query}%")
                    ilike("description", "%${params.query}%")
                }
            }
            respond checkDepositClearingTypeList, model:[CheckDepositClearingTypeInstanceCount: checkDepositClearingTypeList.totalCount]
        }
    }

    def show(CheckDepositClearingType checkDepositClearingTypeInstance) {
        respond checkDepositClearingTypeInstance
        
    }

    def create() {
        respond new CheckDepositClearingType(params)
    }

    @Transactional
    def save(CheckDepositClearingType checkDepositClearingTypeInstance) {
        if (checkDepositClearingTypeInstance == null) {
            notFound()
            return
        }
        
        if (checkDepositClearingTypeInstance.hasErrors()) {
            respond checkDepositClearingTypeInstance.errors, view:'create'
            return
        }
        
        if (Branch.get(1).branchRunStatus != BranchRunStatus.get(2)) {
            flash.message = 'Cannot create Check Deposit Type - Branch already open |warn'
            respond checkDepositClearingTypeInstance.errors, view:'create'
            return
        }
        
        checkDepositClearingTypeInstance.configItemStatus = ConfigItemStatus.get(2)
        checkDepositClearingTypeInstance.save flush:true
        // audit log
        def description = 'save Check deposit clearing type ' + checkDepositClearingTypeInstance.description
        auditLogService.insert('040', 'CFG00400', description, 'checkDepositClearingType', null, null, null, checkDepositClearingTypeInstance.id)
        // params.branches.each {
        //     BranchCheckDepositClearingType var = new BranchCheckDepositClearingType(branch:it, checkDepositClearingType:checkDepositClearingTypeInstance, configItemStatus:ConfigItemStatus.get(2)).save(flush:true)
        // }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'checkDepositClearingType.label', default: 'CheckDepositClearingType'), checkDepositClearingTypeInstance.id])
                redirect checkDepositClearingTypeInstance
            }
            '*' { respond checkDepositClearingTypeInstance, [status: CREATED] }
        }
    }

    def edit(CheckDepositClearingType checkDepositClearingTypeInstance) {
        respond checkDepositClearingTypeInstance
    }

    @Transactional
    def update(CheckDepositClearingType checkDepositClearingTypeInstance) {
        if (checkDepositClearingTypeInstance == null) {
            notFound()
            return
        }

        if (checkDepositClearingTypeInstance.hasErrors()) {
            respond checkDepositClearingTypeInstance.errors, view:'edit'
            return
        }

        checkDepositClearingTypeInstance.save flush:true
        def description = 'Update Check deposit clearing type ' + checkDepositClearingTypeInstance.description
        auditLogService.insert('040', 'CFG00400', description, 'checkDepositClearingType', null, null, null, checkDepositClearingTypeInstance.id)
        // def branches = params.list('branches')

        // updateBranches(checkDepositClearingTypeInstance, branches)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'CheckDepositClearingType.label', default: 'CheckDepositClearingType'), checkDepositClearingTypeInstance.id])
                redirect checkDepositClearingTypeInstance
            }
            '*'{ respond checkDepositClearingTypeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(CheckDepositClearingType checkDepositClearingTypeInstance) {

        if (checkDepositClearingTypeInstance == null) {
            notFound()
            return
        }

        checkDepositClearingTypeInstance.configItemStatus = ConfigItemStatus.get(3)
        checkDepositClearingTypeInstance.save flush:true
        def description = 'Delete Check deposit clearing type ' + checkDepositClearingTypeInstance.description
        auditLogService.insert('040', 'CFG00400', description, 'checkDepositClearingType', null, null, null, checkDepositClearingTypeInstance.id)
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'CheckDepositClearingType.label', default: 'CheckDepositClearingType'), checkDepositClearingTypeInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'checkDepositClearingType.label', default: 'CheckDepositClearingType'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    // def updateBranches(CheckDepositClearingType checkDepositClearingTypeInstance, def branches) {
    //     // add items that are selected
    //     for (id in branches) {
    //         def branch = Branch.get(id) 
    //         def link = BranchCheckDepositClearingType.findByCheckDepositClearingTypeAndBranch(checkDepositClearingTypeInstance, branch)
            
    //         if (!link) {
    //             (new BranchCheckDepositClearingType(role:checkDepositClearingTypeInstance, branch:branch, configItemStatus:ConfigItemStatus.get(2))).save flush:true
    //         }
    //     }
        
    //     // remove items not selected
    //     for (branch in checkDepositClearingTypeInstance.branches) {
    //         if (branch) {
    //             if (!(branches.contains(branch.id.toString()))) {  // if existing, delete
    //                 def link = BranchCheckDepositClearingType.findByCheckDepositClearingTypeAndBranch(checkDepositClearingTypeInstance, branch)
    //                 link.delete flush:true   
    //             }
    //         } else {  // if there are no selected items, delete every item
    //             def link = BranchCheckDepositClearingType.findByCheckDepositClearingTypeAndBranch(checkDepositClearingTypeInstance, branch)
    //             link.delete flush:true   
    //         }
    //     }
    // }
}
