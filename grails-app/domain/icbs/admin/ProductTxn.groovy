package icbs.admin

import icbs.lov.ConfigItemStatus

class ProductTxn {

	Product product
	TxnTemplate txnTemplate
	ConfigItemStatus configItemStatus

    static constraints = {
    }

    static mapping = {
        id sqlType:'int', generator:'increment'
    	product sqlType:'int'
    	txnTemplate sqlType:'int'
    	configItemStatus sqlType:'smallint'
    }
}
