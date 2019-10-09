package icbs.deposit

import icbs.lov.InterestPaymentMode
import icbs.lov.RolloverStatus
import icbs.lov.RolloverType

class Rollover {
    static belongsTo=[deposit:Deposit]
    //int rolloverSequence lipat to deposit
    Date startDate
    Date endDate
    RolloverType type
    Double principalAmt
    Double normalInterestAmt
    Double preTermInterestAmt
    Double taxAmt1
    Double taxAmt2
    Double taxAmt3
    CTD ctd
    RolloverStatus status
    InterestPaymentMode interestPaymentMode
    Deposit fundedDeposit
    //txn id
    Double postMaturityInterestRate
    
    static constraints = {
        //rolloverSequence nullable:true

        startDate nullable:false
        endDate nullable:false
        type nullable:false
        principalAmt nullable:true, scale: 2
        normalInterestAmt nullable:true, scale: 2
        preTermInterestAmt nullable:true, scale: 2
        taxAmt1 nullable:true, scale: 2
        taxAmt2 nullable:true, scale: 2
        taxAmt3 nullable:true, scale: 2
        ctd nullable:true
        status nullable:true
        fundedDeposit nullable:true
        interestPaymentMode nullable:false
        postMaturityInterestRate nullable:true, scale: 5
    }
    static mapping = {
        id sqlType: "int", generator: "increment"
        deposit column: 'deposit', insertable: false, updateable: false
    }
    def beforeInsert(){
        this.status = RolloverStatus.get(1)  
        if (!this.taxAmt1) {
            this.taxAmt1 = 0.00D
        }
        if (!this.taxAmt2) {
            this.taxAmt2 = 0.00D
        }        
        if (!this.taxAmt3) {
            this.taxAmt1 = 0.00D
        } 
        if (!this.normalInterestAmt) {
            this.normalInterestAmt = 0.00D
        }
        if (!this.preTermInterestAmt) {
            this.preTermInterestAmt = 0.00D
        }
    }
    def beforeUpdate(){
        if (this.interestPaymentMode != InterestPaymentMode.read(2)) {
            if (!this.fundedDeposit) {
                this.fundedDeposit = null
            }          
        }
    }
}
