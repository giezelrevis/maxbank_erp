package icbs.deposit

import icbs.cif.Customer
import icbs.lov.ConfigItemStatus
import icbs.lov.MemoTxnType
import icbs.lov.MemoType
import icbs.lov.RolloverType
import icbs.lov.DepositType
import icbs.lov.SweepType
import icbs.lov.CheckStatus
import icbs.lov.StopPaymentOrderStatus
import icbs.lov.DepositStatus
import icbs.admin.TxnTemplate
import icbs.admin.UserMaster
import icbs.admin.Product
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.converters.JSON
import org.codehaus.groovy.grails.web.json.JSONObject
import icbs.gl.TxnGlLink
import icbs.admin.Branch
import icbs.deposit.CTD
import icbs.deposit.StopPaymentOrder
import groovy.sql.Sql
import groovy.json.JsonBuilder
import grails.converters.JSON
import grails.converters.deep.JSON
import icbs.tellering.TxnCOCI
import icbs.deposit.Cheque
import icbs.lov.PassbookStatus
import icbs.tellering.TxnDepositAcctLedger
import icbs.tellering.TxnFile
import icbs.admin.Institution
import icbs.admin.ProductTxn
import icbs.lov.TxnType
import icbs.lov.InterestPaymentMode
import icbs.admin.Module
import static java.util.Calendar.*


class DepositController {
    def jasperService
    def depositService
    def DepositPeriodicOpsService
    def AuditLogService
    def dataSource
    def txnFileID
    def GlTransactionService
    def RoleModuleService
    static allowedMethods = [save: "POST", update: ["PUT","POST"], delete: "DELETE"]
    
    def printDepositInquiry(){
        if(params.id){
            def depositInstance = Deposit.get(params.id)
            respond depositInstance
        }    
    }
    
    def createReport(){
        if(params.type=="sizing"){
            
        }
        if(params.type=="listing"){
             render(view:"reports/listing/view",model:[])
        }
    }
    /*Customer View More Information*/
    def depositViewMoreInformation(){
        def module = Module.findByCode("DEP00401")
        if (RoleModuleService.hasPermission(module) == false) {
            redirect(action:"index")
            return
        }      
        if(params.id){
           def db = new Sql(dataSource)
           def depositInstance = Deposit.get(params.id)
           def PassbookList = db.rows("select (select passbook_no from passbook where issue_passbook_id = A.id) from issue_passbook A where passbooks_idx = (select max(passbooks_idx) from issue_passbook) and deposit_id = ?",[depositInstance.id])
           def ListPassNo
           if(PassbookList.size() > 0){
            def asString = PassbookList.join(", ")
            ListPassNo = asString.substring((asString.indexOf(':') + 1),(asString.length() - 1))
            println "PASS NO: " + ListPassNo
            //depositInstance.passBookNo = ListPassNo.toInteger()
            BigInteger intListPassNo = new BigInteger(ListPassNo)
            depositInstance.passBookNo = intListPassNo
            println "DEP PASS NO: " + depositInstance.passBookNo
           }
           respond depositInstance
        }
    }
    def saveReverseFundTransfer(){
        
    }
    def viewReverseFundTransfer(){
        
    }
    def changeFundTransferCreditAcct(){
        def fundTransferInstance = new fundTransferCommand(fundingAcct:Deposit.get(params.fundingAcct),destinationAcct:Deposit.get(params.destinationAcct))
        def jsonObject =new JSONObject();
        jsonObject = jsonObject.put('creditAcct', g.render (template:'fundTransfer/templates/creditAccount',model:[fundTransferInstance:fundTransferInstance]))
        jsonObject = jsonObject.put('txnDetails',g.render (template:'fundTransfer/templates/transactionDetails',model:[fundTransferInstance:fundTransferInstance]))
        render jsonObject
    }
    def saveFundTransfer(fundTransferCommand cmd){
        if(!cmd.hasErrors()){
            def result = depositService.fundTransfer(params, session.user_id)
            if(!result.error) {
                flash.message = "Fund Transfer Successfully Made|success|alert"
                def fundTransferInstance = new fundTransferCommand(fundingAcct:result.fundingAcct)
               // redirect(controller: "Deposit", action: "viewFundTransfer", id: params.id)
                render(view:"fundTransfer/view",model:[fundTransferInstance:fundTransferInstance])
                return
            } else {
                flash.message = "Fund Transfer failed |error|alert"
                render(view:"fundTransfer/view",model:[fundTransferInstance:cmd]) as JSON
                return                
            }
        }else{
            render(view:"fundTransfer/view",model:[fundTransferInstance:cmd]) as JSON
            return
        }
    }
    def viewFundTransfer(){
        def module = Module.findByCode("DEP01100")
        if (RoleModuleService.hasPermission(module) == false) {
            redirect(action:"index")
            return
        }
        
        if(params.id){
            def fundTransferInstance = new fundTransferCommand(fundingAcct:Deposit.get(params.id))
            render(view:"fundTransfer/view",model:[fundTransferInstance:fundTransferInstance])
        }else{
            notFound()
        }  
    }
    def clearChecksFormAjax(){
        
    }
    
    def editClearChecksManuallyAjaxCancel()
    {
        flash.message = "Canceled:warning"
        println "Cancel ? "+params.id
        def coci = TxnCOCI.get(params.id)
        coci.status = ConfigItemStatus.get(4);
        coci.save flush:true
        
       // redirect (view:"clearChecksManually/view",model:[depositInstance:Deposit.get(depid)])
        response.setContentType("application/json")
        render '{"success":"Check #' + params.id + ' cancelled|warning}'
    }
    
    def editClearChecksManuallyAjaxConfirm()
    {
        def coci = TxnCOCI.get(params.id)
        def depid = coci.depAcct.id
        println "confirm ? "+coci.depAcct.availableBalAmt
        coci.depAcct.availableBalAmt += coci.checkAmt
        coci.cleared = true
        coci.checkStatus = CheckStatus.get(5)
        coci.save flush:true
        
        response.setContentType("application/json")
        render '{"success":"Check #'+params.id+' confirmed (Complete)|success"}'
        
       // flash.message = "Check #"+params.id+" confirmed (Complete):success"
       /// render(view:"clearChecksManually/view",model:[depositInstance:Deposit.get(depid)])
        
    }
    
    
    def viewClearChecksManually(){
        if(params.id){
            render(view:"clearChecksManually/view",model:[depositInstance:Deposit.get(params.id)])
        }else{
            notFound()
        }  
    }
    def updateManualRollover(){
        
        
    }
     def createManualRolloverAjax(){
        /*Calling customer is valid*/
        println "id" +params.id 
        if(params.id){
            def rolloverInstance = new Rollover()
            rolloverInstance.deposit = Deposit.read(params.id)
            if(!rolloverInstance.deposit){
                notFound()
                return
            }
            render (template:'manualFdRollover/create',model:[rolloverInstance:rolloverInstance]) as JSON
        }else{
            notFound()
            return
        }
    }
    def saveManualRollover(){
        println params

        def result = depositService.saveManualRollover(params, session.user_id)
        if(!result.error) {
            flash.message = " Manual Rollover Successfully Created"
            render (template:'manualFdRollover/create',model:[rolloverInstance:new Rollover(deposit:result.rolloverInstance.deposit)]) as JSON
            return
        }else{
            render (template:'manualFdRollover/create',model:[rolloverInstance:result.rolloverInstance]) as JSON
            return
        }
    }
    def viewManualFdRollover(){
        if(params.id){
            render(view:"manualFdRollover/view",model:[depositInstance:Deposit.get(params.id)])
        }else{
            notFound()
        }  
    }
    def interestRateFormAjax(){
        println"interest rate form"+params
        if(params.id){
            render(template:"interestRateMaintenance/template/allAccounts",model:[depositInterestSchemeInstance:DepositInterestScheme.get(params.id)])
        }else{
            notFound()
        }  
    }
    @Transactional
    def updateInterestRate(){
        println"update interest rate"+params
        if(params.type){
            if(params.type.equals('0')){
                //all accts
                println"pumasok sa all Accounts"
                def depositInterestSchemeInstance = DepositInterestScheme.get(params.id)
                bindData(depositInterestSchemeInstance,params,[include:['interestRate']])
                println "interest rate=" +depositInterestSchemeInstance.interestRate
                depositInstance.validate()
                if(depositInstance.hasErrors()){
                    render(view:'interestRateMaintenance/view',model:[depositInterestSchemeInstance:depositInterestSchemeInstance,depositInstance:Deposit.get(params.deposit)])
                    return
                }else{
                    println("depositInterestSchemeInstance"+depositInterestSchemeInstance)
                    depositInterestSchemeInstance.save flush:true
                    flash.message = "Deposit Interest Scheme:"+depositInterestSchemeInstance.name+" successfully changed"
                    render(view:'interestRateMaintenance/view',model:[depositInstance:Deposit.get(params.deposit)])
                    return
                }
            }else if(params.type.equals('1')){
                println"pumasok sa individual"
                if(params.deposit){
                    def depositInstance = Deposit.read(params.deposit)
                    bindData(depositInstance,params,[include:['interestRate']])
                    depositInstance.validate()
                    if(depositInstance.hasErrors()){
                        println "may error!"
                        render(view:'interestRateMaintenance/view',model:[depositInstance:depositInstance])
                        return
                    }else{
                        println "walang error!"
                        println("depositInstance"+depositInstance)
                        depositInstance.save flush:true
                        flash.message = "Deposit Account:"+depositInstance.id+" Successfully Changed"
                        render(view:'interestRateMaintenance/view',model:[depositInstance:depositInstance])
                        return
                    } 
                } 
            }
        }
        else{
            notFound()
        }  
    }
    def viewInterestRateMaintenance(){
        //println "interest rate maintenance"+params 
        if(params.id){
            def depositInstance = Deposit.get(params.id)
            if(depositInstance.typeId != 3){  
               flash.message = "Access Denied. This is for Time Deposit Accounts only."
               render(view:'inquiry/depositInquiry',model:[depositInstance:depositInstance])  
               return
            }
            render(view:'interestRateMaintenance/view',model:[depositInstance:depositInstance])  
        }else{
            notFound()
        }   
    }
    
