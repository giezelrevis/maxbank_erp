package icbs.tellering

import icbs.admin.UserMaster
import icbs.admin.Currency

class TxnTellerBalance {
    
    Date txnDate 
    UserMaster user
    Currency currency
    Double cashIn
    Double cashOut
    Double lastBalanceAmt
    boolean isBalance
    boolean isCashier
    
    static mapping = {
        id sqlType:'int', generator:'increment'
        cashIn defaultValue : 0
        cashOut defaultValue : 0
        lastBalanceAmt defaultValue : 0
        isBalance defaultValue : false
        isCashier defaultValue : false
    }

    static constraints = {
        txnDate nullable:false
        user nullable:false
        currency nullable:false
        cashIn nullable:true, min:0d, scale:2
        cashOut nullable:true, min:0d, scale:2
        lastBalanceAmt nullable:true, scale:2
        isBalance nullable:true
        isCashier nullable:true
        
    }
}
