package icbs.loans

class CollateralHoldout {
	String accountNo
	String accountType	
	Double amount
	String bank
	boolean onUs	
	Date holdoutDate

	//static belongsTo = [collateral: Collateral]

	static constraints = {    	
		accountNo nullable:false
		accountType nullable:false	
		amount nullable:false, min:0d, scale:2
		bank nullable:false
		onUs nullable:false
		holdoutDate nullable:false
    }

    static mapping = {
		id sqlType: "int", generator: "increment"
	}
        
    def beforeInsert(){
        this.onUs = true
    }        
}