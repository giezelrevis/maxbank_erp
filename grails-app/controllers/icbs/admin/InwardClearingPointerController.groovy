package icbs.admin

import icbs.admin.TxnTemplate
import groovy.sql.Sql
import groovy.json.JsonBuilder
import grails.converters.JSON
import grails.converters.deep.JSON
class InwardClearingPointerController {

    static allowedMethods = [update: "PUT"]
    def dataSource
    def index(Integer max) {
        // params.max = Math.min(max ?: 50, 100)
        
        //respond Institution.listOrderById(params), model:[InstitutionInstanceCount: Institution.count()]
        params.max = Math.min(max ?: 10, 100)

        if (params.sort == null) {  // default ordering
            
        }

        if (params.query == null) {  // show all instances    
            def inwardClearingPointerList = InwardClearingPointer.list()
            respond inwardClearingPointerList, model:[InwardClearingPointerInstanceCount: InwardClearingPointer.count()]
        }
        else {    // show query results
            def inwardClearingPointerList = InwardClearingPointer.createCriteria().list(params) {
                or {
                    ilike("description", "%${params.query}%")
                }
            }
            respond InwardClearingPointerList, model:[InwardClearingPointerInstanceCount: InwardClearingPointer.count()]
        }        
    }
    def saveInwardClearingPointer(){
        println("save inward clearing pointer params: "+params)
        def inwardClearingPointerInstancesss = new InwardClearingPointer()
        inwardClearingPointerInstancesss.inwardBRSTN = params.inwardBRSTN.toString()
        inwardClearingPointerInstancesss.description = params.description.toString()
        inwardClearingPointerInstancesss.txnTemplate = TxnTemplate.get(params.txnTemplatePointer)
        inwardClearingPointerInstancesss.save(flush: true)
        flash.message = 'New Inward Clearing Pointer Successfully Created!'
        println("New Inward Clearing Pointer Successfully Created!")
        redirect(action:"index")
    }
    def editInwardClearingPointer(){
        def json = request.JSON
        def sql = new Sql(dataSource)
        println("update params: "+params)
        def inwardClearingPointerInstance = InwardClearingPointer.get(json.inwardMasterId)
        inwardClearingPointerInstance.inwardBRSTN = json.inwardBRSTN.toString()
        inwardClearingPointerInstance.description = json.inwardDescription.toString()
        inwardClearingPointerInstance.txnTemplate = TxnTemplate.get(json.inwardTxnTemplatePointer)
        flash.message = 'Inward Clearing Pointer Successfully Updated!'
        inwardClearingPointerInstance.save(flush: true)
        
        println("Inward Clearing Pointer id :"+json.inwardMasterId+" Successfully Updated!")
        def redirectBacktoinwardClearingPointerInstance = "select * from inward_clearing_pointer limit 1"
        def returnbckToInwardClearingPointeeer = sql.rows(redirectBacktoinwardClearingPointerInstance)
        render returnbckToInwardClearingPointeeer as JSON
        
    }
    def deleteInwardClearingPointer(){
        def json = request.JSON
        def sql = new Sql(dataSource)
        println("update params: "+params)
        def deletenowinwardClearingPointerInstance = "delete from inward_clearing_pointer where id = "+json.inwardMasterId 
        def resultset = sql.execute(deletenowinwardClearingPointerInstance)
        flash.message = 'Inward Clearing Pointer Successfully Deleted!'
        
        
        println("Inward Clearing Pointer id :"+json.inwardMasterId+" Successfully Updated!")
        def redirectBacktoinwardClearingPointerInstance = "select * from inward_clearing_pointer limit 1"
        def returnbckToInwardClearingPointeeer = sql.rows(redirectBacktoinwardClearingPointerInstance)
        render returnbckToInwardClearingPointeeer as JSON
        
    }
}
