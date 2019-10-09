package icbs.atm

class AtmBitmap {

    Integer elementNo
    String name
    Boolean isVar
    String type
    Integer length
    Boolean isInReply
    
    static constraints = {
        elementNo nullable:true
        name nullable:true
        isVar nullable:true
        type nullable:true
        length nullable:true
        isInReply nullable:true
    }
    
    static mapping = {
        id sqlType: 'int', generator: 'increment'
    }
}
