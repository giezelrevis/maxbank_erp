package icbs.periodicops
import icbs.deposit.Deposit
import icbs.tellering.TxnFile

class MonthlyDepositInterest {
    Date    refDate
    Deposit deposit
    TxnFile interest
    TxnFile tax
    
    static constraints = {
        deposit nullable:true
        interest nullable:true
        tax nullable:true
    }
    
    static mapping = {
		id sqlType: "int", generator: "increment"
    }    
}
