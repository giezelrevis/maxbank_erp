package icbs.admin

import icbs.lov.ConfigItemStatus

class UserMessage {

	UserMaster sender
	UserMaster recipient
	String subject
	String body
	String sentAt
    UserMessage parentMessage
    boolean isRead
    ConfigItemStatus configItemStatus

    static constraints = {
    	sender blank:true, nullable:false
    	recipient nullable:false
    	subject nullable:false
    	body nullable:true, size:1..2500
        sentAt blank:true
        parentMessage blank:true, nullable:true
    }

    static mapping = {
        id sqlType:'int', generator:'increment'
    	sender sqlType:'int'
    	recipient sqlType:'int'
    }
}
