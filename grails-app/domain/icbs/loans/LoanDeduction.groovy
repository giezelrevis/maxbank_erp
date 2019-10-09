package icbs.loans

class LoanDeduction {
	LoanDeductionScheme scheme
	Double amount
	Double rate
	Integer transaction
	boolean posted	

	static constraints = {
		scheme nullable:true
		amount nullable:true, min:0d, scale:2
		rate nullable:true, min:0d, scale:5
		transaction nullable:true
	}

    static mapping = {
		id sqlType: "int", generator: "increment"
	}
}