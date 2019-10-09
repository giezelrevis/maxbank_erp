package icbs.loans

import icbs.cif.Customer
import icbs.loans.Loan
import icbs.admin.Branch
import icbs.gl.GlBatch

class DepEdLoanRemDet {
    
    Customer customer
    String batchSerial
    Double remAmount
    
    static constraints = {

        customer nullable:true
        batchSerial nullable:true
        remAmount nullable:true
    
    }
    
    static mapping = {
        id sqlType:'int', generator:'increment'
    }
}
