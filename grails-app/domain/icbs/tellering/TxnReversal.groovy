package icbs.tellering
import icbs.tellering.TxnFile

class TxnReversal {
    static belongsTo = [txnFile:TxnFile]
    String txnParticulars
    String txnReference
   
    
    static constraints = {
        txnParticulars nullable:true
        txnReference nullable:true
    }
    static mapping = {
	id sqlType:'int', generator:'increment'
    }
}
