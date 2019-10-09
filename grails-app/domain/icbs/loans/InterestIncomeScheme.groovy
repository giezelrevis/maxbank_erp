package icbs.loans

import icbs.admin.Product
import icbs.lov.LoanInstallmentType
import icbs.lov.LoanCalculation
import icbs.lov.LoanAdvancedInterestType
import icbs.lov.ConfigItemStatus

class InterestIncomeScheme {
	String code
	String name
	LoanInstallmentType installmentType
	LoanCalculation installmentCalcType
	LoanAdvancedInterestType advInterestType
	Double defaultInterestRate
	Double pastDueInterestRate
        Double minInterestRate
	Double maxInterestRate
	Integer divisor
	Integer gracePeriod
	boolean hasBalloonMode
	boolean canChangeInterestRate
	boolean hasInterestAccrual	
	ConfigItemStatus status
	String hash

	static hasMany = [products: Product]
	static belongsTo = [Product]

    static constraints = {
    	code maxSize: 10, unique: true, nullable: false, blank: false
    	name maxSize: 75, unique: true, nullable: false, blank: false
    	installmentType nullable: false
		installmentCalcType nullable: false
		advInterestType nullable: false
		defaultInterestRate scale: 5, nullable: false, blank: false, min: 0d
		pastDueInterestRate scale: 5, nullable: false, blank: false, min: 0d
    	minInterestRate scale: 5, nullable: false, blank: false, min: 0d
    	maxInterestRate scale: 5, nullable: false, blank: false, min: 0d
    	divisor nullable: false, blank: false, min: 0
    	gracePeriod nullable: false, blank: false, min: 0
		hasBalloonMode nullable: false
		canChangeInterestRate nullable: false
		hasInterestAccrual nullable: false
		status nullable: true
		hash maxSize: 255, nullable: true
    }

    static mapping = {
    	id sqlType: "int", generator: "increment"
    	installmentType sqlType: "smallint"
    	installmentCalcType sqlType: "smallint"
    	advInterestType sqlType: "smallint"
    	divisor sqlType: "smallint"
		gracePeriod sqlType: "smallint"
		status sqlType: "smallint"
		products joinTable: [name:'interest_income_scheme_product', key:'interest_income_scheme_id']
    }

    def beforeValidate() {
    	if ([3, 4, 6].contains(this.installmentCalcType.id.toInteger())) {  // does not have advanced interests
    		this.advInterestType = LoanAdvancedInterestType.get(1)
    	} else if (this.installmentCalcType.id == 2 && this.advInterestType.id == 2) { 
    		// fixed principal cannot have full advanced interests
    		this.advInterestType = LoanAdvancedInterestType.get(3)
    	}
	}
}
