package icbs.deposit



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import icbs.lov.ConfigItemStatus
import icbs.admin.Product
@Transactional(readOnly = true)
class FixedDepositPreTermSchemeController {

    static allowedMethods = [save: "POST", update: "PUT",activate: "POST", delete: "POST"]
    
    def auditLogService
    
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        if (params.sort == null) {  // default ordering
            params.sort = "code"
        }
        if (params.query == null) {
            respond FixedDepositPreTermScheme.list(params), model:[params:params,FixedDepositPreTermSchemeInstanceCount:  FixedDepositPreTermScheme.count()]
            return
        }
        else{
            def FixedDepositPreTermSchemeList = FixedDepositPreTermScheme.createCriteria().list (params) {
                or {
                    ilike("code", "%" + params.query.trim() + "%")
                    //ilike("name", "%" + params.query.trim() + "%")
                }
            }
            respond FixedDepositPreTermSchemeList, model:[params:params,FixedDepositPreTermSchemeInstanceCount: FixedDepositPreTermSchemeList.totalCount]
        }
        return
    }

    def show(FixedDepositPreTermScheme fixedDepositPreTermSchemeInstance) {
        respond fixedDepositPreTermSchemeInstance
    }

    def create() {
        respond new FixedDepositPreTermScheme(params)
    }

    @Transactional
    def save(FixedDepositPreTermScheme fixedDepositPreTermSchemeInstance) {
        if (fixedDepositPreTermSchemeInstance == null) {
            notFound()
            return
        }

        if (fixedDepositPreTermSchemeInstance.hasErrors()) {
            respond fixedDepositPreTermSchemeInstance.errors, view:'create'
            return
        }

        fixedDepositPreTermSchemeInstance.save flush:true
        def products = params.list('products')
        products.each {
            println it
            (new FixedDepositPreTermSchemeProduct(fixedDepositPreTermScheme:fixedDepositPreTermSchemeInstance, product:it)).save flush:true
        }
        
        auditLogService.insert('040', 'CFG00900', 'save new FD Pre-term scheme '+fixedDepositPreTermSchemeInstance.name, 'fixedDepositPreTermScheme', null, null, null, fixedDepositPreTermSchemeInstance.id)
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'fixedDepositPreTermScheme.label', default: 'FixedDepositPreTermScheme'), fixedDepositPreTermSchemeInstance.id])
                redirect fixedDepositPreTermSchemeInstance
            }
            '*' { respond fixedDepositPreTermSchemeInstance, [status: CREATED] }
        }
    }

    def edit(FixedDepositPreTermScheme fixedDepositPreTermSchemeInstance) {
        respond fixedDepositPreTermSchemeInstance
    }

    @Transactional
    def update(FixedDepositPreTermScheme fixedDepositPreTermSchemeInstance) {
        if (fixedDepositPreTermSchemeInstance == null) {
            notFound()
            return
        }

        if (fixedDepositPreTermSchemeInstance.hasErrors()) {
            respond fixedDepositPreTermSchemeInstance.errors, view:'edit'
            return
        }
        auditLogService.insert('040', 'CFG00900', 'update FD Pre-term scheme '+fixedDepositPreTermSchemeInstance.name, 'glBatchHdr', null, null, null, fixedDepositPreTermSchemeInstance.id)
        fixedDepositPreTermSchemeInstance.save flush:true
        updateProducts(fixedDepositPreTermSchemeInstance,params.products)
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'FixedDepositPreTermScheme.label', default: 'FixedDepositPreTermScheme'), fixedDepositPreTermSchemeInstance.id])
                redirect fixedDepositPreTermSchemeInstance
            }
            '*'{ respond fixedDepositPreTermSchemeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(FixedDepositPreTermScheme fixedDepositPreTermSchemeInstance) {

        if (fixedDepositPreTermSchemeInstance == null) {
            notFound()
            return
        }

        fixedDepositPreTermSchemeInstance.status = ConfigItemStatus.get(3)
        //deleteProducts(fixedDepositPreTermSchemeInstance)
        auditLogService.insert('040', 'CFG00900', 'delete FD Pre-term scheme '+fixedDepositPreTermSchemeInstance.name, 'fixedDepositPreTermScheme', null, null, null, fixedDepositPreTermSchemeInstance.id)
        request.withFormat {
            form multipartForm {
                flash.message = " Fixed Deposit Pre-Tern Scheme " + fixedDepositPreTermSchemeInstance.id + " deleted"
                redirect action:'show', id:fixedDepositPreTermSchemeInstance.id
            }
            '*'{ render status: NO_CONTENT }
        }
    }
    @Transactional
    def activate(FixedDepositPreTermScheme fixedDepositPreTermSchemeInstance) {
        if (loanPerformanceClassificationInstance == null) {
            notFound()
            return
        }

        fixedDepositPreTermSchemeInstance.status = ConfigItemStatus.get(2)        
        fixedDepositPreTermSchemeInstance.save(flush:true)
        auditLogService.insert('040', 'CFG00900', 'activate FD Pre-term scheme '+fixedDepositPreTermSchemeInstance.name, 'fixedDepositPreTermScheme', null, null, null, fixedDepositPreTermSchemeInstance.id)

        request.withFormat {
            form multipartForm {
                flash.message = "Fixed Deposit Pre-Term Scheme " + fixedDepositPreTermSchemeInstance.id + " activated"
                //redirect loanPerformanceClassificationInstance
                redirect action:'show', id:fixedDepositPreTermSchemeInstance.id
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'fixedDepositPreTermScheme.label', default: 'FixedDepositPreTermScheme'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    def updateProducts(FixedDepositPreTermScheme fixedDepositPreTermSchemeInstance, def products) {
        // add items that are selected
        for (id in products) {
            def product = Product.get(id) 
            def link = FixedDepositPreTermSchemeProduct.findByFixedDepositPreTermSchemeAndProduct(fixedDepositPreTermSchemeInstance, product)
            if (!link) {
                (new FixedDepositPreTermSchemeProduct(fixedDepositPreTermScheme:fixedDepositPreTermSchemeInstance, product:product)).save flush:true
            }
        }
        
        // remove items not selected
        for (product in fixedDepositPreTermSchemeInstance.products) {
            if (products) {
                if (!(products.contains(product.id.toString()))) {  // if existing, delete
                      def link = FixedDepositPreTermSchemeProduct.findByFixedDepositPreTermSchemeAndProduct(fixedDepositPreTermSchemeInstance, product)
                    link.delete flush:true   
                }
            } else {  // if there are no selected items, delete every item
                   def link = FixedDepositPreTermSchemeProduct.findByFixedDepositPreTermSchemeAndProduct(fixedDepositPreTermSchemeInstance, product)
                    link.delete flush:true   
            }
        }
    }  
    private def deleteProducts(FixedDepositPreTermScheme fixedDepositPreTermSchemeInstance) {
        // mark all linked items as deleted
        for (linkedProduct in fixedDepositPreTermSchemeInstance.products) {
            linkedProduct.status = ConfigItemStatus.get(3)
            linkedProduct.save flush:true        
        }
    }
}
