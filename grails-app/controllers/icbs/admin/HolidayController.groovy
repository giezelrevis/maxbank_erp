package icbs.admin



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import icbs.lov.ConfigItemStatus

@Transactional(readOnly = true)
class HolidayController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def auditLogService
    
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        if(params.offset==null){
            params.offset=0
        }
        if (params.query == null) {
            respond Holiday.list(params), model:[params:params,HolidayInstanceCount:  Holiday.count()]
            return
        }
        else{
            def HolidayList = Holiday.createCriteria().list (params) {
                or {
                    ilike("code", "%${params.query}%")
                    ilike("description", "%${params.query}%")
                }    
            }
            respond HolidayList, model:[params:params,HolidayInstanceCount: HolidayList.totalCount]
        }
        return
    }

    def show(Holiday holidayInstance) {
        respond holidayInstance
    }

    def create() {
        respond new Holiday(params)
    }

    @Transactional
    def save(Holiday holidayInstance) {
        if (holidayInstance == null) {
            notFound()
            return
        }
        
        def hol = Holiday.list()
        Boolean duplName = false
        for (h in hol) {
            if (h.description.toUpperCase() == holidayInstance.description.toUpperCase()) {
                duplName = true
            }
        }
        if (duplName) {
            flash.message = 'Duplicate Holiday description'
            respond holidayInstance.errors, view:'create'
            return            
        }        

        def holDate = Holiday.findByHolidayDate(holidayInstance.holidayDate)
        if (holDate) {
            flash.message = 'Duplicate Holiday Date'
            respond holidayInstance.errors, view:'create'
            return              
        }
        
        if (holidayInstance.holidayDate <= Branch.get(1).runDate) {
            flash.message = 'Holiday Date cannot be less than current run date'
            respond holidayInstance.errors, view:'create'
            return              
        }
        if (holidayInstance.hasErrors()) {
            respond holidayInstance.errors, view:'create'
            return
        }

        holidayInstance.configItemStatus = ConfigItemStatus.get(2);

        holidayInstance.save flush:true
        
        def branches = params.list('branches') 
        
        branches.each {
            BranchHoliday bh = new BranchHoliday(branch:it, holiday:holidayInstance, configItemStatus:ConfigItemStatus.get(2)).save(flush:true)
        }
        
        // Log
        def description = 'save new Holiday ' +  holidayInstance.description
        auditLogService.insert('040', 'ADM00302', description, 'holiday', null, null, null, holidayInstance.id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'holiday.label', default: 'Holiday'), holidayInstance.id])
                redirect holidayInstance
            }
            '*' { respond holidayInstance, [status: CREATED] }
        }
    }

    def edit(Holiday holidayInstance) {
        respond holidayInstance
    }

    @Transactional
    def update(Holiday holidayInstance) {
        if (holidayInstance == null) {
            notFound()
            return
        }

        if (holidayInstance.hasErrors()) {
            respond holidayInstance.errors, view:'edit'
            return
        }
        
        if (holidayInstance.holidayDate <= Branch.get(1).runDate) {
            flash.message = 'Holiday Date cannot be less than current run date'
            respond holidayInstance.errors, view:'create'
            return              
        }
        holidayInstance.save flush:true
        
        def branches = params.list('branches') 
        
        println 'branches[] ' + branches
        
        updatebranches(holidayInstance, branches)
            
        branches.each {
            //println 'branches id ' + it
            def bh = BranchHoliday.findAllByBranchAndHoliday(Branch.get(it), holidayInstance)
            if(!bh) {
                println 'dito na sya'
                BranchHoliday newBH = new BranchHoliday(branch:it, holiday:holidayInstance, configItemStatus:ConfigItemStatus.get(2)).save(flush:true)
            }
        }
       
        // Log
        def description = 'update Holiday ' +  holidayInstance.description
        auditLogService.insert('040', 'ADM00302', description, 'holiday', null, null, null, holidayInstance.id)


        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Holiday.label', default: 'Holiday'), holidayInstance.id])
                redirect holidayInstance
            }
            '*'{ respond holidayInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Holiday holidayInstance) {
        println 'dito na sa delete'
        if (holidayInstance == null) {
            notFound()
             println 'holiday instance null'
            
            return
        }

        holidayInstance.configItemStatus = ConfigItemStatus.get(3);

        holidayInstance.save flush:true

        // Log
        def description = 'delete Holiday ' +  holidayInstance.description
        auditLogService.insert('040', 'ADM00302', description, 'holiday', null, null, null, holidayInstance.id)


        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Holiday.label', default: 'Holiday'), holidayInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'holiday.label', default: 'Holiday'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    
    def updatebranches(Holiday holidayInstance, def branches) {
   
        // add items that are selected
        for (id in branches) {
            def branch = Branch.get(id) 
            def link   = BranchHoliday.findByHolidayAndBranch(holidayInstance, branch)

            if (!link) {
                BranchHoliday newUR = new BranchHoliday(branch:branch, holiday:holidayInstance, configItemStatus:ConfigItemStatus.get(2)).save(flush:true)
		//BranchHoliday newBH = new BranchHoliday(branch:it, holiday:holidayInstance, configItemStatus:ConfigItemStatus.get(2)).save(flush:true)
            }
        }
        
        // remove items not selected
        for (branch in holidayInstance.branches) {
            if (branch) {
                println 'branch to be deleted: ' + holidayInstance.branches
                if (!(branches.contains(branch.id.toString()))) {  // if existing, delete
                    def link = BranchHoliday.findByHolidayAndBranch(holidayInstance, branch)
                    link.delete flush:true   
                }
            } else {  // if there are no selected items, delete every item
                def link = BranchHoliday.findByHolidayAndBranch(holidayInstance, branch)
                link.delete flush:true   
            }
        }
     
    }
    
}
