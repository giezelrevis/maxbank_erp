package icbs.loans

import icbs.admin.Product
import icbs.lov.LoanFreq
import icbs.lov.LoanPerformanceClassification
import icbs.lov.LoanPerformanceClassificationType
import icbs.lov.ConfigItemStatus

class LoanPerformanceClassificationScheme {
	String code
	String name
	LoanPerformanceClassification prevClassification
	LoanPerformanceClassification newClassification
	LoanPerformanceClassificationType type
	Integer thresholdFreq	
	Double thresholdAmount	
    /*boolean isAmountBased
	boolean isFrequencyBased
	LoanFreq frequency
	boolean isMaturityBased*/
	ConfigItemStatus status
	String hash

	static hasMany = [products: Product]
	static belongsTo = [Product]

    static constraints = {
    	code maxSize: 10, unique: true, nullable: false, blank: false
    	name maxSize: 75, unique: true, nullable: false, blank: false
    	prevClassification nullable: false
    	newClassification nullable: false
    	type nullable: false
    	thresholdFreq nullable: false, blank: false
    	thresholdAmount scale: 5, nullable: false, blank: false
    	/*isAmountBased nullable: false
    	isFrequencyBased nullable: false
    	frequency nullable: false    	
    	isMaturityBased nullable: false*/
    	status nullable: true
    	hash maxSize: 255, nullable: true
    }

    static mapping = {
		id sqlType: "int", generator: "increment"
		prevClassification sqlType: "smallint"
		newClassification sqlType: "smallint"
		type sqlType: "smallint"
		//frequency sqlType: "smallint"
		thresholdFreq sqlType: "smallint"
		status sqlType: "smallint"
		products joinTable: [name:'loan_performance_classification_scheme_product', key:'loan_performance_classification_scheme_id']
	}

	def beforeValidate(){
        if (type.id == 1) {  // fixed amount
        	thresholdFreq = 0
        } else if (type.id == 2) {  // frequency
        	thresholdAmount = 0
        } else {  // maturity
        	thresholdFreq = 0
        	thresholdAmount = 0
        }
    } 
}