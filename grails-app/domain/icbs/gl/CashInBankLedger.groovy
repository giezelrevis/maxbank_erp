package icbs.gl
import icbs.tellering.TxnFile

class CashInBankLedger {
    CashInBank cashInBank
    Date txnDate
    Date valueDate
    String reference
    String particulars
    Double debitAmt
    Double creditAmt
    Double balanceAmt
    TxnFile txnFile
    CashInBankCheckbook checkbook
    
    static constraints = {
        cashInBank nullable:true
        txnDate nullable:true
        valueDate nullable:true
        reference nullable:true
        particulars nullable:true
        debitAmt min:0D, scale:2
        creditAmt min:0D, scale:2
        balanceAmt min:0D, scale:2
        txnFile nullable:true 
        checkbook nullable:true
    }
    
    static mapping = {
      id sqlType: "int", generator: "increment"
    }    
}
