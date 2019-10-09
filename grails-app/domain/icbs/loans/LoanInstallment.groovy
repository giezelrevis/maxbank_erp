package icbs.loans

import icbs.lov.LoanInstallmentType
import icbs.lov.LoanInstallmentStatus

class LoanInstallment {
	Integer sequenceNo
	Date installmentDate

	Double principalInstallmentAmount
	Double normalInterestInstallmentAmount
	Double interestInstallmentAmount	
	Double totalInstallmentAmount
	Double pastDueInterestInstallmentAmount
	Double penaltyInstallmentAmount
	Double pastDuePenaltyInstallmentAmount
	Double serviceChargeInstallmentAmount
	Double taxInstallmentAmount

	Double principalInstallmentPaid
	Double interestInstallmentPaid
	Double pastDueInterestInstallmentPaid
	Double penaltyInstallmentPaid
	Double pastDuePenaltyInstallmentPaid
	Double serviceChargeInstallmentPaid
	Double taxInstallmentPaid

	LoanInstallmentType type
	LoanInstallmentStatus status
	Date datePaid

	

    static constraints = {
    	sequenceNo nullable:true
		installmentDate nullable:true

		principalInstallmentAmount nullable:true, scale:2		
		normalInterestInstallmentAmount nullable:true, scale:2
		interestInstallmentAmount nullable:true, scale:2		
		totalInstallmentAmount nullable:true, scale:2
		pastDueInterestInstallmentAmount nullable:true, scale:2
		penaltyInstallmentAmount nullable:true, scale:2
		pastDuePenaltyInstallmentAmount nullable:true, scale:2
		serviceChargeInstallmentAmount nullable:true, scale:2
		taxInstallmentAmount nullable:true, scale:2

		principalInstallmentPaid nullable:true, scale:2
		interestInstallmentPaid nullable:true, scale:2
		pastDueInterestInstallmentPaid nullable:true, scale:2
		penaltyInstallmentPaid nullable:true, scale:2
		pastDuePenaltyInstallmentPaid nullable:true, scale:2
		serviceChargeInstallmentPaid nullable:true, scale:2
		taxInstallmentPaid nullable:true, scale:2

		type nullable:true
		status nullable:true		
		datePaid nullable:true
    }

    static mapping = {
		id sqlType: "int", generator: "increment"	
		type sqlType: "smallint"
		status sqlType: "smallint"
	}

	/*def beforeInsert() {
		this.normalInterestInstallmentAmount = this?.interestInstallmentAmount 
		this.penaltyInstallmentAmount = 0
		this.pastDueInterestInstallmentAmount = 0
		this.pastDuePenaltyInstallmentAmount = 0
		this.taxInstallmentAmount = 0


		this.principalInstallmentPaid = 0	
		this.interestInstallmentPaid = 0
		this.pastDueInterestInstallmentPaid = 0
		this.penaltyInstallmentPaid = 0
		this.pastDuePenaltyInstallmentPaid = 0
		this.serviceChargeInstallmentPaid = 0
		this.taxInstallmentPaid = 0

		this.status = LoanInstallmentStatus.get(1)
	}*/
}