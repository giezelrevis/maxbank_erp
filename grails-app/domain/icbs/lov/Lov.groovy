package icbs.lov

class Lov {

	String groupCode
	String groupDescription
	String itemCode
        String shortDescription
	String itemValue
	boolean status

    static constraints = {
    	groupCode maxSize:10
    	groupDescription maxSize:75
        shortDescription nullable:true, maxSize:10
    	itemCode maxSize:10
    	itemValue maxSize:75
    }

    static mapping = {
    	id sqlType:'int'
    }

    String getCodeDescription() {
        "${itemCode} - ${itemValue}"
    }
}
