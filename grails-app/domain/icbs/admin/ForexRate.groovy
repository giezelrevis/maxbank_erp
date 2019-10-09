package icbs.admin

import icbs.lov.ConfigItemStatus
import icbs.admin.Currency

class ForexRate {
    	Currency currency
        Currency currency2
    String date
    Date txnDate
	BigDecimal rate
	BigDecimal refRate
    BigDecimal historicalRate
    BigDecimal pdsRate
	BigDecimal buyRate1
	BigDecimal buyRate2
	BigDecimal buyRate3
	BigDecimal buyRate4
	BigDecimal buyRate5
	BigDecimal sellRate1
	BigDecimal sellRate2
	BigDecimal sellRate3
	BigDecimal sellRate4
	BigDecimal sellRate5
	ConfigItemStatus configItemStatus
    UserMaster lastUpdatedBy
    Integer tag


    static constraints = {
    	currency nullable:false
        currency2 nullable:false
        date blank:true, nullable:false
    	rate nullable:false, min:0.00, scale: 5
    	refRate nullable:true, min:0.00, scale: 5
        historicalRate nullable:false, min:0.00, scale: 5
        pdsRate nullable:false, min:0.00, scale: 5       
    	buyRate1 nullable:true, min:0.00, scale: 5
    	buyRate2 nullable:true, min:0.00, scale: 5
    	buyRate3 nullable:true, min:0.00, scale: 5
    	buyRate4 nullable:true, min:0.00, scale: 5
    	buyRate5 nullable:true, min:0.00, scale: 5
    	sellRate1 nullable:true, min:0.00, scale: 5
    	sellRate2 nullable:true, min:0.00, scale: 5
    	sellRate3 nullable:true, min:0.00, scale: 5
    	sellRate4 nullable:true, min:0.00, scale: 5
    	sellRate5 nullable:true, min:0.00, scale: 5
        lastUpdatedBy nullable:true
        txnDate nullable:true
        configItemStatus nullable:true
        tag nullable:true
    }

    static mapping = {
        id sqlType:'int', generator:'increment'
    	currency sqlType:'smallint'
        currency2 sqlType:'smallint'
    	configItemStatus sqlType:'smallint'
    }
    
    def beforeInsert(){
 
    }
}
