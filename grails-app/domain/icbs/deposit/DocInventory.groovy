package icbs.deposit

import icbs.admin.Branch
import icbs.admin.UserMaster
import icbs.lov.DocInventoryStatus
import icbs.lov.DocInventoryType


class DocInventory {
    static hasMany=[cheques:Cheque,ctds:CTD,passbooks:Passbook]
    Branch branch
    DocInventoryType type
    Long seriesStart
    Long seriesEnd
    int usageCount
    String docParticulars
    String checkAcctNo
    
    boolean isCanceled
    UserMaster canceledBy
    Date canceledAt
    DocInventoryStatus status
    static constraints = {
        cheques nullable:true
        ctds nullable:true
        passbooks nullable:true
        branch nullable:true
        type nullable:false
        seriesStart nullable:false, maxSize:30, matches:"[0-9]+"
        seriesEnd nullable:false, maxSize:30, matches:"[0-9]+",
            validator:{ val,obj,errors->
                if(obj?.seriesStart!=null){
                    if (val<=obj.seriesStart){
                        println("series end  =" +val +"series start ="+obj?.seriesStart)
                        errors.rejectValue('seriesEnd','Series End Cannot be Less Than or Equal to Series Start')
                        return
                    }  
                }
                if(obj?.type!=null&&obj?.id==null){
                    if(obj.type.id==1){
                        /*Insert CTDS*/
                        def results = CTD.withCriteria {
                            between('ctdNo', obj.seriesStart, obj.seriesEnd)
                        }
                        if(results){
                            errors.rejectValue('seriesStart','CTD is encapsulated by the range')
                            errors.rejectValue('seriesEnd','CTD is encapsulated by the range')
                            return
                        }
                    }
                    if(obj.type.id==3){
                        /*Insert Cheque*/
                        def results = Cheque.withCriteria {
                            between('chequeNo', obj.seriesStart, obj.seriesEnd)
                        }
                        if(results){
                            errors.rejectValue('seriesStart','Cheque is encapsulated by the range')
                            errors.rejectValue('seriesEnd','Cheque is encapsulated by the range')
                            return
                        }
                    }
                    // SA/CA/TD passbook
                    if(obj.type.id==2||obj.type.id==4||obj.type.id==5){
                        /*Insert Passbook*/
                        def results = Passbook.withCriteria {
                            between('passbookNo', obj.seriesStart, obj.seriesEnd)
                        }
                        if(results){
                            errors.rejectValue('seriesStart','Passbook is encapsulated by the range')
                            errors.rejectValue('seriesEnd','Passbook is encapsulated by the range')
                            return
                        }
                    }
                }
            }
        usageCount nullable:true
        isCanceled nullable:true
        canceledBy nullable:true
        canceledAt nullable:true
        status nullable:true
        docParticulars nullable:true, maxSize:255
        checkAcctNo nullable:true
    }
    def beforeValidate(){
        
    }
    def beforeInsert(){
        //pending status
        this.status = DocInventoryStatus.get(2)
    }
    def afterInsert(){
        
    }
    def beforeUpdate(){
        this.seriesStart = this.getPersistentValue('seriesStart')
        this.seriesEnd = this.getPersistentValue('seriesEnd')
    }
    static mapping = {
    	id sqlType: "int", generator: "increment"
    }
}
