package icbs.admin

import icbs.admin.Currency
import icbs.lov.TxnModule
import icbs.lov.TxnType
import icbs.lov.ConfigItemStatus
import icbs.lov.MemoTxnType
import icbs.lov.YesNoNa
import icbs.lov.ProductType
import icbs.deposit.DepositTaxFeeAndChargeScheme

class TxnTemplate {

	TxnModule txnModule
	TxnType txnType
	String code
	String description
	String shortDescription
	BigDecimal minAmt
	BigDecimal maxAmt
	String amlaCode
	boolean requireTxnDescription
	boolean requireTxnReference
	Integer validationCopyNo
	String validationFormCode // Form
	Currency currency
	YesNoNa requirePassbook
	YesNoNa atmOnlyTxn
	YesNoNa interbranchTxn
	boolean systemOnlyTxn
	MemoTxnType memoTxnType
	YesNoNa batchTxn
	ConfigItemStatus configItemStatus
        String appType
        
        
        String defContraAcct
    static belongsTo = [DepositTaxFeeAndChargeScheme]

    static hasMany = [charges:DepositTaxFeeAndChargeScheme, products:Product, policies:Policy]

    static constraints = {
    	txnModule nullable:false
    	txnType nullable:false
    	code maxSize:50, unique:true
    	description maxSize:100, unique:true
    	shortDescription maxSize:50, unique:true, nullable:true
    	minAmt nullable:true, min: 0.00
    	maxAmt nullable:true, min: 0.00
    	amlaCode maxSize:10, nullable:true
    	requireTxnDescription nullable:true
    	requireTxnReference nullable:true
    	validationCopyNo nullable:true, min: 0
    	validationFormCode nullable:true
    	currency nullable:true
    	requirePassbook nullable:true
    	atmOnlyTxn nullable:false
    	interbranchTxn nullable:false
    	systemOnlyTxn nullable:true
    	memoTxnType nullable:false
    	batchTxn nullable:false
    	configItemStatus nullable:false
        defContraAcct nullable:true
        appType nullable:true

    }

    static mapping = {
        charges joinTable: [name:'txn_charge', key:'txn_template_id']
        products joinTable: [name:'product_txn', key:'txn_template_id']
        policies joinTable: [name:'policy_txn', key:'txn_template_id']
    	id sqlType:'int', generator:'increment'
    	txnModule sqlType:'smallint'
    	txnType sqlType:'smallint'
    	requirePassbook column:'require_passbook', sqlType:'smallint'
		atmOnlyTxn column:'atm_only_txn', sqlType:'smallint'
		interbranchTxn column:'interbranch_txn', sqlType:'smallint'
		memoTxnType sqlType:'smallint'
		batchTxn column:'batch_txn', sqlType:'smallint'
    	configItemStatus sqlType:'smallint'
    }
    
    String getCodeDescription() {
        "${code} - ${description}"
    }
}
