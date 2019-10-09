package icbs.deposit



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import icbs.lov.DocInventoryStatus
import icbs.lov.CertificateTimeDepositStatus
import icbs.lov.PassbookStatus
import icbs.lov.CheckStatus
import icbs.admin.UserMaster
import icbs.admin.Branch
import javax.servlet.http.HttpSession
import icbs.deposit.CTD
import groovy.sql.Sql
import groovy.json.JsonBuilder
import grails.converters.JSON
import grails.converters.deep.JSON
//import icbs.deposit.
//import icbs.deposit.CTD
@Transactional(readOnly = true)
class DocInventoryController {
    def dataSource 
    def auditLogService
    static allowedMethods = [save: "POST", update: "PUT",activate: "POST", delete: "POST", cancel: "POST"]
    def index(Integer max) {
        def count
        
        println "index params" + params
        params.max = Math.min(max ?: 25, 100)
        if(params.searchType==null){
            params.searchType = 1
        }
        def paramsid = params.searchType
        def bound 
        def DocInventoryList = DocInventory.createCriteria().list (params) {
            
                if (params.searchType) {
                    //println("search Type!")
                    
                    eq("type.id",params.searchType as Long)
                }
                
                if(params.query&&params.query?.isLong()){
              
                    println "query" + params.query
                     bound = params.query.toLong()
                    
                      if(params.searchType==null){
                        params.searchType = 1
                         }
        
                    def sql = new Sql(dataSource)
                    def sqlqueries = "select * from doc_inventory where type_id = "+paramsid.toLong()+"" 
                        sqlqueries +=" AND (("+bound+" BETWEEN series_start and series_end) or ((series_start = "+bound+") or (series_end = "+bound+")))"
                    def result =  sql.rows(sqlqueries)
                
//                    DocInventoryList = result.collectEntries{
//                        doclist -> [doclist.id,]
//                    }
                    if (result){
                    eq("id", result.id[0].toLong())    
                    }else{
                    eq("seriesStart", bound)  
                    }

//                  
                }
                
        }
        

        println count
        respond DocInventoryList, model:[params:params,DocInventoryInstanceCount: DocInventoryList.totalCount]
    }

    def show(DocInventory docInventoryInstance) {
        respond docInventoryInstance
    }

    def create() {
        respond new DocInventory(params)
    }

    @Transactional
    def save(DocInventory docInventoryInstance) {
//        println "Doc Instance" + docInventoryInstance
        if (docInventoryInstance == null) {
            notFound()
            return
        }

        if (docInventoryInstance.hasErrors()) {
            flash.message ="Series Start and Series End already exist!|error|alert"
            respond docInventoryInstance.errors, view:'create'
            return
        }
        docInventoryInstance.branch = (UserMaster.get(session.user_id)).branch
        docInventoryInstance.save flush:true
        
         /*Insert CTDS*/
        if(docInventoryInstance.type?.id==1){
            for(Long i = docInventoryInstance.seriesStart;i<=docInventoryInstance.seriesEnd;i++){
                def ctdInstance = new CTD(ctdNo:i, docInventory:docInventoryInstance)
                ctdInstance.save()
            }
            //Log
            def description = 'Create CTD inventory ' +  docInventoryInstance.seriesStart + ' to  ' + docInventoryInstance.seriesEnd + ' -' + UserMaster.get(session.user_id).username
            auditLogService.insert('140', 'GEN00101', description, 'docInventory', null, null, null, docInventoryInstance.id)              
        }
        /*Insert Cheques*/
        if(docInventoryInstance.type?.id==3){
            for(Long i = docInventoryInstance.seriesStart;i<=docInventoryInstance.seriesEnd;i++){
                def  chequeInstance = new Cheque(docInventory:docInventoryInstance,chequeNo:i) 
                chequeInstance.save()
            }
            //Log
            def description = 'Create Check inventory ' +  docInventoryInstance.seriesStart + ' to  ' + docInventoryInstance.seriesEnd + ' -' + UserMaster.get(session.user_id).username
            auditLogService.insert('140', 'GEN00101', description, 'docInventory', null, null, null, docInventoryInstance.id)                 
        }
        /*Insert Passbook*/
        if(docInventoryInstance.type?.id==2 || docInventoryInstance.type?.id==4 || docInventoryInstance.type?.id==5){
            for(Long i = docInventoryInstance.seriesStart;i<=docInventoryInstance.seriesEnd;i++){
                def passbookInstance = new Passbook(passbookNo:i, docInventory:docInventoryInstance)
                passbookInstance.save()
            }
            //Log
            def description = 'Create Passbook inventory ' +  docInventoryInstance.seriesStart + ' to  ' + docInventoryInstance.seriesEnd + ' -' + UserMaster.get(session.user_id).username
            auditLogService.insert('140', 'GEN00101', description, 'docInventory', null, null, null, docInventoryInstance.id)                 
        }

           
        request.withFormat {
            form multipartForm {
         
                flash.message = message(code: 'default.created.message', args: [message(code: 'docInventory.label', default: 'DocInventory'), docInventoryInstance.id])
                redirect docInventoryInstance
                
            }
            '*' { respond docInventoryInstance, [status: CREATED] }
        }
    }

