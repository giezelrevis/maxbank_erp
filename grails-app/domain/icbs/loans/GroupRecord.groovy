package icbs.loans

import icbs.lov.ConfigItemStatus
import icbs.lov.GroupType
import icbs.cif.Customer

class GroupRecord {
	String name
    String description
    GroupType type
    GroupRecord parent
    Date meetingDate
	Date dateCreated
	ConfigItemStatus status

	static hasMany = [members: Customer]

    static constraints = {    	
        name nullable: false
        description nullable: true
        type nullable: false
        parent nullable: true
        meetingDate nullable: true
        dateCreated nullable: true
        status nullable: true
    }

    static mapping = {
		id sqlType: "int", generator: "increment"
		parent sqlType: "int"
		status sqlType: "smallint"
	}

    def beforeValidate(){
        dateCreated = new Date()
    }

	def beforeInsert() {
		// determine user rights first
		status = ConfigItemStatus.get(1)
        
        return true
    }    

}