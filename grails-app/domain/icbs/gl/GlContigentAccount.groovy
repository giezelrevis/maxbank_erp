package icbs.gl

import icbs.admin.Branch
import icbs.lov.ContigentAccount
import icbs.admin.UserMaster
import icbs.lov.ConfigItemStatus


class GlContigentAccount {
    
    Date txnDate
    String particulars
    String reference
    Double debitAmt
    Double creditAmt
    ContigentAccount contigent
    UserMaster createdByUser
    Branch branch
    ConfigItemStatus status
    
    static constraints = {
         txnDate nullable: true
         particulars nullable: true
         reference nullable: false
         debitAmt nullable: true
         creditAmt nullable: true
         contigent nullable: true
         createdByUser nullable: true
         branch nullable: true
         status nullable: true
    }
    static mapping = {
    	 id sqlType: "int", generator: "increment"
         
    }

}
