package icbs.cif

import icbs.lov.ConfigItemStatus
import icbs.lov.Lov
/*Lookup Table*/
class Code {
    //type
    Lov type
    String value
    ConfigItemStatus status
    String hash
    
    static constraints = {
        status nullable:true
        type nullable:true
        value nullable:false,maxSize:50
        hash nullable:true
    }
    static mapping = {
        id sqlType: "int", generator: "increment"
        hash sqlType: "varchar"
    }
    def beforeInsert(){
        this.status = ConfigItemStatus.get(2)
    }
}
