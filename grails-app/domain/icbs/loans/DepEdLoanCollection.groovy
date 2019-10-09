package icbs.loans
import icbs.loans.Loan
import icbs.cif.Customer
import icbs.loans.DepEdLoanRemDet
import icbs.admin.Branch

class DepEdLoanCollection {
    String batchSerial
    DepEdLoanRemDet depEdLoanRemDet
    Loan loan
    Branch branch
    Customer customer
    Double paymentAmt
    
    static constraints = {
        batchSerial nullable:false
        depEdLoanRemDet nullable:false
        loan nullable:false
        branch nullable:false
        customer nullable:false
        paymentAmt nullable:true, min:0d, scale:2
    }
}
