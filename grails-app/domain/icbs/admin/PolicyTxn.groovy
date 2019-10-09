package icbs.admin

import icbs.admin.TxnTemplate
import icbs.admin.Policy
import icbs.lov.ConfigItemStatus

class PolicyTxn {

	TxnTemplate txnTemplate
	Policy policy
	ConfigItemStatus configItemStatus

    static constraints = {
    	txnTemplate nullable:false
    	policy nullable:false
    	configItemStatus nullable:false
    }

    static mapping = {
    	id sqlType:'int', generator:'increment'
    	txnTemplate sqlType:'int'
    	configItemStatus sqlType:'smallint'
    }
}