    def viewSweep(){
        println "Sweep? - "+params 
        if(params.id){
            def depositInstance = Deposit.get(params.id)
            if(!depositInstance){
                notFound()
                return
            }
            render(view:'sweep/view',model:[depositInstance:depositInstance])
        }else{
            notFound()
        }   
    }
    def showSweepFormAjax(){
        if(params.id){
            def depositInstance = Deposit.read(params.id)
            if(!depositInstance){
                notFound()
                return
            }
            render(template:"sweep/viewGrid",model:[depositInstance:depositInstance]) as JSON
            return
        }else{
            notFound()
            return     
        }
    }
    
    def editSweepAjax(){
        if(params.id){
            def sweepInstance = Sweep.get(params.id)
            if(!sweepInstance){
                notFound()
                return
            }
            render (template:'sweep/edit',model:[sweepInstance:sweepInstance]) as JSON
        }else{
            notFound()
            return
        }
    }
    def createSweepAjax(){
        println "create Sweep Order params = "+params
        /*Calling customer is valid*/
        if(params.id){
            def sweepInstance = new Sweep()
            sweepInstance.fundingDeposit = Deposit.read(params.id)
            if(!sweepInstance.fundingDeposit){
                notFound()
                return
            }
            //galing sa search
            if(params.deposit){
                println "pumasok dito search deposit sweep"
                sweepInstance.fundedDeposit = Deposit.get(params.deposit)
                    if(!sweepInstance.fundedDeposit){
                    notFound()
                    return
                }
            }   
            render (template:'sweep/create',model:[sweepInstance:sweepInstance]) as JSON
        }else{
            notFound()
            return
        }
    }
    def saveSweepAjax(){
        params.userId = session.user_id
        println params
        def result = depositService.saveSweep(params)
        if(!result.error) {
            flash.message = "Sweep Successfully Created"
            render (template:'sweep/create',model:[sweepInstance:new Sweep(fundingDeposit:result.sweepInstance.fundingDeposit)]) as JSON
            return
        }else{
            render (template:'sweep/create',model:[sweepInstance:result.sweepInstance]) as JSON
            return
        }
    }
    def updateSweepAjax(){
        def result = depositService.updateSweep(params)
        if(!result.error) {
            flash.message = "Sweep Successfully Updated"
            render (template:'sweep/edit',model:[sweepInstance:result.sweepInstance]) as JSON
            return
        }
        if(result.error.code == "default.not.found") {
            notFound()
            return
        }
        render (template:'sweep/edit',model:[sweepInstance:result.sweepInstance.attach()]) as JSON
    }
    
    def viewDepositStatus(){
        println "View Status"+params 
        if(params.id){
            def depositInstance = Deposit.get(params.id)
            render(view:'update/status/view',model:[depositInstance:depositInstance])
        }else{
            notFound()
            return
        }   
    }
    @Transactional
    def updateDepositStatus(){
        println'update deposit status' + params
        if(params.deposit){
            println "ENTER HERE:! "
            def depositInstance = Deposit.get(params.deposit)
            bindData(depositInstance, params)
            if(!depositInstance.validate()){
                println 'errors'+depositInstance.errors
                render(view:'update/status/view',model:[depositInstance:depositInstance])
                return
            }else{
                println "SECOND ENTER :"
                if (depositInstance.availableBalAmt != depositInstance.ledgerBalAmt) {
                    flash.message = 'Cannot Close Account - Balance Issue'
                    render(view:'update/status/view',model:[depositInstance:depositInstance])
                    return                    
                }
                // do not allow closing for dormant account
                if (depositInstance.getPersistentValue('status').id == 5) {
                    depositInstance.status = DepositStatus.get(5)
                    depositInstance.save(flush:true)
                    flash.message = 'Cannot Close Account - Dormant Status'
                    render(view:'update/status/view',model:[depositInstance:depositInstance])
                    return                     
                }
                def currentDate = Branch.get(1).runDate
                //DepositPeriodicOpsService.depositClosingInterestCalculationandPosting(depositInstance,currentDate, UserMaster.get(session.user_id))
                if (depositInstance.status == DepositStatus.get(7)) {
                   // closed account, update date closed
                   if (depositInstance.dateOpened != depositInstance.branch.runDate) {
                    DepositPeriodicOpsService.depositClosingInterestCalculationandPosting(depositInstance,currentDate, UserMaster.get(session.user_id))
                   }                   
                   depositInstance.dateClosed = currentDate
                }
                if (depositInstance.status == DepositStatus.get(3)) {
                   // reactivate closed account, update date closed
                   depositInstance.dateClosed = null
                }                
                println "EXIT HERE :"
                depositInstance.save flush:true
                flash.message = "Deposit Status Successfully Updated"
                render(view:'update/status/view',model:[depositInstance:depositInstance])
                return
            }
        }else{
            notFound()
            return
        }
    }
    /*Di kelangan nasa Inquiry*/
    def viewInwardCheckClearing(inwardCheckClearingCommand cmd){
        if(params.checkClearing){
            def f = request.getFile('checkClearing')
            if (f.empty) {
                flash.message = 'file cannot be empty'
                render(view:"inwardCheckClearing/view",model:[domainInstance:cmd,disabledProcessing:"disabled"])
                return
            }else{
                //change position as needed
                def chequeNoPos = 2
                def amountPos = 1
                def brstnPos = 3
                def acctNoPos = 0
                def trancdPos = 4
                def numberOfFieldsPerLine = 5;
                //parse
                BufferedReader reader = new BufferedReader(new InputStreamReader(f.getInputStream(), "UTF-8"));
                def lineCount = -1
                try {
                    for (String line = reader.readLine(); line != null; line = reader.readLine()) {
                        ++lineCount
                        if (lineCount==0){
                            continue
                        }
                        String[] fields = line.split();
                            
                        def cmd2 = new checkCommand()
                        if(fields.length==5){
                            println fields
                        
                            cmd2.chequeNo = fields[chequeNoPos].toLong()
                            cmd2.brstn = fields[brstnPos]
                            cmd2.trancd = fields[trancdPos]
                            cmd2.acctNo = fields[acctNoPos]
                            cmd2.amt =Double.parseDouble(fields[amountPos].replace(",", ""))
                            cmd.checks.push(cmd2)
                            cmd.count++
                        }
                    }
                    println "count!"+ cmd.count

                } finally {
                  reader.close();
                }  
                cmd.validate()
                render(view:"inwardCheckClearing/view",model:[domainInstance:cmd])
                return
            }
        }
        render(view:"inwardCheckClearing/view",model:[domainInstance:cmd,disabledProcessing:"disabled"])
    }
    def processInwardCheckClearing(inwardCheckClearingCommand cmd){
        depositService.inwardCheckClearing(cmd, session.user_id)
        flash.message = "Inward Check Clearing Completed!|success|alert"
        render(view:"inwardCheckClearing/view",model:[disabledProcessing:"disabled"])
    }
    
