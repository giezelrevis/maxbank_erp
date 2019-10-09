package icbs.tellering


import icbs.admin.Currency

class TxnForexDetail {
    TxnFile txnFile
    Currency currency
    BigDecimal forexRate
    
    static constraints = {        
        txnFile nullable:true
        currency nullable:true
        forexRate nullable:true    
    }
    
    static mapping = {
        id sqlType: 'int', generator: 'increment'
    }    
}
