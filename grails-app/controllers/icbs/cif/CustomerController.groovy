package icbs.cif


import icbs.lov.*
import icbs.admin.UserMaster
import icbs.admin.CustomerGroup
import static org.springframework.http.HttpStatus.*
import grails.converters.JSON
import grails.converters.deep.JSON

import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest
import java.util.Map;
import java.util.regex.Matcher
import java.util.regex.Pattern
import org.codehaus.groovy.grails.web.json.JSONObject
import org.springframework.validation.FieldError
import icbs.gl.CfgAcctGlTemplate
import icbs.loans.Loan
import icbs.lov.LoanAcctStatus
import icbs.cif.Customer
import icbs.admin.Branch
import icbs.cif.CustomerInfobase
import groovy.sql.Sql
import icbs.loans.Collateral
class CustomerController{
    static allowedMethods = [save: "POST", update: ["PUT","POST"], delete: "DELETE"]
    def dataSource
    def policyService    
    def customerService
    def customerid
    def auditLogService
    
    /*Customer Search Page*/
    def customerSearch(){
       //render search in page
       //page contents handled by SearchController
       params.actionTemplate = 'customerInquirySearchAction';
      render(view:'search/customerSearch', model:[params:params])
    }
    /*Customer Inquiry Page*/
    def customerInquiry(){
       println(params)
       if(params.id){
           def customerInstance = Customer.get(params.id)
           customerid = customerInstance.id
           println "customerid " + customerid
           
           //Log
           def description = 'Customer Details of ' +  customerInstance.customerId + ' was viewed by ' + UserMaster.get(session.user_id).username
           auditLogService.insert('050', 'CIF00000', description, 'customer', null, null, null, customerInstance.id)              
           
            render(view:"inquiry/customerInquiry",model:[customerInstance:customerInstance])
       }
       else {
           render(view:"inquiry/customerInquiry")
       }
    }
     /*Update Customer Status In Customer Inquiry When Updated*/
    def customerUpdateInquiryFormAjax(){
        if(params.id){
            def customerInstance = Customer.get(params.id)
            def jsonObject =new JSONObject();
            jsonObject.put('inquiryForm',g.render(template:"inquiry/customerInquiryForm",model:[customerInstance:customerInstance]))
            jsonObject.put('actions',g.render(template:"inquiry/action/action",model:[customerInstance:customerInstance]))
            render jsonObject
            return
        }else{
            notFound()
            return
            
        }  
    }
    /*Customer View More Information*/
    def customerViewMoreInformation(){
        if(params.id){
           println "params " + params
           
           def customerInstance = Customer.get(params.id)
           println "CI? " + customerInstance
           
           //Log
           def description = 'Customer Details (View More Info) of ' +  customerInstance.customerId + ' was viewed by ' + UserMaster.get(session.user_id).username
           auditLogService.insert('050', 'CIF00000', description, 'customer', null, null, null, customerInstance.id)            
           
           respond customerInstance
        }
    }

    /*Customer info for loans*/
    def showBasicCustomerInfoAjax(){
        def customerInstance

        if (params.id) {
            customerInstance = Customer.get(params.id)
        } else {
            customerInstance = null
        }
        
        // get aggregate loans
        def list = Loan.createCriteria().list () {
            and{
                eq("customer",customerInstance)
                gt("balanceAmount",0.00D)
                lt("status", LoanAcctStatus.get(6))
            }
        }
        double totReleased = 0.00D
        double totBalance = 0.00D
        int totCount = 0
        for (l in list) {
            totReleased = totReleased + l.grantedAmount
            totBalance = totBalance + l.balanceAmount
            totCount++
        }
        render(template:"loans/customerBasicInfo", model:[customerInstance:customerInstance, totReleased:totReleased, totBalance:totBalance, totCount:totCount]) as JSON
        return
    }

