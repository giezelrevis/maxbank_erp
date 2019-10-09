package icbs.admin

import icbs.lov.ConfigItemStatus

class BranchHoliday {

	Branch branch
	Holiday holiday
	ConfigItemStatus configItemStatus

    static constraints = {
    }

    static mapping = {
    	branch sqlType:'int'
    	holiday sqlType:'int'
    	configItemStatus sqlType:'int'
        id sqlType:'int', generator:'increment'
    }
}
