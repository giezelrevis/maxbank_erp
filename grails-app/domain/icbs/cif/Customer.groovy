package icbs.cif

import icbs.lov.CustomerDosriCode
import icbs.lov.CustomerStatus
import icbs.lov.CustomerType
import icbs.lov.FirmSize
import icbs.lov.Gender
import icbs.lov.Lov
import icbs.lov.ResidentType
import icbs.lov.RiskType
import icbs.admin.CustomerGroup
import icbs.admin.UserMaster
import icbs.deposit.Signatory
import icbs.admin.Branch
import icbs.deposit.Deposit
import icbs.gl.CfgAcctGlTemplate
import icbs.loans.Loan
class Customer{
    static belongsTo = [Relation,Signatory]
    
    List contacts = [].withLazyDefault {new Contact()}
    List addresses = [].withLazyDefault {new Address()}
    List employments = [].withLazyDefault {new Employment()}
    List businesses = [].withLazyDefault {new Business()}
    List educations = [].withLazyDefault {new Education()}
    List otheraccts = [].withLazyDefault {new OtherAcct()}
    List attachments = [].withLazyDefault {new Attachment()}
    List presentedids = [].withLazyDefault {new PresentedId()}
    List relations =  [].withLazyDefault {new Relation()}
    List extendedinfos =  [].withLazyDefault {new ExtendedInfo()}
    List infobases = [].withLazyDefault {new Infobase()}
    static hasMany =[contacts:Contact,
                    addresses:Address,    
                    employments:Employment,
                    businesses:Business,
                    educations:Education,
                    extendedinfos:ExtendedInfo,
                    otheraccts:OtherAcct,
                    attachments:Attachment,
                    presentedids:PresentedId,
                    relations:Relation,
                    extendedinfos:ExtendedInfo,
                    deposits:Deposit,
                    loans:Loan,
                    infobases:Infobase
                    
    ]
    static mappedBy=[relations:"customer"]
    CustomerType type//lov
    Branch branch
    String customerId// changed 2/5/15
    String name1
    String name2
    String name3
    String name4
    String displayName
    String shortAddress
    String pepDescription
    String amla
    Date birthDate
    Lov title
    Gender gender//lov
    Lov civilStatus
    String birthPlace
    boolean isTaxable
    double creditLimit
    ResidentType customerCode1
    RiskType customerCode2
    
    FirmSize customerCode3
    Lov nationality
    String sourceOfIncome
    CustomerDosriCode dosriCode//lov
    //EXTRA FROM SB.200010B
    //citizenship
    String sssNo
    String gisNo
    String tinNo
    String passportNo
    String remarks
    CustomerGroup group
    CustomerStatus status//lov
    String hash
    UserMaster createdBy
    UserMaster lastUpdatedBy
    Date lastUpdatedAt
    Date createdAt
    static constraints = {
                   
                    contacts nullable:true
                    addresses nullable:true
                    employments nullable:true
                    businesses nullable:true
                    educations nullable:true
                    extendedinfos nullable:true
                    otheraccts nullable:true
                    attachments nullable:true
                    presentedids nullable:true
                    relations nullable:true
                    extendedinfos nullable:true
                    infobases nullable:true
                    name2 nullable:true
        /*contacts(validator: { val, obj,errors ->
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
            println obj.errors
            println "lumabas sa contacts! errors"
        })
        
        /*
        addresses validator:{ val,obj,errors -> 
            println("address validator!")
            if(val){
                for(int i = 0; i < val.size(); i++){
                    if(!val[i]){continue}
                    if(!val[i].validate()){
                        val[i].errors.allErrors.each{
                            errors.putAt("addresses[${i}]."+it.field,it.code)
                        }
                    }
                }   
            }
            println errors
        }/*
        employments validator:{ val,obj,errors -> 
            println("employments validator!")
            if(val){
                for(int i = 0; i < val.size(); i++){
                    if(!val[i]){continue}
                    if(!val[i].validate()){
                        val[i].errors.allErrors.each{
                            errors.putAt("employments[${i}]."+it.field,it.code)
                        }
                    }
                }   
            }
            println errors
        }
        businesses validator: { val,obj,errors -> 
            println("business validator!")
            if(val){
                for(int i = 0; i < val.size(); i++){
                    if(!val[i]){continue}
                    if(!val[i].validate()){
                        val[i].errors.allErrors.each{
                            errors.putAt("businesses[${i}]."+it.field,it.code)
                        }
                    }
                }   
            }
            println errors
        }
        educations validator: { val,obj,errors -> 
            println("educations validator!")
            if(val){
                for(int i = 0; i < val.size(); i++){
                    if(!val[i]){continue}
                    if(!val[i].validate()){
                        val[i].errors.allErrors.each{
                            errors.putAt("educations[${i}]."+it.field,it.code)
                        }
                    }
                }   
            }
            println errors
        }
        otheraccts validator: { val,obj,errors ->
            println("otheraccts Validator!")
            if(val){
                for(int i = 0; i < val.size(); i++){
                    if(!val[i]){continue}
                    if(!val[i].validate()){
                        val[i].errors.allErrors.each{
                            errors.putAt("otheraccts[${i}]."+it.field,it.code)
                        }
                    }
                }   
            }
            println errors
        }
        attachments nullable:true
        presentedids validator: { val,obj,errors -> 
            println("presentedids validator!")
            if(val){
                for(int i = 0; i < val.size(); i++){
                    if(!val[i]){continue}
                    if(!val[i].validate()){
                        val[i].errors.allErrors.each{
                            errors.putAt("presentedids[${i}]."+it.field,it.code)
                        }
                    }
                }   
            }
            println errors
        }
        relations validator: { val,obj,errors -> 
            println("relations validator!")
            if(val){
                for(int i = 0; i < val.size(); i++){
                    if(!val[i]){continue}
                    if(!val[i].validate()){
                        val[i].errors.allErrors.each{
                            errors.putAt("relations[${i}]."+it.field,it.code)
                        }
                    }
                }   
            }
            println errors
        }*/
        //end ids
        type nullable:false
        branch nullable:true
        gender nullable:false
        dosriCode nullable:false
        status nullable:true
        title nullable:false
        civilStatus nullable:false
        customerCode1 nullable:true
        customerCode2 nullable:true
        customerCode3 nullable:true
        amla nullable:true
        pepDescription nullable:true
        nationality nullable:true
        //end lov
        customerId nullable:true
        name1 size:2..50,nullable:false
            
       
        name3 size:2..50,validator:{val,obj,errors->
            if(obj?.type?.id==1){
                if(val==null){
                    errors.rejectValue('name3', "name field cannot be blank")
                }
            }else{
                return true;
            }
        },nullable:true
        name2 nullable:true
        name4 nullable:true, size:2..50
        displayName nullable:true,blank:false,maxSize:255
        shortAddress nullable:true, size:2..50
        birthDate nullable:false,blank:false,validator:{val,obj,errors->
            if(obj?.type?.id==1){
                if(obj.hasProperty('status')){
                    if(obj.status?.id==5){
                        return true
                    }else{
                        if(val>=Branch.get(1).runDate){
                            println("pumasok sa birthdate rejection,rejected!")
                            errors.rejectValue('birthDate', "BirthDate cannot be greater than system date")
                        }  
                    }
                }
                println("pumasok sa birthPlace rejection")    
            }else{
                return true;
            }
        }
        birthPlace maxSize:50 ,validator:{val,obj,errors->
            if(obj?.type?.id==1){
                if(obj.hasProperty('status')){
                    if(obj.status?.id==5){
                        return true
                    }else{
                        if(val==null){
                            println("pumasok sa birthPlace rejection,rejected!")
                            errors.rejectValue('birthPlace', "BirthPlace cannot be null")
                        }  
                    }
                }
                println("pumasok sa birthPlace rejection")    
            }else{
                return true;
            }
        },nullable:false    
        isTaxable nullable:true
        sourceOfIncome nullable:false
        creditLimit nullable:true,min:0D, scale: 2
        sssNo nullable:true,maxSize:50
        gisNo nullable:true,maxSize:50
        tinNo nullable:true,maxSize:50
        passportNo nullable:true,maxSize:50
        remarks nullable:true,maxSize:255
        group nullable:true
        hash nullable:true,maxSize:255
        createdBy nullable:true
        lastUpdatedBy nullable:true
        createdAt nullable:true
        lastUpdatedAt nullable:true

    }

