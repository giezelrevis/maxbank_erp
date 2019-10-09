package accounting.fixedasset

import icbs.ap.AccountPayablesService
import groovy.sql.Sql
import groovy.json.JsonBuilder
import grails.converters.*
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

class FixedassetController {

    def dataSource
    
    def index(Integer max) { 
        def BankassetList = Bankasset.createCriteria().list (params) {

        }
        respond BankassetList, model:[params:params,BankassetInstanceCount: BankassetList.totalCount]
    }

    def create() {
        respond new Bankasset(params)
    }

    def edit(Bankasset bankassetInstance) {
        respond bankassetInstance
    }

    def show(Bankasset bankassetInstance) {
        respond bankassetInstance
    }

    def accountPayablesService

    @Transactional
    def save(Bankasset bankassetInstance) {
        
        println "Im here!!!"
        println params
        println "Credit GL " + params.creditglacc.id
        println "Debit GL " + params.ebitglacc.id
        println "GLACC " + params.glacc.id
        println "vendorlink test " + params.vendorlink
        bankassetInstance.glacc = params.creditglacc.id
        bankassetInstance.ebitglacc = params.creditglacc.id
        bankassetInstance.creditglacc = params.creditglacc.id
        bankassetInstance.vendorlink = params.vendorlink
        
        if (bankassetInstance == null) {
            notFound()
            return
        }
     
        if (bankassetInstance.hasErrors()) {
            respond bankassetInstance.errors, view:'create'
            return
        }

        bankassetInstance.save(flush: true, failOnError: true)

        if (!bankassetInstance.save()) {
            println "Failed"
            bankassetInstance.errors.each {
                println it
            }
        }
        else {
            println params
            println "ready to fire service"
            accountPayablesService.insert(params.purcost, 'NA', params.vendorlink, params.glacc.id, params.assetdesc, params.assetcode, params.purdate)
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

    @Transactional
    def update(Bankasset bankassetInstance) {
        
        println "Update!!!Im here!!!"
        println bankassetInstance
        // println params
        // println "Credit GL " + params.creditglacc.id
        // println "Debit GL " + params.ebitglacc.id
        // println "GLACC " + params.glacc.id
        // println "vendorlink " + params.vendorlink.id
        // bankassetInstance.glacc = params.creditglacc.id
        // bankassetInstance.ebitglacc = params.creditglacc.id
        // bankassetInstance.creditglacc = params.creditglacc.id
        // bankassetInstance.vendorlink = params.vendorlink.id
        
        if (bankassetInstance == null) {
            notFound()
            return
        }
     
        if (bankassetInstance.hasErrors()) {
            respond bankassetInstance.errors, view:'create'
            return
        }

        bankassetInstance.save(flush: true, failOnError: true)

        if (!bankassetInstance.save()) {
            println "Failed"
            bankassetInstance.errors.each {
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

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'bankasset.label', default: 'Bankasset'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    
    def fixedasset = {
        
    }
    
    def vendorlink = {
        
    }
    
    //display
    def showassets() {
        
        def sql = new Sql(dataSource)
        def query = "select bankasset.id, bankasset.assetcode, bankasset.assetdesc, bankasset.purdate, (select vendor.companyname from vendor where vendor.id = cast(bankasset.vendorlink as Integer)) vendorlink, bankasset.purcost from bankasset where tag = 1"
        def queryresult = sql.rows(query)
        
        render queryresult as JSON
        
    }
    
    def showvendors() {
        
        def sql = new Sql(dataSource)
        def query = "select * from vendor where status = 1"
        def queryresult = sql.rows(query)
        
        render queryresult as JSON
        
    }

    def showglaccounts() {
        
        def json = request.JSON
        
        def sql = new Sql(dataSource)
        //def query = "select * from gl_account where short_name like '%" + json.key + "%' limit 1000"
        def query = "select * from gl_account"
        def queryresult = sql.rows(query)
        
        render queryresult as JSON
        
    }

    //push
    def pushasset() {
               
        try {
            def json = request.JSON

            def b = new Bankasset
            (assetcode: json.assno,
            glacc: json.assacct,
            creditglacc: json.accumulated,
            ebitglacc: json.expnse,
            assetdesc: json.assdesc,
            assetpo: json.pono,
            assetserial: json.seno,
            vendorlink: json.vlink,
            purdate: json.purdate,
            purcost: json.asscost,
            isnew: json.inx,
            salvagevalue: json.salval,
            lifeinyears: json.liy,
            deprevalue: json.dvalue,
            annualexpense: json.ade,
            monthlyexpense: json.mde,
            tag: 1
            )
            b.save(flush: true)

            render b as JSON
        } catch(Exception ex) {
            render ex as JSON
        }
        
    }
    
    //push vendor
    
    def pushvendor() {
    
        try {
            def json = request.JSON

            def b = new Vendor
            (companyname: json.compname,
            contactname: json.contname,
            contactno: json.contno,
            email: json.emailadd,
            remarks: json.rem,
            address: json.address,
            status: 1
            )
            b.save(flush: true)

            render b as JSON
        } catch(Exception ex) {
            render ex as JSON
        }
        
    }
    
    //edit
    def editasset() {
        
        def json = request.JSON
        
        def sql = new Sql(dataSource)
        def query = "select * from bankasset where id = '" + json.id + "'"
        def queryresult = sql.rows(query)
        
        render queryresult as JSON
        
    }
    
    def editvendor() {
        
        def json = request.JSON
        
        def sql = new Sql(dataSource)
        def query = "select * from vendor where id = '" + json.id + "'"
        def queryresult = sql.rows(query)
        
        render queryresult as JSON
        
    }
    
    //update
    def updateasset() {
        
        def json = request.JSON
        
        def sql = new Sql(dataSource)
        def query = "UPDATE bankasset set assetcode='" + json.assno + "', "
            query += "glacc='" + json.assacct + "',"
            query += "creditglacc='" + json.accumulated + "',"
            query += "ebitglacc='" + json.expnse + "',"
            query += "assetdesc='" + json.assdesc + "',"
            query += "assetpo='" + json.pono + "',"
            query += "assetserial='" + json.seno + "',"
            query += "vendorlink='" + json.vlink + "',"
            query += "purdate='" + json.purdate + "',"
            query += "purcost='" + json.asscost + "',"
            query += "isnew='" + json.inx + "',"
            query += "salvagevalue='" + json.salval + "',"
            query += "lifeinyears='" + json.liy + "',"
            query += "deprevalue='" + json.dvalue + "',"
            query += "annualexpense='" + json.ade + "',"
            query += "monthlyexpense='" + json.mde + "' where id = '" + json.id + "'"
            

        def queryresult = sql.execute(query)
        
        render queryresult as JSON
        
    }
    
    def updatevendor() {
        
        def json = request.JSON
        
        def sql = new Sql(dataSource)
        def query = "UPDATE vendor set companyname='" + json.compname + "', "
            query += "contactname='" + json.contname + "',"
            query += "contactno='" + json.contno + "',"
            query += "address='" + json.address + "',"
            query += "email='" + json.emailadd + "',"
            query += "remarks='" + json.rem + "' where id = '" + json.id + "'"           

        def queryresult = sql.execute(query)
        
        render queryresult as JSON
        
    }
    
    //delete
    def deleteasset() {
        
        def json = request.JSON
        
        def sql = new Sql(dataSource)
        def query = "UPDATE bankasset set tag=0 where id = '" + json.id + "'"

        def queryresult = sql.execute(query)
        
        render queryresult as JSON
        
    }
    
    def deletevendor() {
        
        def json = request.JSON
        
        def sql = new Sql(dataSource)
        def query = "UPDATE vendor set status=0 where id = '" + json.id + "'"

        def queryresult = sql.execute(query)
        
        render queryresult as JSON
        
    }
}
