package icbs.deposit

import icbs.lov.CertificateTimeDepositStatus

class CTD {
    static belongsTo=[docInventory:DocInventory]
    IssueCTD issueCTD
    Long ctdNo
    Date dateOpened
    Date maturityDate
    int term
    Double interestRate
    double principalAmt
    String remarks
    CertificateTimeDepositStatus status
    
    static constraints = {
        issueCTD nullable:true
        ctdNo nullable:false,unique:true
        remarks maxSize:255,nullable:true
        status nullable:true
        dateOpened nullable:true
        interestRate nullable:true, scale: 5
        maturityDate nullable:true
        term nullable:true
        principalAmt nullable:true, scale: 2
    }
    static mapping = {
        id sqlType: "int", generator: "increment"
    }
    def beforeInsert(){
       this.status=CertificateTimeDepositStatus.get(1)
    }
    def beforeUpdate(){
//        this.status=CertificateTimeDepositStatus.get(4)
    }
}
