package accounting.bankpayables

import icbs.ap.AccountPayablesService
import groovy.sql.Sql
import groovy.json.JsonBuilder
import grails.converters.*
import grails.transaction.Transactional
import static org.springframework.http.HttpStatus.*

class PayablesController {
    
    def dataSource
    
    def index(Integer max) { 

        params.max = Math.min(max ?: 10, 100)

        if(params.offset == null){
            params.offset = 0
        }

        def PayablesList = Payables.createCriteria().list (params) {

        }
        respond PayablesList, model:[params:params,PayablesInstanceCount: PayablesList.totalCount]
    }
    
    def create() {
        respond new Payables(params)
    }

    def edit(Payables payablesInstance) {
        respond payablesInstance
    }

    def show(Payables payablesInstance) {
        respond payablesInstance
    }

    def accountPayablesService

    @Transactional
    def save(Payables payablesInstance) {

        println params
        payablesInstance.status = 1
        payablesInstance.checknumber = 12345
        payablesInstance.glaccount = params.glaccount.id
        payablesInstance.trntype = params.trntype.id

        if (payablesInstance == null) {
            notFound()
            return
        }
     
        if (payablesInstance.hasErrors()) {
            respond payablesInstance.errors, view:'create'
            return
        }

        payablesInstance.save(flush: true, failOnError: true)

        if (!payablesInstance.save()) {
            println "Failed"
            payablesInstance.errors.each {
                println it
            }
        }
        else {
            println params
            println "ready to fire service"
            accountPayablesService.insert(params.checkamt, 'NA', params.clientname, params.glaccount.id,params.trntype.id, params.trnid, params.transdate)
            redirect(action:'index')
        }
        
    }

    @Transactional
    def update(Payables payablesInstance) {
        println "Update!!"
        println params
        //payablesInstance.status = 1

        if (payablesInstance == null) {
            notFound()
            return
        }
     
        if (payablesInstance.hasErrors()) {
            respond payablesInstance.errors, view:'create'
            return
        }

        payablesInstance.save(flush: true, failOnError: true)

        if (!payablesInstance.save()) {
            println "Failed"
            payablesInstance.errors.each {
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

    def payables = {

        
    }
    
    def add_payables = {
        
    }
    
    // def showpayables() {
           
    //     def sql = new Sql(dataSource)
    //     def query = "select * from ap"
    //     def queryresult = sql.rows(query)
        
    //     render queryresult as JSON        
        
    // }
    
    def pushpayables() {
        
        // try {
        //     def json = request.JSON

        //     def b = new Ap
        //     (glaccount: json.bankacctap,
        //     clientname: json.payee,
        //     checknunmber: json.chknum,
        //     amount: json.amt,
        //     transdate: json.transdate,
        //     reference: json.ref,
        //     particulars: json.particulars,
        //     tag: 1
        //     )
        //     b.save(flush: true)

        //     render b as JSON
        // } catch(Exception ex) {
        //     render ex as JSON
        // }
        
    }
    
    def txnbreakdown() {
        
        def json = request.JSON
        
        def sql = new Sql(dataSource)
        def query = "select * from txn_breakdown where txn_file_id = '" + json.id + "'"
        def queryresult = sql.rows(query)
        
        render queryresult as JSON             
        
    }
    
    def showglaccounts() {
        
        //def json = request.JSON
        
        def sql = new Sql(dataSource)
        //def query = "select * from gl_account where short_name like '%" + json.key + "%' limit 1000"
        def query = "select * from gl_account where parent_id = 1248 and branch_id = 1 and financial_year = 2016"
        def queryresult = sql.rows(query)
        
        render queryresult as JSON
        
    }
    
    def showgltemplates() {
        
        def sql = new Sql(dataSource)
        
        def query = "select * from gl_batch_template"
        def queryresult = sql.rows(query)
        
        render queryresult as JSON
        
    }
    
    def showgltxntype() {
        
        def sql = new Sql(dataSource)
        
        def query = "select * from gl_batch_transaction_type"
        def queryresult = sql.rows(query)
        
        render queryresult as JSON
    }
    
    def currency() {
        
        def sql = new Sql(dataSource)
        
        def query = "select * from currency"
        def queryresult = sql.rows(query)
        
        render queryresult as JSON
        
    }
    
    def branch() {
        
        def sql = new Sql(dataSource)
        
        def query = "select * from branch"
        def queryresult = sql.rows(query)
        
        render queryresult as JSON
        
    }
    
    def pushBatch() {
        
        // try {
        //     def json = request.JSON

        //     def b = new Ap
        //     (glaccount: json.bankacctap,
        //     clientname: json.payee,
        //     checknunmber: json.chknum,
        //     amount: json.amt,
        //     transdate: json.transdate,
        //     reference: json.ref,
        //     particulars: json.particulars,
        //     tag: 1
        //     )
        //     b.save(flush: true)

        //     render b as JSON
        // } catch(Exception ex) {
        //     render ex as JSON
        // }
        
    }
    
    def pushBatchDtl() {
        
        // try {
        //     def json = request.JSON

        //     def b = new Ap
        //     (glaccount: json.bankacctap,
        //     clientname: json.payee,
        //     checknunmber: json.chknum,
        //     amount: json.amt,
        //     transdate: json.transdate,
        //     reference: json.ref,
        //     particulars: json.particulars,
        //     tag: 1
        //     )
        //     b.save(flush: true)

        //     render b as JSON
        // } catch(Exception ex) {
        //     render ex as JSON
        // }
        
    }
}
