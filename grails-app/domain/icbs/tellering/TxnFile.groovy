package icbs.tellering

import icbs.loans.Loan
import icbs.admin.UserMaster
import icbs.cif.Customer
import icbs.gl.GlAccount
import icbs.admin.Currency
import icbs.lov.ConfigItemStatus
import icbs.lov.LoanAcctStatus
import icbs.admin.Branch
import java.sql.Timestamp
import icbs.deposit.Deposit
import icbs.lov.TxnType
import icbs.admin.TxnTemplate

class TxnFile {

    String txnCode
    String txnDescription
    String chd
    //Integer txnId
    Date txnDate
    static belongsTo=[user:UserMaster, glAcct:GlAccount];
    Deposit depAcct
    Loan loanAcct
    Customer sender
    Customer beneficiary
    String acctNo
    Currency currency
    Double txnAmt
    String txnRef
    ConfigItemStatus status
    LoanAcctStatus acctStatus
    Branch branch
    Timestamp txnTimestamp
    
    String txnParticulars
    // txnType = txn_template_id
    TxnType txnType
    TxnTemplate txnTemplate
    
    static constraints = {
        txnCode nullable:true
        txnDescription nullable:true
        chd nullable:true
        txnTemplate nullable:true
        txnDate nullable:true
        depAcct nullable:true
        loanAcct nullable:true
        acctNo nullable:true
        user nullable:true
        sender nullable:true
        beneficiary nullable:true
        glAcct nullable:true
        currency nullable:true
        txnAmt nullable:true, min: 0d, scale:2
        txnRef nullable:true
        status nullable:true
        acctStatus nullable:true
        branch nullable:true
        txnTimestamp nullable:true
        txnType nullable:true
        txnParticulars nullable:true
    
    }
    
    static mapping = {
        id sqlType: 'int', generator: 'increment'
        txnRef sqlType: 'varchar'
        txnParticulars sqlType: 'varchar'
    }
    
    def beforeInsert(){
         //blank txnTemplate
        if(!this.txnTemplate){
            this.txnTemplate = TxnTemplate.findByCode(this.txnCode)
        }
        return true
    }    
}
