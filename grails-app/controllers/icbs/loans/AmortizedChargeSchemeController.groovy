package icbs.loans



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import icbs.admin.Product
import icbs.lov.ConfigItemStatus

@Transactional(readOnly = true)
class AmortizedChargeSchemeController {

    static allowedMethods = [save: "POST", update: "PUT", activate: "POST", delete: "POST"]
    
    def auditLogService

    def index(Integer max) {        
       // params.max = Math.min(max ?: 10, 100)
       params.max = Math.min(max ?: 25, 100)
        if (params.sort == null) {
            params.sort = "code"
        }

        if (params.query == null) {
            respond AmortizedChargeScheme.list(params), model:[params:params, amortizedChargeSchemeInstanceCount: AmortizedChargeScheme.count()]
        } else {
            def amortizedChargeSchemeInstanceList = AmortizedChargeScheme.createCriteria().list(params) {
                or {
                    ilike("code", "%" + params.query.trim() + "%")
                    ilike("name", "%" + params.query.trim() + "%")
                }
            }
            respond amortizedChargeSchemeInstanceList, model:[params:params, amortizedChargeSchemeInstanceCount: amortizedChargeSchemeInstanceList.totalCount]
        }
        return
    }

    def show(AmortizedChargeScheme amortizedChargeSchemeInstance) {
        respond amortizedChargeSchemeInstance
    }

    def create() {
        respond new AmortizedChargeScheme(params)
    }

    @Transactional
    def save(AmortizedChargeScheme amortizedChargeSchemeInstance) {
        if (amortizedChargeSchemeInstance == null) {
            notFound()
            return
        }

        if (amortizedChargeSchemeInstance.hasErrors()) {
            respond amortizedChargeSchemeInstance.errors, view:'create'
            return
        }

        amortizedChargeSchemeInstance.status = ConfigItemStatus.get(1)  // check user role
        amortizedChargeSchemeInstance.hash = generateHash(amortizedChargeSchemeInstance)

        amortizedChargeSchemeInstance.save flush:true
        
        params.products.each {
            (new AmortizedChargeSchemeProduct(amortizedChargeScheme:amortizedChargeSchemeInstance, product:it)).save flush:true
        }
        auditLogService.insert('040', 'CFG01200', 'save new Amortized SC '+amortizedChargeSchemeInstance.name, 'amortizedChargeScheme', null, null, null, amortizedChargeSchemeInstance.id)
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'amortizedChargeScheme.label', default: 'AmortizedChargeScheme'), amortizedChargeSchemeInstance.id])
                redirect amortizedChargeSchemeInstance
            }
            '*' { respond amortizedChargeSchemeInstance, [status: CREATED] }
        }
    }

    def edit(AmortizedChargeScheme amortizedChargeSchemeInstance) {
        respond amortizedChargeSchemeInstance
    }

    @Transactional
    def update(AmortizedChargeScheme amortizedChargeSchemeInstance) {
        if (amortizedChargeSchemeInstance == null) {
            notFound()
            return
        }

        if (amortizedChargeSchemeInstance.hasErrors()) {
            respond amortizedChargeSchemeInstance.errors, view:'edit'
            return
        }

        amortizedChargeSchemeInstance.hash = generateHash(amortizedChargeSchemeInstance)

        amortizedChargeSchemeInstance.save flush:true

        updateProducts(amortizedChargeSchemeInstance, params.products)
        auditLogService.insert('040', 'CFG01200', 'update Amortized SC '+amortizedChargeSchemeInstance.name, 'amortizedChargeScheme', null, null, null, amortizedChargeSchemeInstance.id)
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'AmortizedChargeScheme.label', default: 'AmortizedChargeScheme'), amortizedChargeSchemeInstance.id])
                redirect amortizedChargeSchemeInstance
            }
            '*'{ respond amortizedChargeSchemeInstance, [status: OK] }
        }
    }

    @Transactional
    def activate(AmortizedChargeScheme amortizedChargeSchemeInstance) {
        if (amortizedChargeSchemeInstance == null) {
            notFound()
            return
        }

        amortizedChargeSchemeInstance.status = ConfigItemStatus.get(2)      
        amortizedChargeSchemeInstance.save(flush:true)
        auditLogService.insert('040', 'CFG01200', 'activate Amortized SC '+amortizedChargeSchemeInstance.name, 'amortizedChargeScheme', null, null, null, amortizedChargeSchemeInstance.id)
        request.withFormat {
            form multipartForm {
                flash.message = "Amortized Charge Scheme " + amortizedChargeSchemeInstance.id + " activated"
                redirect amortizedChargeSchemeInstance
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    @Transactional
    def delete(AmortizedChargeScheme amortizedChargeSchemeInstance) {
        if (amortizedChargeSchemeInstance == null) {
            notFound()
            return
        }

        amortizedChargeSchemeInstance.status = ConfigItemStatus.get(3)
        amortizedChargeSchemeInstance.save(flush:true)
        auditLogService.insert('040', 'CFG01200', 'delete Amortized SC '+amortizedChargeSchemeInstance.name, 'amortizedChargeScheme', null, null, null, amortizedChargeSchemeInstance.id)

        request.withFormat {
            form multipartForm {
                flash.message = "Amortized Charge Scheme " + amortizedChargeSchemeInstance.id + " deleted"
                redirect amortizedChargeSchemeInstance
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'amortizedChargeScheme.label', default: 'AmortizedChargeScheme'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def updateProducts(AmortizedChargeScheme amortizedChargeSchemeInstance, def products) {
        // add items that are selected
        for (id in products) {
            def product = Product.get(id) 
            def link = AmortizedChargeSchemeProduct.findByAmortizedChargeSchemeAndProduct(amortizedChargeSchemeInstance, product)
            
            if (!link) {
                (new AmortizedChargeSchemeProduct(amortizedChargeScheme:amortizedChargeSchemeInstance, product:product)).save flush:true
            }
        }
        
        // remove items not selected
        for (product in amortizedChargeSchemeInstance.products) {
            if (products) {
                if (!(products.contains(product.id.toString()))) {  // if existing, delete
                    def link = AmortizedChargeSchemeProduct.findByAmortizedChargeSchemeAndProduct(amortizedChargeSchemeInstance, product)
                    link.delete flush:true   
                }
            } else {  // if there are no selected items, delete every item
                def link = AmortizedChargeSchemeProduct.findByAmortizedChargeSchemeAndProduct(amortizedChargeSchemeInstance, product)
                link.delete flush:true   
            }
        }
    }    

    def generateHash(AmortizedChargeScheme amortizedChargeSchemeInstance) {
        def values = ""

        // combine properties
        AmortizedChargeScheme.constraints.each() { key, value ->
            if (key != "hash" && key != "products") {
                values += amortizedChargeSchemeInstance."${key}"
            }
        }
        
        return values.encodeAsMD5()    
    }
}