    static mapping = {
        contacts cascade:"all-delete-orphan"
        addresses cascade:"all-delete-orphan"
        businesses cascade: "all-delete-orphan"
        educations cascade: "all-delete-orphan"
        otheraccts cascade: "all-delete-orphan"
        employments cascade: "all-delete-orphan"
        presentedids cascade: "all-delete-orphan"
        attachments cascade: "all-delete-orphan"
        relations cascade: "all-delete-orphan"
        infobases cascade: "all-delete-orphan"
        displayName cascade: "all-delete-orphan"
        id sqlType:'int', generator:'increment'
    }
    def beforeValidate(){
        println("before Validate Customer")
        displayNameHelper()
    }
    def beforeDelete(){
        return false
    }
    def beforeUpdate(){
        /*If updating from incomplete and passed validation
         * Update from incomplete status to Pending
         */        
        displayNameHelper()
        if(this.status?.id==5&&this.birthPlace!=null){
             this.status = CustomerStatus.get(1)
        }
        this.lastUpdatedAt = new Date()
        return true
    }
    def beforeInsert(){
         //linked from relation
        if(this.type?.id==1&&this.status?.id==5){
            println("related")
        }else{
            /*Status Pending(Not Linked from Relation*/
            this.status = CustomerStatus.get(1)
        }
        this.createdAt = new Date()
        displayNameHelper()
        return true
    }
    private displayNameHelper(){
        /*Append Display Name*/
        /*Note, only happens when someone maliciously changes DOM in view*/
        //if(this.displayName==""||this.displayName==null){
            //Multiple IF statements to prevent "null" from being printed
            if(this.name1!=null&&this.name1!=""){
                this.displayName = this.name1 +" ";
            }
            if(this.type?.id==1){
                /*
                if(this.name2&&this.name2!=""){
                     this.displayName += this.name2 +" ";
                }
                if(this.name3&&this.name3!=""){
                     this.displayName += this.name3 +" ";
                }
                if(this.name4&&this.name4!=""){
                    //if private
                    if(this.type?.id==1){
                        this.displayName += '('+this.name4+')';
                    }else {
                        this.displayName += this.name4;
                    }
                }
                */
                if(this.name3!=null&&this.name3!=""){
                    this.displayName = this.name3 + ", ";
                }
                if(this.name1!=null&&this.name1!=""){
                    this.displayName += this.name1 + " ";
                }                
                if(this.name2!=null&&this.name2!=""){
                    this.displayName += this.name2 + " ";
                }
                if(this.name4!=null&&this.name4!=""){
                    this.displayName += "(" + this.name4 + ")";
                }                
            }
        // }
    }
}