package icbs.tellering

import icbs.cif.Customer
import icbs.admin.Currency
import icbs.admin.Branch
import icbs.lov.ConfigItemStatus
import icbs.tellering.TxnCOCI

class TxnBillsPayment {

    static belongsTo=[beneficiary:Customer];
    Branch branch
    static hasMany=[checks:TxnCOCI]
    Double txnAmt
    String txnRef
    String billsPaymentId
    String billsRef
    String txnParticulars
    ConfigItemStatus status
    String billsMerchantId
    Date txnDate
    Currency currency
    TxnFile txnFile
    
    static constraints = {
        txnAmt nullable:false, min:0d, scale:2
        beneficiary nullable:true
        txnRef nullable:false
        billsPaymentId nullable:true
        branch nullable:true
        billsRef nullable:true, maxSize:50
        txnParticulars nullable:false, maxSize:100
        status nullable:true
        billsMerchantId nullable:true
        txnDate nullable:true
        currency nullable:true
        txnFile nullable:true
        checks nullable:true
    }
    
    static mapping = {
        id sqlType: 'int', generator: 'increment'
        txnRef sqlType: 'varchar'
        billsRef sqlType: 'varchar'
        txnParticulars sqlType: 'varchar'
    }
}
