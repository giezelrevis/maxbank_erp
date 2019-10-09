package icbs.gl
import icbs.admin.Branch
import icbs.lov.DepositType
import icbs.lov.DepositStatus
import icbs.admin.UserMaster
import icbs.admin.Currency

class CashInBank {

    Currency currency
    Branch branch
    String bankName
    String bankAddress
    String acctNo
    DepositType type
    Double balance
    Double intRate
    String bankBranch
    Date openDate
    Date maturityDate
    UserMaster user
    Date createDate
    DepositStatus status
    String remarks
    String glContra
    
    static constraints = {
        currency nullable:true
        branch nullable:true
        bankName nullable:true, maxSize:30
        bankAddress nullable:true, maxSize:70
        acctNo nullable:true, maxSize:25
        type nullable:true
        balance nullable:true, min:0D, scale:2
        intRate nullable:true, min:0D, scale:5
        bankBranch nullable:true
        openDate nullable:true
        maturityDate nullable:true
        user nullable:true
        createDate nullable:true
        status nullable:true  
        remarks nullable:true
        glContra nullable:true
    }
    
    static mapping = {
      id sqlType: "int", generator: "increment"
    }
}
