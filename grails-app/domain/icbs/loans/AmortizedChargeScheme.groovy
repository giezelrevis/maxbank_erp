package icbs.loans

import icbs.admin.Product
import icbs.lov.LoanServiceChargeType
import icbs.lov.LoanServiceChargeBasis
import icbs.lov.LoanInstallmentFreq
import icbs.lov.ConfigItemStatus

class AmortizedChargeScheme {
	String code
	String name	
	LoanServiceChargeBasis basis
	//LoanInstallmentFreq frequency
	LoanServiceChargeType type
	Double amount
	Double rate	
	boolean hasEirMode
	ConfigItemStatus status
	String hash	

	static hasMany = [products: Product]
	static belongsTo = [Product]

    static constraints = {
    	code maxSize: 10, unique: true, nullable: false, blank: false
    	name maxSize: 75, unique: true, nullable: false, blank: false
    	type nullable: false
    	basis nullable: false
    	//frequency nullable: false
    	amount scale: 2, nullable: false, blank: false, min: 0d 
		rate scale: 5, nullable: false, blank: false, min: 0d		
		hasEirMode nullable: false
		status nullable: true
		hash maxSize: 255, nullable: true
    }

    static mapping = {
		id sqlType: "int", generator: "increment"		
    	basis sqlType: "smallint"
    	//frequency sqlType: "smallint"
    	type sqlType: "smallint" 
		status sqlType: "smallint"
		products joinTable: [name:'amortized_charge_scheme_product', key:'amortized_charge_scheme_id']
    }

    def beforeValidate(){
        if (type.id == 1) {  // fixed amount
        	rate = 0
        } else if (type.id == 2) {  // rate based
        	amount = 0
        } else if (type.id == 3) {  // special
        	amount = 0
        	rate = 0
        } else if (type.id == 4) {  // manual
        	amount = 0
        	rate = 0
        }
    }
}