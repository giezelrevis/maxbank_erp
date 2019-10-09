package icbs.cif


import java.text.SimpleDateFormat 
import java.util.Date
import groovy.sql.Sql
import grails.converters.JSON
import icbs.deposit.*
import icbs.tellering.*
import icbs.loans.Loan
import groovy.sql.Sql
import icbs.tellering.TxnCOCI
import icbs.tellering.TxnFile
import icbs.admin.Branch
import icbs.gl.*
import accounting.bankpayables.AccountsPayables
    
class SearchController {
    def dataSource
//        def dataSource
    /*params.searchQuery query string*/
    /*params.searchType is the type to search*/
    /*if CID ==1*/
    def index(){
        redirect(action: "search", params:params);
    }
    
    private def searchCustomer(params){
        if (params.sort == null) {
            params.sort = "name1"
        }
        if(params.order==null){
            params.order= "asc"
        }
        println(params)
        if(params.searchQuery==''||params.searchQuery==null){
           println" pumasok sa null query!"
           render(template:"searchTemplate/searchCustomer",model:[params:params,domainInstanceList: Customer.list(params), domainInstanceCount: Customer.count()]) as JSON
           return
        }else{
            def list = Customer.createCriteria().list (params) {
                or{
                    ilike("name1", "%${params.searchQuery}%")
                    ilike("name2", "%${params.searchQuery}%")
                    ilike("name3", "%${params.searchQuery}%")
                    ilike("name4", "%${params.searchQuery}%")
                    ilike("customerId", "%${params.searchQuery}%")
                    ilike("displayName", "%${params.searchQuery}%")
                }
                order("displayName", "asc")
            }
            render(template:"searchTemplate/searchCustomer",model:[params:params,domainInstanceList: list, domainInstanceCount: list.totalCount]) as JSON
        }
    }
    
   private def searchCID(params){
     def customer = Customer.get(params.searchQuery)
     if(customer) {
        render customer as JSON
     } else {
         render 'Not found'
     }
    }
    
    private def searchAcctNo(params){
        println('hey')
        def loanAcct = Loan.get(params.searchQuery)
        if(loanAcct) {
            render loanAcct as JSON
        } else {
            render 'Not found'
        }
    }
    
