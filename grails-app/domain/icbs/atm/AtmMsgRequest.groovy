package icbs.atm

class AtmMsgRequest {

    String  sourceIp
    Integer msgLength
    Date    dateReceived
    String msgContent
    
    static constraints = {
        sourceIp nullable:true
        msgLength nullable:true
        dateReceived nullable:true
        msgContent nullable:true
    }
    
    def beforeInsert() {
        this.dateReceived = new Date()
    }
    
    static mapping = {
        id sqlType: 'int', generator: 'increment'
        msgContent type: 'text'
    }
}
