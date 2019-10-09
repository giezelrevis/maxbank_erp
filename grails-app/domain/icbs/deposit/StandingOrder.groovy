package icbs.deposit
import groovy.time.TimeCategory
import icbs.lov.StandingOrderFreq
import icbs.lov.StandingOrderStatus
import icbs.lov.StandingOrderType
import icbs.admin.Branch

class StandingOrder {
    Deposit fundingDeposit
    Deposit fundedDeposit
    StandingOrderFreq freq
    StandingOrderType type
    Date startDate
    Date endDate
    Boolean isFundFixed
    Double fundFixedAmt
    Double percent
    int retries
    StandingOrderStatus status
    static mapping = {
    	id sqlType: "int", generator: "increment"
        status sqlType: "smallint"
    }
    static constraints = {
        type nullable:false
        freq nullable:false
        fundingDeposit nullable:false
        fundedDeposit nullable:false
        startDate nullable:true
        endDate nullable:true
        isFundFixed nullable:true
        fundFixedAmt nullable:true, min:0d, scale: 2, validator:{
            val,obj,errors->
            if(!val&&obj.type?.id==1){
                  errors.rejectValue('fundFixedAmt', 'Fund amount cannot be null')
            }
            if(obj?.fundingDeposit&&obj.type?.id==1){
                if(obj.fundingDeposit.availableBalAmt<val){
                    errors.rejectValue('fundFixedAmt', 'Amount exceeds available balance of Account No:'+obj.fundingDeposit.acctNo)
                }
            }
        }//, min:0D
        percent nullable:true, scale: 5, validator:{
            val,obj,errors->
            if(!val&&obj.type?.id==2){
                  errors.rejectValue('percent', 'Percent Cannot be null')
            }
        }//,max:100D,min:0D
        retries nullable:true
        status nullable:true
    }
    def beforeInsert(){
        this.startDate = Branch.get(1).runDate
        /*if(this.freq.id==1){
            this.endDate  = new Date()+1.day
        }else if(this.freq.id==2){
            this.endDate  = new Date()+1.week
        }else if(this.freq.id==3){
            this.endDate  = new Date()+15.days
        }else if(this.freq.id==4){
            this.endDate  = new Date()+1.month
        }else if(this.freq.id==5){
            this.endDate  = new Date()+4.months
        }*/
            
        //this.status = StandingOrderStatus.read(2)
    }
    def beforeUpdate(){
       
    }
}
