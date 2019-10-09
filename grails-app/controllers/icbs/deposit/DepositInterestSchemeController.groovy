package icbs.deposit

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.converters.JSON
import icbs.lov.ConfigItemStatus
import icbs.admin.Product
import icbs.admin.UserMaster
import icbs.admin.Branch

@Transactional(readOnly = true)
class DepositInterestSchemeController {

    static allowedMethods = [save: "POST", update: "PUT",activate: "POST", delete: "POST"]
    
    def auditLogService
    
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        if (params.sort == null) {  // default ordering
            params.sort = "code"
        }
        if (params.query == null) {
            respond DepositInterestScheme.list(params), model:[params:params,DepositInterestSchemeInstanceCount:  DepositInterestScheme.count()]
            return
        }
        else{
            def DepositInterestSchemeList = DepositInterestScheme.createCriteria().list (params) {
                or {
                    ilike("code", "%" + params.query.trim() + "%")
                    ilike("name", "%" + params.query.trim() + "%")
                }
                
            }
            respond DepositInterestSchemeList, model:[params:params,DepositInterestSchemeInstanceCount: DepositInterestSchemeList.totalCount]
        }
        return
    }
    def addGraduatedFormAjax(){
        render (template:'form/graduated/onetomany/graduated',model:[i:(params.i as Integer)]) as JSON
    }
    def show(DepositInterestScheme depositInterestSchemeInstance) {
        respond depositInterestSchemeInstance
    }

    def create() {
        respond new DepositInterestScheme(params)
    }

    @Transactional
    def save(DepositInterestScheme depositInterestSchemeInstance) {
        if (depositInterestSchemeInstance == null) {
            notFound()
            return
        }
        if(depositInterestSchemeInstance.graduateds){depositInterestSchemeInstance.graduateds.removeAll([null])}
        if (depositInterestSchemeInstance.hasErrors()) {
            respond depositInterestSchemeInstance.errors, view:'create'
            return
        }
        depositInterestSchemeInstance.save flush:true
        def products = params.list('products')
        
        products.each {
            println it
            (new DepositInterestSchemeProduct(depositInterestScheme:depositInterestSchemeInstance, product:it)).save flush:true
        }
        
        auditLogService.insert('040', 'CFG00800', 'save interest scheme '+depositInterestSchemeInstance.name, 'depositInterestScheme', null, null, null, depositInterestSchemeInstance.id)       
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'depositInterestScheme.label', default: 'DepositInterestScheme'), depositInterestSchemeInstance.id])
                redirect depositInterestSchemeInstance
            }
            '*' { respond depositInterestSchemeInstance, [status: CREATED] }
        }
    }

    def edit(DepositInterestScheme depositInterestSchemeInstance) {
        respond depositInterestSchemeInstance
    }
    @Transactional
    def update(DepositInterestScheme depositInterestSchemeInstance) {
        println params
        if (depositInterestSchemeInstance == null) {
            notFound()
            return
        }
        if(depositInterestSchemeInstance.graduateds){depositInterestSchemeInstance.graduateds.removeAll([null])}
        if(depositInterestSchemeInstance.graduateds){
            def _graduatedDelete = depositInterestSchemeInstance.graduateds.findAll{(it.deleted )}
            println "Graduated" +  depositInterestSchemeInstance.graduateds
            println "Graduated to be Deleted "+ _graduatedDelete
            if(_graduatedDelete) {
                for (DepositInterestSchemeGraduated graduated : _graduatedDelete) {
                    graduated?.status = ConfigItemStatus.get(3)
                }
            }
        }
        if (depositInterestSchemeInstance.hasErrors()) {
            println depositInterestSchemeInstance.errors
            respond depositInterestSchemeInstance.errors, view:'edit'
            depositInterestSchemeInstance.discard()
            return
        }
        depositInterestSchemeInstance.save flush:true
        updateProducts(depositInterestSchemeInstance,params.products)
        auditLogService.insert('040', 'CFG00800', 'update interest scheme '+depositInterestSchemeInstance.name, 'depositInterestScheme', null, null, null, depositInterestSchemeInstance.id)       
        
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'DepositInterestScheme.label', default: 'DepositInterestScheme'), depositInterestSchemeInstance.id])
                redirect depositInterestSchemeInstance
            }
            '*'{ respond depositInterestSchemeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(DepositInterestScheme depositInterestSchemeInstance) {

        if (depositInterestSchemeInstance == null) {
            notFound()
            return
        }
        depositInterestSchemeInstance.status = ConfigItemStatus.get(3)
        request.withFormat {
            form multipartForm {
                flash.message = "Deposit Interest Scheme " + depositInterestSchemeInstance.id + " deleted"
                redirect action:'show', id:depositInterestSchemeInstance.id
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'depositInterestScheme.label', default: 'DepositInterestScheme'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    
    @Transactional
    def activate(DepositInterestScheme depositInterestSchemeInstance) {
        if (depositInterestSchemeInstance == null) {
            notFound()
            return
        }

        depositInterestSchemeInstance.status = ConfigItemStatus.get(2)  
        depositInterestSchemeInstance.save(flush:true)
        auditLogService.insert('040', 'CFG00800', 'activate interest scheme '+depositInterestSchemeInstance.name, 'depositInterestScheme', null, null, null, depositInterestSchemeInstance.id)       

        request.withFormat {
            form multipartForm {
                flash.message = "Deposit Interest Scheme " + depositInterestSchemeInstance.id + " activated"
                //redirect loanPerformanceClassificationInstance
                redirect action:'show', id:depositInterestSchemeInstance.id
            }
            '*'{ render status: NO_CONTENT }
        }
    }
    def changeInt(DepositInterestScheme depositInterestSchemeInstance) {
        respond depositInterestSchemeInstance
    }
    
    @Transactional
    def saveIntRate(DepositInterestScheme depositInterestSchemeInstance) {
        println params
        if (depositInterestSchemeInstance == null) {
            notFound()
            return
        }
        if(depositInterestSchemeInstance.graduateds){depositInterestSchemeInstance.graduateds.removeAll([null])}
        if(depositInterestSchemeInstance.graduateds){
            def _graduatedDelete = depositInterestSchemeInstance.graduateds.findAll{(it.deleted )}
            println "Graduated" +  depositInterestSchemeInstance.graduateds
            println "Graduated to be Deleted "+ _graduatedDelete
            if(_graduatedDelete) {
                for (DepositInterestSchemeGraduated graduated : _graduatedDelete) {
                    graduated?.status = ConfigItemStatus.get(3)
                }
            }
        }
        if (depositInterestSchemeInstance.hasErrors()) {
            println depositInterestSchemeInstance.errors
            respond depositInterestSchemeInstance.errors, view:'changeInt'
            depositInterestSchemeInstance.discard()
            return
        }
        def oldRate = depositInterestSchemeInstance.getPersistentValue('interestRate')
        depositInterestSchemeInstance.save flush:true
        
        def intHist = new DepositInterestSchemeIntRateHist(depositInterestScheme:depositInterestSchemeInstance, 
            refDate:Branch.get(1).runDate, oldInterestRate:oldRate, newInterestRate:depositInterestSchemeInstance.interestRate, 
            user:UserMaster.get(session.user_id))
        intHist.save(flush:true)
        
        // update all deposit accounts if int rate is fixed
        if (depositInterestSchemeInstance.canChangeInterestRate == false) {
            def deps = Deposit.findAllByDepositInterestScheme(depositInterestSchemeInstance)
            for (d in deps) {
                if (d.status.id == 7){
                    continue;
                }
                if (depositInterestSchemeInstance.isGraduated == true) {
                    // graduated rates
                    def gradInt = d.depositInterestScheme.graduateds.find { it.startBal <= d.ledgerBalAmt && it.endBal >= d.ledgerBalAmt}
                    if (gradInt) {
                        d.interestRate = gradInt.interestRate
                        d.save(flush:true)
                    }                    
                } else {
                    d.interestRate = depositInterestSchemeInstance.interestRate
                    d.save(flush:true)
                }

            }
        }
        
        auditLogService.insert('040', 'CFG00800', 'Change interest rate '+depositInterestSchemeInstance.name, 'depositInterestScheme', null, null, null, depositInterestSchemeInstance.id)       
        
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'DepositInterestScheme.label', default: 'DepositInterestScheme'), depositInterestSchemeInstance.id])
                redirect depositInterestSchemeInstance
            }
            '*'{ respond depositInterestSchemeInstance, [status: OK] }
        }
    }

    def updateProducts(DepositInterestScheme depositInterestSchemeInstance, def products) {
        // add items that are selected
        for (id in products) {
            def product = Product.get(id) 
            def link = DepositInterestSchemeProduct.findByDepositInterestSchemeAndProduct(depositInterestSchemeInstance, product)
            if (!link) {
                (new DepositInterestSchemeProduct(depositInterestScheme:depositInterestSchemeInstance, product:product)).save flush:true
            }
        }
        
        // remove items not selected
        for (product in depositInterestSchemeInstance.products) {
            if (products) {
                if (!(products.contains(product.id.toString()))) {  // if existing, delete
                    def link = DepositInterestSchemeProduct.findByDepositInterestSchemeAndProduct(depositInterestSchemeInstance, product)
                    link.delete flush:true   
                }
            } else {  // if there are no selected items, delete every item
                def link = DepositInterestSchemeProduct.findByDepositInterestSchemeAndProduct(depositInterestSchemeInstance, product)
                link.delete flush:true   
            }
        }
    }  
}
