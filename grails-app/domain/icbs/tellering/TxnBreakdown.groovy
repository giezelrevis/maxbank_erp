package icbs.tellering

import icbs.admin.Currency
import icbs.admin.UserMaster
import icbs.admin.Branch

class TxnBreakdown {

    String debitAcct
    Double debitAmt
    String creditAcct
    Double creditAmt
    Date txnDate
    static belongsTo=[user:UserMaster];
    Currency currency
    TxnFile txnFile
    String txnCode
    Branch branch
    
    static constraints = {
        debitAcct nullable:true
        debitAmt nullable:true, scale:2
        creditAcct nullable:true
        creditAmt nullable:true, scale:2
        txnDate nullable:true
        user nullable:true
        currency nullable:true
        txnFile nullable:true
        txnCode nullable:true
        branch nullable:false
    }
    
    static mapping = {
        id sqlType: 'int', generator: 'increment'
        debitAcct sqlType: 'varchar'
        creditAcct sqlType: 'varchar'
    }
}
