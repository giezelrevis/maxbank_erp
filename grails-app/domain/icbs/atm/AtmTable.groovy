package icbs.atm

class AtmTable {

    String mti
    String atmType
    String atmTxnCode
    String txnCode
    String atmShortDescription
    String atmDescription
    String atmGlCode
    String atmGlCode2
    Boolean isAtmCash
    Boolean isReversal
    Integer atmTxnType
    Integer mbTxnType
    Boolean isFtt
    String revLookUp
    String bitEnabled
    String atmCashAcct
    
    static constraints = {
        mti nullable:true
        atmType nullable:true
        atmTxnCode nullable:true
        txnCode nullable:true
        atmShortDescription nullable:true
        atmDescription nullable:true
        atmGlCode nullable:true
        atmGlCode2 nullable:true
        isAtmCash nullable:true
        isReversal nullable:true
        atmTxnType nullable:true
        mbTxnType nullable:true
        isFtt nullable:true
        revLookUp nullable:true
        bitEnabled nullable:true
        atmCashAcct nullable:true
    }
    
    static mapping = {
        id sqlType: 'int', generator: 'increment'
        atmDescription sqlType: 'varchar'
    }
}
