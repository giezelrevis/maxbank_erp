package icbs.lov

class LoanCollateralType {

    String code
	String description
	boolean status

    static constraints = {
    	code maxSize:10, unique:true
    	description maxSize:75, unique:true
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