    def edit(DocInventory docInventoryInstance) {
        respond docInventoryInstance
    }

    @Transactional
    def update(DocInventory docInventoryInstance) {
        if (docInventoryInstance == null) {
            notFound()
            return
        }

        if (docInventoryInstance.hasErrors()) {
            respond docInventoryInstance.errors, view:'edit'
            return
        }
        if(!docInventoryInstance.branch)
        {
        docInventoryInstance.branch = (UserMaster.get(session.user_id)).branch
        }
        docInventoryInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'DocInventory.label', default: 'DocInventory'), docInventoryInstance.id])
                redirect docInventoryInstance
            }
            '*'{ respond docInventoryInstance, [status: OK] }
        }
    }
    @Transactional
    def activate(DocInventory docInventoryInstance) {
        if (depositInterestSchemeInstance == null) {
            notFound()
            return
        }

        docInventoryInstance.status = DocInventoryStatus.get(2)        

        request.withFormat {
            form multipartForm {
                flash.message = "Deposit Inventory" + docInventoryInstance.id + " activated"
                //redirect loanPerformanceClassificationInstance
                redirect action:'show', id:docInventoryInstance.id
            }
            '*'{ render status: NO_CONTENT }
        }
    }
    @Transactional
    def delete(DocInventory docInventoryInstance) {
        println("usage count: "+docInventoryInstance.usageCount)
        Boolean okToDelete = true
        
        if (docInventoryInstance == null) {
            notFound()
            return
        }
        
        if (docInventoryInstance.hasErrors()) {
            respond docInventoryInstance.errors, view:'show'
            return
        }

        if (docInventoryInstance.branch.id != UserMaster.get(session.user_id).branch.id) {
            flash.message = 'Cannot delete Document Inventory Item, different branch'
            respond docInventoryInstance.errors, view:'show'
            return
        }
        if (docInventoryInstance.usageCount > 0) {
            flash.message = 'Cannot delete Document Inventory Item, Document Inventory Already used!'
            respond docInventoryInstance.errors, view:'show'
            return
        }        
        
        def de = CertificateTimeDepositStatus.get(4)
            println " Certificate of Time Deposit Status "+de
   
//    Updating of CTD status    
         if(docInventoryInstance.type?.id==1){
            for(Long i = docInventoryInstance.seriesStart;i<=docInventoryInstance.seriesEnd;i++){
                //def ctdInstance =  new CTD(ctdNo:i, docInventory:docInventoryInstance)
                def ctdInstance =  CTD.findByCtdNo(i)//new CTD(ctdNo:i)
//                (CTD.get(i)).status = a
                if(ctdInstance)
                {
                    if (ctdInstance.status.id == 2) {
                        okToDelete = false
                    }
                }
            }
            if (okToDelete) {
                for(Long i = docInventoryInstance.seriesStart;i<=docInventoryInstance.seriesEnd;i++){
                    def ctdDelInstance =  CTD.findByCtdNo(i)
                    if(ctdDelInstance)
                        {
                            ctdDelInstance.delete()
                        }
                    }
                def description = 'Delete CTD inventory ' +  docInventoryInstance.seriesStart + ' to  ' + docInventoryInstance.seriesEnd + ' -' + UserMaster.get(session.user_id).username
                auditLogService.insert('140', 'GEN00104', description, 'docInventory', null, null, null, docInventoryInstance.id)   
                }     
            }
      
          def ve = CheckStatus.get(4)
//        Updating of cheque status
         if(docInventoryInstance.type?.id==3||docInventoryInstance.type?.id==4){
            for(Long i = docInventoryInstance.seriesStart;i<=docInventoryInstance.seriesEnd;i++){
                def  chequeInstance =  Cheque.findByChequeNo(i) 
                if(chequeInstance)
                {
                    if (chequeInstance.status.id == 2) {
                        okToDelete = false
                    }
                }                
            }   
            if (okToDelete) {
                for(Long i = docInventoryInstance.seriesStart;i<=docInventoryInstance.seriesEnd;i++){
                    def chequeDelInstance =  Cheque.findByChequeNo(i) 
                    if(chequeDelInstance)
                        {
                            chequeDelInstance.delete()
                        }
                    }
                def description = 'Delete Check inventory ' +  docInventoryInstance.seriesStart + ' to  ' + docInventoryInstance.seriesEnd + ' -' + UserMaster.get(session.user_id).username
                auditLogService.insert('140', 'GEN00104', description, 'docInventory', null, null, null, docInventoryInstance.id)                      
                } 
                
        }
 

        def ra = PassbookStatus.get(4)
        println " Passbook Status "+ra
//        Updating of passbook status
         if(docInventoryInstance.type?.id==2){
            for(Long i = docInventoryInstance.seriesStart;i<=docInventoryInstance.seriesEnd;i++){
                def passbookInstance =  Passbook.findByPassbookNo(i)
                if(passbookInstance)
                {
                    if (passbookInstance.status.id == 2) {
                        okToDelete = false
                    }
                }                 
            }
            if (okToDelete) {
                for(Long i = docInventoryInstance.seriesStart;i<=docInventoryInstance.seriesEnd;i++){
                    def passbookDelInstance =  Passbook.findByPassbookNo(i) 
                    if(passbookDelInstance)
                        {
                            passbookDelInstance.delete()
                        }
                    }
                    def description = 'Delete Passbook inventory ' +  docInventoryInstance.seriesStart + ' to  ' + docInventoryInstance.seriesEnd + ' -' + UserMaster.get(session.user_id).username
                    auditLogService.insert('140', 'GEN00104', description, 'docInventory', null, null, null, docInventoryInstance.id)                      
                }            
        }
        
        if (okToDelete) {
            docInventoryInstance.delete()
        } else {
            flash.message = 'Cannot delete Document Inventory Item, already used'
            respond docInventoryInstance.errors, view:'show'
            return
        }
        
        
        request.withFormat {
            form multipartForm {
                flash.message = "Deposit Inventory" + docInventoryInstance.id + " deleted"
                //redirect action:'show', id:docInventoryInstance.id
                redirect action:'index'
            }
            '*'{ render status: NO_CONTENT }
        }
    }
    
    
