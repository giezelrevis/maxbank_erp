package icbs.cif

import icbs.lov.ConfigItemStatus
import icbs.lov.OtherAcctType

class OtherAcct {

    //customer id
    static belongsTo = [customer:Customer]
    OtherAcctType type//lov
    boolean isOtherAcctJoint
    String bankName
    String branchName
    //currency id
    String acctNo
    String description
    ConfigItemStatus status 
    String hash
    
    static constraints = {
        type nullable:false
        status nullable:true
        //end lov
        bankName nullable:false,maxSize:50
        branchName nullable:true,maxSize:50
        acctNo nullable:false,maxSize:30
        description nullable:true,maxSize:50
        hash nullable:true,maxSize:255
        
        deleted bindable: true
    }
    def beforeInsert(){
        this.status = ConfigItemStatus.get(2)
    }
    static mapping = {
        id sqlType: "int", generator: "increment"
        bankName sqlType: "varchar"
        branchName sqlType: "varchar"
        acctNo sqlType: "varchar"
        description sqlType: "varchar"
        hash sqlType: "varchar"
    }
    boolean deleted
    static transients = ['deleted']
}
