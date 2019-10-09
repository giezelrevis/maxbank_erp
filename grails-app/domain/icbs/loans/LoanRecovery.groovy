package icbs.loans

import icbs.deposit.Deposit
import icbs.admin.UserMaster
import icbs.lov.SweepType
import icbs.lov.SweepRule
import icbs.lov.SweepStatus
import icbs.loans.Loan

class LoanRecovery {
    Deposit depositAccount
    SweepType type
    SweepRule rule
    Double fundLimitAmt
    Double fundLimitPercentage
    
    String remarks
    SweepStatus status
    Loan fundedLoan
    Date dateCreated
    UserMaster createdBy

    static constraints = {
        depositAccount nullable:false
        type nullable:false
        rule nullable:false
        fundLimitAmt nullable:true, min: 0d, scale:2
        fundLimitPercentage nullable:true, min: 0d, scale:5
        remarks nullable:true
        status nullable:true
        fundedLoan nullable:true
        dateCreated nullable:true
        createdBy nullable:true
    }

    static mapping = {
    	id sqlType: "int", generator: "increment"
    }   
}