    def saveMemoBillsPayment(memoDebitBillsPaymentCommand cmd){
        println "BILLS PARAMS: " + params
        if(!cmd.hasErrors()){
            params.user = UserMaster.get(session.user_id)
            params.branch = UserMaster.get(session.user_id).branch
            
            def txnTemp = TxnTemplate.read(params.txnTemplate.id)
            def acctProduct = ProductTxn.findByProductAndTxnTemplate(cmd.acct.product,txnTemp)
            // transaction not allowed for product
            if (!acctProduct) {
                flash.message = 'Transaction not allowed for product|error|alert'
                render(view:"memo/view",model:[depositInstance:cmd.acct,adjustmentInstance:cmd])
                return              
            }
            
            def depBalAmt = Deposit.get(params.acct.id)
//            println "PARAMS AMOUNT: " + params
//            println "Dep Bal AMOUNT: " + depBalAmt.availableBalAmt
            if(params.amt.replace(',','').toDouble() < 0){
//                println "DITO PUMASOK:1 "
                flash.message = "Amount must be greater than 0.|warn|alert"
                render(view:"memo/view",model:[depositInstance:cmd.acct,billsPaymentInstance:cmd])
                return
            }
            if(depBalAmt.availableBalAmt < params.amt.replace(',','').toDouble()){
//                println "DITO PUMASOK:2 "
                flash.message = "Amount cannot be greater than the available balance.|warn|alert"
                render(view:"memo/view",model:[depositInstance:cmd.acct,billsPaymentInstance:cmd])
                return
            }
            
            def result = depositService.memoBillsPayment(params)
            if(!result.error) {
                flash.message = "Bills Payment Successfully made.|success|alert"
                  session["txnFileID"] = result.txnFile.id.toInteger()
                 render(view:"memo/view",model:[depositInstance:cmd.acct])
                return
            }else{
               flash.errors = result.error
            }
        }
//        println "LALABAS DITO ERROR: "
        render(view:"memo/view",model:[depositInstance:cmd.acct,billsPaymentInstance:cmd])
        return
        //redirect(action:"viewMemo",params:[deposit:params.deposit])
    }
    def saveMemoRemittance(memoDebitCreditRemittanceCommand cmd){
        println params
        //if(!cmd.hasErrors()){
            params.user = UserMaster.get(session.user_id)
            params.branch = UserMaster.get(session.user_id).branch
            def txnTemp = TxnTemplate.read(params.txnTemplate.id)
            def acctProduct = ProductTxn.findByProductAndTxnTemplate(cmd.acct.product,txnTemp)
            // transaction not allowed for product
            if (!acctProduct) {
                flash.message = 'Transaction not allowed for product|error|alert'
                render(view:"memo/view",model:[depositInstance:cmd.acct,adjustmentInstance:cmd])
                return              
            }
            
            def depBalAmt = Deposit.get(params.acct.id)
//            println "PARAMS AMOUNT: " + params
//            println "Dep Bal AMOUNT: " + depBalAmt.availableBalAmt
            if(params.amt.replace(',','').toDouble() < 0){
                flash.message = "Amount must be greater than 0.|warn|alert"
                render(view:"memo/view",model:[depositInstance:cmd.acct,remittanceInstance:cmd])
                return
            }
            if (cmd.type == MemoType.get(1)) {
                if(depBalAmt.availableBalAmt < params.amt.replace(',','').toDouble()){
                    flash.message = "Amount cannot be greater than the available balance.|warn|alert"
                    render(view:"memo/view",model:[depositInstance:cmd.acct,remittanceInstance:cmd])
                    return
                }                
            }

            
//            println "PARAMs CUSTOMER : " + params.customer
//            println "PARAMs CUSTOMER ID: " + params.customer.id
            if(!params.customer.id){
//                println "INSERT HERE:"
                flash.message = "Customer is required!|warn|alert"
                render(view:"memo/view",model:[depositInstance:cmd.acct,remittanceInstance:cmd])
                return
            }
            def result = depositService.memoRemittance(params)
            if(!result.error) {
                flash.message = "Memo Remittance Successfully made.|success|alert"
                session["txnFileID"] = result.txnFile.id.toInteger()
                render(view:"memo/view",model:[depositInstance:cmd.acct])
                return
            }else{
               flash.errors = result.error
            }
//        }
//        render(view:"memo/view",model:[depositInstance:cmd.acct,remittanceInstance:cmd])
//        return
    }
    def saveMemoAdjustment(memoDebitCreditAdjustmentCommand cmd){
        println("MEMO PARAMS: "+params)
        if(!cmd.hasErrors()){
            
            params.user = UserMaster.get(session.user_id)
            params.branch = UserMaster.get(session.user_id).branch
            def depBalAmt = Deposit.get(params.acct.id)
//            println "PARAMS AMOUNT: " + params.amt
//            println "Dep Bal AMOUNT: " + depBalAmt.availableBalAmt
            def txnTemp = TxnTemplate.read(params.txnTemplate.id)
            def acctProduct = ProductTxn.findByProductAndTxnTemplate(cmd.acct.product,txnTemp)
            // transaction not allowed for product
            if (!acctProduct) {
                flash.message = 'Transaction not allowed for product|error|alert'
                render(view:"memo/view",model:[depositInstance:cmd.acct,adjustmentInstance:cmd])
                return              
            }
            if(params.amt.replace(',','').toDouble() < 0){
                flash.message = "Amount must be greater than 0.|warn|alert"
                render(view:"memo/view",model:[depositInstance:cmd.acct,adjustmentInstance:cmd])
                return
            }
            if (cmd.type == MemoType.get(1)) {
                if(depBalAmt.availableBalAmt < params.amt.replace(',','').toDouble()){
                    flash.message = "Amount cannot be greater than the available balance.|warn|alert"
                    render(view:"memo/view",model:[depositInstance:cmd.acct,adjustmentInstance:cmd])
                    return
                }                
            }
            
            // do not allow credit to FD unless rollover start date
            if (cmd.acct.type.id == 3 && cmd.type == MemoType.get(2)) {
                if (cmd.acct.currentRollover.startDate != cmd.acct.branch.runDate) {
                    flash.message = "Credit to FD only allowed on rollover start date.|warn|alert"
                    render(view:"memo/view",model:[depositInstance:cmd.acct,adjustmentInstance:cmd])
                    return                    
                }
            }
            // do not allow debit to FD unless this is int wdl transaction
            if (cmd.acct.type.id == 3 && cmd.type == MemoType.get(1)) {
                if (cmd.acct.currentRollover.interestPaymentMode.id != 1 & cmd.acct.acrintAmt > 0) {
                    flash.message = "FD interest withdrawal not allowed for this account.|warn|alert"
                    render(view:"memo/view",model:[depositInstance:cmd.acct,adjustmentInstance:cmd])
                    return                       
                }
                def tAmt = cmd.acct.acrintAmt - cmd.acct.currentRollover.taxAmt1
                tAmt = tAmt.round(2)
                if (cmd.amt != tAmt && cmd.acct.acrintAmt > 0) {
                    flash.message = "FD interest withdrawal amount incorect.|warn|alert"
                    render(view:"memo/view",model:[depositInstance:cmd.acct,adjustmentInstance:cmd])
                    return                       
                }
                // do not allow credit to FD unless rollover start date
                if (cmd.acct.currentRollover.startDate != cmd.acct.branch.runDate && cmd.amt != cmd.acct.ledgerBalAmt && cmd.acct.acrintAmt==0) {
                    flash.message = "Debit to FD only allowed on rollover start date.|warn|alert"
                    render(view:"memo/view",model:[depositInstance:cmd.acct,adjustmentInstance:cmd])
                    return                    
                }
                                
            }    
            def result = depositService.memoAdjustment(params)
            if(!result.error) {
                flash.message = "Memo Adjustment successfully made"
                session["txnFileID"] = result.txnFile.id.toInteger() 
                def idDeposit = params.id
                println("idDeposit: "+cmd.acct.id)
                render(view:"memo/view",model:[depositInstance:cmd.acct])
            }else{
               flash.message = result.error
            }
        }
        render(view:"memo/view",model:[depositInstance:cmd.acct,adjustmentInstance:cmd])
        return
        
        
    }
    
/* Memo Transaction Validation Printing */    
     def MemoTransactionValidationSlip(){    
         def txnFileID = session.txnFileID
         try {  
            println "Memo Transaction"
            params._name = "Validation Slip Bills Payment"
            params._format = "PDF"
            params._file = "ValidationSlip.jasper" 
            params.accountid =  txnFileID 
            
            def reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            byte[] bytes = jasperService.generateReport(reportDef).toByteArray()

            response.outputStream << bytes
            response.outputStream.flush()
            
        }catch(Exception e) {
            //deal with your exception here
            e.printStackTrace()
        }
    }
    def changeRolloverFormAjax(int type){
        println params
     
        def fixedDepositTermScheme = null
        
        def currentRollover = new Rollover()
        def product = params.product
        def interestPaymentMode = params.interestPaymentMode
        def fundedDeposit = params.fundedDeposit
        
        currentRollover.type = icbs.lov.RolloverType.read(type)
        
        println(currentRollover.type.id)
        if(fundedDeposit){                 
            fundedDeposit = Deposit.read(fundedDeposit.toLong())
            currentRollover.fundedDeposit = fundedDeposit
        }else{
            fundedDeposit = null
        } 

        if(params.startDate){
            currentRollover.startDate = new Date(params.startDate);
        }else{
            if(params.fixedDepositTermScheme){
                currentRollover.startDate = Branch?.get(1).runDate 
            }
        }
        if(params.endDate){
            currentRollover.endDate = new Date(params.endDate);
        }else{
            if(params.fixedDepositTermScheme){
                currentRollover.endDate = Branch?.get(1).runDate + FixedDepositTermScheme.read(params.fixedDepositTermScheme).value.toInteger()
            }
        }
        if(params.fixedDepositTermScheme){
            fixedDepositTermScheme = params.fixedDepositTermScheme
        }
        
        render (template:'form/rollover/form',model:[currentRollover:currentRollover,interestPaymentMode:interestPaymentMode,fundedDeposit:fundedDeposit]) as JSON
    }
    def editRollover(){
        println("params: "+params)
        def depositInstance = Deposit.get(params.id.toInteger())
        println("depositInstance: "+depositInstance)
        render (view: 'manualFdRollover/editRollover', model:[depositInstance:depositInstance])
    }
    def newchangeRolloverFormAjax(int type){
        
        def json = request.JSON
      
        println("########### value from ajax #################################")
        println("depositAccount :"+json.depositID)
        println("startdate :"+json.startDate)
        println("endDate :"+json.endDate)
        println("rolltype :"+json.rolltype)
        println("newfundedDep :"+json.newfundedDep)
        println("fdinterestPaymentMode :"+json.fdinterestPaymentMode)
        
        def depositIntanceCurrentRollover = Deposit.get(json.depositID.toInteger())
        println("depositIntanceCurrentRollover: "+depositIntanceCurrentRollover)
        def currRolloverupdate = Rollover.get(depositIntanceCurrentRollover.currentRollover.id)
        println("currRolloverupdate: "+currRolloverupdate)
        if(json.fdinterestPaymentMode.toInteger() == 2){
            if(json.newfundedDep){
                println("hindi null yung funded")
                currRolloverupdate.fundedDeposit = Deposit.get(json.newfundedDep.toInteger())
            }else{
                println("null yung funded")
            }
            
        }else{
             currRolloverupdate.fundedDeposit = null
        }
        
        def startDate = new Date().parse("MM/dd/yyyy", json.startDate)
        def endDate = new Date().parse("MM/dd/yyyy", json.endDate)
        /*if(json.oldrolltypeR.toInteger() == json.rolltype.toInteger()){
            
        }else{
            
        } */      
        currRolloverupdate.startDate = startDate
        currRolloverupdate.endDate = endDate
        currRolloverupdate.type = RolloverType.get(json.rolltype.toInteger())
        currRolloverupdate.interestPaymentMode = InterestPaymentMode.get(json.fdinterestPaymentMode.toInteger())
        currRolloverupdate.save(flush: true)
        
        
        def sql = new Sql(dataSource)
        def queryall = "select * from branch limit 1"
        def resultqueryall = sql.rows(queryall)
        render resultqueryall as JSON
    }

