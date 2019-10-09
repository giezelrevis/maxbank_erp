package icbs.atm

class AtmTxnMapping {

    String mti
    String txnCode
    
    static constraints = {
        mti nullable:true
        txnCode nullable:true
    }
    
    static mapping = {
        id sqlType: 'int', generator: 'increment'
    }
}
