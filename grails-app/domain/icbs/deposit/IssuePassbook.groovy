package icbs.deposit

import icbs.admin.UserMaster
import icbs.admin.Branch

class IssuePassbook {
    static belongsTo = [deposit:Deposit]
    Passbook passbook
    UserMaster issuedBy
    Date dateIssued
    UserMaster canceledBy
    Date canceledAt
    String remarks
    Long passbookNo
    static transients=['passbookNo']
    static constraints = {
        deposit nullable:false
        passbook nullable:true
        issuedBy nullable:true
        dateIssued nullable:true
        canceledBy nullable:true
        canceledAt nullable:true
        remarks nullable:true,maxSize:255
        passbookNo bindable:true,
            validator:{val,obj,errors->
                if(obj.id==null){
                    if(val==null){
                        errors.rejectValue('passbookNo', 'Cannot Be Null')
                    }else{
                        def passbookInstance = Passbook.find{passbookNo ==val}
                        if(!passbookInstance){
                             errors.rejectValue('passbookNo', 'Passbook No:'+ val +' is Invalid')
                        }else{
                            if(passbookInstance.issuePassbook!=null){
                                 errors.rejectValue('passbookNo', 'Passbook No:'+ val +'has already been issued')
                            }
                        }
                    }   
                }      
            }
    }
    static mapping={
        id sqlType: "int", generator: "increment"
    }
    def beforeInsert(){
        this.dateIssued = Branch.get(1).runDate
    }
}