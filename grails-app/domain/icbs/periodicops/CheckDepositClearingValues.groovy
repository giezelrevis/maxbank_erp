package icbs.periodicops

class CheckDepositClearingValues {
	
	Date systemRunDate
	String checkType//lov ko
	Date checkClearingDate//Check Deposit Transaction
        //Mark in COCI table as cleared, add to deposit main avail balance
	Date checkClearingDateAfterCutoff// Check Deposit Transaction
	
	static constraints = {
		systemRunDate nullable:false
		checkType nullable:false
		checkClearingDate nullable:false 
		checkClearingDateAfterCutoff nullable:false  
	}
        
    static mapping = {
        id sqlType:'int', generator:'increment'
    }
}
