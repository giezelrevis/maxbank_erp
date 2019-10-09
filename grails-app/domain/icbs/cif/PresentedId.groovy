package icbs.cif

import icbs.lov.ConfigItemStatus
import icbs.lov.Lov

class PresentedId {
    //customer id
    static belongsTo = [customer:Customer]
    Lov type
    String idNo
    Date issueDate
    Date validDate
    boolean isGovtIssue
    boolean isWithPhoto
    boolean isWithSignature
    String remarks
    ConfigItemStatus status 
    String hash
    static constraints = {
        status nullable:true
        type nullable:false
        //end lov
        idNo  nullable:false,maxSize:50
        issueDate nullable:true,max: new Date()
        validDate nullable:true
        remarks nullable:true,maxSize:255
        hash nullable:true,maxSize:255
        
        deleted bindable: true
    }
    def beforeInsert(){
        this.status = ConfigItemStatus.get(2)
    }
    static mapping = {
        id sqlType: "int", generator: "increment"
        idNo sqlType: "varchar"
        issueDate sqlType: "date"
        validDate sqlType: "date"
        remarks sqlType: "varchar"
        hash sqlType: "varchar"
        
    }
    boolean deleted
    static transients = ['deleted']
}
