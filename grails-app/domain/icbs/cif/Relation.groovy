package icbs.cif

import icbs.lov.ConfigItemStatus
import icbs.lov.Lov
import icbs.lov.CustomerType
import icbs.lov.CustomerStatus
import icbs.lov.Gender
class Relation {
    //customerId
    static belongsTo = [customer:Customer]
    Customer customer2
    Lov type
    String remarks
    ConfigItemStatus status 
    String hash
    static constraints = {
        customer nullable:false
        type nullable:true
        status nullable:true
        //end lov
        remarks nullable:true
        customer2 (validator: { val, obj, errors ->
            /*You cannot have a relationship with your own!*/
            println("pumasok dito sa customer validator!")
            if(val?.id!=null&&obj.customer?.id!=null){
                println("pumasok dito sa customer validator!")
                println "owner =" + obj.customer.id
                println "customer2 = "+val.id
                if(obj.customer.id==val.id){
                    errors.rejectValue('customer2.name1', 'You cannot hava a relationship with your own!')
                    errors.rejectValue('customer2.name2', 'You cannot hava a relationship with your own!')
                    errors.rejectValue('customer2.name3', 'You cannot hava a relationship with your own!')
                    errors.rejectValue('customer2.name4', 'You cannot hava a relationship with your own!')
                    errors.rejectValue('customer2', 'You cannot hava a relationship with your own!')
                }
                /*If you have existing relationship with that person*/
                /*def customerInstance = Customer.read(obj.customer.id)*/
                if(obj.id==null){
                    def rel = Relation.find{customer.id==obj.customer.id && customer2.id==val.id&&status.id!=3}
                    if(rel){
                        errors.rejectValue('customer2.name1', 'You cannot have multiple relationships with same person!')
                        errors.rejectValue('customer2.name2', 'You cannot have multiple relationships with same person!')
                        errors.rejectValue('customer2.name3', 'You cannot have multiple relationships with same person!')
                        errors.rejectValue('customer2.name4', 'You cannot have multiple relationships with same person!')
                        errors.rejectValue('customer2', 'You cannot have multiple relationships with same person!')
                    }
                }   
            }
        },nullable:false)
        hash nullable:true,maxSize:255
        deleted bindable: true
    }
    /*Will be deleted*/
    def beforeValidate(){
    }
    def beforeInsert(){
        this.status = ConfigItemStatus.read(2)
    }
    static mapping = {
        id sqlType: "int", generator: "increment"
        remarks sqlType: "varchar"
        hash sqlType: "varchar"
    }
    boolean deleted
    static transients = ['deleted']
}
