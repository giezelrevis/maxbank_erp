package icbs.tellering

import icbs.admin.CheckDepositClearingType
import icbs.lov.ConfigItemStatus
import icbs.admin.ClearingBank
import icbs.admin.Branch
import icbs.loans.Loan
import icbs.admin.Currency
import icbs.lov.CheckStatus
import icbs.lov.TxnCheckStatus
import icbs.deposit.Deposit
import icbs.deposit.Cheque
import icbs.admin.UserMaster

class TxnCOCI {

    Cheque cheque
    String txnRef
    String totalChecks
    Double txnAmt //checkControlTotal
    String payee
    Loan acct
    Deposit depAcct
    String acctNo
    Branch branch
    CheckDepositClearingType checkType
    ClearingBank bank
    String checkNo
    String checkAcctName
    Double checkAmt
    Date checkDate
    Date clearingDate
    ConfigItemStatus status
    String hash
    Currency currency
    TxnFile txnFile
    CheckStatus checkStatus
    TxnCheckStatus txnCheckStatus
    String cleared
    UserMaster user
 
    static constraints = {
        txnRef nullable:true
        totalChecks nullable:true
        txnAmt nullable:true, min:0d, scale:2
        payee nullable:true
        acct nullable:true
        depAcct nullable:true
        acctNo nullable:true
        branch nullable:true
        checkType nullable:true
        bank nullable:true
        checkNo nullable:true
        checkAcctName nullable:true
        checkAmt nullable:true, min:0d, scale:2
        //checkDate(max: new Date(), min: new Date()-180, nullable:true)
        clearingDate nullable:true
        status nullable:true
        hash nullable:true
        currency nullable:true
        txnFile nullable:true
        checkStatus nullable:true
        cleared nullable:true
        txnCheckStatus nullable:true
        user nullable:true
        cheque nullable:true
    }
    
    static mapping = {
        id sqlType: 'int', generator: 'increment'
        txnRef sqlType: 'varchar'
        checkNo sqlType: 'varchar'
        checkAcctName sqlType: 'varchar'
    }
}