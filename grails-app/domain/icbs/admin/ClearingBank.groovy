package icbs.admin

import icbs.lov.ConfigItemStatus

class ClearingBank {

	String code
	String name
	String shortName
	String address
	String contactPerson
	String contact
	String email
	String swiftCode
	ConfigItemStatus configItemStatus

    // static belongsTo = [Branch]

    // static hasMany = [branches: Branch]

    static constraints = {
    	code maxSize:50, unique:true
    	name maxSize:100, unique:true
    	shortName maxSize:50, unique:true
    	address maxSize:255, nullable:true
    	contactPerson maxSize:50, nullable:true
    	contact maxSize:50, nullable:true
    	email maxSize:50, nullable:true
    	swiftCode maxSize:10
    }

    static mapping = {
        // branches joinTable: [name:'branch_clearing_bank', key:'clearing_bank_id']
    	id sqlType:'int', generator:'increment'
    	configItemStatus sqlType:'smallint'
    }
}
