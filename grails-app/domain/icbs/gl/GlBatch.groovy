package icbs.gl

import icbs.admin.Currency

class GlBatch {

	String batchId
	String lineNo
	String batchType
	String txnType
	Date recordDate
	String account
	Double amount
        Double principal
        Double interest
        Double penalty
        Double serviceCharge
	String particulars
	String lineStatus	
	Currency currency
	String reference
	String debitAccount
	String creditAccount
	Double credit
	Double debit
        String checkNo
        String accountName
        
	static mapping = {
            id sqlType:'int', generator:'increment'  
            datasources(['reporting', 'DEFAULT'])
   	}

    static constraints = {
    	batchId nullable:false
    	lineNo nullable:true
    	batchType nullable: true  
    	txnType nullable:true
    	recordDate nullable:true
    	amount nullable:true, min: 0d ,scale:2		
    	particulars nullable:true
    	lineStatus nullable:true
    	currency nullable:true
    	account nullable:true
    	reference nullable:true
    	creditAccount nullable:true
    	debitAccount nullable:true
    	debit nullable:true, min: 0d, scale:2
    	credit nullable:true, min: 0d, scale:2
        checkNo nullable:true
        accountName nullable:true
        principal nullable:true, min: 0d, scale:2
        interest nullable:true, min: 0d, scale:2
        penalty nullable:true, min: 0d, scale:2
        serviceCharge nullable:true, min: 0d, scale:2
    }
       
}
