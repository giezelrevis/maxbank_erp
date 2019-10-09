package icbs.deposit

import icbs.admin.UserMaster
import icbs.lov.HoldStatus
import icbs.lov.HoldType
import icbs.admin.Branch

class Hold {
    static belongsTo = [deposit:Deposit]
    Date holdDate
    UserMaster heldBy
    HoldType type
    Date maturityDate
    Double amt
    Double percent
    //txn id
    String remarks
    
    HoldStatus status
    static mapping = {
    	id sqlType: "int", generator: "increment"
    }
    static constraints = {
        deposit nullable:false
        holdDate nullable:true
        heldBy nullable:true
        type nullable:false
        maturityDate nullable:false
        amt nullable:true, min:0d, scale: 2, validator:{
            val,obj,errors->
            if(!val&&obj.type?.id==1){
                  errors.rejectValue('amt', 'amount Cannot be null')
            }
            //if(obj?.deposit&&obj.type?.id==1){
            //    if(obj.deposit.availableBalAmt<val && obj?.status.id<=2){
            //        errors.rejectValue('amt', 'Amount exceeds available balance of Account No:'+obj.deposit.acctNo + ' >> ' + obj.deposit.availableBalAmt)
            //    }
            //}
        }//, min:0D
        percent nullable:true, min: 0d, scale: 5, validator:{
            val,obj,errors->
            if(!val&&obj.type?.id!=1){
                  errors.rejectValue('percent', 'Percent Cannot be null')
            }
        }//,max:100D,min:0D
        
        remarks nullable:true,maxSize:255
        status nullable:true
    }
    def beforeInsert(){
        // this.status = HoldStatus.get(2)
    }
    def beforeUpdate(){

    }
}
