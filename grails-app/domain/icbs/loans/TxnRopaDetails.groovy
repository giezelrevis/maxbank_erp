package icbs.loans
import icbs.tellering.TxnFile
import icbs.loans.Collateral

class TxnRopaDetails {
    TxnFile txnFile
    Collateral collateral
    String modeOfForeclosure
    Date dateBooked
    Date dateAcquired
    Date dateRegistered
    Date dateNotarized
    Date dateConsolidated
    Date expiryOfRedemption
    String particulars
    
    static constraints = {
        collateral nullable:true
        modeOfForeclosure nullable:true
        dateBooked nullable:true
        dateAcquired nullable:true
        dateRegistered nullable:true
        dateNotarized nullable:true
        dateConsolidated nullable:true
        expiryOfRedemption nullable:true
        particulars nullable:true, maxSize: 250
    }
    
    static mapping = {
        id sqlType: "int", generator: "increment"
    }
}
