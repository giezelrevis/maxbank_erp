package icbs.gl

class GlBatchTemplate {

	String status
	String description
    
    static constraints = {
    	status nullable:false
    	description nullable:false
    }

    static mapping = {
    	id sqlType:'int'
    }
}