    def changeMemoFormAjax(int formType){
        println params
        if(formType==0){
            def  adjustmentInstance= new memoDebitCreditAdjustmentCommand()
            bindData(adjustmentInstance,params)
            if(adjustmentInstance?.type?.id==1){
                println("pasok dito sa memo");
                render (template:'memo/form/creditAdjustment/debit/form',model:[adjustmentInstance:adjustmentInstance]) as JSON             
            }else{
                println("pasok dito sa credit");
                render (template:'memo/form/creditAdjustment/credit/form',model:[adjustmentInstance:adjustmentInstance]) as JSON              
            }
            return
        }
        if(formType==1){
            def remittanceInstance  = new memoDebitCreditRemittanceCommand()
            bindData(remittanceInstance,params)
            if(remittanceInstance?.type?.id==1){
                println("memo beditttttttttttttt...")
                render (template:'memo/form/remittance/debit/form',model:[remittanceInstance:remittanceInstance]) as JSON
            }else{
                 println("memo crediitttttttttttttt...")
                render (template:'memo/form/remittance/credit/form',model:[remittanceInstance:remittanceInstance]) as JSON
            }
            return
            
        }
        if(formType==2){
             def billsPaymentInstance = memoDebitBillsPaymentCommand()
             bindData(billsPaymentInstance,params)
            if(billsPaymentInstance?.type?.id=="1"){
                render (template:'memo/form/billsPayment/debit/form',model:[billsPaymentInstance:billsPaymentInstance]) as JSON
            }else{
                render (template:'memo/form/billsPayment/credit/form',model:[billsPaymentInstance:billsPaymentInstance]) as JSON
            }
            return 
        }
    }
    def viewMemo(){
        println "Memo"+params 
        if(params.id){
            def depositInstance = Deposit.get(params.id)
            def c = TxnFile.createCriteria()
            def TxnFileInstance = c.list {
                eq("txnDate", Branch.get(1).runDate)
                eq("acctNo", depositInstance.acctNo)
                'in'("txnType",[TxnType.get(7),TxnType.get(9)])
            }

            if(!depositInstance){
                notFound()
            }else{
                render(view:'memo/view',model:[depositInstance:depositInstance,TxnFileInstance:TxnFileInstance])
            }
        }
    }
    def viewStopPaymentOrder(){
        println "Stop Payment"+params 
        if(params.id){
            def depositInstance = Deposit.get(params.id)
            if(!depositInstance){
                notFound()
                return
            }
            def stopPaymentOrderList = StopPaymentOrder.findAll{cheque.issueCheque.deposit.id == params.id.toInteger()}
            render(view:'stopPaymentOrder/view',model:[depositInstance:depositInstance,stopPaymentOrderList:stopPaymentOrderList])
        }else{
            notFound()
        }   
    }
    
    def showStopPaymentOrderFormAjax(){
        if(params.id){
            def depositInstance = Deposit.read(params.id)
            if(!depositInstance){
                notFound()
                return
            }
            def stopPaymentOrderList = StopPaymentOrder.findAll{cheque.chequebook.deposit.id == params.id.toInteger()}
            render(template:"stopPaymentOrder/viewGrid",model:[depositInstance:depositInstance,stopPaymentOrderList:stopPaymentOrderList]) as JSON
            return
        }else{
            notFound()
            return     
        }
    }
    def createStopPaymentOrderAjax(){
        println "create Stop Payment Order params = "+params
        /*Calling customer is valid*/
        if(params.deposit){
            def stopPaymentOrderInstance = new StopPaymentOrder()
            stopPaymentOrderInstance.deposit = Deposit.read(params.deposit)
            if(!stopPaymentOrderInstance.deposit){
                notFound()
                return
            }
            render (template:'stopPaymentOrder/create',model:[stopPaymentOrderInstance:stopPaymentOrderInstance]) as JSON
        }else{
           notFound()
           return
        }
    }
    def editStopPaymentOrderAjax(){
        if(params.id){
            def stopPaymentOrderInstance = StopPaymentOrder.get(params.id)
            if(!stopPaymentOrderInstance){
                notFound()
                return
            }
            render (template:'stopPaymentOrder/edit',model:[stopPaymentOrderInstance:stopPaymentOrderInstance]) as JSON
        }else{
            notFound()
            return
        }
    }
    def saveStopPaymentOrderAjax(){
        def result = depositService.saveStopPaymentOrder(params)
        if(!result.error) {
            result.stopPaymentOrderInstance.stopBy = UserMaster.get(session.user_id)
            result.stopPaymentOrderInstance.save(flush:true)
            flash.message = "Stop Payment Order Successfully Created"
            render (template:'stopPaymentOrder/create',model:[stopPaymentOrderInstance:new StopPaymentOrder(deposit:result.stopPaymentOrderInstance.deposit)]) as JSON
            return
        }else{
            render (template:'stopPaymentOrder/create',model:[stopPaymentOrderInstance:result.stopPaymentOrderInstance]) as JSON
            return
        }
    }
    def updateStopPaymentOrderAjax(){
        def result = depositService.updateStopPaymentOrder(params)
        if(!result.error) {
            flash.message = "Stop Payment Order Successfully Updated"
            render (template:'stopPaymentOrder/edit',model:[stopPaymentOrderInstance:result.stopPaymentOrderInstance]) as JSON
            return
        }
        if(result.error.code == "default.not.found") {
            notFound()
            return
        }
        render (template:'stopPaymentOrder/edit',model:[stopPaymentOrderInstance:result.stopPaymentOrderInstance.attach()]) as JSON
    }
    
