package icbs.periodicops

import icbs.loans.Loan
import icbs.tellering.TxnFile

class DailyLoanRecoveries {
    Date processDate
    Loan loan
    TxnFile txnFileDrDeposit
    TxnFile txnFileCrLoan
    
    static constraints = {
    }
    static mapping = {
	id sqlType:'int', generator:'increment'
	processDate sqlType:'date'
    }     
}
