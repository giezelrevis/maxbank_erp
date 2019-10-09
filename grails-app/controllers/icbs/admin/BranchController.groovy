    package icbs.admin



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import icbs.lov.BranchStatus

import icbs.lov.AuditType

@Transactional(readOnly = true)
class BranchController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def roleModuleService
    def auditLogService
    def policyService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        if (params.sort == null) {  // default ordering
            params.sort = "code"
        }

        if (params.query == null) {  // show all instances            
            respond Branch.list(params), model:[BranchInstanceCount: Branch.count()]
        }
        else {    // show query results
            def branchList = Branch.createCriteria().list(params) {
                or {
                    eq("code", params.int('query'))
                    ilike("name", "%${params.query}%")
                }
            }
            respond branchList, model:[BranchInstanceCount: branchList.totalCount]
        }
    }

    def show(Branch branchInstance) {
        def isPending = false
        def isAllowed = false
        if (branchInstance.status.code == '000') { // Create
            isPending = true
            if(policyService.isAllowed('ADM00202'))
                isAllowed = true
        }
        else if(branchInstance.status.code == '002') { // Delete
            isPending = true
            if(policyService.isAllowed('ADM00204'))
                isAllowed = true
        }
        else if(branchInstance.status.code == '800')
            isPending = true
        
        respond branchInstance, model:[isPending:isPending, isAllowed: isAllowed]
    }

    def create() {
        def disableDataCenter = Branch.findWhere(dataCenter: true) != null

        respond new Branch(params), model:[disableDataCenter:disableDataCenter]
    }
    
    def noCreate(){
        
    }

    @Transactional
    def save(Branch branchInstance) {
        branchInstance.status = BranchStatus.get(2)
        branchInstance.runDate = Branch.get(1).runDate
        branchInstance.newRunDate = Branch.get(1).runDate
        branchInstance.branchRunStatus = Branch.get(1).branchRunStatus
        branchInstance.isTelleringActive = Branch.get(1).isTelleringActive
        branchInstance.defDueToFromAcct = Branch.get(1).defDueToFromAcct
        
        /*
        if(new Date(params.runDate) < new Date()) {
            branchInstance.errors.reject(
                'icbs.admin.Branch.invalidRunDate',
                ['runDate', 'class Branch'] as Object[],
                '[Property [{0}] of class [{1}] cannot be equal or before the current date.]')

            branchInstance.errors.rejectValue(
                'runDate',
                'icbs.admin.Branch.invalidRunDate')
        }
        */
        
        if (branchInstance == null) {
            notFound()
            return
        }
        if (branchInstance.hasErrors()) {
            respond branchInstance.errors, view:'create'
            return
        }
        
        // check duplicate branch name
        def br = Branch.list()
        Boolean duplName = false
        for (b in br) {
            if (b.name.toUpperCase() == branchInstance.name.toUpperCase()) {
                duplName = true
            }
        }
        if (duplName) {
            flash.message = 'Duplicate Branch Name'
            respond branchInstance.errors, view:'create'
            return            
        }
        
        // Policy
        def isAllowed =  policyService.isAllowed('ADM00202')

        if(isAllowed) {

            
            branchInstance.status = branchInstance.status = BranchStatus.get(2)
            branchInstance.save flush:true
        }
        else {
            branchInstance.status = branchInstance.status = BranchStatus.get(1)
            branchInstance.save flush:true

            policyService.createException('ADM00202', 'branch', branchInstance.id, 'branch/show/'+branchInstance.id)
        }

        // Log
        def description = 'save new Branch ' +  branchInstance.name
        auditLogService.insert('040', 'ADM00202', description, 'branch', null, null, null, branchInstance.id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'branch.label', default: 'Branch'), branchInstance.id])
                redirect branchInstance
            }
            '*' { respond branchInstance, [status: CREATED] }
        }
    }

    def edit(Branch branchInstance) {
        def dataCenterExists = Branch.findWhere(dataCenter: true) != null
        def disableDataCenter = true

        if(branchInstance.dataCenter == true || !dataCenterExists) disableDataCenter = false

        respond branchInstance, model:[disableDataCenter:disableDataCenter]
    }

    @Transactional
    def update(Branch branchInstance) {
        if (branchInstance == null) {
            notFound()
            return
        }

        if (branchInstance.hasErrors()) {
            respond branchInstance.errors, view:'edit'
            return
        }

        branchInstance.save flush:true

        // Log
        def description = 'Update Branch ' +  branchInstance.name
        auditLogService.insert('040', 'ADM00202', description, 'branch', null, null, null, branchInstance.id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Branch.label', default: 'Branch'), branchInstance.id])
                redirect branchInstance
            }
            '*'{ respond branchInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Branch branchInstance) {
        branchInstance.status = BranchStatus.get(3)

        if (branchInstance == null) {
            notFound()
            return
        }

        branchInstance.save flush:true

        // Policy
        def isAllowed =  policyService.isAllowed('ADM00204')

        if(isAllowed) {
            branchInstance.status = branchInstance.status = BranchStatus.get(3)
            branchInstance.save flush:true
        }
        else {
            branchInstance.status = branchInstance.status = BranchStatus.get(6)
            branchInstance.save flush:true

            policyService.createException('ADM00204', 'branch', branchInstance.id, 'branch/show/'+branchInstance.id)
        }

        // Log
        def description = 'delete Branch ' +  branchInstance.name
        auditLogService.insert('040', 'ADM00202', description, 'branch', null, null, null, branchInstance.id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Branch.label', default: 'Branch'), branchInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    @Transactional
    def close(Branch branchInstance) {
        branchInstance.status = BranchStatus.get(4)

        if (branchInstance == null) {
            notFound()
            return
        }

        branchInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.close.message', args: [message(code: 'Branch.label', default: 'Branch'), branchInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    @Transactional
    def takeAction(Branch branchInstance) {
        if (branchInstance == null) {
            notFound()
            return
        }

        policyService.takeAction(branchInstance, BranchStatus, 'branch', (boolean)params.isApproved)
    }

    
    def test() {
        if(policyService.isTxnAllowed('001002', 21000)) {
            println 'true'
        }
        else {
            println 'false'
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'branch.label', default: 'Branch'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
