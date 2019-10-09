package icbs.gl
import icbs.admin.UserMaster
import icbs.admin.Branch
import icbs.gl.GlAccount
import icbs.gl.GlBatchHdr 
import icbs.gl.GlBatch
import icbs.gl.GlAccount

class GlTxnFile {

	String glAccountCode
        String batchId
	double debitAmt
	double creditAmt
	double debitBal		
	double creditBal
	double outstandingBal
        String glBatchLine
	String batchParticulars
	Date txnDate
	Date txnValueDate
	UserMaster user
        Branch branch
	GlAccount glAccount
	GlBatchHdr glBatchHdrId
    static constraints = {
        
        glBatchHdrId nullable: true
        glAccount nullable: true
        branch nullable: true
        user nullable: true
        txnValueDate nullable: true
        batchParticulars nullable: true
        glBatchLine nullable: true
        outstandingBal nullable: true, scale:2
        creditBal nullable: true, scale:2
        debitBal nullable: true, scale:2
        creditAmt nullable: true, scale:2
        debitAmt nullable: true, scale:2
        glAccountCode nullable: true
        batchId nullable: true
        txnDate nullable: true
    }
    
    static mapping = {
        id sqlType:'int', generator:'increment'
    }
}
