package icbs.periodicops
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
import icbs.loans.LoanSpecial
import icbs.loans.InterestIncomeScheme
import icbs.loans.LoanApplication
import icbs.loans.PenaltyIncomeScheme

class MonthlyPointerLoan {
    Date refDate
    LoanApplication loanApplication

    // general info
    String accountNo
    String pnNo
    OwnershipType ownershipType  // input
    Customer customer  // input
    Product product	 // input
    Branch branch  // auto (taken from user)
    Currency currency  // auto (taken from product)   
    Lov security
    
    // schemes
    InterestIncomeScheme interestIncomeScheme // input
    PenaltyIncomeScheme currentPenaltyScheme  // input
    PenaltyIncomeScheme pastDuePenaltyScheme  // input
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

    // tellering
    Double balanceAmount // updated during opening and payments      
    Double totalDisbursementAmount  // generated (start 0, will accumulate for every disbursement from tellering)        
    Integer lastTransactionNo // auto (id of last transaction)
    Integer transactionSequenceNo // generated (start 0, increment for every transaction made)
    Date lastTransactionDate  // auto
    Date lastCustormerTransactionDate  // auto

    // start of day and tellering
    Double overduePrincipalBalance // updated during SOD, sum of unpaid installments
    Double normalInterestAmount // generated (start 0, add interest when due is reached, will be equal to total installment amount once maturity is reached)
    Double interestBalanceAmount // generated (start 0, add interest when due is reached, payments are deducted, can be negative)
    Double penaltyBalanceAmount // generated (start 0, add penalties when due, payments are deducted)
    // penaltyBalanceAmount = penaltyBalanceAmount + ((overdue principal * penalty Rate) /divisor))
    // if overdue principal is less than or equal to zero, no penalty will be computed
    Double serviceChargeBalanceAmount  // generated (start 0, add service charges when due, payments are deducted)    
    Double taxBalanceAmount  // 0 (no tax loan)    
    Double accruedInterestAmount  // generated  (principal [the current after maturity] * interest [the current after maturity]) / divisor
    //Double totalDeductions //total deduction amount
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

    static constraints = {
        refDate nullable:true
        loanApplication nullable:true

        accountNo nullable:true
        pnNo nullable:true
        ownershipType nullable:true
        customer nullable:true
        product nullable:true
        branch nullable:true
        currency nullable:true
        security nullable:true
    
        interestIncomeScheme nullable:true
        currentPenaltyScheme  nullable:true
        pastDuePenaltyScheme  nullable:true
        // loan specifications
        interestRate  nullable:true
        penaltyRate  nullable:true
        penaltyAmount  nullable:true
        serviceCharge nullable:true
        grantedAmount  nullable:true
        term  nullable:true
        frequency  nullable:true
        numInstallments  nullable:true
        balloonInstallments nullable:true
        applicationDate  nullable:true
        openingDate  nullable:true
        interestStartDate nullable:true
        firstInstallmentDate nullable:true
        // generated from installment schedule
        maturityDate nullable:true
        effectiveInterestRate nullable:true
        monthlyInterestRate nullable:true
        totalNetProceeds  nullable:true

        // tellering
        balanceAmount nullable:true
        totalDisbursementAmount  nullable:true
        lastTransactionNo nullable:true
        transactionSequenceNo nullable:true
        lastTransactionDate  nullable:true
        lastCustormerTransactionDate  nullable:true

        // start of day and tellering
        overduePrincipalBalance nullable:true
        normalInterestAmount nullable:true
        interestBalanceAmount nullable:true
        penaltyBalanceAmount nullable:true
        serviceChargeBalanceAmount  nullable:true    
        taxBalanceAmount  nullable:true    
        accruedInterestAmount  nullable:true
        // advance interests
        advInterest nullable:true
        advInterestDays nullable:true
        advInterestPeriods nullable:true

        // control interest accrual
        hasInterestAccrual  nullable:true
        accruedInterestDate  nullable:true
        
        // misc
        special  nullable:true
        performanceClassification  nullable:true
        status  nullable:true
        statusChangedDate  nullable:true
        approvedBy  nullable:true
        dateApproved  nullable:true
        glLink nullable:true
        prevGLLink nullable:true
        loanType nullable:true
        loanProject nullable:true
        loanKindOfLoan nullable:true
        loanProvision nullable:true
        loanPerformanceId nullable:true
        loanSecurity nullable:true

        ageInArrears nullable:true
        loanProvisionBsp nullable:true
    }
    
    static mapping = {
		id sqlType: "int", generator: "increment"
    }
}
