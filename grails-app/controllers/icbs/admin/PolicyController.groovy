package icbs.admin



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import icbs.lov.ConfigItemStatus
import groovy.json.JsonBuilder
import grails.converters.JSON
import grails.converters.deep.JSON
import groovy.sql.Sql

@Transactional(readOnly = true)
class PolicyController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def auditLogService
    def policyService
    def dataSource

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        if(params.offset==null){
            params.offset=0
        }
        if (params.query == null) {
            respond Policy.list(params), model:[params:params,PolicyInstanceCount:  Policy.count()]
            return
        }
        else{
            def PolicyList = Policy.createCriteria().list (params) {
                or {
                    ilike("description", "%${params.query}%")
                }
            }
            respond PolicyList, model:[params:params,PolicyInstanceCount: PolicyList.totalCount]
        }
        return
    }

    def show(Policy policyInstance) {
        respond policyInstance
    }

    def create() {
        respond new Policy(params)
    }

    @Transactional
    def save(Policy policyInstance) {
        policyInstance.configItemStatus = ConfigItemStatus.get(2)

        if (policyInstance == null) {
            notFound()
            return
        }

        if (policyInstance.hasErrors()) {
            respond policyInstance.errors, view:'create'
            return
        }
        
        if (!policyInstance.policyTemplate) {
            respond policyInstance.errors, view:'edit'
            return            
        }        
        def roles = params.list('roles')
        def approvers = params.list('approvers')
        def transactions = params.list('transactions')
        
        // Check if policy template-role already exists
        def existingPolicies = Policy.findAllByPolicyTemplate(PolicyTemplate.get(policyInstance.policyTemplateId))
        def roleException = null
        existingPolicies.each {
            def policy = it
            roles.each {
                def policyRoleCheck = PolicyRole.findByPolicyAndRole(policy, Role.get(it))
                if(policyRoleCheck) {
                    roleException = Role.get(it)
                }
            }
        }
        
        if(roleException) {
            flash.error = "Policy already exists for role " + roleException.name + '.'
            respond policyInstance.errors, view:'create'
            return
        }
        
        policyInstance.save flush:true

        roles.each {
            PolicyRole pr = new PolicyRole(role:it, policy:policyInstance, configItemStatus:ConfigItemStatus.get(2)).save(flush:true)
        }

        approvers.each {
            PolicyApprover pa = new PolicyApprover(role:it, policy:policyInstance, configItemStatus:ConfigItemStatus.get(2)).save(flush:true)
        }

        transactions.each {
            PolicyTxn pt = new PolicyTxn(txnTemplate:it, policy:policyInstance, configItemStatus:ConfigItemStatus.get(2)).save(flush:true)
        }

        // Log
        def description = 'save new Policy ' +  policyInstance.description
        auditLogService.insert('040', 'ADM00402', description, 'policy', null, null, null, policyInstance.id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'policy.label', default: 'Policy'), policyInstance.id])
                redirect policyInstance
            }
            '*' { respond policyInstance, [status: CREATED] }
        }
    }

    def edit(Policy policyInstance) {
        respond policyInstance
    }

    @Transactional
    def update(Policy policyInstance) {
        
        if (policyInstance == null) {
            notFound()
            return
        }

        if (policyInstance.hasErrors()) {
            respond policyInstance.errors, view:'edit'
            return
        }

        if (!policyInstance.policyTemplate) {
            respond policyInstance.errors, view:'edit'
            return            
        }
        
        def roles = params.list('roles')
        def approvers = params.list('approvers')
        def transactions = params.list('transactions')
        
        // Check if policy template-role already exists
        def existingPolicies = Policy.findAllByPolicyTemplate(PolicyTemplate.get(policyInstance.policyTemplateId))
        def roleException = null
        existingPolicies.each {
            def policy = it
            roles.each {
                def policyRoleCheck = PolicyRole.findByPolicyAndRole(policy, Role.get(it))
                if(policyRoleCheck) {
                    roleException = Role.get(it)
                }
            }
        }
        
        if(roleException) {
            flash.error = "Policy already exists for role " + roleException.name + '.'
            respond policyInstance.errors, view:'create'
            return
        }
        
        policyInstance.save flush:true
        
        println "policyid? "+policyInstance.id
        
        roles.each {
            def role = Role.get(it) 
            //println role
            
            def pr = PolicyRole.findAllByRoleAndPolicy(role, policyInstance)
            //println "pr ? "+pr

            if(!pr) {
               // println "not pr?"
                (new PolicyRole(role:it, policy:policyInstance, configItemStatus:ConfigItemStatus.get(2))).save(flush:true)
            } 
        }
        
      
        def role = PolicyRole.findAllByPolicy(policyInstance)
        for (eachrole in role)
        {
            if (!(roles.contains(eachrole.role.id.toString())))
            {
                eachrole.delete flush:true
            } 
        }
 
        approvers.each {
            def pa = PolicyApprover.findAllByRoleAndPolicy(Role.get(it), policyInstance)

            if(!pa) {
                (new PolicyApprover(role:it, policy:policyInstance, configItemStatus:ConfigItemStatus.get(2))).save(flush:true)
            }
        }
        
        def approver = PolicyApprover.findAllByPolicy(policyInstance)
        for (eachapprove in approver)
        {
            if (!(approvers.contains(eachapprove.role.id.toString())))
            {
                eachapprove.delete flush:true
            } 
        }
        
        

        transactions.each {
            def pt = PolicyTxn.findAllByTxnTemplateAndPolicy(TxnTemplate.get(it), policyInstance)

            if(!pt) {
                (new PolicyTxn(txnTemplate:it, policy:policyInstance, configItemStatus:ConfigItemStatus.get(2))).save(flush:true)
            }
        }
        
        def transaction = PolicyTxn.findAllByPolicy(policyInstance)
        for (eachtransact in transaction)
        {
            if (!(transactions.contains(eachtransact.role.id.toString())))
            {
                eachtransact.delete flush:true
            } 
        }

        // Log
        def description = 'update Policy ' +  policyInstance.description
        auditLogService.insert('040', 'ADM00402', description, 'policy', null, null, null, policyInstance.id)

        request.withFormat {
            form multipartForm {
                //flash.message = message(code: 'default.updated.message', args: [message(code: 'Policy.label', default: 'Policy'), policyInstance.id])
                flash.message = "Policy Updated!|success|alert"
                redirect policyInstance
            }
            '*'{ respond policyInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Policy policyInstance) {

        if (policyInstance == null) {
            notFound()
            return
        }


        policyInstance.configItemStatus = ConfigItemStatus.get(3)
        policyInstance.save flush:true
        def roles = params.list('roles')
        def approvers = params.list('approvers')
        def transactions = params.list('transactions')
        
        def role = PolicyRole.findAllByPolicy(policyInstance)
        for (eachrole in role)
        {
            if (!(roles.contains(eachrole.role.id.toString())))
            {
                eachrole.delete flush:true
            } 
        }
        
        def approver = PolicyApprover.findAllByPolicy(policyInstance)
        for (eachapprove in approver)
        {
            if (!(approvers.contains(eachapprove.role.id.toString())))
            {
                eachapprove.delete flush:true
            } 
        }
        
        def transaction = PolicyTxn.findAllByPolicy(policyInstance)
        for (eachtransact in transaction)
        {
            if (!(transactions.contains(eachtransact.role.id.toString())))
            {
                eachtransact.delete flush:true
            } 
        }
        
        // Log
        def description = 'delete Policy ' +  policyInstance.description
        auditLogService.insert('040', 'ADM00402', description, 'policy', null, null, null, policyInstance.id)
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Policy.label', default: 'Policy'), policyInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    def checkIfAllowed() {
        def isAllowed = null
        println "transaction amount" + params
        if(params.amount) { // If teller transaction
            def a = params.amount.replaceAll(',','')
            def b = a.toDouble()
            isAllowed = policyService.isTxnAllowed(params.policyCode, b)
        }
        else {
            isAllowed = policyService.isAllowed(params.policyCode)
        }

        // Create exception if not allowed
        if(!isAllowed) {
            policyService.createException(params.policyCode, null, null, null)
        }
        println 'Overide?: ' + isAllowed
        response.setContentType("application/json")
        render '{"isAllowed":"' + isAllowed + '"}'
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'policy.label', default: 'Policy'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    
    def getPendingPolicyCount()
    {
        response.setContentType("application/json")
        render '{"pendingPolicy":'+policyService.getPendingPolicyExceptionCount() + '}'
    }
    
    def getPolicyJS()
    {
        def db = new Sql(dataSource)
        def sql = "select 9999"
        if(params.recid == "PROCESS")
        {
              sql = "SELECT id,description from policy_template where type = 'PROCESS' and config_item_status_id = 2"
        } else {
              sql = "SELECT id,description from policy_template where type = 'TXN' and config_item_status_id = 2"

        }
   
        def results = new JsonBuilder(db.rows(sql)).toPrettyString()
        render(text: results) as JSON
        return
    }
}
