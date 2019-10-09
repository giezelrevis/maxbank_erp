package icbs.tellering

import icbs.lov.DepositStatus
import icbs.admin.Branch
import icbs.cif.Customer
import icbs.deposit.Deposit
import icbs.admin.UserMaster
import icbs.admin.Currency
import icbs.admin.Institution
import icbs.tellering.TxnCOCI
import icbs.lov.TxnType

class TxnDepositAcctLedger {

    Branch branch
    static belongsTo=[user:UserMaster]
    Deposit acct
    String acctNo
    Date txnDate
    Double debitAmt
    Double creditAmt
    Double bal
    String txnRef
    Integer passbookLine
    Double passbookBal
    DepositStatus status
    Currency currency
    TxnFile txnFile
    TxnType txnType
    String txnCode
    String reversalParticulars
    
    static hasMany=[checks:TxnCOCI]
    
    static constraints = {
        branch nullable:true
        acct nullable:true
        acctNo nullable:true
        user nullable:true
        txnDate nullable:true
        debitAmt nullable:true, min:0d, scale:2
        creditAmt nullable:true, min:0d, scale:2
        bal nullable:true, min:0d, scale:2
        txnRef nullable:false
        passbookLine nullable:true
        passbookBal nullable:true, min:0d, scale:2
        status nullable:true
        currency nullable:true
        txnFile nullable:true
        txnType nullable:true
        checks nullable:true
        txnCode nullable:true
        reversalParticulars nullable:true
    }
    
    static mapping = {
        id sqlType: 'int', generator: 'increment'
        txnRef sqlType: 'varchar'
    }
    
    def beforeInsert(){
        // force passbook line
        if (!this.passbookLine){
            def lastPb = TxnDepositAcctLedger.findAllByAcct(this.acct,[sort: 'id', order: 'desc', max: 1])
            if (lastPb) {
                for (lp in lastPb) {
                    this.passbookLine = lp.passbookLine + 1
                }
            } else {
                this.passbookLine = 1
            }
        }
        if (!this.passbookBal) {
            this.passbookBal = 0
        }
    }
    
}
