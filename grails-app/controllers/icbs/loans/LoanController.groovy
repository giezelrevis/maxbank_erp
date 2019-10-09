package icbs.loans


import grails.converters.JSON
import grails.converters.deep.JSON

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

import org.apache.poi.ss.formula.functions.Irr
import org.apache.poi.ss.formula.functions.FinanceLib
import icbs.tellering.TxnLoanPaymentDetails
import java.io.ByteArrayInputStream
import java.io.ByteArrayOutputStream
import java.io.ObjectInputStream
import java.io.ObjectOutputStream
import icbs.lov.LoanProvisionBsp
import icbs.admin.Branch
import icbs.admin.Product
import icbs.admin.UserMaster
import icbs.deposit.Deposit
import icbs.admin.Currency
import icbs.admin.Institution
import icbs.loans.LoanApplication
import icbs.loans.LoanApplicationComaker.*
import icbs.loans.TxnRopaDetails
import icbs.loans.PenaltyIncomeScheme
import icbs.lov.LoanAcctStatus
import icbs.lov.LoanSpecialType
import icbs.lov.TxnType
import icbs.admin.TxnTemplate
import icbs.deposit.Hold
import icbs.deposit.Deposit
import icbs.lov.HoldStatus
import icbs.lov.HoldType
import icbs.lov.ConfigItemStatus
import icbs.lov.SweepType
import icbs.lov.SweepRule
import icbs.lov.SweepStatus
import icbs.tellering.TxnFile
import icbs.gl.GlAccount
import icbs.gl.CfgAcctGlTemplate
import org.hibernate.Session
import org.hibernate.SessionFactory
import icbs.reports.LoanListingEntry
import groovy.time.TimeCategory
import icbs.loans.LoanSweep
import groovy.sql.Sql
//new imports
import java.text.SimpleDateFormat
import org.springframework.dao.DataIntegrityViolationException
import org.springframework.web.multipart.MultipartFile
import java.lang.*
// ===================================


class LoanController {
    def jrxmlTcId
    def jasperService
    def transactionFileId 
    def dataSource
    def auditLogService
    static allowedMethods = [save: "POST", update: ["PUT","POST"], delete: "DELETE"]
    
    def loanService   
    def glTransactionService

    def index(Integer max) {
      
        def module
        if (params?.module)
            module = params?.module
        else
            module = getModule(request?.forwardURI)
        def title = getTitle(module)

      //  params.max = Math.min(max ?: 10, 100)     //replace to change min to 25 line
        params.max = Math.min(max ?: 25, 100)
        
        if (params.sort == null) {
            params.sort = "id"
        }

        if (params.query == null) {
            respond Loan.list(params), model:[params:params, LoanInstanceCount: Loan.count(), module:module, title:title]
        } else {
            def LoanList = Loan.createCriteria().list(params) {
               or{
                 ilike("accountNo","%${params.query.trim()}%")
                    'customer'{
                        or{
                            ilike("displayName","%${params.query.trim()}%")
                        }
                    }
                    if(params.query.trim().isLong()){
                        idEq(params.query.trim().toLong())
                        
                    }
                }
            }
            
            respond LoanList, model:[params:params, LoanInstanceCount: LoanList.totalCount, module:module, title:title]
        }
        return
    }
    
    def printLoanInstallment(){
        try {    
            //println"asdf "+session["jrxmlTcId"]
            params._name = "INSTALLMENT SCHEDULE FINAL VERSION"
            params._format ="PDF"//required caps
            params._file ="LOAN_INSTALLMENT_SCHEDULE_WITHOUT_EIR_NOLOGO.jasper" //jasper file name
            params.id=  session["jrxmlTcId"]
//            params.id = 1 //jasper param name
            def reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            byte[] bytes = jasperService.generateReport(reportDef).toByteArray()
            //set the byte content on the response. This determines what is shown in your browser window.       
            response.setContentType('application/pdf')
            response.setContentLength(bytes.length)

            response.setHeader('Content-disposition', 'inline; filename=quote.pdf')
            response.setHeader('Expires', '0');
            response.setHeader('Cache-Control', 'must-revalidate, post-check=0, pre-check=0');
            response.outputStream << bytes
            response.outputStream.flush()
        }catch(Exception e) {
            //deal with your exception here
            e.printStackTrace()
        }        
    }
    
    def printDisclosure(){    
        try {    
            println"asdf "+session["jrxmlTcId"]
            params._name = "Disclosure Statement"
            params._format ="PDF"//required caps
            params._file ="Disclosure_Statement.jasper" //jasper file name
            params.id=  session["jrxmlTcId"]
//            params.id = 1 //jasper param name
            def reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            byte[] bytes = jasperService.generateReport(reportDef).toByteArray()
            //set the byte content on the response. This determines what is shown in your browser window.       
            response.setContentType('application/pdf')
            response.setContentLength(bytes.length)

            response.setHeader('Content-disposition', 'inline; filename=quote.pdf')
            response.setHeader('Expires', '0');
            response.setHeader('Cache-Control', 'must-revalidate, post-check=0, pre-check=0');
            response.outputStream << bytes
            response.outputStream.flush()
        }catch(Exception e) {
            //deal with your exception here
            e.printStackTrace()
        }
    }  
     def printPromissory(){    
        try {    
            println"---------------- "
            params._name = "Promissory"
            params._format ="PDF"//required caps
            params._file ="PN.jasper" //jasper file name
            params.id =  session["jrxmlTcId"]
//            params.id = 1 //jasper param name
            def reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            byte[] bytes = jasperService.generateReport(reportDef).toByteArray()
            //set the byte content on the response. This determines what is shown in your browser window.       
            response.setContentType('application/pdf')
            response.setContentLength(bytes.length)

            response.setHeader('Content-disposition', 'inline; filename=quote.pdf')
            response.setHeader('Expires', '0');
            response.setHeader('Cache-Control', 'must-revalidate, post-check=0, pre-check=0');
            response.outputStream << bytes
            response.outputStream.flush()
        }catch(Exception e) {
            //deal with your exception here
            e.printStackTrace()
        }
    } 
    //print loan inquiry
    def printLoanInquiry(){
        try {    
            println"---------------- "
            params._name = "loan_inquiry"
            params._format ="PDF"//required caps
            params._file ="loan_inquiry.jrxml" //jasper file name
            params.id =  session["jrxmlTcId"]
//            params.id = 1 //jasper param name
            def reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            byte[] bytes = jasperService.generateReport(reportDef).toByteArray()
            //set the byte content on the response. This determines what is shown in your browser window.       
            response.setContentType('application/pdf')
            response.setContentLength(bytes.length)

            response.setHeader('Content-disposition', 'inline; filename=quote.pdf')
            response.setHeader('Expires', '0');
            response.setHeader('Cache-Control', 'must-revalidate, post-check=0, pre-check=0');
            response.outputStream << bytes
            response.outputStream.flush()
        }catch(Exception e) {
            //deal with your exception here
            e.printStackTrace()
        }        
    }
    //Loan Approval Slip
    def printLoanApprovalSlip(){    
        try {    
            println"---------------- "
            params._name = "LoanApprovalSlip"
            params._format ="PDF"//required caps
            params._file ="TransactionSlipLoanSample1.jrxml" //jasper file name
            params.id =  session["jrxmlTcId"]
//            params.id = 1 //jasper param name
            def reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            byte[] bytes = jasperService.generateReport(reportDef).toByteArray()
            //set the byte content on the response. This determines what is shown in your browser window.       
            response.setContentType('application/pdf')
            response.setContentLength(bytes.length)

            response.setHeader('Content-disposition', 'inline; filename=quote.pdf')
            response.setHeader('Expires', '0');
            response.setHeader('Cache-Control', 'must-revalidate, post-check=0, pre-check=0');
            response.outputStream << bytes
            response.outputStream.flush()
        }catch(Exception e) {
            //deal with your exception here
            e.printStackTrace()
        }
    }
    

    def search(Integer max) {
     //   params.max = Math.min(max ?: 10, 100)   //replace to change min to 25 line
//     println "Loan Params : " + params
//     println "Loan Params query : " + params.query
//     println "Loan Params sort : " + params.sort
//     println "Loan Params flag : " + params.flag
     def flags = params.flag
     if(!flags){
         flags = 0
     }
     params.max = Math.min(max ?: 25, 100)

        if (params.sort == null) {
            params.sort = "id"

        }
        
        if (params.query == null || params.query.trim() == "") {  // show all instances
//            if(flags.toInteger() == 6){
//                def stat = LoanAcctStatus.get(3)
//                def result = Loan.createCriteria().list(params){
//                    eq('status', stat)
//                }
//                render(template:"search/searchLoan", model:[params:params, domainInstanceList:result, domainInstanceCount:result.totalCount]) as JSON
//            }
//            else
//            {
                render(template:"search/searchLoan", model:[params:params, domainInstanceList:Loan.list(params), domainInstanceCount:LoanApplication.count()]) as JSON
//            }
        } 
        else 
        {    
//            if(flags.toInteger() == 6){
//                println "TESTING : !!!"
//                // show query results
//                def result = Loan.createCriteria().list(params){
//                            or{
//                       ilike("accountNo","%${params.query.trim()}%")
//                       eq('status', stat)
//                       'customer'{
//                           or{
//                               ilike("displayName","%${params.query.trim()}%")
//                               eq('status', stat)
//                           }
//                       }
//                       if(params.query.trim().isLong()){
//                           idEq(params.query.trim().toLong())
//                       }
//                   }
//               }
//               render(template:"search/searchLoan", model:[params:params, domainInstanceList:result, domainInstanceCount:result.totalCount]) as JSON
//            }
//            else
//            {
                // show query results
                def result = Loan.createCriteria().list(params){
                            or{
                       ilike("accountNo","%${params.query.trim()}%")
                       'customer'{
                           or{
                               ilike("displayName","%${params.query.trim()}%")
                           }
                       }
                       if(params.query.trim().isLong()){
                           idEq(params.query.trim().toLong())
                       }
                   }
               }
//               render(template:"search/searchLoan", model:[params:params, domainInstanceList:result, domainInstanceCount:result.totalCount]) as JSON
//            }
            
 
            render(template:"search/searchLoan", model:[params:params, domainInstanceList:result, domainInstanceCount:result.totalCount]) as JSON
        }            
        return
    }    

    def getModule(String url) {
        if (url =~ /^.*\/loanAmendment.*$/) {
            return "loanAmendment"
        } else if (url =~ /^.*\/loanInterestAccrual.*$/) {
            return "loanInterestAccrual"            
        } else if (url =~ /^.*\/loanRepricing.*$/) {
            return "loanRepricing" 
        } else if (url =~ /^.*\/loanReschedule.*$/) {
            return "loanReschedule" 
        } else if (url =~ /^.*\/reschedule.*$/) {
            return "loanReschedule"             
        } else if (url =~ /^.*\/loanRestructure.*$/) {
            return "loanRestructure" 
        } else if (url =~ /^.*\/restructure.*$/) {
            return "loanRestructure" 
        } else if (url =~ /^.*\/loanGLClassification.*$/) {
            return "loanGLClassification"
        } else if (url =~ /^.*\/loanRenewal.*$/) {
            return "loanRenewal"  
        } else if (url =~ /^.*\/loanBranchTransfer.*$/) {
            return "loanBranchTransfer"  
        } else if (url =~ /^.*\/loanApproval.*$/) {
            return "loanApproval"  
        } else if (url =~ /^.*\/loanTermination.*$/) {
            return "loanTermination"       
        } else if (url =~ /^.*\/loanWriteOff.*$/) {
            return "loanWriteOff"       
        } else if (url =~ /^.*\/loanROPA.*$/) {
            return "loanROPA"       
        } else {  // if (url =~ /^.*\/loan(\/|\/index|\/show\/\d*)?$/) {
            return "loan"
        }
    }

    def getTitle(String module) {
        if (module == "loan") {
            return "Loan Accounts"
        } else if (module == "loanAmendment") {
            return "Loan Account Amendment"
        } else if (module == "loanInterestAccrual") {
            return "Loan Account Interest Accrual"
        } else if (module == "loanRepricing") {
            return "Loan Account Repricing"
        } else if (module == "loanReschedule") {
            return "Loan Account Reschedule"
        } else if (module == "loanRestructure") {
            return "Loan Account Restructure"
        } else if (module == "loanGLClassification") {
            return "Loan GL Classification"
        } else if (module == "loanRenewal") {
            return "Loan Account Renewal"
        } else if (module == "loanBranchTransfer") {
            return "Loan Account Branch Transfer"
        } else if (module == "loanApproval") {
            return "Loan Account Approval"
        } else if (module == "loanTermination") {
            return "Loan Account Termination"
        } else if (module == "loanWriteOff") {
            return "Loan Account Write-Off"
        } else if (module == "loanROPA") {
            return "Loan ROPA"
        }
    }

    def getLoanDetailsAjax() {
        def loanInstance = null
        if (params?.id) {
            loanInstance = Loan.get(params.id)

        }

        render(template:"search/loanDetails", model:[loanInstance: loanInstance]) as JSON
        return
    }

    def getTermAjax() {

        
        def term = params?.term ? params.term.toInteger() : 0
        def numInstallments = params?.numInstallments ? params.numInstallments.toInteger() : 0
        def frequency = params?.frequency ? params.frequency.toInteger() : 0
        def openingDate = params?.openingDate ? new Date().parse("MM/dd/yyyy", params?.openingDate) : null
        
        def firstInstallmentDate = params?.firstInstallmentDate ? new Date().parse("MM/dd/yyyy", params?.firstInstallmentDate) : null

        def interestIncomeScheme = null    
        if (params?.interestIncomeScheme) {
            interestIncomeScheme = InterestIncomeScheme.get(params.interestIncomeScheme)
        }

        def gracePeriod = interestIncomeScheme?.gracePeriod ?: 0
        def installmentType = interestIncomeScheme?.installmentType.id
        def installmentCalculation = interestIncomeScheme?.installmentCalcType.id

        def dueDate
        def prevDueDate = firstInstallmentDate  
        def baseDate = firstInstallmentDate   

        if (installmentType != 5 && installmentCalculation != 1 && installmentCalculation != 6) {
            for(int i = 1; i <= gracePeriod; i++) {                      
                dueDate = loanService.getNextDueDate(prevDueDate, baseDate, frequency)
                prevDueDate = dueDate
                baseDate = baseDate
              
            }
        }

        if (installmentCalculation == 1) {  // single payment   
            term = term + gracePeriod            

            render(template:"search/term", model:[term: term]) as JSON
            return
        } else if (installmentType == 5 || installmentCalculation == 6) {  // manual
            def lastInstallment = session["installments"].get(session["installments"].size() - 1)
            dueDate = lastInstallment.installmentDate
        } else {  // others
            for(int i = 1 + gracePeriod; i <= numInstallments + gracePeriod; i++) {
                if (i == 1 && firstInstallmentDate) {
                    dueDate = firstInstallmentDate
                } else {
                    
                    dueDate = loanService.getNextDueDate(prevDueDate, baseDate, frequency)
                }
                prevDueDate = dueDate
                baseDate = baseDate
              
            }
        }

        term = dueDate - openingDate

        render(template:"search/term", model:[term: term]) as JSON
        return
    }

