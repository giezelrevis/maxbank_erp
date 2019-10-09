package icbs.loans
import icbs.lov.LoanInstallmentFreq
import icbs.lov.LoanGuaranteeFacility
import icbs.loans.LoanApplication
class LoanApplicationSpecAdditional {
    
    LoanApplication loanApplication
    Double interestRate
    Double serviceCharge
    LoanInstallmentFreq frequency
    LoanGuaranteeFacility guaranteeFacility
    String preRelease
    String comments

    static constraints = {
        loanApplication nullable:true
        interestRate nullable:true
        serviceCharge nullable:true
        frequency nullable:true
        guaranteeFacility nullable:true
        preRelease nullable:true
        comments nullable:true        
    }
    static mapping = {
        id sqlType: "int", generator: "increment"
    }    
}
