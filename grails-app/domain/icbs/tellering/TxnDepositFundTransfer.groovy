package icbs.tellering
import icbs.admin.Branch
import icbs.deposit.Deposit
import icbs.admin.UserMaster
import icbs.admin.Currency
import icbs.admin.TxnTemplate

class TxnDepositFundTransfer {
    Branch branch
    Deposit drDeposit
    Deposit crDeposit
    TxnFile drTxn
    TxnFile crTxn
    Double fundTransferAmt
    String txnParticulars
    String txnRef
    Currency currency
    Date txnDate
    UserMaster user
    TxnTemplate txnTemplate
    
    static constraints = {
        branch nullable:true
        drDeposit nullable:true
        crDeposit nullable:true
        drTxn nullable:true
        crTxn nullable:true
        fundTransferAmt nullable:true, min:0d, scale:2
        txnParticulars nullable:true
        txnRef nullable:true
        currency nullable:true
        txnDate nullable:true
        user nullable:true
        txnTemplate nullable:true
    }
    
    static mapping = {
        id sqlType: 'int', generator: 'increment'
    }
}
