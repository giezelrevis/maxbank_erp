package icbs.loans

class ServiceCharge {
	AmortizedChargeScheme scheme
	Double amount
	Double rate

	static constraints = {
		scheme nullable:true
		amount nullable:true, min: 0d, scale:2
		rate nullable:true, min: 0d, scale:5
	}

    static mapping = {
		id sqlType: "int", generator: "increment"
	}
}