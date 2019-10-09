package icbs.deposit

import icbs.deposit.DepositInterestScheme
import icbs.admin.UserMaster

class DepositInterestSchemeIntRateHist {

    DepositInterestScheme depositInterestScheme
    Date refDate
    Double oldInterestRate
    Double newInterestRate
    UserMaster user

    static constraints = {
        depositInterestScheme nullable:false
        refDate nullable:false
        user nullable:false
        oldInterestRate scale: 5, nullable: false, min: 0d
        newInterestRate scale: 5, nullable: false, min: 0d
    }
    static mapping = {
    	id sqlType: "int", generator: "increment"
    }
}
