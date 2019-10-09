package icbs.admin

class PolicyException {

	UserMaster requestingUser
	UserMaster approvingUser
	Date dateOfRequest
	Date dateOfAction
    PolicyTemplate policyTemplate
    String tableName
    Integer recordId
	String recordUrl
	boolean isApproved

    static constraints = {
    	approvingUser nullable:true
    	dateOfAction nullable:true
    	isApproved nullable:true
    }

    static mapping = {
        id sqlType:'int', generator:'increment'
    	requestingUser sqlType:'int'
    	approvingUser sqlType:'int'
        policyTemplate sqlType:'smallint'
    }
}
