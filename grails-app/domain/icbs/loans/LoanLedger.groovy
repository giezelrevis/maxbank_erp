package icbs.loans

import icbs.lov.MemoTxnType
import icbs.admin.TxnTemplate
import icbs.deposit.Deposit
import icbs.tellering.TxnFile

class LoanLedger {
	// disbursement - debit
	// payment - credit
	Loan loan	
	Deposit deposit
	MemoTxnType txnType
	TxnTemplate txnTemplate
	Date txnDate
 	String txnRef
        String txnCode
	String txnParticulars
	Double principalDebit
	Double principalCredit
	Double principalBalance  // initial value is other charges, then add total net proceeds
	Double interestDebit
	Double interestCredit	
	Double interestBalance
	Double penaltyDebit	
	Double penaltyCredit	
	Double penaltyBalance
	Double chargesDebit	
	Double chargesCredit
	Double chargesBalance
        TxnFile txnFile
       // Double totalDeductions //total deduction amount

	static constraints = {
		loan nullable:false
		deposit nullable:true
		txnType nullable:true
		txnTemplate nullable:false
		txnDate	nullable:false
		txnRef nullable:false
		txnParticulars nullable:true
		principalDebit nullable:true, scale:2, min:0d
		principalCredit nullable:true, scale:2, min:0d
		principalBalance nullable:true, scale:2, min:0d
		interestDebit nullable:true, scale:2, min:0d
		interestCredit nullable:true, scale:2, min:0d
		interestBalance nullable:true, scale:2
		penaltyDebit nullable:true, scale:2, min:0d
		penaltyCredit nullable:true, scale:2, min:0d
		penaltyBalance nullable:true, scale:2
		chargesDebit nullable:true, scale:2, min:0d
		chargesCredit nullable:true, scale:2, min:0d
		chargesBalance nullable:true, scale:2
                txnCode nullable:true
                txnFile nullable:true
               // totalDeductions nullable:true
	}

	static mapping = {
		id sqlType: "int", generator: "increment"
	}

	def beforeInsert() {  
        this.principalDebit = this.principalDebit ?: 0
		this.principalCredit = this.principalCredit ?: 0
		this.principalBalance = this.principalBalance ?: 0
		this.interestDebit = this.interestDebit ?: 0
		this.interestCredit = this.interestCredit ?: 0
		this.interestBalance = this.interestBalance ?: 0
		this.penaltyDebit = this.penaltyDebit ?: 0
		this.penaltyCredit = this.penaltyCredit ?: 0
		this.penaltyBalance = this.penaltyBalance ?: 0
		this.chargesDebit = this.chargesDebit ?: 0
		this.chargesCredit = this.chargesCredit ?: 0
		this.chargesBalance = this.chargesBalance ?: 0
    }
}