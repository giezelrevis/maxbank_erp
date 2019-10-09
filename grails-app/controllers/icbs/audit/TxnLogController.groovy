package icbs.audit

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import icbs.tellering.TxnFile

@Transactional(readOnly = true)
class TxnLogController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        if (params.sort == null) {  // default ordering
            params.sort = "id"
        }

        if (params.query == null) {  // show all instances            
            respond TxnFile.list(params), model:[TxnFileInstanceCount: TxnFile.count()]
        }
        else {    // show query results
            def txnFileList = TxnFile.createCriteria().list(params) {
                or {
                    ilike("acctNo", "%${params.query}%")
                    ilike("txnParticulars", "%${params.query}%")
                }
            }
            respond txnFileList, model:[TxnFileInstanceCount: txnFileList.totalCount]
        }

    }

}
