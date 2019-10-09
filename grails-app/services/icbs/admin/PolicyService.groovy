package icbs.admin

import grails.transaction.Transactional
import javax.servlet.http.HttpSession
import org.springframework.web.context.request.RequestContextHolder
import org.hibernate.criterion.CriteriaSpecification
import org.hibernate.FetchMode

import icbs.lov.ConfigItemStatus
import icbs.lov.PolicyAction
import icbs.admin.UserMaster

@Transactional
class PolicyService {

    def isAllowed(String policyTemplateCode) {
    	HttpSession session = RequestContextHolder.currentRequestAttributes().getSession();

    	def isAllowed = false

    	def roles = UserRole.findAllByUserMasterAndConfigItemStatus(UserMaster.get(session.user_id), ConfigItemStatus.get(2))

        def policyRoleCount = 0

    	roles.each {
            def role = it.role
            def policyRole = PolicyRole.createCriteria().get() {
                createAlias('policy', 'p', CriteriaSpecification.LEFT_JOIN)
                and {
                    eq("role", role)
                    eq("p.policyTemplate", PolicyTemplate.findByCode(policyTemplateCode))
                }
            }

            if(policyRole) {
                policyRoleCount++
                if(policyRole.policy.policyAction == PolicyAction.get(1)) {
                    isAllowed = true
                }
            }
    	}

        // Check if approver
        roles.each {
            def role = it.role
            def policyApprover = PolicyApprover.createCriteria().get() {
                createAlias('policy', 'p', CriteriaSpecification.LEFT_JOIN)
                and {
                    eq("role", role)
                    eq("p.policyTemplate", PolicyTemplate.findByCode(policyTemplateCode))
                }
            }

            if(policyApprover) {
                isAllowed = true
            }
        }

        // If no policy is defined, allow
        if(policyRoleCount == 0) isAllowed = true
        println 'IsAllowedsya ' + isAllowed
    	return isAllowed
    }

    def isAllowedToOverride(String policyTemplateCode, UserMaster userMaster) {
        def isAllowed = false

        def roles = UserRole.findAllByUserMasterAndConfigItemStatus(userMaster, ConfigItemStatus.get(2))

        def policyRoleCount = 0

        roles.each {
            def role = it.role
            def policyRole = PolicyRole.createCriteria().get() {
                createAlias('policy', 'p', CriteriaSpecification.LEFT_JOIN)
                and {
                    eq("role", role)
                    eq("p.policyTemplate", PolicyTemplate.findByCode(policyTemplateCode))
                }
            }

            if(policyRole) {
                policyRoleCount++
                if(policyRole.policy.policyAction == PolicyAction.get(1)) {
                    isAllowed = true
                }
            }
        }

        // Check if approver
        roles.each {
            def role = it.role
            def policyApprover = PolicyApprover.createCriteria().get() {
                createAlias('policy', 'p', CriteriaSpecification.LEFT_JOIN)
                and {
                    eq("role", role)
                    eq("p.policyTemplate", PolicyTemplate.findByCode(policyTemplateCode))
                }
            }

            if(policyApprover) {
                isAllowed = true
            }
        }

        // If no policy is defined, allow
        if(policyRoleCount == 0) isAllowed = true

        return isAllowed
    }

    def isTxnAllowed(String txnTemplateCode, Double txnAmtCondition) {
        HttpSession session = RequestContextHolder.currentRequestAttributes().getSession();

        def isAllowed = false

        def roles = UserRole.findAllByUserMasterAndConfigItemStatus(UserMaster.get(session.user_id), ConfigItemStatus.get(2))

        def policyRoleCount = 0
        
        roles.each {
            def role = it.role
            println "txnAmtCondition" + txnAmtCondition
            def policyTxn = PolicyTxn.executeQuery("select pTxn.id from PolicyTxn pTxn, PolicyRole pRole"
                + " join pTxn.txnTemplate tTemplate"
                + " join pTxn.policy p"
                + " where tTemplate.code = '" + txnTemplateCode + "'"
                + " and pRole.policy = p.id"
                + " and pRole.role = " + role.id
                + " and p.txnAmtCondition < " + txnAmtCondition)
            
            if(policyTxn) {
                policyRoleCount++
            }
        }

        // Check if approver
        roles.each {
            def role = it.role
            def policyApprover = PolicyTxn.executeQuery("select pTxn.id from PolicyTxn pTxn, PolicyApprover pApprover"
                + " join pTxn.txnTemplate tTemplate"
                + " join pTxn.policy p"
                + " where tTemplate.code = '" + txnTemplateCode + "'"
                + " and pApprover.policy = p.id"
                + " and pApprover.role = " + role.id
                + " and p.txnAmtCondition < " + txnAmtCondition)

            if(policyApprover) {
                isAllowed = true
            }
        }

        // If no policy is defined, allow
        if(policyRoleCount == 0) isAllowed = true

        return isAllowed
    }

