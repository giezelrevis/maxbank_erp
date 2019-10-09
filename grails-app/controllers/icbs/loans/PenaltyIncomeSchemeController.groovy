package icbs.loans



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import icbs.admin.Product
import icbs.lov.ConfigItemStatus

@Transactional(readOnly = true)
class PenaltyIncomeSchemeController {

    static allowedMethods = [save: "POST", update: "PUT", activate: "POST", delete: "POST"]
    
    def auditLogService
    
    def index(Integer max) {
       // params.max = Math.min(max ?: 10, 100)
          params.max = Math.min(max ?: 25, 100)

        if (params.sort == null) {
            params.sort = "code"
        }

        if (params.query == null) {
            respond PenaltyIncomeScheme.list(params), model:[params:params, penaltyIncomeSchemeInstanceCount: PenaltyIncomeScheme.count()]
        } else {
            def penaltyIncomeSchemeInstanceList = PenaltyIncomeScheme.createCriteria().list(params) {
                or {
                    ilike("code", "%" + params.query.trim() + "%")
                    ilike("name", "%" + params.query.trim() + "%")
                }
            }
            respond penaltyIncomeSchemeInstanceList, model:[params:params, penaltyIncomeSchemeInstanceCount: penaltyIncomeSchemeInstanceList.totalCount]
        }
        return
    }

    def show(PenaltyIncomeScheme penaltyIncomeSchemeInstance) {
        respond penaltyIncomeSchemeInstance
    }

    def create() {
        respond new PenaltyIncomeScheme(params)
    }

    @Transactional
    def save(PenaltyIncomeScheme penaltyIncomeSchemeInstance) {
        if (penaltyIncomeSchemeInstance == null) {
            notFound()
            return
        }

        if (penaltyIncomeSchemeInstance.hasErrors()) {
            respond penaltyIncomeSchemeInstance.errors, view:'create'
            return
        }

        penaltyIncomeSchemeInstance.status = ConfigItemStatus.get(1)  // check user role
        penaltyIncomeSchemeInstance.hash = generateHash(penaltyIncomeSchemeInstance)

        penaltyIncomeSchemeInstance.save flush:true
        
        def products = params.list('products')
        products.each {
            (new PenaltyIncomeSchemeProduct(penaltyIncomeScheme:penaltyIncomeSchemeInstance, product:it)).save flush:true
        }
        auditLogService.insert('040', 'CFG01100', 'save new Loan penalty '+penaltyIncomeSchemeInstance.name, 'penaltyIncomeScheme', null, null, null, penaltyIncomeSchemeInstance.id)
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'penaltyIncomeScheme.label', default: 'PenaltyIncomeScheme'), penaltyIncomeSchemeInstance.id])
                redirect penaltyIncomeSchemeInstance
            }
            '*' { respond penaltyIncomeSchemeInstance, [status: CREATED] }
        }
    }

    def edit(PenaltyIncomeScheme penaltyIncomeSchemeInstance) {
        respond penaltyIncomeSchemeInstance
    }

    @Transactional
    def update(PenaltyIncomeScheme penaltyIncomeSchemeInstance) {
        if (penaltyIncomeSchemeInstance == null) {
            notFound()
            return
        }

        if (penaltyIncomeSchemeInstance.hasErrors()) {
            respond penaltyIncomeSchemeInstance.errors, view:'edit'
            return
        }

        penaltyIncomeSchemeInstance.hash = generateHash(penaltyIncomeSchemeInstance)

        penaltyIncomeSchemeInstance.save flush:true

        updateProducts(penaltyIncomeSchemeInstance, params.products)
        auditLogService.insert('040', 'CFG01100', 'update Loan penalty '+penaltyIncomeSchemeInstance.name, 'penaltyIncomeScheme', null, null, null, penaltyIncomeSchemeInstance.id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PenaltyIncomeScheme.label', default: 'PenaltyIncomeScheme'), penaltyIncomeSchemeInstance.id])
                redirect penaltyIncomeSchemeInstance
            }
            '*'{ respond penaltyIncomeSchemeInstance, [status: OK] }
        }
    }

    @Transactional
    def activate(PenaltyIncomeScheme penaltyIncomeSchemeInstance) {
        if (penaltyIncomeSchemeInstance == null) {
            notFound()
            return
        }

        penaltyIncomeSchemeInstance.status = ConfigItemStatus.get(2)  
        penaltyIncomeSchemeInstance.save(flush:true)
        auditLogService.insert('040', 'CFG01100', 'activate Loan penalty '+penaltyIncomeSchemeInstance.name, 'penaltyIncomeScheme', null, null, null, penaltyIncomeSchemeInstance.id)

        request.withFormat {
            form multipartForm {
                flash.message = "Penalty Income Scheme " + penaltyIncomeSchemeInstance.id + " activated"
                redirect penaltyIncomeSchemeInstance
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    @Transactional
    def delete(PenaltyIncomeScheme penaltyIncomeSchemeInstance) {
        if (penaltyIncomeSchemeInstance == null) {
            notFound()
            return
        }

        penaltyIncomeSchemeInstance.status = ConfigItemStatus.get(3)
        penaltyIncomeSchemeInstance.save(flush:true)
        auditLogService.insert('040', 'CFG01100', 'delete Loan penalty '+penaltyIncomeSchemeInstance.name, 'penaltyIncomeScheme', null, null, null, penaltyIncomeSchemeInstance.id)
        request.withFormat {
            form multipartForm {
                flash.message = "Penalty Income Scheme " + penaltyIncomeSchemeInstance.id + " deleted"
                redirect penaltyIncomeSchemeInstance
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'penaltyIncomeScheme.label', default: 'PenaltyIncomeScheme'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def updateProducts(PenaltyIncomeScheme penaltyIncomeSchemeInstance, def products) {
        // add items that are selected
        for (id in products) {
            def product = Product.get(id) 
            def link = PenaltyIncomeSchemeProduct.findByPenaltyIncomeSchemeAndProduct(penaltyIncomeSchemeInstance, product)
            
            if (!link) {
                (new PenaltyIncomeSchemeProduct(penaltyIncomeScheme:penaltyIncomeSchemeInstance, product:product)).save flush:true
            }
        }
        
        // remove items not selected
        for (product in penaltyIncomeSchemeInstance.products) {
            if (products) {
                if (!(products.contains(product.id.toString()))) {  // if existing, delete
                    def link = PenaltyIncomeSchemeProduct.findByPenaltyIncomeSchemeAndProduct(penaltyIncomeSchemeInstance, product)
                    link.delete flush:true   
                }
            } else {  // if there are no selected items, delete every item
                def link = PenaltyIncomeSchemeProduct.findByPenaltyIncomeSchemeAndProduct(penaltyIncomeSchemeInstance, product)
                link.delete flush:true   
            }
        }
    }    

    def generateHash(PenaltyIncomeScheme penaltyIncomeSchemeInstance) {
        def values = ""

        // combine properties
        PenaltyIncomeScheme.constraints.each() { key, value ->
            if (key != "hash" && key != "products") {
                values += penaltyIncomeSchemeInstance."${key}"
            }
        }
        
        return values.encodeAsMD5()
    }
}
