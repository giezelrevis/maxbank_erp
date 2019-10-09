package icbs.admin

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import icbs.admin.Branch
import icbs.admin.UserMaster

@Transactional(readOnly = true)
class ForexRateController {
    
    def auditLogService
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        if(params.offset==null){
            params.offset=0
        }
        if (params.query == null) {
            println "Params query is null"
            def c = ForexRate.createCriteria()
            def results = c.list {
                eq("tag", 1)
            }
            // respond ForexRate.withCriteria{eq 'tag', 1}, model:[params:params,ForexRateInstanceCount:  ForexRate.count()]
            respond results, model:[params:params,ForexRateInstanceCount:  ForexRate.count()]
            return
        }
        else{
            println "Params query not null"
            println params
            def ForexRateList = ForexRate.createCriteria().list (params) {

            }
            respond ForexRateList, model:[params:params,ForexRateInstanceCount: ForexRateList.totalCount]
        }
        return
    }

    def show(ForexRate forexRateInstance) {
        respond forexRateInstance
    }

    def create() {
        session["forexPageAction"] = "create"
        respond new ForexRate(params)
    }

    @Transactional
    def save(ForexRate forexRateInstance) {
        println "Im here!!!"
        println "date"+ new Date().format('yyyy-MM-dd HH:mm')
        println "txndate"+ Branch.get(1).runDate
        println "last update by"+ UserMaster.get(session.user_id)
        println "refrate"+ 0.00D  
        //println params
        
        println("jm params: "+params)
        // forexRateInstance.currency = 2
        forexRateInstance.date = new Date().format('yyyy-MM-dd HH:mm')
        forexRateInstance.txnDate = Branch.get(1).runDate
        forexRateInstance.lastUpdatedBy = UserMaster.get(session.user_id)
        forexRateInstance.refRate = 0.00D   
    	forexRateInstance.buyRate1 = 0.00D
    	forexRateInstance.buyRate2 = 0.00D
    	forexRateInstance.buyRate3 = 0.00D
    	forexRateInstance.buyRate4 = 0.00D
    	forexRateInstance.buyRate5 = 0.00D
    	forexRateInstance.sellRate1 = 0.00D
    	forexRateInstance.sellRate2 = 0.00D
    	forexRateInstance.sellRate3 = 0.00D
    	forexRateInstance.sellRate4 = 0.00D
    	forexRateInstance.sellRate5 = 0.00D   
        forexRateInstance.tag = 1
        
        println forexRateInstance.refRate
        println forexRateInstance.buyRate1
        println forexRateInstance.sellRate1
        println forexRateInstance.lastUpdatedBy
        println forexRateInstance.txnDate
        println("param currency2: "+params.currency2.id)
        
        if (forexRateInstance == null) {
            notFound()
            return
        }
     
        if (forexRateInstance.currency.id == forexRateInstance.currency2.id)  {
            flash.error = 'unable to continue, Cannot create forex rate with same Currency'
            respond forexRateInstance, view:'create'
            return
        }
        
        def c = ForexRate.createCriteria()
        def isExistingCutOffandcurrencyDetails = c.list {
            and {
                eq("currency2",Currency.get(params.currency2.id))
                eq("currency",Currency.get(params.currency.id))
                eq("txnDate", Branch.get(1).runDate)
            }
        }
        println("isExistingCutOffandcurrencyDetails: "+isExistingCutOffandcurrencyDetails)
        if(isExistingCutOffandcurrencyDetails){
            flash.error = 'Unable to continue, Theres an Existing Forex Rate information in this Cut Off Date '
            respond forexRateInstance, view:'create'
            return
        }
        
        
        if (forexRateInstance.hasErrors()) {
            respond forexRateInstance.errors, view:'create'
            return
        }

        forexRateInstance.save flush:true

        // Log
        def description = 'Save Forex Rate ' +  forexRateInstance.currency.name
        auditLogService.insert('040', 'ADM00900', description, 'forexRate', null, null, null, forexRateInstance.id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'forexRate.label', default: 'ForexRate'), forexRateInstance.id])
                redirect forexRateInstance
            }
            '*' { respond forexRateInstance, [status: CREATED] }
        }
    }

    def edit(ForexRate forexRateInstance) {
        session["forexPageAction"] = "edit"
        respond forexRateInstance
    }

    @Transactional
    def update(ForexRate forexRateInstance) {
        if (forexRateInstance == null) {
            notFound()
            return
        }

        if (forexRateInstance.hasErrors()) {
            respond forexRateInstance.errors, view:'edit'
            return
        }
        if (forexRateInstance.txnDate != Branch.get(1).runDate) {
            flash.error = 'Cannot Edit previous date'
            respond forexRateInstance.errors, view:'edit'
            return            
        }
        if (forexRateInstance.currency.id == forexRateInstance.currency2.id)  {
            flash.error = 'unable to continue, Cannot update forex rate with same Currency'
            respond forexRateInstance.errors, view:'edit'
            return
        }
        
        def c = ForexRate.createCriteria()
        def isExistingCutOffandcurrencyDetails = c.list {
            and {
                eq("currency2",Currency.get(params.currency2.id))
                eq("currency",Currency.get(params.currency.id))
                eq("txnDate", Branch.get(1).runDate)
                ne("id", forexRateInstance.id)
            }
        }
        println("isExistingCutOffandcurrencyDetails: "+isExistingCutOffandcurrencyDetails)
        if(isExistingCutOffandcurrencyDetails){
            flash.error = 'Unable to continue, Theres an Existing Forex Rate information in this Cut Off Date '
            respond forexRateInstance.errors, view:'edit'
            return
        }
        
        forexRateInstance.date = new Date().format('yyyy-MM-dd HH:mm')
        forexRateInstance.save flush:true

        // Log
        def description = 'update Forex Rate ' +  forexRateInstance.currency.name
        auditLogService.insert('040', 'ADM00900', description, 'forexRate', null, null, null, forexRateInstance.id)
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'ForexRate.label', default: 'ForexRate'), forexRateInstance.id])
                flash.message = 'Forex Rate '+forexRateInstance.id+' Successfully Updated!'
                redirect forexRateInstance
            }
            '*'{ respond forexRateInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(ForexRate forexRateInstance) {
        println "Pumasok sa delete!"
        if (forexRateInstance == null) {
            notFound()
            return
        }
        if (forexRateInstance.txnDate != Branch.get(1).runDate) {
            flash.error = 'Cannot Delete previous date'
            respond forexRateInstance.errors, view:'show'
            return            
        }
        
        forexRateInstance.tag = 0
        forexRateInstance.save flush:true

        // Log
        def description = 'delete Forex Rate ' +  forexRateInstance.currency.name
        auditLogService.insert('040', 'ADM00900', description, 'forexRate', null, null, null, forexRateInstance.id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'ForexRate.label', default: 'ForexRate'), forexRateInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'forexRate.label', default: 'ForexRate'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
