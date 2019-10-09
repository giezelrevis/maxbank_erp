package icbs.loans
import icbs.cif.Customer

class LoanRenewal {
    Customer customer
    Loan oldLoan
    Double oldLoanAmount
    Loan newLoan
    Double newLoanAmount
    Boolean renewalCompleted
    
    static constraints = {
        customer nullable:false
        oldLoan nullable:false
        newLoan nullable:false
        renewalCompleted nullable:true
        oldLoanAmount nullable:true, min:0d, scale:2
        newLoanAmount nullable:true, min:0d, scale:2
    }
    
    static mapping = {
	id sqlType: "int", generator: "increment"
    }    
}
