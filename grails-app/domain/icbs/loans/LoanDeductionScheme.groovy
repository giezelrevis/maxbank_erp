package icbs.loans

import icbs.admin.Product
import icbs.lov.LoanDeductionCalculationType
import icbs.lov.LoanDeductionSpecialCalculation
import icbs.lov.ConfigItemStatus
import icbs.gl.GlAccount

class LoanDeductionScheme {
	String code
	String name		
	String description
	LoanDeductionSpecialCalculation specialCalculation	
	LoanDeductionCalculationType type
	Double amount
	Double rate	
	Integer divisor
	boolean hasEirMode
        GlAccount contraAcct
	ConfigItemStatus status
	String hash	

	static hasMany = [products: Product]
	static belongsTo = [Product]

    static constraints = {
    	code maxSize: 10, unique: true, nullable: false, blank: false
    	name maxSize: 75, unique: true, nullable: false, blank: false    	
    	description nullable: true
    	specialCalculation nullable: false
    	type nullable: false
	amount scale: 2, nullable: false, blank: false, min: 0d
	rate scale: 5, nullable: false, blank: false, min: 0d
	divisor nullable: false, blank: false, min: 0
	hasEirMode nullable: false
	status nullable: true
	hash maxSize: 255, nullable: true
        contraAcct nullable:false        
    }

    static mapping = {
		id sqlType: "int", generator: "increment"		
		specialCalculation sqlType: "smallint"
		type sqlType: "smallint"
		divisor sqlType: "smallint"
		status sqlType: "smallint"
		products joinTable: [name:'loan_deduction_scheme_product', key:'loan_deduction_scheme_id']
    }   

    def beforeValidate(){
        if (type.id == 1) {  // fixed amount
        	rate = 0
        	divisor = 0
        } else if (type.id == 2) {  // rate based
        	amount = 0
        } else if (type.id == 3) {  // special - dst rem
        	amount = 0
        	rate = 0
        	divisor = 0
        } else if (type.id == 4) {  // special - dst rn
        	amount = 0
        	rate = 0
        	divisor = 365
        } else if (type.id == 5) {  // manual
        	amount = 0
        	rate = 0
        	divisor = 0
        }
    } 
}