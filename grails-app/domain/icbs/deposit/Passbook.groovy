package icbs.deposit

import icbs.admin.UserMaster
import icbs.lov.*

class Passbook {
    static belongsTo = [docInventory:DocInventory] 
    IssuePassbook issuePassbook
    Long passbookNo
    String remarks
    PassbookStatus status
    static constraints = {
        issuePassbook nullable:true
        passbookNo nullable:false,unique:true
        status nullable:true
        remarks maxSize:255,nullable:true
    }
    static mapping={
        id sqlType: "int", generator: "increment"
    }
    def beforeInsert(){
        this.status =PassbookStatus.get(1)
    }
    def beforeUpdate(){
    }
}
