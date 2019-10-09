package icbs.gl
import icbs.tellering.TxnFile

class AccountsPayableLedger {
    
    AccountsPayable accountsPayable
    Date refDate
    Date valueDate
    Double debit
    Double credit
    Double balance
    String reference
    String particulars
    TxnFile txnFile
    
    static constraints = {
        accountsPayable nullable:true
        refDate nullable:true
        valueDate nullable:true
        debit min:0D, scale:2
        credit min:0D, scale:2
        balance min:0D, scale:2
        reference nullable:true
        particulars nullable:true
        txnFile nullable:true        
    }
    
    static mapping = {
      id sqlType: "int", generator: "increment"
    }     
}
