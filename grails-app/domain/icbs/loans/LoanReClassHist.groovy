package icbs.loans

import icbs.loans.Loan
import icbs.tellering.TxnFile
import icbs.lov.LoanPerformanceId

class LoanReClassHist {

        Date reclassDate
        Loan loanAcct
        LoanPerformanceId oldClass
        LoanPerformanceId newClass
        TxnFile txnFile
        String reclassDesc
        
    static constraints = {
        loanAcct nullable:false
        txnFile nullable:false
        oldClass nullable:false
        newClass nullable:false
    }
    
    static mapping = {
        id sqlType:'int', generator:'increment'
    }
}