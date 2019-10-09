package icbs.admin

import icbs.lov.ConfigItemStatus

class Role {

	String code
	String name
	ConfigItemStatus configItemStatus

    static belongsTo = [Module]

    static hasMany = [modules: Module, userMasters: UserMaster, policies: Policy, approvalPolicies: Policy]

    static constraints = {
    	code maxSize:10, unique:true
    	name maxSize:50, unique:true
        configItemStatus blank:true, nullable:false
    }

    static mapping = {
        modules joinTable: [name:'role_module', key:'role_id']
        userMasters joinTable: [name:'user_role', key:'role_id']
        policies joinTable: [name:'policy_role', key:'role_id']
        approvalPolicies joinTable: [name:'policy_approver', key:'role_id']
    	id sqlType:'smallint', generator:'increment'
        configItemStatus sqlType:'smallint'
    }
}
