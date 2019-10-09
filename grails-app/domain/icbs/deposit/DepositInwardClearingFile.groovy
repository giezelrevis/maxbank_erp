package icbs.deposit

import icbs.deposit.Deposit
import icbs.deposit.DepositInwardClearingHeader
import icbs.tellering.TxnFile

class DepositInwardClearingFile {
    static belongsTo = [header:DepositInwardClearingHeader]
    String inwardAcctNo
    Double inwardAmount
    String inwardCheckNo
    String inwardBRSTN
    String inwardTranCd
    String inwardReason
    Deposit deposit
    TxnFile txnFile
    
    static constraints = {
        header nullable:false
        inwardAcctNo nullable:true
        inwardAmount nullable:true, scale: 2
        inwardCheckNo nullable:true
        inwardBRSTN nullable:true
        inwardTranCd nullable:true
        inwardReason nullable:true
        deposit nullable:true
        txnFile nullable:true
    }

    static mapping = {
        id sqlType:'int', generator:'increment'
    }
    
    def beforeInsert() {

    }
    
    def beforeUpdate() {
        
    }
}