    /*One to many forms ajax.Customer registration and edit templates*/
    def addAddressFormAjax(){
        render (template:'form/address/onetomany/address',model:[i:(params.i as Integer)]) as JSON
    }
    def addContactFormAjax(){
        render (template:'form/contact/onetomany/contact',model:[i:(params.i as Integer),choice:params.choice]) as JSON
    }
    def addRelationFormAjax(){
        println("add Relation Params" +params)
        def jsonObject =new JSONObject();
        if(params.customer2&&params.i){
            def relation = new Relation()
            relation.customer2 = Customer.read(params.customer2);
            println("add known customer choice"+params.choice)
            jsonObject = jsonObject.put('html', g.render (template:'form/relation/onetomany/relation',model:[relation:relation,i:(params.i as Integer),choice:params.choice]))
            jsonObject = jsonObject.put('i',params.i)
        }else{
            jsonObject = jsonObject.put('html', g.render (template:'form/relation/onetomany/relation',model:[i:(params.i as Integer),choice:params.choice]))
        }
        println(jsonObject.toString())
        render jsonObject
    }
    def addEducationFormAjax(){
        render (template:'form/education/onetomany/education',model:[i:(params.i as Integer),choice:params.choice]) as JSON
    }
    def addAttachmentFormAjax(){
        render (template:'form/attachment/onetomany/attachment',model:[i:(params.i as Integer)]) as JSON
    }
    def addPresentedIdFormAjax(){
        render (template:'form/presentedid/onetomany/presentedId',model:[i:(params.i as Integer)]) as JSON
    }
    def addOtherAcctFormAjax(){
        render (template:'form/otheracct/onetomany/otherAcct',model:[i:(params.i as Integer)]) as JSON
    }
    
    /*Customer Relationship Page*/
    def customerShowRelated(){
        if(params.id){
           def customerInstance = Customer.read(params.id)
           
           //Log
           def description = 'Related customer of ' +  customerInstance.customerId + ' was viewed by ' + UserMaster.get(session.user_id).username
           auditLogService.insert('050', 'CIF00000', description, 'customer', null, null, null, customerInstance.id)            
           
           render (view:"relation/showRelated", model:[customerInstance:customerInstance])
        }else{
            notFound()
            return    
        }  
    }
    /*Update Customer Relations Table In Customer Inquiry When Updated*/
    def customerShowRelatedFormAjax(){
        if(params.id){
            def customerInstance = Customer.read(params.id)
            render(template:"relation/showRelatedForm",model:[customerInstance:customerInstance]) as JSON
            return
        }else{
            notFound()
            return
            
        }  
    }
    def customerCreateRelatedAjax(int customerRelationshipType){
        /*Calling customer is valid*/
        if(params.id){
            def relationInstance = new Relation();
            relationInstance.customer = Customer.read(params.id)
            //galing sa search  
            if(params.customer2){
                relationInstance.customer2 = Customer.read(params.customer2)
                if (customerRelationshipType==1){
                    customerRelationshipType = relationInstance.customer2.type.id
                    println 'cust2 params'
                }
            }
            render (template:'relation/createRelated',model:[relationInstance:relationInstance,customerRelationshipType:customerRelationshipType]) as JSON
        }else{
            notFound()
            return
        }
    }
    def customerEditRelatedAjax(int customerRelationshipType){
        println "relatuionseditparams" +params   
        if (customerRelationshipType==1){
            println "Type " + Relation.get(params.id).customer2.id
            customerRelationshipType = Customer.get(Relation.get(params.id).customer2.id).type.id
        }
        if(params.id){
            render (template:'relation/editRelated',model:[relationInstance:Relation.get(params.id),params:params,customerRelationshipType:customerRelationshipType]) as JSON
        }else{
            notFound()
            return
        }
    }
    
    def customerDeleteRelatedAjax(int customerRelationshipType){
        println "relatuionsdeleteparams" +params 
        
        if(params.id){
            render (template:'relation/deleteRelated',model:[relationInstance:Relation.get(params.id),params:params,customerRelationshipType:customerRelationshipType]) as JSON
        }else{
            notFound()
            return
        }
    }
    
