package icbs.admin

import icbs.lov.Month
import icbs.lov.ConfigItemStatus

class Holiday {

	enum Type {
		FIXED, MANUAL_RESET
	}

	String code
	String description
	Month month
	Integer day
	Type type
    ConfigItemStatus configItemStatus
    Date holidayDate
    Boolean institutionWideHoliday
    
    static belongsTo = [Branch]

    static hasMany = [branches: Branch]

    static constraints = {
    	code maxSize:10, unique:true
    	description maxSize:100, unique:true
    	month nullable:true
    	day nullable:true
    	type nullable:false
        holidayDate nullable:false
        //institutionWideHoliday nullable:true
    }

    static mapping = {
        branches joinTable: [name:'branch_holiday', key:'holiday_id']
    	id sqlType:'int', generator:'increment'
    	day sqlType:'smallint'
        configItemStatus sqlType:'smallint'
    }
}
