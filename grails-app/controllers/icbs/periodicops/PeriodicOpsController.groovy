package icbs.periodicops
import grails.converters.JSON
import org.codehaus.groovy.grails.web.json.JSONObject
import groovy.time.TimeCategory
import icbs.admin.UserMaster
import java.nio.file.*
import icbs.admin.Branch
import icbs.admin.Holiday
import icbs.admin.UserMaster
import icbs.admin.CheckDepositClearingType
import icbs.admin.Institution
import icbs.admin.BranchHoliday
import icbs.security.UserSession
import icbs.lov.BranchRunStatus
import icbs.tellering.TxnBreakdown
import icbs.tellering.TxnTellerBalance
import icbs.gl.GlBatchHdr
import icbs.gl.GlBatch
import icbs.gl.GlDailyFile
import icbs.gl.GlMonthlyBalance
import icbs.gl.GlAccount
import icbs.deposit.Deposit
import icbs.periodicops.PeriodicOpsLog
import icbs.periodicops.DailyLoanRecoveries
import icbs.lov.ConfigItemStatus
import icbs.lov.DepositStatus
import icbs.lov.DepositType
import icbs.loans.Loan
import icbs.lov.LoanAcctStatus
import icbs.lov.GlBatchHdrStatus
import icbs.tellering.TxnTellerBalance
import icbs.tellering.TxnPassbookLine
import icbs.cif.Customer
import grails.transaction.Transactional
import org.apache.commons.io.FileUtils
import org.apache.tools.zip.ZipEntry
import java.text.SimpleDateFormat
import java.util.zip.ZipOutputStream
import java.util.Calendar
import icbs.admin.UserMessage
import static grails.async.Promises.*
import groovy.sql.Sql


class PeriodicOpsController {
    def periodicOpsService
    def loanPeriodicOpsService
    def IsTelleringActiveService
    def depositPeriodicOpsService
    def jasperService
    def AuditLogService
    def GlTransactionService
    def UserMasterService
    def sessionFactory
    def dataSource
    
    def index() { 
        def runDate = Branch.read(1).runDate
        
        //render(view:"index",model:[startOfDayDate:new Date()])
        render(view:"index",model:[startOfDayDate:runDate])
    }
    
    def lockSystem(){
        def lockMe = Institution.findByParamCode('GEN.10250')
        lockMe.paramValue = 'TRUE'
        lockMe.save(flush:true)
        flash.message = 'System Lock completed |success|alert'
        def runDate = Branch.read(1).runDate
        render(view:"index",model:[startOfDayDate:runDate])
        return
    }
    
    def unlockSystem(){
         def lockMe = Institution.findByParamCode('GEN.10250')
        lockMe.paramValue = 'FALSE'
        lockMe.save(flush:true)
        flash.message = 'System unlock completed |success|alert'
        def runDate = Branch.read(1).runDate
        render(view:"index",model:[startOfDayDate:runDate])
        return       
    }
    
    private def zipFiles(String fileName,String inputDir) {
        fileName = fileName+".zip"
        ByteArrayOutputStream baos = new ByteArrayOutputStream()
        ZipOutputStream zipFile = new ZipOutputStream(baos)
        new File(inputDir).eachFile() { file ->
            zipFile.putNextEntry(new ZipEntry(file.name))
            file.withInputStream { i ->
                zipFile << i
            }
            zipFile.closeEntry()
        }
        zipFile.finish()
        new File(inputDir).eachFile() { file ->
            file.delete()
        }
        
        OutputStream outputStream = new FileOutputStream (inputDir+"/"+fileName)
        baos.writeTo(outputStream)
        println 'finished zip....'
    }
    def getStartOfDayReport(){
        Date startOfDayDate = Branch.read(1).runDate
        def rootDir = request.getSession().getServletContext().getRealPath("/")+"reports_repository/startOfDay/"+new SimpleDateFormat("yyyy-MM-dd").format(startOfDayDate)
        Path path = Paths.get(rootDir+"/reports.zip");
        byte[] data = Files.readAllBytes(path);
        response.setHeader("Content-disposition", "filename=\"reports.zip\"")
        response.contentType = "application/zip"
        response.outputStream << data
        response.outputStream.flush()   
  
    }
    private def createStartOfDayReport(Date date){
        def rootDir = request.getSession().getServletContext().getRealPath("/")+"reports_repository/startOfDay/"+new SimpleDateFormat("yyyy-MM-dd").format(date)
        //params with underscore are required/
        //This is one report
        params._name = "FD_TD_Rollover_SOD_NO_LOGO" //Report Name
        params._format ="PDF"//Save as TYPE Format (Required CAPS)
        params._file = "FD_TD_Rollover_SOD_NO_LOGO.jrxml" //eto ung pangalang ng jasper file
        //parameters that will be passed to the jasper report, add as needed
        //params.type =  1
        //params.status = 2        
        def reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
        def file = jasperService.generateReport(reportDef).toByteArray()
        FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file)
        
        //params with underscore are required
            
