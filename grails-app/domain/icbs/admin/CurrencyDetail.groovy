package icbs.admin



class CurrencyDetail {
    Currency currency
    Integer index
    String shortdescription
    String longdescription
    BigDecimal currencyvalue
    
    static constraints = {
        currency nullable:false
        index nullable:false
        shortdescription nullable:false
        longdescription nullable:true
        currencyvalue nullable:false, min:0.00, scale: 2
    }
    static mapping = {
        
        id sqlType:'int', generator:'increment'
    	currency sqlType:'smallint'
    }
    
    def beforeInsert() {
  
    }
    def beforeUpdate() {
        
    }
}