    def viewStandingOrder(){
        println "Standing Order"+params 
        if(params.id){
            def depositInstance = Deposit.read(params.id)
            if(!depositInstance){
                notFound()
                return
            }
            render(view:'standingOrder/view',model:[depositInstance:depositInstance])
        }else{
            notFound()
        }   
    }
    def showStandingOrderFormAjax(){
        if(params.id){
            def depositInstance = Deposit.read(params.id)
            if(!depositInstance){
                notFound()
                return
            }
            render(template:"standingOrder/viewGrid",model:[depositInstance:depositInstance]) as JSON
            return
        }else{
            notFound()
            return     
        }
    }
    def createStandingOrderAjax(){
        println "create Standing Order params = "+params
        /*Calling customer is valid*/
        if(params.id){
            def standingOrderInstance = new StandingOrder()
            standingOrderInstance.fundingDeposit = Deposit.read(params.id)
            if(!standingOrderInstance.fundingDeposit){
                notFound()
                return
            }
            //galing sa search
            if(params.deposit){
                println "pumasok dito search deposit standing ordeer!"
                standingOrderInstance.fundedDeposit = Deposit.read(params.deposit)
                if(!standingOrderInstance.fundedDeposit){
                    notFound()
                    return
                }
            }   
            render (template:'standingOrder/create',model:[standingOrderInstance:standingOrderInstance]) as JSON
        }else{
            notFound()
            return
        }
    }
    def editStandingOrderAjax(){
        if(params.id){
            def standingOrderInstance = StandingOrder.read(params.id)
            if(!standingOrderInstance){
                notFound()
                return
            }
            render (template:'standingOrder/edit',model:[standingOrderInstance:standingOrderInstance]) as JSON
        }else{
            notFound()
            return
        }
    }
    def saveStandingOrderAjax(){
        def result = depositService.saveStandingOrder(params)
        if(!result.error) {
            flash.message = "Standing Order Successfully Created"
            render (template:'standingOrder/create',model:[standingOrderInstance:new StandingOrder(fundingDeposit:result.standingOrderInstance.fundingDeposit)]) as JSON
            return
        }else{
            render (template:'standingOrder/create',model:[standingOrderInstance:result.standingOrderInstance]) as JSON
            return
        }
    }
    def updateStandingOrderAjax(){
        def result = depositService.updateStandingOrder(params)
        if(!result.error) {
            flash.message = "Standing Order Successfully Updated"
            render (template:'standingOrder/edit',model:[standingOrderInstance:result.standingOrderInstance]) as JSON
            return
        }
        if(result.error.code == "default.not.found") {
            notFound()
            return
        }
        render (template:'standingOrder/edit',model:[standingOrderInstance:result.standingOrderInstance.attach()]) as JSON
    }
    def viewHold(){
        println "hold"+params 
        if(params.id){
            def depositInstance = Deposit.read(params.id)
            if(!depositInstance){
                notFound()
                return
            }
            render(view:'hold/view',model:[depositInstance:depositInstance])
        }else{
            notFound()
        }   
    }
    def showHoldFormAjax(){
        if(params.id){
            def depositInstance = Deposit.read(params.id)
            if(!depositInstance){
                
                notFound()
                return
            }
        
            render(template:"hold/viewGrid",model:[depositInstance:depositInstance]) as JSON
            return
        }else{
         
            notFound()
            return     
        }   
    }
    def createHoldAjax(){
      //  println "?create Hold params = "+params
        /*Calling customer is valid*/
        if(params.id){
            def holdInstance = new Hold()
            holdInstance.deposit = Deposit.read(params.id)
            if(!holdInstance.deposit){
               // println "notfound1"
                notFound()
                return
            }
           // println "render/create"
            session["holdaction"]=""
            session["holdaction"]="create"									  
            render (template:'hold/create',model:[holdInstance:holdInstance]) as JSON
        }else{
           // println "notfound2"
            notFound()
            return
        }
    }
    def editHoldAjax(){
        if(params.id){
            def holdInstance = Hold.read(params.id)
            if(!holdInstance){
                notFound()
                return
            }
            session["holdaction"]=""
            session["holdaction"]="edit"									
            render (template:'hold/edit',model:[holdInstance:holdInstance]) as JSON
        }else{
            notFound()
            return
        }
    }
    def saveHoldAjax(){
        
        params.heldBy = UserMaster.get(session.user_id)
        def result = depositService.saveHold(params)
        if(!result.error) {
            //println "saveholdsuccess?"
            flash.message = "Hold Successfully Issued"
            render (template:'hold/create',model:[holdInstance:new Hold(deposit:result.holdInstance.deposit)]) as JSON
            return
        }else{
            //println "saveholderr1?"
            flash.message = result.error.code
            render (template:'hold/create',model:[holdInstance:result.holdInstance]) as JSON
            return
        }
    }
    def updateHoldAjax(){
       // println "update old ajax?"
        def result = depositService.updateHold(params)
        if(!result.error) {
            flash.message = "Hold Successfully Updated"
            render (template:'hold/edit',model:[holdInstance:result.holdInstance]) as JSON
            return
        }
        if(result.error.code == "default.not.found") {
            notFound()
            return
        }
        if (result.error) {
            flash.message = result.error.code
            render (template:'hold/edit',model:[holdInstance:result.holdInstance]) as JSON
            return            
        }
        render (template:'hold/edit',model:[holdInstance:result.holdInstance.attach()]) as JSON
    } 
    def viewChecksAjax(){
        if(params.id){
            def chequebookInstance = Chequebook.read(params.id)
            if(!chequebookInstance){
                notFound()
                return
            }
            render (template:'chequebook/checks/checkGrid',model:[chequebookInstance:chequebookInstance]) as JSON
        }else{
            notFound()
            return
        }
        
    }
    def viewCheckbook(){
        println "chequebook"+params 
        if(params.id){
            def depositInstance = Deposit.read(params.id)
            if(!depositInstance){
                notFound()
                return
            }
            render(view:'chequebook/view',model:[depositInstance:depositInstance])
        }else{
            notFound()
            return
        }   
    }
    def showCheckbookFormAjax(){
        if(params.id){
            def depositInstance = Deposit.read(params.id)
            if(!depositInstance){
                notFound()
                return
            }
            render(template:"chequebook/viewGrid",model:[depositInstance:depositInstance]) as JSON
            return
        }else{
            notFound()          
        }    
    }
    def createCheckbookAjax(){
        println "create chequebook params = "+params
        /*Calling customer is valid*/
        if(params.id){
            def chequebookInstance = new Chequebook()
            chequebookInstance.deposit = Deposit.read(params.id)
            if(!chequebookInstance.deposit){
                notFound()
                return
            }
            render (template:'chequebook/create',model:[chequebookInstance:chequebookInstance]) as JSON
        }else{
            notFound()
            return
        }
    }
    def editCheckbookAjax(){
        if(params.id){
            def chequebookInstance = Chequebook.read(params.id)
            if(!chequebookInstance){
                notFound()
                return
            }
            render (template:'chequebook/edit',model:[chequebookInstance:chequebookInstance]) as JSON
        }else{
            notFound()
            return
        }
    }
    def cancelCheckbookAjax(){
        if(params.id){
            def chequebookInstance = Chequebook.read(params.id)
            def depositInstance = chequebookInstance.deposit
            if(!chequebookInstance){
                notFound()
                return
            }
            def result = depositService.cancelChequebook(params)
            println "RESULT??? "+result
            flash.message = "Checkbook Successfully removed|success|alert"
            if(result.error) {
                println 'error!!!!!!'
                flash.message = "Checkbook cancel failed|error|alert"
            }
            redirect(action: "viewCheckbook", id: depositInstance.id)
        }           
    }
    def saveCheckbookAjax(){
        println "saveCheckbookAjax params ? "+params
        def result = depositService.saveChequebook(params)
        if(!result.error) {
            flash.message = "Checkbook Successfully Issued"
            render (template:'chequebook/create',model:[chequebookInstance:new Chequebook(deposit:result.chequebookInstance.deposit)]) as JSON
            return
        }else{
            render (template:'chequebook/create',model:[chequebookInstance:result.chequebookInstance]) as JSON
            return
        }
    }
    def updateCheckbookAjax(){
            def result = depositService.updateChequebook(params)
            if(!result.error) {
                flash.message = "Checkbook Successfully Updated"
                render (template:'chequebook/edit',model:[chequebookInstance:result.chequebookInstance]) as JSON
                return
            }
            if(result.error.code == "default.not.found") {
                notFound()
                return
            }
            render (template:'chequebook/edit',model:[chequebookInstance:result.chequebookInstance.attach()]) as JSON
        
    }
     def printPassbook={
        println params
        def list
        list = Customer.list(fetch:[branch:"eager"]) 
            //println customers
        chain(controller:'jasper',action:'index',model:[data:list],params:params)
        //def customers = Customer.findAll("from Customer as c left join c.contacts as a where a.status.id=2 and a.isPrimaryPhone=true")
    }
    def printPassbookCover(){
         try {  
            params._name = "Passbook Cover"
            params._format ="PDF"
            params._file ="PassbookCover.jasper" //jasper file
            params.pbID = params.passbookNo.toString()
            def reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            byte[] bytes = jasperService.generateReport(reportDef).toByteArray()

            response.outputStream << bytes
            response.outputStream.flush()
            
        }catch(Exception e) {
            //deal with your exception here
            e.printStackTrace()
        }
    }
    def viewPassbook(){
        println "passbook"+params 
        if(params.id){
            def depositInstance = Deposit.read(params.id)
            if(!depositInstance){
                notFound()
                return
            }
            if (depositInstance.branch == UserMaster.get(session.user_id).branch) {
                render(view:'passbook/view',model:[depositInstance:depositInstance])
            } else {
                flash.message = 'Passbook functions not allowed  for other branch account'
                render(view:"inquiry/depositInquiry",model:[depositInstance:depositInstance])              
            }
        }else{
            notFound()
            return
        }      
    }
    def showPassbookFormAjax(){
        if(params.id){
            def depositInstance = Deposit.read(params.id)
            if(!depositInstance){
                notFound()
                return
            }
            render(template:"passbook/viewGrid",model:[depositInstance:depositInstance]) as JSON
            return
        }else{
            notFound()
            return   
        }  
    }
    def createPassbookAjax(){
        println "create passbook params = "+params
        /*Calling customer is valid*/
   
        if(params.id){
            def issuePassbookInstance = new IssuePassbook()
            issuePassbookInstance.deposit = Deposit.read(params.id)
            issuePassbookInstance.issuedBy = UserMaster.get(session.user_id) 
            //println "ISSUED BY: " + issuePassbookInstance.issuedBy
            if(!issuePassbookInstance.deposit){
                notFound()
                return
            }
            render (template:'passbook/create',model:[issuePassbookInstance:issuePassbookInstance]) as JSON
        }else{
            notFound()
            return
        }
    }
    def editPassbookAjax(){
        if(params.id){
            def issuePassbookInstance = IssuePassbook.read(params.id)
            if(!issuePassbookInstance){
                notFound()
                return
            }
            render (template:'passbook/edit',model:[issuePassbookInstance:issuePassbookInstance]) as JSON
        }else{
            notFound()
            return
        }
    }
    def savePassbookAjax(){
        println "SAVEPASS PARAMS :" + params
        def retPass = Passbook.findByPassbookNo(params.passbookNo)
        //println retPass.docInventory?.status.id
        if(retPass)
        {
            if((retPass.docInventory.status.id == 4) || retPass.docInventory.status.id == 3)
            {
                flash.message = "Document Inventory for this passbook already cancelled or removed."
                render (template:'passbook/create',model:[issuePassbookInstance:new IssuePassbook()]) as JSON
                return
            } else {
                
                def result = depositService.savePassbook(params)
                if(!result.error) {
                    println "Save passbook Successful"
                    flash.message = "Passbook Successfully Issued"
                    render (template:'passbook/create',model:[issuePassbookInstance:new IssuePassbook(deposit:result.issuePassbookInstance.deposit)]) as JSON
                    return
                }else{
                    println '++++++++++++++++++++++++++++++++++++++++++++++++++'
                    println result.error
                    flash.message = result.error.code
                    render (template:'passbook/create',model:[issuePassbookInstance:result.issuePassbookInstance]) as JSON
                    return
                }
                
            }
        } else {
            def issuePassbookInstance = new IssuePassbook()
            issuePassbookInstance.deposit = Deposit.read(params.deposit.id)
            issuePassbookInstance.issuedBy = UserMaster.get(session.user_id) 
            
            flash.message = 'Invalid Passbook Number'
            render (template:'passbook/create',model:[issuePassbookInstance:issuePassbookInstance]) as JSON
            return
            
        }

    }
    def updatePassbookAjax(){
        def result = depositService.updatePassbook(params)
        if(!result.error) {
            flash.message = "Passbook Successfully Updated"
            render (template:'passbook/edit',model:[issuePassbookInstance:result.issuePassbookInstance]) as JSON
            return
        }
        if(result.error.code == "default.not.found") {
            notFound()
            return
        }
        render (template:'passbook/edit',model:[issuePassbookInstance:result.issuePassbookInstance.attach()]) as JSON
    }
    def printCTD={
        println params
        def list = IssueCTD.findAllById(params.id.toLong()) 
            //println customers
        chain(controller:'jasper',action:'index',model:[data:list],params:params)
        
        //def customers = Customer.findAll("from Customer as c left join c.contacts as a where a.status.id=2 and a.isPrimaryPhone=true")
    }
    def viewCTD(){
        if(params.id){
            def depositInstance = Deposit.get(params.id)
            if(!depositInstance){
                notFound()
                return
            }
            render(view:'ctd/view',model:[depositInstance:depositInstance])
        }else{
            notFound()
        }
    } 
    def createCTDAjax(){
        println params
        /*Calling customer is valid*/
        if(params.id){
            def issueCTDInstance = new IssueCTD()
            def CTDInstance = new CTD()
            
            issueCTDInstance.deposit = Deposit.read(params.id)
            if(!issueCTDInstance.deposit){
                notFound()
                return
            }
            render (template:'ctd/create',model:[issueCTDInstance:issueCTDInstance]) as JSON
        }else{
            notFound()
            return
        }
    }
    def editCTDAjax(){
        if(params.id){
            def issueCTDInstance = IssueCTD.read(params.id)
            if(!issueCTDInstance){
                notFound()
                return
            }
            render (template:'ctd/edit',model:[issueCTDInstance:issueCTDInstance]) as JSON
        }else{
            notFound()
            return
        }
    }
    def showCTDFormAjax(){
        if(params.id){
            def depositInstance = Deposit.read(params.id)
            if(!depositInstance){
                notFound()
                return
            }
            render(template:"ctd/viewGrid",model:[depositInstance:depositInstance]) as JSON
            return
        }else{
            notFound()
            return   
        }  
    }
     def saveCTDAjax(){
         println"paramsssssssssssssssssss " +params
        def result = depositService.saveCTD(params)
//        def ctdstat = new CTD()
//        println" ctdstat "+ctdstat
        if(!result.error) {
            result.issueCTDInstance.issuedBy = UserMaster.get(session.user_id)
            result.issueCTDInstance.save(flush:true)
            println "Save CTD Successful"
            flash.message = "CTD Successfully Issued"
            render (template:'ctd/create',model:[issueCTDInstance:new IssueCTD(deposit:result.issueCTDInstance.deposit)]) as JSON
            return
        }else{
            render (template:'ctd/create',model:[issueCTDInstance:result.issueCTDInstance]) as JSON
            return
        }
    }
    def updateCTDAjax(){
        def result = depositService.updateCTD(params)
         println("update ctd success!")
         println params
        if(!result.error) {
            println("update ctd success!")
            flash.message = "CTD Successfully Updated"
            render (template:'ctd/edit',model:[issueCTDInstance:result.issueCTDInstance]) as JSON
            return
        }
        if(result.error.code == "default.not.found") {
            notFound()
            return
        }
        render (template:'ctd/edit',model:[issueCTDInstance:result.issueCTDInstance.attach()]) as JSON
    }
    def index() {
       // println "module??? "+ params?.module
        
        def module
        if (params?.module)
            module = params?.module
        else
            module = getModule(request?.forwardURI)
        //def title = getTitle(module)
        //println module
        redirect(action:'depositSearch', params:[module:module])
    }
    def getModule(String url) {
        println url
        if (url =~ /^.*\/deposit\/edit.*$/) {
            return "edit"
        }
        if (url =~ /^.*\/deposit\/viewCheckbook.*$/) {
            return "checkbook"
        }
        else if (url =~ /^.*\/deposit\/viewPassbook.*$/) {
            return "passbook"
        }
        else if (url =~ /^.*\/deposit\/viewCTD.*$/) {
            return "ctd"
        }
        else if (url =~ /^.*\/deposit\/viewHold.*$/) {
            return "hold"
        } 
        else if (url =~ /^.*\/deposit\/viewStandingOrder.*$/) {
            return "standingorder"
        }
        else if (url =~ /^.*\/deposit\/viewMemo.*$/) {
            return "memo"
        } 
        else if (url =~ /^.*\/deposit\/viewStopPaymentOrder.*$/) {
            return "spo"
        } 
        else if (url =~ /^.*\/deposit\/viewDepositStatus.*$/) {
            return "close"
        } 
        else if (url =~ /^.*\/deposit\/viewInterestRateMaintenance.*$/) {
            return "irm"
        } 
        else if (url =~ /^.*\/deposit\/viewSweep.*$/) {
            return "sweep"
        }
        else if (url =~ /^.*\/deposit\/viewFundTransfer.*$/) {
            return "fundtransfer"
        } 
        else if (url =~ /^.*\/deposit\/viewClearChecksManually.$/) {
            return "clearchecksmanually"
        } 
        else if (url =~ /^.*\/deposit\/viewManualFdRollover.*$/) {
            return "manualfdrollover"
        }    
    }
    def depositSearch(String module){
        if(module){
            params.module = module
        }
        params.actionTemplate = 'depositInquirySearchAction';
  //      println "???? "+params
        render(view:'search/depositSearch', model:[params:params])
    }
    def depositInquiry(){
        println(params)
        if(params.id){
           def depositInstance = Deposit.get(params.id)
           println "def1 "
           render(view:"inquiry/depositInquiry",model:[depositInstance:depositInstance])
        }
        else {
            println "def2 "
           render(view:'inquiry/depositInquiry')
        }
    }
    def addSignatoryFormAjax(){
        println params
        if(params.signatory){
            def signatory = new Signatory()
            signatory.signatory = Customer.read(params.signatory);
            def i 
            //if Update
            if(params.deposit){
                def depositInstance = Deposit.read(params.deposit)
                    depositInstance?.signatories.eachWithIndex { obj, v ->
                        println "${v}: ${obj}"
                    }
                i = (depositInstance?.signatories.findIndexOf{it?.signatory?.id==params.signatory})  // Start with B.{key,value-> value?.signatory ==params.signatory})?.key
                println i  +  "i#1";
                if(i==null||i==-1){
                    if(depositInstance?.signatories!=null){
                        i = depositInstance?.signatories.size()
                         println i  +  "i#2";
                    }else{
                        i=0
                    }   
                }
            }else{
                i = params.i
            }
            println(i + "ung i!")
            render (template:'form/signatory/onetomany/signatory',model:[signatory:signatory,i:i]) as JSON
        }else{
            render "" as JSON
        }
    }
    def showCustomerDetailsAjax(){
        if(params.customer){
            def customerInstance = Customer.read(params.customer)
            render (template:'/customer/details/customerDetails',model:[customerInstance:customerInstance,boxName:params.boxName]) as JSON
        }
    }
    def showDepositDetailsAjax(){
        println params
        if(params.deposit){
            def depositInstance = Deposit.read(params.deposit.toLong())
            render (template:'/deposit/details/depositDetails',model:[depositInstance:depositInstance,boxName:params.boxName]) as JSON
        }
    }
    def changeDepositFormAjax(){
        def cmd = new depositInitialCommand()
        println params
        if(params.changeType=="type"){
            println "pumasok sa changeType"
            bindData(cmd, params, [include: ['type','customer']])
        }
        else if(params.changeType=="product"){
            bindData(cmd, params, [exclude: ['depositInterestScheme']])
        }else{
             bindData(cmd, params)
        }
        render(template:"form/deposit/typeAndProduct", model:[depositInstance:cmd,firstCreate:true]) as JSON
    }
    def show(Deposit depositInstance) {
        respond depositInstance
    }