        params._name = "Dormant_30_Days_before_SOD_NOLOGO"
        params._format = "PDF"
        params._file = "Dormant_30_Days_before_SOD_NOLOGO.jrxml"
        //params.date = date
        reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
        file = jasperService.generateReport(reportDef).toByteArray()
        FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file)   
        
        params._name = "FD_TD_7Days_before_Maturity_Date_SOD_NOLOGO"
        params._format = "PDF"
        params._file = "FD_TD_7Days_before_Maturity_Date_SOD_NOLOGO.jrxml"
        //params.date = date
        reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
        file = jasperService.generateReport(reportDef).toByteArray()
        FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file) 
        
        params._name = "Loans_Due_Report_SOD_NOLOGO"
        params._format = "PDF"
        params._file = "Loans_Due_Report_SOD_NOLOGO.jrxml"
        //params.date = date
        reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
        file = jasperService.generateReport(reportDef).toByteArray()
        FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file) 
        
        params._name = "Deposit_Listing_SOD_NOLOGO"
        params._format = "PDF"
        params._file = "Deposit_Listing_SOD_NOLOGO.jrxml"
        //params.date = date
        reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
        file = jasperService.generateReport(reportDef).toByteArray()
        FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file) 
        
        params._name = "Loan_Listing_SOD_NOLOGO"
        params._format = "PDF"
        params._file = "Loan_Listing_SOD_NOLOGO.jrxml"
        //params.date = date
        reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
        file = jasperService.generateReport(reportDef).toByteArray()
        FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file) 
        
        params._name = "CASA_Listing_SOD_NOLOGO"
        params._format = "PDF"
        params._file = "CASA_Listing_SOD_NOLOGO.jrxml"
        //params.date = date
        reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
        file = jasperService.generateReport(reportDef).toByteArray()
        FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file)
        
        params._name = "FD_TD_Listing_SOD_NOLOGO"
        params._format = "PDF"
        params._file = "FD_TD_Listing_SOD_NOLOGO.jrxml"
        //params.date = date
        reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
        file = jasperService.generateReport(reportDef).toByteArray()
        FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file)
        
        //do not edit beyond this line
        //Zip all files in root directory
        zipFiles("reports",rootDir);
    }    
    def getEndOfDayReport(){
         Date endOfDayDate = Branch.read(1).runDate.minus(1)
         /*
        def rootDir = request.getSession().getServletContext().getRealPath("/")+"reports_repository/endOfDay/"+new SimpleDateFormat("yyyy-MM-dd").format(endOfDayDate)
        Path path = Paths.get(rootDir+"/reports.zip");
        println path
        byte[] data = Files.readAllBytes(path);
        response.setHeader("Content-disposition", "filename=\"reports.zip\"")
        response.contentType = "application/zip"
        response.outputStream << data
        response.outputStream.flush()
        */
       render(view:"index",model:[startOfDayDate:endOfDayDate])
    }
    
    def downloadEodReport() {
           Date endOfDayDate = Branch.read(1).runDate.minus(1)
           
        def rootDir = request.getSession().getServletContext().getRealPath("/")+"reports_repository/endOfDay/"+new SimpleDateFormat("yyyy-MM-dd").format(endOfDayDate)
        Path path = Paths.get(rootDir+"/reports.zip");
        println path
        byte[] data = Files.readAllBytes(path);
        response.setHeader("Content-disposition", "filename=\"reports.zip\"")
        response.contentType = "application/zip"
        response.outputStream << data
        response.outputStream.flush()       
    }
    def eodReport(){
        println 'EOD REPORTS ++++++'
        def currentDate = Branch.get(1).runDate.minus(1)
        println currentDate
        this.createEndOfDayReport(currentDate, 1)
        this.downloadEodReport()
        println 'Finshed reports......'
        render(view:"index",model:[startOfDayDate:currentDate])
    }
    
    def eomReport(){
        println 'EOM REPORTS ++++++'
        def currentDate = Branch.get(1).runDate.minus(1)
        println currentDate
        this.createEndOfDayReport(currentDate, 2)
        this.downloadEodReport()
        println 'Finshed reports......'
        render(view:"index",model:[startOfDayDate:currentDate])        
    }
    private def createEndOfDayReport(Date date, Integer pMode){
        def rootDir = request.getSession().getServletContext().getRealPath("/")+"reports_repository/endOfDay/"+new SimpleDateFormat("yyyy-MM-dd").format(date)
        def reportDef
        def file
        
        if (pMode >= 1) {
            params._name = "Cash_to_Vault_EOD_NOLOGO"
            params._format = "PDF"
            params._file = "Cash_to_Vault_EOD_NOLOGO.jasper"
            reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            file = jasperService.generateReport(reportDef).toByteArray()
            FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file) 
            
            params._name = "Transaction_cash_from_Vault_EOD_NOLOGO"
            params._format = "PDF"
            params._file = "Transaction_cash_from_Vault_EOD_NOLOGO.jrxml"
            reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            file = jasperService.generateReport(reportDef).toByteArray()
            FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file) 
            
            params._name = "Transaction_Cash_Deposit_EOD_NOLOGO"
            params._format = "PDF"
            params._file = "Transaction_Cash_Deposit_EOD_NOLOGO.jrxml"
            reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            file = jasperService.generateReport(reportDef).toByteArray()
            FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file) 
          
            params._name = "Transaction_Check_Deposit_EOD_NOLOGO"
            params._format = "PDF"
            params._file = "Transaction_Check_Deposit_EOD_NOLOGO.jrxml"
            reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            file = jasperService.generateReport(reportDef).toByteArray()
            FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file) 
            params._name = "Transaction_Deposit_Memo_EOD_NOLOGO"
            params._format = "PDF"
            params._file = "Transaction_Deposit_Memo_EOD_NOLOGO.jrxml"
            reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            file = jasperService.generateReport(reportDef).toByteArray()
            FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file) 
           
            params._name = "Transaction_Check_Encashment_EOD_NOLOGO"
            params._format = "PDF"
            params._file = "Transaction_Check_Encashment_EOD_NOLOGO.jrxml"
            reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            file = jasperService.generateReport(reportDef).toByteArray()
            FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file) 
           
            params._name = "Transaction_Checks_to_COCI_EOD_NOLOGO"
            params._format = "PDF"
            params._file = "Transaction_Checks_to_COCI_EOD_NOLOGO.jrxml"
            reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            file = jasperService.generateReport(reportDef).toByteArray()
            FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file) 
          
            params._name = "Transaction_Cash_Withdrawal_EOD_NOLOGO"
            params._format = "PDF"
            params._file = "Transaction_Cash_Withdrawal_EOD_NOLOGO.jrxml"
            reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            file = jasperService.generateReport(reportDef).toByteArray()
            FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file) 
 
            params._name = "Transaction_cash_payment_EOD_NOLOGO"
            params._format = "PDF"
            params._file = "Transaction_cash_payment_EOD_NOLOGO.jrxml"
            reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            file = jasperService.generateReport(reportDef).toByteArray()
            FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file) 
            
            params._name = "Transaction_Bills_Payment_EOD_NOLOGO"
            params._format = "PDF"
            params._file = "Transaction_Bills_Payment_EOD_NOLOGO.jrxml"
            reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            file = jasperService.generateReport(reportDef).toByteArray()
            FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file) 
       
            params._name = "Transaction_Bills_Payment_EOD_NOLOGO"
            params._format = "PDF"
            params._file = "Transaction_Bills_Payment_EOD_NOLOGO.jrxml"
            reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            file = jasperService.generateReport(reportDef).toByteArray()
            FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file) 
             
            params._name = "Check_deposit_for_the_Day_EOD_NOLOGO"
            params._format = "PDF"
            params._file = "Check_deposit_for_the_Day_EOD_NOLOGO.jrxml"
            reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            file = jasperService.generateReport(reportDef).toByteArray()
            FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file)  
          
            params._name = "Transaction_Fixed_Deposit_PreTermination_EOD_NOLOGO"
            params._format = "PDF"
            params._file = "Transaction_Fixed_Deposit_PreTermination_EOD_NOLOGO.jrxml"
            reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            file = jasperService.generateReport(reportDef).toByteArray()
            FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file) 
             
            params._name = "Fixed_Deposit_Interest_Withdrawal_EOD_NOLOGO"
            params._format = "PDF"
            params._file = "Fixed_Deposit_Interest_Withdrawal_EOD_NOLOGO.jrxml"
            reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            file = jasperService.generateReport(reportDef).toByteArray()
            FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file) 
            
            params._name = "Summary_of_Account_By_GLCODE_Deposit"
            params._format = "PDF"
            params._file = "Summary_of_Account_By_GLCODE_Deposit.jrxml"
            reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            file = jasperService.generateReport(reportDef).toByteArray()
            FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file) 
            
            params._name = "Summary_of_Account_by_GLCODE_Loan"
            params._format = "PDF"
            params._file = "Summary_of_Account_by_GLCODE_Loan.jrxml"
            reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            file = jasperService.generateReport(reportDef).toByteArray()
            FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file) 
           
            params._name = "Daily_Transaction_Listing_Loan_Account_EOD_NOLOGO"
            params._format = "PDF"
            params._file = "Daily_Transaction_Listing_Loan_Account_EOD_NOLOGO.jrxml"
            reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            file = jasperService.generateReport(reportDef).toByteArray()
            FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file) 
           
            /*
            params._name = "Daily_Transaction_Summary_Loan_Accounts_EOD_NOLOGO"
            params._format = "PDF"
            params._file = "Daily_Transaction_Summary_Loan_Accounts_EOD_NOLOGO.jrxml"
            reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            file = jasperService.generateReport(reportDef).toByteArray()
            FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file)
            */
           
            params._name = "Loan_Reclass_EOD_NOLOGO"
            params._format = "PDF"
            params._file = "Loan_Reclass_EOD_NOLOGO.jrxml"
            reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            file = jasperService.generateReport(reportDef).toByteArray()
            FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file)
            
            params._name = "Full_Trial_Balance_EOD_NOLOGO"
            params._format = "PDF"
            params._file = "Full_Trial_Balance_EOD_NOLOGO.jrxml"
            reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            file = jasperService.generateReport(reportDef).toByteArray()
            FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file)
            
            params._name = "GL_Batch_Report_EOD_NOLOGO"
            params._format = "PDF"
            params._file = "GL_Batch_Report_EOD_NOLOGO.jrxml"
            reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            file = jasperService.generateReport(reportDef).toByteArray()
            FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file)
            
            params._name = "Summary_of_GL_Entries_EOD_NOLOGO"
            params._format = "PDF"
            params._file = "Summary_of_GL_Entries_EOD_NOLOGO.jrxml"
            reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            file = jasperService.generateReport(reportDef).toByteArray()
            FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file)
            
            params._name = "DAILY_TRANSACTION_LISTING_EOD"
            params._format = "PDF"
            params._file = "DAILY_TRANSACTION_LISTING_EOD.jrxml"
            reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            file = jasperService.generateReport(reportDef).toByteArray()
            FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file)
            
            println 'completed printing....'
            // end of month reports
            if (pMode >= 2) {
            
            }
        
            // end of year reports
            if (pMode == 3) {
                
            }    
        }
        
 
        
        //do not edit beyond this line
        //Zip all files in root directory
        
        zipFiles("reports",rootDir);
    }
    
    // no longer used
    def getEndOfMonthReport(Date date){
        def rootDir = request.getSession().getServletContext().getRealPath("/")+"reports_repository/endOfMonth/"+new SimpleDateFormat("yyyy-MM-dd").format(date)
        Path path = Paths.get(rootDir+"/reports.zip");
        byte[] data = Files.readAllBytes(path);
        response.setHeader("Content-disposition", "filename=\"reports.zip\"")
        response.contentType = "application/zip"
        response.outputStream << data
        response.outputStream.flush()   
    }    
    private def createEndOfMonthReport(){
        def rootDir = request.getSession().getServletContext().getRealPath("/")+"reports_repository/endOfMonth/"+new SimpleDateFormat("yyyy-MM-dd").format(new Date())
        //params with underscore are required/
        //This is one report just cop
        params._name = "ListOfBranches"
        params._format ="PDF"//required caps
        params._file ="Sample-1.jasper"  //eto ung pangalang ng jasper file
        //parameters that will be passed to the jasper report, add as needed
        params.type =  1
        params.status = 2
        
        def reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
        def file = jasperService.generateReport(reportDef).toByteArray()
        FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file)
        //end of one report (add as needed copy paste lang to just change ung params with underscore_)
        
        //do not edit beyond this line
        //Zip all files in root directory
        zipFiles("reports",rootDir);
    }
    def getEndOfYearReport(){
        def rootDir = request.getSession().getServletContext().getRealPath("/")+"reports_repository/endOfYear/"+new SimpleDateFormat("yyyy-MM-dd").format(new Date())
        Path path = Paths.get(rootDir+"/reports.zip");
        byte[] data = Files.readAllBytes(path);
        response.setHeader("Content-disposition", "filename=\"reports.zip\"")
        response.contentType = "application/zip"
        response.outputStream << data
        response.outputStream.flush()   
  
    }
    // no longer used
    private def createEndOfYearReport(){
        def rootDir = request.getSession().getServletContext().getRealPath("/")+"reports_repository/endOfYear/"+new SimpleDateFormat("yyyy-MM-dd").format(new Date())
        //params with underscore are required/
        //This is one report
        params._name = "ListOfBranches"
        params._format ="PDF"//required caps
        params._file ="Sample-1.jasper" //eto ung pangalang ng jasper file
        //parameters that will be passed to the jasper report, add as needed
        params.type =  1
        params.status = 2
        
        def reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
        def file = jasperService.generateReport(reportDef).toByteArray()
        FileUtils.writeByteArrayToFile(new File(rootDir+"/"+params._name+"."+params._format.toLowerCase()),file)
        //end of one report (add as needed copy paste lang to just change ung params with underscore_)
          
        
        //do not edit beyond this line
        //Zip all files in root directory
        zipFiles("reports",rootDir);
    }
    private JSONObject setProgressSession(progress,message,flag){
        session.progress= progress
        session.message = message
        session.flag = flag
        def jsonObject =new JSONObject();
        jsonObject = jsonObject.put('progress',session.progress)
        jsonObject = jsonObject.put('message',session.message)
        jsonObject = jsonObject.put('flag',session.flag)
        return jsonObject
    }
    def startOfDayProgressAjax(){
        def jsonObject =new JSONObject();
        println session.progress
        jsonObject = jsonObject.put('progress',session.progress)
        jsonObject = jsonObject.put('message',session.message)
        jsonObject = jsonObject.put('flag',session.flag)
        render jsonObject as JSON
    }
    @Transactional
    def startOfDay(){
        //Date startOfDayDate = (new Date()).clearTime()
        render(setProgressSession("0","start","start"))
        
        def activeUsers = UserSession.findAllByLogout(null)
        Integer numLogin = 0
        for (userLogin in activeUsers){
            numLogin++
        }
        if (numLogin > 1) {
            setProgressSession("0","ERROR: users still logged cannot proceed","error") 
            return            
        }
        
        def bList = Branch.list()
        Boolean openBr = true
        for (b in bList){
            if (b.branchRunStatusId == 1){
                openBr = false
            }
        }
        
        if (!openBr){
            println 'ERROR: Branches already open'
            setProgressSession("0","ERROR: Branches already open","error") 
            return
        }
        
        
        Date startOfDayDate = Branch.read(1).runDate
                // new checking for EOM
        Calendar c = Calendar.getInstance();
        c.setTime(startOfDayDate);
        if (c.get(Calendar.DATE) == c.getActualMaximum(Calendar.DATE) && startOfDayDate.format('MM') == '12') {
            // add condition to protect against double 12/31 SOD
            // check institution parameters
            def eoyCompleted = Institution.findByParamCode('GEN.10247').paramValue
            if (eoyCompleted == 'FALSE') {
                def inst = Institution.findByParamCode('GEN.10247')
                inst.paramValue = 'TRUE'
                inst.save(flush:true)
                def bSoyList = Branch.list()
                for (bSoy in bSoyList) {
                    bSoy.runDate = startOfDayDate.plus(1)
                    bSoy.save(flush:true)
                }
                startOfDayDate = startOfDayDate.plus(1)                
            }
        }
        // update periodic ops log
        def pLog = new PeriodicOpsLog()
        pLog.periodicOpsProcess = PeriodicOpsProcess.read(1)
        pLog.processUID = 'SOD-' + startOfDayDate.toString()
        pLog.runDate = startOfDayDate
        pLog.cpuDate = new Date()
        pLog.startTime = new Date().toString()
        pLog.user = UserMaster.get(session.user_id)
        
        setProgressSession("99","report something","msg") 
        
        // for start of year
        def firstDay = new SimpleDateFormat("yyyy-MM-dd").format(startOfDayDate)
        String date = startOfDayDate.format('yyyy')+'-01-01'
        Date first_day_of_year = Date.parse( 'yyyy-MM-dd', date )
        def StartOfYearDay = new SimpleDateFormat("yyyy-MM-dd").format(first_day_of_year)
        if(firstDay.equals(StartOfYearDay)){           
            GlTransactionService.startOfYear( startOfDayDate, UserMaster.get(session.user_id) )
        }        
        
        // SOD reset for GL accounts daily balances
        GlAccount.executeUpdate("update GlAccount set debit_today=0.00, credit_today = 0.00 where financial_year = ?", [startOfDayDate.format('yyyy').toInteger()])
        
        //  placeholder for DepEd payment processing
        if (Institution.findByParamCode('LNS.50071').paramValue == 'TRUE') {
            String fileContents = new File('/deped.txt').getText('UTF-8')
            if (fileContents) {
            }            
        }
        // compute check cleaing date
        def ch = CheckDepositClearingType.list()
        def clDate = startOfDayDate
        def cltoday
        Integer i
        Integer clDays = 0
        
        for (chDay in ch) {
            clDays = 0
            clDate = startOfDayDate
            for (i = 1; i <= chDay.clearingDays; i++) {
                def nonClearingDay = Holiday.findByHolidayDateAndInstitutionWideHolidayAndConfigItemStatus(clDate,true,ConfigItemStatus.get(2))
                if (nonClearingDay) {
                    println 'clearing holiday >>>' + clDate.toString()
                    i--
                } else {
                    // check for weekends
                    cltoday = clDate.toString()
                    Calendar cl = new GregorianCalendar(Integer.parseInt(cltoday.substring(0,4)), Integer.parseInt(cltoday.substring(5,7)),Integer.parseInt(cltoday.substring(8,10)) );
                    
                    def clDay = clDate.toString()
                    println 'clearing - today is  >>>' + clDate.toString()
                    println 'clday substr >>> ' + Date.parse("yyyy-MM-dd", cltoday.substring(0,10))[Calendar.DAY_OF_WEEK]
                    if ((Date.parse("yyyy-MM-dd", cltoday.substring(0,10))[Calendar.DAY_OF_WEEK]==1) || 
                        (Date.parse("yyyy-MM-dd", cltoday.substring(0,10))[Calendar.DAY_OF_WEEK]==7)){
                        i--
                        println 'clearing weekend >>>' + clDate.toString()
                    }                
                } 
                clDays++   
                clDate = clDate.plus(1)
                println 'clearing date >>>' + clDate.toString()
            }
            println clDays
            println startOfDayDate.plus(clDays)
            chDay.clearingDate = startOfDayDate.plus(clDays)
            chDay.save(flush:true)
        }
        
        // Process only for working days
        def holidays = Holiday.findAllByHolidayDateAndConfigItemStatus(startOfDayDate,ConfigItemStatus.get(2))
        Boolean bHoliday 
        Boolean bankwideHoliday
        if (holidays){
           bankwideHoliday = false 
           for (h in holidays) {
              if (h.institutionWideHoliday == true) {
                bankwideHoliday = true
              }
           }
           if (bankwideHoliday == true){
               // do something for holiday
               println 'Holiday!!!!!'        
               def bl = Branch.list()
               for (branch in bl){
                  // compute penalties for loans 
                  loanPeriodicOpsService.updatePenalties(startOfDayDate, branch)
                  loanPeriodicOpsService.updateInterest(startOfDayDate, branch)
                  branch.branchRunStatus = BranchRunStatus.get(1)
                  branch.save(flush:true,failOnError:true) 
               }
           } else {
               // first do clearing of checks
               depositPeriodicOpsService.clearingChecks(startOfDayDate)
               // release holdss
               //depositPeriodicOpsService.holdsReleaseProcessing(startOfDayDate)
               
               def bhList = Branch.list(sort: "id", order: "asc")
               for (bh in bhList){
                   
                   bHoliday = BranchHoliday.findAllByBranchAndHoliday(bh,holidays)
                   //bHoliday = false
                   println 'holiday branch >>>>>>>>'
                   println bHoliday
                   
                   if (!bHoliday){
                    // release holds
                        depositPeriodicOpsService.holdsReleaseProcessing(startOfDayDate, bh, UserMaster.get(session.user_id))
                       
                        depositPeriodicOpsService.startOfDay(startOfDayDate,bh,UserMaster.get(session.user_id))
                        setProgressSession("25","Processing Loans Start Of Day","processing")
                        //currentDate = new Date().parse("MM/dd/yyyy", "08/10/2015")  // for debugging
                        loanPeriodicOpsService.startOfDay(startOfDayDate,bh, UserMaster.get(session.user_id))
                        //println 'branch>>'+branch.isTelleringActive                                                
                   } else {
                        // compute penalties for loans 
                        loanPeriodicOpsService.updatePenalties(startOfDayDate, bh)  
                        loanPeriodicOpsService.updateInterest(startOfDayDate, bh)
                   } 
               }
               // update run status and tellering
               def brs = Branch.list()
               for (br in brs){
                  bHoliday = BranchHoliday.findAllByBranchAndHoliday(br,holidays)
                  if (bHoliday) {
                      br.isTelleringActive = false
                  } else {
                      br.isTelleringActive = true
                  }                     
                  br.branchRunStatus = BranchRunStatus.get(1)
                  br.save(flush:true,failOnError:true) 
               }
           }
        } else {
            // first do clearing of checks
            depositPeriodicOpsService.clearingChecks(startOfDayDate)
            
            Boolean notWeekend = false
            String  today
            Date weekDate
            def bl = Branch.list(sort: "id", order: "asc")
            for (branch in bl){
                today = branch.runDate.toString()
                Calendar calendar = new GregorianCalendar(Integer.parseInt(today.substring(0,4)), Integer.parseInt(today.substring(5,7)),Integer.parseInt(today.substring(8,10)) );
                //weekDate = Date.parse("yyyy-MM-dd",today.substring(0,10))
                //println calendar.get(Calendar.DAY_OF_WEEK)
                //Date.parse("yyyy-MM-dd", "2015-12-13")[Calendar.DAY_OF_WEEK]
                //Date.parse("yyyy-MM-dd", today2)[Calendar.DAY_OF_WEEK]
                //println branch.name + ' date string ' + today + ' day of week' + Date.parse("yyyy-MM-dd", today.substring(0,10))[Calendar.DAY_OF_WEEK]
                //check for weekend
                if (branch.openOnSun && (Date.parse("yyyy-MM-dd", today.substring(0,10))[Calendar.DAY_OF_WEEK]==1)){
                    println 'sunday'
                    notWeekend = true
                }
                if (branch.openOnMon && (Date.parse("yyyy-MM-dd", today.substring(0,10))[Calendar.DAY_OF_WEEK]==2)){
                    println 'monday'
                    notWeekend = true
                }                
                if (branch.openOnTue && (Date.parse("yyyy-MM-dd", today.substring(0,10))[Calendar.DAY_OF_WEEK]==3)){
                    println 'tuesday'
                    notWeekend = true
                }                
                if (branch.openOnWed && (Date.parse("yyyy-MM-dd", today.substring(0,10))[Calendar.DAY_OF_WEEK]==4)){
                    println 'wed'
                    notWeekend = true
                }               
                if (branch.openOnThu && (Date.parse("yyyy-MM-dd", today.substring(0,10))[Calendar.DAY_OF_WEEK]==5)){
                    println 'thu'
                    notWeekend = true
                }               
                if (branch.openOnFri && (Date.parse("yyyy-MM-dd", today.substring(0,10))[Calendar.DAY_OF_WEEK]==6)){
                    println 'friday'
                    notWeekend = true
                }                
                if (branch.openOnSat && (Date.parse("yyyy-MM-dd", today.substring(0,10))[Calendar.DAY_OF_WEEK]==7)){
                    println 'sat'
                    notWeekend = true
                }               
                if (notWeekend){
                    //println branch.name
                    setProgressSession("25","Processing Deposit Start Of Day","processing")
                    depositPeriodicOpsService.startOfDay(startOfDayDate,branch,UserMaster.get(session.user_id))
                    
                    // release holds
                    depositPeriodicOpsService.holdsReleaseProcessing(startOfDayDate, branch, UserMaster.get(session.user_id))
            
                    setProgressSession("75","Processing Loans Start Of Day","processing")
                    //currentDate = new Date().parse("MM/dd/yyyy", "08/10/2015")  // for debugging
                    //println 'branch>>'+branch.isTelleringActive
                    //IsTelleringActiveService.enableTellering()
                    
                    //----- process loan recoveries
                    loanPeriodicOpsService.startOfDay(startOfDayDate,branch, UserMaster.get(session.user_id))
                    //----------------------------
                    branch.isTelleringActive = true
                } else {
                    // for weekend do this
                    loanPeriodicOpsService.updatePenalties(startOfDayDate, branch)  
                    loanPeriodicOpsService.updateInterest(startOfDayDate, branch)  
                }
                def brUpdate = Branch.get(branch.id)
                
                if (brUpdate) {
                   brUpdate.isTelleringActive = branch.isTelleringActive 
                   brUpdate.branchRunStatus = BranchRunStatus.get(1)
                   brUpdate.save(flush:true,failOnError:true)
                }
                //branch.branchRunStatus = BranchRunStatus.get(1)
                //branch.save(flush:true,failOnError:true)
            }
            //def branch = UserMaster.get(session.user_id).branch
            //branch.runDate = startOfDayDate
            //branch.save(flush:true,validate:false)
            //IsTelleringActiveService.disableTellering()
            //render(setProgressSession("0","Processing Deposit Start Of Day","start")) 
        }
        
        //auditLogService.insert('150', 'ADM00700', 'periodicops - Start of Day ' + startOfDayDate.toString())
        setProgressSession("98","Printing of reports","msg")
        this.createStartOfDayReport(startOfDayDate)
        setProgressSession("100","Complete","end")
        
        pLog.endTime = new Date().toString()
        pLog.status = 1
        pLog.save(flush:true)
        
    }
    def endOfDayProgressAjax(){
        def jsonObject =new JSONObject();
        println session.progress
        jsonObject = jsonObject.put('progress',session.progress)
        jsonObject = jsonObject.put('message',session.message)
        jsonObject = jsonObject.put('flag',session.flag)
        render jsonObject as JSON
    }
    @Transactional
    def endOfDay(){
        render(setProgressSession("0","start","start"))
        def currentDate = Branch.get(1).runDate
        
        def activeUsers = UserSession.findAllByLogout(null)    
        Integer numLogin = 0
        for (userLogin in activeUsers){
            numLogin++
        }
        if (numLogin > 1) {
            setProgressSession("0","ERROR: users still logged cannot proceed","error")
           
            for(usermessage in activeUsers){
                //================= SEND MESSAGE TO ALL LOGGED USERS
                    if(session.user_id == usermessage.userMaster.id){
                        println('.............')
                    }else{
                        def crtBulkMessageInstance = new UserMessage()
                        crtBulkMessageInstance.subject = "Periodic Operation Warning"
                        crtBulkMessageInstance.sender = UserMaster.get(session.user_id)
                        crtBulkMessageInstance.recipient = UserMaster.get(usermessage.userMaster.id)
                        crtBulkMessageInstance.configItemStatus = ConfigItemStatus.get(2)
                        crtBulkMessageInstance.isRead = false
                        crtBulkMessageInstance.sentAt = new Date().format('yyyy-MM-dd HH:mm')
                        crtBulkMessageInstance.body = "Periodic Ops Operation is about to start. Please log out immediately or contact your system administrator."
                        println("Notification Message sent to username: "+usermessage.userMaster.name+"[ID: "+usermessage.userMaster.id+"]")
                        crtBulkMessageInstance.save flush:true                           
                    }

                //==================================================                
            }
            
            return            
        }     
        
        def openBr = Branch.list(sort: "id", order: "asc")
        Boolean closedBr = true
        for (oBr in openBr){
            if (oBr.branchRunStatusId == 2){
                closedBr = false
            }
        }
        if (!closedBr){
            println 'already closed'
            setProgressSession("0","ERROR: branches already closed","error")
            return    
        }
        // check tellers for unbalanced
        def uList = UserMaster.list()
        Boolean allBalanced = true
        for (ul in uList){
            if (!ul.isTellerBalanced){
                allBalanced = false
            }
        }
        if (!allBalanced) {
           println 'teller not balanced'
           setProgressSession("0","ERROR: Tellers not yet balanced","error")
           return
        }
        // disallow overnight cash
        // create cash balance forward
        def oCash = TxnTellerBalance.createCriteria().list{
            and {
                eq("txnDate",currentDate)
            }
        }
        for (oc in oCash) {
            if (oc.cashIn != oc.cashOut) {
                println 'teller cash not returned to vault'
                setProgressSession("0","ERROR: Tellers cash not returned to vault","error")
                return
            }
        }
        
        // update log
        def pLog = new PeriodicOpsLog()
        pLog.periodicOpsProcess = PeriodicOpsProcess.read(2)
        pLog.processUID = 'EOD-' + currentDate.toString()
        pLog.runDate = currentDate
        pLog.cpuDate = new Date()
        pLog.startTime = new Date().toString()
        pLog.user = UserMaster.get(session.user_id)
       
        //def branch = UserMaster.get(session.user_id).branch
        //Date currentDate = (new Date()).clearTime()
        // execute last txn update
        setProgressSession("0","ERROR:set last txn date","error")
        depositPeriodicOpsService.updateLastTxnDate(currentDate)
        
        
        //IsTelleringActiveService.enableTellering()
        setProgressSession("25","Processing End Of Day Deposits And Loans ","processing")
        if (allBalanced && closedBr){
            def brList = Branch.list(sort: "id", order: "asc")
            for (branch in brList){
                IsTelleringActiveService.disableTellering()
                this.newDailyBalanceUpdate(currentDate, branch)
                println 'depositPeriodicOpsService.endOfDay'
                depositPeriodicOpsService.endOfDay(currentDate,branch,UserMaster.get(session.user_id))
                println 'loanPeriodicOpsService.endOfDay'
                loanPeriodicOpsService.endOfDay(currentDate, branch, UserMaster.get(session.user_id))
                
                // transfer to dormant
                depositPeriodicOpsService.TransferToDormant(currentDate, branch, UserMaster.get(session.user_id),'daily')
            }
        }
        
        setProgressSession("75","Processing End Of Day Deposits And Loans ","processing")
        
        def today = new SimpleDateFormat("yyyy-MM-dd").format(currentDate)
        def last_day_of_month = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(new java.util.Date().format('yyyy') + "-" + (new Integer (new SimpleDateFormat("MM").format(currentDate))+1) + "-01")-1);
        String date = currentDate.format('yyyy')+'-12-31'
        Date last_day_of_year = Date.parse( 'yyyy-MM-dd', date )
        Integer repMode = 1
        
        // new checking for EOM
        Calendar c = Calendar.getInstance();
        c.setTime(currentDate);
        //if(today.equals(last_day_of_month)){
        if (c.get(Calendar.DATE) == c.getActualMaximum(Calendar.DATE)) {
            this.endOfMonth(currentDate)
            repMode = 2
            //this.createEndOfDayReport(currentDate, 2)
        }
        
        if(today.equals(last_day_of_year)){
            this.endOfYear()
            repMode = 3 
            //this.createEndOfDayReport(currentDate, 3)
            // update institution for start-of-year
            def eoyCompleted = Institution.findByParamCode('GEN.10247').paramValue
            if (eoyCompleted == 'TRUE') {
                eoyCompleted = 'FALSE'
                eoyCompleted.save(flush:true)
            }
        }
        
        //auditLogService.insert('700', 'ADM00700', 'periodicops - End of Day ' + currentDate.toString())
        
        // update GL
        GlTransactionService.PeriodicGlEntries(currentDate, UserMaster.get(session.user_id))
        
        // forex revaluation
        GlTransactionService.forexRevaluation()
        
        // update gl daily balances
        def db = new Sql(dataSource)
        def sqlstmt  = "select id from gl_account where financial_year = "+currentDate.format('yyyy').toInteger()
        def glDly = db.rows(sqlstmt)
        def gl
        Double drBal = 0.00D
        Double crBal = 0.00D
        /*
        def glDly = GlAccount.createCriteria().list{
            and {
                eq("financialYear",currentDate.format('yyyy').toInteger())
            }
        }
        */
        Integer i = 0
        for (g in glDly){
            gl = GlAccount.read(g.id)
            drBal = 0.00
            crBal = 0.00
            println gl
            if (gl.balance > 0) {
                drBal = gl.balance
            } else {
                crBal = gl.balance.abs()
            }
            def gld = new GlDailyFile(glAcct:gl, branch:gl.branch, currency:gl.currency, name:gl.name, 
                code:gl.code, refDate:currentDate, 
                debitToday:gl.debitToday, creditToday:gl.creditToday,
                debitBalance:drBal, creditBalance:crBal,
                financialYear:currentDate.format('yyyy').toInteger())
            gld.save(validate:false)
            i++
            if (i == 1000) {
                cleanUpGorm()
                i = 0
            }
        }
        GlDailyFile.executeUpdate("delete from GlDailyFile where financial_year<>? and ref_date=?", [currentDate.format('yyyy').toInteger(),currentDate])
        TxnPassbookLine.executeUpdate("delete TxnPassbookLine")
        
        // closing of deposit accounts with zero balance 30 days
        if (Institution.findByParamCode('DEP.40124').paramValue == 'TRUE') {
            def clsDep = Deposit.createCriteria().list{ 
                and {
                    eq("ledgerBalAmt",0.00D)
                    ne("status",DepositStatus.get(7))
                    eq("type",DepositType.get(1))
                }
            }    
            def txnDate
            Integer duration_days
            for (deposit in clsDep) {
                txnDate = deposit.lastTxnDate
                if (!txnDate) {
                    txnDate = deposit.dateOpened
                }
                use(TimeCategory){
                    duration_days = (currentDate - txnDate).days
                }
                if (duration_days > 30 && deposit.status.id != 8 && deposit.status.id != 6) {
                    deposit.status = DepositStatus.get(7)
                    auditLogService.insert('080', 'DEP00501', 'Automatic Closing of SA '+deposit.acctNo, 'Deposit', null, null, null, deposit.id)
                }
            }
        }
        
        // EOD reports 
        //setProgressSession("98","Printing of reports","msg")
        //this.createEndOfDayReport(currentDate, repMode)
        
        // update branch for completed processes
        def brs = Branch.list(sort: "id", order: "asc")
        for (b in brs) {
            if (c.get(Calendar.DATE) == c.getActualMaximum(Calendar.DATE) && currentDate.format('MM') == '12') {
                b.runDate = currentDate
            } else {
                b.runDate = currentDate.plus(1)
            }
            b.branchRunStatus = BranchRunStatus.get(2)
            b.isTelleringActive = false
            b.save(flush:true, failOnError:true)
            
        }
        // create cash balance forward
        def txnCash = TxnTellerBalance.createCriteria().list{
            and {
                eq("txnDate",currentDate)
            }
        }
        for (tc in txnCash) {
            if (tc.cashIn != tc.cashOut) {
                def tn = new TxnTellerBalance(txnDate:currentDate.plus(1),user:tc.user, currency:tc.currency,
                    cashIn:tc.cashIn, cashOut:tc.cashOut, lastBalanceAmt:0d, isBalance:false, isCashier:tc.isCashier)
                tn.save(flush:true)
            }
        }
        // update rollovers
        depositPeriodicOpsService.rolloverStatusUpdate()
        
        // write to log
        pLog.endTime = new Date().toString()
        pLog.status = 1
        pLog.save(flush:true)
        
        setProgressSession("100","Complete","end")
        
        UserMasterService.initTellerBalance()
        
    }
    private def newDailyBalanceUpdate(Date currentDate,Branch branch){
        def db = new Sql(dataSource)
        def sqlstmt  = "select id from deposit where branch_id = "+branch.id
        def depositList = db.rows(sqlstmt)
        def deposit
        /*
         def depositList = Deposit.createCriteria().list{
            and{
                // eq("status",DepositStatus.read(2))
                eq("branch",branch)
            }
        }
        */
        Integer i = 1
        for(d in depositList){
            deposit = Deposit.read(d.id)
            println 'daily balance >>>' + deposit
            def dailyBalanceInstance = new DailyBalance(accountNo:deposit.acctNo,
                refDate:currentDate,
                branch:branch,
                accountStatus:deposit.status.id,
                currency:icbs.admin.Currency.get(1),
                availableBal:deposit.availableBalAmt,
                closingBal:deposit.ledgerBalAmt,
                holdBal:deposit.holdBalAmt,
                refYear:currentDate.format('yyyy'),
                refMonth:new SimpleDateFormat("MM").format(currentDate),
                )
            dailyBalanceInstance.save(validate:false)
            i++
            if (i == 1000) {
                cleanUpGorm()
                i = 0
            }
            
        }
        println 'finished!!! Daily Balance'
    }
    def cleanUpGorm() {
        def session = sessionFactory.currentSession
        session.flush()
        session.clear()
        //propertyInstanceMap.get().clear()
        //DomainClassGrailsPlugin.PROPERTY_INSTANCE_MAP.get().clear()
        def propertyInstanceMap = org.codehaus.groovy.grails.plugins.DomainClassGrailsPlugin.PROPERTY_INSTANCE_MAP
        propertyInstanceMap.get().clear()    									 
    }
    def endOfMonthProgressAjax(){
        def jsonObject =new JSONObject();
        jsonObject = jsonObject.put('progress',session.progress)
        jsonObject = jsonObject.put('message',session.message)
        jsonObject = jsonObject.put('flag',session.flag)
        render jsonObject
    }
    def endOfMonth(currentDate){
        //Date currentDate = (new Date()).clearTime()
        //render(setProgressSession("0","Processing End of Month","start"))
        def bl = Branch.list(sort: "id", order: "asc")
        for (branch in bl) {
            depositPeriodicOpsService.TransferToDormant(currentDate, branch, UserMaster.get(session.user_id),'monthly')  
            depositPeriodicOpsService.endOfMonth(currentDate, branch, UserMaster.get(session.user_id))    
            // transfer to dormant
            loanPeriodicOpsService.endOfMonth(currentDate, branch, UserMaster.get(session.user_id))
        }
        //setProgressSession("100","Complete","end")
        
        Integer i = 0
        // update GL
        //GlTransactionService.PeriodicGlEntries(currentDate, UserMaster.get(session.user_id)   
        
        // gl monthly balance update
        def db = new Sql(dataSource)
        def sqlstmt  = "select id from gl_account where financial_year = "+currentDate.format('yyyy').toInteger()
        def glList = db.rows(sqlstmt)
        def gl
        /*
        def glList = GlAccount.createCriteria().list{
            and {
                eq("financialYear",currentDate.format('yyyy').toInteger())
            }
        }
        */
        for (g in glList){
            gl = GlAccount.read(g.id)            
            if (!gl.isAttached()) {
                gl.attach()
            }            
            def glm = new GlMonthlyBalance(glAcct:gl, branch:gl.branch, currency:gl.currency,
                code:gl.code, name:gl.name, refDate:currentDate, 
                refYear:currentDate.format('yyyy'),
                refMonth:new SimpleDateFormat("MM").format(currentDate),
                debitBalance:gl.debitBalance, creditBalance:gl.creditBalance)
            glm.save(validate:false)
            i++
            if (i == 50) {
                cleanUpGorm()
                i = 0
            }
        }
      
        // loans and deposit balances monthly
        sqlstmt  = "select id from deposit"
        def depList = db.rows(sqlstmt)
        def dl        
        //def depList = Deposit.list()
        Double intCap = 0.00D
        Double taxWheld = 0.00D
        i = 0
        for (d in depList) {
            dl = Deposit.read(d.id)
            if (!dl.isAttached()) {
                dl.attach()
            }
            if (dl.type.id != 3 && dl.status.id > 1 && dl.status.id <  7) {
                intCap = dl.lastInterestPosted
                taxWheld = intCap * dl.depositTaxChargeScheme.taxRate.div(100)
            } 
            def dm = new MonthlyBalance(refMonth:new SimpleDateFormat("MM").format(currentDate), refYear:currentDate.format('yyyy'), 
                appType:dl.type.id.toString(), branch:dl.branch,
                currency:dl.product.currency,refDate:currentDate, accountNo:dl.acctNo, accountStatus:dl.status.id,
                availableBal:dl.availableBalAmt, averageBal:dl.lmAveBalAmt, closingBal:dl.ledgerBalAmt, 
                accruedInterestThisMonth:dl.accruedIntForTheMonth,accruedInterestCumulative:dl.accruedIntPayable,
                grossInterestCapital:intCap, taxWithheld:taxWheld, lastTxnDate:dl.lastTxnDate)
            dm.save(validate:true)
            i++
            if (i == 50) {
                cleanUpGorm()
                i = 0
            }            
        }
        i = 0
        sqlstmt  = "select id from loan"
        def loanList = db.rows(sqlstmt)  
        def l
        //def loanList = Loan.list()
        for (ln in loanList) {
            l = Loan.read(ln.id)
            if (!l.isAttached()) {
                l.attach()
            }            
            def lm = new MonthlyBalance(refMonth:new SimpleDateFormat("MM").format(currentDate), refYear:currentDate.format('yyyy'),
                appType:'4', branch:l.branch, currency:l.product.currency, refDate:currentDate,accountNo:l.accountNo,
                accountStatus:l.loanPerformanceId.id, loanPastDueStatus:l.loanPerformanceId.id.toString(),
                closingBal:l.balanceAmount, loanInterestBal:l.interestBalanceAmount, penaltyBal: l.penaltyBalanceAmount, 
                uidBal: l.advInterest)
            lm.save(validate:true)
            
            def lp = new MonthlyPointerLoan(refDate:currentDate, loanApplication:l.loanApplication, accountNo:l.accountNo,
                pnNo:l.pnNo, ownershipType:l.ownershipType, customer:l.customer, product:l.product, branch:l.branch,
                currency:l.currency, security:l.security, interestIncomeScheme:l.interestIncomeScheme, 
                currentPenaltyScheme:l.currentPenaltyScheme, pastDuePenaltyScheme:l.pastDuePenaltyScheme, interestRate:l.interestRate,
                penaltyRate:l.penaltyRate, penaltyAmount:l.penaltyAmount, serviceCharge:l.serviceCharge, grantedAmount:l.grantedAmount,
                term:l.term, frequency:l.frequency, numInstallments:l.numInstallments, balloonInstallments:l.balloonInstallments,
                applicationDate:l.applicationDate, openingDate:l.openingDate, interestStartDate:l.interestStartDate, 
                firstInstallmentDate:l.firstInstallmentDate, maturityDate:l.maturityDate, effectiveInterestRate:l.effectiveInterestRate,
                monthlyInterestRate:l.monthlyInterestRate, totalNetProceeds:l.totalNetProceeds, balanceAmount:l.balanceAmount,
                totalDisbursementAmount:l.totalDisbursementAmount, lastTransactionNo:l.lastTransactionNo, 
                transactionSequenceNo:l.transactionSequenceNo, lastTransactionDate:l.lastTransactionDate, 
                lastCustormerTransactionDate:l.lastCustormerTransactionDate, overduePrincipalBalance:l.overduePrincipalBalance,
                normalInterestAmount:l.normalInterestAmount, interestBalanceAmount:l.interestBalanceAmount,
                penaltyBalanceAmount:l.penaltyBalanceAmount, serviceChargeBalanceAmount:l.serviceChargeBalanceAmount,
                taxBalanceAmount:l.taxBalanceAmount, accruedInterestAmount:l.accruedInterestAmount,
                advInterest:l.advInterest, advInterestDays:l.advInterestDays, advInterestPeriods:l.advInterestPeriods,
                hasInterestAccrual:l.hasInterestAccrual, accruedInterestDate:l.accruedInterestDate,
                special:l.special, performanceClassification:l.performanceClassification, status:l.status,
                statusChangedDate:l.statusChangedDate, approvedBy:l.approvedBy, dateApproved:l.dateApproved,
                glLink:l.glLink, prevGLLink:l.prevGLLink, loanType:l.loanType, loanProject:l.loanProject, 
                loanKindOfLoan:l.loanKindOfLoan, loanProvision:l.loanProvision, loanPerformanceId:l.loanPerformanceId,
                loanSecurity:l.loanSecurity, ageInArrears:l.ageInArrears, loanProvisionBsp:l.loanProvisionBsp, hash:'X')
            lp.save(validate:true,failOnError:true)
            i++
            if (i == 50) {
                cleanUpGorm()
                i = 0
            } 
        }
        // customer file monthly
        i = 0
        sqlstmt  = "select id from customer"
        def cl = db.rows(sqlstmt)  
        def c
        //def cl = Customer.list()
        for (cust in cl) {
            c = Customer.read(cust.id)
            if (!c.isAttached()) {
                c.attach()
            }              
            def cm = new MonthlyCustomer(refDate:currentDate, customer:c, type:c.type, branch:c.branch, cid:c.customerId,
                name1:c.name1, name2:c.name2, name3:c.name3, name4:c.name4, displayName:c.displayName, 
                shortAddress:c.shortAddress, pepDescription:c.pepDescription, amla:c.amla, birthDate:c.birthDate, 
                title:c.title, gender:c.gender, civilStatus:c.civilStatus, birthPlace: c.birthPlace, isTaxable: c.isTaxable,
                creditLimit:c.creditLimit, customerCode1:c.customerCode1, customerCode2:c.customerCode2, 
                customerCode3: c.customerCode3, nationality:c.nationality, sourceOfIncome:c.sourceOfIncome, 
                dosriCode:c.dosriCode, sssNo:c.sssNo, gisNo:c.gisNo, tinNo:c.tinNo, passportNo:c.passportNo,
                remarks:c.remarks, group:c.group, status:c.status)
            cm.save(validate:true,failOnError:true)
            i++
            if (i == 50) {
                cleanUpGorm()
                i = 0
            }             
        }
        //this.createEndOfMonthReport()
    }
    
    def endOfYearProgressAjax(){
        def jsonObject =new JSONObject();
        jsonObject = jsonObject.put('progress',session.progress)
        jsonObject = jsonObject.put('message',session.message)
        jsonObject = jsonObject.put('flag',session.flag)
        render jsonObject
    }
    def endOfYear(){
        render(setProgressSession("0","Processing End of Year","start"))
        //this.createEndofYearReport()
        setProgressSession("100","Complete","end")
        
    }
    
    def EODCheck() {
        def userMasterInstanceList = UserMaster.createCriteria().list(params) {
            and {
                eq("isTellerBalanced", false)
                eq("configItemStatus", ConfigItemStatus.read(2))
            }
        }
        
        def txnCashList = TxnTellerBalance.createCriteria().list() {
            and {
                neProperty("cashIn", "cashOut")
                eq("txnDate",Branch.get(1).runDate)
            }
        }
        
        def loanInstanceList = Loan.createCriteria().list() {
            and {
                neProperty("totalDisbursementAmount", "totalNetProceeds")
                eq("status",LoanAcctStatus.get(4))
            }
        }        
        
        def loggedUserList = UserSession.createCriteria().list() {
            and {
                ne("userMaster", UserMaster.get(session.user_id))
                isNull("logout")
            }
        } 
        
        def unpostedGlList = GlBatchHdr.createCriteria().list() {
            and {
                eq("txnDate",Branch.get(1).runDate)
                lt("status",GlBatchHdrStatus.get(3))
            }
        } 
        println loggedUserList
        //respond userList, model:[UserMasterInstanceCount: userList.totalCount]
        render(view:'/periodicOps/EODCheck', model:[userMasterInstanceList:userMasterInstanceList, 
                UserMasterInstanceCount: userMasterInstanceList.totalCount,
                loanInstanceList:loanInstanceList,
                txnCashList:txnCashList,loggedUserList:loggedUserList,
                unpostedGlList:unpostedGlList])
    }
    
    def periodicOpsUtil(){
        // new page for periodic ops util
    }
    
    def rebuildLoanRecovery(){
        def runDate = Branch.get(1).runDate
        def rec = DailyLoanRecoveries.findAllByProcessDate(runDate)
        def drTxn
        def crTxn
        if (rec) {
            for (r in rec) {
                println '======================='
                println r
                drTxn = r.txnFileDrDeposit
                crTxn = r.txnFileCrLoan
                def tDr = TxnBreakdown.findAllByTxnFile(drTxn)
                if (!tDr) {
                    GlTransactionService.saveTxnBreakdown(drTxn.id)
                    println 'Add Debit'
                }
                def tCr = TxnBreakdown.findAllByTxnFile(crTxn)
                if (!tCr){
                    GlTransactionService.saveTxnBreakdown(crTxn.id)
                    println 'Add Credit'
                }
                
            }
        }
        flash.message = 'Successfully Executed!'
        println("executed");
        redirect(action:"index")
    }
    
}