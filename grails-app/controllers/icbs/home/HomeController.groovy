package icbs.home

import icbs.admin.UserMessage
import icbs.admin.UserMaster

import icbs.tellering.TxnTellerBalance
import icbs.tellering.TxnFile
import icbs.tellering.TxnCashCheckBlotter
import icbs.tellering.TxnBillsPayment
import icbs.admin.Branch
								 


class HomeController {

	def landing() {
            //println "landing always"
            //println "Timeout: ${session.getMaxInactiveInterval()} seconds"
            
        def tbCash = TxnCashCheckBlotter.createCriteria().list() {
            and{
                eq("user",UserMaster.get(session.user_id))   
                //eq("txnFile.txnDate",Branch.get(1).runDate)
            }
            order("txnFile", "asc")
        }  
        def userInstance = UserMaster.get(session.user_id)
            respond UserMessage.findAllByRecipientAndIsRead(UserMaster.get(session.user_id), false, [max:10]), model:[params:params,
                    UserMessageInstanceCount:  UserMessage.count(),userInstance:userInstance,tbCash:tbCash]   
            return
            
	}
        
}
