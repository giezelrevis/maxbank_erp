package icbs.loans

import icbs.gl.GlAccount
import icbs.lov.LoanSpecialType

class LoanSpecial {
	LoanSpecialType type
	String action
	Date transferDate

	static hasMany = [litigationExpenses: LitigationExpense,
					  litigationDeficiencies: LitigationDeficiency,
					  ropaExpenses: ROPAExpense,
					  ropaExpenseAdjustments: ROPAExpenseAdjustment,
					  ropaExpenseCapitalizations: ROPAExpenseCapitalization,
					  ropaExpenseCapitalizationAdjustments: ROPAExpenseCapitalizationAdjustment,
					  ropaSellOffs: ROPASellOff]

	static constraints = {    	
		type nullable:true
		action nullable:true
		transferDate nullable:true
	}

    static mapping = {
		id sqlType: "int", generator: "increment"
	}
}