    private def searchDeposit(params){
        println('pumasok sa search deposit')
        println(params)
        if (params.sort == null) {
            params.sort = "acctName"
        }
        if(params.order==null){
            params.order= "asc"
        }
        if(params.searchQuery==''||params.searchQuery==null){
           println" pumasok sa null query!"
           if(params.customFilter)
           {
               def newlist = Deposit.findAllByType(icbs.lov.DepositType.get(params.customFilter),params)
               def cntBy = Deposit.countByType(icbs.lov.DepositType.get(params.customFilter),params)
               render(template:"searchTemplate/searchDeposit",model:[params:params,domainInstanceList: newlist, domainInstanceCount: cntBy]) as JSON
           } else {
                render(template:"searchTemplate/searchDeposit",model:[params:params,domainInstanceList: Deposit.list(params), domainInstanceCount: Deposit.count()]) as JSON
           }
           return
        }else{
            if(params.searchType=='1'){
                searchDepositOwner(params)
                return
            }
            else if (params.searchType=='0'){
                searchDepositID(params)
                return
            }
        }
        return
    }
    private def searchPassbook(params){
        if (params.sort == null) {
            params.sort = "dateIssued"
        }
        if(params.order==null){
            params.order= "asc"
        }
        def list = IssuePassbook.createCriteria().list (params) {
                eq("deposit.id",params.id.toLong())
                if (params.searchType) {
                }
                
        }
        render(template:"searchTemplate/deposit/passbook/viewGrid",model:[params:params,domainInstanceList:list , domainInstanceCount: list.totalCount]) as JSON
    }
    private def searchChecks(params){
        if (params.sort == null) {
            params.sort = "chequeDate"
        }
        if(params.order==null){
            params.order= "asc"
        }
        def list = Cheque.createCriteria().list (params) {
                eq("chequebook.id",params.id.toLong())
                if (params.searchType) {
                }
                order("chequeNo","asc")
        }
        render(template:"searchTemplate/deposit/check/viewGrid",model:[params:params,domainInstanceList:list , domainInstanceCount: list.totalCount]) as JSON
    }
    private def searchCheckbook(params){
        if (params.sort == null) {
            params.sort = "dateIssued"
        }
        if(params.order==null){
            params.order= "asc"
        }
        def list = Chequebook.createCriteria().list (params) {
                eq("deposit.id",params.id.toLong())
                if (params.searchType) {
                }
                
        }
        render(template:"searchTemplate/deposit/checkbook/viewGrid",model:[params:params,domainInstanceList:list , domainInstanceCount: list.totalCount]) as JSON
    }
    private def searchCTD(params){
        if (params.sort == null) {
            params.sort = "dateIssued"
        }
        if(params.order==null){
            params.order= "asc"
        }
        def list = IssueCTD.createCriteria().list (params) {
                eq("deposit.id",params.id.toLong())
                if (params.searchType) {
                }
                
        }
        render(template:"searchTemplate/deposit/ctd/viewGrid",model:[params:params,domainInstanceList:list , domainInstanceCount: list.totalCount]) as JSON
    }
    private def searchHold(params){
        if (params.sort == null) {
            params.sort = "maturityDate"
        }
        if(params.order==null){
            params.order= "asc"
        }
        println("hold params"+params);
        def list = Hold.createCriteria().list (params) {
                eq("deposit.id",params.id.toLong())
                if (params.searchType) {
                }
                
        }
        render(template:"searchTemplate/deposit/hold/viewGrid",model:[params:params,domainInstanceList:list , domainInstanceCount: list.totalCount]) as JSON
    }
    private def searchStandingOrder(params){
        if (params.sort == null) {
            //params.sort = "dateIssued"
        }
        if(params.order==null){
            params.order= "asc"
        }
        def list = StandingOrder.createCriteria().list (params) {
                eq("fundingDeposit.id",params.id.toLong())
                if (params.searchType) {
                }
                
        }
        render(template:"searchTemplate/deposit/standingOrder/viewGrid",model:[params:params,domainInstanceList:list , domainInstanceCount: list.totalCount]) as JSON
    }
    private def searchStopPaymentOrder(params){
        if (params.sort == null) {
           // params.sort = "dateIssued"
        }
        if(params.order==null){
            params.order= "asc"
        }
        def list = StopPaymentOrder.createCriteria().list (params) {
                cheque{
                    chequebook{
                        eq("deposit.id",params.id.toLong())
                    }
                }
                if (params.searchType) {
                }
        }
        render(template:"searchTemplate/deposit/stopPaymentOrder/viewGrid",model:[params:params,domainInstanceList:list , domainInstanceCount: list.totalCount]) as JSON
    }
     private def searchSweep(params){
         println "searchSweep params "+params
        if (params.sort == null) {
            //params.sort = "dateIssued"
        }
        if(params.order==null){
            params.order= "asc"
        }
        def list = Sweep.createCriteria().list (params) {
                eq("fundingDeposit.id",params.id.toLong())
                if (params.searchType) {
                }
        }
        render(template:"searchTemplate/deposit/sweep/viewGrid",model:[params:params,domainInstanceList:list , domainInstanceCount: list.totalCount]) as JSON
    }
    private def searchClearChecksManually(params){
        if (params.sort == null) {
            //params.sort = "dateIssued"
        }
        if(params.order==null){
            params.order= "asc"
        }
        def list = icbs.tellering.TxnCOCI.createCriteria().list (params) {
                eq("acctNo",Deposit.read(params.id.toLong())?.acctNo)
                if (params.searchType) {
                }  
        }
        render(template:"searchTemplate/deposit/clearChecksManually/viewGrid",model:[params:params,domainInstanceList:list , domainInstanceCount: list.totalCount]) as JSON
    }
    /* Main Router*/
    def search(int max){
        println'search params!'+params
        params.max = Math.min(max ?: 10, 100)   // no. of items on display
        if(!params.searchDomain){
            searchCustomer(params)
        }else if(params.searchDomain.equals("deposit")){
            searchDeposit(params)
        }else if(params.searchDomain.equals("deposit-checkbook")){
            searchCheckbook(params)
        }else if(params.searchDomain.equals("deposit-check")){
            searchChecks(params)
        }else if(params.searchDomain=="deposit-passbook"){
            searchPassbook(params)
        }
        else if(params.searchDomain=="deposit-ctd"){
            searchCTD(params)
        }
        else if(params.searchDomain=="deposit-hold"){
            searchHold(params)
        }
        else if(params.searchDomain=="deposit-standingOrder"){
            searchStandingOrder(params)
        }
        else if(params.searchDomain=="deposit-stopPaymentOrder"){
            searchStopPaymentOrder(params)
        }
        else if(params.searchDomain=="deposit-sweep"){
            searchSweep(params)
        }
        else if(params.searchDomain=="deposit-clearChecksManually"){
            searchClearChecksManually(params)
        }
        else if(params.searchDomain=="deposit-txn"){
            searchDepositTransactions(params)
        }
//        For Reprint
        else if(params.searchDomain=="depositreprint"){
            searchDepositTransactionsReprint(params)
        }
        else if(params.searchDomain=="gl-sortcode"){
            searchSortCodes(params)
        } 
        else if(params.searchDomain=="gl-glcode"){
            searchGlCodes(params)
        } 

        else if(params.searchDomain=="gl-deposits"){
            searchGlDeposits(params)
        }

        else if(params.searchDomain=="gl-loans"){
            searchGlLoans(params)
        }

        else if(params.searchDomain=="gl-aps"){
            println "pasok sa gl aps"
            searchAps(params)
        }

        return
    }
    