    def create(depositInitialCommand cmd) {
        println params
        if(params.customerFromCIFPage!=null){
            cmd.customer = Customer.read(params.customerFromCIFPage)
        }else{
            if(params.customer?.id){
                cmd.customer = Customer.read(params.customer.id)
            }
        }
        if(params.firstCreate!=null){
            if(cmd.hasErrors()){
                render (view:'create',model:['depositInstance': cmd,'firstCreate':true])
            }else{
                render (view:'create',model:['depositInstance': new Deposit(params)])
            }
        }else{
            cmd.clearErrors()
            render (view:'create',model:['depositInstance': cmd,'firstCreate':true])
        }
    }
    
    def ups()
    {
        println params
        println params.txn
        def passbookinstance = IssuePassbook.get(params.txnid.toInteger())
        def passbook = passbookinstance.passbook
        def deposit = passbookinstance.deposit
        
        passbook.status = PassbookStatus.read(params.txn.toInteger())
        passbook.save flush:true
        
        // cancelled passbook
        // delete issue passbook and mark passbook as unused
        if (passbook.status == PassbookStatus.read(4)) {
            passbook.status = PassbookStatus.read(1)
            passbook.issuePassbook = null
            passbook.save(flush:true, failOnError:true)
            
            passbookinstance.delete(flush:true)
        }
        def desc = deposit.acctNo + ' - Update Passbook Status - ' + passbook.status
        AuditLogService.insert('080', 'DEP00600',desc, 'deposit', null, null, null, deposit.id)
        return
    }
    
    def pslist()
    {
        def db = new Sql(dataSource)
        def sql = "select id,description from passbook_status where id<>2"
        def results = new JsonBuilder(db.rows(sql)).toPrettyString()
        //println results
        render(text: results) as JSON
        return    
    }

    @Transactional
    def save() {
        def depositInstance = new Deposit()
        bindData(depositInstance,params)
        if (depositInstance == null) {
            notFound()
            return
        }
        if(depositInstance?.signatories){
            depositInstance.signatories.removeAll([null])
        }
        
        
        if (!depositInstance.validate()) {
            respond depositInstance.errors, view:'create'
            return
        }
        if (depositInstance?.type?.id==2 && depositInstance?.depositInterestScheme.isGraduated == false) {
            // CA int rate
            depositInstance?.interestRate = depositInstance?.depositInterestScheme.interestRate
        }    
        if (depositInstance?.type?.id==3 && depositInstance?.depositInterestScheme.isGraduated == false) {
            if (!depositInstance?.interestRate) {
                flash.message = 'Interest Rate cannot be null'
                respond depositInstance.errors, view:'create'
                return                
            }
        }
        // check for min/max rates for schemes with changeable rates
        if (depositInstance?.depositInterestScheme?.canChangeInterestRate == true){
            if (depositInstance?.interestRate > depositInstance?.depositInterestScheme?.maxInterestRate) {
                flash.message = 'Interest Rate cannot be greater than max interest rate'
                respond depositInstance.errors, view:'create'
                return                 
            }
            if (depositInstance?.interestRate < depositInstance?.depositInterestScheme?.minInterestRate) {
                flash.message = 'Interest Rate cannot be less than min interest rate'
                respond depositInstance.errors, view:'create'
                return                 
            }
        }
        def currentRollover = depositInstance.currentRollover
        depositInstance.currentRollover = null
        depositInstance.branch  = UserMaster.get(session.user_id)?.branch
        depositInstance.createdBy = session.user_id
        depositInstance.save flush:true
        if(depositInstance?.type?.id==3){
            
            depositInstance.maturityDate = currentRollover.endDate
            depositInstance.save flush:true            
            if (depositInstance.depositInterestScheme.fdMonthlyTransfer == true){
                
                def nextDate = depositService.getNextDate(currentRollover.startDate,currentRollover.startDate,depositInstance.maturityDate)
                currentRollover.endDate = nextDate
                
            }

            depositInstance.addToRollovers(currentRollover)
            depositInstance.currentRollover = currentRollover

        }

        //AcctNo
        //
        flash.message = "Account created.|success|alert"
        depositService.buildAcctNo(depositInstance);
        AuditLogService.insert('080', 'DEP00200','saveDeposit ' + depositInstance.id, 'deposit', null, null, null, depositInstance.id)
        redirect(action: "depositInquiry", id: depositInstance.id)
    }
/*
    def getNextDate(Date prevDueDate, Date baseDate){
        
        def calendar = new GregorianCalendar()
        def next = new GregorianCalendar()
        def nextcal = new GregorianCalendar()
        int max = 0
        int feb = 0
        calendar.setTime(prevDueDate)
        next.setTime(baseDate)
        nextcal.setTime(prevDueDate)
        nextcal.add(Calendar.MONTH, 1)
        max = nextcal.getActualMaximum(Calendar.DAY_OF_MONTH)        
        
             switch(next.get(Calendar.DAY_OF_MONTH)) {
                    case 31:
                         switch(calendar.get(Calendar.MONTH)){
                            case Calendar.JANUARY:
                                println max
                                        switch(max){
                                        case 28:
                                        calendar.add(Calendar.DAY_OF_MONTH, 28)
                                        break
                                        case 29:
                                             calendar.add(Calendar.DAY_OF_MONTH, 29)    
                                        break
                                    }
                             
                            break
                            case Calendar.FEBRUARY:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.MARCH:
                            calendar.add(Calendar.DAY_OF_MONTH, 30)
                            break
                            case Calendar.APRIL:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.MAY:
                            calendar.add(Calendar.DAY_OF_MONTH, 30)
                            break
                            case Calendar.JUNE:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.JULY:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.AUGUST:
                            calendar.add(Calendar.DAY_OF_MONTH, 30)
                            break
                            case Calendar.SEPTEMBER:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.OCTOBER:
                            calendar.add(Calendar.DAY_OF_MONTH, 30)
                            break
                            case Calendar.NOVEMBER:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.DECEMBER:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break    
                                }
                
                            break   
                    
                    case 30:
                        switch(calendar.get(Calendar.MONTH)){
                            case Calendar.JANUARY:
                                println max
                                         switch(max){
                                         case 28:
                                         calendar.add(Calendar.DAY_OF_MONTH, 29)
                                         break
                                         case 29:
                                         calendar.add(Calendar.DAY_OF_MONTH, 30)    
                                         break
                                    }
                            break
                            case Calendar.FEBRUARY:
                            calendar.add(Calendar.DAY_OF_MONTH, 30)
                            break
                            case Calendar.MARCH:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.APRIL:
                            calendar.add(Calendar.DAY_OF_MONTH, 30)
                            break
                            case Calendar.MAY:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.JUNE:
                            calendar.add(Calendar.DAY_OF_MONTH, 30)
                            break
                            case Calendar.JULY:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.AUGUST:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.SEPTEMBER:
                            calendar.add(Calendar.DAY_OF_MONTH, 30)
                            break
                            case Calendar.OCTOBER:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break
                            case Calendar.NOVEMBER:
                            calendar.add(Calendar.DAY_OF_MONTH, 30)
                            break
                            case Calendar.DECEMBER:
                            calendar.add(Calendar.DAY_OF_MONTH, 31)
                            break    
                                }
                            break
                            
                    case 29:
                       switch(calendar.get(Calendar.MONTH)){
                            case Calendar.JANUARY:
                                println max
                                         switch(max){
                                         case 28:
                                         calendar.add(Calendar.DAY_OF_MONTH, 30)
                                         break
                                         case 29:
                                         calendar.add(Calendar.DAY_OF_MONTH, 31)    
                                         break
                                    }
                            break
                            case Calendar.FEBRUARY:
                            calendar.add(Calendar.DAY_OF_MONTH, 29)
                            break
                            default:
                            calendar.add(Calendar.MONTH, 1)
                            break
                            }
                    break
                    default:
                    calendar.add(Calendar.MONTH, 1)
                    break
               
            
                }        
        return calendar.getTime()
    }
    
*/    
    def edit(Deposit depositInstance) {
        def module = Module.findByCode("DEP00300")
        if (RoleModuleService.hasPermission(module) == false) {
            redirect(action:"index")
            return
        }    
        respond depositInstance
    }