//    protected void notFound() {
//        request.withFormat {
//            form multipartForm {
//                flash.message = message(code: 'default.not.found.message', args: [message(code: 'docInventory.label', default: 'DocInventory'), params.id])
//                redirect action: "index", method: "GET"
//            }
//            '*'{ render status: NOT_FOUND }
//        }
//    }
    
//    --- > Cancel function added here! :)

    @Transactional
    def cancel(DocInventory docInventoryInstance) {

        if (docInventoryInstance == null) {
            notFound()
            return
        }
        
        def de = CertificateTimeDepositStatus.get(3)
            println " Certificate of Time Deposit Status "+de
   
//    Updating of CTD status    
         if(docInventoryInstance.type?.id==1){
            for(Long i = docInventoryInstance.seriesStart;i<=docInventoryInstance.seriesEnd;i++){
                //def ctdInstance =  new CTD(ctdNo:i, docInventory:docInventoryInstance)
                def ctdInstance =  CTD.findByCtdNo(i)//new CTD(ctdNo:i)
//                (CTD.get(i)).status = a
                ctdInstance.status = de
                ctdInstance.save()
            }
        }
      
//        Updating of cheque status
        def ve = CheckStatus.get(4)
         if(docInventoryInstance.type?.id==3||docInventoryInstance.type?.id==4){
            for(Long i = docInventoryInstance.seriesStart;i<=docInventoryInstance.seriesEnd;i++){
                def  chequeInstance =  Cheque.findByChequeNo(i) 
                chequeInstance.status = ve
                chequeInstance.save()
            }
        }
 

//        Updating of passbook status
        def ra = PassbookStatus.get(3)
        println " Passbook Status "+ra
         if(docInventoryInstance.type?.id==2){
            for(Long i = docInventoryInstance.seriesStart;i<=docInventoryInstance.seriesEnd;i++){

                def passbookInstance =  Passbook.findByPassbookNo(i)
                if(passbookInstance){
                passbookInstance.status = ra
                passbookInstance.save()
                }
            }
        }

        docInventoryInstance.status = DocInventoryStatus.get(4)
        docInventoryInstance.isCanceled = true
        docInventoryInstance.canceledBy = UserMaster.get(session.user_id)
        docInventoryInstance.canceledAt = Branch.get(1).runDate
        request.withFormat {
            form multipartForm {
                flash.message = "Deposit Inventory" + docInventoryInstance.id + " cancelled"
                redirect action:'show', id:docInventoryInstance.id
            }
            '*'{ render status: NO_CONTENT }
        }
    }
    //sai
    //start
    def viewDetails(DocInventory docInventoryInstance , Integer max) {
         println "viewDetails outise params" + params
         println "Docinvetory" +  docInventoryInstance
         println "max" + max
        if(max <= 0){
        max = 10    
        } 
          println params.query
        if (docInventoryInstance.type.id == 1) {  
            println "CTD params" + params
            println "CTD docinventory" + docInventoryInstance
            params.max = Math.min(max ?: 25, 100)
            if(params.query.toString() == "null" || params.query.toString() == "")
            {
            def ctdInstance = CTD.createCriteria().list(params){
             eq("docInventory", docInventoryInstance)     
              order("ctdNo", "asc")
            }
            render(view: "viewCtdDetails", model: [params:params,docInventoryInstance: docInventoryInstance,
                    ctdInstance: ctdInstance,ctdInstanceCount:ctdInstance.totalCount])
            return
            }else{
                
            def ctdInstance = CTD.createCriteria().list(params){
             eq("docInventory", docInventoryInstance)
             eq("ctdNo", Long.parseLong(params.query))
            }
            render(view: "viewCtdDetails", model: [params:params,docInventoryInstance: docInventoryInstance,
                    ctdInstance: ctdInstance,ctdInstanceCount:ctdInstance.totalCount])
            return
            }
          
        }
        if (docInventoryInstance.type.id == 2 || docInventoryInstance.type.id == 4 || docInventoryInstance.type.id == 5) { 
            println "2 4 5 params" + params
            params.max = Math.min(max ?: 25, 100)
             if(params.query.toString() == "null" || params.query.toString() == ""){
                 println "PB 2 4 5" + params
                   println "2 4 5 docinventory" + docInventoryInstance
                  def pbInstance = Passbook.createCriteria().list(params){
                     eq("docInventory", docInventoryInstance)   
                        order("passbookNo", "asc")
                        }
                        render(view: "viewSaPbDetails", model: [params:params,docInventoryInstance: docInventoryInstance, 
                        pbInstance: pbInstance,pbInstanceCount:pbInstance.totalCount])
             }else{
                 
                     def pbInstance = Passbook.createCriteria().list(params){
                        eq("docInventory", docInventoryInstance)   
                        eq("passbookNo", Long.parseLong(params.query))
                        }
                        render(view: "viewSaPbDetails", model: [params:params,docInventoryInstance: docInventoryInstance, 
                        pbInstance: pbInstance,pbInstanceCount:pbInstance.totalCount])
             }
           
            return
        }        
        if (docInventoryInstance.type.id == 3) {
            println "checque" + params
             println "CTD docinventory" + docInventoryInstance
            params.max = Math.min(max ?: 25, 100)
            if(params.query.toString() == "null" || params.query.toString() == ""){
             def chkInstance = Cheque.createCriteria().list(params){  
             eq("docInventory", docInventoryInstance)
             
             order("chequeNo", "asc")
            } 
            render(view: "viewChkDetails", model: [params:params,docInventoryInstance: docInventoryInstance, 
                        chkInstance: chkInstance,chkInstanceCount:chkInstance.totalCount])   
            }else{
            def chkInstance = Cheque.createCriteria().list(params){  
             eq("docInventory", docInventoryInstance)
            eq("chequeNo", Long.parseLong(params.query))
         
            }
            render(view: "viewChkDetails", model: [params:params,docInventoryInstance: docInventoryInstance, 
                        chkInstance: chkInstance,chkInstanceCount:chkInstance.totalCount])   
            }
           
            
            return
        }  
    }
    //end
    
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'docInventory.label', default: 'DocInventory'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
