package icbs.deposit

import icbs.lov.ConfigItemStatus
import icbs.lov.FdPreTerminationType
import icbs.admin.Product
class FixedDepositPreTermScheme {
    String code
    String name
    String description
    FdPreTerminationType type//mali values
    Double rate
    boolean isGradeRate
    Double term1stHalf
    Double term2ndHalf
    Integer divisor
    ConfigItemStatus status
    static belongsTo = [Product]
    static hasMany = [products: Product]
    static constraints = {
        products nullable:true
        code maxSize: 10, unique: true, nullable: false, blank: false
        name maxSize: 50, unique: true, nullable: false, blank: false
        description maxSize: 255, unique: true, nullable: true, blank: true
        type nullable:false
        rate nullable:false, min: 0d, scale: 5
        term1stHalf nullable:false, min: 0d, scale: 0
        term2ndHalf nullable:false, min: 0d, scale: 0
        divisor nullable: false, blank: false, min: 0
        status nullable:true
    }
    static mapping = {
    	id sqlType: "int", generator: "increment"
    	divisor sqlType: "smallint"
        status sqlType: "smallint"
        products joinTable: [name:'fixed_deposit_pre_term_scheme_product', key:'fixed_deposit_pre_term_scheme_id']
    }
    def beforeInsert(){
        //set status as pending
        this.status = ConfigItemStatus.read(2)
    }
    def beforeUpdate(){
      
    }
    String toString(){
        return this.code+":"+this.name
    }
}
