package icbs.loans

class CollateralPDC {
	String accountNo
	String checkNo
	Double amount
	String bank
	boolean onUs
	Date pdcDate

	//static belongsTo = [collateral: Collateral]

	static constraints = {    	
		accountNo nullable:true
		checkNo nullable:true, unique: true
		amount nullable:true, min:0d, scale:2
		bank nullable:true
		onUs nullable:true
		pdcDate nullable:true
    }

    static mapping = {
		id sqlType: "int", generator: "increment"
	}
}
