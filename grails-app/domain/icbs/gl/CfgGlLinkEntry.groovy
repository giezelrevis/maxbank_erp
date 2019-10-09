package icbs.gl

import icbs.gl.TxnGlLink
import icbs.gl.GlAccount
import icbs.gl.CfgAcctGlTemplateDet

class CfgGlLinkEntry {

	TxnGlLink glLink
	String debitAcct
	String creditAcct
	String debitAcctLink
	String creditAcctLink
	String description

    static belongsTo = [glLink: TxnGlLink]

    static constraints = {
    	debitAcct nullable:true
    	creditAcct nullable:true
    	debitAcctLink nullable:true
    	creditAcctLink nullable:true
    	description nullable:false
    }

    static mapping = {
    	id sqlType:'int'
    }
}
