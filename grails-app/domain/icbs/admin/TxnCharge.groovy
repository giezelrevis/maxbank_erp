package icbs.admin

import icbs.deposit.DepositTaxFeeAndChargeScheme
import icbs.lov.ConfigItemStatus

class TxnCharge {

	TxnTemplate txnTemplate
	DepositTaxFeeAndChargeScheme charge
	ConfigItemStatus configItemStatus

    static constraints = {
    }

    static mapping = {
        id sqlType:'int', generator:'increment'
    	txnTemplate sqlType:'int'
    	charge sqlType:'int'
    	configItemStatus sqlType:'smallint'
    }
}
