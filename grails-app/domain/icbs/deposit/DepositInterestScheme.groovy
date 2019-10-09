package icbs.deposit

import icbs.lov.ConfigItemStatus
import icbs.lov.DepositCapitalizationFreq
import icbs.lov.DepositInterestCalculation
import icbs.lov.DepositInterestStart
import icbs.admin.Product
class DepositInterestScheme {
    String code
    String name
    Double interestRate
    Double fdPostMaturityRate
    Integer divisor
    Double minInterestRate
    Double maxInterestRate
    Double minBalanceToEarnInterest
    boolean canChangeInterestRate
    boolean isAccrual
    boolean isGraduated
    Boolean interestOnClosing
    boolean fdMonthlyTransfer
    //huh?
    DepositCapitalizationFreq depositCapitalizationFreq
    //deposit interestcalculation
    DepositInterestCalculation depositInterestCalculation //hmm
    DepositInterestStart depositInterestStart
    //status
    ConfigItemStatus status
    List graduateds =  [].withLazyDefault {new DepositInterestSchemeGraduated()}
    static belongsTo = [Product]
    static hasMany = [products: Product,graduateds:DepositInterestSchemeGraduated]
    static constraints = {
        code maxSize: 10, unique: true, nullable: false, blank: false
    	name maxSize: 50, unique: true, nullable: false, blank: false
        interestRate scale: 5, nullable: false, min: 0d
        divisor nullable: false, blank: false, min: 0
    	minInterestRate scale: 5, nullable: false, blank: false, min: 0d
    	maxInterestRate scale: 5, nullable: false, blank: false, min: 0d
        fdPostMaturityRate scale: 5, nullable: true, blank: false, min: 0d
        minBalanceToEarnInterest nullable:false, min: 0d, scale: 2
        canChangeInterestRate nullable: false
        isAccrual nullable: false
	depositCapitalizationFreq nullable: false
    	depositInterestCalculation nullable:false
        status nullable:true
        graduateds nullable:true
        depositInterestStart nullable:true
        interestOnClosing nullable:true
        fdMonthlyTransfer nullable:true
    }
    static mapping = {
        graduateds cascade:"all-delete-orphan"
    	id sqlType: "int", generator: "increment"
    	divisor sqlType: "smallint"
        status sqlType: "smallint"
        products joinTable: [name:'deposit_interest_scheme_product', key:'deposit_interest_scheme_id']
    }
    def beforeUpdate(){
     
    }
    def beforeInsert(){
        //set to pending 
        this.status = ConfigItemStatus.read(2);
    }
    String toString(){
        return this.code+":"+this.name
    }
}
