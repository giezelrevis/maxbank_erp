package accounting.bankpayables

import groovy.sql.Sql
import groovy.json.JsonBuilder
import grails.converters.*
import grails.transaction.Transactional

class PotransController {

	def dataSource

    def index(Integer max) { 

        params.max = Math.min(max ?: 10, 100)

        if(params.offset == null){
            params.offset = 0
        }

        def AccountsPayablesList = AccountsPayables.createCriteria().list (params) {

        }
        respond AccountsPayablesList, model:[params:params,AccountsPayablesInstanceCount: AccountsPayablesList.totalCount]
    }
    
    def create() {
        respond new AccountsPayables(params)
    }

    def edit(AccountsPayables accountsPayablesInstance) {
        respond accountsPayablesInstance
    }

    def show(AccountsPayables accountsPayablesInstance) {
        respond accountsPayablesInstance
    }

    @Transactional
    def save(AccountsPayables accountsPayablesInstance) {

        println params
        println "Weeeeeeeeeeeeee"
        // if (accountsPayablesInstance == null) {
        //     notFound()
        //     return
        // }
     
        // if (apInstance.hasErrors()) {
        //     respond accountsPayablesInstance.errors, view:'create'
        //     return
        // }

        // accountsPayablesInstance.save(flush: true, failOnError: true)

        // if (!accountsPayablesInstance.save()) {
        //     println "Failed"
        //     accountsPayablesInstance.errors.each {
        //         println it
        //     }
        // }
        // else {
        //     redirect(action:'index')
        // }
        

        // Log
        // def description = 'Save Fixed Asset ' +  bankassetInstance.currency.name
        // auditLogService.insert('040', 'ADM00900', description, 'forexRate', null, null, null, forexRateInstance.id)

        // request.withFormat {
        //     form multipartForm {
        //         flash.message = message(code: 'default.created.message', args: [message(code: 'forexRate.label', default: 'ForexRate'), forexRateInstance.id])
        //         redirect forexRateInstance
        //     }
        //     '*' { respond forexRateInstance, [status: CREATED] }
        // }
    }

    @Transactional
    def update(AccountsPayables accountsPayablesInstance) {
        println "Update!!"
        println params
        //apInstance.status = 1

        if (accountsPayablesInstance == null) {
            notFound()
            return
        }
     
        if (accountsPayablesInstance.hasErrors()) {
            respond accountsPayablesInstance.errors, view:'create'
            return
        }

        accountsPayablesInstance.save(flush: true, failOnError: true)

        if (!accountsPayablesInstance.save()) {
            println "Failed"
            accountsPayablesInstance.errors.each {
                println it
            }
        }
        else {
            redirect(action:'index')
        }
        

        // Log
        // def description = 'Save Fixed Asset ' +  bankassetInstance.currency.name
        // auditLogService.insert('040', 'ADM00900', description, 'forexRate', null, null, null, forexRateInstance.id)

        // request.withFormat {
        //     form multipartForm {
        //         flash.message = message(code: 'default.created.message', args: [message(code: 'forexRate.label', default: 'ForexRate'), forexRateInstance.id])
        //         redirect forexRateInstance
        //     }
        //     '*' { respond forexRateInstance, [status: CREATED] }
        // }
    }
    
    def potrans = {
        
    }

    def assetinfo() {

    	def json = request.JSON

        def sql = new Sql(dataSource)
        def query = "select bankasset.id, bankasset.assetcode, bankasset.assetdesc, bankasset.purdate, (select vendor.companyname from vendor where vendor.id = cast(bankasset.vendorlink as Integer)) vendorlink, bankasset.purcost from bankasset where tag = 1 and bankasset.id = '" + json.id + "'"
        def queryresult = sql.rows(query)
        
        render queryresult as JSON

    }
    
}
