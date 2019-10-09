package icbs.admin



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import icbs.lov.ConfigItemStatus

@Transactional(readOnly = true)
class UserMessageController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def index(Integer max) {
        
        params.max = Math.min(max ?: 10, 100)
        if(params.offset==null){
            params.offset=0
        }
        if (params.query == null) {
            respond UserMessage.findAllByRecipient(UserMaster.get(session.user_id)), model:[params:params,UserMessageInstanceCount:  UserMessage.count()]
            return
        }
        else{
            def UserMessageList = UserMessage.createCriteria().list (params) {
                
            }
            respond UserMessageList, model:[params:params,UserMessageInstanceCount: UserMessageList.totalCount]
        }
        return
    }

    def outbox(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        if(params.offset==null){
            params.offset=0
        }
        if (params.query == null) {
            respond UserMessage.findAllBySender(UserMaster.get(session.user_id)), model:[params:params,UserMessageInstanceCount:  UserMessage.count()]
            return
        }
        else{
            def UserMessageList = UserMessage.createCriteria().list (params) {
                
            }
            respond UserMessageList, model:[params:params,UserMessageInstanceCount: UserMessageList.totalCount]
        }
        return
    }

    @Transactional
    def show(UserMessage userMessageInstance) {
        if(userMessageInstance.recipient == UserMaster.get(session.user_id)) {
            userMessageInstance.isRead = true
            userMessageInstance.save flush:true
        }
        respond userMessageInstance
    }

    def create() {
        respond new UserMessage(params)
    }

    def reply(UserMessage replyInstance) {
        params.parentMessage = replyInstance
        respond new UserMessage(params)
    }

    @Transactional
    def save(UserMessage userMessageInstance) {
        userMessageInstance.sender = UserMaster.get(session.user_id)
        userMessageInstance.configItemStatus = ConfigItemStatus.get(2)
        userMessageInstance.sentAt = new Date().format('yyyy-MM-dd HH:mm')

        if (userMessageInstance == null) {
            notFound()
            return
        }

        if (userMessageInstance.hasErrors()) {
            respond userMessageInstance.errors, view:'create'
            return
        }

        userMessageInstance.save flush:true

        request.withFormat {
            form multipartForm {
                //flash.message = message(code: 'default.created.message', args: [message(code: 'userMessage.label', default: 'UserMessage'), userMessageInstance.id])
                flash.message = "Message Sent!|success|alert"
                redirect userMessageInstance
            }
            '*' { respond userMessageInstance, [status: CREATED] }
        }
    }

    @Transactional
    def saveReply(UserMessage userMessageInstance) {
        userMessageInstance.recipient = UserMaster.get(params.recipient)
        userMessageInstance.sender = UserMaster.get(session.user_id)
        userMessageInstance.configItemStatus = ConfigItemStatus.get(2)
        userMessageInstance.sentAt = new Date().format('yyyy-MM-dd HH:mm')

        if (userMessageInstance == null) {
            notFound()
            return
        }

        if (userMessageInstance.hasErrors()) {
            respond userMessageInstance.errors, view:'reply'
            return
        }

        userMessageInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'userMessage.label', default: 'UserMessage'), userMessageInstance.id])
                redirect userMessageInstance
            }
            '*' { respond userMessageInstance, [status: CREATED] }
        }
    }

    def edit(UserMessage userMessageInstance) {
        respond userMessageInstance
    }

    @Transactional
    def update(UserMessage userMessageInstance) {
        if (userMessageInstance == null) {
            notFound()
            return
        }

        if (userMessageInstance.hasErrors()) {
            respond userMessageInstance.errors, view:'edit'
            return
        }

        userMessageInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'UserMessage.label', default: 'UserMessage'), userMessageInstance.id])
                redirect userMessageInstance
            }
            '*'{ respond userMessageInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(UserMessage userMessageInstance) {
        userMessageInstance.configItemStatus = ConfigItemStatus.get(3)

        if (userMessageInstance == null) {
            notFound()
            return
        }

        userMessageInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'UserMessage.label', default: 'UserMessage'), userMessageInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'userMessage.label', default: 'UserMessage'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    
    def getUnreadMessage()
    {
        def cnt = UserMessage.countByRecipientAndIsRead(UserMaster.get(session.user_id),false)
         
        response.setContentType("application/json")
        render '{"emailUnread":'+cnt+ '}'
         
        
        //render '{"pendingPolicy":'+policyService.getPendingPolicyExceptionCount() + '}'
        
    }
}