    def isAllowedToOverrideTxn(String txnTemplateCode, txnAmtCondition, UserMaster userMaster) {
        def isAllowed = false

        def roles = UserRole.findAllByUserMasterAndConfigItemStatus(userMaster, ConfigItemStatus.get(2))

        def policyRoleCount = 0

        roles.each {
            def role = it.role
            def policyTxn = PolicyTxn.executeQuery("select pTxn.id from PolicyTxn pTxn, PolicyRole pRole"
                + " join pTxn.txnTemplate tTemplate"
                + " join pTxn.policy p"
                + " where tTemplate.code = '" + txnTemplateCode + "'"
                + " and pRole.policy = p.id"
                + " and pRole.role = " + role.id
                + " and p.txnAmtCondition <> 0" )
            
            if(policyTxn) {
                policyRoleCount++
            }
        }

        // Check if approver
        roles.each {
            def role = it.role
            def policyApprover = PolicyTxn.executeQuery("select pTxn.id from PolicyTxn pTxn, PolicyApprover pApprover"
                + " join pTxn.txnTemplate tTemplate"
                + " join pTxn.policy p"
                + " where tTemplate.code = '" + txnTemplateCode + "'"
                + " and pApprover.policy = p.id"
                + " and pApprover.role = " + role.id
                + " and p.txnAmtCondition <> 0" )

            if(policyApprover) {
                isAllowed = true
            }
        }

        // If no policy is defined, allow
        if(policyRoleCount == 0) isAllowed = true

        return isAllowed
    }

    def createException(String policyTemplateCode, String tableName, Long recordId, String recordUrl) {
    	HttpSession session = RequestContextHolder.currentRequestAttributes().getSession()

    	def policyException = new PolicyException()
    	policyException.requestingUser = UserMaster.get(session.user_id)
    	policyException.dateOfRequest = new Date()
    	policyException.policyTemplate = PolicyTemplate.findByCode(policyTemplateCode)
        //policyException.tableName = tableName
        //policyException.recordId = recordId
    	//policyException.recordUrl = recordUrl
    	policyException.save flush:true
    }
    
     def createException(String policyTemplateCode, String tableName, Long recordId, String recordUrl, Long targetid) {
        
    	HttpSession session = RequestContextHolder.currentRequestAttributes().getSession()

    	def policyException = new PolicyException()
        policyException.approvingUser = UserMaster.get(session.user_id)
    	policyException.requestingUser = UserMaster.get(targetid)
    	policyException.dateOfRequest = new Date()
    	policyException.policyTemplate = PolicyTemplate.findByCode(policyTemplateCode)
        policyException.tableName = tableName
        policyException.recordId = recordId
    	policyException.recordUrl = recordUrl
    	policyException.save flush:true
    }
    
    def updateException(String TableName, Long recordId, boolean isApproved) {
        HttpSession session = RequestContextHolder.currentRequestAttributes().getSession()
        
        /*
        def policyException = PolicyException.createCriteria().get() {
            and {
                eq("tableName", tableName)
                eq("recordId", (int) (long) recordId)
                isNull("dateOfAction")
            }
        }
        */
        //println TableName
        //println recordId
    
        
        def policyException = PolicyException.get((int) recordId) //findWhere(tableName : TableName, recordId : (int) recordId, dateOfAction: null)
        
        if(policyException)
        {
            policyException.approvingUser = UserMaster.get(session.user_id)
            policyException.dateOfAction = new Date()
            policyException.isApproved = isApproved
            policyException.save flush:true
        }
    }
    
     def updateException(String tableName, Long recordId, boolean isApproved, UserMaster userMaster) {
        HttpSession session = RequestContextHolder.currentRequestAttributes().getSession()
        
      //  println "user id ? " + user_id
        
        def policyException = PolicyException.createCriteria().get() {
            and {
                eq("tableName", tableName)
                eq("recordId", (int) (long) recordId)
                isNull("dateOfAction")
            }
        }
  
        //def policyException = PolicyException.get(recordId)
        
       
        policyException.approvingUser = userMaster
        policyException.dateOfAction = new Date()
        policyException.isApproved = isApproved
        policyException.save flush:true
    }
    

    def takeAction(classInstance, classStatus, String table, boolean isApproved) {
        def currentStatus = classInstance.status.code

        switch(currentStatus) {
            case '000':
                classInstance.status = classStatus.findByCode('010')
                break
            case '002':
                classInstance.status = classStatus.findByCode('990')
        }

        classInstance.save flush:true

        // Update Policy Exception
        updateException(table, classInstance.id, isApproved)
    }

    def getPendingPolicyExceptionCount() {
        HttpSession session = RequestContextHolder.currentRequestAttributes().getSession()
        
        return PolicyException.findAllByDateOfActionAndRequestingUser(null,UserMaster.get(session.user_id)).size()
    }
}
