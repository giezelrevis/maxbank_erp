package icbs.gl
import icbs.tellering.TxnFile

class BillsPayableLedger {
    BillsPayable billsPayable
    Date refDate
    Date valueDate
    Double debit
    Double credit
    Double balance
    String reference
    String particulars
    TxnFile txnFile
    
    static constraints = {
        billsPayable nullable:true
        refDate nullable:true
        valueDate nullable:true
        debit min:0D, scale:2, nullable:true
        credit min:0D, scale:2, nullable:true
        balance min:0D, scale:2, nullable:true
        reference nullable:true
        particulars nullable:true
        txnFile nullable:true          
    }
    
    static mapping = {
      id sqlType: "int", generator: "increment"
    }    
}
