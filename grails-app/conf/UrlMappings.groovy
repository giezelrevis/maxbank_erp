class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?" {
            constraints {
                // apply constraints here
                //println "runable?"
            }
        }
        
       // println "urlmappins"

        "/"(controller:"authentication", action:"login")
        "500"(view:'/error')
        
        "/loan"(controller:"loan", action:"index")
        "/loan/show/$id"(controller:"loan", action:"show")
        "/loan/edit/$id"(controller:"loan", action:"edit")
        "/loan/update/$id"(controller:"loan", action:"update")
        "/loan/reschedule/$id"(controller:"loan", action:"reschedule")
        "/loan/restructure/$id"(controller:"loan", action:"reschedule")
        "/loan/renew/$id"(controller:"loan", action:"renew")
        "/loanAmendment"(controller:"loan", action:"index")
        "/loanAmendment/show/$id"(controller:"loan", action:"show")
        "/loanAmendment/edit/$id"(controller:"loan", action:"edit")
        "/loanAmendment/update/$id"(controller:"loan", action:"update")
        "/loanInterestAccrual"(controller:"loan", action:"index")
        "/loanInterestAccrual/show/$id"(controller:"loan", action:"show")
        "/loanRepricing"(controller:"loan", action:"index")
        "/loanRepricing/show/$id"(controller:"loan", action:"show")
        "/loanReschedule"(controller:"loan", action:"index")
        "/loanReschedule/show/$id"(controller:"loan", action:"show")
        "/loanReschedule/reschedule/$id"(controller:"loan", action:"reschedule")
        "/loanRestructure"(controller:"loan", action:"index")
        "/loanRestructure/show/$id"(controller:"loan", action:"show")
        "/loanRestructure/restructure/$id"(controller:"loan", action:"reschedule")
        "/loanRenewal"(controller:"loan", action:"index")
        "/loanRenewal/show/$id"(controller:"loan", action:"show")
        "/loanRenewal/renew/$id"(controller:"loan", action:"renew")
        "/loanGLClassification"(controller:"loan", action:"index")
        "/loanGLClassification/show/$id"(controller:"loan", action:"show")
        "/loanBranchTransfer"(controller:"loan", action:"index")
        "/loanBranchTransfer/show/$id"(controller:"loan", action:"show")
        "/loanApproval"(controller:"loan", action:"index")
        "/loanApproval/show/$id"(controller:"loan", action:"show")
    	"/loanTermination"(controller:"loan", action:"index")
        "/loanTermination/show/$id"(controller:"loan", action:"show")
        "/loanWriteOff"(controller:"loan", action:"index")
        "/loanWriteOff/show/$id"(controller:"loan", action:"show")
        "/loanWriteOff/writeOff/$id"(controller:"loan", action:"writeOff")
        "/loanROPA"(controller:"loan", action:"index")
        "/loanROPA/show/$id"(controller:"loan", action:"show")
        "/loanROPA/createSCR/$id"(controller:"loan", action:"renew")
        
        
        "/deposit/viewCheckbook/"(controller:"deposit", action:"index")
        "/deposit/viewPassbook/"(controller:"deposit", action:"index")
        "/deposit/viewCTD/"(controller:"deposit", action:"index")
        "/deposit/edit/"(controller:"deposit", action:"index")
        "/deposit/viewHold/"(controller:"deposit", action:"index")
        "/deposit/viewStandingOrder/"(controller:"deposit", action:"index")
        "/deposit/viewMemo/"(controller:"deposit", action:"index")
        "/deposit/viewStopPaymentOrder/"(controller:"deposit", action:"index")
        "/deposit/viewDepositStatus/"(controller:"deposit", action:"index")
        "/deposit/viewInterestRateMaintenance/"(controller:"deposit", action:"index")
        "/deposit/viewSweep/"(controller:"deposit", action:"index")
        "/deposit/viewFundTransfer/"(controller:"deposit", action:"index")
        "/deposit/viewClearChecksManually/"(controller:"deposit", action:"index")
        "/deposit/viewManualFdRollover/"(controller:"deposit", action:"index")

        //"/loanCancelPayment/index"(controller:"loanCancelPayment", action:"index", params:"[max:10, offset:0]")
        //"/loanCancelPayment/index"(uri: "/loanCancelPayment/index?max=10&query=&offset=0")

	}
}
