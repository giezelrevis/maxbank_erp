package icbs.lov

class Designation {

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
    }

    String toString() {
        return description
    }

    String getCodeDescription() {
        "${code} - ${description}"
    }
}