 /*Reprint Grid*/
    private def searchDepositTransactionsReprint(params){
        println "params "+params
        def reprintPassbookInstance = params
        servletContext.reprint = reprintPassbookInstance
        println " Search Controller "+servletContext.reprint
        
        def sql = new Sql(dataSource)
        def type = params.type.toInteger()
        def id = params.id.toInteger()  
        //Date txndate = new SimpleDateFormat("MM/dd/yyyy").parse(params.txndate)
        //def txnDates = params.txndate.format('yyyy-mm-dd')
        
        
        //def startdate = Date.parse("yyyy-mm-dd", params.startdate)
        //def enddate = Date.parse("yyyy-mm-dd", params.enddate)
        //String newstartdate = startdate.format('yyyy-mm-dd')
        //String newenddate = enddate.format('yyyy-mm-dd')
        
//      For Fixed Deposit
        if(type == 3){
            println("Txn file no: "+  Date.parse("yyyy-mm-dd", params.txndate))
            
            def results = TxnDepositAcctLedger.createCriteria().list{ 
                and {
                    //params.sort = "id"
                    
                    ge("txnDate", Date.parse("yyyy-mm-dd", params.txndate))
                    eq("acct", Deposit.get(params.id))
                    isNotNull("passbookLine")                
                }
            }
            /*
            def c = TxnDepositAcctLedger.createCriteria()
            def results = c.list {

                //between("txnDate", startdate, enddate)
                    params.sort = "id"
                    eq("acct", Deposit.get(params.id))
                    isNotNull("passbookLine")
            }
            */
            render(template:"searchTemplate/deposit/reprintGrid/viewGrid", model:[params:params,  domainInstanceList: results]) as JSON
        }
        else{
            println("Txn file no: "+  Date.parse("yyyy-mm-dd", params.txndate))
            
            def results = TxnDepositAcctLedger.createCriteria().list{ 
                and {
                    //params.sort = "id"
                    
                    ge("txnDate", Date.parse("yyyy-mm-dd", params.txndate))
                    eq("acct", Deposit.get(params.id))
                    isNotNull("passbookLine")                
                }
            }
            /*
            def c = TxnDepositAcctLedger.createCriteria()
            def results = c.list {

                //between("txnDate", startdate, enddate)
                    params.sort = "id"
                    eq("acct", Deposit.get(params.id))
                    isNotNull("passbookLine")
            }
            */
            render(template:"searchTemplate/deposit/reprintGrid/viewGrid", model:[params:params,  domainInstanceList: results]) as JSON
        }
    }
    private def searchDepositTransactions(params){
        def list = TxnDepositAcctLedger.createCriteria().list (params) {
                acct{
                    eq('id',params.id.toLong())
                }
                if (params.searchType) {
                    println(params.searchQuery1)
                    or{
                        customer{
                            ilike("displayName", "%${params.searchQuery}%")
                        }
                    }
                    
                }
                order("id","asc")
        }
        println 'list :'+list
        render(template:"searchTemplate/deposit/txn/viewGrid",model:[params:params,domainInstanceList: list, domainInstanceCount: list.totalCount]) as JSON
    }
    /*deposit Search Parameters*/
    
    private def searchDepositOwner(params){
        println" pumasok sa name query"
        def list = Deposit.createCriteria().list (params) {
                if (params.searchType) {
                    println(params.searchQuery1)
                    or{
                        customer{
                            ilike("displayName", "%${params.searchQuery}%")
                        }
                    }
                   
                }
        }
        render(template:"searchTemplate/searchDeposit",model:[params:params,domainInstanceList: list, domainInstanceCount: list.totalCount]) as JSON
    }
    
