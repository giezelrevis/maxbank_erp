package icbs.periodicops

import icbs.deposit.Hold

class DailyHoldsRelease {
    Date processDate
    Hold hold
    
    static constraints = {
    }
    static mapping = {
	id sqlType:'int', generator:'increment'
	processDate sqlType:'date'
		
    }    
}
