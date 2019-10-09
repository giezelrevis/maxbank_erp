package icbs.lov

class LoanProvisionBsp {
    
    String code 	
    String description
    String shortDescription
    Integer loanProvision	
    Integer minAge	
    Integer maxAge	
    Double otherAclRate	
    Double remAclRate	
    Boolean status
    
    static constraints = {
    	code maxSize:10, unique:true
        shortDescription nullable:true, maxSize:10
    	//description maxSize:75, unique:true
    }

    static mapping = {
    	id sqlType:'smallint'
    }

    String toString() {
        return description
    }

    String getCodeDescription() {
        "${code} - ${description}"
    }
}
