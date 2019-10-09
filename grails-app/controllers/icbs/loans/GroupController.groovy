package icbs.loans

import grails.converters.JSON
import grails.converters.deep.JSON

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import icbs.cif.Customer
import icbs.lov.ConfigItemStatus


@Transactional(readOnly = true)
class GroupController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def index(Integer max) {
       // params.max = Math.min(max ?: 10, 100)
       params.max = Math.min(max ?: 25, 100)

        if (params.sort == null) {  // default ordering
            params.sort = "id"
        }

        if (params.query == null || params.query.trim() == "") {  // show all instances
            def groupInstanceList = GroupRecord.list(params)
            respond groupInstanceList, model:[params:params, groupInstanceList:groupInstanceList, groupInstanceCount:  GroupRecord.count()]
        } else {    // show query results
            def groupInstanceList = GroupRecord.createCriteria().list(params) {
                ilike("name", "%" + params.query.trim() + "%")
            }
            respond groupInstanceList, model:[params:params, groupInstanceList:groupInstanceList, groupInstanceCount: groupInstanceList.totalCount]
        }
        return
    }

    def search(Integer max) {
      //  params.max = Math.min(max ?: 10, 100) 
          params.max = Math.min(max ?: 25, 100)  

        if (params.sort == null) {
            params.sort = "id"
        }

        if (params.query == null || params.query.trim() == "") {  // show all instances
            render(template:"search/search", model:[params:params, domainInstanceList:GroupRecord.list(params), domainInstanceCount:GroupRecord.count()]) as JSON
        } else {    // show query results
            def result = GroupRecord.createCriteria().list(params) {                
                idEq(params.query.trim().toLong())
            }
            render(template:"search/search", model:[params:params, domainInstanceList:result, domainInstanceCount:result.totalCount]) as JSON
        }            
        return
    }

    def show(GroupRecord groupInstance) {
        respond groupInstance, model:[groupInstance:groupInstance]
    }

    def create() {
        // initialize session variables
        session["members"] = []

        respond new GroupRecord(params)
    }

    @Transactional
    def save(GroupRecord groupInstance) {
        if (groupInstance == null) {
            notFound()
            return
        }

        if (groupInstance.hasErrors()) {
            respond groupInstance.errors, model: [groupInstance:groupInstance],  view:'create'
            return
        }

        for(member in session["members"]) {
            groupInstance.addToMembers(member)
        }
        session["members"] = null

        groupInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'group.label', default: 'Group'), groupInstance.id])
                //redirect groupInstance
                redirect action: "show", id: groupInstance.id
            }
            '*' { respond groupInstance, [status: CREATED] }
        }
    }

    def edit(GroupRecord groupInstance) {
        //respond groupInstance
        respond groupInstance, model:[groupInstance:groupInstance]
    }

    @Transactional
    def update(GroupRecord groupInstance) {
        if (groupInstance == null) {
            notFound()
            return
        }

        if (groupInstance.hasErrors()) {
            respond groupInstance.errors, model: [groupInstance:groupInstance], view:'edit'
            return
        }

        groupInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'group.label', default: 'Group'), groupInstance.id])
                //redirect groupInstance
                redirect action: "show", id: groupInstance.id
            }
            '*'{ respond groupInstance, [status: OK] }
        }
    }

    def getGroupInfoAjax() {
        def group

        if (params.id) {
            group = GroupRecord.get(params.id)
        } else {
            group = null
        }

        render(template:"details/groupInfo", model:[group: group]) as JSON
        return
    }     

    /*
     * Members
     */

    def showMembersAjax() {
        render(template:"members/list") as JSON
        return
    } 

    def showMembersAjax2() {
        def id  = params?.id
        def groupInstance = GroupRecord.get(id)

        render(template:"members/list", model:[groupInstance:groupInstance]) as JSON
        return
    } 

    def addMemberAjax() {
        def id = params?.id

        def member = Customer.get(id)

        def members
        if (session["members"]) {
            members = session["members"]
        } else {
            members = []
        } 

        if (!(members*.id.contains(member.id))) {
            members.add(member)
            session["members"] = members
        }

        render "success"
        return
    }

    @Transactional
    def addMemberAjax2() {
        def id = params?.id
        def cid = params?.cid

        def groupInstance = GroupRecord.get(id)
        def member = Customer.get(cid)

        if (!(groupInstance*.members.id.contains(member.id))) {
            groupInstance.addToMembers(member)
            groupInstance.save flush:true
        }

        render "success"
        return
    }

    def deleteMemberAjax() {
        def id = params?.id?.toInteger()

        session["members"].remove(id)

        render "success"
        return
    }

    @Transactional
    def deleteMemberAjax2() {
        def id = params?.id?.toInteger()
        def cid = params?.cid

        def groupInstance = GroupRecord.get(id)
        def member = Customer.get(cid)

        groupInstance.removeFromMembers(member)
        groupInstance.save flush:true

        render "success"
        return
    }

    /*
     * Status
     */

    def showUpdateStatusAjax() {
        def groupInstance = GroupRecord.get(params?.id)

        render(template:"status/editStatus", model:[groupInstance:groupInstance]) as JSON
        return
    }

    @Transactional
    def updateStatusAjax() {
        def groupInstance = GroupRecord.get(params?.id)

        groupInstance.status = ConfigItemStatus.get(params?.status?.id)
        groupInstance.save flush:true

        def message = "Status successfully updated"
        render(template:"status/editStatus", model:[groupInstance:groupInstance, message:message]) as JSON

        return
    }

    /*@Transactional
    def delete(GroupRecord groupInstance) {

        if (groupInstance == null) {
            notFound()
            return
        }

        groupInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'group.label', default: 'Group'), groupInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }*/

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'group.label', default: 'Group'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
