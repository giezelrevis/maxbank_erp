package icbs.admin

import icbs.lov.ProductType
import icbs.lov.LoanFreq
import icbs.lov.DepositAcctDormancyTransferFreq
import icbs.lov.ConfigItemStatus
import icbs.loans.InterestIncomeScheme
import icbs.loans.PenaltyIncomeScheme
import icbs.loans.AmortizedChargeScheme
import icbs.loans.LoanDeductionScheme
import icbs.loans.LoanPerformanceClassificationScheme
import icbs.deposit.DepositInterestScheme
import icbs.deposit.FixedDepositPreTermScheme
import icbs.deposit.FixedDepositTermScheme
class Product {

	Integer code
	ProductType productType
	String name
	String shortName
	Currency currency
	BigDecimal minOpen
	BigDecimal maxOpen
	BigDecimal minBalance
	BigDecimal maxBalance
	Integer minTerm
	Integer maxTerm
	boolean allowFdMultiplePlacement
	boolean allowFdPartialWithrawal
	Integer depositDormancyMonths
	DepositAcctDormancyTransferFreq depositDormancyTransferFreq
	boolean hasDepositDormancyInterest
	BigDecimal depositDormancyAmt
	BigDecimal depositChargeStart
	boolean isMicrofinance
	LoanFreq loanUidTransferFreq
	LoanFreq loanReclassFreq
	LoanFreq loanProvisionFreq
	String documentTemplate
	ConfigItemStatus configItemStatus

	static belongsTo = [Branch, CustomerGroup, TxnTemplate]

	static hasMany = [branches: Branch,
					customerGroups: CustomerGroup,
					txnTemplates: TxnTemplate,
					  interestIncomeSchemes: InterestIncomeScheme, 
					  penaltyIncomeSchemes: PenaltyIncomeScheme,
					  amortizedChargeSchemes: AmortizedChargeScheme,
					  loanDeductionSchemes: LoanDeductionScheme,
					  loanPerformanceClassificationSchemes: LoanPerformanceClassificationScheme,
                                          depositInterestSchemes:DepositInterestScheme,
                                          fixedDepositPretermSchemes:FixedDepositPreTermScheme,
                                          fixedDepositTermSchemes:FixedDepositTermScheme
    ]

    static constraints = {
    	code min:1, max:999, unique:true
    	name maxSize:100, unique:true
    	shortName maxSize:50, unique:true
    	minBalance nullable:true, min: 0.00, scale: 2
    	maxBalance nullable:true, min: 0.00, scale: 2
    	minTerm nullable:true, min: 0
    	maxTerm nullable:true, min: 0
    	allowFdPartialWithrawal nullable:true
    	allowFdMultiplePlacement nullable:true
    	depositDormancyMonths nullable:true, min: 0
    	depositDormancyTransferFreq nullable:true
    	hasDepositDormancyInterest nullable:true
    	depositDormancyAmt nullable:true, min: 0.00, scale: 2
    	depositChargeStart nullable:true, min: 0.00, scale: 2
    	isMicrofinance nullable:true
    	documentTemplate nullable:true
    	loanUidTransferFreq nullable:true
		loanReclassFreq nullable:true
		loanProvisionFreq nullable:true
    }

    static mapping = {
    	branches joinTable: [name:"branch_product", key:"product_id"]
    	customerGroups joinTable: [name:'customer_group_product', key:'product_id']
    	txnTemplates joinTable: [name:'product_txn', key:'product_id']
    	id sqlType:'int', generator:'increment'
    	minTerm sqlType:'smallint'
    	maxTerm sqlType:'smallint'
    	depositDormancyTransferFreq sqlType:'smallint'
    	configItemStatus sqlType:'smallint'
    	interestIncomeSchemes joinTable: [name:'interest_income_scheme_product', key:'product_id']
    	penaltyIncomeSchemes joinTable: [name:'penalty_income_scheme_product', key:'product_id']
    	amortizedChargeSchemes joinTable: [name:'amortized_charge_scheme_product', key:'product_id']
    	loanDeductionSchemes joinTable: [name:'loan_deduction_scheme_product', key:'product_id']
    	loanPerformanceClassificationSchemes joinTable: [name:'loan_performance_classification_scheme_product', key:'product_id']
        depositInterestSchemes joinTable: [name:'deposit_interest_scheme_product', key:'product_id']
        fixedDepositPretermSchemes joinTable: [name:'fixed_deposit_pre_term_scheme_product', key:'product_id']
        fixedDepositTermSchemes joinTable: [name:'fixed_deposit_term_scheme_product', key:'product_id']
    }
    
    def beforeInsert() {
        // ca/sa
        if ((this.productType == ProductType.read(1)) || this.productType == ProductType.read(1) ) {
            this.minTerm = 0
            this.maxTerm = 0
            this.allowFdMultiplePlacement = false
            this.allowFdPartialWithrawal = false    
            this.loanUidTransferFreq = null
            this.loanReclassFreq = null
            this.loanProvisionFreq = null
        }
        // fd
        if (this.productType == ProductType.read(3)) {
            this.depositDormancyMonths = 0
            this.depositDormancyTransferFreq = null
            this.depositDormancyAmt = 0.00
            this.depositChargeStart = 0.00
            this.loanUidTransferFreq = null
            this.loanReclassFreq = null
            this.loanProvisionFreq = null        
        }
        // loans
        if (this.productType == ProductType.read(4)) {
            this.depositDormancyMonths = 0
            this.depositDormancyTransferFreq = null
            this.depositDormancyAmt = 0.00
            this.depositChargeStart = 0.00      
            this.allowFdMultiplePlacement = false
            this.allowFdPartialWithrawal = false   
        }        
    }
    
    def beforeUpdate() {

    }    
}
