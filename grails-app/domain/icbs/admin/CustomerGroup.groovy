package icbs.admin

import icbs.lov.ConfigItemStatus

class CustomerGroup {

	String code
	String name
	ConfigItemStatus configItemStatus

    static hasMany = [products: Product]

    static constraints = {
    	code maxSize:10, unique:true
    	name maxSize:50, unique:true
        configItemStatus blank:true, nullable:true
    }

    static mapping = {
        products joinTable: [name:'customer_group_product', key:'customer_group_id']
    	id sqlType:'int', generator:'increment'
        configItemStatus sqlType:'smallint'
    }
}
