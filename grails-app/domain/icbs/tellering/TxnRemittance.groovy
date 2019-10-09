package icbs.tellering

import icbs.lov.ConfigItemStatus
import icbs.admin.Branch
import icbs.cif.Customer
import icbs.loans.Loan
import icbs.admin.UserMaster
import icbs.admin.Currency
import icbs.tellering.TxnFile

class TxnRemittance {
    
    static belongsTo=[acct:Loan, user:UserMaster];
    Customer sender
    Customer beneficiary
    String acctNo
    Double txnAmt
    String txnRef
    Branch branch
    String agent
    String claimMethod
    ConfigItemStatus status
    String txnParticulars
    String controlNo
    Date txnDate
    Currency currency
    TxnFile txnFile
    static hasMany=[checks:TxnCOCI]
    
    static constraints = {
        sender nullable:false
        beneficiary nullable:false
        acct nullable:true
        acctNo nullable:true
        user nullable:true
        txnAmt nullable:false, min:0d, scale:2
        txnRef nullable:false
        branch nullable:true
        agent nullable:true
        claimMethod nullable:true
        status nullable:true
        txnParticulars nullable:false
        controlNo nullable:false
        txnDate nullable:true
        currency nullable:true
        txnFile nullable:true
        checks nullable:true
    }
    
    static mapping = {
        id sqlType: 'int', generator: 'increment'
        txnRef sqlType: 'varchar'
        claimMethod sqlType: 'varchar'
        txnParticulars sqlType: 'varchar'
        controlNo sqlType: 'varchar'
    }
}