    def customerSaveRelAjax(){
        
            println "save relation ajax"
            println "params : " + params
            def relationInstance = new Relation()
            bindData(relationInstance, params)  
            //def relInstance = new Relation()
            //println "params : " + params
            //relInstance.statusId = ConfigItemStatus.get(3) 
            //println "status.id " + relInstance.statusId
            //relInstance.save(flush:true,failOnError:true)
            flash.message = "Customer Relation Successfully Deleted"
            relationInstance.save(flush:true,failOnError:true)
            render (template:'relation/deleteRelated',model:[relationInstance:relationInstance,saved:'saved']) as JSON
            return
    }
    
    def customerSaveRelatedAjax(){
        def customerIns = Customer.get(params.customer.id)
        customerIns.lastUpdatedBy = UserMaster.get(session.user_id)
        println customerIns
        println "Save Related Ajax"+params
        if(!params.id){
            def relationInstance = new Relation()
            bindData(relationInstance, params)
            if(!relationInstance.validate()){
                render (template:'relation/createRelated',model:[relationInstance:relationInstance,saved:'saved']) as JSON
                return
            }else{
                relationInstance.save(failOnError: true, flush:true,validate:false)
                def relationInstance2 = new Relation()
                bindData(relationInstance2, params)
                relationInstance2.customer = relationInstance.customer2
                relationInstance2.customer2 = relationInstance.customer
                relationInstance2.type = null          
                relationInstance2.save(failOnError: true,flush:true,validate:false)
                flash.message = "Customer Relation Successfully Created"
                println(relationInstance);
                render (template:'relation/createRelated',model:[relationInstance:relationInstance,saved:'saved']) as JSON
                return
   
                // Log
                def description = 'Created New Customer Relationship for  ' + Customer.get(params.customer.id).customerId + ' by ' + UserMaster.get(session.user_id).username
                println 'Log Description:' + description
                auditLogService.insert('060', 'CIF00000', description, 'relation', null, null, 'customer/customerShowRelated/'+Customer.get(params.customer.id).id, relationInstance.id)

                render (template:'relation/createRelated',model:[relationInstance:relationInstance,saved:'saved']) as JSON
                return
            }
        }else if(params.id){
            println "Update Related Ajax"+params
            def relationInstance = Relation.get(params.id)
             bindData(relationInstance, params,['relationStatusId'])
            if(!relationInstance.validate()){
                render (template:'relation/EditRelated',model:[relationInstance:relationInstance,saved:'saved']) as JSON
                return
            }else{
                relationInstance.save flush:true
                flash.message = "Customer Relation Successfully Updated"
                
                // Log
                def description = 'Update Customer Relationship for  ' + Customer.get(params.customer.id).customerId + ' by ' + UserMaster.get(session.user_id).username
                println 'Log Description:' + description
                auditLogService.insert('060', 'CIF00000', description, 'relation', null, null, 'customer/customerShowRelated/'+Customer.get(params.customer.id).id, relationInstance.id)

                render (template:'relation/EditRelated',model:[relationInstance:relationInstance,saved:'saved']) as JSON
                return
            }
        }
        else{
            
        }
    }
    /*get form*/
    def getCustomerUpdateStatusFormAjax(){
        if(params.id){
            def customerInstance = Customer.read(params.id);
            render(template:'update/customerEditStatus',model:[customerInstance:customerInstance]) as JSON
        }else{
            notFound()
            return
        }
    }
    def getCustomerUpdateCreditLimitFormAjax(){
        if(params.id){
            def customerInstance = Customer.read(params.id);
            render(template:'update/customerEditCreditLimit',model:[customerInstance:customerInstance]) as JSON
        }else{
            notFound()
            return
        }
    }
    /*Update Customer Status*/
    def customerUpdateStatusAjax(){
        def result = customerService.update(params,'status')
        println 'update status params'+params
        if(!result.error) {
            def message = "Customer Status Successfully Updated"
            println "walang error!"
            println result.customerInstance.errors
                        
            // Log
            def description = 'Customer Status of ' + Customer.read(params.id).customerId + ' was updated to ' + Customer.read(params.id).status + ' by ' + UserMaster.get(session.user_id).username
            println 'Log Description:' + description
            auditLogService.insert('060', 'CIF00040', description, 'customer', null, null, 'customer/customerInquiry/'+ Customer.read(params.id).id, Customer.read(params.id).id)

            render (template:'update/customerEditStatus',model:[message:message,customerInstance:result.customerInstance,saved:'saved']) as JSON
            return
        }
        if(result.error.code == "default.not.found") {
            notFound()
            return
        }
        /*Error in Validation, to prevent lazylist exception refresh instance*/
        def customerInstance = Customer.read(params.id)
        customerInstance.errors = result.customerInstance.errors
        render (template:'update/customerEditStatus',model:[customerInstance:customerInstance]) as JSON
    }
     /*Update Customer Status*/
    def customerUpdateCreditLimitAjax(){
        def result = customerService.update(params,'creditLimit')
        if(!result.error) {
            def message = "Credit Limit Successfully Updated"
            
            // Log
            def description = 'Credit Limit of ' + Customer.read(params.id).customerId + 'was updated to ' + Customer.read(params.id).creditLimit + ' by ' + UserMaster.get(session.user_id).username
            println 'Log Description:' + description
            auditLogService.insert('060', 'CIF00000', description, 'customer', null, null, 'customer/customerInquiry/'+ Customer.read(params.id).id, Customer.read(params.id).id)

            render (template:'update/customerEditCreditLimit',model:[message:message,customerInstance:result.customerInstance,saved:'saved']) as JSON
            return
        }
        if(result.error.code == "default.not.found") {
            notFound()
            return
        }
        /*Error in Validation, to prevent lazylist exception refresh instance*/
        def customerInstance = Customer.read(params.id)
        customerInstance.errors = result.customerInstance.errors
        render (template:'update/customerEditCreditLimit',model:[customerInstance:customerInstance]) as JSON
    }
    /*Customer Verification Ajax Per Form Client Side Validation*/
    private def customerDuplicateTest(customerVerificationCommand cmd){
        println cmd.id
        println cmd.name1
        println cmd.name2
        println cmd.name3
        println cmd.name4
        def list = Customer.createCriteria().list () {
            and{
                if(cmd.id){
                    ne('id',cmd.id as Long)
                }
                if(cmd.name1){
                    ilike("name1", "%${cmd.name1}%")
                }
                if(cmd.name2){
                    ilike("name2", "%${cmd.name2}%")
                }
                if(cmd.name3){
                    ilike("name3", "%${cmd.name3}%")
                }
                if(cmd.birthDate){
                    eq("birthDate", cmd.birthDate)
                }
            }
        }
        println "eto ung list ng posible duplicates"+list
        return list
    }
    def customerVerificationValidationAjax(customerVerificationCommand cmd){
        def duplicateList;
        
        println "pumasok dito sa duplicate test!"
        println params
        if(!cmd.hasErrors()&&!cmd.id){
            println "no errors"
            duplicateList = customerDuplicateTest(cmd);
        }else{
            println "errors"+cmd.errors
        }
        AjaxPostResponse response = new AjaxPostResponse();
        response.domainObject = cmd
        
        def jsonObject =new JSONObject();
        if(duplicateList?.size()>0){
            jsonObject = jsonObject.put("possibleDuplicate", true);
        }
        if(!params?.onsubmit){
            if(cmd.type?.id!=1){
                jsonObject = jsonObject.put("html",g.render (template:'form/customer/customerverification/corporation',model:[customerInstance:cmd,duplicateList:duplicateList,isVerified:"true"]))
            }else{
                jsonObject = jsonObject.put("html",g.render(template:'form/customer/customerverification/private',model:[customerInstance:cmd,duplicateList:duplicateList,isVerified:"true"]))
            }
        }else{
            if(cmd.type?.id!=1){
                jsonObject = jsonObject.put("html",g.render (template:'form/customer/customerverification/corporation',model:[customerInstance:cmd,duplicateList:duplicateList,onsubmit:"true",isVerified:"true"]))
                
            }else{
                jsonObject = jsonObject.put("html",g.render(template:'form/customer/customerverification/private',model:[customerInstance:cmd,duplicateList:duplicateList,onsubmit:"true",isVerified:"true"]))
            }
        }
        render jsonObject
    }
    def customerOtherDetailsValidationAjax(customerOtherDetailsCommand cmd){
       render (template:'form/customer/othercustomerinfo/otherCustomerInfo',model:['customerInstance':cmd]) as JSON
    }
    def customerContactInformationValidationAjax(customerContactsCommand cmd){
        println cmd.contacts
        println("entered contacts validation")
        render (template:'form/contact/contactInfo',model:['customerInstance':cmd]) as JSON
    }
    def customerAddressInformationValidationAjax(customerAddressessCommand cmd){
        render (template:'form/address/addrInfo',model:['customerInstance':cmd]) as JSON
    }
    def customerEmploymentBusinessInformationValidationAjax(customerEmploymentandBusinessCommand cmd){
        render (template:'form/jointviews/employmentsAndBusinessInfo',model:['customerInstance':cmd]) as JSON
    }
    def customerRelationValidationAjax(customerRelationCommand cmd, int customerRelationshipType){
        println "relation validation *************"+params
        cmd.relations.removeAll([null])
        if(customerRelationshipType==1){
            render (template:'form/relation/relationInfo',model:['customerInstance':cmd,customerRelationshipType:customerRelationshipType]) as JSON
        }else{
             render (template:'form/relation/relationInfoBusiness',model:['customerInstance':cmd,customerRelationshipType:customerRelationshipType]) as JSON
        }
    }
    def customerEducationInformationValidationAjax(customerEducationsCommand cmd){
        cmd.validate()
        //def postResponse = customerService.preparePostResponse(customerInstance,"educations(.*)")
        render(template:'form/education/educationInfo',model:['customerInstance':cmd]) as JSON
    }
    def customerIdsAndOtherAcctsValidationAjax(customerPresentedIdsandOtherAcctsCommand cmd){
        cmd.validate()
        //def postResponse = customerService.preparePostResponse(customerInstance,["presentedids(.*)","otheraccts(.*)"])
        render (template:'form/jointviews/presentedIdsAndOtherAcctsInfo',model:['customerInstance':cmd]) as JSON
    }
    /*End Customer Ajax Validation*/
    /**********************************/
    def index(Integer max) {
        redirect(action:'customerSearch')
    }

