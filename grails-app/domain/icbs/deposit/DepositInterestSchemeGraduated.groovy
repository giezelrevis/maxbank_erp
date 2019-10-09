package icbs.deposit

import icbs.lov.ConfigItemStatus

class DepositInterestSchemeGraduated {
    static belongsTo=[depositInterestScheme:DepositInterestScheme]
    //String name
    //String code
    //String description
    Double startBal
    Double endBal
    Double interestRate
    ConfigItemStatus status
    static constraints = {
        depositInterestScheme nullable:false
       // code maxSize: 10, unique: true, nullable: false, blank: false
       //description maxSize:255, nullable:true
        startBal nullable:false, min: 0d, scale: 2
        endBal nullable:false, min: 0d, scale: 2
        interestRate scale: 5, nullable: false, blank: false, min: 0d 
        status nullable:true
        deleted bindable:true
    }
    static mapping = {
    	id sqlType: "int", generator: "increment"
        status sqlType: "smallint"
    }
    def beforeUpdate(){

    }
    def beforeInsert(){
        //set as pending
        this.status = ConfigItemStatus.read(2)  
    }
    boolean deleted
    static transients = ['deleted']
}

