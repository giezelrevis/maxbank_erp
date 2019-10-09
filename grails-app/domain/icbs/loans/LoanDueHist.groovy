package icbs.loans

import icbs.loans.Loan
import icbs.lov.LoanAcctStatus
import icbs.admin.Branch

class LoanDueHist {

    Branch branch
    Loan loanAcct
    Date refDate
    LoanAcctStatus status
    Double grantedAmt
    Double principalBalanceAmt
    Double intrestBalanceAmt
    Double penaltyBalanceAmt
    Double scBalanceAmt
    
    static constraints = {
        loanAcct nullable:false
        refDate nullable:false
        status nullable:false
        grantedAmt nullable:true, scale:2
        principalBalanceAmt nullable:true, scale:2
        intrestBalanceAmt nullable:true, scale:2
        penaltyBalanceAmt nullable:true, scale:2
        scBalanceAmt nullable:true, scale:2
    }
    
    static mapping = {
        id sqlType:'int', generator:'increment'
    }
}
