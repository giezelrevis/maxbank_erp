package icbs.gl

import icbs.admin.Currency
import icbs.gl.GlAccount
import icbs.loans.Loan
import icbs.admin.Branch
import icbs.lov.GlBatchHdrStatus
import icbs.admin.UserMaster

class GlBatchHdr {

	String batchId
	String batchName
	String batchType //Template
	Currency batchCurrency
	String batchParticulars
	Double totalDebit
	Double totalCredit
	GlAccount contraGl
	GlAccount errorGl
	String txnType
	String loanId
	boolean isLocked
	boolean isBalanced
	Branch branch
        Date txnDate
        Date valueDate
        GlBatchHdrStatus status
        UserMaster approvedBy
        UserMaster postedBy
        UserMaster createdBy

    static constraints = {
   		contraGl nullable:true
   		errorGl nullable:true
   		batchType nullable:true
   		batchParticulars nullable:true
        txnType nullable: true
        loanId nullable: true
        txnDate nullable:true
        status nullable:true
        approvedBy nullable:true
        postedBy nullable:true
        createdBy nullable:true
        valueDate nullable:true
	totalDebit scale:2
	totalCredit scale:2
        
    }

    static mapping = {
      id sqlType: "int", generator: "increment"
      batchCurrency sqlType: "int"
      branch sqlType: "int"
      status sqlType: "int"
      approvedBy sqlType: "int"
      postedBy sqlType: "int"
      createdBy sqlType: "int"
    }

    
}
