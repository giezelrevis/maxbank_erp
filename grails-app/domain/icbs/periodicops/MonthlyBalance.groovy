package icbs.periodicops

import icbs.admin.Branch
import icbs.admin.Currency

class MonthlyBalance {
	//every end of month straight forward sa deposit and loans
	String refMonth
	String refYear
	String appType//product type
	Branch branch
	Currency currency
        Date refDate //reference date
	String accountNo//loan or deposit
	Integer accountStatus//loan or deposit direct pickup
	String loanPastDueStatus//direct pickup loan
	Double availableBal//deposit
	Double averageBal//calculate from daily balance
	Double closingBal//pickup from deposit. Ledger Balance
	Double accruedInterestThisMonth//calculate during ending month deposit daily balance
	Double accruedInterestCumulative//calculate during ending month deposit daily balance
	Double grossInterestCapital//calculate during ending month deposit daily balance
	Double taxWithheld//calculate during ending month deposit tax lang sa deposit
	Double loanInterestBal//kukunin ko lang sa loan master calculated daily
	Double penaltyBal//loan master calculated daily
	Double uidBal//galing sa loan masterv direct pickup
	Double lastTxnAmountPrincipal//loans direct pickup 
	Double lastTxnAmountInterest //loans direct pickup
	Date lastTxnDate// for report purposes
	String checkSum
	static constraints = {
		
		refMonth nullable:true 
		refYear nullable:true 
		appType nullable:false 
		branch nullable:true 
		currency nullable:false 
		accountNo maxsize:50,nullable:false
                loanPastDueStatus nullable:true
                availableBal nullable:true, scale:2
                averageBal nullable:true, scale:2
                closingBal nullable:true, scale:2
                accruedInterestThisMonth nullable:true, scale:2
                accruedInterestCumulative nullable:true, scale:2
                grossInterestCapital nullable:true, scale:2
                taxWithheld nullable:true, scale:2
                loanInterestBal nullable:true, scale:2
                penaltyBal nullable:true, scale:2
                uidBal nullable:true, scale:2
                lastTxnAmountPrincipal nullable:true, scale:2
                lastTxnAmountInterest nullable:true, scale:2
                lastTxnDate nullable:true
		checkSum maxsize:10, nullable:true
		
        }
	static mapping = {
		
		id sqlType:'int', generator:'increment'
		branch sqlType:'smallint'
		currency sqlType:'smallint'
		accountStatus sqlType:'smallint'
		lastTxnDate sqlType:'date'
		
	}
	
}