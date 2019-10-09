package icbs.gl

class GlBatchTransactionType {
	//Active or Inactive
	String status
	String description
    
    static constraints = {
    	status nullable:false
    	description nullable:false
    }

    static mapping = {
    	id sqlType:'int', generator:'increment'
    }

}
