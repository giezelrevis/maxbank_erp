package icbs.cif

import grails.transaction.Transactional
import grails.util.Holders
import grails.converters.JSON
import grails.converters.deep.JSON

import icbs.lov.ConfigItemStatus
import icbs.lov.CustomerStatus
import icbs.lov.CustomerType
import icbs.lov.Gender
import icbs.lov.Lov
import icbs.admin.UserMaster

@Transactional
class CustomerService {
    def auditLogService
    def policyService
    boolean transactional = false    
    def update(params,includeList=null) {
        println "includelist"+ includeList
        println params
        Customer.withTransaction { status ->
            def result = [:]
            def fail = { Map m ->
                status.setRollbackOnly()
                if(result.customerInstance && m.field)
                    result.customerInstance.errors.rejectValue(m.field, m.code)
                result.error = [ code: m.code, args: ["Customer", params.id] ]
                return result
            }
            result.customerInstance = Customer.get(params.id)
            if(!result.customerInstance){
                return fail(code:"default.not.found")
            }
            // Optimistic locking check.
            if(params.version) {
                if(result.customerInstance.version > params.version.toLong())
                    return fail(field:"version", code:"default.optimistic.locking.failure")
            }
            if(!includeList){
                result.customerInstance.properties = params
            }
            else{
                result.customerInstance.properties[includeList]=params
            }
             println("lumagpas dito!")
            /*Help process one to many functions relationships*/
            result.customerInstance = deleteHelper(result.customerInstance)
            if(!includeList){
                if(!result.customerInstance.validate()){    
                    return fail(code:"default.update.failure")
                }
            }else{
                if(!result.customerInstance.validate([includeList])){    
                    return fail(code:"default.update.failure")
                }
            }
            result.customerInstance.save()  
            // Log
            //def description = 'save customer ' +  result.customerInstance.customerId
            //auditLogService.insert('060', 'CIF00000', description, 'customer', null, null, null)
            
            // Success.
            return result
        } //end withTransaction
    }  // end update()
    def save(params) {
        Customer.withTransaction { status ->
            def result = [:]
            def fail = { Map m ->
                status.setRollbackOnly()
                if(result.customerInstance && m.field)
                    result.customerInstance.errors.rejectValue(m.field, m.code)
                result.error = [ code: m.code, args: ["Customer", params.id] ]
                return result
            }
            result.customerInstance = new Customer()
            result.customerInstance.properties = params
            /*Help process one to many functions*/
            result.customerInstance = deleteHelper(result.customerInstance)
            /*End removing*/ 
            for(a in result.customerInstance.relations){
                if(!a.customer2.id){
                    //individual cif
                    a.customer2?.type = CustomerType.read(1)
                    a.customer2?.status = CustomerStatus.read(5)
                    a.customer2?.createdBy = result.customerInstance.createdBy
                    a.customer2?.lastUpdatedBy = result.customerInstance.createdBy
                    //Father Gender
                    //if(a.type?.id==63)
                    if(a.type?.id==48){
                        a.customer2?.gender = Gender.read(2)
                    }
                    //Mother Gender
                    //if(a.type?.id==64)
                    if(a.type?.id==47){
                        a.customer2?.gender = Gender.read(3)
                    }
                    //Spouse Gender
                    //if(a.type?.id==65)
                    if(a.type?.id==410){
                        if(a.customer?.gender?.id==2){
                            a.customer2?.gender = Gender.read(3)
                        }else if(a.customer?.gender?.id==3){
                            a.customer2?.gender = Gender.read(2)
                        }
                    } 
                    a.customer2.branch = result.customerInstance.branch
                }
            }
            if(!result.customerInstance.validate()){
               
                //println relations[0].errors
                //println relations[1].errors
                return fail(code:"default.save.failure")
            }
            result.customerInstance.save(flush:true,failOnError:true)
            result.customerInstance = customerIdBuilder(result.customerInstance)
            result.customerInstance.save(failOnError:true)
            for(a in result.customerInstance.relations){
                if(a.customer2.customerId==null){
                    println("Type of clawback for not existing customer"+a.type?.id);
                    a.customer2 = customerIdBuilder(a.customer2)
                    a.customer2.save(validate:false,failOnError:true)
                    def relation = new Relation(customer:a.customer2,type:a.type,customer2:result.customerInstance)
                    relation.save(validate:false,failOnError:true)
                }else{
                    println("Type of clawback for existing customer"+a.type?.id);
                    def relation = new Relation(customer:a.customer2,type:a.type,customer2:result.customerInstance)
                    relation.save(validate:false,failOnError:true)
                }
            }
            // Log
            //def description = 'save customer ' +  result.customerInstance.customerId
            //auditLogService.insert('060', 'CIF00000', description, 'customer', null, null, null)  
            
            //def description = 'New Customer Record for ' + result.customerInstance.customerId + ' was created' + ' by ' + UserMaster.get(session.user_id).username
            //println 'Log Description:' + description
            //auditLogService.insert('060', 'CIF00010', description, 'customer', null, null, 'customer/customerInquiry/')

            return result
        }
    }
    private customerIdBuilder(customerInstance){
        String branchCode =String.format("%03d", customerInstance.branch.code)
        String serial = String.format("%07d", customerInstance.id);
        branchCode= branchCode.substring(0, Math.min(branchCode.length(), 3));
        customerInstance.customerId = branchCode+"-"+serial
        return customerInstance
    }
    /*Remove relations from params map and handle manually*/
    private relationsHelper(params){
        /*Parents  are Required*/
        List relations = new ArrayList()
        List customers = new ArrayList()
        customers[0] =  new Customer(firstName:params['relations[0].firstName'],lastName:params['relations[0].lastName'],middleName:params['relations[0].middleName'],birthDate:params['relations[0].birthDate'])
        customers[1] =  new Customer(firstName:params['relations[1].firstName'],lastName:params['relations[1].lastName'],middleName:params['relations[1].middleName'],birthDate:params['relations[1].birthDate'])

        customers[0].validate(['firstName','lastName','middleName','birthDate'])
        customers[1].validate(['firstName','lastName','middleName','birthDate'])
        
        relations[0] = new Relation(relationTypeId:"36",customer2:customers[0])
        relations[1] = new Relation(relationTypeId:"36",customer2:customers[1])
        
        println customers[0].errors
        println customers[1].errors
        relations[0].validate()
        relations[1].validate()
        println relations[0].errors
        println relations[1].errors
        return relations
    }
    
    
     /*Takes care of deleting one to many relations that are deleted*/
    public deleteHelper(customerInstance){
        
        /*Deleting nulls in one to many relationships*/
        if(customerInstance.contacts){customerInstance.contacts.removeAll([null])}
        if(customerInstance.addresses){customerInstance.addresses.removeAll([null])}
        if(customerInstance.educations){customerInstance.educations.removeAll([null])}
        if(customerInstance.relations){customerInstance.relations.removeAll([null])}
        if(customerInstance.attachments){customerInstance.attachments.removeAll([null])}
        if(customerInstance.presentedids){customerInstance.presentedids.removeAll([null])}
        if(customerInstance.otheraccts){customerInstance.otheraccts.removeAll([null])}
        if(customerInstance.relations){customerInstance.relations.removeAll([null])}
       
        /*Deleted One to many Relationships are proccessed here. Soft Delete*/
        if(customerInstance.relations){
            def _relationDelete = customerInstance.relations.findAll{(it.deleted )}
            println "Relations" + customerInstance.relations
            println "Relations to be Deleted "+ _relationDelete
            if(_relationDelete) {
                for (Relation relation : _relationDelete) {
                    relation?.status = ConfigItemStatus.get(3)
                }
            }
        }
        if(customerInstance.contacts){
            def _contactDelete = customerInstance.contacts.findAll{(it.deleted )}
            println "Contacts" + customerInstance.contacts
            println "contacts to be Deleted "+ _contactDelete
            if(_contactDelete) {
                for (Contact contact : _contactDelete) {
                    contact?.status = ConfigItemStatus.get(3)
                }
            }
        }
        if(customerInstance.addresses){
            def _addressDelete = customerInstance.addresses.findAll{(it.deleted)}
            println  "Address" +customerInstance.addresses
            println "Address to be deleted "+ _addressDelete
            if(_addressDelete) {
                for (Address address : _addressDelete) {
                    address?.status = ConfigItemStatus.get(3)
                }
            }
        }
        if(customerInstance.educations){
            def _educationDelete = customerInstance.educations.findAll{(it.deleted)}
            println  "Education" +customerInstance.educations
            println  "Education to be deleted "+ _educationDelete
            if(_educationDelete) {
                for (Education education : _educationDelete) {
                    education?.status = ConfigItemStatus.get(3)
                }
            }
        }
        if(customerInstance.attachments){
            def _attachmentDelete = customerInstance.attachments.findAll{(it.deleted)}
            println  "Attachment" +customerInstance.attachments
            println  "Attachment to be deleted "+ _attachmentDelete
            if(_attachmentDelete) {
                for (Attachment attachment : _attachmentDelete) {
                    attachment?.status = ConfigItemStatus.get(3)
                }
            }
        }
        if(customerInstance.otheraccts){
            def _otherAcctDelete = customerInstance.otheraccts.findAll{(it.deleted)}
            println "OtherAccts" + customerInstance.otheraccts
            println "Other Accts to be Deleted "+ _otherAcctDelete
            if(_otherAcctDelete) {
                for (OtherAcct ottherAcct : _otherAcctDelete) {
                    ottherAcct?.status = ConfigItemStatus.get(3)
                }
            }
        }
        if(customerInstance.presentedids){
            def _presentedIdDelete = customerInstance.presentedids.findAll{(it.deleted)}
            println "presentedIds" + customerInstance.presentedids
            println "presentedIds to be Deleted "+ _presentedIdDelete
            if(_presentedIdDelete) {
                for (PresentedId presentedId : _presentedIdDelete) {
                    presentedId?.status = ConfigItemStatus.get(3)
                }
            }
        }
        // Log      
        return customerInstance
    }
    /*Childlist is an array of an array*/
    def preparePostResponse(domainInstance,matches=null) {
        def grailsApplication = Holders.getGrailsApplication()
        def g = grailsApplication.mainContext.getBean( 'org.codehaus.groovy.grails.plugins.web.taglib.ApplicationTagLib' )
        
        def postResponse = new AjaxPostResponse()
        postResponse.domainObject = domainInstance
        if(domainInstance.hasErrors()){
            g.eachError(bean: domainInstance) {
                if(!matches){
                    postResponse.errors."${it.field}" = g.message(error: it)
                }else{
                    if(matches instanceof List <?>){
                        for(i in 0..matches.size()-1){
                            if((it.field).matches(matches.get(i))){
                                postResponse.errors."${it.field}" = g.message(error: it)
                            }
                        }
                    }else{
                        if((it.field).matches(matches)){
                                postResponse.errors."${it.field}" = g.message(error: it)
                            }
                    }  
                }
                println it
            }
        }
        println postResponse.errors
        if(postResponse.errors){ 
            postResponse.success = false
            postResponse.message = "There was an error"
        } else {
            postResponse.success = true
            postResponse.message = "Success"
        } 
        return postResponse 
    }
    def validate(domainInstance,childList=null,maxDepth=null){
        def a = new customErrorValidation(domainInstance,childList,maxDepth)
        a.validateInstance()
        return a.getPostResponse()
    }
}

