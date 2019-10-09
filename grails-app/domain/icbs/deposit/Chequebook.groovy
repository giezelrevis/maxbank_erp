package icbs.deposit

import icbs.admin.UserMaster
import icbs.admin.Branch
import icbs.lov.CheckStatus

class Chequebook {
    static belongsTo=[deposit:Deposit]
    static hasMany=[cheques:Cheque]
    int chequesUsed
    Long seriesStart
    Long seriesEnd
    Date dateIssued
    String remarks
    static constraints = {
        deposit nullable:false
        chequesUsed nullable:true
        seriesStart nullable:false
        seriesEnd nullable:false,
            validator:{val,obj,errors->
                if(obj.seriesStart!=null){
                    if(obj.seriesStart>obj.seriesEnd){
                        errors.rejectValue('seriesStart','SeriesStart cannot be greater than seriesEnd')
                        return
                    }
                    if(!obj?.id){
                        for(def i =obj.seriesStart;i<=val;i++){
                            def chequeInstance = Cheque.find{chequeNo==i}
                            if(!chequeInstance){
                                 errors.rejectValue('seriesStart','Cheque Number does not exist')
                                 errors.rejectValue('seriesEnd','Cheque Number does not exist')
                                return
                            }else if(chequeInstance.status.id!=1){
                                errors.rejectValue('seriesStart','Series start is already taken')
                                errors.rejectValue('seriesEnd','Series end is already taken')
                                return
                            }
                        }
                    }
                }
            }
        dateIssued nullable:true
        remarks nullable:false,maxSize:255
    }
    static mapping = {
        id sqlType: "int", generator: "increment"
    }
    def beforeInsert(){
        this.dateIssued = Branch.get(1).runDate
        this.chequesUsed = 0
    }
    def beforeUpdate(){
    }

}
