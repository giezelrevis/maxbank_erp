package icbs.gl
import icbs.admin.Branch
import icbs.lov.ContigentAccount
import icbs.admin.UserMaster
import icbs.lov.ConfigItemStatus
import icbs.gl.GlContigentAccount
import groovy.json.JsonBuilder

import static org.springframework.http.HttpStatus.*
import java.util.*
import java.text.SimpleDateFormat
import java.util.Date
import groovy.sql.Sql

import grails.transaction.Transactional
import icbs.atm.AtmTxn
import icbs.tellering.*
import icbs.tellering.TxnFile
import grails.converters.JSON


class GlContAcctController {

     static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    def datasource
       
     def index(Integer max) {
        
        params.max = Math.min(max ?: 10, 100)
 
        def ColumnName = "id"
        def ColumnOrderBy = "desc"
        if (params.query == null) {  // show all instances  
           
            println("clickable sort column: "+params)
           if(params.sort==null){
                 ColumnName = "id"
                 ColumnOrderBy = "desc"
           }else{
                 ColumnName = params.sort
                 ColumnOrderBy = params.order
           }
           def GlContigentAccountList = GlContigentAccount.createCriteria().list(params) {
               //order(ColumnName,ColumnOrderBy)
               
            }
            println("result value: "+GlContigentAccountList)
            //respond GlContigentAccountList, model:[BranchInstanceCount: GlContigentAccountList.totalCount]
            [GlContigentAccountList:GlContigentAccountList,BranchInstanceCount: GlContigentAccountList.totalCount,]
        }
        else{
           
              
             def GlContigentAccountList = GlContigentAccount.createCriteria().list(params) {
                 
                or {
                    ilike("particulars", "%${params.query}%")
                    ilike("reference", "%${params.query}%")
                }
                
                
                
            }
           [GlContigentAccountList:GlContigentAccountList,BranchInstanceCount: GlContigentAccountList.totalCount]
        }  
    }
    
    
    //show list of contigent accounts
    def viewdetails(){
        def actioncreateshow = params.fromcreate.toString()
        println("params from create section: "+params.fromcreate)
        def GlContigentAccountList 
        if(actioncreateshow == "showcreate"){
                    
                    def c = GlContigentAccount.createCriteria()
                    GlContigentAccountList = c.list {
                        and {
                            max("id")
                        }
                    }   
            
        }else{
                     println("parameter values from glink: "+params)
                    def idfrmupdate = params.ids
                    def idmainview = params.id
                    
                    def idtouse    
                    if(idfrmupdate=="" || idfrmupdate==null){
                        idtouse = idmainview.toInteger()
                    }else{
                        idtouse = idfrmupdate.toInteger()
                    }
                    Long ids = new Long(idtouse.toInteger())

                    def c = GlContigentAccount.createCriteria()
                    GlContigentAccountList = c.list {
                        and {
                            eq("id",ids)
                        }
                    }   
            
        }
 
        //def atmTxnList = AtmTxn.list(params)
        println("RESULT FOR GlContigentAccountList FILE: "+GlContigentAccountList)
        [GlContigentAccountList:GlContigentAccountList]
        // render (view:'/atmInterface/viewAtmTxnFile',model:[TxnFile:TxnFile]);
        

    }
    //insert values to table createContingentAccounts
    def createcontigent(){

    }
    def savecontigent(){
        
        def contigentId = params.contigenttype.toInteger()
        def creditAmtvalue = params.creditamt ? (params.creditamt.replaceAll(",","")).toDouble() : null
        def debitAmtvalue = params.debitamt ? (params.debitamt.replaceAll(",","")).toDouble() : null
        def particularvalue = params.particulars.toString()
        def referencevalue = params.reference.toString()
        def txnDatevalue = params.txndate ? new Date().parse("MM/dd/yyyy", params.txndate) : null
        
        println("contigent id: "+contigentId)
        println("creditvalue: "+creditAmtvalue)
        println("debitavalue: "+debitAmtvalue)
        println("particulars: "+particularvalue)
        println("reference: "+referencevalue)
        println("txndate: "+txnDatevalue)
        println("user id: "+session.user_id)
        println("branch id: "+UserMaster.get(session.user_id).branch)
        
        def glcontacct = new GlContigentAccount()
        glcontacct.branch = UserMaster.get(session.user_id).branch
        glcontacct.contigent = ContigentAccount.get(contigentId);
        glcontacct.createdByUser = UserMaster.get(session.user_id)
        glcontacct.creditAmt = creditAmtvalue
        glcontacct.debitAmt = debitAmtvalue
        glcontacct.particulars = particularvalue
        glcontacct.reference = referencevalue
        glcontacct.status = ConfigItemStatus.get(2);
        glcontacct.txnDate = txnDatevalue
        glcontacct.save(flush:true)
        
        render(view: "createcontigent") as JSON
        //loan performance id = 2 or 3
    }
    // update or edit specific ContigentAccounts
    def updatecontAcct(){
        
      println("params: "+params)
      def GlContAccts = GlContigentAccount.get(params.id)
      [GlContAccts:GlContAccts]
        
    }
    def updatecontAcctajax(){
        println("params: "+params)
        def contigentId = params.contigenttype.toInteger()
        def creditAmtvalue = params.creditamt ? (params.creditamt.replaceAll(",","")).toDouble() : null
        def debitAmtvalue = params.debitamt ? (params.debitamt.replaceAll(",","")).toDouble() : null
        def particularvalue = params.particulars.toString()
        def referencevalue = params.reference.toString()
        def txnDatevalue = params.txndate ? new Date().parse("MM/dd/yyyy", params.txndate) : null
        println("id: "+params.id)
        println("contigent type id: "+contigentId)
        println("creditvalue: "+creditAmtvalue)
        println("debitavalue: "+debitAmtvalue)
        println("particulars: "+particularvalue)
        println("txndate: "+txnDatevalue)

        
        def GlContAccts = GlContigentAccount.get(params.id)
        GlContAccts.contigent = ContigentAccount.get(contigentId)
        GlContAccts.creditAmt = creditAmtvalue
        GlContAccts.debitAmt = debitAmtvalue
        GlContAccts.particulars = particularvalue
        GlContAccts.txnDate = txnDatevalue
        GlContAccts.reference = referencevalue
        GlContAccts.save(flush:true)
        render(view: "updatecontAcct") as JSON
    }
    
    def removeContigentAccountAjax(){
        
        def GlContAccts = GlContigentAccount.get(params.id)
        GlContAccts.status = ConfigItemStatus.get(3);
        GlContAccts.save flush:true
        
       def messageConfirm = "Successfully Removed Contigent Account!"
       println(messageConfirm)
            //respond GlContigentAccountList, model:[BranchInstanceCount: GlContigentAccountList.totalCount]
       redirect(action:"index",model:[messageConfirmInstance:messageConfirm])
        
    }
    
    
}
