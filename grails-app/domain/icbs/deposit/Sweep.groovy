package icbs.deposit

import icbs.admin.UserMaster
import icbs.lov.SweepRule
import icbs.lov.SweepStatus
import icbs.admin.Branch

class Sweep {
    static belongsTo= [fundingDeposit:Deposit]
    Deposit fundedDeposit
    //boolean isFundFixed
    SweepRule rule
    Double fundLimitPercentage
    Double fundLimitAmt
    String remarks
    SweepStatus status
    int ordinalNum
    Date dateCreated
    UserMaster createdBy
    static constraints = {
        fundingDeposit nullable:false
        fundedDeposit nullable:false,
        validator:{
            val,obj,errors->
            if(obj?.fundingDeposit!=null&&obj?.id==null){
                def sweepInstance = Sweep.find{fundingDeposit.id ==obj.fundingDeposit.id &&fundedDeposit.id ==val.id && status.id<3}
                if(sweepInstance){
                    errors.rejectValue('fundedDeposit','This Account is already part of your sweep')
                }
            }
        }
        rule nullable:false
        fundLimitPercentage nullable:true, scale: 5
        fundLimitAmt nullable:true, min:0d, scale: 2
        remarks nullable:true,maxSize:255
        status nullable:true
        dateCreated nullable:true
        createdBy nullable:true
        ordinalNum nullable:false,min:0,
        validator:{
            val,obj,errors->
            if(obj?.fundingDeposit!=null&&obj?.id==null){
                def sweepInstance = Sweep.find{fundingDeposit.id ==obj.fundingDeposit.id && status.id<3 &&ordinalNum==val}
                if(sweepInstance){
                    errors.rejectValue('ordinalNum','Order is already taken')
                }
            }
        }
    }
    static mapping = {
    	id sqlType: "int", generator: "increment"
        //status sqlType: "smallint"?
    }   
    def beforeUpdate(){

    }
    def beforeInsert(){
        this.dateCreated = Branch.get(1).runDate
        // this.status = SweepStatus.get(2)
    }
}
