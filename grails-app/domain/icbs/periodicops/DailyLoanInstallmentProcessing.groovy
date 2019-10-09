package icbs.periodicops

import icbs.loans.LoanInstallment
import icbs.loans.Loan

class DailyLoanInstallmentProcessing {
    Date processDate
    Integer loanInstallment
    Integer loan
    
    static constraints = {
        loanInstallment nullable:true
        loan nullable:true
    }
    static mapping = {
	id sqlType:'int', generator:'increment'
	processDate sqlType:'date'
    }      
}