    def show(Customer customerInstance) {
        respond customerInstance
    }

    def create() {
        if(!params.type?.id){
            render (view:'create',model:['customerInstance': new Customer(params),'firstCreate':true])
        }else{
            respond new Customer(params)
        }
    }
    def save(Customer customerInstance) {
         /*Attachments*/
        if (request instanceof MultipartHttpServletRequest){
            request.fileNames.each {
                def uploadedFile = request.getFile(it)
                String subscript = (it.split("\\.")[0])
                if(uploadedFile.getSize()<1){
                    if(!params[subscript+".id"]){
                        params.remove(subscript+'.fileName')
                    }
                }else{
                    params[subscript+".fileName"] = uploadedFile.getOriginalFilename()
                    params[subscript+".fileType"] = uploadedFile.getContentType()
                }
            }
        }
        //add branch
        params.branch  = UserMaster.get(session.user_id)?.branch?.id
        params.createdBy = UserMaster.get(session.user_id)
        params.lastUpdatedBy = UserMaster.get(session.user_id)
        if (!params.dosriCode) {
           params.dosriCode = CustomerDosriCode.get(1) 
        }
        def result = customerService.save(params)
        if(!result.error) {
                                    
            // Log
            def description = 'New Customer Record for ' + result.customerInstance.customerId + ' was created' + ' by ' + UserMaster.get(session.user_id).username
            println 'Log Description:' + description
            auditLogService.insert('060', 'CIF00010', description, 'customer', null, null, 'customer/customerInquiry/', result.customerInstance.id)

            //flash.message = message(code: 'default.created.message', args: [message(code: 'customer.label', default: 'Customer'), result.customerInstance.id])
            redirect(action: "customerInquiry", id: result.customerInstance.id)
            return
        }
            //render (template:'form',model:[customerInstance:result.customerInstance]) as JSON
             /*Error in Validation, to prevent lazylist exception refresh instance*/
        //def customerInstance = Customer.get(params.id)
        customerInstance.errors = result.customerInstance.errors
        println result.customerInstance.errors
        respond customerInstance.errors, view:'create'

    }

