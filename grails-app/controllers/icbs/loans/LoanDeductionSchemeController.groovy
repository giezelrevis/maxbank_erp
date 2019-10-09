package icbs.loans



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import icbs.admin.Product
import icbs.lov.ConfigItemStatus

@Transactional(readOnly = true)
class LoanDeductionSchemeController {

    static allowedMethods = [save: "POST", update: "PUT", activate: "POST", delete: "POST"]
    
    def auditLogService

    def index(Integer max) {
       // params.max = Math.min(max ?: 10, 100)
          params.max = Math.min(max ?: 25, 100)  
        if (params.sort == null) {
            params.sort = "code"
        }

        if (params.query == null) {
            respond LoanDeductionScheme.list(params), model:[params:params, loanDeductionSchemeInstanceCount: LoanDeductionScheme.count()]
        } else {
            def loanDeductionSchemeInstanceList = LoanDeductionScheme.createCriteria().list(params) {
                or {
                    ilike("code", "%" + params.query.trim() + "%")
                    ilike("name", "%" + params.query.trim() + "%")
                }
            }
            respond loanDeductionSchemeInstanceList, model:[params:params, loanDeductionSchemeInstanceCount: loanDeductionSchemeInstanceList.totalCount]
        }
        return
    }

    def show(LoanDeductionScheme loanDeductionSchemeInstance) {
        respond loanDeductionSchemeInstance
    }

    def create() {
        respond new LoanDeductionScheme(params)
    }

    @Transactional
    def save(LoanDeductionScheme loanDeductionSchemeInstance) {
        if (loanDeductionSchemeInstance == null) {
            notFound()
            return
        }

        if (loanDeductionSchemeInstance.hasErrors()) {
            respond loanDeductionSchemeInstance.errors, view:'create'
            return
        }

        loanDeductionSchemeInstance.status = ConfigItemStatus.get(1)  // check user role        
        loanDeductionSchemeInstance.hash = generateHash(loanDeductionSchemeInstance)

        loanDeductionSchemeInstance.save flush:true

        params.products.each {
            (new LoanDeductionSchemeProduct(loanDeductionScheme:loanDeductionSchemeInstance, product:it)).save flush:true
        }
        auditLogService.insert('040', 'CFG01300', 'save new Loan deduction '+loanDeductionSchemeInstance.name, 'loanDeductionScheme', null, null, null, loanDeductionSchemeInstance.id)
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'loanDeductionScheme.label', default: 'LoanDeductionScheme'), loanDeductionSchemeInstance.id])
                redirect loanDeductionSchemeInstance
            }
            '*' { respond loanDeductionSchemeInstance, [status: CREATED] }
        }
    }

    def edit(LoanDeductionScheme loanDeductionSchemeInstance) {
        respond loanDeductionSchemeInstance
    }

    @Transactional
    def update(LoanDeductionScheme loanDeductionSchemeInstance) {
        if (loanDeductionSchemeInstance == null) {
            notFound()
            return
        }

        if (loanDeductionSchemeInstance.hasErrors()) {
            respond loanDeductionSchemeInstance.errors, view:'edit'
            return
        }

        loanDeductionSchemeInstance.hash = generateHash(loanDeductionSchemeInstance)

        loanDeductionSchemeInstance.save flush:true

        updateProducts(loanDeductionSchemeInstance, params.products)
        auditLogService.insert('040', 'CFG01300', 'update Loan deduction '+loanDeductionSchemeInstance.name, 'loanDeductionScheme', null, null, null, loanDeductionSchemeInstance.id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'LoanDeductionScheme.label', default: 'LoanDeductionScheme'), loanDeductionSchemeInstance.id])
                redirect loanDeductionSchemeInstance
            }
            '*'{ respond loanDeductionSchemeInstance, [status: OK] }
        }
    }

    @Transactional
    def activate(LoanDeductionScheme loanDeductionSchemeInstance) {
        if (loanDeductionSchemeInstance == null) {
            notFound()
            return
        }

        loanDeductionSchemeInstance.status = ConfigItemStatus.get(2) 
        loanDeductionSchemeInstance.save(flush:true)
        auditLogService.insert('040', 'CFG01300', 'activate Loan deduction '+loanDeductionSchemeInstance.name, 'loanDeductionScheme', null, null, null, loanDeductionSchemeInstance.id)

        request.withFormat {
            form multipartForm {
                flash.message = "Loan Deduction Scheme " + loanDeductionSchemeInstance.id + " activated"
                redirect loanDeductionSchemeInstance
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    @Transactional
    def delete(LoanDeductionScheme loanDeductionSchemeInstance) {
        if (loanDeductionSchemeInstance == null) {
            notFound()
            return
        }

        loanDeductionSchemeInstance.status = ConfigItemStatus.get(3)
        loanDeductionSchemeInstance.save(flush:true)
        auditLogService.insert('040', 'CFG01300', 'delete Loan deduction '+loanDeductionSchemeInstance.name, 'loanDeductionScheme', null, null, null, loanDeductionSchemeInstance.id)

        request.withFormat {
            form multipartForm {
                flash.message = "Loan Deduction Scheme " + loanDeductionSchemeInstance.id + " deleted"
                redirect loanDeductionSchemeInstance
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'loanDeductionScheme.label', default: 'LoanDeductionScheme'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def updateProducts(LoanDeductionScheme loanDeductionSchemeInstance, def products) {
        // add items that are selected
        for (id in products) {
            def product = Product.get(id) 
            def link = LoanDeductionSchemeProduct.findByLoanDeductionSchemeAndProduct(loanDeductionSchemeInstance, product)
            
            if (!link) {
                (new LoanDeductionSchemeProduct(loanDeductionScheme:loanDeductionSchemeInstance, product:product)).save flush:true
            }
        }
        
        // remove items not selected
        for (product in loanDeductionSchemeInstance.products) {
            if (products) {
                if (!(products.contains(product.id.toString()))) {  // if existing, delete
                    def link = LoanDeductionSchemeProduct.findByLoanDeductionSchemeAndProduct(loanDeductionSchemeInstance, product)
                    link.delete flush:true   
                }
            } else {  // if there are no selected items, delete every item
                def link = LoanDeductionSchemeProduct.findByLoanDeductionSchemeAndProduct(loanDeductionSchemeInstance, product)
                link.delete flush:true   
            }
        }
    }        

    def generateHash(LoanDeductionScheme loanDeductionSchemeInstance) {
        def values = ""

        // combine properties
        LoanDeductionScheme.constraints.each() { key, value ->
            if (key != "hash" && key != "products") {
                values += loanDeductionSchemeInstance."${key}"
            }
        }
        
        return values.encodeAsMD5()
    }
}
