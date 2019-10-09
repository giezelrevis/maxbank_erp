package icbs.cif

import icbs.lov.ConfigItemStatus
import icbs.lov.Lov

class Education {   

    //customer_id
    static belongsTo = [customer:Customer]
    //educationtype
    Lov type
    String schoolAttended
    String yearStart
    String yearEnd
    String educationDegree
    String remarks
    ConfigItemStatus status 
    String hash
    static constraints = {
        status nullable:true
        type nullable:true
        schoolAttended nullable:false,maxSize:50
        yearStart nullable:true,maxSize:4
        yearEnd nullable:true,maxSize:4
        educationDegree display:true,nullable:true,maxSize:50
        remarks display:false,nullable:true,maxSize:255
        hash display:false,nullable:true,blankable:true,maxSize:255
        
        deleted bindable: true
    }
    def beforeInsert(){
        this.status = ConfigItemStatus.get(2)
    }
    static mapping = {
        id sqlType: "int", generator: "increment"
        schoolAttended sqlType: "varchar",length: 50
        yearStart sqlType: "varchar",length: 4
        yearEnd sqlType: "varchar",length: 4
        educationDegree sqlType: "varchar",length: 50
        remarks sqlType: "varchar",length: 255
        hash sqlType: "varchar", length: 15
    }
    boolean deleted
    static transients = ['deleted']
}