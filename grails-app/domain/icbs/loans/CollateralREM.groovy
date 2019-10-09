package icbs.loans

import icbs.lov.AppraisedValueType

class CollateralREM {
	AppraisedValueType appraisedValueType
	String tctNo
	String lotNo
	String location
	String otherOwners
	String registryOfDeeds
	Date dateOfIssuance
	String encumberances
        Double landArea

	//static belongsTo = [collateral: Collateral]

	static constraints = {
    	appraisedValueType nullable:false    
		tctNo nullable:false
		lotNo nullable:false
		location nullable:false
		otherOwners nullable:true
		registryOfDeeds nullable:false
		dateOfIssuance nullable:false
		encumberances nullable:true
                landArea nullable:true, min: 0d, scale:2
    }

    static mapping = {
		id sqlType: "int", generator: "increment"
		appraisedValueType sqlType: "smallint"
	}

}