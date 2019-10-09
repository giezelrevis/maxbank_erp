package icbs.admin

import icbs.lov.ConfigItemStatus
import icbs.admin.Currency

class CheckDepositClearingType {

	String code
	String description
	String shortDescription
	boolean isOnUs
	boolean hasVariableClearingDays
	Integer clearingDays
	Currency currency
	ConfigItemStatus configItemStatus
        Date clearingDate

    // static belongsTo = [Branch]

    // static hasMany = [branches: Branch]

    static constraints = {
    	code maxSize:10, unique:true
    	description maxSize:100, unique:true
    	shortDescription maxSize:50, unique:true
    	isOnUs nullable:true
    	hasVariableClearingDays nullable:true
    	clearingDays nullable:true
    	currency nullable:false
        clearingDate nullable:true
    }

    static mapping = {
        // branches joinTable: [name:'branch_check_deposit_clearing_type', key:'check_deposit_clearing_type_id']
    	id sqlType:'int', generator:'increment'
    	currency sqlType:'smallint'
    	configItemStatus sqlType:'smallint'
    }
}
