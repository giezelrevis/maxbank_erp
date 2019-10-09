package icbs.loans

import icbs.admin.Product
import icbs.lov.LoanPenaltyType
import icbs.lov.LoanPenaltyBasis
import icbs.lov.LoanPenaltyFreq
import icbs.lov.ConfigItemStatus

class PenaltyIncomeScheme {
	String code
	String name
	LoanPenaltyBasis basis
	LoanPenaltyType type
	LoanPenaltyFreq frequency
	Double defaultPenaltyAmount
	Double minPenaltyAmount
	Double maxPenaltyAmount	
	Double defaultPenaltyRate
	Double minPenaltyRate
	Double maxPenaltyRate	
	Integer divisor	
	Integer gracePeriod
	boolean canChangePenaltyRate
	boolean hasWeekendMode
	ConfigItemStatus status
	String hash
	
	static hasMany = [products: Product]
	static belongsTo = [Product]

    static constraints = {
    	code maxSize: 10, unique: true, nullable: false, blank: false
    	name maxSize: 75, unique: true, nullable: false, blank: false
    	basis nullable: false
    	type nullable: false
    	frequency nullable: true
    	defaultPenaltyAmount scale: 2, nullable: false, blank: false
		minPenaltyAmount scale: 2, nullable: false, blank: false, min: 0d
		maxPenaltyAmount scale: 2, nullable: false, blank: false, min: 0d
		defaultPenaltyRate scale: 5, nullable: false, blank: false, min: 0d
		minPenaltyRate scale: 5, nullable: false, blank: false, min: 0d
		maxPenaltyRate scale: 5, nullable: false, blank: false, min: 0d		
		divisor nullable: false, blank: false, min: 0
		gracePeriod nullable: true, blank: true, min: 0
		canChangePenaltyRate nullable: false
		hasWeekendMode nullable: false
		status nullable: true
		hash maxSize: 255, nullable: true
    }

    static mapping = {
    	id sqlType: "int", generator: "increment"
		basis sqlType: "smallint"
    	frequency sqlType: "smallint"
    	type sqlType: "smallint"
    	divisor sqlType: "smallint"
    	gracePeriod sqlType: "smallint"
		status sqlType: "smallint"
		products joinTable: [name:'penalty_income_scheme_product', key:'penalty_income_scheme_id']
    }

    def beforeValidate(){
        if (type.id == 1) {  // fixed amount
        	defaultPenaltyRate = 0
        	minPenaltyRate = 0
        	maxPenaltyRate = 0
        	divisor = 0
        } else if (type.id == 2) {  // rate based
        	frequency = null
        	defaultPenaltyAmount = 0
        	minPenaltyAmount = 0
        	maxPenaltyAmount = 0
        } 

        if (!gracePeriod)
        	gracePeriod = 0
    }
}