    def show(Loan loanInstance) {
        println "id "+loanInstance.id
        def a = loanInstance.id.toInteger()
        session["jrxmlTcId"] = a
        def module = getModule(request?.forwardURI)
        def title = getTitle(module)

        def loanApplicationInstance = loanInstance.loanApplication
        def comakers = LoanApplicationComaker.findAllByLoanApplication(loanApplicationInstance)
        
        println("   comakerss: "+comakers)	
        def totalDeductions = 0
        for(loanDeduction in loanInstance?.loanDeductions) {
            totalDeductions += loanDeduction?.amount
        }

        def totalUID = 0
        for(loanEIRSchedules in loanInstance?.loanEIRSchedules) {
            totalUID += loanEIRSchedules?.uidAmount
        }
        // add computation of interest to date
        def intToDate
        use(TimeCategory) {
            def duration = loanInstance.branch.runDate - loanInstance.accruedInterestDate
            intToDate = duration.days * loanInstance.interestRate.div(100) * loanInstance.balanceAmount.div(loanInstance.interestIncomeScheme.divisor)
        }
        if (loanInstance.branch.runDate > loanInstance.maturityDate) {
            intToDate = loanInstance.interestBalanceAmount
        } else {
            intToDate += loanInstance.interestBalanceAmount
        }
        intToDate = intToDate.round(2)
        
        def loanHistoryList = LoanHistory.findAllByLoanId(loanInstance.id)        

        respond loanInstance, model:[loanApplicationInstance:loanApplicationInstance, totalDeductions: totalDeductions, 
           totalUID: totalUID, loanHistoryList: loanHistoryList.sort{it.id}, module:module, title:title, intToDate:intToDate, comakers:comakers]
    }

    def create() {
        // initialize session variables
        session["serviceCharges"] = []
        session["deductions"] = []
        session["installments"] = []        
        session["eirSchedules"] = []
        session["sweepAccounts"] = []
        session["pageAction"]=""
        session["pageAction"]="create"	
        

        def loanApplication = null
        if (params?.id) {
            loanApplication = LoanApplication.get(params?.id)
        }

        respond new Loan(params), model:[loanApplication:loanApplication]
    }

    @Transactional
    def save(Loan loanInstance) {

        if (loanInstance.loanApplication == null) {
            notFound()
            return
        }

        def test = LoanApplication.get(params.loanApplication).approvalStatus
        if (test.id != 6){
            statusPending()
            return
        }
        if(loanInstance.ageInArrears == null){
            loanInstance.ageInArrears = 0 
        }
        if(loanInstance.loanProvisionBsp == null){
           loanInstance.loanProvisionBsp = LoanProvisionBsp.get(1) 
        }
       
        if (loanInstance.grantedAmount < 0){ 
            flash.message = 'Loan Amount Cannot be negative !|error|alert'
            render(view: '/loan/create', model: [loanInstance:loanInstance])
            return
        }
        if (loanInstance.interestRate < 0){ 
            flash.message = 'Loan interest rate cannot be negative !|error|alert'
            render(view: '/loan/create', model: [loanInstance:loanInstance])
            return
        } 
        if (loanInstance.glLink == null) {
            flash.message = "Invalid Loan GL Link!|error|alert"
            render(view: '/loan/create', model: [loanInstance:loanInstance])
            return          
        }        
      
       
        loanService.beforeValidation(loanInstance)
        loanInstance.clearErrors()
            loanInstance.validate()

            def installmentType = loanInstance?.interestIncomeScheme?.installmentType.id
            def installmentCalculation = loanInstance?.interestIncomeScheme?.installmentCalcType.id
        if (installmentType == 5 || installmentCalculation == 6) {  // manual            
            loanInstance.numInstallments = session["installments"].size()
            Boolean dateCheck = false
            Boolean checkAmt = false
            def startDate = Branch.get(1).runDate
            
            def totalAmount = 0.00D
            for(installment in session["installments"]) {
                totalAmount = totalAmount + installment.principalInstallmentAmount
                if (installment.installmentDate <= startDate) {
                    dateCheck = true
                }
                startDate = installment.installmentDate
                if (installment.principalInstallmentAmount < 0 || installment.interestInstallmentAmount < 0 || installment.serviceChargeInstallmentAmount < 0) {
                    checkAmt = true
                }
            }            

            loanInstance.clearErrors()
            loanInstance.validate()
            
            totalAmount = totalAmount.round(2)
            loanInstance.grantedAmount = loanInstance.grantedAmount.round(2)
            if (dateCheck==true) {
                println '==== loan installments date check fail====='
                loanInstance.errors.rejectValue("maturityDate", "loan.maturityDate.invalid")                
            }
            if (checkAmt==true) {
                println '==== loan installments amounts check fail====='
                loanInstance.errors.rejectValue("grantedAmount", "loan.grantedAmount.invalid")                
            }            
            if (totalAmount != loanInstance.grantedAmount) {
                println '==== loan granted check ====='
                println totalAmount
                println '============================='
                loanInstance.errors.rejectValue("grantedAmount", "loan.grantedAmount.incorrect")
            }
        }
        
            if (loanInstance.applicationDate == null)
            {  
                loanInstance.applicationDate = Branch.get(1).runDate
            }
        
            if (loanInstance.openingDate == null)
            {  
                loanInstance.openingDate = Branch.get(1).runDate
                loanInstance.accruedInterestDate = Branch.get(1).runDate
            } 
            if (loanInstance.firstInstallmentDate)
            {  
               if(loanInstance.firstInstallmentDate < Branch.get(1).runDate)
               {
                    flash.message = 'first Installment Date Cannot be less than Current Date !.|error|alert'
                    render(view: '/loan/create', model: [loanInstance:loanInstance])
                    return
               }
            } 

        if (loanInstance.hasErrors()) {
            respond loanInstance.errors, view:'create'
            return
        }                              
        loanService.initializeLoan(loanInstance)
        def installmentAmount = params?.installmentAmount ? (params?.installmentAmount.replaceAll(",","")).toDouble() : null
        loanService.saveLoan(loanInstance, installmentAmount)
         def description = 'Loan Account ' +  loanInstance.accountNo + ' was created by ' + UserMaster.get(session.user_id).username
           auditLogService.insert('090', 'LON00500', description, 'Loan', null, null, null, loanInstance.id)
        
        request.withFormat {
            form multipartForm {
                    //loanInstance.totalNetProceeds = loanInstance.totalNetProceeds - loanInstance.advInterest
                    // loanInstance.save flush:true          
                //flash.message = message(code: 'default.created.message', args: [message(code: 'loan.label', default: 'Loan'), loanInstance.id])
                flash.message = 'Successfully opened Loan Account ' +loanInstance.accountNo
                redirect loanInstance
            }
            '*' { respond loanInstance, [status: CREATED] }
        }
    }
    
    def renew(Loan renewalLoanInstance) { 
        def module = getModule(request?.forwardURI)

        //if (module == "loanRenewal") 
        def loanInstance = Loan.read(renewalLoanInstance.id)
        createLoanHistoryEntry(loanInstance)
        createSessionData(loanInstance)
        
        def newLoanInstance = new Loan()
        newLoanInstance.id =  Loan.count() + 1
        // clone loan account
        Loan.constraints.each() { key, value ->
            if (key != "loanInstallments" && key != "serviceCharges" && key != "loanDeductions" && 
                key != "loanEIRSchedules" && key != "sweepAccounts" ) {
                newLoanInstance."${key}" = loanInstance."${key}"
            }
        }        

        //respond newLoanInstance, model:[module:module]
        respond loanInstance, model:[module:module]
    }

    def applyIntToDate(Loan loanInstance) { 
        def module = getModule(request?.forwardURI)
        Double totInt = 0.00D
        Double intRate
        
        if (loanInstance.loanPerformanceId.id == 1 ) {
            intRate = loanInstance.interestRate.div(100) 
        } else {
            // past due, use different rate
            intRate = loanInstance.interestRate.div(100)
        }
        if (loanInstance.maturityDate <= loanInstance.branch.runDate) {
            flash.message = 'Loan Already matured'
        } else if (loanInstance.advInterest > 0) {           
            flash.message = 'Loan advance interest'
        } else {
            use(TimeCategory) {
                def duration = loanInstance.branch.runDate - loanInstance.accruedInterestDate
                totInt  = (loanInstance.balanceAmount * intRate * duration.days).div(loanInstance.interestIncomeScheme.divisor)
                totInt = totInt.round(2)
            }
        }
        
        if (totInt > 0) {
            println totInt
            def tf = new TxnFile(acctNo:loanInstance.accountNo, branch:loanInstance.branch, currency:loanInstance.product.currency,
                loanAcct:loanInstance, status:ConfigItemStatus.get(2), user:UserMaster.get(session.user_id), txnAmt:totInt,
                txnCode:TxnTemplate.get(40).code, txnDate:loanInstance.branch.runDate, txnTimestamp:new Date().toTimestamp(),
                txnDescription:'Apply Interest to Date', txnParticulars: loanInstance.accountNo + ' - Apply Interest to current Date', 
                txnType:TxnTemplate.get(40).txnType, txnRef:loanInstance.accountNo + ' Int', txnTemplate:TxnTemplate.get(40))
            
            tf.save(flush:true)
            
            def ll = new LoanLedger(loan: loanInstance, txnFile: tf, txnDate: tf.txnDate, txnTemplate: TxnTemplate.get(40), 
                interestCredit: totInt, interestDebit:totInt, txnRef: tf.txnRef,principalBalance: loanInstance.balanceAmount)
            ll.save(flush:true)
            
            loanInstance.interestBalanceAmount += totInt
            loanInstance.save(flush:true)
            flash.message = 'Interest Credit Completed!!!'
            
            session["transactionFileId"] = tf.id.toInteger()
            redirect(controller: "tellering", action: "txnSuccess")
        } else {
            redirect(action: "show", id:loanInstance.id , params: [loanInstance: loanInstance])
        }

    }
    
    def applyIntToMaturity(Loan loanInstance) { 
        def module = getModule(request?.forwardURI)
        Double totInt = 0.00D
        
        for(installment in loanInstance.loanInstallments.sort{it.sequenceNo}) {
            if (installment.status.id == 2 || installment.status.id == 3 || installment.status.id == 4) {
                totInt += (installment.interestInstallmentAmount - installment.interestInstallmentPaid)
            }
        }
        
        if (loanInstance.maturityDate <= loanInstance.branch.runDate) {
            totInt = 0.00D
            flash.message = 'Loan Already matured'
        }
        
        if (totInt > 0) {
            println totInt
            def tf = new TxnFile(acctNo:loanInstance.accountNo, branch:loanInstance.branch, currency:loanInstance.product.currency,
                loanAcct:loanInstance, status:ConfigItemStatus.get(2), user:UserMaster.get(session.user_id), txnAmt:totInt,
                txnCode:TxnTemplate.get(40).code, txnDate:loanInstance.branch.runDate, txnTimestamp:new Date().toTimestamp(),
                txnDescription:'Apply Interest to Date', txnParticulars: loanInstance.accountNo + ' - Apply Interest to maturity', 
                txnType:TxnTemplate.get(40).txnType, txnRef:loanInstance.accountNo + ' Int', txnTemplate:TxnTemplate.get(40))
            
            tf.save(flush:true)
            
            def ll = new LoanLedger(loan: loanInstance, txnFile: tf, txnDate: tf.txnDate, txnTemplate: TxnTemplate.get(40), 
                interestCredit: totInt, interestDebit:totInt, txnRef: tf.txnRef,principalBalance: loanInstance.balanceAmount)
            ll.save(flush:true)
            
            loanInstance.interestBalanceAmount += totInt
            loanInstance.save(flush:true)
            flash.message = 'Interest Credit to Maturity Completed!!!'
            session["transactionFileId"] = tf.id.toInteger()
            redirect(controller: "tellering", action: "txnSuccess")
            
        } else {
            redirect(action: "show", id:loanInstance.id , params: [loanInstance: loanInstance])            
        }
    }
    
