package icbs.periodicops

import icbs.deposit.Rollover
import icbs.tellering.TxnDepositAcctLedger

class DailyTimeDepositRollover {
    Date processDate
    Rollover oldRollover
    Rollover newRollover
    TxnDepositAcctLedger interest
    TxnDepositAcctLedger tax
    TxnDepositAcctLedger transferDepositDr
    TxnDepositAcctLedger transferDepositCr
    
    static constraints = {
        newRollover nullable:true
        interest nullable:true
        tax nullable:true
        transferDepositDr nullable:true
        transferDepositCr nullable:true
    }
    
    static mapping = {
	id sqlType:'int', generator:'increment'
	processDate sqlType:'date'
    }     
}
