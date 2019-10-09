package icbs.tellering

import icbs.admin.Branch
import icbs.loans.Loan
import icbs.admin.UserMaster
import icbs.admin.Currency

class TxnLoanPaymentDetails {

    Branch branch
    static belongsTo=[user:UserMaster];
    Loan acct
    String acctNo
    String txnRef
    Double paymentAmt
    Double principalAmt
    Double interestAmt
    Double pastDueInterestAmt
    Double penaltyAmt
    Double serviceChargeAmt
    Double grtAmt
    Double otherAmt
    Double totalNetProceeds
    Double interestBalAfterPayment
    Double penaltyBalAfterPayment
    Double balForwarded
    Double principalBalAfterPayment
    Date txnDate
    Currency currency
    TxnFile txnFile
    static hasMany=[checks:TxnCOCI]
    
    static constraints = {
        branch nullable:true
        acct nullable:true
        acctNo nullable:true
        user nullable:true
        txnRef nullable:false
        paymentAmt nullable:true, min:0d, scale:2
        principalAmt nullable:true, min:0d, scale:2
        interestAmt nullable:true, min:0d, scale:2
        pastDueInterestAmt nullable:true, min:0d, scale:2
        penaltyAmt nullable:true, min:0d, scale:2
        serviceChargeAmt nullable:true, min:0d, scale:2
        grtAmt nullable:true, min:0d, scale:2
        otherAmt nullable:true, min:0d, scale:2
        totalNetProceeds nullable:true, min:0d, scale:2
        interestBalAfterPayment nullable:true, scale:2
        penaltyBalAfterPayment nullable:true, scale:2
        balForwarded nullable:true, min:0d, scale:2
        principalBalAfterPayment nullable:true, min:0d, scale:2
        txnDate nullable:true
        currency nullable:true
        txnFile nullable:true
        checks nullable:true
    }
    
    static mapping = {
        id sqlType: 'int', generator: 'increment'
        txnRef sqlType: 'varchar'
    }
}