    @Transactional
    def update(Deposit depositInstance) {
        if (depositInstance == null) {
            notFound()
            return
        }
        println params
        if(depositInstance.signatories){
            depositInstance.signatories.removeAll([null])
            def _signatoryDelete= depositInstance.signatories.findAll{(it.deleted)}
            println  "Signatory" +depositInstance.signatories
            println "Signatory to be deleted "+ _signatoryDelete
            if(_signatoryDelete) {
                for (Signatory signatory : _signatoryDelete) {
                    signatory?.status = ConfigItemStatus.get(3)
                    println signatory?.status?.description
                }
            }
        }

        if (!depositInstance.validate()) {
            respond depositInstance.errors, view:'edit'
            return
        }
        
        if (depositInstance.isDirty('status')) {
            
            if (depositInstance.getPersistentValue('status').id == 1) {
                // pending account
                // limit allowed options
                if (depositInstance.status.id == 3 || depositInstance.status.id == 4 || depositInstance.status.id == 5 || depositInstance.status.id == 6 || depositInstance.status.id == 7) {
                    flash.message = 'Invalid new status for pending account|error|alert'
                    depositInstance.status = DepositStatus.get(params.origStatus.toInteger())
                    respond depositInstance.errors, view:'edit'
                    return                    
                }    
            }  
            if (depositInstance.getPersistentValue('status').id == 2) {
                // active account
                // limit allowed options
                if (depositInstance.status.id == 3 || depositInstance.status.id == 4 || depositInstance.status.id == 8) {
                    flash.message = 'Invalid new status for active account|error|alert'
                    depositInstance.status = DepositStatus.get(params.origStatus.toInteger())
                    respond depositInstance.errors, view:'edit'
                    return                    
                }    
            }    
            if (depositInstance.getPersistentValue('status').id == 3) {
                // re-activated account
                // limit allowed options
                if (depositInstance.status.id == 1 || depositInstance.status.id == 2 || depositInstance.status.id == 4 || depositInstance.status.id == 7 || depositInstance.status.id == 8) {
                    flash.message = 'Invalid new status for re-activated account|error|alert'
                    depositInstance.status = DepositStatus.get(params.origStatus.toInteger())
                    respond depositInstance.errors, view:'edit'
                    return                    
                }    
            }    
            if (depositInstance.getPersistentValue('status').id == 4) {
                // re-opened account
                // limit allowed options
                if (depositInstance.status.id == 1 || depositInstance.status.id == 2 || depositInstance.status.id == 3 || depositInstance.status.id == 7 || depositInstance.status.id == 8) {
                    flash.message = 'Invalid new status for re-opened account|error|alert'
                    depositInstance.status = DepositStatus.get(params.origStatus.toInteger())
                    respond depositInstance.errors, view:'edit'
                    return                    
                }    
            }              
            if (depositInstance.getPersistentValue('status').id == 5) {
                // dormant account
                // limit allowed options
                if (depositInstance.status.id == 1 || depositInstance.status.id == 2 || depositInstance.status.id == 4) {
                    flash.message = 'Invalid new status for Dormant account|error|alert'
                    depositInstance.status = DepositStatus.get(params.origStatus.toInteger())
                    respond depositInstance.errors, view:'edit'
                    return                    
                }    
            }
            if (depositInstance.getPersistentValue('status').id == 6) {
                // frozen account
                // limit allowed options
                if (depositInstance.status.id == 1 ) {
                    flash.message = 'Invalid new status for locked/Frozen account|error|alert'
                    depositInstance.status = DepositStatus.get(params.origStatus.toInteger())
                    respond depositInstance.errors, view:'edit'
                    return                    
                }    
            }     
            
            if (depositInstance.getPersistentValue('status').id == 5 && depositInstance.status.id == 3) {
                // transfer transaction
                def dormantTxn = Institution.findByParamCode('DEP.40080').paramValue.toInteger()
                def txn = new TxnFile(acctNo:depositInstance.acctNo, branch:depositInstance.branch, currency:depositInstance.product.currency,
                    depAcct:depositInstance, status:ConfigItemStatus.get(2), txnAmt:depositInstance.ledgerBalAmt, 
                    txnCode:TxnTemplate.get(dormantTxn).code, txnDate:depositInstance.branch.runDate, txnDescription:'Reactivate Dormant Account',
                    txnParticulars:'Transfer to Re-activated status', txnRef:depositInstance.branch.runDate.toString() + ' - Reactivate',
                    txnTimestamp:new Date().toTimestamp(), user:UserMaster.get(session.user_id), txnType:TxnTemplate.get(dormantTxn).txnType,
                    txnTemplate:TxnTemplate.get(dormantTxn))
                    txn.save(flush:true, failOnError:true)
                    
                // update ledger
                def ledger = new TxnDepositAcctLedger(acct:depositInstance, acctNo:depositInstance.acctNo, bal:depositInstance.ledgerBalAmt,
                    branch:depositInstance.branch, creditAmt:depositInstance.ledgerBalAmt, debitAmt:depositInstance.ledgerBalAmt,
                    currency:depositInstance.product.currency, status:depositInstance.status, txnDate:txn.txnDate, txnFile:txn,
                    user:UserMaster.get(session.user_id), txnRef:txn.txnRef, txnType:txn.txnType)

                ledger.save(flush:true, failOnError:true)
                    
                // update deposit
                depositInstance.statusChangeDate = depositInstance.branch.runDate
                depositInstance.save(flush:true, failOnError:true)
                    
                //create entry for glTxnBreakdown
                GlTransactionService.saveTxnBreakdown(txn.id)                
            }
            if (depositInstance.status.id == 5) {
                // transfer transaction
                def dormantTxn = Institution.findByParamCode('DEP.40080').paramValue.toInteger()
                def txn = new TxnFile(acctNo:depositInstance.acctNo, branch:depositInstance.branch, currency:depositInstance.product.currency,
                    depAcct:depositInstance, status:ConfigItemStatus.get(2), txnAmt:depositInstance.ledgerBalAmt, 
                    txnCode:TxnTemplate.get(dormantTxn).code, txnDate:depositInstance.branch.runDate, txnDescription:'transfer to Dormant Account',
                    txnParticulars:'Transfer to Dormant status', txnRef:depositInstance.branch.runDate.toString() + ' - Dormancy',
                    txnTimestamp:new Date().toTimestamp(), user:UserMaster.get(session.user_id), txnType:TxnTemplate.get(dormantTxn).txnType,
                    txnTemplate:TxnTemplate.get(dormantTxn))
                    txn.save(flush:true, failOnError:true)
                    
                // update ledger
                def ledger = new TxnDepositAcctLedger(acct:depositInstance, acctNo:depositInstance.acctNo, bal:depositInstance.ledgerBalAmt,
                    branch:depositInstance.branch, creditAmt:depositInstance.ledgerBalAmt, debitAmt:depositInstance.ledgerBalAmt,
                    currency:depositInstance.product.currency, status:depositInstance.status, txnDate:txn.txnDate, txnFile:txn,
                    user:UserMaster.get(session.user_id), txnRef:txn.txnRef, txnType:txn.txnType)

                ledger.save(flush:true, failOnError:true)
                    
                // update deposit
                depositInstance.statusChangeDate = depositInstance.branch.runDate
                depositInstance.save(flush:true, failOnError:true)
                    
                //create entry for glTxnBreakdown
                GlTransactionService.saveTxnBreakdown(txn.id)                
            }            
        }
        // change in gl link
        if (depositInstance.isDirty('glLink')) {
                def glLinkTxn = Institution.findByParamCode('GEN.10241').paramValue.toInteger()
                def txnRef = depositInstance.getPersistentValue('glLink')
                def txnParticulars = depositInstance.glLink
                def txn = new TxnFile(acctNo:depositInstance.acctNo, branch:depositInstance.branch, currency:depositInstance.product.currency,
                    depAcct:depositInstance, status:ConfigItemStatus.get(2), txnAmt:depositInstance.ledgerBalAmt, 
                    txnCode:TxnTemplate.get(glLinkTxn).code, txnDate:depositInstance.branch.runDate, txnDescription:'Deposit Account Re-Classification',
                    txnParticulars:txnParticulars.id, txnRef:txnRef.id,
                    txnTimestamp:new Date().toTimestamp(), user:UserMaster.get(session.user_id), txnType:TxnTemplate.get(glLinkTxn).txnType,
                    txnTemplate:TxnTemplate.get(glLinkTxn))
                    txn.save(flush:true, failOnError:true)
                    
                // update ledger
                def ledger = new TxnDepositAcctLedger(acct:depositInstance, acctNo:depositInstance.acctNo, bal:depositInstance.ledgerBalAmt,
                    branch:depositInstance.branch, creditAmt:depositInstance.ledgerBalAmt, debitAmt:depositInstance.ledgerBalAmt,
                    currency:depositInstance.product.currency, status:depositInstance.status, txnDate:txn.txnDate, txnFile:txn,
                    user:UserMaster.get(session.user_id), txnRef:txn.txnRef, txnType:txn.txnType)

                ledger.save(flush:true, failOnError:true)      
                GlTransactionService.saveTxnBreakdown(txn.id) 
        }
        if (depositInstance.type.id  == 3) {
            if (depositInstance.depositInterestScheme.fdMonthlyTransfer == true) {
                // check for maturity date
            } else if (depositInstance.currentRollover.endDate != depositInstance.maturityDate  ) {
                depositInstance.maturityDate = depositInstance.currentRollover.endDate
            }            
        }    
    
        depositInstance.save flush:true
        AuditLogService.insert('080', 'DEP00200','updateDeposit ' + depositInstance.id, 'deposit', null, null, null, depositInstance.id)
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Deposit.label', default: 'Deposit'), depositInstance.id])
                redirect depositInstance
            }
            '*'{ respond depositInstance, [status: OK] }
        }
        flash.message = "Deposit Account [" + depositInstance.acctNo + "] updated.|success|alert"
    }

    @Transactional
    def delete(Deposit depositInstance) {

        if (depositInstance == null) {
            notFound()
            return
        }

        depositInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Deposit.label', default: 'Deposit'), depositInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'deposit.label', default: 'Deposit'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
@grails.validation.Validateable
class inwardCheckClearingCommand{
    int count
    List<checkCommand> checks =[].withLazyDefault {new checkCommand()}
    static constraints={
        checks validator:{ val,obj,errors -> 
            if(val){
                for(int i = 0; i < val.size(); i++){
                    if(!val[i]){continue}
                    if(!val[i].validate()){
                        val[i].errors.allErrors.each {error->
                            errors.rejectValue(
                                "checks[${i}]."+error.field,
                                error.getCode(),
                                error.getArguments(),
                                error.getDefaultMessage()
                            )
                        }
                    }
                }   
            }       
        }
    }
}
@grails.validation.Validateable
class checkCommand{
    
    String acctNo
    Long chequeNo
    Double amt
    String brstn
    String trancd
    static constraints={
         //acctNo validator: { val, obj,errors -> 
         //   if(!Deposit.findByAcctNo(val)){
         //       errors.rejectValue('acctNo','Acct No Does Not Exist')
         //   }         
        //}
        chequeNo validator: { val, obj,errors -> 
            def cheque = Cheque.findByChequeNo(val)
            if(!cheque){
                errors.rejectValue('chequeNo','Cheque no. does not exist!')
            }else{
                if(cheque.status.id!=2){
                     errors.rejectValue('chequeNo','Cheque no. is used or has not been activated yet!')
                } else {
                    def stopChq = StopPaymentOrder.findByChequeAndStatus(cheque,ConfigItemStatus.read(2))
                    if (stopChq) {
                        errors.rejectValue('chequeNo','ChequeStopped')
                    }       
                }
            }     
        }
        
        amt validator: { val, obj,errors -> 
            def chequeInstance  = Cheque.findByChequeNo(obj.chequeNo)
            if(chequeInstance){
                def depositInstance = chequeInstance.chequebook.deposit
                //def chequeInstance  = Cheque.findByChequeNo(obj.chequeNo)
                if (depositInstance.status.id  > 4) {
                    errors.rejectValue('chequeNo','DepositAccountStatus')
                } else if(depositInstance.availableBalAmt< val){
                    def sweepList = depositInstance.sweeps
                    /*
                    sweepList = Sweep.createCriteria(sort: "ordinalNum", order: "asc").list{
                        and{
                            eq("fundingDeposit",depositInstance)
                            eq("status",SweepStatus.read(2))   
                        }
                    }
                    */
                    def sweepTypeThreeAmt = 0
                    for(sweep in sweepList){
                        def fundedDepositInstance  = sweep.fundedDeposit
                        if(sweep.rule.id==1){
                            if(fundedDepositInstance.availableBalAmt>=val){
                                return true
                            }
                        }
                        if(sweep.rule.id==2){
                            if(fundedDepositInstance.ledgerBalAmt>=val){
                                return true
                            }
                        }
                        if(sweep.rule.id==3){
                           if(fundedDepositInstance.availableBalAmt>=val){
                               return true
                           }else{
                               if(sweepTypeThreeAmt+fundedDepositInstance.availableBalAmt>=val){
                                   return true
                               }else{
                                   sweepTypeThreeAmt+=fundedDepositInstance.availableBalAmt
                               }
                           }
                        }
                        if(sweep.rule.id==4){
                            if(fundedDepositInstance.availableBalAmt*sweep.fundLimitPercentage>=val){
                                return true
                            }
                        }
                    }
                    errors.rejectValue('amt','Insufficient Funds on Deposit Accounts and its sweep accounts')
                }else{
                    return true
                }
            }         
        }
    }
}
@grails.validation.Validateable
class fundTransferCommand{
    Deposit fundingAcct
    Deposit destinationAcct
    TxnTemplate txnTemplate
    Double amt
    String txnRef
    String txnDescription
    static constraints={
        fundingAcct nullable:false,
            validator: { val, obj,errors -> 
                if(obj.amt>val.availableBalAmt){
                    errors.rejectValue('fundingAcct','Insufficient Funds')
                }
            }
        destinationAcct nullable:false
            validator: { obj, errors -> 
                if(obj.destinationAcct == obj.fundingAcct){
                    errors.rejectValue('fundingAcct','Duplicate account')
                } else if(obj.destinationAcct.status.id >= 5) {
                    errors.rejectValue('fundingAcct','account status error')
                } else if(obj.destinationAcct.status.id == 1) {
                    errors.rejectValue('fundingAcct','pending status error')
                }
            }        
        txnTemplate nullable:false
        amt nullable:false,
            validator:{ val,obj,errors->
                if(obj.amt<=0){
                    errors.rejectValue('amt','Amount should not be less than or equal to 0')
                }
            }
        txnDescription nullable:true
        txnRef nullable:true
    }
}

@grails.validation.Validateable
class memoDebitCreditAdjustmentCommand{
    MemoType type
    TxnTemplate txnTemplate
    //MemoTxnType txnType
    Deposit acct
    Double amt
    String txnRef
    String txnDescription
    static constraints={
        type nullable:false
        //txnType nullable:false
        acct nullable:true
        amt nullable:false
        txnDescription nullable:true
        txnRef nullable:true
    }
}
@grails.validation.Validateable
class memoDebitCreditRemittanceCommand{
    Customer customer
    MemoType type
    TxnTemplate txnTemplate
    //MemoTxnType txnType
    Deposit acct
    Double amt
    String txnRef
    String txnDescription
    static constraints={
        customer nullable:false
        type nullable:false
        //txnType nullable:false
        acct nullable:true
        amt nullable:false
        txnDescription nullable:true
        txnRef nullable:true
    }
}
@grails.validation.Validateable
class memoDebitBillsPaymentCommand{
    MemoType type
    TxnTemplate txnTemplate
    //MemoTxnType txnType
    Deposit acct
    //Deposit destinationAcct
    Double amt
    String txnRef
    String txnDescription
    static constraints={
        type nullable:false
        //txnType nullable:false
        acct nullable:false
//            ,validator: { val, obj,errors -> 
//                if(obj?.amt>val.availableBalAmt){
//                    println obj.amt +":"+val.availableBalAmt
//                    errors.rejectValue('acct','Insufficient Funds')
//                }
//            }
            
        //destinationAcct nullable:false
        amt nullable:false
        txnDescription nullable:true
        txnRef nullable:true
    }
}

@grails.validation.Validateable
class depositInitialCommand{
    DepositType type
    Product product
    Customer customer
    DepositInterestScheme  depositInterestScheme
    FixedDepositTermScheme fixedDepositTermScheme
    FixedDepositPreTermScheme fixedDepositPreTermScheme
    static constraints={
        type nullable:false
        product nullable:false
        customer nullable:false
        depositInterestScheme nullable:false
        fixedDepositTermScheme nullable:true, validator:{val,obj,errors->
            if(obj?.type?.id==3){
                if(!val){
                    errors.rejectValue('fixedDepositTermScheme',"Cannot Be Null")
                }
            }
        }
        fixedDepositPreTermScheme nullable:true,validator:{val,obj,errors->
            if(obj?.type?.id==3){
                if(!val){
                    errors.rejectValue('fixedDepositPreTermScheme',"Cannot Be Null")
                }
            }
        }
    }
}