    //@Transactional
    //this is also used for renewal
    def saveNew(Loan loanInstance) {  
        println '$$$$$'
        println params
        println loanInstance
        if (loanInstance == null) {
            notFound()
            return
        }

        def ol = loanInstance.id
        def newLoanInstance = new Loan()
        newLoanInstance.id =  Loan.count() + 1
        // clone loan account
        Loan.constraints.each() { key, value ->
            if (key != "loanInstallments" && key != "serviceCharges" && key != "loanDeductions" && 
                key != "loanEIRSchedules" && key != "sweepAccounts" ) {
                newLoanInstance."${key}" = loanInstance."${key}"
            }
        }
        loanInstance.discard()
        def oldLoan = Loan.get(ol)
        
        if (params.activity=='Renewal') {
            def oldRenew = LoanRenewal.findAllByOldLoanAndRenewalCompleted(oldLoan, true)
            if (oldRenew) {
                oldLoan.errors.rejectValue("accountNo", "loan.accountNo.alreadyRenewed")
                respond oldLoan.errors, view:'renew', model:[module:params?.module]
                return
            }
            
            if (oldLoan.product.configItemStatus.id != 2) {
                oldLoan.errors.rejectValue("product", "loan.product.productClosed")
                respond oldLoan.errors, view:'renew', model:[module:params?.module]
                return                
            }
            
            def totAmtToClose = oldLoan.balanceAmount + oldLoan.interestBalanceAmount + oldLoan.penaltyBalanceAmount + oldLoan.serviceChargeBalanceAmount
            if (loanInstance.grantedAmount < totAmtToClose) {
                oldLoan.errors.rejectValue("grantedAmount", "loan.grantedAmount.grantedAmountCannotCoverTotalDue")
                respond oldLoan.errors, view:'renew', model:[module:params?.module]
                return                
            }
            // cancel/delete all unposted renewals, treat the orphan loans as new
            def renewalList = LoanRenewal.findAllByOldLoanAndRenewalCompleted(loanInstance, false)
            for (rl in renewalList) {
                rl.delete(flush:true)
            }
        }
        
        loanService.beforeValidation(newLoanInstance)
        newLoanInstance.clearErrors()
        newLoanInstance.validate()

        def installmentType = newLoanInstance?.interestIncomeScheme?.installmentType.id
        def installmentCalculation = loanInstance?.interestIncomeScheme?.installmentCalcType.id
        if (installmentType == 5 || installmentCalculation == 6) {  // manual            
            newLoanInstance.numInstallments = session["installments"].size()

            def totalAmount = 0
            for(installment in session["installments"]) {
                totalAmount = totalAmount + installment.principalInstallmentAmount
            }            

            newLoanInstance.clearErrors()
            newLoanInstance.validate()

            if (totalAmount != newLoanInstance.grantedAmount) {
                nl.errors.rejectValue("grantedAmount", "loan.grantedAmount.incorrect")
            }
        }

        if (newLoanInstance.hasErrors()) {
            respond newLoanInstance.errors, view:'renew', model:[module:params?.module]
            return
        }        

        // add validation for new loan instance
        if (params.activity=='Renewal') {
            
            newLoanInstance.validate()
            if (newLoanInstance.hasErrors()) {
                respond newLoanInstance.errors, view:'renew', model:[module:params?.module]
                return
            }            
        } 
        
        if (module == "loanRenewal")
            loanService.commitLoanHistoryEntry(params?.activity)

        loanService.initializeLoan(newLoanInstance)
        def installmentAmount = params?.installmentAmount ? (params?.installmentAmount.replaceAll(",","")).toDouble() : null
        if (params.activity=='Renewal') { 
            loanService.renewLoan(newLoanInstance, installmentAmount)
        } else {
            loanService.saveLoan(newLoanInstance, installmentAmount)
        }
        
        // update renewal table
        if (params.activity=='Renewal') {
            def lnRenew = new LoanRenewal(customer:newLoanInstance.customer, newLoan:newLoanInstance,
                newLoanAmount:newLoanInstance.grantedAmount, oldLoan:oldLoan, oldLoanAmount:oldLoan.grantedAmount,
                renewalCompleted:false)
            lnRenew.save(flush:true, failOnError:true)            
        }
        
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'loan.label', default: 'Loan'), newLoanInstance.id])
                redirect controller:params?.module, action:'show', id:newLoanInstance?.id 
                //redirect loanInstance
            }
            '*' { respond newLoanInstance, [status: CREATED] }
        }
    }

    def edit(Loan loanInstance) {
        session["pageAction"]=""
        session["sweeplist"] =""
        session["pageAction"]="edit"
        session["loanidvalue"]=""
        session["loanidvalue"]=loanInstance.id
        println("loan id: "+loanInstance.id)
        session["sweepAccounts"] = null
        def c = LoanRecovery.createCriteria()
        def results = c.list {
            
            eq("fundedLoan", Loan.get(loanInstance.id))	 
        }
        session["sweeplist"] = results
        
        println("mysweepList: "+session["sweeplist"])
        def module = getModule(request?.forwardURI)
        
        createLoanHistoryEntry(loanInstance)        
        createSessionData(loanInstance)        

        respond loanInstance, model:[module:module]
   
   
    }

    def reschedule(Loan loanInstance) {
        def module = getModule(request?.forwardURI)
        
        createLoanHistoryEntry(loanInstance)
        createSessionData(loanInstance)        

        respond loanInstance, model:[module:module]
    }

    def writeOff(Loan loanInstance) {
        def module = getModule(request?.forwardURI)
        
        createLoanHistoryEntry(loanInstance)
        createSessionData(loanInstance)        

        respond loanInstance, model:[module:module]
    }    

    @Transactional
    def update(Loan loanInstance) {
        if (loanInstance == null) {
            notFound()
            return
        }
        println("==============================================================")
        println("Loan updateeeee  params: "+params)
        println("params activity: "+params?.activity)
        //to create installment amount base on balance amount
        def origOpen = loanInstance.openingDate
        def origGranted = loanInstance.grantedAmount
        if (params?.activity == "Reschedule") {
           
            loanInstance.grantedAmount = loanInstance.balanceAmount
            loanInstance.openingDate = loanInstance.branch.runDate
            if (loanInstance.interestIncomeScheme.installmentCalcType.id == 6) {
                // for manual installment, interest start date to current date
                loanInstance.interestStartDate = loanInstance.branch.runDate
            }
            if (loanInstance.interestStartDate < loanInstance.branch.runDate) {
				flash.message = 'Interest Start Date should be Greater than Run Date!'																	   
                respond loanInstance.errors, view:'reschedule', model:[module:params?.module]
                return                
            }
            if (loanInstance.firstInstallmentDate < loanInstance.branch.runDate) {
				flash.message = 'First Installment Date should be Greater than Run Date!'																		  
                respond loanInstance.errors, view:'reschedule', model:[module:params?.module]
                return                
            }     
            
            println '******************************'
            println loanInstance.grantedAmount
            println loanInstance.openingDate
            println '******************************'
        }
        if (params?.activity == "Restructure") {
            loanInstance.grantedAmount = loanInstance.balanceAmount
            loanInstance.openingDate = loanInstance.branch.runDate
            if (loanInstance.interestStartDate < loanInstance.branch.runDate) {
                 flash.message = 'Interest Start Date should be Greater than Run Date!'
                respond loanInstance.errors, view:'restructure', model:[module:params?.module]
                return                
            }
            if (loanInstance.firstInstallmentDate < loanInstance.branch.runDate) {
                flash.message = 'First Installment Date should be Greater than Run Date!'
                respond loanInstance.errors, view:'restructure', model:[module:params?.module]
                return                 
            } 
            loanInstance.grantedAmount = loanInstance.balanceAmount
            loanInstance.openingDate = loanInstance.branch.runDate
        }
        
        loanService.beforeValidation(loanInstance)
        loanInstance.clearErrors()
        loanInstance.validate()
        
         
        
        if (params.activity == 'Amendment' && loanInstance.status.id > 2) {
            println("pasok dito sa amendment")
            def uId = UserMaster.get(session.user_id)  
            loanService.saveLoanAmendment(loanInstance, uId)
            
             def description = 'Loan Account ' +  loanInstance.accountNo + ' was edited by ' + UserMaster.get(session.user_id).username
           auditLogService.insert('090', 'LON00500', description, 'Loan', null, null, null, loanInstance.id)
        
            
            request.withFormat {
                form multipartForm {
                    flash.message = message(code: 'default.updated.message', args: [message(code: 'Loan.label', default: 'Loan'), loanInstance.id])
                    redirect controller:params?.module, action:'show', id:loanInstance?.id 
                }
                '*'{ respond loanInstance, [status: OK] }
            }
            return
        }
            
        def installmentType = loanInstance?.interestIncomeScheme?.installmentType.id
        def installmentCalculation = loanInstance?.interestIncomeScheme?.installmentCalcType.id
        if (installmentType == 5 || installmentCalculation == 6) {  // manual            
            loanInstance.numInstallments = session["installments"].size()

            def totalAmount = 0
            for(installment in session["installments"]) {
                totalAmount = totalAmount + installment.principalInstallmentAmount
            }            
           
            loanInstance.clearErrors()
            loanInstance.validate()
            println("totalAmount : "+totalAmount.round(2))
            println("granted amount: "+loanInstance.grantedAmount)
            totalAmount = totalAmount.round(2)
            if (totalAmount != loanInstance.grantedAmount) {
                println("condition totalAmount != loanInstance.grantedAmount ")
                loanInstance.errors.rejectValue("grantedAmount", "loan.grantedAmount.incorrect")
            }
        }
       
        if (loanInstance.hasErrors()) {
            println("condition .hasErrors")
            respond loanInstance.errors, view:'edit', model:[module:params?.module]
            return
        }    
        
        loanService.commitLoanHistoryEntry(params?.activity)
        clearLoanData(loanInstance)
        
        if (params?.activity == "Write-Off") {
            loanService.writeOff(loanInstance)
        }
       println("asdasdasdads")
        def installmentAmount = params?.installmentAmount ? (params?.installmentAmount.replaceAll(",","")).toDouble() : null        
        loanService.saveLoan(loanInstance, installmentAmount)
        // to revert back granted amount value
        if (params?.activity == "Reschedule") {   
        //loanInstance.grantedAmount = origGranted
        //loanInstance.openingDate = origOpen
        loanInstance.status = LoanAcctStatus.read(4)
        }
         if (params?.activity == "Restructure") {   
        //loanInstance.grantedAmount = origGranted
        //loanInstance.openingDate = origOpen
        loanInstance.status = LoanAcctStatus.read(4)
        }
        
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Loan.label', default: 'Loan'), loanInstance.id])
                redirect controller:params?.module, action:'show', id:loanInstance?.id 
            }
            '*'{ respond loanInstance, [status: OK] }
        }
    }    

    @Transactional
    def delete(Loan loanInstance) {
        if (loanInstance == null) {
            notFound()
            return
        }

        loanInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Loan.label', default: 'Loan'), loanInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    def createSessionData(Loan loanInstance) {
        /*session["installments"] = []
        def installmentType = loanInstance?.interestIncomeScheme?.installmentType.id
        def installmentCalculation = loanInstance?.interestIncomeScheme?.installmentCalcType.id
        if (installmentType == 5 || installmentCalculation == 6) {  // manual            
            // duplicate previous installments
            for(installment in loanInstance.loanInstallments.sort{it.sequenceNo}) {
                def newInstallment = new LoanInstallment(installmentDate: installment.installmentDate, 
                    principalInstallmentAmount: installment.principalInstallmentAmount, 
                    interestInstallmentAmount: installment.interestInstallmentAmount)
                session["installments"].add(newInstallment)
            }
        }*/

        session["installments"] = []
        // duplicate previous installments
        for(installment in loanInstance.loanInstallments.sort{it.sequenceNo}) {
            def newInstallment = new LoanInstallment()
            LoanInstallment.constraints.each() { key, value ->            
                newInstallment."${key}" = installment."${key}"   
            }
            session["installments"].add(newInstallment)
        }

        session["eirSchedules"] = []       
        // duplicate EIR schedules
        for(eirSchedule in loanInstance?.loanEIRSchedules?.sort{it.transferDate}) {
            def newEIRSchedule = new LoanEIRSchedule(transferAmount: eirSchedule.transferAmount, 
                transferDate: eirSchedule.transferDate, uidAmount: eirSchedule.uidAmount)
            session["eirSchedules"].add(newEIRSchedule)
        }     

        session["serviceCharges"] = []
        // duplicate previous service charges
        for(serviceCharge in loanInstance.serviceCharges.sort{it.id}) {
            def newServiceCharge = new ServiceCharge(scheme: serviceCharge.scheme, amount: serviceCharge.amount, 
                rate: serviceCharge.rate)
            session["serviceCharges"].add(newServiceCharge)
        }

        session["deductions"] = []
        // duplicate previous deductions
        for(deduction in loanInstance.loanDeductions.sort{it.id}) {
            def newDeduction = new LoanDeduction(scheme: deduction.scheme, amount: deduction.amount)
            session["deductions"].add(newDeduction)
        }

        session["sweepAccounts"] = []
        // duplicate previous sweep accounts
        for(sweepAccount in loanInstance.sweepAccounts.sort{it.id}) {
            def newSweepAccount = new LoanSweep(depositAccount: sweepAccount.depositAccount, type: sweepAccount.type, 
                rule: sweepAccount.rule, fundLimitAmt: sweepAccount.fundLimitAmt, fundLimitPercentage: sweepAccount.fundLimitPercentage, 
                ordinalNum: sweepAccount.ordinalNum, remarks: sweepAccount.remarks, status: sweepAccount.status, 
                dateCreated: sweepAccount.dateCreated, createdBy: sweepAccount.createdBy)
            session["sweepAccounts"].add(newSweepAccount)
        }
    }

    /*
     * Schemes
     */

    def getProductSchemesAjax() {
        def loanInstance = null
        if (params?.id) {            
            loanInstance = Loan.get(params.id)
        }

        def product = null
        if (params?.product) {        
            product = Product.get(params.product)            
        } 
        
        render(template:"schemes/schemes", model:[loanInstance: loanInstance, params: params, product: product]) as JSON
        return
    }

    def getProductSchemesAjax2() {
        def loanInstance = null
        if (params?.id) {
            loanInstance = Loan.get(params.id)
        }

        def product = null
        if (params?.product) {
            product = Product.get(params.product)            
        } 
        
        render(template:"schemes/schemes2", model:[loanInstance: loanInstance, params: params, product: product]) as JSON
        return
    }

    def getSchemeDetailsAjax() {
        def interestIncomeScheme = null
        if (params?.interestIncomeScheme) {
            interestIncomeScheme = InterestIncomeScheme.get(params.interestIncomeScheme)
        }

        def penaltyIncomeScheme = null
        if (params?.penaltyIncomeScheme) {
            penaltyIncomeScheme = PenaltyIncomeScheme.get(params.penaltyIncomeScheme)
        }

        /*def amortizedChargeScheme = null
        if (params?.amortizedChargeScheme) {
            amortizedChargeScheme = AmortizedChargeScheme.get(params.amortizedChargeScheme)
        }*/

        render(template:"schemes/schemeDetails", model:[interestIncomeScheme: interestIncomeScheme, 
            penaltyIncomeScheme: penaltyIncomeScheme]) as JSON
        return
    }    

    def getAmortizedChargeSchemeInfoAjax() {
        def amortizedChargeScheme

        if (params.id) {
            amortizedChargeScheme = AmortizedChargeScheme.get(params.id)
        } else {
            amortizedChargeScheme = null
        }

        render(template:"serviceCharges/amortizedChargeSchemeInfo", model:[amortizedChargeScheme: amortizedChargeScheme]) as JSON
        return
    }     

    def getDeductionSchemeInfoAjax() {
        def deductionScheme

        if (params.id) {
            deductionScheme = LoanDeductionScheme.get(params.id)
        } else {
            deductionScheme = null
        }

        render(template:"deductions/deductionSchemeInfo", model:[deductionScheme: deductionScheme]) as JSON
        return
    }     


    /*
     * Loan Application
     */

    def showLoanApplicationAjax() {
         println("pasok dito agad 1")
         def comakers
        def loanApplicationInstance = null
            //println("   loanAppId: "+loanApplicationInstance)
        println("loan aplication id: in params: "+params?.id)    
        if (params?.id) {
            loanApplicationInstance = LoanApplication.get(params?.id)
            if(loanApplicationInstance == null){
                println("null yung loan application id...")
            }else{
               //def coMakers
               comakers = LoanApplicationComaker.findAllByLoanApplication(loanApplicationInstance)
               println("comakers: "+comakers)
               //coMakers = comakers
               //def aStudent = [name: "Student1"]
               //session["coMakers"] = comakers
               //println("Scomakers: "+session["coMakers"])
            }
  
        }

        render(template:"loanApplication/show", model:[loanApplicationInstance:loanApplicationInstance,comakers:comakers]) as JSON
        return
    }

    /*
     * Service Charges
     */

    def showServiceChargesAjax() {
        render(template:"serviceCharges/list") as JSON
        return
    }

    def showAddServiceChargeAjax() {
        def product = Product.get(params?.product)

        render(template:"serviceCharges/form", model:[product:product]) as JSON
        return
    }

    def addServiceChargeAjax() {         
        def scheme = AmortizedChargeScheme.get(params?.scheme)
        def product = Product.get(params?.product)
        def amount

        def hasErrors = false
        
        def serviceCharge
        if (scheme?.type?.id == 2) {  // rate
            def grantedAmount = (params?.grantedAmount.replaceAll(",","")).toDouble()
            def rate = params?.rate ? (params?.rate.replaceAll(",","")).toDouble() : null
            def numInstallments = params?.numInstallments ? params?.numInstallments?.toInteger() : 0

            if (grantedAmount > 0 && numInstallments > 0 && rate != null) {
                amount = ((grantedAmount * rate * 0.01) / numInstallments).round(2)
            } else {
                amount = 0
            }            

            serviceCharge = new ServiceCharge(scheme:scheme, amount:amount, rate:params?.rate)

            if (session["serviceCharges"]?.size > 0 && session["serviceCharges"]?.find{it?.scheme?.id == scheme?.id} != null) {
                serviceCharge.errors.rejectValue("scheme", "serviceCharge.scheme.used")
                hasErrors = true
            }

            if (!rate) {
                serviceCharge.errors.rejectValue("rate", "serviceCharge.rate.null")
                hasErrors = true
            }            
        } else {
            
             if (params?.amount  == '')
                {
                 amount = params?.amount 
                }
             else
                {
                 amount = params?.amount.toDouble()
                }
            if (amount == '')
                {
            def message = 'Amount Value cannot be null !'
            render(template:"serviceCharges/form", model:[product:product, serviceCharge:serviceCharge]) as JSON
            return
                }    
          
             if (amount < 0)
                 {
            def message = 'Amount Value cannot be negative !'
            render(template:"serviceCharges/form", model:[product:product, serviceCharge:serviceCharge]) as JSON
            return
             }
            

            serviceCharge = new ServiceCharge(scheme:scheme, amount:amount, rate:0)

            if (session["serviceCharges"]?.size > 0 && session["serviceCharges"]?.find{it?.scheme?.id == scheme?.id} != null) {
                serviceCharge.errors.rejectValue("scheme", "serviceCharge.scheme.used")
                hasErrors = true
            }

            if (!amount) {
                serviceCharge.errors.rejectValue("amount", "serviceCharge.amount.null")
                hasErrors = true
            }            
        }        

        if (hasErrors) {
            render(template:"serviceCharges/form", model:[product:product, serviceCharge:serviceCharge]) as JSON
            return
        }

        def serviceCharges
        if (session["serviceCharges"]) {
            serviceCharges = session["serviceCharges"]
        } else {
            serviceCharges = []
        } 
        serviceCharges.add(serviceCharge)
        session["serviceCharges"] = serviceCharges

        def message = "Service charge successfully added"
        render(template:"serviceCharges/form", model:[product:product, message:message]) as JSON

        return
    }

    def showUpdateServiceChargeAjax() {        
        def id = params?.id?.toInteger()
        def product = Product.get(params?.product)

        def serviceCharges = session["serviceCharges"]        
        def serviceCharge = serviceCharges[id]

        render(template:"serviceCharges/form", model:[product:product, serviceCharge:serviceCharge]) as JSON
        return
    }

    def updateServiceChargeAjax() {   
        def id = params?.id?.toInteger()
        def scheme = AmortizedChargeScheme.get(params?.scheme)
        def product = Product.get(params?.product)
        def amount
        def rate

        def hasErrors = false

        def serviceCharge
        def serviceCharges = session["serviceCharges"]
        def tempServiceCharge
        if (scheme?.type?.id == 2) {  // rate            
            def grantedAmount = (params?.grantedAmount.replaceAll(",","")).toDouble()            
            def numInstallments = params?.numInstallments ? params?.numInstallments?.toInteger() : 0
            rate = params?.rate ? (params?.rate.replaceAll(",","")).toDouble() : null

            if (grantedAmount > 0 && numInstallments > 0 && rate != null) {
                amount = ((grantedAmount * rate * 0.01) / numInstallments).round(2)
            } else {
                amount = 0
            }

            tempServiceCharge = new ServiceCharge(scheme:scheme, amount:amount, rate:rate)
            
            for(int i = 0; i < serviceCharges?.size(); i++) {
                if (i != id && serviceCharges[i].scheme.id == scheme.id) {
                    tempServiceCharge.errors.rejectValue("scheme", "serviceCharge.scheme.used")
                    hasErrors = true
                }
            }

            if (!rate) {
                tempServiceCharge.errors.rejectValue("rate", "serviceCharge.rate.null")
                hasErrors = true
            }
        } else {
            amount = params?.amount ? (params?.amount.replaceAll(",","")).toDouble() : null
            rate = 0
            
            tempServiceCharge = new ServiceCharge(scheme:scheme, amount:amount, rate:0)
            if (amount == '')
                     {
                    def message = 'Amount Value cannot be null !'
                    render(template:"serviceCharges/form", model:[product:product, serviceCharge:serviceCharge]) as JSON
                    return
                    }    
          
                    if (amount < 0)
                    {
                     def message = 'Amount Value cannot be negative !'
                     render(template:"serviceCharges/form", model:[product:product, serviceCharge:serviceCharge]) as JSON
                    return
                    }
            for(int i = 0; i < serviceCharges?.size(); i++) {
                if (i != id && serviceCharges[i].scheme.id == scheme.id) {
                    tempServiceCharge.errors.rejectValue("scheme", "serviceCharge.scheme.used")
                    hasErrors = true
                }
            }

            if (!amount) {
                tempServiceCharge.errors.rejectValue("amount", "serviceCharge.amount.null")
                hasErrors = true
            }              
        }

        if (hasErrors) {
            render(template:"serviceCharges/form", model:[product:product, serviceCharge:tempServiceCharge]) as JSON
            return
        }

        serviceCharge = serviceCharges[id]
        serviceCharge.scheme = scheme
        serviceCharge.amount = amount
        serviceCharge.rate = rate

        def message = "Service charge successfully updated"
        render(template:"serviceCharges/form", model:[product:product, serviceCharge:serviceCharge, message:message]) as JSON

        return
    }

    def deleteServiceChargeAjax() {
        def id = params?.id?.toInteger()
        session["serviceCharges"].remove(id)

        render "success"
        return
    }

    /*
     * Deductions
     */

    def showDeductionsAjax() {
        render(template:"deductions/list") as JSON
        return
    }

    def showAddDeductionAjax() {
        def product = Product.get(params?.product)

        render(template:"deductions/form", model:[product:product]) as JSON
        return
    }

    def addDeductionAjax() {
        println("params: "+params)
        params?.amount = params?.amount ? (params?.amount.replaceAll(",","")): null
        println("params: "+params?.value)
        def scheme = LoanDeductionScheme.get(params?.scheme)
        def product = Product.get(params?.product)
        def amount
        
      
        def hasErrors = false

        def deduction
        if (scheme?.type?.id == 2) {  // rate
            def grantedAmount = (params?.grantedAmount.replaceAll(",","")).toDouble()
            def rate = params?.rate ? (params?.rate.replaceAll(",","")).toDouble() : null
           
            if (grantedAmount > 0 && rate != null) {
                amount = (grantedAmount * rate * 0.01).round(2)
            } else {
                amount = 0
            }

            deduction = new LoanDeduction(scheme:scheme, amount:amount, rate:rate)

            if (session["deductions"]?.size > 0 && session["deductions"]?.find{it?.scheme?.id == scheme?.id} != null) {
                deduction.errors.rejectValue("scheme", "loanDeduction.scheme.used")
                hasErrors = true
            }

            if (!rate) {
                deduction.errors.rejectValue("rate", "loanDeduction.rate.null")
                hasErrors = true
            }            
        } else if (scheme?.type?.id == 3) {
            // DST Computation
            def grantedAmount = (params?.grantedAmount.replaceAll(",","")).toDouble()
            def rate = params?.rate ? (params?.rate.replaceAll(",","")).toDouble() : null
           
            if (grantedAmount > 0 ) {
                amount = grantedAmount* 0.005
                amount = amount.round(2)    
            } else {
                amount = 0
            }

            deduction = new LoanDeduction(scheme:scheme, amount:amount, rate:rate)

            if (session["deductions"]?.size > 0 && session["deductions"]?.find{it?.scheme?.id == scheme?.id} != null) {
                deduction.errors.rejectValue("scheme", "loanDeduction.scheme.used")
                hasErrors = true
            }

            if (!amount) {
                deduction.errors.rejectValue("amount", "loanDeduction.amount.invalid")
                hasErrors = true
            }              
        } else if (scheme?.type?.id == 6) {
          // fire insurance special calculation
            def grantedAmount = (params?.grantedAmount.replaceAll(",","")).toDouble()
            def rate = params?.rate ? (params?.rate.replaceAll(",","")).toDouble() : null
           
            if (grantedAmount > 100000 ) {
                amount = grantedAmount* 0.002
                amount = amount.round(2)    
            } else {
                amount = 120
            }

            deduction = new LoanDeduction(scheme:scheme, amount:amount, rate:rate)

            if (session["deductions"]?.size > 0 && session["deductions"]?.find{it?.scheme?.id == scheme?.id} != null) {
                deduction.errors.rejectValue("scheme", "loanDeduction.scheme.used")
                hasErrors = true
            }

            if (!amount) {
                deduction.errors.rejectValue("amount", "loanDeduction.amount.invalid")
                hasErrors = true
            }          
        } else {
            if (params?.amount  == '')
                {
                 amount = params?.amount 
                }
             else
                {
                 amount = params?.amount.toDouble()
                }
            if (amount == '')
                {
            def message = 'Amount Value cannot be null !'
            render(template:"deductions/form" , model:[product:product, message:message]) as JSON
            return
                }    
          
             if (amount < 0)
                 {
            def message = 'Amount Value cannot be negative !'
            render(template:"deductions/form" , model:[product:product, message:message]) as JSON
            return
             }
           

            deduction = new LoanDeduction(scheme:scheme, amount:amount, rate:0)

            if (session["deductions"]?.size > 0 && session["deductions"]?.find{it?.scheme?.id == scheme?.id} != null) {
                deduction.errors.rejectValue("scheme", "loanDeduction.scheme.used")
                hasErrors = true
            }

            if (!amount) {
                deduction.errors.rejectValue("amount", "loanDeduction.amount.null")
                hasErrors = true                
            }  
        
        }        

        if (hasErrors) {
            render(template:"deductions/form", model:[product:product, deduction:deduction]) as JSON
            return
        }

        def deductions
      
        if (session["deductions"]) {
            deductions = session["deductions"]
        } else {
            deductions = []
        }  
            
        deductions.add(deduction)
        session["deductions"] = deductions
    
        def message = "Deduction successfully added"
        render(template:"deductions/form", model:[product:product, message:message]) as JSON

        return
    }

    def showUpdateDeductionAjax() {        
        def id = params?.id?.toInteger()
        def product = Product.get(params?.product)

        def deductions = session["deductions"]        
        def deduction = deductions[id]

        render(template:"deductions/form", model:[product:product, deduction:deduction]) as JSON
        return
    }

    def updateDeductionAjax() {   
        def id = params?.id?.toInteger()
        def scheme = LoanDeductionScheme.get(params?.scheme)
        def product = Product.get(params?.product)
        def amount
        def rate

        def hasErrors = false

        def deduction
        def deductions = session["deductions"]      
        def tempDeduction  
        if (scheme?.type?.id == 2) {  // rate
            def grantedAmount = (params?.grantedAmount.replaceAll(",","")).toDouble()            
            rate = params?.rate ? (params?.rate.replaceAll(",","")).toDouble() : null

            if (grantedAmount > 0 && rate != null) {
                amount = (grantedAmount * rate * 0.01).round(2)
            } else {
                amount = 0
            }

            tempDeduction = new LoanDeduction(scheme:scheme, amount:amount, rate:rate)

            for(int i = 0; i < deductions?.size(); i++) {
                if (i != id && deductions[i].scheme.id == scheme.id) {
                    tempDeduction.errors.rejectValue("scheme", "loanDeduction.scheme.used")
                    hasErrors = true
                }
            }

            if (!rate) {
                tempDeduction.errors.rejectValue("rate", "loanDeduction.rate.null")
                hasErrors = true
            } 
        } else {
            amount = params?.amount ? (params?.amount.replaceAll(",","")).toDouble() : null
            rate = 0
    
            tempDeduction = new LoanDeduction(scheme:scheme, amount:amount, rate:0)
                    if (amount == '')
                     {
                    def message = 'Amount Value cannot be null !'
                    render(template:"deductions/form" , model:[product:product, deduction:deduction, message:message]) as JSON
                    return
                    }    
          
                    if (amount < 0)
                    {
                     def message = 'Amount Value cannot be negative !'
                     render(template:"deductions/form" , model:[product:product, deduction:deduction, message:message]) as JSON
                    return
                    }
            
            
            
            
            for(int i = 0; i < deductions?.size(); i++) {
                if (i != id && deductions[i].scheme.id == scheme.id) {
                    tempDeduction.errors.rejectValue("scheme", "loanDeduction.scheme.used")
                    hasErrors = true
                }
            }

            if (!amount) {
                tempDeduction.errors.rejectValue("amount", "loanDeduction.amount.null")                
                hasErrors = true
            }                  
        }        

        if (hasErrors) {
            render(template:"deductions/form", model:[product:product, deduction:tempDeduction]) as JSON
            return
        }

        deduction = deductions[id]
        deduction.scheme = scheme
        deduction.amount = amount
        deduction.rate = rate

        def message = "Deduction successfully updated"
        render(template:"deductions/form", model:[product:product, deduction:deduction, message:message]) as JSON

        return
    }

    def deleteDeductionAjax() {
        def id = params?.id?.toInteger()
        session["deductions"].remove(id)

        render "success"
        return
    }    

    /*
     * Sweep
     */

    def showDepositAccountInfo() {
        def depositAccount

        if (params.id) {
            depositAccount = Deposit.get(params.id)
        } else {
            depositAccount = null
        }

        render(template:"sweep/depositInfo", model:[depositAccount: depositAccount]) as JSON
        return
    }

    def showSweepAccountsAjax() {
        render(template:"sweep/list") as JSON
        return
    }

    def showAddSweepAccountAjax() {
        render(template:"sweep/form") as JSON
        return
    }

    def addSweepAccountAjax() { 
        println '----- sweep -----'
        println params
        def depositAccount = Deposit.get(params?.deposit)
        def type = SweepType.get(params?.type)
        def rule = SweepRule.get(params?.rule)
        def fundLimitAmt  
        def fundLimitPercentage = params?.fundLimitPercentage
        def ordinalNum = params?.ordinalNum ? params?.ordinalNum?.toInteger() : null
        def remarks = params?.remarks
        
        

         
        
//       
//        if (depositAccount == null)
//        {
//            def message = 'Deposit Account cannot be null !'
//            render(template:"sweep/form" , model:[message:message]) as JSON
//            return
//        }
        
        if (rule == SweepRule.get(3))
        { 
            println 'angels' 
            
             if (params?.fundLimitAmt  == '')
                {
                 fundLimitAmt = params?.fundLimitAmt 
                }
             else
                {
                 fundLimitAmt = params?.fundLimitAmt.toDouble()
                }
                         if (fundLimitAmt == '')
                         {
                          def message = 'Fixed Amount cannot be null if Rule is Fixed Amount!'
                          render(template:"sweep/form" , model:[message:message]) as JSON
                            return
                         }
                         if (fundLimitAmt < 0 )
                         {
                          def message = 'Fixed Amount cannot be negative'
                          render(template:"sweep/form" , model:[message:message]) as JSON
                            return
                         }
        }
        
         if (ordinalNum == null)
        {
            def message = 'Ordinal Number cannot be null !'
            render(template:"sweep/form" , model:[message:message]) as JSON
            return
        }

        def sweepAccount = new LoanSweep(depositAccount:depositAccount, type:type, rule:rule, fundLimitAmt:fundLimitAmt,
            fundLimitPercentage:fundLimitPercentage, ordinalNum:ordinalNum, remarks:remarks)

        def hasErrors = false

        if (!depositAccount) {
            sweepAccount.errors.rejectValue("depositAccount", "sweep.depositAccount.null")
            hasErrors = true
        } else if (session["sweepAccounts"]?.size > 0 && session["sweepAccounts"]?.find{it?.depositAccount?.id == depositAccount?.id} != null) {
            sweepAccount.errors.rejectValue("depositAccount", "sweep.depositAccount.used")
            hasErrors = true
        }

        if (rule?.id == 3 && !fundLimitAmt) {
            sweepAccount.errors.rejectValue("fundLimitAmt", "sweep.fundLimitAmt.null")
            hasErrors = true
        }

        if (rule?.id == 4 && !fundLimitPercentage) {
            sweepAccount.errors.rejectValue("fundLimitPercentage", "sweep.fundLimitPercentage.null")
            hasErrors = true
        }

        if (ordinalNum == null) {
            sweepAccount.errors.rejectValue("ordinalNum", "sweep.ordinalNum.null")
            hasErrors = true
        } else if (session["sweepAccounts"]?.size > 0 && session["sweepAccounts"]?.find{it?.ordinalNum == ordinalNum} != null) {
            sweepAccount.errors.rejectValue("ordinalNum", "sweep.ordinalNum.notUnique")
            hasErrors = true
        }

        if (hasErrors) {
            render(template:"sweep/form", model:[sweepAccount:sweepAccount]) as JSON
            return
        }       

        sweepAccount.status = SweepStatus.get(2)
        sweepAccount.createdBy = UserMaster.get(session.user_id)  
        sweepAccount.dateCreated = new Date()

        def sweepAccounts
        if (session["sweepAccounts"]) {
            sweepAccounts = session["sweepAccounts"]
        } else {
            sweepAccounts = []
        }        
        sweepAccounts.add(sweepAccount)
        session["sweepAccounts"] = sweepAccounts
        
        if(session["pageAction"]=="edit"){
            def loanididid = Loan.get(params?.loanidvalue).id
            // saving first the LoanSweep object
            sweepAccount.save(flush:true)
            // retrieving the last id for the last save
            def sql = new Sql(dataSource)
            def queryall = "select id from loan_sweep order by id desc limit 1"
            def resultqueryall = sql.rows(queryall)
            // insert loan_id and the last of the LoanSweep id
            def insertQuery = "insert into loan_loan_sweep (loan_sweep_accounts_id,loan_sweep_id) values (${loanididid},${LoanSweep.get(resultqueryall.id[0].toInteger()).id})"
            def resultInsert = sql.execute(insertQuery) 
        }

        def message = "Sweep account successfully added"
        render(template:"sweep/form", model:[message:message]) as JSON

        return
    }

    def showUpdateSweepAccountAjax() {
        session["sweepposition"]=""
        def id = params?.id?.toInteger()
        def posArray = params?.posArray?.toInteger()
        def sweepAccounts = session["sweepAccounts"]
        def sweepAccount = sweepAccounts[posArray]
        session["sweepposition"]= params?.posArray
        render(template:"sweep/form", model:[sweepAccount:sweepAccount]) as JSON
        return
    }

    def updateSweepAccountAjax() {   
        def id = params?.id?.toInteger()
        def posArray = params?.posArray?.toInteger()													
        def depositAccount = Deposit.get(params?.deposit)
        def type = SweepType.get(params?.type)
        def rule = SweepRule.get(params?.rule)
        def fundLimitAmt = params?.fundLimitAmt ? (params?.fundLimitAmt.replaceAll(",","")).toDouble() : null
        def fundLimitPercentage = params?.fundLimitPercentage ? (params?.fundLimitPercentage.replaceAll(",","")).toDouble() : null
        def ordinalNum = params?.ordinalNum ? params?.ordinalNum?.toInteger() : null
        def remarks = params?.remarks

        def tempSweepAccount = new LoanSweep(depositAccount:depositAccount, type:type, rule:rule, fundLimitAmt:fundLimitAmt,
            fundLimitPercentage:fundLimitPercentage, ordinalNum:ordinalNum, remarks:remarks)
                 if (rule == SweepRule.get(3))
        { 
         
            
             if (params?.fundLimitAmt  == '')
                {
                 fundLimitAmt = params?.fundLimitAmt 
                }
             else
                {
                 fundLimitAmt = params?.fundLimitAmt.toDouble()
                }
                         if (fundLimitAmt == '')
                         {
                          def message = 'Fixed Amount cannot be null if Rule is Fixed Amount!'
                          render(template:"sweep/form" , model:[message:message]) as JSON
                            return
                         }
                         if (fundLimitAmt < 0 )
                         {
                          def message = 'Fixed Amount cannot be negative'
                          render(template:"sweep/form" , model:[message:message]) as JSON
                            return
                         }
        }
        def hasErrors = false

        if (!depositAccount) {
            tempSweepAccount.errors.rejectValue("depositAccount", "sweep.depositAccount.null")
            hasErrors = true
        } else {
            def sweepAccounts = session["sweepAccounts"]
            for(int i = 0; i < sweepAccounts?.size(); i++) {
                if (i != posArray && sweepAccounts[i].depositAccount == depositAccount) {
                    tempSweepAccount.errors.rejectValue("depositAccount", "sweep.depositAccount.used")
                    hasErrors = true
                }
            }            
        }

        if (rule?.id == 3 && !fundLimitAmt) {
            tempSweepAccount.errors.rejectValue("fundLimitAmt", "sweep.fundLimitAmt.null")
            hasErrors = true
        }

        if (rule?.id == 4 && !fundLimitPercentage) {
            tempSweepAccount.errors.rejectValue("fundLimitPercentage", "sweep.fundLimitPercentage.null")
            hasErrors = true
        }

        if (ordinalNum == null) {
            tempSweepAccount.errors.rejectValue("ordinalNum", "sweep.ordinalNum.null")
            hasErrors = true
        } else {
            def sweepAccounts = session["sweepAccounts"]
            for(int i = 0; i < sweepAccounts?.size(); i++) {
                if (i != posArray && sweepAccounts[i].ordinalNum == ordinalNum) {
                    tempSweepAccount.errors.rejectValue("ordinalNum", "sweep.ordinalNum.notUnique")
                    hasErrors = true
                }
            }
        }

        if (hasErrors) {
            render(template:"sweep/form", model:[sweepAccount:tempSweepAccount]) as JSON
            return
        }    

        def sweepAccounts = session["sweepAccounts"]        
        def sweepAccount = sweepAccounts[posArray]

        sweepAccount.depositAccount = depositAccount
        sweepAccount.type = type
        sweepAccount.rule = rule
        sweepAccount.fundLimitAmt = fundLimitAmt
        sweepAccount.fundLimitPercentage = fundLimitPercentage
        sweepAccount.ordinalNum = ordinalNum
        sweepAccount.remarks = remarks
        println("================================================================="+session["pageAction"])
        if(session["pageAction"]=="edit"){
            println("depositAccount: "+depositAccount)
            println("type: "+type)
            println("rule: "+rule)
            println("fundLimitAmt: "+fundLimitAmt)
            println("fundLimitPercentage: "+fundLimitPercentage)
            println("ordinalNum: "+ordinalNum)
            println("remarks: "+remarks)
            
            def loanSweepInstance = LoanSweep.get(id)
                loanSweepInstance.depositAccount = depositAccount
                loanSweepInstance.type = type
                loanSweepInstance.rule = rule
                loanSweepInstance.fundLimitAmt = fundLimitAmt
                loanSweepInstance.fundLimitPercentage = fundLimitPercentage
                loanSweepInstance.ordinalNum = ordinalNum
                loanSweepInstance.remarks = remarks
                loanSweepInstance.save(flush:true)
            
        }
        def message = "Sweep account successfully updated"
        render(template:"sweep/form", model:[sweepAccount:sweepAccount, message:message]) as JSON

        return
    }

    def deleteSweepAccountAjax() {
        def id = params?.id?.toInteger()
        def posArray = params?.posArray?.toInteger()
        println("deletesweep loanid: "+session["loanidvalue"].toInteger())
        if(session["pageAction"]=="edit"){
            def sql = new Sql(dataSource)
            //def queryall = "delete from loan_loan_sweep where loan_sweep_id = ${id} and loan_sweep_accounts_id = ${session["loanidvalue"].toInteger()}"
            def queryall="delete from loan_loan_sweep where loan_sweep_id = "+id+"and loan_sweep_accounts_id = "+session["loanidvalue"].toInteger()
            def resultqueryall = sql.execute(queryall)
            if(!resultqueryall){
                println("pasok sa ifffffffffffffff")
                 def queryall1 = "delete from loan_sweep where id ="+id
                
                def resultqueryall1 = sql.execute(queryall1)
            }else{
                println("pasok sa else")
            }
        }
        session["sweepAccounts"].remove(posArray)

        render "success"
        return
    }      

    /*
     * Manual Loan Installments
     */

    def showInstallmentsAjax() {
        def thepassedvalue = params?.onffvalue
        println("the parameter passed onoffvalue: "+thepassedvalue)
      
        render(template:"installments/list", model: [onoffplugvalue: thepassedvalue]) as JSON
        return
    }     

    def showAddInstallmentAjax() {    
        render(template:"installments/form") as JSON
        return
    }

    def addInstallmentAjax() {    
        def date = params?.date
        def principal = params?.principal
        def interest = params?.interest
        def serviceCharge = params?.serviceCharge ? (params?.serviceCharge.replaceAll(",","")).toDouble() : null
        println "value " + params
        def installment = new LoanInstallment(installmentDate:date, principalInstallmentAmount:principal, interestInstallmentAmount:interest, serviceChargeInstallmentAmount:serviceCharge)

        def hasErrors = false

        if (!date) {
            installment.errors.rejectValue("installmentDate", "loanInstallment.installmentDate.null")
            hasErrors = true
        } else {
            def laterDate = true;
            for(def i = 0; i < session["installments"].size(); i++) {
                if (installment.installmentDate <= session["installments"].get(i).installmentDate) {
                    laterDate = false;
                }
            }

            if (!laterDate) {
                installment.errors.rejectValue("installmentDate", "loanInstallment.installmentDate.incorrect")    
                hasErrors = true
            }
        }
        
        if (!principal) {
            installment.errors.rejectValue("principalInstallmentAmount", "loanInstallment.principal.null")
            hasErrors = true
        }

        if (!interest) {
            installment.errors.rejectValue("interestInstallmentAmount", "loanInstallment.interest.null")
            hasErrors = true
        }

        if (hasErrors) {
            render(template:"installments/form", model:[installment:installment]) as JSON
            return
        } 

        def installments
        if (session["installments"]) {
            installments = session["installments"]
        } else {
            installments = []
        }        
        installments.add(installment)
        session["installments"] = installments

        def add = "true"
        def message = "Installment successfully added"
        session["onffvalue"]="addbtn";	  
        render(template:"installments/form", model:[add:add, message:message]) as JSON

        return
    }

    def showUpdateInstallmentAjax() {   
        def id = params?.id?.toInteger()
        
        def installments = session["installments"]        
        def installment = installments[id]

        render(template:"installments/form", model:[installment:installment]) as JSON
        return
    }

    def updateInstallmentAjax() {    
        def id = params?.id?.toInteger()
        def date = params?.date ? new Date().parse("MM/dd/yyyy", params?.date) : null
        def principal = params?.principal ? (params?.principal.replaceAll(",","")).toDouble() : null
        def interest = params?.interest ? (params?.interest.replaceAll(",","")).toDouble() : null
        def serviceCharge = params?.serviceCharge ? (params?.serviceCharge.replaceAll(",","")).toDouble() : null
        def tempInstallment = new LoanInstallment(installmentDate:date, principalInstallmentAmount:principal, 
            interestInstallmentAmount:interest,serviceChargeInstallmentAmount:serviceCharge)

        def hasErrors = false

        if (!date) {
            tempInstallment.errors.rejectValue("installmentDate", "loanInstallment.installmentDate.null")
            hasErrors = true
        } else {
            def laterDate = true;
            for(def i = 0; i < id; i++) {
                if (tempInstallment.installmentDate <= session["installments"].get(i).installmentDate) {
                    laterDate = false;
                }
            }

            if (!laterDate) {
                tempInstallment.errors.rejectValue("installmentDate", "loanInstallment.installmentDate.incorrect")    
                hasErrors = true
            }
        }

        if (!principal) {
            tempInstallment.errors.rejectValue("principalInstallmentAmount", "loanInstallment.principal.null")
            hasErrors = true
        }

        if (!interest) {
            //tempInstallment.errors.rejectValue("interestInstallmentAmount", "loanInstallment.interest.null")
            //hasErrors = true
            interest = 0.0
        }

        if (hasErrors) {
            render(template:"installments/form", model:[installment:tempInstallment]) as JSON
            return
        }   

        def installments = session["installments"]        
        def installment = installments[id]

        installment.installmentDate = date
        installment.principalInstallmentAmount = principal
        installment.interestInstallmentAmount = interest
        installment.serviceChargeInstallmentAmount = serviceCharge

        def message = "Installment successfully updated"
        render(template:"installments/form", model:[installment:installment, message:message]) as JSON

        return
    }

    def deleteInstallmentAjax() {
        def id = params?.id?.toInteger()
        session["installments"].remove(id)

        render "success"
        return
    }

    /*
     * History
     */

    def createLoanHistoryEntry(Loan loanInstance) {
        def loanHistory = new LoanHistory()
        session["loanHistory"] = []
        println("loanInstance ==============================================: "+loanInstance.id)
        // copy details from loan account        
        loanHistory.loanId = loanInstance.id
        Loan.constraints.each() { key, value ->            
            if (key != "loanInstallments" && key != "serviceCharges" && 
                key != "loanDeductions" && key != "sweepAccounts") {                                
                loanHistory."${key}" = loanInstance."${key}"
            }
        }
        session["loanHistory"].add(loanHistory)    

        // duplicate service charges
        session["newServiceCharges"] = []       
        for(serviceCharge in loanInstance?.serviceCharges) {
            def newServiceCharge = new ServiceCharge()
            ServiceCharge.constraints.each() { key, value ->            
                newServiceCharge."${key}" = serviceCharge."${key}"   
            }
            session["newServiceCharges"].add(newServiceCharge)            
        }

        // duplicate deductions
        session["newDeductions"] = []       
        for(deduction in loanInstance?.loanDeductions) {
            def newDeduction = new LoanDeduction()
            LoanDeduction.constraints.each() { key, value ->            
                newDeduction."${key}" = deduction."${key}"   
            }
            session["newDeductions"].add(newDeduction)
        }

        // duplicate installments
        session["newInstallments"] = []       
        for(installment in loanInstance?.loanInstallments) {
            def newInstallment = new LoanInstallment()
            LoanInstallment.constraints.each() { key, value ->            
                newInstallment."${key}" = installment."${key}"   
            }
            session["newInstallments"].add(newInstallment)
        }        

        // duplicate EIR schedules
        session["newEIRSchedules"] = []       
        for(eirSchedule in loanInstance?.loanEIRSchedules) {
            def newEIRSchedule = new LoanEIRSchedule()
            LoanEIRSchedule.constraints.each() { key, value ->            
                newEIRSchedule."${key}" = eirSchedule."${key}"   
            }
            session["newEIRSchedules"].add(newEIRSchedule)
        } 

        // duplicate sweep accounts
        session["newSweepAccounts"] = []       
        for(sweepAccount in loanInstance?.sweepAccounts) {
            println '--->' + sweepAccount
            def newSweepAccount = new LoanSweep()
            LoanSweep.constraints.each() { key, value ->            
                newSweepAccount."${key}" = sweepAccount."${key}"   
            }
            println '----->' + newSweepAccount
            session["newSweepAccounts"].add(newSweepAccount)
        }       
    }

    def clearLoanData(Loan loanInstance) {
        loanInstance.serviceCharges.clear()
        loanInstance.loanDeductions.clear()
        loanInstance.loanInstallments.clear()
        loanInstance.loanEIRSchedules.clear()
        loanInstance.sweepAccounts.clear()
        //loanInstance.save flush:true 
    }

    def showHistory() {
        if (params?.id && params?.history) {
            def origLoanInstance = Loan.get(params.id)
            def loanInstance = LoanHistory.get(params.history)

            def totalDeductions = 0
            for(loanDeduction in loanInstance?.loanDeductions) {
                totalDeductions += loanDeduction?.amount
            }

            respond loanInstance, model: [loanInstance: loanInstance, origLoanInstance: origLoanInstance,
                loanApplicationInstance: loanInstance.loanApplication, totalDeductions: totalDeductions]
        } else {
            notFound()
            return
        }
    }     

    /*
     * Repricing
     */

    def showUpdateInterestRateAjax() {
        def loanInstance = Loan.get(params?.id)

        render(template:"interestRate/form", model:[loanInstance:loanInstance]) as JSON
        return
    }

    @Transactional
    def updateInterestRateAjax() {
        def loanInstance = Loan.get(params.id)
        
        createLoanHistoryEntry(loanInstance)
        createSessionData(loanInstance)

        def interestRate = params?.interestRate ? (params?.interestRate.replaceAll(",","")).toDouble() : null
        if (!interestRate) {
            loanInstance.errors.rejectValue("interestRate", "loan.interestRate.null")

            render(template:"interestRate/form", model:[loanInstance:loanInstance]) as JSON    
            return        
        }        
        
        loanService.commitLoanHistoryEntry("Repricing")
        clearLoanData(loanInstance)
        
        loanService.updateInterestRate(loanInstance, interestRate)

        def message = "Interest rate successfully updated"
        render(template:"interestRate/form", model:[loanInstance:loanInstance, message:message]) as JSON

        return
    }    

    /*
     * Interest Accrual
     */

    @Transactional
    def startInterestAccrual(Loan loanInstance) {
        if (loanInstance == null) {
            notFound()
            return
        }

        createLoanHistoryEntry(loanInstance)
        createSessionData(loanInstance)

        loanService.commitLoanHistoryEntry("Start Interest Accrual")
        clearLoanData(loanInstance)

        loanService.updateInterestAccrual(loanInstance, true)

        request.withFormat {
            form multipartForm {
                flash.message = "Interest accrual started"
                //redirect loanInstance
                redirect controller:params?.module, action: 'show', id: loanInstance.id
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    @Transactional
    def stopInterestAccrual(Loan loanInstance) {
        if (loanInstance == null) {
            notFound()
            return
        }

        createLoanHistoryEntry(loanInstance)
        createSessionData(loanInstance)

        loanService.commitLoanHistoryEntry("Stop Interest Accrual")
        clearLoanData(loanInstance)
        
        loanService.updateInterestAccrual(loanInstance, false)

        request.withFormat {
            form multipartForm {
                flash.message = "Interest accrual stopped"
                //redirect loanInstance
                redirect controller:params?.module, action: 'show', id: loanInstance.id
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    
    def approved(Loan loanInstance) {
        if (loanInstance == null) {
            notFound()
            return
        }
        def aln = Loan.get(loanInstance.id)
        if (aln.status.id > 2) {
            flash.message = "Loan Already approved"
            //redirect loanInstance
            redirect controller:params?.module, action: 'show', id: loanInstance.id 
            return
        }
        
         def coll 
         coll = loanInstance.loanApplication.collaterals
         println "====>" + coll.size()
         for (co in coll)
         {
           println "1. " + co.collateralType.id
           if (co.collateralType.id == 3)  
           {
                def amount
                println "deposit " + Deposit.findByAcctNo(co.holdout.accountNo).availableBalAmt
                println "loan " + loanInstance.grantedAmount 
                def depositInstance = Deposit.findByAcctNo(co.holdout.accountNo)
                if(depositInstance.availableBalAmt <= loanInstance.grantedAmount)
                {
                    amount = depositInstance.availableBalAmt
                    
                }
                else
                {
                    amount = loanInstance.grantedAmount                    
                }
                //def depositInstance = Deposit.findByAcctNo(co.holdout.accountNo)
                def number = Deposit.findByAcctNo(co.holdout.accountNo)
               
                def holdInstance = new Hold()
                holdInstance.amt = amount
                holdInstance.holdDate = Branch.get(1).runDate
                holdInstance.maturityDate = loanInstance.maturityDate
                holdInstance.remarks = 'Auto Posting of Hold Out Collateral'
                holdInstance.status = HoldStatus.get(2)
                holdInstance.type = HoldType.get(1)
                number.addToHolds(holdInstance).save(flush: true) 
              
                number.availableBalAmt -= amount 
                number.holdBalAmt += amount
                number.save(flush:true, failOnError:true)
              
                //def dep = Deposit.findByAcctNo(co.holdout.accountNo)
                //number.availableBalAmt -= amount 
                //number.holdBalAmt += amount
                //number.save(flush:true, failOnError:true)
                println '+++++++++++++++++++++++++++'
                println number.acctNo
                println number.availableBalAmt
                println number.holdBalAmt
                println number.errors
                println '+++++++++++++++++++++++++++'              
           }
         }

        createLoanHistoryEntry(loanInstance)
        createSessionData(loanInstance)
        loanInstance?.hasInterestAccrual = true
        loanInstance?.dateApproved = loanInstance?.branch?.runDate
        loanInstance?.approvedBy = UserMaster.get(session.user_id)
        loanInstance.save(flush:true)
       
        loanService.commitLoanHistoryEntry("Update Status to " + LoanAcctStatus.get(3).description)
        clearLoanData(loanInstance)
        loanService.updateStatus(loanInstance, LoanAcctStatus.get(3))
        loanService.updateOpeningBal(loanInstance, LoanAcctStatus.get(3))
            def message = "Status successfully updated"
            def x = Institution.findByParamCode('LNS.50074').paramValue.toInteger()
            def branch = Branch.get(loanInstance.branchId)    
            def txnFileInstance = new TxnFile()
            loanInstance.grantedAmount = loanInstance.grantedAmount.round(2)
            loanInstance.totalNetProceeds = loanInstance.totalNetProceeds.round(2)
            def amount = loanInstance.grantedAmount - loanInstance.totalNetProceeds
            amount = amount.round(2)
            def deduct = amount - loanInstance.advInterest
            deduct = deduct.round(2)
            txnFileInstance.acctNo = loanInstance.accountNo
            txnFileInstance.loanAcct = loanInstance
            txnFileInstance.currency = Currency.get(loanInstance.product.currencyId)
            txnFileInstance.user = UserMaster.get(session.user_id)
            txnFileInstance.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            txnFileInstance.txnAmt = amount
            txnFileInstance.txnCode = TxnTemplate.get(x).code
            txnFileInstance.txnDate = branch.runDate
            txnFileInstance.txnTimestamp = new Date().toTimestamp()
            txnFileInstance.txnDescription = TxnTemplate.get(x).codeDescription
            txnFileInstance.status = ConfigItemStatus.get(2)
            txnFileInstance.txnType = TxnTemplate.get(x).txnType
            txnFileInstance.txnRef = params.txnReference.toString()
            txnFileInstance.txnParticulars = params.txnParticulars.toString()
            txnFileInstance.save(flush:true,failOnError:true)
            glTransactionService.saveTxnBreakdown(txnFileInstance.id)
            def loanLedgerEntry = new LoanLedger(loan: loanInstance, txnFile: txnFileInstance, txnDate: branch.runDate, txnTemplate: TxnTemplate.get(x), interestCredit: loanInstance.advInterest, interestDebit:loanInstance.advInterest, chargesCredtit:deduct ,chargesDebit:deduct , txnRef: txnFileInstance.txnRef,principalBalance: loanInstance.balanceAmount)
            loanLedgerEntry.save(flush:true,failOnError:true)
            
            // handling of loan renewal pay-off to old loan
            println '+++' + loanInstance
            def lnRenew = LoanRenewal.findAllByNewLoanAndRenewalCompleted(loanInstance,false, [max: 1, sort: "id", order: "asc"])
            if (lnRenew) {
                for (l in lnRenew) {
                    // debit new loan for total due
                    def oldLoan = l.oldLoan
                    def debitTxn = TxnTemplate.get(Institution.findByParamCode('LNS.50081').paramValue.toInteger())   // should be changed later to parameter
                    def totAmtToClose = oldLoan.balanceAmount + oldLoan.interestBalanceAmount + oldLoan.penaltyBalanceAmount + oldLoan.serviceChargeBalanceAmount
                    // create debit txnFile
                    def debitTf = new TxnFile(acctNo:loanInstance.accountNo, branch:loanInstance.branch, 
                        currency:loanInstance.product.currency, loanAcct:loanInstance, status:ConfigItemStatus.get(2), 
                        txnAmt:totAmtToClose, txnCode:debitTxn.code, 
                        txnDate:loanInstance.branch.runDate, txnDescription:'Renewal payout',
                        txnParticulars: 'Renewal payout to ' + oldLoan.accountNo, txnRef:'Renewal :' + oldLoan.accountNo,
                        txnTemplate:debitTxn, txnTimestamp: new Date().toTimestamp(), txnType:debitTxn.txnType,
                        user:UserMaster.get(session.user_id))
                    debitTf.save(flush:true)
                    def debitLd = new LoanLedger(loan:loanInstance, principalDebit:totAmtToClose, txnCode:debitTxn.code,
                        principalBalance:loanInstance.balanceAmount + totAmtToClose, txnDate:loanInstance.branch.runDate,
                        txnFile:debitTf, txnParticulars:'Renewal payout to ' + oldLoan.accountNo,
                        txnRef:'Renewal :' + oldLoan.accountNo, txnTemplate:debitTxn)
                    debitLd.save(flush:true)
                    glTransactionService.saveTxnBreakdown(debitTf.id)
                    
                    loanInstance.balanceAmount += totAmtToClose
                    loanInstance.totalDisbursementAmount += totAmtToClose
                    // credit payment to old loan
                    def creditTxn = TxnTemplate.get(Institution.findByParamCode('LNS.50082').paramValue.toInteger())   // should be changed later to parameter
                    def creditTf = new TxnFile(acctNo:oldLoan.accountNo, branch:loanInstance.branch, 
                        currency:oldLoan.product.currency, loanAcct:oldLoan, status:ConfigItemStatus.get(2), 
                        txnAmt:totAmtToClose, txnCode:creditTxn.code, 
                        txnDate:oldLoan.branch.runDate, txnDescription:'Renewal payment',
                        txnParticulars: 'Renewal payment from ' + loanInstance.accountNo, 
                        txnRef:'Renewal :' + loanInstance.accountNo,
                        txnTemplate:creditTxn, txnTimestamp: new Date().toTimestamp(), txnType:creditTxn.txnType,
                        user:UserMaster.get(session.user_id))
                    creditTf.save(flush:true)
                    def creditLd = new LoanLedger(loan:oldLoan, txnCode:debitTxn.code,
                        chargesBalance:0, chargesCredit:oldLoan.serviceChargeBalanceAmount, 
                        chargesDebit: oldLoan.serviceChargeBalanceAmount, 
                        interestBalance:0, interestCredit:oldLoan.interestBalanceAmount, 
                        interestDebit:oldLoan.interestBalanceAmount,
                        penaltyBalance:0, penaltyCredit: oldLoan.penaltyBalanceAmount,
                        penaltyDebit:oldLoan.penaltyBalanceAmount,
                        principalBalance:0, principalCredit: oldLoan.balanceAmount,
                        txnDate:loanInstance.branch.runDate,
                        txnFile:creditTf, txnParticulars:'Renewal payment from ' + loanInstance.accountNo,
                        txnRef:'Renewal:' + loanInstance.accountNo, txnTemplate:creditTxn)
                    creditLd.save(flush:true)   
                    // loan payment details
                    def txnLoanPaymentDetailsInstance = new TxnLoanPaymentDetails(acct:oldLoan,
                        acctNo:oldLoan.accountNo, balForwarded:oldLoan.balanceAmount,
                        branch:oldLoan.branch, currency:oldLoan.product.currency,
                        interestAmt:oldLoan.interestBalanceAmount, interestBalAfterPayment:0,
                        paymentAmt:totAmtToClose, penaltyAmt:oldLoan.penaltyBalanceAmount,
                        penaltyBalAfterPayment:0, principalAmt:oldLoan.balanceAmount, principalBalAfterPayment:0,
                        serviceChargeAmt:oldLoan.serviceChargeBalanceAmount,
                        totalNetProceeds:0, txnDate:oldLoan.branch.runDate,txnFile:creditTf,
                        txnRef:'Renewal:' + loanInstance.accountNo, user:UserMaster.get(session.user_id)) 
                    txnLoanPaymentDetailsInstance.save(flush:true,failOnError:true)
                    glTransactionService.saveTxnBreakdown(creditTf.id)
                    
                    // close old loan
                    oldLoan.status = LoanAcctStatus.get(6)
                    oldLoan.balanceAmount = 0
                    oldLoan.interestBalanceAmount = 0
                    oldLoan.penaltyBalanceAmount = 0
                    oldLoan.serviceChargeBalanceAmount = 0
                    oldLoan.save(flush:true)
                    // save renewal
                    l.renewalCompleted = true
                    l.save(flush:true)
                }
            }
            request.withFormat {
            form multipartForm {
                flash.message = "Loan Approve Success"
                //redirect loanInstance
                redirect controller:params?.module, action: 'show', id: loanInstance.id
            }
            '*'{ render status: NO_CONTENT }
        }
 
    } 
    
    /*
     * Branch
     */

    def showUpdateBranchAjax() {
        def loanInstance = Loan.get(params.id)
        
        render(template:"branch/form", model:[loanInstance:loanInstance]) as JSON
        return
    }

    @Transactional
    def updateBranchAjax() {
        println params
        def loanInstance = Loan.get(params.id)
        
        if (loanInstance.branch.id == params.branch.id) {
            def message = "ERROR: Same branch selected"
            render(template:"branch/form", model:[loanInstance:loanInstance, message:message]) as JSON
            return
        }
        
        createLoanHistoryEntry(loanInstance)
        createSessionData(loanInstance)

        loanService.commitLoanHistoryEntry("Branch Transfer")
        clearLoanData(loanInstance)

        loanService.updateBranch(loanInstance, Branch.get(params.branch.id), params.particulars, params.reference, UserMaster.get(session.user_id))
        println params.branch.id
        def message = "Branch successfully updated"
        render(template:"branch/form", model:[loanInstance:loanInstance, message:message]) as JSON

        return
    }
    /*
     * Status
     */

     def viewRopa(){
        if(params.id){
            def loanInstance = Loan.get(params.id)
            def txnRopaInstance = new TxnRopaDetails()
            render(view:'ropa/view', model: [loanInstance:loanInstance, txnRopaInstance:txnRopaInstance])
        }else{
            notFound()
        }  
    }
    
     def viewWriteOff(){
        if(params.id){
            def loanInstance = Loan.get(params.id)
            render(view:"writeOff/view",model:[loanInstance:loanInstance])
        }else{
            notFound()
        }  
    }

    def showUpdateStatusAjax() {
        def loanInstance = Loan.get(params.id)
        
        render(template:"status/form1", model:[loanInstance:loanInstance, save:'save']) as JSON
        return
    }
        def showUpdateStatAjax() {
        def loanInstance = Loan.get(params.id)
        
        render(template:"status/form", model:[loanInstance:loanInstance]) as JSON
        return
    }

//    @Transactional
//    //loan aproval instead we use approve function
//    def updateStatusAjax() {
//        def loanInstance = Loan.get(params.id)
//        createLoanHistoryEntry(loanInstance)
//        createSessionData(loanInstance)
//        def stats = LoanAcctStatus.get(params.status.id).id
//        loanInstance?.hasInterestAccrual = true
//        loanInstance.save(flush:true)
//        loanService.commitLoanHistoryEntry("Update Status to " + LoanAcctStatus.get(params.status.id).description)
//        clearLoanData(loanInstance)
//        loanService.updateStatus(loanInstance, LoanAcctStatus.get(params.status.id))
//        if (stats == 3){
//        loanService.updateOpeningBal(loanInstance, LoanAcctStatus.get(params.status.id))
//        def message = "Status successfully updated"
//            def x = Institution.findByParamCode('LNS.50074').paramValue.toInteger()
//            def branch = Branch.get(loanInstance.branchId)    
//            def txnFileInstance = new TxnFile()
//            def amount = loanInstance.grantedAmount - loanInstance.totalNetProceeds
//            def deduct = amount - loanInstance.advInterest
//            txnFileInstance.acctNo = loanInstance.accountNo
//            txnFileInstance.loanAcct = loanInstance
//            txnFileInstance.currency = Currency.get(loanInstance.product.currencyId)
//            txnFileInstance.user = UserMaster.get(session.user_id)
//            txnFileInstance.branch = Branch.get(UserMaster.get(session.user_id).branchId)
//            txnFileInstance.txnAmt = amount
//            txnFileInstance.txnCode = TxnTemplate.get(x).code
//            txnFileInstance.txnDate = branch.runDate
//            txnFileInstance.txnTimestamp = new Date().toTimestamp()
//            txnFileInstance.txnDescription = TxnTemplate.get(x).codeDescription
//            txnFileInstance.status = ConfigItemStatus.get(2)
//            txnFileInstance.txnType = TxnTemplate.get(x).txnType
//            txnFileInstance.txnRef = 'Loan Deduction'
//            txnFileInstance.save(flush:true,failOnError:true)
//            glTransactionService.saveTxnBreakdown(txnFileInstance.id)
//            def loanLedgerEntry = new LoanLedger(loan: loanInstance, txnFile: txnFileInstance, txnDate: branch.runDate, txnTemplate: TxnTemplate.get(x), interestCredit: loanInstance.advInterest, interestDebit:loanInstance.advInterest, chargesCredtit:deduct ,chargesDebit:deduct , txnRef: txnFileInstance.txnRef,principalBalance: loanInstance.balanceAmount)
//            loanLedgerEntry.save(flush:true,failOnError:true)
//        render(template:"status/form1", model:[loanInstance:loanInstance, message:message, save:'save']) as JSON
//        return
//        }
//        
//        else{
//        def message = "Status successfully updated"
//        render(template:"status/form1", model:[loanInstance:loanInstance, message:message, save:'save']) as JSON
//
//        return
//    }
//    }

        def showUpdateCloseStatusAjax() {
        def loanInstance = Loan.get(params.id)
        
        render(template:"status/form2", model:[loanInstance:loanInstance]) as JSON
        return
    }

    @Transactional
    def updateCloseStatusAjax() {
        def loanInstance = Loan.get(params.id)
        println params
        println loanInstance
        createLoanHistoryEntry(loanInstance)
        createSessionData(loanInstance)
        def stats = LoanAcctStatus.get(params.status.id).id

        loanService.commitLoanHistoryEntry("Update Status to " + LoanAcctStatus.get(params.status.id).description)
        clearLoanData(loanInstance)

        loanService.updateStatus(loanInstance, LoanAcctStatus.get(params.status.id))
        def message = "Status successfully updated"
        render(template:"status/form2", model:[loanInstance:loanInstance, message:message]) as JSON

        return
 
    }

    @Transactional
 
    def updateStatAjax() {
        def loanInstance = Loan.get(params.id)
        println params
        println loanInstance
        createLoanHistoryEntry(loanInstance)
        createSessionData(loanInstance)
        def stats = LoanAcctStatus.get(params.status.id).id
        loanService.commitLoanHistoryEntry("Update Status to " + LoanAcctStatus.get(params.status.id).description)
        clearLoanData(loanInstance)
        loanService.updateStatus(loanInstance, LoanAcctStatus.get(params.status.id))
        if (stats == 3){
        loanService.updateOpeningBal(loanInstance, LoanAcctStatus.get(params.status.id))
        def message = "Status successfully updated"
        render(template:"status/form", model:[loanInstance:loanInstance, message:message]) as JSON
        return
        }
        else{
        def message = "Status successfully updated"
        render(template:"status/form", model:[loanInstance:loanInstance, message:message]) as JSON
        return
    }
    }
    @Transactional
    def terminate(Loan loanInstance) {
        if (loanInstance == null) {
            notFound()
            return
        }

        loanInstance.statusChangedDate = loanInstance.branch.runDate
        loanInstance.status = LoanAcctStatus.get(6)
        loanInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = "Loan " + loanInstance.id + " terminated"
                redirect controller:"loanTermination", action:'show', id:loanInstance?.id 
            }
            '*'{ render status: NO_CONTENT }
        }
    }
    
    
    def transferR(Loan loanInstance, TxnRopaDetails txnRopaInstance) {
        if (loanInstance == null) {
            notFound()
            return
        }
        println 'transferR start---------------------------'
        println params
        println txnRopaInstance
        println 'transferR end  ---------------------------'
        
        createLoanHistoryEntry(loanInstance)
        def balance = loanInstance.balanceAmount
        loanInstance.status = LoanAcctStatus.get(7)
        def amount = balance  
        def credit = loanInstance.balanceAmount - balance
        loanInstance.balanceAmount = credit
                
        def branch = Branch.get(loanInstance.branchId)    
        def txnFileInstance = new TxnFile()
        txnFileInstance.acctNo = loanInstance.accountNo
        txnFileInstance.loanAcct = loanInstance
        txnFileInstance.currency = Currency.get(loanInstance.product.currencyId)
        txnFileInstance.user = UserMaster.get(session.user_id)
        txnFileInstance.branch = Branch.get(UserMaster.get(session.user_id).branchId)
        txnFileInstance.txnAmt = balance
        txnFileInstance.txnCode = TxnTemplate.get(79).code
        txnFileInstance.txnDate = branch.runDate
        txnFileInstance.txnTimestamp = new Date().toTimestamp()
        txnFileInstance.txnDescription = TxnTemplate.get(79).codeDescription
        txnFileInstance.status = ConfigItemStatus.get(2)
        txnFileInstance.txnType = TxnTemplate.get(79).txnType
        txnFileInstance.txnParticulars = loanInstance.accountNo + ' Loans Transfer to ROPA'
        txnFileInstance.txnRef = 'Loans Transfer to ROPA'
        txnFileInstance.save(flush:true,failOnError:true)
            
        def txnLoanPaymentDetailsInstance = new TxnLoanPaymentDetails() 
        txnLoanPaymentDetailsInstance.acct = loanInstance 
        txnLoanPaymentDetailsInstance.acctNo = loanInstance.accountNo  
        txnLoanPaymentDetailsInstance.balForwarded = balance
        txnLoanPaymentDetailsInstance.branch = Branch.get(UserMaster.get(session.user_id).branchId)
        txnLoanPaymentDetailsInstance.currency = Currency.get(loanInstance?.product?.currencyId)
        txnLoanPaymentDetailsInstance.interestAmt = 0
        txnLoanPaymentDetailsInstance.interestBalAfterPayment = 0
        txnLoanPaymentDetailsInstance.paymentAmt = 0
        txnLoanPaymentDetailsInstance.penaltyAmt = 0
        txnLoanPaymentDetailsInstance.penaltyBalAfterPayment = 0
        txnLoanPaymentDetailsInstance.principalAmt = amount
        txnLoanPaymentDetailsInstance.principalBalAfterPayment = loanInstance?.balanceAmount
        txnLoanPaymentDetailsInstance.serviceChargeAmt = 0
        txnLoanPaymentDetailsInstance.totalNetProceeds = loanInstance?.totalNetProceeds
        txnLoanPaymentDetailsInstance.txnDate = branch.runDate
        txnLoanPaymentDetailsInstance.txnFile = txnFileInstance 
        txnLoanPaymentDetailsInstance.txnRef = 'loan transfer to ROPA'
        txnLoanPaymentDetailsInstance.user = UserMaster.get(session.user_id)
        txnLoanPaymentDetailsInstance.save(flush:true,failOnError:true)
        glTransactionService.saveTxnBreakdown(txnFileInstance.id)
            
        def loanLedgerEntry = new LoanLedger(loan: loanInstance, txnFile: txnFileInstance, txnDate: branch.runDate, txnTemplate: TxnTemplate.get(79), txnRef: txnFileInstance.txnRef,principalCredit: amount ,principalBalance: loanInstance.balanceAmount)
                loanLedgerEntry.save(flush:true,failOnError:true)
                
        loanService.commitLoanHistoryEntry("Transfer to ROPA" )
        loanInstance.save flush:true
        /*
        def txnRopaDetails = new TxnRopaDetails(txnFile:txnFileInstance, 
            modeOfForeclosure:txnRopaInstance.modeOfForeclosure, dateBooked:txnRopaInstance.dateBooked,
            dateAcquired:txnRopaInstance.dateAcquired, dateRegistered:txnRopaInstance.dateAcquired,
            dateNotarized:txnRopaInstance.dateNotarized, dateConsolidated:txnRopaInstance.dateNotarized,
            expiryOfRedemption:txnRopaInstance.expiryOfRedemption, particulars:txnRopaInstance.particulars)
        txnRopaDetails.save(flush:true)
       */
       request.withFormat {
            form multipartForm {
                flash.message = "Loan " + loanInstance.id + " TRANSFER TO ROPA "
                 session["transactionFileId"] = txnFileInstance.id.toInteger()
                 redirect(controller: "tellering", action: "txnSuccess")
            }
            '*'{ render status: NO_CONTENT }
        }
    }
       
    
        def transferW(Loan loanInstance) {
        if (loanInstance == null) {
            notFound()
            return
        }
                createLoanHistoryEntry(loanInstance)
                def balance = loanInstance.balanceAmount
                def amount = balance - 1
                loanInstance.status = LoanAcctStatus.get(8)
                def credit = loanInstance.balanceAmount - (balance - 1)
                loanInstance.balanceAmount = credit
            def branch = Branch.get(loanInstance.branchId)    
            def txnFileInstance = new TxnFile()
            txnFileInstance.acctNo = loanInstance.accountNo
            txnFileInstance.loanAcct = loanInstance
            txnFileInstance.currency = Currency.get(loanInstance.product.currencyId)
            txnFileInstance.user = UserMaster.get(session.user_id)
            txnFileInstance.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            txnFileInstance.txnAmt = amount
            txnFileInstance.txnCode = TxnTemplate.get(80).code
            txnFileInstance.txnDate = branch.runDate
            txnFileInstance.txnTimestamp = new Date().toTimestamp()
            txnFileInstance.txnDescription = TxnTemplate.get(80).codeDescription
            txnFileInstance.status = ConfigItemStatus.get(2)
            txnFileInstance.txnType = TxnTemplate.get(80).txnType
            txnFileInstance.txnRef = 'Loans Transfer to Write Off'
            txnFileInstance.txnParticulars = loanInstance.accountNo + ' Loans Transfer to Write Off'
            txnFileInstance.save(flush:true,failOnError:true)
         
        def txnLoanPaymentDetailsInstance = new TxnLoanPaymentDetails() 
            txnLoanPaymentDetailsInstance.acct = loanInstance 
            txnLoanPaymentDetailsInstance.acctNo = loanInstance.accountNo  
            txnLoanPaymentDetailsInstance.balForwarded = balance
            txnLoanPaymentDetailsInstance.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            txnLoanPaymentDetailsInstance.currency = Currency.get(loanInstance?.product?.currencyId)
            txnLoanPaymentDetailsInstance.interestAmt = 0
            txnLoanPaymentDetailsInstance.interestBalAfterPayment = 0
            txnLoanPaymentDetailsInstance.paymentAmt = 0
            txnLoanPaymentDetailsInstance.penaltyAmt = 0
            txnLoanPaymentDetailsInstance.penaltyBalAfterPayment = 0
            txnLoanPaymentDetailsInstance.principalAmt = amount
            txnLoanPaymentDetailsInstance.principalBalAfterPayment = loanInstance?.balanceAmount
            txnLoanPaymentDetailsInstance.serviceChargeAmt = 0
            txnLoanPaymentDetailsInstance.totalNetProceeds = loanInstance?.totalNetProceeds
            txnLoanPaymentDetailsInstance.txnDate = branch.runDate
            txnLoanPaymentDetailsInstance.txnFile = txnFileInstance 
            txnLoanPaymentDetailsInstance.txnRef = 'Loans Transfer to Write Off'
            txnLoanPaymentDetailsInstance.user = UserMaster.get(session.user_id)
            txnLoanPaymentDetailsInstance.save(flush:true,failOnError:true)
            glTransactionService.saveTxnBreakdown(txnFileInstance.id)
            def loanLedgerEntry = new LoanLedger(loan: loanInstance, txnFile: txnFileInstance, txnDate: branch.runDate, txnTemplate: TxnTemplate.get(80), txnRef: txnFileInstance.txnRef,principalCredit: amount,principalBalance: loanInstance.balanceAmount)
            loanLedgerEntry.save(flush:true,failOnError:true)
                
                loanService.commitLoanHistoryEntry("Transfer to Write off ")
                loanInstance.save flush:true
           
       request.withFormat {
            form multipartForm {
                flash.message = "Loan " + loanInstance.id + " TRANSFER TO WRITE OFF "
                 session["transactionFileId"] = txnFileInstance.id.toInteger()
                 redirect(controller: "tellering", action: "txnSuccess")
            }
            '*'{ render status: NO_CONTENT }
        }
       }
    
    

         
        



    /*@Transactional
    def writeOff(Loan loanInstance) {
        if (loanInstance == null) {
            notFound()
            return
        }

        loanInstance.status = LoanAcctStatus.get(7)
        loanInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = "Loan " + loanInstance.id + " written off"
                redirect controller:"loanWriteOff", action:'show', id:loanInstance?.id 
            }
            '*'{ render status: NO_CONTENT }
        }
    }*/

    @Transactional
    def transferToROPA() {
        def loanInstance = Loan.get(params.id)

        createLoanHistoryEntry(loanInstance)
        createSessionData(loanInstance)

        loanService.commitLoanHistoryEntry("ROPA")
        clearLoanData(loanInstance)

        loanService.ropa(loanInstance)

        request.withFormat {
            form multipartForm {
                flash.message = "Loan " + loanInstance.id + " transfered to ROPA"
                redirect controller:"loanROPA", action:'show', id:loanInstance?.id 
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    /*
     * GL Classification
     */

     def showUpdateGLClassificationAjax() {
        def loanInstance = Loan.get(params.id)
        
        render(template:"gl/form", model:[loanInstance:loanInstance]) as JSON
        return
    }

    @Transactional
    def updateGLClassificationAjax() {
        def loanInstance = Loan.get(params.id)

        createLoanHistoryEntry(loanInstance)
        createSessionData(loanInstance)

        loanService.commitLoanHistoryEntry("Update GL Classification")
        clearLoanData(loanInstance)

        loanService.updateGLClassification(loanInstance, CfgAcctGlTemplate.get(params.glLink.id), UserMaster.get(session.user_id))

        def message = "GL classification successfully updated"
        render(template:"gl/form", model:[loanInstance:loanInstance, message:message]) as JSON

        return
    }

    /*
     * Special
     */

    def showSpecial(Loan loanInstance) {
        respond loanInstance
    }

    def editSpecial(Loan loanInstance) {
        respond loanInstance
    }

    @Transactional
    def updateSpecial(Loan loanInstance) {
        def type = LoanSpecialType.get(params?.type.id)
        def action = params?.specialAction?.trim() 
        def transferDate = params?.transferDate ? new Date().parse("MM/dd/yyyy", params?.transferDate) : null
        if (loanInstance.special) {
            loanInstance.special.type = type
            loanInstance.special.action = action
            loanInstance.special.transferDate = transferDate
        } else {
            def special = new LoanSpecial(type: type, action: action, transferDate: transferDate)
            special.save flush:true    

            loanInstance.special = special
        }            
        loanInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Loan.label', default: 'Loan'), loanInstance.id])
                redirect action: 'showSpecial', id: loanInstance.id
                //redirect loanInstance
            }
            '*'{ respond loanInstance, [status: OK] }
        }
    }

    /*
     * Litigation
     */

    def litigation(Loan loanInstance) {
        params.max = Math.min(params?.max?.toInteger() ?: 10, 100)

        if (params.offset == null) {
            params.offset = 0
        }

        if (params.sort == null) {
            params.sort = "id"
        }
        
        def litigationExpenses = loanInstance?.special?.litigationExpenses
        def litigationDeficiencies = loanInstance?.special?.litigationDeficiencies
        
        respond loanInstance, model:[litigationExpenses:litigationExpenses, litigationDeficiencies:litigationDeficiencies]
        return
    }

    @Transactional
    def saveLitigationExpense(Loan loanInstance) {        
        def glAccount = GlAccount.get(params?.glAccount.id)        
        def type = TxnType.get(params?.type.id)        
        def amount = params?.amount?.toDouble() ?: 0

        def litigationExpense = new LitigationExpense(glAccount: glAccount, type: type, amount: amount)
        loanInstance.special.addToLitigationExpenses(litigationExpense);
        loanInstance.save flush:true

        /*params.remove("save")
        params.remove("glAccount")
        params.remove("glAccount.id")        
        params.remove("type")
        params.remove("type.id")
        params.remove("amount")*/

        redirect action: 'litigation', id: loanInstance.id
        return
    }

    @Transactional
    def saveLitigationDeficiency(Loan loanInstance) {        
        def glAccount = GlAccount.get(params?.glAccount.id)        
        def type = TxnType.get(params?.type.id)        
        def amount = params?.amount?.toDouble() ?: 0

        def litigationDeficiency = new LitigationDeficiency(glAccount: glAccount, type: type, amount: amount)
        loanInstance.special.addToLitigationDeficiencies(litigationDeficiency);
        loanInstance.save flush:true      

        redirect action: 'litigation', id: loanInstance.id
        return
    }

    /*
     * ROPA
     */

    def ropa(Loan loanInstance) {            
        respond loanInstance
        return
    }

    @Transactional
    def saveROPAExpense(Loan loanInstance) {        
        def glAccount = GlAccount.get(params?.glAccount.id)        
        def type = TxnType.get(params?.type.id)        
        def amount = params?.amount?.toDouble() ?: 0

        def ropaExpense = new ROPAExpense(glAccount: glAccount, type: type, amount: amount)
        loanInstance.special.addToRopaExpenses(ropaExpense);
        loanInstance.save flush:true
        
        redirect action: 'ropa', id: loanInstance.id
        return
    }

    @Transactional
    def saveROPAExpenseAdjustment(Loan loanInstance) {        
        def glAccount = GlAccount.get(params?.glAccount.id)        
        def type = TxnType.get(params?.type.id)        
        def amount = params?.amount?.toDouble() ?: 0

        def ropaExpenseAdjustment = new ROPAExpenseAdjustment(glAccount: glAccount, type: type, amount: amount)
        loanInstance.special.addToRopaExpenseAdjustments(ropaExpenseAdjustment);
        loanInstance.save flush:true
        
        redirect action: 'ropa', id: loanInstance.id
        return
    }

    @Transactional
    def saveROPAExpenseCapitalization(Loan loanInstance) {        
        def glAccount = GlAccount.get(params?.glAccount.id)        
        def type = TxnType.get(params?.type.id)        
        def amount = params?.amount?.toDouble() ?: 0

        def ropaExpenseCapitalization = new ROPAExpenseCapitalization(glAccount: glAccount, type: type, amount: amount)
        loanInstance.special.addToRopaExpenseCapitalizations(ropaExpenseCapitalization);
        loanInstance.save flush:true
        
        redirect action: 'ropa', id: loanInstance.id
        return
    }

    @Transactional
    def saveROPAExpenseCapitalizationAdjustment(Loan loanInstance) {        
        def glAccount = GlAccount.get(params?.glAccount.id)        
        def type = TxnType.get(params?.type.id)        
        def amount = params?.amount?.toDouble() ?: 0

        def ropaExpenseCapitalizationAdjustment = new ROPAExpenseCapitalizationAdjustment(glAccount: glAccount, type: type, amount: amount)
        loanInstance.special.addToRopaExpenseCapitalizationAdjustments(ropaExpenseCapitalizationAdjustment);
        loanInstance.save flush:true
        
        redirect action: 'ropa', id: loanInstance.id
        return
    }

    @Transactional
    def saveROPASellOff(Loan loanInstance) {        
        def glAccount = GlAccount.get(params?.glAccount.id)        
        def type = TxnType.get(params?.type.id)        
        def amount = params?.amount?.toDouble() ?: 0

        def ropaSellOff = new ROPASellOff(glAccount: glAccount, type: type, amount: amount)
        loanInstance.special.addToRopaSellOffs(ropaSellOff);
        loanInstance.save flush:true
        
        redirect action: 'ropa', id: loanInstance.id
        return
    }

    /*
     * Reports
     */

    def reports() {
        render (view:'reports/view')
    }

    def generateReport() {
        if (params.type == "1") {
            params._name = "Loan Listing"
            params._file = "loan_listing"

            //def loans = Loan.list(fetch:[customer:"eager"])

            def loanListing = []
            for(loan in Loan.list()) {
                def entry = new LoanListingEntry()
                entry.accountNo = loan?.accountNo
                entry.customerName = loan?.customer?.displayName

                entry.customerAddress = ""
                def primaryAddress = loan?.customer?.addresses?.find{it.isPrimary==true}                
                if (primaryAddress) 
                    entry.customerAddress = primaryAddress?.address1 + ', ' + primaryAddress?.address2 +', ' +primaryAddress?.address3

                entry.dateGranted = loan?.openingDate.format("MM/dd/yyyy")
                entry.maturityDate = loan?.maturityDate.format("MM/dd/yyyy")
                entry.balanceAmount = loan?.balanceAmount

                entry.uid = loan?.advInterest ?: 0
                entry.interestRate = loan?.interestRate
                entry.frequency = loan?.frequency?.description
                entry.lastTransactionDate = loan?.lastTransactionDate?.format("MM/dd/yyyy") ?: ""
                /*entry.principalAmount = 0
                entry.interestAmount = 0
                entry.amortizationAmount = 0
                entry.product = ""
                entry.status = ""*/

                loanListing.add(entry)
            }

            chain(controller:'jasper',action:'index',model:[data:loanListing], params:params)
        } else {
            //render (view:'reports/view')
            redirect action: 'reports'
        }
    }
        

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'loan.label', default: 'Loan'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
        protected void statusPending() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.approval', args: [message(code: 'loan.label', default: 'Loan'), params.id])
                redirect action: "index", method: "GET"
                flash.warning = ' angelo'
           
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    // start of my coding JM CODES HERE================================================== JM CODES HERE ==============

    def showImportInstallmentAjax() {    
        render(template:"installments/formupload") as JSON
        return
    }
   
   // addInstallmentAjax
    def importInstallmentss(){
        
        def installmaent_date
        def principal_amt
        def interest_value
        def service_charge
        int counter=0;
        int validateTitleExcelTitleHeader =0
        println("from ajax value :"+params)
        session["installments"]="";
        session["onffvalue"]="";
        
         MultipartFile file = request.getFile( 'file' )
        file.inputStream.eachCsvLine { row ->
            
             installmaent_date = row[0]?: "NA";
             principal_amt = row[1]?: "0.00";
             interest_value = row[2]?: "0.00";
             service_charge = row[3]?: "0.00";
             
            if(validateTitleExcelTitleHeader==0){
                validateTitleExcelTitleHeader=1
            }else{
                
                println("======== CSV PER LINE ===============")
                println("Installment Date: "+installmaent_date);
                println("Principal Amount: "+principal_amt);
                println("Interest Amount: "+interest_value);
                println("Service Charge: "+service_charge);
                println("=====================================")
                println("")
        
                //println("params id: "+params.id);
               
               def date = installmaent_date? new Date().parse("MM/dd/yyyy", installmaent_date) : null
               def principal = principal_amt ? (principal_amt.replaceAll(",","")).toDouble() : null
               def interest = interest_value ? (interest_value.replaceAll(",","")).toDouble() : null
               def serviceCharge = service_charge ? (service_charge.replaceAll(",","")).toDouble() : null

              // def serviceChargeddd = service_charge.toDouble()
               def installment = new LoanInstallment(installmentDate:date, principalInstallmentAmount:principal, interestInstallmentAmount:interest, serviceChargeInstallmentAmount:serviceCharge)

                def hasErrors = false
              def installments
               if (session["installments"]) {
                   
                   installments = session["installments"]
               } else {
                   
                   installments = []
               } 
               installments.add(installment)
               session["installments"] = installments             

               if (!date) {
                   installment.errors.rejectValue("installmentDate", "loanInstallment.installmentDate.null")
                   hasErrors = true
                } else {
                   def laterDate = true;
                   for(def i = 0; i < session["installments"].size(); i++) {
                        if (installment.installmentDate <= session["installments"].get(i).installmentDate) {
                           laterDate = false;
                       }
                   }

                   if (!laterDate) {
                       installment.errors.rejectValue("installmentDate", "loanInstallment.installmentDate.incorrect")    
                       hasErrors = true
                   }
               }

               if (!principal) {
                   installment.errors.rejectValue("principalInstallmentAmount", "loanInstallment.principal.null")
                   hasErrors = true
               }

               if (!interest) {
                   installment.errors.rejectValue("interestInstallmentAmount", "loanInstallment.interest.null")
                   hasErrors = true
               }

               if (hasErrors) {
                   render(template:"installments/form", model:[installment:installment]) as JSON
                   return
               } 
               counter = counter + 1;
            }

        }

        if(counter>0){

            println("pasok sa condition if counter greater than 0")
             flash.message = "Upload Successfully Executed!"    
            def add = "true"
            def message = "Installment successfully added"      
            render(template:"installments/formupload") as JSON
            
        }
    
}

    /* Download csv file code */
    /*
    def downloadSampleExcel() {
        response.setContentType('application/vnd.ms-excel')
        response.setHeader('Content-Disposition', 'Attachment;Filename="file.csv"')
        WritableWorkbook workbook = Workbook.createWorkbook(response.outputStream)
        WritableSheet sheet1 = workbook.createSheet("Students", 0)
        //excel column names / headers
        sheet1.addCell(new Label(0,0, "Installment_date"))
        sheet1.addCell(new Label(1,0, "Principal_amount"))
        sheet1.addCell(new Label(2,0, "Interest"))
        sheet1.addCell(new Label(3,0, "Service_charge"))
        // excel row values based on coordinates (column,row)
        sheet1.addCell(new Label(0,1, "10/4/2016"))
        sheet1.addCell(new Label(1,1, "10000"))
        sheet1.addCell(new Label(2,1, "200"))
        sheet1.addCell(new Label(3,1, "50"))

        workbook.write();
        workbook.close();
    }    
    */
    /* End of Download csv file code */
    
    // =======================END OF JM CODES ==============================================END OF JM CODES HERE===========
    def editSweepAccount(Loan loanInstance){
        println "id "+loanInstance.id
        
        def a = loanInstance.id.toInteger()
        session["jrxmlTcId"] = a
        def module = getModule(request?.forwardURI)
        def title = getTitle(module)

        def loanApplicationInstance = loanInstance.loanApplication

        // add computation of interest to date
        def intToDate
        use(TimeCategory) {
            def duration = loanInstance.branch.runDate - loanInstance.accruedInterestDate
            intToDate = duration.days * loanInstance.interestRate.div(100) * loanInstance.balanceAmount.div(loanInstance.interestIncomeScheme.divisor)
        }
        session["pageAction"]=""
        session["sweeplist"] =""
        session["pageAction"]="edit"
        session["loanidvalue"]=""
        session["loanidvalue"]=loanInstance.id
        println("loan id: "+loanInstance.id)
        session["sweepAccounts"] = null
 
        def c = LoanRecovery.createCriteria()
        def results = c.list {
            
            eq("fundedLoan", Loan.get(loanInstance.id))
        }
        session["sweeplist"] = results
        println("mysweepList: "+session["sweeplist"])            
        respond loanInstance, model:[loanApplicationInstance:loanApplicationInstance,module:module, title:title, intToDate:intToDate]        
    }
    def removeLoanSweepAccountAjax(){
        def json = request.JSON
        def loanSweepInstanceee = LoanRecovery.get(json.sweepIdValue.toInteger())
        auditLogService.insert('100', 'LON00600',loanSweepInstanceee.fundedLoan.accountNo + ' remove loan sweep ' + loanSweepInstanceee.depositAccount.acctNo, 'LoanRecovery', null, null, null, loanSweepInstanceee.id)
        
        println("########### value from ajax #################################")
        println("loanIdValue :"+json.loanIdValue)
        println("sweepIdValue: "+json.sweepIdValue)
        def sql = new Sql(dataSource)
        def queryall = "delete from loan_recovery where id ="+json.sweepIdValue.toInteger()+"and funded_loan_id ="+json.loanIdValue.toInteger()    
        def resultqueryall1 = sql.execute(queryall)
        println("############################################")
        def queryallsss = "select * from loan where id ="+json.loanIdValue.toInteger()
        def resultqueryall = sql.rows(queryallsss)
        render resultqueryall as JSON    
    }
    def validateDuplicateSweepDepositAcctNoAjax(){
        def json = request.JSON
        println("########### value from ajax #################################")
        println("depositAccountNo :"+json.depositAccountNo)
        println("loanAccountId: "+json.loanAccountId)
        println("depositAccountId: "+json.depositAccountId)
        
        def c = Deposit.createCriteria()
        def results = c.list {
            eq("acctNo", json.depositAccountNo.toString())
        }
        def sql = new Sql(dataSource)
        def queryall = "select * from loan_recovery where funded_loan_id = "+json.loanAccountId.toInteger()+" and deposit_account_id = "+results.id[0]
        def resultqueryall = sql.rows(queryall)
        println("result: "+resultqueryall)
        println("reuslt: "+results.id[0])
        println("############################################")
        render resultqueryall as JSON   
    }
    def editLoanSweepAccountAjaxx(){
        def json = request.JSON
        def sql = new Sql(dataSource)
        
        println("########### value from ajax #################################")
        println("saccountNo :"+json.saccountNo)
        println("sdepositAccount: "+json.sdepositAccount)
        println("stype: "+json.stype)
        println("srule :"+json.srule)
        println("sfundLimitAmt: "+json.sfundLimitAmt)
        println("sfundLimitPercentage: "+json.sfundLimitPercentage)
        println("sremarks: "+json.sremarks)
        println("loanAccountId: "+json.loanAccountIds)
        println("loanrecoveryid: "+json.loanrecoveryid)
        def loanSweepInstanceee = LoanRecovery.get(json.loanrecoveryid)
        loanSweepInstanceee.depositAccount = Deposit.get(json.sdepositAccount)
        loanSweepInstanceee.type = SweepType.get(json.stype)
        loanSweepInstanceee.rule = SweepRule.get(json.srule)
        loanSweepInstanceee.fundLimitAmt = json.sfundLimitAmt.toDouble()
        loanSweepInstanceee.fundLimitPercentage = json.sfundLimitPercentage.toDouble()
        loanSweepInstanceee.remarks = json.sremarks.toString()
        loanSweepInstanceee.fundedLoan = Loan.get(json.loanAccountIds)
        loanSweepInstanceee.status = SweepStatus.get(2)
        loanSweepInstanceee.createdBy = UserMaster.get(session.user_id)  
        loanSweepInstanceee.dateCreated = new Date()
        loanSweepInstanceee.save(flush: true) 
        auditLogService.insert('100', 'LON00600',loanSweepInstanceee.fundedLoan.accountNo + ' edit loan sweep ' + loanSweepInstanceee.depositAccount.acctNo, 'LoanRecovery', null, null, null, loanSweepInstanceee.id)
        
        def queryallsss = "select * from loan_recovery limit 1"
        def resultqueryall = sql.rows(queryallsss)
        render resultqueryall as JSON
        
    }
    def addLoanSweepAccountAjaxx(){
        def json = request.JSON
      
        println("########### value from ajax #################################")
        println("saccountNo :"+json.saccountNo)
        println("sdepositAccount: "+json.sdepositAccount)
        println("stype: "+json.stype)
        println("srule :"+json.srule)
        println("sfundLimitAmt: "+json.sfundLimitAmt)
        println("sfundLimitPercentage: "+json.sfundLimitPercentage)
        println("sremarks: "+json.sremarks)
        println("loanAccountId: "+json.loanAccountIds)
        
        def loanSweepInstanceee = new LoanRecovery()
        loanSweepInstanceee.depositAccount = Deposit.get(json.sdepositAccount)
        loanSweepInstanceee.type = SweepType.get(json.stype)
        loanSweepInstanceee.rule = SweepRule.get(json.srule)
        loanSweepInstanceee.fundLimitAmt = json.sfundLimitAmt.toDouble()
        loanSweepInstanceee.fundLimitPercentage = json.sfundLimitPercentage.toDouble()
        loanSweepInstanceee.remarks = json.sremarks.toString()
        loanSweepInstanceee.fundedLoan = Loan.get(json.loanAccountIds)
        loanSweepInstanceee.status = SweepStatus.get(2)
        loanSweepInstanceee.createdBy = UserMaster.get(session.user_id)  
        loanSweepInstanceee.dateCreated = new Date()
        loanSweepInstanceee.save(flush: true)
        
        auditLogService.insert('100', 'LON00600',loanSweepInstanceee.fundedLoan.accountNo + ' Add loan sweep ' + loanSweepInstanceee.depositAccount.acctNo, 'LoanRecovery', null, null, null, loanSweepInstanceee.id)
        
        println("savingggg.....")
        def sql = new Sql(dataSource)
        def queryall = "select * from loan_recovery limit 1"
        def resultqueryall = sql.rows(queryall)
        render resultqueryall as JSON
      
    }
    
}
