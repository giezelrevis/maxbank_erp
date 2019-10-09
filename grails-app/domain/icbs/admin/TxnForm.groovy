package icbs.admin

import icbs.lov.ConfigItemStatus

class TxnForm {

	TxnTemplate txnTemplate
	Form form
	ConfigItemStatus configItemStatus

    static constraints = {
    }

    static mapping = {
    	txnTemplate sqlType:'int'
    	form sqlType:'int'
    	configItemStatus sqlType:'smallint'
    }
}
