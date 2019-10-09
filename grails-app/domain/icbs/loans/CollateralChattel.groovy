package icbs.loans

class CollateralChattel {
	String identificationNo
	Double acquisitionCost
	Date acquisitionDate	
	String insuranceType
        String orNo
        Date orDate
        String crNo
        Date crDate

	//static belongsTo = [collateral: Collateral]

	static constraints = {  
		identificationNo nullable:false
		acquisitionCost nullable:false, min:0d, scale:2
		acquisitionDate nullable:false
		insuranceType nullable:true
                orNo nullable:true
                crNo nullable:true
                orDate nullable:true
                crDate nullable:true
	}	

    static mapping = {
		id sqlType: "int", generator: "increment"
	}
}