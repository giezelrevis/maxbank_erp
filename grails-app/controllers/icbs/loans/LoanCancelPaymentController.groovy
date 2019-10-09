package icbs.loans
import icbs.tellering.TxnLoanPaymentDetails

class LoanCancelPaymentController {

    def index(Integer max) {

        params.max = Math.min(max ?: 10, 100)

        if(params.offset == null){
            params.offset = 0
        }

        if (params.query == null) {
            println "Params query is null"
            def TxnLoanPaymentDetailsList = TxnLoanPaymentDetails.createCriteria().list (params) {

            }
            // def c = TxnLoanPaymentDetails.createCriteria()
            // def results = c.list(max: max, offset: offset) {

            // }s
            println params
            // respond ForexRate.withCriteria{eq 'tag', 1}, model:[params:params,ForexRateInstanceCount:  ForexRate.count()]
            respond TxnLoanPaymentDetailsList, model:[params:params,TxnLoanPaymentDetailsInstanceCount:  TxnLoanPaymentDetailsList.totalCount]
            // respond TxnLoanPaymentDetailsList, model:[params:params,TxnLoanPaymentDetailsInstanceCount:  TxnLoanPaymentDetailsList.totalCount]
            //return
        }
        else{
            println "Params query not null"
            println params
            def TxnLoanPaymentDetailsList = TxnLoanPaymentDetails.createCriteria().list (params) {

            }
            respond TxnLoanPaymentDetailsList, model:[params:params,TxnLoanPaymentDetailsInstanceCount: TxnLoanPaymentDetailsList.totalCount]
        }
        //return
    }

    def create () {

    }
    // def index(Integer max) {
    // // params.max = Math.min(max ?: 10, 100)
    //  params.max = Math.min(max ?: 25, 100)

    //     if(params.offset == null){
    //         params.offset = 0
    //     }

    //     if (params.sort == null) {
    //         params.sort = "loan.accountNo"
    //     }

    //     if (params.query == null) {
    //         println "null"
    //         def txnLoanPaymentDetailsList = TxnLoanPaymentDetails.list()
    //         //respond LoanLedger.list(params), model:[params:params, LoanLedgerInstanceCount:  LoanLedger.count()]
    //         respond txnLoanPaymentDetailsList , model:[params:params, txnLoanPaymentDetailInstanceCount: TxnLoanPaymentDetails.count()]
    //     } else{
    //         println params
    //         println "not null"
    //         def txnLoanPaymentDetailsList = TxnLoanPaymentDetails.list()
    //         /*
    //         def txnLoanPaymentDetailsList = TxnLoanPaymentDetails.createCriteria().list(params) {
    //            or{
    //                like("acctNo", "%${params.query.trim()}%")
    //             }
    //         }
    //         */
    //         respond txnLoanPaymentDetailsList, model:[params:params, txnLoanPaymentDetailInstanceCount: txnLoanPaymentDetailsList..count()]
    //     }
    //     return
    // }
    
    def reverseLoanPaymentTxn(TxnLoanPaymentDetails txnLoanPaymentDetailsInstance){
        respond txnLoanPaymentDetailsInstance
    }
}
