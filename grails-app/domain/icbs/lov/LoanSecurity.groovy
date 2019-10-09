package icbs.lov

class LoanSecurity {

      String code
	String description
        String shortDescription
	boolean status

    static constraints = {
    	code maxSize:10, unique:true
    	description maxSize:75, unique:true
        shortDescription nullable:true, maxSize:10
    }

    static mapping = {
    	id sqlType:'smallint'
        id generator:'increment'
    }

    String toString() {
        return description
    }

    String getCodeDescription() {
        "${code} - ${description}"
    }
}
