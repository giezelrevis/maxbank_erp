package icbs.deposit

import icbs.cif.Customer
import icbs.lov.CheckStatus

class Cheque {
    static belongsTo = [chequebook:Chequebook,docInventory:DocInventory]
    static hasOne = [stopPaymentOrder:StopPaymentOrder]
    Long chequeNo
    //Date dateIssued
    //txn id
    Date chequeDate
    String payeeName
    Customer payeeCustomer
    String payeeAcctNo
    Double chequeAmt
    Boolean isChequeClrOnUs   
    String clrOtherBankName
    String clrAcctNo
    
    CheckStatus status
    static constraints = {
        docInventory nullable:false
        chequebook nullable:true
        stopPaymentOrder nullable:true
        chequeNo nullable:false,unique:true
        chequeDate nullable:true
        payeeName nullable:true
        payeeCustomer nullable:true
        payeeAcctNo nullable:true, maxSize:30
        chequeAmt nullable:true, scale: 2, min: 0d
        isChequeClrOnUs nullable:true
        clrOtherBankName nullable:true, maxSize:50
        clrAcctNo nullable:true ,maxSize:50
        status nullable:true
    }
    static mapping = {
        id sqlType: "int", generator: "increment"
    }
    def beforeInsert(){
        this.status = CheckStatus.get(1)
    }
}
