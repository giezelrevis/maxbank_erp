package icbs.cif

import icbs.lov.ConfigItemStatus

class ExtendedInfo {
    //customer id
    static belongsTo = [customer:Customer]
    Code code
    String value
    ConfigItemStatus status 
    String hash
    static constraints = {
        status nullable:true
        code nullable:true
        hash nullable:true
        value nullable:true
    }
    static mapping = {
        id sqlType: "int", generator: "increment"
        value sqlType: "varchar"
        hash sqlType: "varchar"
    }
    def beforeInsert(){
        this.status = ConfigItemStatus.get(2)
    }
}
