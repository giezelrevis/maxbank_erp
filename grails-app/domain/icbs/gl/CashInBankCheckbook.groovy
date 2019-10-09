package icbs.gl
import icbs.lov.CheckStatus
import icbs.tellering.TxnFile
import icbs.admin.UserMaster

class CashInBankCheckbook {
    
    CashInBank cashInBank
    Integer checkNo
    String reference
    String checkVoucherNo
    Date checkDate
    String payee
    String particulars
    Date releaseDate
    Double checkAmt
    CheckStatus checkStatus
    TxnFile txnFile
    UserMaster issuedBy
    UserMaster approvedBy
    Date approveDate
    Date createDate
    UserMaster createdBy
        
    static constraints = {
        cashInBank nullable:true
        checkNo min:0, nullable:true
        reference nullable:true
        checkVoucherNo nullable:true
        checkDate nullable:true
        payee nullable:true
        particulars nullable:true
        releaseDate nullable:true
        checkAmt min:0D, scale:2, nullable:true
        checkStatus nullable:true
        txnFile nullable:true
        issuedBy nullable:true
        approvedBy nullable:true
        approveDate nullable:true
        createDate nullable:true
        createdBy nullable:true       
    }
    
    static mapping = {
      id sqlType: "int", generator: "increment"
    }    
}
