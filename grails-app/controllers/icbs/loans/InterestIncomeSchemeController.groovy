package icbs.loans



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import icbs.admin.Product
import icbs.lov.ConfigItemStatus

@Transactional(readOnly = true)
class InterestIncomeSchemeController {

    static allowedMethods = [save: "POST", update: "PUT", activate: "POST", delete: "POST"]
    
    def auditLogService

    def index(Integer max) {    
      //  params.max = Math.min(max ?: 10, 100)
          params.max = Math.min(max ?: 25, 100)

        if (params.sort == null) {
            params.sort = "code"
        }

        if (params.query == null) {
            respond InterestIncomeScheme.list(params), model:[params:params, interestIncomeSchemeInstanceCount: InterestIncomeScheme.count()]
        } else {
            def interestIncomeSchemeInstanceList = InterestIncomeScheme.createCriteria().list(params) {
                or {
                    ilike("code", "%" + params.query.trim() + "%")
                    ilike("name", "%" + params.query.trim() + "%")
                }
            }
            respond interestIncomeSchemeInstanceList, model:[params:params, interestIncomeSchemeInstanceCount: interestIncomeSchemeInstanceList.totalCount]
        }
        return
    }

    def show(InterestIncomeScheme interestIncomeSchemeInstance) {
        respond interestIncomeSchemeInstance
    }

    def create() {        
        respond new InterestIncomeScheme(params)
    }

    @Transactional
    def save(InterestIncomeScheme interestIncomeSchemeInstance) {
        if (interestIncomeSchemeInstance == null) {
            notFound()
            return
        }

        if (interestIncomeSchemeInstance.hasErrors()) {
            flash.message = 'Error saving new interest income scheme'
            respond interestIncomeSchemeInstance.errors, view:'create'
            return
        }

        interestIncomeSchemeInstance.status = ConfigItemStatus.get(1)  // check user role
        interestIncomeSchemeInstance.hash = generateHash(interestIncomeSchemeInstance)

        interestIncomeSchemeInstance.save flush:true

        def products = params.list('products')

        products.each {
            (new InterestIncomeSchemeProduct(interestIncomeScheme:interestIncomeSchemeInstance, product:it)).save flush:true
        }
        auditLogService.insert('040', 'CFG01000', 'save new Loan interest scheme '+interestIncomeSchemeInstance.name, 'interestIncomeScheme', null, null, null, interestIncomeSchemeInstance.id)
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'interestIncomeScheme.label', default: 'InterestIncomeScheme'), interestIncomeSchemeInstance.id])
                redirect interestIncomeSchemeInstance
            }
            '*' { respond interestIncomeSchemeInstance, [status: CREATED] }
        }
    }

    def edit(InterestIncomeScheme interestIncomeSchemeInstance) {
        respond interestIncomeSchemeInstance
    }

    @Transactional
    def update(InterestIncomeScheme interestIncomeSchemeInstance) {
        if (interestIncomeSchemeInstance == null) {
            notFound()
            return
        }

        if (interestIncomeSchemeInstance.hasErrors()) {
            flash.message = 'Error saving new interest income scheme'
            respond interestIncomeSchemeInstance.errors, view:'edit'
            return
        }
        
        interestIncomeSchemeInstance.hash = generateHash(interestIncomeSchemeInstance)

        interestIncomeSchemeInstance.save flush:true

        updateProducts(interestIncomeSchemeInstance, params.products)
        auditLogService.insert('040', 'CFG01000', 'update interest scheme '+interestIncomeSchemeInstance.name, 'interestIncomeScheme', null, null, null, interestIncomeSchemeInstance.id)
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'InterestIncomeScheme.label', default: 'InterestIncomeScheme'), interestIncomeSchemeInstance.id])
                redirect interestIncomeSchemeInstance
            }
            '*'{ respond interestIncomeSchemeInstance, [status: OK] }
        }
    }

    @Transactional
    def activate(InterestIncomeScheme interestIncomeSchemeInstance) {
        if (interestIncomeSchemeInstance == null) {
            notFound()
            return
        }

        interestIncomeSchemeInstance.status = ConfigItemStatus.get(2)   
        interestIncomeSchemeInstance.save(flush:true)
        auditLogService.insert('040', 'CFG01000', 'activate Loan interest scheme '+interestIncomeSchemeInstance.name, 'interestIncomeScheme', null, null, null, interestIncomeSchemeInstance.id)
        request.withFormat {
            form multipartForm {
                flash.message = "Interest Income Scheme " + interestIncomeSchemeInstance.id + " activated"
                redirect interestIncomeSchemeInstance
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    @Transactional
    def delete(InterestIncomeScheme interestIncomeSchemeInstance) {
        if (interestIncomeSchemeInstance == null) {
            notFound()
            return
        }

        interestIncomeSchemeInstance.status = ConfigItemStatus.get(3)
        interestIncomeSchemeInstance.save(flush:true)
        auditLogService.insert('040', 'CFG01000', 'delete Loan interest scheme '+interestIncomeSchemeInstance.name, 'interestIncomeScheme', null, null, null, interestIncomeSchemeInstance.id)

        request.withFormat {
            form multipartForm {
                flash.message = "Interest Income Scheme " + interestIncomeSchemeInstance.id + " deleted"
                redirect interestIncomeSchemeInstance
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'interestIncomeScheme.label', default: 'InterestIncomeScheme'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def updateProducts(InterestIncomeScheme interestIncomeSchemeInstance, def products) {
        // add items that are selected
        for (id in products) {
            def product = Product.get(id) 
            def link = InterestIncomeSchemeProduct.findByInterestIncomeSchemeAndProduct(interestIncomeSchemeInstance, product)
            
            if (!link) {
                (new InterestIncomeSchemeProduct(interestIncomeScheme:interestIncomeSchemeInstance, product:product)).save flush:true
            }
        }
        
        // remove items not selected
        for (product in interestIncomeSchemeInstance.products) {
            if (products) {
                if (!(products.contains(product.id.toString()))) {  // if existing, delete
                    def link = InterestIncomeSchemeProduct.findByInterestIncomeSchemeAndProduct(interestIncomeSchemeInstance, product)
                    link.delete flush:true   
                }
            } else {  // if there are no selected items, delete every item
                def link = InterestIncomeSchemeProduct.findByInterestIncomeSchemeAndProduct(interestIncomeSchemeInstance, product)
                link.delete flush:true   
            }
        }
    }    

    def generateHash(InterestIncomeScheme interestIncomeSchemeInstance) {
        def values = ""

        // combine properties
        InterestIncomeScheme.constraints.each() { key, value ->
            if (key != "hash" && key != "products") {
                values += interestIncomeSchemeInstance."${key}"
            }
        }
        
        return values.encodeAsMD5()
    }
}
