package icbs.loans

import icbs.cif.Customer
import icbs.admin.Product
import icbs.admin.Branch
import icbs.admin.Currency
import icbs.admin.UserMaster
import icbs.gl.GlLink
import icbs.gl.CfgAcctGlTemplate
import icbs.lov.LoanAcctStatus
import icbs.lov.LoanInstallmentFreq
import icbs.lov.OwnershipType
import icbs.lov.LoanPerformanceClassification
import icbs.lov.LoanType
import icbs.lov.LoanProject
import icbs.lov.LoanProvision
import icbs.lov.LoanPerformanceId
import icbs.lov.LoanSecurity
import icbs.lov.Lov
import icbs.lov.LoanProvisionBsp
import icbs.lov.LoanKindOfLoan

class LoanHistory {
    LoanApplication loanApplication

    // general info
    Integer loanId
	String accountNo
    String pnNo
 	OwnershipType ownershipType  // input
	Customer customer  // input
	Product product	 // input
	Branch branch  // auto (taken from user)
	Currency currency  // auto (taken from product)   
        Lov security
    // schemes
	InterestIncomeScheme interestIncomeScheme  // input
	PenaltyIncomeScheme currentPenaltyScheme  // input
	PenaltyIncomeScheme pastDuePenaltyScheme  // input
    //LoanPerformanceClassificationScheme performanceClassificationScheme1  // input
    //LoanPerformanceClassificationScheme performanceClassificationScheme2  // input
    //LoanPerformanceClassificationScheme performanceClassificationScheme3  // input
    //LoanPerformanceClassificationScheme performanceClassificationScheme4  // input

    // loan specifications
	Double interestRate  // input (initial value from interest income scheme)
    Double penaltyRate  // input (initial value from penalty income scheme)
    Double penaltyAmount  // input (initial value from penalty income scheme)
    Double serviceCharge // input (for manual service charge only, otherwise this is 0)
    Double grantedAmount  // input
    Integer term  // input (added field)
    LoanInstallmentFreq frequency  // input (added field)
    Integer numInstallments  // input (added field)
    Integer balloonInstallments // input (added field)
    Date applicationDate  // input
    Date openingDate  // input
    Date interestStartDate
    Date firstInstallmentDate
    
    // generated from installment schedule
    Date maturityDate  // generated
	Double effectiveInterestRate // generated
	Double monthlyInterestRate // generated    
    Double totalNetProceeds  // generated (loan amount - loan deductions)
    Double overduePrincipalBalance
    // tellering
    Double totalDisbursementAmount  // generated (start 0, will accumulate for every disbursement from tellering)        
    Integer lastTransactionNo // auto (id of last transaction)
    Integer transactionSequenceNo // generated (start 0, increment for every transaction made)
    Date lastTransactionDate  // auto
    Date lastCustormerTransactionDate  // auto

    // start of day and tellering
    Double balanceAmount // generated (start 0, add principal when due is reached, payments are deducted, can be negative)
    Double normalInterestAmount // generated (start 0, add interest when due is reached, will be equal to total installment amount once maturity is reached)
    Double interestBalanceAmount // generated (start 0, add interest when due is reached, payments are deducted, can be negative)
    Double penaltyBalanceAmount // generated (start 0, add penalties when due, payments are deducted)
    // penaltyBalanceAmount = penaltyBalanceAmount + ((overdue principal * penalty Rate) /divisor))
    // if overdue principal is less than or equal to zero, no penalty will be computed
    Double serviceChargeBalanceAmount  // generated (start 0, add service charges when due, payments are deducted)    
    Double taxBalanceAmount  // 0 (no tax loan)    
    Double accruedInterestAmount  // generated  (principal [the current after maturity] * interest [the current after maturity]) / divisor

     // advance interests
    Double advInterest
    Integer advInterestDays
    Integer advInterestPeriods

    // control interest accrual
    boolean hasInterestAccrual  // input (initial value from interest income scheme)
    Date accruedInterestDate  // auto
        
    // misc
    LoanSpecial special  // input
    LoanPerformanceClassification performanceClassification  // auto
	LoanAcctStatus status  // auto
	Date statusChangedDate  // auto
	UserMaster approvedBy  // auto
	Date dateApproved  // auto
	/*GlLink glLink  // input
	GlLink prevGLLink  // auto    */
    CfgAcctGlTemplate glLink
    CfgAcctGlTemplate prevGLLink
    LoanType loanType
    LoanProject loanProject
    LoanKindOfLoan loanKindOfLoan
    LoanProvision loanProvision
    LoanPerformanceId loanPerformanceId
    LoanSecurity loanSecurity
    String hash  // auto
    Integer ageInArrears
    LoanProvisionBsp loanProvisionBsp

    String activity
    Date dateModified
	    	    
	static hasMany = [loanInstallments: LoanInstallment, 
                      serviceCharges: ServiceCharge, 
                      loanDeductions: LoanDeduction,
                      loanEIRSchedules: LoanEIRSchedule,
                      sweepAccounts: LoanSweep]

    static constraints = {  
        loanApplication nullable:false
        
  		accountNo nullable:true
        pnNo nullable:true
 		ownershipType nullable:false
		customer nullable:false
		product nullable:false
		branch nullable:false
		currency nullable:false
                security nullable:true
		interestIncomeScheme nullable:false
		currentPenaltyScheme nullable:false
		pastDuePenaltyScheme nullable:false
        //performanceClassificationScheme1 nullable:false
        //performanceClassificationScheme2 nullable:false
        //performanceClassificationScheme3 nullable:false
        //performanceClassificationScheme4 nullable:false
        overduePrincipalBalance nullable:true
        interestRate nullable:false
        penaltyRate nullable:false
        penaltyAmount nullable:false
        serviceCharge nullable:true
        grantedAmount nullable:false        
        term nullable:false
        frequency nullable:true
        numInstallments nullable:false
        balloonInstallments nullable:true        
        applicationDate nullable:false
        openingDate nullable:false
        firstInstallmentDate nullable:true
        interestStartDate nullable:true

        maturityDate nullable:true
        effectiveInterestRate nullable:true
        monthlyInterestRate nullable:true
        totalNetProceeds  nullable:true
        ageInArrears nullable:true
        loanProvisionBsp nullable:true
        totalDisbursementAmount nullable:true        
        lastTransactionNo nullable:true
        transactionSequenceNo nullable:true
        lastTransactionDate nullable:true
        lastCustormerTransactionDate nullable:true
		
        balanceAmount nullable:true
		normalInterestAmount nullable:true
        interestBalanceAmount nullable:true
        penaltyBalanceAmount nullable:true
        serviceChargeBalanceAmount nullable:true
        taxBalanceAmount nullable:true
        accruedInterestAmount nullable:true

        advInterest nullable:true
        advInterestDays nullable:false
        advInterestPeriods nullable:false

        hasInterestAccrual nullable:false
        accruedInterestDate nullable:true

        special nullable:true
        performanceClassification nullable:true
        status nullable:true
        statusChangedDate nullable:true
        approvedBy nullable:true
        dateApproved nullable:true
        glLink nullable:true
        prevGLLink nullable:true
        loanType nullable:true
        loanProject nullable:true
        loanKindOfLoan nullable:true
        loanProvision nullable:true
        loanPerformanceId nullable:true
        loanSecurity nullable:true
        hash nullable:true

        activity nullable:false
        dateModified nullable:false
    }
    
    static mapping = {
        id sqlType:'int', generator:'increment'
    }
}	