    /*Customer Search Parameters*/
    private def searchName(params){
        println" pumasok sa name query"
        def list = Customer.createCriteria().list (params) {
                if (params.searchType) {
                    or{
                        ilike("name1", "%${params.searchQuery}%")
                        ilike("name2", "%${params.searchQuery}%")
                        ilike("name3", "%${params.searchQuery}%")
                        ilike("name4", "%${params.searchQuery}%")
                    }
                }
        }
        render(template:"searchTemplate/searchCustomer",model:[params:params,domainInstanceList: list, domainInstanceCount: list.totalCount]) as JSON
    }
    
    private def searchLoanID(){
    
    
    }
    private def searchDepositID(params){
        def list = Deposit.createCriteria().list (params) {
                if (params.searchType) {
                    println(params.searchQuery)
                    and{
                        ilike("acctNo", "%${params.searchQuery}%")
                    }
                    
                }
        }
        println list
        render(template:"searchTemplate/searchDeposit",model:[params:params,domainInstanceList: list, domainInstanceCount: list.totalCount]) as JSON
    }

    private def searchSortCodes(params){
        
        def list = GlSortCode.createCriteria().list (params) {
                if (params.searchQuery) {
                    or{
                        ilike("sort_code", "%${params.searchQuery}%")
                        ilike("sort_name", "%${params.searchQuery}%")
                    }
                }
        }

        render(template:"searchTemplate/gl/searchSortCode",model:[params:params,domainInstanceList: list, domainInstanceCount: list.totalCount]) as JSON

    }

    private def searchGlCodes(params){
        
        // Use branch_id to filter
        // use currency to filter
        def list = GlAccount.createCriteria().list (params) {
                eq("branch.id", params.branch_id.toLong())
                eq("currency.id", params.currency.toLong())
                eq("financialYear", Branch.get(1).runDate.format('yyyy').toInteger())
                if (params.searchQuery) {
                    or{
                        ilike("code", "%${params.searchQuery}%")
                        ilike("name", "%${params.searchQuery}%")
                    }
                }
                order("code")
        }

        render(template:"searchTemplate/gl/searchGlCode",model:[params:params,domainInstanceList: list, domainInstanceCount: list.totalCount]) as JSON

    }

    private def searchGlDeposits(params){
        
        // Use branch_id to filter
        def list = Deposit.createCriteria().list (params) {
                eq("branch.id", params.branch_id.toLong())
                if (params.searchQuery) {
                    or{
                        ilike("acctNo", "%${params.searchQuery}%")
                        ilike("acctName", "%${params.searchQuery}%")
                    }
                }
        }

        render(template:"searchTemplate/gl/searchDeposit",model:[params:params,domainInstanceList: list, domainInstanceCount: list.totalCount]) as JSON

    }

    private def searchGlLoans(params){
        
        // Use branch_id to filter
        def list = Loan.createCriteria().list (params) {
                eq("branch.id", params.branch_id.toLong())
                if (params.searchQuery) {
                    or{
                        ilike("accountNo", "%${params.searchQuery}%")
                        'customer'{
                           or{
                               ilike("displayName","%${params.searchQuery}%")
                           }
                       }
                    }
                }
        }

        render(template:"searchTemplate/gl/searchLoan",model:[params:params,domainInstanceList: list, domainInstanceCount: list.totalCount]) as JSON

    }

    private def searchAps(params){
        
        // Use branch_id to filter
        println "Params here im in"+ params
        def list = AccountsPayables.createCriteria().list (params) {

                eq("tag", 1)
                if (params.searchQuery) {
                        or{
                            ilike("glaccount", "%${params.searchQuery}%")

                            //'customer'{
                               or{
                                   ilike("clientname","%${params.searchQuery}%")
                               }
                           //}
                        }
                }
        }

        println "list here "+list
        println "params here 2 "+params
        render(template:"searchTemplate/gl/searchAp",model:[params:params,domainInstanceList: list, domainInstanceCount: list.totalCount]) as JSON

    }

    def viewCheckDepDetails(params) {
        def txnCOCIList = TxnCOCI.createCriteria().list (params) {
                eq("txnFile.id", params.id.toLong())
        }    
       // render(template:"searchTemplate/deposit/viewCheckDepDetails/viewGrid",model:[params:params,domainInstanceList: list, domainInstanceCount: list.totalCount]) as JSON
       println txnCOCIList
       respond txnCOCIList, model:[txnCOCICount: txnCOCIList.totalCount]
    }
}
