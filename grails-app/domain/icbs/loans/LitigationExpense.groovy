package icbs.loans

import icbs.gl.GlAccount
import icbs.lov.TxnType

class LitigationExpense {
	GlAccount glAccount
	TxnType type
	Double amount

	static constraints = {    	
		glAccount nullable:true
		type nullable:true
		amount nullable:true
	}

    static mapping = {
		id sqlType: "int", generator: "increment"
	}
}