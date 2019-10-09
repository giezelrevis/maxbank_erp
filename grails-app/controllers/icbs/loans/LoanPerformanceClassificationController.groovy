package icbs.loans



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import icbs.admin.Product
import icbs.lov.ConfigItemStatus

@Transactional(readOnly = true)
class LoanPerformanceClassificationController {

    static allowedMethods = [save: "POST", update: "PUT", activate: "POST", delete: "POST"]

    def index(Integer max) {        
      //  params.max = Math.min(max ?: 10, 100)
          params.max = Math.min(max ?: 25, 100)
          
        if (params.sort == null) {
            params.sort = "code"
        }

        def loanPerformanceClassificationInstanceList
        if (params.query == null) {            
            loanPerformanceClassificationInstanceList = LoanPerformanceClassificationScheme.list(params)
            respond loanPerformanceClassificationInstanceList, model:[loanPerformanceClassificationInstanceList:loanPerformanceClassificationInstanceList, loanPerformanceClassificationInstanceCount: LoanPerformanceClassificationScheme.count(), params:params]
        } else {
            loanPerformanceClassificationInstanceList = LoanPerformanceClassificationScheme.createCriteria().list(params) {
                or {
                    ilike("code", "%" + params.query.trim() + "%")
                    ilike("name", "%" + params.query.trim() + "%")
                }
            }
            respond loanPerformanceClassificationInstanceList, model:[loanPerformanceClassificationInstanceList:loanPerformanceClassificationInstanceList, loanPerformanceClassificationInstanceCount: loanPerformanceClassificationInstanceList.totalCount, params:params]
        }
        return
    }

    def show(LoanPerformanceClassificationScheme loanPerformanceClassificationInstance) {
        respond loanPerformanceClassificationInstance, model:[loanPerformanceClassificationInstance:loanPerformanceClassificationInstance]
    }

    def create() {
        respond new LoanPerformanceClassificationScheme(params)
    }

