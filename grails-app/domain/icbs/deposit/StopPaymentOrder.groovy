package icbs.deposit

import icbs.admin.UserMaster
import icbs.lov.ConfigItemStatus

class StopPaymentOrder {
    static belongsTo=[cheque:Cheque]
    String ref
    String chkPayee
    Date chkDate
    Double chkAmt
    Date stopAt
    UserMaster stopBy
    String remarks
    ConfigItemStatus status
    String chequeNo
    Deposit deposit
    static transients=['chequeNo','deposit']
    static constraints = {
        cheque nullable:true
        ref nullable:true, maxSize:50
        chkPayee nullable:true ,maxSize:50
        chkDate nullable:true
        chkAmt nullable:true, min: 0d, scale: 2
        stopAt nullable:true
        stopBy nullable:true
        remarks nullable:true,maxSize:255
        chequeNo bindable:true,
            validator:{val,obj,errors->
                if(obj.id==null){
                    if(val==null){
                        errors.rejectValue('chequeNo', 'chequeNo Cannot Be Null')
                    }else{
                        def chequeInstance = Cheque.find{chequebook.deposit.id ==obj.deposit.id && chequeNo==val}
                        if(!chequeInstance){
                             errors.rejectValue('chequeNo', 'Cheque No:'+ val +' is Invalid For the specified deposit Account')
                        }else{
                            if(chequeInstance.stopPaymentOrder!=null){
                                 errors.rejectValue('chequeNo', 'Cheque No:'+ val +'already has a Stop Payment Order Issued')
                            }
                        }
                    }   
                }      
            }
        deposit bindable:true,validator:{val,obj,errors->
            if(obj.id==null&&val==null){
                 errors.rejectValue('deposit', 'Deposit Cannot Be Null')
            }
        }
        status nullable:true
    }
    static mapping = {
        id sqlType: "int", generator: "increment"
    }
    def beforeInsert(){
        // this.status = ConfigItemStatus.get(2)
        
    }
    def beforeUpdate(){
      
    }
}
