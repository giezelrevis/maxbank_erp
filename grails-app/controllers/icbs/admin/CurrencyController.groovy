package icbs.admin

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import icbs.lov.ConfigItemStatus

class CurrencyController {
    
    def auditLogService
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        if (params.sort == null) {  // default ordering
            params.sort = "code"
        }

        if (params.query == null) {  // show all instances            
            respond Currency.list(params), model:[CurrencyInstanceCount: Currency.count()]
        }
        else {    // show query results
            def currencyList = Currency.createCriteria().list(params) {
                or {
                    ilike("code", "%${params.query}%")
                    ilike("name", "%${params.query}%")
                }
            }
            respond currencyList, model:[CurrencyInstanceCount: currencyList.totalCount]
        }
    }

    def show(Currency currencyInstance) {
        respond currencyInstance
    }

    def create() {
        respond new Currency(params)
    }
    
     def edit(Currency currencyInstance) {
        respond currencyInstance
    }
    
    def detailView()
    {
        println params.id
        def money = Currency.get(params.id)
        def moneydetail =  CurrencyDetail.findAllByCurrency(money)
        render(view: "detail", model: [money: money, moneydetail:moneydetail])
    }

    @Transactional
    def save(Currency currencyInstance) {
        currencyInstance.configItemStatus = ConfigItemStatus.get(2)
        
        if (currencyInstance == null) {
            notFound()
            return
        }

        if (currencyInstance.hasErrors()) {
            respond currencyInstance.errors, view:'create'
            return
        }

        currencyInstance.save flush:true
  
        // Log
        def description = 'save Currency ' +  currencyInstance.name
        auditLogService.insert('040', 'ADM00100', description, 'currency', null, null, null, currencyInstance.id)


        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'currency.label', default: 'Currency'), currencyInstance.id])
                redirect currencyInstance
            }
            '*' { respond currencyInstance, [status: CREATED] }
        }
    }

   
    
    

   
    def deleteDetail()
    {
        (CurrencyDetail.get(params.id.toInteger())).delete flush:true
        render(text: "Record delete..|success|alert")    
    }
    def updateDetail()
    {
        println params
        if(params.id.toInteger()==0)
        {
            println "new"
            //def nc = CurrencyDetail.findByCurrenyAndIndex(Currency.get(params.moneyid.toInteger()),params.index.toInteger())
            //if(nc)
            //{
            //   render(text: "Index already exists..|errror|alert")  
            //} else {
            
                def nc = new CurrencyDetail()
                nc.currency = Currency.get(params.moneyid.toInteger())
                nc.index = params.index.toInteger()
                nc.shortdescription = params.shortdesc
                nc.longdescription = params.longdesc
                nc.currencyvalue = params.value.toDouble()
                nc.save flush:true
                println "inser?"
                render(text: "New record saved..|success|alert") 
            //}
           
            
            
        } else {
            println "edit"
            def nc = CurrencyDetail.get(params.id.toInteger())
                //nc.currency = Currency.get(params.moneyid.toInteger())
                nc.index = params.index.toInteger()
                nc.shortdescription = params.shortdesc
                nc.longdescription = params.longdesc
                nc.currencyvalue = params.value.toDouble()
                nc.save flush:true
                println "edit?"
                render(text: "Update record saved..|success|alert") 
            
        }
        
         return 
        
    }
    
    def update(Currency currencyInstance) {
        if (currencyInstance == null) {
            notFound()
            return
        }

        if (currencyInstance.hasErrors()) {
            respond currencyInstance.errors, view:'edit'
            return
        }

        currencyInstance.save flush:true


        // Log
        def description = 'update Currency ' +  currencyInstance.name
        auditLogService.insert('040', 'ADM00100', description, 'currency', null, null, null, currencyInstance.id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Currency.label', default: 'Currency'), currencyInstance.id])
                redirect currencyInstance
            }
            '*'{ respond currencyInstance, [status: OK] }
        }
    }

   
    def delete(Currency currencyInstance) {
        currencyInstance.configItemStatus = ConfigItemStatus.get(3)

        if (currencyInstance == null) {
            notFound()
            return
        }

        currencyInstance.save flush:true


        // Log
        def description = 'delete Currency ' +  currencyInstance.name
        auditLogService.insert('040', 'ADM00100', description, 'currency', null, null, null, currencyInstance.id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Currency.label', default: 'Currency'), currencyInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'currency.label', default: 'Currency'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
