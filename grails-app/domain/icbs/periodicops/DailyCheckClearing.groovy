package icbs.periodicops
import icbs.deposit.Deposit
import icbs.tellering.TxnCOCI

class DailyCheckClearing {
    Date processDate
    Deposit deposit
    TxnCOCI checkDeposit
    
    static constraints = {
    }
    
    static mapping = {
	id sqlType:'int', generator:'increment'
	processDate sqlType:'date'		
    }   
}