/*response for grails validation*/
class AjaxPostResponse {
    boolean success
    String message
    String html
    def domainObject
    def errors = [:] 
}
class customErrorValidation{
    int maxDepth
    AjaxPostResponse postResponse
    def childList
    def grailsApplication
    def g
    def customErrorValidation(domainInstance,childList=null,maxDepth=null){
        this.grailsApplication = Holders.getGrailsApplication()
        this.g = grailsApplication.mainContext.getBean( 'org.codehaus.groovy.grails.plugins.web.taglib.ApplicationTagLib' )
        this.postResponse = new AjaxPostResponse()
        if(childList)this.childList = childList
        this.postResponse.domainObject = domainInstance
        if(maxDepth)this.maxDepth = maxDepth
    }
    def validateInstance(){
        if(this.childList==null){
            if(this.postResponse.domainObject.hasErrors()){
                g.eachError(bean: postResponse.domainObject) {
                    this.postResponse.errors."${it.field}" = g.message(error: it)
                }
            }
        }else if(childList){ 
            recursiveValidate(childList,0,0)
        }
        if(this.postResponse.errors){ 
            this.postResponse.success = false
            this.postResponse.message = "There was an error"
        } else {
            this.postResponse.success = true
            this.postResponse.message = "Success"
        }
        return
    }
    private recursiveValidate(subsetList,childNumber,curDepth){
        def tempSubsetList = subsetList
        if(!subsetList){
            return
        }
        if(this.maxDepth){
            if(curDepth>this.maxDepth){
                return 
            }
        }
         if(subsetList instanceof List <?>){
            println("List Is an Array List *******" + curDepth)
            for(i in 0 .. subsetList.size()-1) {
                def object = subsetList.get(i)
                println"child"+ i+" class="+ object.getClass()
                recursiveValidate(object,i,++curDepth)
                println("Total Error List"+this.postResponse.errors)
            }
        }else {
            tempSubsetList.validate()
            g.eachError(bean: subsetList) {
                println " terminal child" +subsetList.getClass()
                this.postResponse.errors."${it.field+childNumber}" = g.message(error: it)
                println"post response errors on terminal" +this.postResponse.errors
            }
        } 
        return 
    }   
    def getPostResponse(){
        return this.postResponse
    }
}
