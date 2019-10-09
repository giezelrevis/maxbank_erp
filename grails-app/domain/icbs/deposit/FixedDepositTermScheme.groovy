package icbs.deposit

import icbs.lov.ConfigItemStatus
import icbs.admin.Product
class FixedDepositTermScheme {
    String code
    String name
    String description
    double value
    double termMin//days
    double termMax//days
    ConfigItemStatus status
    static belongsTo = [Product]
    static hasMany = [products: Product]
    static constraints = {
        code maxSize: 10, unique: true, nullable: false, blank: false
        name maxSize: 50, unique: true, nullable: false, blank: false
        description maxSize: 255, unique: true, nullable: true, blank: true
        value maxSize:50, nullable:false, min: 0d , scale: 0
        termMin scale:0,nullable:false, min: 0d
        termMax scale:0,nullable:false, min: 0d
        status nullable:true
    }
    static mapping = {
    	id sqlType: "int", generator: "increment"
        status sqlType: "smallint"
        products joinTable: [name:'fixed_deposit_term_scheme_product', key:'fixed_deposit_term_scheme_id']
    }
    def beforeInsert(){
        //pending status
        this.status = ConfigItemStatus.read(2)
    }
    def beforeUpdate(){
      
    }
    String toString(){
        return this.code+":"+this.name
    }
}
