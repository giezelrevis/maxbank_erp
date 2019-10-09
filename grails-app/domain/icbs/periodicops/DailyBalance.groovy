package icbs.periodicops

import icbs.admin.Branch
import icbs.admin.Currency

class DailyBalance {
	//closing straight forward from deposit account, all types
	Date refDate
	String refMonth
	String refYear
	String appType
	Branch branch
	Currency currency
	String accountNo
	Integer accountStatus
	Double availableBal
        Double closingBal
	Double holdBal
		
	static constraints = {
		
		refDate nullable:false 
		refMonth nullable:true 
		refYear nullable:true 
		appType nullable:true 
		branch nullable:true 
		currency nullable:false 
		accountNo maxsize:50, nullable:false
		availableBal nullable:false, scale:2 
		closingBal nullable:false, scale:2 
		holdBal nullable:false , scale:2
		
	}
	
	static mapping = {
		
		id sqlType:'int', generator:'increment'
		refDate sqlType:'date'
		branch sqlType:'smallint'
		currency sqlType:'smallint'
		accountNo sqlType:'varchar'
		accountStatus sqlType:'smallint'
		
	}

}
