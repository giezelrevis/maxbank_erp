package icbs.admin

import icbs.admin.PolicyTemplate
import icbs.lov.PolicyAction
import icbs.lov.ConfigItemStatus

class Policy {

	PolicyTemplate policyTemplate
	String description
	BigDecimal txnAmtCondition
	PolicyAction policyAction
	String reference
	ConfigItemStatus configItemStatus

    static belongsTo = [Role, TxnTemplate]

    static hasMany = [roles: Role, approvers: Role, txnTemplates: TxnTemplate]

    static constraints = {
    	policyTemplate nullable:false
    	description maxSize:100
    	txnAmtCondition nullable:true, min: 0.00, scale: 2
    	policyAction nullable:false
    	reference nullable:true
    }

    static mapping = {
        roles joinTable: [name:'policy_role', key:'policy_id']
        approvers joinTable: [name:'policy_approver', key:'policy_id']
        txnTemplates joinTable: [name:'policy_txn', key:'policy_id']
    	id sqlType:'smallint', generator:'increment'
    	policyTemplate sqlType:'smallint'
    	policyAction sqlType:'smallint'
    	configItemStatus sqlType:'smallint'
    }
}