    @Transactional
    def save(LoanPerformanceClassificationScheme loanPerformanceClassificationInstance) {
        if (loanPerformanceClassificationInstance == null) {
            notFound()
            return
        }

        if (loanPerformanceClassificationInstance?.prevClassification?.id == loanPerformanceClassificationInstance?.newClassification?.id) {
            loanPerformanceClassificationInstance.errors.rejectValue("prevClassification", "loanPerformanceClassificationScheme.classification.same")
            loanPerformanceClassificationInstance.errors.rejectValue("newClassification", "loanPerformanceClassificationScheme.classification.same")
        }

        if (loanPerformanceClassificationInstance.hasErrors()) {
            respond loanPerformanceClassificationInstance.errors, view:'create', model:[loanPerformanceClassificationInstance:loanPerformanceClassificationInstance]
            return
        }

        loanPerformanceClassificationInstance.status = ConfigItemStatus.get(1)  // check user role
        loanPerformanceClassificationInstance.hash = generateHash(loanPerformanceClassificationInstance)

        loanPerformanceClassificationInstance.save flush:true
        
        params.products.each {
            (new LoanPerformanceClassificationSchemeProduct(loanPerformanceClassificationScheme:loanPerformanceClassificationInstance, product:it)).save flush:true
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'loanPerformanceClassificationScheme.label', default: 'Loan Performance Classification'), loanPerformanceClassificationInstance.id])
               //redirect loanPerformanceClassificationInstance
                redirect action:'show', id:loanPerformanceClassificationInstance.id
            }
            '*' { respond loanPerformanceClassificationInstance, [status: CREATED] }
        }
    }

    def edit(LoanPerformanceClassificationScheme loanPerformanceClassificationInstance) {
        respond loanPerformanceClassificationInstance, model:[loanPerformanceClassificationInstance:loanPerformanceClassificationInstance]
    }

    @Transactional
    def update(LoanPerformanceClassificationScheme loanPerformanceClassificationInstance) {
        if (loanPerformanceClassificationInstance == null) {
            notFound()
            return
        }
        
        if (loanPerformanceClassificationInstance?.prevClassification?.id == loanPerformanceClassificationInstance?.newClassification?.id) {
            loanPerformanceClassificationInstance.errors.rejectValue("prevClassification", "loanPerformanceClassificationScheme.classification.same")
            loanPerformanceClassificationInstance.errors.rejectValue("newClassification", "loanPerformanceClassificationScheme.classification.same")
        }

        if (loanPerformanceClassificationInstance.hasErrors()) {
            respond loanPerformanceClassificationInstance.errors, view:'edit', model:[loanPerformanceClassificationInstance:loanPerformanceClassificationInstance]
            return
        }

        loanPerformanceClassificationInstance.hash = generateHash(loanPerformanceClassificationInstance)

        loanPerformanceClassificationInstance.save flush:true

        updateProducts(loanPerformanceClassificationInstance, params.products)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'LoanPerformanceClassification.label', default: 'Loan Performance Classification'), loanPerformanceClassificationInstance.id])
                //redirect loanPerformanceClassificationInstance
                redirect action:'show', id:loanPerformanceClassificationInstance.id
            }
            '*'{ respond loanPerformanceClassificationInstance, [status: OK] }
        }
    }

    @Transactional
    def activate(LoanPerformanceClassificationScheme loanPerformanceClassificationInstance) {
        if (loanPerformanceClassificationInstance == null) {
            notFound()
            return
        }

        loanPerformanceClassificationInstance.status = ConfigItemStatus.get(2)        

        request.withFormat {
            form multipartForm {
                flash.message = "Loan Performance Classification " + loanPerformanceClassificationInstance.id + " activated"
                //redirect loanPerformanceClassificationInstance
                redirect action:'show', id:loanPerformanceClassificationInstance.id
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    @Transactional
    def delete(LoanPerformanceClassificationScheme loanPerformanceClassificationInstance) {
        if (loanPerformanceClassificationInstance == null) {
            notFound()
            return
        }

        loanPerformanceClassificationInstance.status = ConfigItemStatus.get(3)

        request.withFormat {
            form multipartForm {
                flash.message = "Loan Performance Classification " + loanPerformanceClassificationInstance.id + " deleted"
                //redirect loanPerformanceClassificationInstance
                redirect action:'show', id:loanPerformanceClassificationInstance.id
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'loanPerformanceClassification.label', default: 'LoanPerformanceClassification'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def updateProducts(LoanPerformanceClassificationScheme loanPerformanceClassificationInstance, def products) {
        // add items that are selected
        for (id in products) {
            def product = Product.get(id) 
            def link = LoanPerformanceClassificationSchemeProduct.findByLoanPerformanceClassificationSchemeAndProduct(loanPerformanceClassificationInstance, product)
            
            if (!link) {
                (new LoanPerformanceClassificationSchemeProduct(loanPerformanceClassificationScheme:loanPerformanceClassificationInstance, product:product)).save flush:true
            }
        }
        
        // remove items not selected
        for (product in loanPerformanceClassificationInstance.products) {
            if (products) {
                if (!(products.contains(product.id.toString()))) {  // if existing, delete
                    def link = LoanPerformanceClassificationSchemeProduct.findByLoanPerformanceClassificationSchemeAndProduct(loanPerformanceClassificationInstance, product)
                    link.delete flush:true   
                }
            } else {  // if there are no selected items, delete every item
                def link = LoanPerformanceClassificationSchemeProduct.findByLoanPerformanceClassificationSchemeAndProduct(loanPerformanceClassificationInstance, product)
                link.delete flush:true   
            }
        }
    }        
   
    def generateHash(LoanPerformanceClassificationScheme loanPerformanceClassificationInstance) {
        def values = ""

        // combine properties
        LoanPerformanceClassificationScheme.constraints.each() { key, value ->
            if (key != "hash" && key != "products") {
                values += loanPerformanceClassificationInstance."${key}"
            }
        }
        
        return values.encodeAsMD5()
    }
}
