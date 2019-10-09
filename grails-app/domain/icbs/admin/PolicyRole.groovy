package icbs.admin

import icbs.lov.ConfigItemStatus

class PolicyRole {

	Policy policy
	Role role
	ConfigItemStatus configItemStatus

    static constraints = {
        
    }

    static mapping = {
    	id sqlType:'int', generator:'increment'
    	policy sqlType:'smallint'
    	role sqlType:'smallint'
    	configItemStatus sqlType:'smallint'
    }
}