    def edit(Customer customerInstance) {
        respond customerInstance
    }
    /*Customer Instance is a Command  Object*/
    def update(Customer customerInstance) {
         /*Attachments*/
        if (request instanceof MultipartHttpServletRequest){
            request.fileNames.each {
                def uploadedFile = request.getFile(it)
                String subscript = (it.split("\\.")[0])
                if(uploadedFile.getSize()<1){
                    if(!params[subscript+".id"]){
                        params.remove(subscript+'.fileName')
                    }
                }else{
                    params[subscript+".fileName"] = uploadedFile.getOriginalFilename()
                    params[subscript+".fileType"] = uploadedFile.getContentType()
                }
            }
        }
        params.lastUpdatedBy = UserMaster.get(session.user_id).id
        println 'this is my params'
        println  params  
        def result = customerService.update(params)
        if(!result.error) {
            flash.message = message(code: 'default.updated.message', args: [message(code: 'Customer.label', default: 'Customer'), params.id])
                        
            // Log
            def description = 'Customer details of ' + Customer.read(params.id).customerId + ' was updated'
            println 'Log Description:' + description
            auditLogService.insert('060', 'CIF00000', description, 'customer', null, null, 'customer/customerInquiry/'+ Customer.read(params.id).id, Customer.read(params.id).id)

            redirect(action: "customerInquiry", id: result.customerInstance.id)
            // redirect(action: "show", id: params.id)
            return
        }
        if(result.error.code == "default.not.found") {
            notFound()
            return
        }
        /*Error in Validation, to prevent lazylist exception refresh instance*/
        def c = Customer.read(params.id)
        c.properties = params
        c.errors = result.customerInstance.errors
        render view: "edit", model: [customerInstance:c]
      
        
    }
    def delete(Customer customerInstance) {

        if (customerInstance == null) {
            notFound()
            return
        }

        customerInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Customer.label', default: 'Customer'), customerInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }
    def viewCustomerReports(){
        render (view:'reports/view')
    }
    // Generate list of Customers
    def createReport={
        println params
        def list
        if(params.type=="individual"){
            list = Customer.get(params.customer.id) 
        }
        list = Customer.list(fetch:[branch:"eager"]) 
            //println customers
        chain(controller:'jasper',action:'index',model:[data:list],params:params)
        
        //def customers = Customer.findAll("from Customer as c left join c.contacts as a where a.status.id=2 and a.isPrimaryPhone=true")
    }
    
    def customerInfobase(Customer customerInstance){
        // display view
        def result = CustomerInfobase.createCriteria().list () {
            and{
                eq("status",ConfigItemStatus.get(2))
                eq("customer",customerInstance)
            }
        }

        [customerInstance:customerInstance,result:result]
    }
    def createCustomerInfoBaseAjax(){
        println("params : "+params)
        def json = request.JSON
        println("customer: ididid: "+Customer.get(json.customerTID.toInteger()).id)
        def infoBaseIntance = new CustomerInfobase()
        infoBaseIntance.infoMessage = json.infoMsg.toString()
        infoBaseIntance.customer = Customer.get(json.customerTID.toInteger())
        infoBaseIntance.status = ConfigItemStatus.get(2)
        infoBaseIntance.user = UserMaster.get(session.user_id)
        infoBaseIntance.refDate = Branch.get(1).runDate
        infoBaseIntance.save(flush:true)
        println("savinggg complete")
        def sql = new Sql(dataSource)
        def queryall = "select * from customer_infobase order by id desc limit 1"
        def resultqueryall = sql.rows(queryall)
        render resultqueryall as JSON
    }
    def removeCustomerInfoBaseAjax(){
        def json = request.JSON
        def infoBaseIntance = CustomerInfobase.get(json.infobaseId)
            infoBaseIntance.status = ConfigItemStatus.get(3)
            infoBaseIntance.save(flush: true)
            def sql = new Sql(dataSource)
            def queryall = "select * from customer_infobase order by id desc limit 1"
            def resultqueryall = sql.rows(queryall)
            render resultqueryall as JSON     
    }
    //============== for viewing of accepted customer loan comaker
    def viewLoanComakerRelationship(){
        if(params.id){
           def customerInstance = Customer.read(params.id)
           //==query to find all loan comaker=============
           def sql = new Sql(dataSource)
           def queryall = "select loan.id,loan_application.customer_id,customer.display_name,loan_application_comaker.loan_application_id,loan.account_no,loan_acct_status.description,loan.status_id from loan_application_comaker INNER JOIN loan ON loan_application_comaker.loan_application_id=loan.loan_application_id INNER JOIN loan_application on loan.loan_application_id = loan_application.id INNER JOIN customer on loan_application.customer_id = customer.id INNER JOIN loan_acct_status on loan_acct_status.id = loan.status_id where loan.status_id < 5 and loan_application_comaker.customer_id="+params.id
           def resultqueryall = sql.rows(queryall)
           //==================================
           //Log
           def description = 'Related customer of ' +  customerInstance.customerId + ' was viewed by ' + UserMaster.get(session.user_id).username
           auditLogService.insert('050', 'CIF00000', description, 'customer', null, null, null, customerInstance.id)            
           
           render (view:"viewLoanComakerRelationship", model:[customerInstance:customerInstance,resultqueryall:resultqueryall])
        }else{
            notFound()
            return    
        }        
    }
    //============================================================
    //============== for viewing of accepted customer collateral
    def viewCustomerCollateral(){
        if(params.id){
           def customerInstance = Customer.read(params.id)
            def c = Collateral.createCriteria()
            def results = c.list {
                eq("owner",customerInstance)
                order("id", "asc")
            }
           //Log
           println("results: "+results)
           //def description = 'Related customer of ' +  customerInstance.customerId + ' was viewed by ' + UserMaster.get(session.user_id).username
           //auditLogService.insert('050', 'CIF00000', description, 'customer', null, null, null, customerInstance.id)            
           
           render (view:"viewCustomerCollateral", model:[customerInstance:customerInstance,results:results])
        }else{
            notFound()
            return    
        }        
    }
    //============================================================
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
@grails.validation.Validateable
class customerVerificationCommand {
        CustomerType type//lov
        int id
        //CfgAcctGlTemplate glLink
        CustomerGroup group
        String name1
        String name2
        String name3
        String name4
        Lov title
        Gender gender//lov
        Lov civilStatus
        Date birthDate
        String birthPlace
            static constraints = {
                group nullable:false
                importFrom Customer
            }
}
@grails.validation.Validateable
class customerOtherDetailsCommand {
        CustomerType type//lov
        String displayName
        ResidentType customerCode1
        RiskType customerCode2
        FirmSize customerCode3
        String sourceOfIncome
        Lov nationality
        CustomerDosriCode dosriCode
        String sssNo
        String gisNo
        String tinNo
        String passportNo
        String pepDescription
        String amla
            static constraints = {
                importFrom Customer
            }
}
@grails.validation.Validateable
class customerContactsCommand {
    List <Contact> contacts = [].withLazyDefault {new Contact()}
    static constraints = {
            //importFrom Contact
        contacts validator:{ val,obj,errors -> 
            if(val){
                for(int i = 0; i < val.size(); i++){
                    if(!val[i]){continue}
                    if(!val[i].validate()){
                        val[i].errors.allErrors.each {error->
                            errors.rejectValue(
                                "contacts[${i}]."+error.field,
                                error.getCode(),
                                error.getArguments(),
                                error.getDefaultMessage()
                           )
                        }
                    }
                }   
            }
            println errors
            println "end"   
        }
    }
}
@grails.validation.Validateable
class customerAddressessCommand {
    List <Address> addresses = [].withLazyDefault {new Address()}
    static constraints = {
        addresses validator:{ val,obj,errors -> 
            if(val){
                for(int i = 0; i < val.size(); i++){
                    if(!val[i]){continue}
                    if(!val[i].validate()){
                        val[i].errors.allErrors.each {error->
                            errors.rejectValue(
                                "addresses[${i}]."+error.field,
                                error.getCode(),
                                error.getArguments(),
                                error.getDefaultMessage()
                           )
                        }
                    }
                }   
            }
            println errors
            println "end"   
        }       
    }
}
@grails.validation.Validateable
class customerEmploymentandBusinessCommand {
    CustomerType type//lov
    List <Employment> employments = [].withLazyDefault {new Employment()}
    List <Business> businesses = [].withLazyDefault {new Business()}
    static constraints = {
        employments validator:{ val,obj,errors -> 
            if(val){
                for(int i = 0; i < val.size(); i++){
                    if(!val[i]){continue}
                    if(!val[i].validate()){
                        val[i].errors.allErrors.each {error->
                            errors.rejectValue(
                                "employments[${i}]."+error.field,
                                error.getCode(),
                                error.getArguments(),
                                error.getDefaultMessage()
                           )
                        }
                    }
                }   
            }
            println errors
            println "end"   
        }
        businesses validator:{ val,obj,errors -> 
            if(val){
                for(int i = 0; i < val.size(); i++){
                    if(!val[i]){continue}
                    if(!val[i].validate()){
                        val[i].errors.allErrors.each {error->
                            errors.rejectValue(
                                "businesses[${i}]."+error.field,
                                error.getCode(),
                                error.getArguments(),
                                error.getDefaultMessage()
                           )
                        }
                    }
                }   
            }
            println errors
            println "end"   
        }       
    }
}
@grails.validation.Validateable
class customerRelationCommand{
    List <Relation> relations = [].withLazyDefault {new Relation()}
    static constraints={
        relations validator:{ val,obj,errors -> 
            if(val){
                for(int i = 0; i < val.size(); i++){
                    if(!val[i]){continue}
                    if(!val[i].validate()){
                        val[i].errors.allErrors.each {error->
                            errors.rejectValue(
                                "relations[${i}]."+error.field,
                                error.getCode(),
                                error.getArguments(),
                                error.getDefaultMessage()
                            )
                        }
                    }
                }   
            }       
        }
    }
}
@grails.validation.Validateable
class customerEducationsCommand{
    List <Education> educations = [].withLazyDefault {new Education()}
    static constraints={
        educations validator:{ val,obj,errors -> 
            if(val){
                for(int i = 0; i < val.size(); i++){
                    if(!val[i]){continue}
                    if(!val[i].validate()){
                        val[i].errors.allErrors.each {error->
                            errors.rejectValue(
                                "educations[${i}]."+error.field,
                                error.getCode(),
                                error.getArguments(),
                                error.getDefaultMessage()
                            )
                        }
                    }
                }   
            }       
        }
    }
}
@grails.validation.Validateable
class customerPresentedIdsandOtherAcctsCommand{
    CustomerType type//lov
    List <PresentedId> presentedids = [].withLazyDefault {new PresentedId()}
    List <OtherAcct> otheraccts = [].withLazyDefault {new OtherAcct()}
    static constraints={
        presentedids validator:{ val,obj,errors -> 
            if(val){
                for(int i = 0; i < val.size(); i++){
                    if(!val[i]){continue}
                    if(!val[i].validate()){
                        val[i].errors.allErrors.each {error->
                            errors.rejectValue(
                                "presentedids[${i}]."+error.field,
                                error.getCode(),
                                error.getArguments(),
                                error.getDefaultMessage()
                            )
                        }
                    }
                }   
            }       
        }
        otheraccts validator:{ val,obj,errors -> 
            if(val){
                for(int i = 0; i < val.size(); i++){
                    if(!val[i]){continue}
                    if(!val[i].validate()){
                        val[i].errors.allErrors.each {error->
                            errors.rejectValue(
                                "otheraccts[${i}]."+error.field,
                                error.getCode(),
                                error.getArguments(),
                                error.getDefaultMessage()
                            )
                        }
                    }
                }   
            }       
        }
    }
}