package icbs.atm

class AtmMsgResponse {

    String  destinationIp
    Integer msgLength
    Date    dateSent
    String msgContent
    
    static constraints = {
        destinationIp nullable:true
        msgLength nullable:true
        dateSent nullable:true
        msgContent nullable:true
    }
    
    def beforeInsert() {
        this.dateSent = new Date()
    }
    
    static mapping = {
        id sqlType: 'int', generator: 'increment'
        msgContent type: 'text'
    }
}
