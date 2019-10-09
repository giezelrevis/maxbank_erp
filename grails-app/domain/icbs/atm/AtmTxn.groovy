package icbs.atm
import icbs.lov.ConfigItemStatus
import icbs.tellering.TxnFile

class AtmTxn {
    
    Date txnDate
    Date responseDate
    Date reversalDate
    AtmMsgResponse responseMsg
    AtmMsgRequest requestMsg
    String txnCode
    String mti
    String atmCardNumber
    String atmTerminal
    String acct1
    String acct2
    String txnRef
    Double txnAmt
    Double txnChargeAmt
    Double bal1
    Double bal2
    ConfigItemStatus status
    Boolean isReversed
    int txnFile1
    int txnFile2
    
    static constraints = {
        txnDate nullable:true
        responseDate nullable:true
        reversalDate nullable:true
        responseMsg nullable:true
        requestMsg nullable:true
        txnCode nullable:true
        mti nullable:true
        atmCardNumber nullable:true
        atmTerminal nullable:true
        acct1 nullable:true
        acct2 nullable:true
        txnRef nullable:true
        txnAmt nullable:true
        txnChargeAmt nullable:true
        bal1 nullable:true
        bal2 nullable:true
        status nullable:true
        isReversed nullable:true
        txnFile1 nullable:true
        txnFile2 nullable:true
    }
    
    static mapping = {
        id sqlType: 'int', generator: 'increment'
    }
}
