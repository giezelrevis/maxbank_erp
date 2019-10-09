package icbs.loans
import icbs.admin.Branch
import icbs.admin.UserMaster
import icbs.tellering.TxnFile

class LoanBranchTransfer {
    Loan loan
    Branch newBranch
    Branch oldBranch
    TxnFile loanDr
    TxnFile loanCr
    Date transferDate
    String particulars
    String reference
    UserMaster user
    Branch userBranch
    
    static constraints = {
        loan nullable:false
        newBranch nullable:false
        oldBranch nullable:false
        loanDr nullable:false
        loanCr nullable:false
        transferDate nullable:false
        particulars nullable:false
        reference nullable:false
        user nullable:false
        userBranch nullable:false
    }
    
    static mapping = {
        id sqlType:'int', generator:'increment'
    }
}
