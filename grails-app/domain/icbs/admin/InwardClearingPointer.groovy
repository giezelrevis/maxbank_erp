package icbs.admin

import icbs.deposit.DepositInwardClearingFile
import icbs.admin.TxnTemplate

class InwardClearingPointer {
    String inwardBRSTN
    String description
    TxnTemplate txnTemplate
    
    static constraints = {
        inwardBRSTN nullable:false, unique:true
        description nullable:true
        txnTemplate nullable:true
    }
    
    static mapping = {
        id sqlType:'int', generator:'increment'
    }    
}
