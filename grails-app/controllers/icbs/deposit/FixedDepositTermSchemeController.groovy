package icbs.deposit



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import icbs.lov.ConfigItemStatus
import icbs.admin.Product
@Transactional(readOnly = true)
class FixedDepositTermSchemeController {

    static allowedMethods = [save: "POST", update: "PUT",activate: "POST", delete: "POST"]
    
    def auditLogService
    
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        if (params.sort == null) {  // default ordering
            params.sort = "code"
        }
        if (params.query == null) {
            respond FixedDepositTermScheme.list(params), model:[params:params,FixedDepositTermSchemeInstanceCount:  FixedDepositTermScheme.count()]
            return
        }
        else{
            def FixedDepositTermSchemeList = FixedDepositTermScheme.createCriteria().list (params) {
                ilike("code", "%" + params.query.trim() + "%")
                //ilike("name", "%" + params.query.trim() + "%")
                
            }
            respond FixedDepositTermSchemeList, model:[params:params,FixedDepositTermSchemeInstanceCount: FixedDepositTermSchemeList.totalCount]
        }
        return
    }

    def show(FixedDepositTermScheme fixedDepositTermSchemeInstance) {
        respond fixedDepositTermSchemeInstance
    }

    def create() {
        respond new FixedDepositTermScheme(params)
    }

    @Transactional
    def save(FixedDepositTermScheme fixedDepositTermSchemeInstance) {
        if (fixedDepositTermSchemeInstance == null) {
            notFound()
            return
        }

        if (fixedDepositTermSchemeInstance.hasErrors()) {
            respond fixedDepositTermSchemeInstance.errors, view:'create'
            return
        }
        fixedDepositTermSchemeInstance.save flush:true
        def products = params.list('products')
        products.each {
            (new FixedDepositTermSchemeProduct(fixedDepositTermScheme:fixedDepositTermSchemeInstance, product:it)).save flush:true
        }
        auditLogService.insert('040', 'CFG01500', 'save new FD Term '+fixedDepositTermSchemeInstance.name, 'fixedDepositTermScheme', null, null, null, fixedDepositTermSchemeInstance.id)          
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'fixedDepositTermScheme.label', default: 'FixedDepositTermScheme'), fixedDepositTermSchemeInstance.id])
                redirect fixedDepositTermSchemeInstance
            }
            '*' { respond fixedDepositTermSchemeInstance, [status: CREATED] }
        }
    }

    def edit(FixedDepositTermScheme fixedDepositTermSchemeInstance) {
        respond fixedDepositTermSchemeInstance
    }

    @Transactional
    def update(FixedDepositTermScheme fixedDepositTermSchemeInstance) {
        if (fixedDepositTermSchemeInstance == null) {
            notFound()
            return
        }

        if (fixedDepositTermSchemeInstance.hasErrors()) {
            respond fixedDepositTermSchemeInstance.errors, view:'edit'
            return
        }
        auditLogService.insert('040', 'CFG01500', 'update FD Term '+fixedDepositTermSchemeInstance.name, 'fixedDepositTermScheme', null, null, null, fixedDepositTermSchemeInstance.id)          

        fixedDepositTermSchemeInstance.save flush:true
        updateProducts(fixedDepositTermSchemeInstance,params.products)
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'FixedDepositTermScheme.label', default: 'FixedDepositTermScheme'), fixedDepositTermSchemeInstance.id])
                redirect fixedDepositTermSchemeInstance
            }
            '*'{ respond fixedDepositTermSchemeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(FixedDepositTermScheme fixedDepositTermSchemeInstance) {

        if (fixedDepositTermSchemeInstance == null) {
            notFound()
            return
        }

        fixedDepositTermSchemeInstance.status = ConfigItemStatus.get(3)
        fixedDepositTermSchemeInstance.save(flush:true)
        //deleteProducts(fixedDepositPreTermSchemeInstance)
        auditLogService.insert('040', 'CFG01500', 'delete FD Term '+fixedDepositTermSchemeInstance.name, 'fixedDepositTermScheme', null, null, null, fixedDepositTermSchemeInstance.id)          

        request.withFormat {
            form multipartForm {
                flash.message = " Fixed Deposit Term Scheme " + fixedDepositTermSchemeInstance.id + " deleted"
                redirect action:'show', id:fixedDepositTermSchemeInstance.id
            }
            '*'{ render status: NO_CONTENT }
        }
    }
    @Transactional
    def activate(FixedDepositTermScheme fixedDepositTermSchemeInstance) {
        if (fixedDepositTermSchemeInstance == null) {
            notFound()
            return
        }

        fixedDepositTermSchemeInstance.status = ConfigItemStatus.get(2)   
        fixedDepositTermSchemeInstance.save(flush:true)
        auditLogService.insert('040', 'CFG01500', 'activate FD Term '+fixedDepositTermSchemeInstance.name, 'fixedDepositTermScheme', null, null, null, fixedDepositTermSchemeInstance.id)          

        request.withFormat {
            form multipartForm {
                flash.message = "Fixed Deposit Term Scheme " + fixedDepositTermSchemeInstance.id + " activated"
                //redirect loanPerformanceClassificationInstance
                redirect action:'show', id:fixedDepositTermSchemeInstance.id
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'fixedDepositTermScheme.label', default: 'FixedDepositTermScheme'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
     def updateProducts(FixedDepositTermScheme fixedDepositTermSchemeInstance, def products) {
        // add items that are selected
        for (id in products) {
            def product = Product.get(id) 
            def link = FixedDepositTermSchemeProduct.findByFixedDepositTermSchemeAndProduct(fixedDepositTermSchemeInstance, product)
            if (!link) {
                (new FixedDepositTermSchemeProduct(fixedDepositTermScheme:fixedDepositTermSchemeInstance, product:product)).save flush:true
            }
        }
        
        // remove items not selected
        for (product in fixedDepositTermSchemeInstance.products) {
            if (products) {
                if (!(products.contains(product.id.toString()))) {  // if existing, delete
                      def link = FixedDepositTermSchemeProduct.findByFixedDepositTermSchemeAndProduct(fixedDepositTermSchemeInstance, product)
                    link.delete flush:true   
                }
            } else {  // if there are no selected items, delete every item
                   def link = FixedDepositTermSchemeProduct.findByFixedDepositTermSchemeAndProduct(fixedDepositTermSchemeInstance, product)
                    link.delete flush:true   
            }
        }
    }  
    private def deleteProducts(FixedDepositTermScheme fixedDepositTermSchemeInstance) {
        // mark all linked items as deleted
        for (linkedProduct in fixedDepositTermSchemeInstance.fixedDepositTermSchemeProducts) {
            linkedProduct.status = ConfigItemStatus.get(3)
            linkedProduct.save flush:true        
        }
    }
}
