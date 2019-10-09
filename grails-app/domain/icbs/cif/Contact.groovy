package icbs.cif

import icbs.lov.ConfigItemStatus
import icbs.lov.ContactStatus
import icbs.lov.Lov

class Contact {

    //customer id
    static belongsTo = [customer:Customer]
    boolean isPrimaryPhone
    boolean isPrimaryEmail
    Lov type
    String contactValue
    ConfigItemStatus status

    String hash
    static constraints = {
        customer nullable:true
        status nullable:true
        type nullable:false
        //end lov
        contactValue nullable:false,maxSize:50
       // isPrimaryPhone 
       // isPrimaryEmail 
        hash nullable:true,maxSize:255
        //bindable
        deleted bindable: true
    }
    static mapping ={
        id sqlType: "int", generator: "increment"
        contactValue sqlType: "varchar"
        hash sqlType: "varchar"
    }
    boolean deleted
    static transients = ['deleted']
    
    def beforeInsert(){
        this.status = ConfigItemStatus.get(2)
    }
}
