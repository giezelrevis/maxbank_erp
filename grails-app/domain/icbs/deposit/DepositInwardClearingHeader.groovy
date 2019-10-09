package icbs.deposit

import icbs.admin.UserMaster
import icbs.lov.DepositInwardFileStatus

class DepositInwardClearingHeader {
    List clearingFiles =  [].withLazyDefault {new DepositInwardClearingFile()}
    String inwardBatch
    Date batchDate
    byte[] inwardFile 
    UserMaster uploadedBy
    UserMaster processedBy
    //DepositInwardFileStatus inwardFileStatus
    static hasMany =[clearingFiles:DepositInwardClearingFile]
    
    static constraints = {
        clearingFiles nullable:true
        inwardBatch nullable:true
        batchDate nullable:true
        inwardFile nullable:true
        uploadedBy nullable:true
        processedBy nullable:true
        //inwardFileStatus nullable:true    
    }
    
    static mapping = {
        id sqlType:'int', generator:'increment'
        columns { 
            inwardFile type:'blob'
        }
    }
}
