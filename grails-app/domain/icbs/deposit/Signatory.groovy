package icbs.deposit

import icbs.cif.Customer
import icbs.lov.ConfigItemStatus
import icbs.lov.SignatoryType
class Signatory {
    static belongsTo=[deposit:Deposit]
    Customer signatory
    SignatoryType type
    //boolean isSignatory
    ConfigItemStatus status
    
    static constraints = {
        signatory (validator: { val, obj, errors ->
            /*You cannot have a relationship with your own!*/
            println("pumasok dito sa customer validator!")
            if(val?.id!=null&&obj.deposit.customer?.id!=null){
                if(obj.deposit.customer.id==val.id){
                    errors.rejectValue('signatory.name1', 'You cannot be co owners with your own account!')
                    errors.rejectValue('signatory.name2', 'You cannot be co owners with your own account!')
                    errors.rejectValue('signatory.name3', 'You cannot be co owners with your own account!')
                    errors.rejectValue('signatory.name4', 'You cannot be co owners with your own account!')
                    errors.rejectValue('signatory', 'You cannot be co owners with your own account!')
                }
                /*If you have existing relationship with that person*/
                /*def customerInstance = Customer.read(obj.customer.id)*/
                if(obj.id==null){
                    def rel = Signatory.find{deposit.id==obj.deposit.id && signatory.id==val.id&&status.id!=3}
                    if(rel){
                        errors.rejectValue('signatory.name1', 'You cannot be co owners with your own account!')
                        errors.rejectValue('signatory.name2', 'You cannot be co owners with your own account!')
                        errors.rejectValue('signatory.name3', 'You cannot be co owners with your own account!')
                        errors.rejectValue('signatory.name4', 'You cannot be co owners with your own account!')
                        errors.rejectValue('signatory', 'You cannot have multiple relationships with same person!')
                    }
                }   
            }
        },nullable:false)
        type nullable:false    
        status nullable:true
        deleted bindable:true
    }
    def beforeInsert(){
        this.status = ConfigItemStatus.get(2);
    }
    static mapping={
        id sqlType: "int", generator: "increment"
    }
    boolean deleted
    static transients = ['deleted']
}
