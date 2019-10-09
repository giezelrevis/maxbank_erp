package icbs.deposit

import icbs.admin.UserMaster
import icbs.admin.Branch

class IssueCTD {
    static belongsTo = [deposit:Deposit]
    CTD ctd
    UserMaster issuedBy
    Date dateIssued
    UserMaster canceledBy
    Date canceledAt
    String remarks
    Long ctdNo
    static transients=['ctdNo']
    static constraints = {
        ctd nullable:true
        issuedBy nullable:true
        dateIssued nullable:true
        canceledBy nullable:true
        canceledAt nullable:true
        remarks nullable:true,maxSize:255
        ctdNo bindable:true,
            validator:{val,obj,errors->
                if(obj.id==null){
                    if(val==null){
                        errors.rejectValue('ctdNo', 'Cannot Be Null')
                    }else{
                        def ctdInstance = CTD.find{ctdNo ==val}
                        if(!ctdInstance){
                             errors.rejectValue('ctdNo', 'CTD No:'+ val +' is Invalid')
                        }else{
                            if(ctdInstance.issueCTD!=null){
                                 errors.rejectValue('ctdNo', 'CTD No:'+ val +'has already been issued')
                            }
                        }
                    }   
                }      
            }
    }
    static mapping = {
        id sqlType: "int", generator: "increment"
        ctd lazy: false
        deposit lazy:false
    }
    def beforeInsert(){
       this.dateIssued=Branch.get(1).runDate
    }
}
