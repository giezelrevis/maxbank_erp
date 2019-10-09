package icbs.periodicops
import icbs.deposit.Deposit
import icbs.tellering.TxnFile

class MonthlyDepositCharges {
    Date    refDate
    Deposit deposit
    TxnFile charges
    Integer chargeType // 1 is charge, 2 is fees
    
    static constraints = {
        refDate nullable:true
        deposit nullable:true
        charges nullable:true
        chargeType nullable:true
    }
    static mapping = {
		id sqlType: "int", generator: "increment"
    }
    
}
