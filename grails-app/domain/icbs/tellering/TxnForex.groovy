package icbs.tellering

import icbs.lov.TxnType
import icbs.admin.Currency
import icbs.cif.Customer
import icbs.admin.ForexRate
import icbs.admin.UserMaster
import icbs.lov.ConfigItemStatus

class TxnForex {

    Currency currency
    String currencyPayout
    Double exchangeRate
    ForexRate exchangeRateRef
    Double receivedAmt
    Double paidOutAmt
    String txnParticulars
    static belongsTo=[customer:Customer, user:UserMaster];
    Double chargesAmt
    Double netAmtPaidOut
    ConfigItemStatus status
    Date txnDate
    TxnFile txnFile
    
    static constraints = {
        currency nullable:true
        currencyPayout nullable:true
        exchangeRate nullable:true
        exchangeRateRef nullable:true
        receivedAmt nullable:true
        paidOutAmt nullable:true
        customer nullable:true
        user nullable:true
        txnParticulars nullable:true
        chargesAmt nullable:true
        netAmtPaidOut nullable:true
        status nullable:true
        txnDate nullable:true
        txnFile nullable:true
    }
    
    static mapping = {
        id sqlType: 'int', generator: 'increment'
        txnParticulars sqlType: 'varchar'
    }
}
