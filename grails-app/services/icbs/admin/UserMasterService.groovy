package icbs.admin

import grails.transaction.Transactional
import javax.servlet.http.HttpSession
import org.apache.poi.hpsf.Currency
import org.springframework.web.context.request.RequestContextHolder
import icbs.lov.Designation

@Transactional
class UserMasterService {

    def updateTellerBalanceStatus(boolean isBalanced) {
    	HttpSession session = RequestContextHolder.currentRequestAttributes().getSession();

		def userMaster = UserMaster.get(session.user_id)
		userMaster.isTellerBalanced = isBalanced
		userMaster.save flush:true    	
    }

    def checkIfTellerBalanced() {
    	HttpSession session = RequestContextHolder.currentRequestAttributes().getSession();

    	def userMaster = UserMaster.get(session.user_id)

    	// If teller
    	//if(userMaster.designation == Designation.get(2)) {
    		// If not balanced
    		if(userMaster.isTellerBalanced == false) {
    			return false
    		}
    	//}
    	
    	return true
    }

    def checkIfAllTellerBalanced() {
        HttpSession session = RequestContextHolder.currentRequestAttributes().getSession();

        def userMaster = UserMaster.get(session.user_id)

        def branch = userMaster.branch

        def userList = UserMaster.createCriteria().list() {
            and {
                eq("branch", branch)
                eq("designation", Designation.get(2))
            }
        }

        def tellersBalanced = true

        for(user in userList) {
            if(user.isTellerBalanced == false) {
                tellersBalanced = false
                return
            }
        }

        return tellersBalanced
    }

    def checkIfChangePassword() {
        HttpSession session = RequestContextHolder.currentRequestAttributes().getSession();

        def userMaster = UserMaster.get(session.user_id)

        if(userMaster.isFirstLogin) {
            return true
        }

        return false
    }
    
    def initTellerBalance()
    {
        println "inittellerbalance service"
        HttpSession session = RequestContextHolder.currentRequestAttributes().getSession();

        def userMaster = UserMaster.get(session.user_id)
        def curlist = icbs.admin.Currency.getAll()
        def txnTellerBal
        println curlist
        //userMaster.branch.runDate
        
        curlist.each{ currency ->
            //if(icbs.admin.CurrencyDetail.findAllByCurrency(currency))
           // {
            if(!icbs.tellering.TxnTellerBalance.findAllByUserAndTxnDateAndCurrency(userMaster,Branch.get(userMaster.branchId).runDate,currency))
            {
            
                txnTellerBal = new icbs.tellering.TxnTellerBalance()
                txnTellerBal.txnDate = userMaster.branch.runDate
                txnTellerBal.user = userMaster
                txnTellerBal.currency = currency
                txnTellerBal.cashIn = 0
                txnTellerBal.cashOut = 0
                txnTellerBal.lastBalanceAmt = 0
                txnTellerBal.save flush:true
            }
            //}
           // println currency.name
            
        }
        
    }
    
    
}
