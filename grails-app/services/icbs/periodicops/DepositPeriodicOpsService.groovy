package icbs.periodicops
import grails.transaction.Transactional
import groovy.time.TimeCategory
import icbs.tellering.TxnCOCI
import icbs.tellering.TxnDepositAcctLedger
import icbs.tellering.TxnFile
import icbs.admin.TxnTemplate
import java.text.SimpleDateFormat
import java.util.Formatter.DateTime
import icbs.deposit.Deposit
import icbs.deposit.StandingOrder
import icbs.deposit.Rollover
import icbs.deposit.FixedDepositPreTermScheme
import icbs.deposit.Hold
import icbs.lov.HoldStatus
import icbs.lov.HoldType
import icbs.lov.ConfigItemStatus
import icbs.lov.DepositStatus
import icbs.lov.DepositType
import icbs.lov.RolloverStatus
import icbs.lov.DepositAcctDormancyTransferFreq
import icbs.admin.Branch
import icbs.admin.UserMaster
import icbs.deposit.DepositTaxFeeAndChargeScheme
import icbs.admin.Branch
import icbs.admin.UserMaster
import icbs.lov.TxnType
import icbs.lov.StandingOrderStatus
import icbs.lov.CheckStatus
import icbs.admin.Holiday
import icbs.admin.Institution
import icbs.admin.Product
import icbs.lov.ProductType
import icbs.lov.TxnCheckStatus
import icbs.admin.Currency	
import icbs.periodicops.DailyTimeDepositRollover
import icbs.periodicops.DailyHoldsRelease
import icbs.periodicops.MonthlyDepositInterest
import icbs.periodicops.MonthlyDepositCharges
import icbs.periodicops.DailyCheckClearing
import groovy.sql.Sql

@Transactional
class DepositPeriodicOpsService {
    
    def GlTransactionService
    def depositService
    def sessionFactory
    def dataSource
    
    def startOfDay(Date currentDate,Branch branch,UserMaster user) {
        currentDate = currentDate.clearTime()
        //clearingChecks(currentDate)//working
        timeDepositDailyInterestCalculation(currentDate,branch)//working
        FDRollover(currentDate,branch,user)
        standingOrderProcessing(currentDate,branch,user)//working
        updatePbClosed(branch)
    }
    
    def endOfDay(Date currentDate,Branch branch,UserMaster user) {
        currentDate = currentDate.clearTime()
        //updateLastTxnDate(currentDate, branch)
        
        //dailyBalanceUpdate(currentDate,branch)//working
        def today = new SimpleDateFormat("yyyy-MM-dd").format(currentDate)
        def last_day_of_month = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(new java.util.Date().format('yyyy') + "-" + (new Integer (new SimpleDateFormat("MM").format(new Date()))+1) + "-01")-1);
        
        def last_day_of_year
        if(today.equals(last_day_of_month)){
            //this.endOfMonth(currentDate,branch,user)
        }
        if(today.equals(last_day_of_year)){
            this.endOfYear()
        }
    }
    private def endOfMonth(Date currentDate, Branch branch,UserMaster user){
        this.depositInterestCalculation(currentDate,branch)
        this.depositInterestPosting(currentDate, branch, user)
        this.monthlyFDInterest(currentDate, branch, user)
        this.DormancyCharges(currentDate, branch, user)
        this.depositFeesProcessing(currentDate,branch,user)
        //this.monthlyBalanceUpdate(currentDate,branch)
    }
    private def endOfYear(){
        
    }
    
    def cleanUpDepGorm() {
        def session = sessionFactory.currentSession
        session.flush()
        session.clear()
        def propertyInstanceMap = org.codehaus.groovy.grails.plugins.DomainClassGrailsPlugin.PROPERTY_INSTANCE_MAP
        propertyInstanceMap.get().clear()
        //propertyInstanceMap.get().clear()
    }
    def updatePbClosed(Branch branch){
        def dcl = Deposit.createCriteria().list{
            and {
                eq("status",DepositStatus.read(7))
                eq("branch",branch)
                eq("ledgerBalAmt",0.00D)
                ne("passbookBalAmt",0.00D)
                //eq("branch",Branch.read(branch.id))
            }
        }
        for (d in dcl){
            d.passbookBalAmt = 0.00D
            d.save(flush:true,failOnError:true)
        }
    }
    
    def updateLastTxnDate(Date currentDate) {
        def txnList = TxnFile.createCriteria().list{
            and {
                eq("txnDate",currentDate)
                isNotNull("depAcct")
                //eq("branch",Branch.read(branch.id))
            }
        }
        def di
        for (txn in txnList) {
            di = Deposit.get(txn.depAcct.id)
            if ((di)  && (txn.txnTemplate.requireTxnDescription == true)) {
                di.lastTxnDate = currentDate
                di.save(flush:true, failOnError:true)
            }
        }
    }
    
    // transfer deposit accounts to dormant status
    def TransferToDormant(Date runDate, Branch branch, UserMaster user, String type){
        def prList
        if (type == 'daily') {
            println type
            prList = Product.createCriteria().list() {
                and{
                    eq("depositDormancyTransferFreq",DepositAcctDormancyTransferFreq.get(1))
                }
                or {
                    eq("productType",ProductType.read(1))
                    eq("productType",ProductType.read(2))
                }
            }               
        }
        if (type == 'monthly') {
            prList = Product.createCriteria().list() {
                and{
                    eq("depositDormancyTransferFreq",DepositAcctDormancyTransferFreq.get(2))
                }  
                or {
                    eq("productType",ProductType.read(1))
                    eq("productType",ProductType.read(2))
                }
            }            
        }
        println 'transfer to dormant >>>>>>>'
        println prList
        // nothing to do
        if (!prList) {
            return
        }        
        
        def depositList = Deposit.createCriteria().list{
            and{
                'in'("status",[DepositStatus.read(2),DepositStatus.read(3),DepositStatus.read(4)])
                isNotNull("lastTxnDate")
                eq("branch",branch)
                'in'("product",prList)
            }
        }               
        println depositList
        def dormDate = branch.runDate
        def lastDate
        def txn
        def ledger
        
        def dormantTxn = Institution.findByParamCode('DEP.40080').paramValue.toInteger()
        
        for (deposit in depositList) {
            if (deposit.product.depositDormancyMonths > 0) {
                    use (TimeCategory) {
                        //standingOrder.endDate += 4.months
                        //dormDate -= deposit.product.depositDormancyMonths.months
                        dormDate = deposit.branch.runDate - deposit.product.depositDormancyMonths.months
                    }     
                    println deposit.acctNo
                    println deposit.lastTxnDate
                    println dormDate
                    
                if (deposit.lastTxnDate < dormDate) {
                    // update txnFile
                    println '*** dormant ***'
                    txn = new TxnFile()
                    txn.acctNo = deposit.acctNo
                    txn.branch = deposit.branch
                    txn.currency = deposit.product.currency
                    txn.depAcct = deposit
                    txn.status = ConfigItemStatus.get(2)
                    txn.txnAmt = deposit.ledgerBalAmt
                    // create txn_template for transfer to dormant
                    txn.txnCode = TxnTemplate.get(dormantTxn).code
                    txn.txnDate = branch.runDate
                    txn.txnDescription = 'Transfer to Dormant'
                    txn.txnParticulars = branch.runDate.toString() + ' - Transfer to Dormancy - ' + type
                    txn.txnRef = branch.runDate.toString() + ' - Dormancy'
                    txn.txnTimestamp = new Date().toTimestamp()
                    // create txn_template for transfer to dormant
                    txn.txnType = TxnTemplate.get(dormantTxn).txnType
                    txn.user = UserMaster.get(1)
                    txn.save(flush:true, failOnError:true)
                    
                    // update ledger
                    ledger = new TxnDepositAcctLedger()
                    ledger.acct = deposit
                    ledger.acctNo = deposit.acctNo
                    ledger.bal = deposit.ledgerBalAmt
                    ledger.branch = deposit.branch
                    ledger.creditAmt = deposit.ledgerBalAmt
                    ledger.debitAmt = deposit.ledgerBalAmt
                    ledger.currency = deposit.product.currency
                    ledger.status = DepositStatus.get(5)
                    ledger.txnDate = txn.txnDate
                    ledger.txnFile = txn
                    ledger.user = UserMaster.get(1)
                    ledger.txnRef = txn.txnRef
                    ledger.txnType = txn.txnType
                    ledger.save(flush:true, failOnError:true)
                    
                    // update deposit
                    deposit.status = DepositStatus.get(5)
                    deposit.statusChangeDate = branch.runDate
                    deposit.save(flush:true, failOnError:true)
                    
                    //create entry for glTxnBreakdown
                    GlTransactionService.saveTxnBreakdown(txn.id)
                }    
            } 
        }
    }
    
    def monthlyFDInterest(Date currentDate, Branch branch, UserMaster user) {
        def depositList = Deposit.createCriteria().list{
            and{
                eq("type",DepositType.read(3))
                eq("branch",branch)
                ne("status",DepositStatus.read(1))
                ne("status",DepositStatus.read(8))
                ne("status",DepositStatus.read(7))								  
            }
        }
        Date today = Branch.get(1).runDate
        Calendar calendar = Calendar.getInstance()
        calendar.setTime(today)
        calendar.set(Calendar.DAY_OF_MONTH, 1)
        Date firstDayOfMonth = calendar.getTime()
        def fdRoll 
        Date intStartDate
        Double intRate
        Double interestAmt = 0.00D
        Double aipAmt = 0.00D
        Double aipTax = 0.00D
        Integer duration_days
        Integer total_days
        def intTxn = Institution.findByParamCode("DEP.40100").paramValue.toInteger()
        def taxTxn = Institution.findByParamCode("DEP.40110").paramValue.toInteger()  
        
        for(deposit in depositList) {
                    
            fdRoll = deposit.currentRollover
            
            if (deposit.acrintDate > firstDayOfMonth){
                intStartDate = deposit.acrintDate
            } else {
                intStartDate = firstDayOfMonth.minus(1)
            }
            use(TimeCategory){
                duration_days = (currentDate - intStartDate).days
                total_days = (currentDate - deposit.acrintDate).days
            }
            
            if (fdRoll.status.id == 1) {
                intRate = deposit.interestRate.div(100)
            } else {
                intRate = deposit.fixedDepositPreTermScheme.rate.div(100)
            }
            
            interestAmt = deposit.ledgerBalAmt * duration_days * intRate.div(deposit.depositInterestScheme.divisor)     
            interestAmt = interestAmt.round(2)
            
            //AIP computation
            //total_days = total_days.plus(1)
            aipAmt = deposit.ledgerBalAmt * total_days * intRate.div(deposit.depositInterestScheme.divisor) 
            aipAmt = aipAmt.round(2)
            aipTax = aipAmt * deposit.depositTaxChargeScheme.taxRate.div(100)
            aipTax = aipTax.round(2)
            //deposit.taxWithheld = roll.taxAmt1
            deposit.accruedIntForTheMonth = interestAmt
            deposit.accruedTaxForTheMonth = interestAmt * deposit.depositTaxChargeScheme.taxRate.div(100)
            deposit.accruedIntPayable = aipAmt
            deposit.accruedTaxPayable = aipTax
            deposit.save()   
            
            if (interestAmt > 0) {
                // create interest accural transaction
                def intTxnTmp = TxnTemplate.get(intTxn)
                def taxTxnTmp = TxnTemplate.get(taxTxn)
                
                def txnFile1 = new TxnFile(txnParticulars:"Interest Accrual",currency:deposit.product.currency,txnType:intTxnTmp.txnType,
                    status:ConfigItemStatus.read(2), txnTimestamp:new Date().toTimestamp(),user:user,branch:branch,txnCode:intTxnTmp.code,
                    acctNo:deposit.acctNo, txnAmt:deposit.accruedIntForTheMonth, txnRef:"FD accrual",depAcct:deposit,txnDate:currentDate, 
                    txnTemplate:intTxnTmp, txnDescription:intTxnTmp.description)
                //debit tax
                def txnFile2 = new TxnFile(txnParticulars:"Tax debit",currency:deposit.product.currency,txnType:taxTxnTmp.txnType,
                    status:ConfigItemStatus.read(2),txnTimestamp:new Date().toTimestamp(),user:user,branch:branch,txnCode:taxTxnTmp.code,
                    acctNo:deposit.acctNo, txnAmt:deposit.accruedTaxForTheMonth, txnRef:"FD accrual tax",depAcct:deposit,txnDate:currentDate, 
                    txnTemplate:taxTxnTmp, txnDescription:taxTxnTmp.description)                        
                txnFile1.save(failOnError:true,flush:true,validate:false)
                txnFile2.save(failOnError:true,flush:true,validate:false)
                
                def monthlyInterest = new MonthlyDepositInterest(refDate:currentDate, deposit:deposit, 
                    interest:txnFile1, tax:txnFile2)
                monthlyInterest.save(flush:true)    
                
                GlTransactionService.fdInterestAccrual(txnFile1, txnFile2)
            }
        }        
    }
    
    def DormancyCharges(Date currentDate, Branch branch, UserMaster user){
         def depositList = Deposit.createCriteria().list{
            and{
                eq("status",DepositStatus.read(5))
                eq("branch",branch)
                gt("ledgerBalAmt",0.00d)
                //eq("branch",branch)
            }
        }   
        def dormDate = branch.runDate
        Double chgAmt 
        def lastDate
        def txn
        def ledger
        def depositBalRefAmt
        def dormantChgTxn = Institution.findByParamCode('DEP.40120').paramValue.toInteger()
        def chgDate = branch.runDate
        println 'dormancy charges >>>>>>>>>>>'
        println depositList
        for (deposit in depositList) {
            
            if (deposit.ledgerBalAmt <= deposit.product.minBalance) {
                // can change later to ADB as needed
                depositBalRefAmt = deposit.ledgerBalAmt 
                // add BSP circular 928 compliance
                use (TimeCategory) {
                    def monthsToCharge = 60
                    chgDate = deposit.branch.runDate - monthsToCharge.months
                }                 
                
                if ((depositBalRefAmt > 0.00d) && (deposit.lastTxnDate < chgDate)) {
                    
                    if (deposit.ledgerBalAmt > deposit.product.depositDormancyAmt) {
                        chgAmt =  deposit.product.depositDormancyAmt
                    } else {
                        chgAmt = deposit.ledgerBalAmt
                    }
                    // update txnFile
                    txn = new TxnFile()
                    txn.acctNo = deposit.acctNo
                    txn.branch = deposit.branch
                    txn.currency = deposit.product.currency
                    txn.depAcct = deposit
                    txn.status = ConfigItemStatus.get(2)
                    txn.txnAmt = chgAmt  // use deposit.product.depositDormancyAmt
                    
                    txn.txnCode = TxnTemplate.get(dormantChgTxn).code
                    txn.txnDate = branch.runDate
                    txn.txnDescription = 'Dormancy Charges'
                    txn.txnParticulars = branch.runDate.toString() + ' Dormancy Charges'
                    txn.txnRef = branch.runDate.toString() + ' - Dormancy Chg'
                    txn.txnTimestamp = new Date().toTimestamp()
                    
                    txn.txnType = TxnTemplate.get(dormantChgTxn).txnType
                    txn.txnTemplate = TxnTemplate.get(dormantChgTxn)
                    txn.user = user
                    txn.save(flush:true, failOnError:true)
                    
                    // update ledger
                    ledger = new TxnDepositAcctLedger()
                    ledger.acct = deposit
                    ledger.acctNo = deposit.acctNo
                    ledger.bal = deposit.ledgerBalAmt - chgAmt
                    ledger.branch = deposit.branch
                    ledger.debitAmt = chgAmt 
                    ledger.currency = deposit.product.currency
                    ledger.status = deposit.status
                    ledger.txnDate = txn.txnDate
                    ledger.txnFile = txn
                    ledger.user = user
                    ledger.txnRef = txn.txnRef
                    ledger.txnType = txn.txnType
                    ledger.save(flush:true, failOnError:true)
                    
                    // update deposit
                    deposit.availableBalAmt -= chgAmt
                    deposit.ledgerBalAmt -= chgAmt
                    if (deposit.availableBalAmt <= 0.00d) {
                        deposit.availableBalAmt = 0.00d
                    }
                    deposit.save(flush:true, failOnError:true)
                    
                    def monthlyCharge = new MonthlyDepositCharges(refDate:currentDate, deposit:deposit,
                        charges:txn, chargeType:1)
                    monthlyCharge.save(flush:true)
                    //create entry for glTxnBreakdown
                    GlTransactionService.saveTxnBreakdown(txn.id)
                }    
            } 
        }
    }
    
    def clearingChecks(Date currentDate){
        Boolean withClearing = true
        def holidays = Holiday.findAllWhere(holidayDate:currentDate)
        Boolean bHoliday
        
        // check for countrywide holidays
        if (holidays){
            if (holidays.institutionWideHoliday){
                withClearing = false
            }
        }
        
        // check for weekends (sunday and saturday no clearing)
        def today = currentDate.toString()
        if (Date.parse("yyyy-MM-dd", today.substring(0,10))[Calendar.DAY_OF_WEEK]==1){
            withClearing = false
        }
        if (Date.parse("yyyy-MM-dd", today.substring(0,10))[Calendar.DAY_OF_WEEK]==7){
            withClearing = false
        }
        if (withClearing){
            def checkList = TxnCOCI.findAllByClearingDateLessThanEqualsAndCheckStatusNotEqual(currentDate, CheckStatus.read(5))
            def deposit
            for(check in checkList){
                println '???' + check
                if (check.txnCheckStatus == TxnCheckStatus.get(1) || check.txnCheckStatus == TxnCheckStatus.get(4)) {
                    continue;
                }
                // do not include on-us checks
                if (check.checkType.isOnUs) {
                    continue;
                }
                //def deposit = Deposit.find(acctNo==check.acctNo)
                deposit = check.depAcct
                if(deposit){
                    println '???' + deposit
                    check.status=ConfigItemStatus.read(3)
                    check.checkStatus = CheckStatus.read(5)
                    check.cleared = 'TRUE'
                    check.save(flash:true, failOnError:true)
                    //deposit.outstandingBalAmt += check.Amt
                    //deposit.ledgerBalAmt -= check.Amt
                    deposit.availableBalAmt += check.checkAmt
                    deposit.unclearedCheckBalAmt -= check.checkAmt
                    deposit.save(flush:true, failOnError:true)
                    
                    def dailyCheckDeposit = new DailyCheckClearing(processDate:currentDate, deposit:deposit, checkDeposit:check)
                    dailyCheckDeposit.save(flush:true)
                }else{
                    //Acct no does not exist
                }  
            }
        }
  
    }
    
    def holdsReleaseProcessing(Date refDate, Branch branch, UserMaster user) {
        def holdList = Hold.createCriteria().list{
            and{
                eq("status",HoldStatus.read(2))
                //eq("type",HoldType.read(1))
                le("maturityDate",refDate)
            }
        }   
        for (hold in holdList){
            
            def hDep = hold.deposit
            println 'hold br >>>>> ' + hDep.branch
            println 'br >>>> ' + branch
            if (hDep.branch.id == branch.id) {
                println 'hold clear >>>>> ' + hold
                println 'hold clear dep >>>>> ' + hDep
                hold.status = HoldStatus.get(3)
                println 'hold status >>>>>' + hold.status
                hDep.availableBalAmt+= hold.amt
                hDep.holdBalAmt -= hold.amt
            
                hold.save(flush:true, failOnError:true)
                hDep.save(flush:true)
                
                def daily = new DailyHoldsRelease(processDate:refDate,hold:hold)
                daily.save(flush:true)
                // need to add audit log here                
            }
        }    
                 
    }
    //checked is working
    private def standingOrderProcessing(Date currentDate,Branch branch,UserMaster user){
        def standingOrderList 
        def amount
        standingOrderList = StandingOrder.createCriteria().list{
            and{
                eq("status",StandingOrderStatus.read(2))
                eq("endDate",currentDate)   
                'fundingDeposit'{
                    eq("branch",branch)
                }
            }
        }
        println standingOrderList
        for(standingOrder in standingOrderList){
            if(standingOrder.type.id==1){//absolute
                if(standingOrder.fundingDeposit.availableBalAmt>=standingOrder.fundFixedAmt){
                    amount = standingOrder.fundFixedAmt 
                    standingOrder.fundingDeposit.availableBalAmt-=amount
                    standingOrder.fundingDeposit.outstandingBalAmt -= amount
                    standingOrder.fundingDeposit.ledgerBalAmt -= amount
                    standingOrder.fundedDeposit.availableBalAmt+=amount 
                    standingOrder.fundedDeposit.outstandingBalAmt += amount
                    standingOrder.fundedDeposit.ledgerBalAmt += amount
                    if(standingOrder.freq.id==1){
                        
                        use (TimeCategory) {
                            standingOrder.endDate+=1.day
                            println standingOrder.endDate
                        }
                    }
                    if(standingOrder.freq.id==2){
                        use (TimeCategory) {
                            standingOrder.endDate+= 1.week
                        }
                    }
                    if(standingOrder.freq.id==3){
                         use (TimeCategory) {
                            standingOrder.endDate+=15.days
                        }
                    }
                    if(standingOrder.freq.id==4){
                        use (TimeCategory) {
                            standingOrder.endDate += 1.month
                        }
                    }
                    if(standingOrder.freq.id==5){
                        use (TimeCategory) {
                            standingOrder.endDate += 4.months
                        }
                    }
                    def txnTemplate = TxnTemplate.findByCode("008001")
                    def txnFile1 = new TxnFile(txnParticulars:txnTemplate.description,currency:standingOrder.fundingDeposit.currency,txnType:TxnType.read(8),acctStatus:standingOrder.fundingDeposit.status.id,status:ConfigItemStatus.read(2),txnTimestamp:new Date().toTimestamp(),user:user,branch:branch,txnCode:txnTemplate.code,acctNo:standingOrder.fundingDeposit.acctNo,txnAmt:amount,txnRef:txnTemplate.description,depAcct:standingOrder.fundingDeposit)
                    def txnFile2 = new TxnFile(txnParticulars:txnTemplate.description,currency:standingOrder.fundedDeposit.currency,txnType:TxnType.read(8),acctStatus:standingOrder.fundedDeposit.status.id,status:ConfigItemStatus.read(2),txnTimestamp:new Date().toTimestamp(),user:user,branch:branch,txnCode:txnTemplate.code,acctNo:standingOrder.fundedDeposit.acctNo,txnAmt:amount,txnRef:txnTemplate.description,depAcct:standingOrder.fundedDeposit)
                    def acctLedger1 = new TxnDepositAcctLedger(txnType:TxnType.read(8),user:user,branch:branch,currency:standingOrder.fundingDeposit.currency,status:ConfigItemStatus.read(2),txnDate:new Date(),txnFile:txnFile1,acct:standingOrder.fundingDeposit,acctNo:standingOrder.fundingDeposit.acctNo,debitAmt:amount,bal:standingOrder.fundingDeposit.availableBalAmt,txnRef:txnTemplate.description)
                    def acctLedger2 = new TxnDepositAcctLedger(txnType:TxnType.read(8),user:user,branch:branch,currency:standingOrder.fundedDeposit.currency,status:ConfigItemStatus.read(2),txnDate:new Date(),txnFile:txnFile2,acct:standingOrder.fundedDeposit,acctNo:standingOrder.fundedDeposit.acctNo,creditAmt:amount,bal:standingOrder.fundedDeposit.availableBalAmt,txnRef:txnTemplate.description)
                    
                    standingOrder.fundingDeposit.save(failOnError:true)
                    standingOrder.fundedDeposit.save(failOnError:true)
                    standingOrder.save(failOnError:true)
                    
                    txnFile1.save(failOnError:true,flush:true,validate:false)
                    txnFile2.save(failOnError:true,flush:true,validate:false)
                    acctLedger1.save(failOnError:true)
                    acctLedger2.save(failOnError:true)
                }else{
                    println "not enough money"+standingOrder.fundingDeposit
                }
            }
            if(standingOrder.type.id==2){//percentage
                amount = (standingOrder.fundingDeposit.availableBalAmt*standingOrder.percent)
                standingOrder.fundingDeposit.availableBalAmt-= amount
                standingOrder.fundingDeposit.outstandingBalAmt-=amount 
                standingOrder.fundingDeposit.ledgerBalAmt-=amount 
                
                standingOrder.fundedDeposit.availableBalAmt+=amount
                standingOrder.fundedDeposit.outstandingBalAmt+=amount
                standingOrder.fundedDeposit.ledgerBalAmt+=amount
                if(standingOrder.freq.id==1){
                    use (TimeCategory) {
                        standingOrder.endDate+=1.day
                    }
                }
                if(standingOrder.freq.id==2){
                    use (TimeCategory) {
                        standingOrder.endDate+= 1.week
                    }
                }
                if(standingOrder.freq.id==3){
                    use(TimeCategory) {
                        standingOrder.endDate+=15.days
                    }
                }
                if(standingOrder.freq.id==4){
                    use (TimeCategory) {
                        standingOrder.endDate += 1.month
                    }
                }
                if(standingOrder.freq.id==5){
                    use (TimeCategory) {
                        standingOrder.endDate += 4.months
                    }
                }
                def txnTemplate = TxnTemplate.findByCode("008001")
                def txnFile1 = new TxnFile(txnParticulars:txnTemplate.description,currency:standingOrder.fundingDeposit.currency,txnType:TxnType.read(8),acctStatus:standingOrder.fundingDeposit.status.id,status:ConfigItemStatus.read(2),txnTimestamp:new Date().toTimestamp(),user:user,branch:branch,txnCode:txnTemplate.code,acctNo:standingOrder.fundingDeposit.acctNo,txnAmt:amount,txnRef:txnTemplate.description,depAcct:standingOrder.fundingDeposit)
                def txnFile2 = new TxnFile(txnParticulars:txnTemplate.description,currency:standingOrder.fundedDeposit.currency,txnType:TxnType.read(8),acctStatus:standingOrder.fundedDeposit.status.id,status:ConfigItemStatus.read(2),txnTimestamp:new Date().toTimestamp(),user:user,branch:branch,txnCode:txnTemplate.code,acctNo:standingOrder.fundedDeposit.acctNo,txnAmt:amount,txnRef:txnTemplate.description,depAcct:standingOrder.fundedDeposit)
                def acctLedger1 = new TxnDepositAcctLedger(txnType:TxnType.read(8),user:user,branch:branch,currency:standingOrder.fundingDeposit.currency,status:ConfigItemStatus.read(2),txnDate:new Date(),txnFile:txnFile1,acct:standingOrder.fundingDeposit,acctNo:standingOrder.fundingDeposit.acctNo,debitAmt:amount,bal:standingOrder.fundingDeposit.availableBalAmt,txnRef:txnTemplate.description)
                def acctLedger2 = new TxnDepositAcctLedger(txnType:TxnType.read(8),user:user,branch:branch,currency:standingOrder.fundedDeposit.currency,status:ConfigItemStatus.read(2),txnDate:new Date(),txnFile:txnFile2,acct:standingOrder.fundedDeposit,acctNo:standingOrder.fundedDeposit.acctNo,creditAmt:amount,bal:standingOrder.fundedDeposit.availableBalAmt,txnRef:txnTemplate.description)
                standingOrder.fundingDeposit.save(failOnError:true)
                standingOrder.fundedDeposit.save(failOnError:true)
                standingOrder.save(failOnError:true)
                txnFile1.save(failOnError:true,flush:true,validate:false)
                txnFile2.save(failOnError:true,flush:true,validate:false)
                acctLedger1.save(failOnError:true)
                acctLedger2.save(failOnError:true)
            }
        }
    }
    //for automatic recovery only
    private def FDRollover(Date currentDate,Branch branch,UserMaster user){
        def intTxn = Institution.findByParamCode("DEP.40100").paramValue.toInteger()
        def taxTxn = Institution.findByParamCode("DEP.40110").paramValue.toInteger()        
        Integer i = 0
        def db = new Sql(dataSource)
        def sqlstmt  = "select id from deposit where type_id = 3 and status_id > 1 and status_id < 7 and branch_id = "+branch.id

        def fdList = db.rows(sqlstmt)
        def fd
        /*
        def fdList = Deposit.createCriteria().list{
            and{
                eq("type",DepositType.read(3))
                eq("status",DepositStatus.read(2))
                eq("branch",branch)
                //eq("branch",branch)
            }
        }
        */
       def rolloverSql
        for(f in fdList){
            fd = Deposit.get(f.id)
            i++
            if (i == 50 ){
                i = 1
                cleanUpDepGorm()
            }
            if(!fd.isAttached()) {
                fd.attach()
            }            
            rolloverSql = "select id from rollover where status_id = 1 and id = "+fd.currentRollover.id + " and end_Date <='" + currentDate.format('yyyy-MM-dd') +"'"
            def rolloverList = db.rows(rolloverSql)
            if (rolloverList) {
            //if((fd.currentRollover.endDate <= currentDate) && (fd.currentRollover.status == RolloverStatus.read(1))){ 
                // no rollover
                if(fd.currentRollover.type.id==1){
                    //update status
                    fd.currentRollover.endDate = currentDate
                    fd.currentRollover.status = RolloverStatus.get(2)
                    fd.currentRollover.save(failOnError:true)
                    /*
                    // interest posting
                    if (fd.currentRollover.normalInterestAmt > 0.00) {
                        def tfInt = new TxnFile()
                        tfInt.acctNo = fd.acctNo
                        //tfInt.acctStatus= fd.status.id
                        tfInt.branch = fd.branch
                        tfInt.currency = fd.product.currency
                        tfInt.depAcct = fd
                        tfInt.status = ConfigItemStatus.read(2)
                        tfInt.txnTimestamp = currentDate.toTimestamp()
                        tfInt.txnDate = currentDate
                        tfInt.txnAmt = fd.currentRollover.normalInterestAmt
                        tfInt.txnCode = TxnTemplate.get(intTxn).code
                        tfInt.txnType = TxnTemplate.get(intTxn).txnType
                        tfInt.txnDescription = TxnTemplate.get(intTxn).description
                        tfInt.txnRef = currentDate.toString() + ' Int Posting'  
                        tfInt.user = user
                        //tfInt.branch = branch
                        tfInt.txnTemplate = TxnTemplate.get(intTxn)
                        tfInt.save(flush:true)	
                
                        def dlInt = new TxnDepositAcctLedger()
                        dlInt.acct = fd
                        dlInt.acctNo = fd.acctNo
                        dlInt.bal = fd.ledgerBalAmt + fd.currentRollover.normalInterestAmt
                        dlInt.branch = fd.branch
                        dlInt.creditAmt = fd.currentRollover.normalInterestAmt
                        dlInt.currency = fd.product.currency
                        dlInt.status = fd.status
                        dlInt.txnDate = currentDate
                        dlInt.txnFile = tfInt
                        dlInt.txnRef = currentDate.toString() + ' Int Posting'
                        dlInt.txnType = TxnTemplate.get(intTxn).txnType
                        dlInt.user = user
                        dlInt.branch = branch	
                        dlInt.save(flush:true)
            
                        // post tax txn
                        def tfTax = new TxnFile()
                        tfTax.acctNo = fd.acctNo
                        //tfTax.acctStatus= fd.status.id
                        tfTax.branch = fd.branch
                        tfTax.currency = fd.product.currency
                        tfTax.depAcct = fd
                        tfTax.status = ConfigItemStatus.read(2)
                        tfTax.txnTimestamp = currentDate.toTimestamp()
                        tfTax.txnDate = currentDate
                        tfTax.txnAmt = fd.currentRollover.taxAmt1
                        tfTax.txnCode = TxnTemplate.get(taxTxn).code
                        tfTax.txnType = TxnTemplate.get(taxTxn).txnType
                        tfTax.txnTemplate = TxnTemplate.get(taxTxn)
                        tfTax.txnDescription = TxnTemplate.get(taxTxn).description
                        tfTax.txnRef = currentDate.toString() + ' Wholding Tax'  
                        tfTax.user = user
                        //tfTax.branch = branch
                        tfTax.save(flush:true)	
                
                        def dlTax = new TxnDepositAcctLedger()
                        dlTax.acct = fd
                        dlTax.acctNo = fd.acctNo
                        dlTax.bal = fd.ledgerBalAmt + fd.acrintAmt - fd.currentRollover.taxAmt1
                        dlTax.branch = fd.branch
                        dlTax.debitAmt = fd.currentRollover.taxAmt1
                        dlTax.currency = fd.product.currency
                        dlTax.status = fd.status
                        dlTax.txnDate = currentDate
                        dlTax.txnFile = tfTax
                        dlTax.txnRef = currentDate.toString() + ' Wholding Tax'
                        dlTax.txnType = TxnTemplate.get(taxTxn).txnType
                        dlTax.user = user
                        dlTax.branch = branch	
                        dlTax.save(flush:true)     
                    
                        // update deposit
                        fd.ledgerBalAmt += fd.currentRollover.normalInterestAmt - fd.currentRollover.taxAmt1
                        fd.availableBalAmt += fd.currentRollover.normalInterestAmt - fd.currentRollover.taxAmt1
                        // compute and update tax
                        if (fd.grossRolloverInterestAmt) {
                            fd.grossRolloverInterestAmt += fd.currentRollover.normalInterestAmt
                        } else {
                            fd.grossRolloverInterestAmt = fd.currentRollover.normalInterestAmt  
                        }
                        if (fd.netRolloverInterestAmt) {
                            fd.netRolloverInterestAmt += (fd.currentRollover.normalInterestAmt - fd.currentRollover.taxAmt1)  
                        } else {
                            fd.netRolloverInterestAmt = (fd.currentRollover.normalInterestAmt - fd.currentRollover.taxAmt1)
                        }
                        fd.taxWithheld = fd.currentRollover.taxAmt1
                        fd.acrintAmt = 0.00
                        fd.interestBalAmt = 0.00
                        fd.acrintDate = currentDate
                        fd.save(flush:true)     
                        
                        GlTransactionService.saveTxnBreakdown(tfInt.id)
                        GlTransactionService.saveTxnBreakdown(tfTax.id)
                       
                    }
                    */
                    if (fd.grossRolloverInterestAmt) {
                        fd.grossRolloverInterestAmt += fd.currentRollover.normalInterestAmt
                    } else {
                        fd.grossRolloverInterestAmt = fd.currentRollover.normalInterestAmt  
                    }
                    if (fd.netRolloverInterestAmt) {
                        fd.netRolloverInterestAmt += (fd.currentRollover.normalInterestAmt - fd.currentRollover.taxAmt1)  
                    } else {
                        fd.netRolloverInterestAmt = (fd.currentRollover.normalInterestAmt - fd.currentRollover.taxAmt1)
                    }                    
                   fd.acrintAmt = fd.currentRollover.normalInterestAmt
                   fd.acrintDate = currentDate
                   fd.taxWithheld = fd.currentRollover.taxAmt1
                   fd.save(flush:true)
                   def daily = new DailyTimeDepositRollover(processDate:currentDate,oldRollover:fd.currentRollover)
                   daily.save(flush:true)
                   continue;
                }  
                if(fd.currentRollover.type.id==2){
                    //send principal
                    if(fd.currentRollover.interestPaymentMode.id==1){
                        //withdrawal from amount
                        
                        def tax = 0
                        if (fd.grossRolloverInterestAmt) {
                            fd.grossRolloverInterestAmt += fd.currentRollover.normalInterestAmt
                        } else {
                            fd.grossRolloverInterestAmt = fd.currentRollover.normalInterestAmt  
                        }
                        if (fd.netRolloverInterestAmt) {
                            fd.netRolloverInterestAmt += (fd.currentRollover.normalInterestAmt - fd.currentRollover.taxAmt1)  
                        } else {
                            fd.netRolloverInterestAmt = (fd.currentRollover.normalInterestAmt - fd.currentRollover.taxAmt1)
                        }
                        //fd.currentRollover.normalInterestAmt = fd.acrintAmt
                        tax = fd.currentRollover.taxAmt1
                        def oldRollover = fd.currentRollover
                        def rolloverInstance = new Rollover(
                            principalAmt:fd.ledgerBalAmt,
                            type:fd.currentRollover.type,deposit:fd,
                            ctd:fd.currentRollover.ctd,
                            startDate:currentDate,
                            endDate:currentDate.plus(fd.fixedDepositTermScheme.value.toInteger()),
                            status:RolloverStatus.get(1),
                            interestPaymentMode:fd.currentRollover.interestPaymentMode,
                            fundedDeposit:fd.currentRollover.fundedDeposit,
                            postMaturityInterestRate:fd.currentRollover.postMaturityInterestRate,
                            normalInterestAmt:fd.grossRolloverInterestAmt, preTermInterestAmt:0, 
                            taxAmt1:tax, taxAmt2:0)                        
                        fd.currentRollover.status = RolloverStatus.get(2)
                        fd.currentRollover.endDate = currentDate
                        fd.currentRollover.save(failOnError:true)
                        fd.save(flush:true)
                        fd.addToRollovers(rolloverInstance).save(flush: true)
                        fd.currentRollover = rolloverInstance 
                        if (fd.maturityDate <= currentDate) {
                            fd.maturityDate = currentDate.plus(fd.fixedDepositTermScheme.value.toInteger())
                        }                         
                        fd.save(flush:true)
                        
                        def daily = new DailyTimeDepositRollover(processDate:currentDate,
                            oldRollover:oldRollover, newRollover:rolloverInstance)
                        daily.save(flush:true)
                    }
                    if(fd.currentRollover.interestPaymentMode.id==2){
                        // principal rollover with interest to funded account 
                        def tax = 0
                        fd.grossRolloverInterestAmt = 0.00
                        fd.netRolloverInterestAmt = 0.00
                        //fd.currentRollover.normalInterestAmt = fd.acrintAmt
                        def intTxnTmp = TxnTemplate.get(intTxn)
                        def taxTxnTmp = TxnTemplate.get(taxTxn)
                        //credit interest
                        //fd.product.attach()
                        fd = fd.merge()
                        def txnFile1 = new TxnFile(txnParticulars:"Interest Credit",currency:fd.product.currency,txnType:intTxnTmp.txnType,status:ConfigItemStatus.read(2),
                                txnTimestamp:new Date().toTimestamp(),user:user,branch:branch,txnCode:intTxnTmp.code,acctNo:fd.acctNo,
                                txnAmt:fd.currentRollover.normalInterestAmt,txnRef:"int",depAcct:fd,txnDate:currentDate, txnTemplate:intTxnTmp,
                                txnDescription:intTxnTmp.description)
                        def acctLedger1 = new TxnDepositAcctLedger(txnType:intTxnTmp.txnType,user:user,branch:branch,currency:fd.product.currency,
                                status:fd.status,txnDate:currentDate,acct:fd,acctNo:fd.acctNo,creditAmt:fd.currentRollover.normalInterestAmt,
                                bal:fd.ledgerBalAmt+fd.currentRollover.normalInterestAmt,txnRef:"FD Rollover Int "+fd.currentRollover.id,debitAmt:0,
                                txnFile:txnFile1, txnCode:txnFile1.txnCode)
                         //debit tax
                        def txnFile2 = new TxnFile(txnParticulars:"Tax debit",currency:fd.product.currency,txnType:taxTxnTmp.txnType,status:ConfigItemStatus.read(2),
                                txnTimestamp:new Date().toTimestamp(),user:user,branch:branch,txnCode:taxTxnTmp.code,acctNo:fd.acctNo,
                                txnAmt:fd.currentRollover.taxAmt1,txnRef:"tax",depAcct:fd,txnDate:currentDate, txnTemplate:taxTxnTmp,
                                txnDescription:taxTxnTmp.description)                        
                        def acctLedger2 = new TxnDepositAcctLedger(txnType:taxTxnTmp.txnType,user:user,branch:branch,currency:fd.product.currency,
                                status:fd.status,txnDate:currentDate,acct:fd,acctNo:fd.acctNo,debitAmt:fd.currentRollover.taxAmt1,
                                bal:fd.ledgerBalAmt+fd.currentRollover.normalInterestAmt-fd.currentRollover.taxAmt1,
                                txnRef:"FD Rollover Tax "+fd.currentRollover.id, creditAmt:0,
                                txnFile:txnFile2, txnCode:txnFile2.txnCode)
                        // transfer debit of interest    
                        def ft = TxnTemplate.get(Institution.findByParamCode('DEP.40121').paramValue.toInteger())    
                        def txnFile4 = new TxnFile(txnParticulars:"Int Tr debit",currency:fd.product.currency,txnType:ft.txnType,
                                status:ConfigItemStatus.read(2),
                                txnTimestamp:new Date().toTimestamp(),user:user,branch:branch,txnCode:ft.code,acctNo:fd.acctNo,
                                txnAmt:fd.currentRollover.normalInterestAmt - fd.currentRollover.taxAmt1,txnRef:"Transfer Int ",
                                depAcct:fd,txnDate:currentDate, txnTemplate:ft,
                                txnDescription:taxTxnTmp.description)                        
                        def acctLedger4 = new TxnDepositAcctLedger(txnType:ft.txnType,user:user,branch:branch,currency:fd.product.currency,
                                status:fd.status,txnDate:currentDate,acct:fd,acctNo:fd.acctNo,
                                debitAmt:fd.currentRollover.normalInterestAmt - fd.currentRollover.taxAmt1,
                                bal:fd.ledgerBalAmt,txnRef:"Int Tr debit", creditAmt:0,
                                txnFile:txnFile4, txnCode:txnFile2.txnCode)
                            
                        txnFile1.save(failOnError:true,flush:true,validate:false)
                        acctLedger1.save(failOnError:true,flush:true,validate:false)
                        txnFile2.save(failOnError:true,flush:true,validate:false)
                        acctLedger2.save(failOnError:true,flush:true,validate:false)
                        txnFile4.save(failOnError:true,flush:true,validate:false)
                        acctLedger4.save(failOnError:true,flush:true,validate:false)
                        
                        GlTransactionService.saveTxnBreakdown(txnFile1.id)
                        GlTransactionService.saveTxnBreakdown(txnFile2.id) 
                        GlTransactionService.saveTxnBreakdown(txnFile4.id) 
                        //credit to account
                        fd.currentRollover.fundedDeposit.attach()
                        fd.currentRollover.fundedDeposit.ledgerBalAmt+=(fd.currentRollover.normalInterestAmt-fd.currentRollover.taxAmt1)
                        fd.currentRollover.fundedDeposit.availableBalAmt+=(fd.currentRollover.normalInterestAmt-fd.currentRollover.taxAmt1)
                        //fd.currentRollover.fundedDeposit.interestBalAmt+=amount
                        def txnFile3 = new TxnFile(txnParticulars:"Interest Credit from FD "+fd.acctNo,currency:fd.product.currency,txnType:intTxnTmp.txnType,
                                status:ConfigItemStatus.read(2),txnTimestamp:new Date().toTimestamp(),user:user,branch:branch,txnCode:intTxnTmp.code,
                                acctNo:fd.currentRollover.fundedDeposit.acctNo,txnAmt:fd.currentRollover.normalInterestAmt-fd.currentRollover.taxAmt1,
                                txnRef:fd.acctNo,depAcct:fd.currentRollover.fundedDeposit,txnDate:currentDate, txnTemplate:intTxnTmp,
                                txnDescription:"Interest Credit from FD")
                        def acctLedger3 = new TxnDepositAcctLedger(txnType:intTxnTmp.txnType,user:user,branch:branch,currency:fd.product.currency,
                                status:fd.currentRollover.fundedDeposit.status,txnDate:currentDate,acct:fd.currentRollover.fundedDeposit,
                                acctNo:fd.currentRollover.fundedDeposit.acctNo, creditAmt:fd.currentRollover.normalInterestAmt-fd.currentRollover.taxAmt1,
                                bal:fd.currentRollover.fundedDeposit.ledgerBalAmt, txnRef:"int from FD "+fd.acctNo, txnFile:txnFile3, 
                                txnCode:txnFile3.txnCode)
     
                        txnFile3.save(failOnError:true,flush:true,validate:false)
                        acctLedger3.save(failOnError:true,flush:true,validate:false)
                        GlTransactionService.saveTxnBreakdown(txnFile3.id)  
                        def nextDate = depositService.getNextDate(fd.currentRollover.endDate,currentDate,fd.maturityDate)
                        fd.currentRollover.fundedDeposit.save(failOnError:true,flush:true,validate:false)  
                        fd.currentRollover.endDate = currentDate
                        fd.currentRollover.status = RolloverStatus.get(2)                    
                        fd.currentRollover.fundedDeposit.save(flush:true, failOnError:true)
                        fd.currentRollover.save(failOnError:true, flush:true)
                        fd.save(flush:true, failOnError:true)
                                              
                        def oldRollover = fd.currentRollover
                        def rolloverInstance = new Rollover(
                              principalAmt:fd.ledgerBalAmt,
                              type:fd.currentRollover.type,deposit:fd,
                              ctd:fd.currentRollover.ctd,
                              startDate:currentDate,
                              endDate:( (fd.depositInterestScheme.fdMonthlyTransfer == true) ? nextDate : currentDate.plus(fd.fixedDepositTermScheme.value.toInteger()) ) ,
                              status:RolloverStatus.get(1),
                              interestPaymentMode:fd.currentRollover.interestPaymentMode,
                              fundedDeposit:fd.currentRollover.fundedDeposit,
                              postMaturityInterestRate:fd.currentRollover.postMaturityInterestRate,
                              normalInterestAmt:0, preTermInterestAmt:0, 
                              taxAmt1:0, taxAmt2:0
                        )                        
                        
                        fd.addToRollovers(rolloverInstance).save(flush: true)
                        fd.currentRollover = rolloverInstance                
                        fd.acrintAmt = 0.00
                        if (fd.maturityDate <= currentDate) {
                            fd.maturityDate = currentDate.plus(fd.fixedDepositTermScheme.value.toInteger())
                        }                        
                        fd.save(flush:true)
                        
                        def daily = new DailyTimeDepositRollover(processDate:currentDate,
                            oldRollover:oldRollover, newRollover:rolloverInstance,
                            interest:acctLedger1, tax:acctLedger2, transferDepositDr:acctLedger4,
                            transferDepositCr:acctLedger3)
                        daily.save(flush:true)
                                                
                    }
                    //net
                    //fd.acrintAmt = 0.00
                    fd.interestBalAmt = 0.00
                    fd.acrintDate = currentDate
                    fd.save(flush:true)  
                }
                if(fd.currentRollover.type.id==3){
                    //P+I rollover
                    if(fd.currentRollover.interestPaymentMode.id==3){
                        def tax = fd.currentRollover.taxAmt1
                        def oldBal = fd.ledgerBalAmt
                        fd.grossRolloverInterestAmt = fd.currentRollover.normalInterestAmt
                        fd.netRolloverInterestAmt = fd.currentRollover.normalInterestAmt - tax
                        //fd.currentRollover.normalInterestAmt = fd.acrintAmt
                        fd.ledgerBalAmt += (fd.currentRollover.normalInterestAmt - fd.currentRollover.taxAmt1)
                        fd.availableBalAmt += (fd.currentRollover.normalInterestAmt - fd.currentRollover.taxAmt1)
                        def intTxnTmp = TxnTemplate.get(intTxn)
                        def taxTxnTmp = TxnTemplate.get(taxTxn)
                        fd.product.attach()
                        //credit interest
                        def txnFile1 = new TxnFile(txnParticulars:"Interest Credit",currency:fd.product.currency,txnType:intTxnTmp.txnType,status:ConfigItemStatus.read(2),
                                txnTimestamp:new Date().toTimestamp(),user:user,branch:branch,txnCode:intTxnTmp.code,acctNo:fd.acctNo,
                                txnAmt:fd.grossRolloverInterestAmt,txnRef:"FD Rollover Interest "+fd.currentRollover.id,
                                depAcct:fd,txnDate:currentDate, txnTemplate:intTxnTmp, txnDescription:intTxnTmp.description)
                        def acctLedger1 = new TxnDepositAcctLedger(txnType:intTxnTmp.txnType,user:user,branch:branch,currency:fd.product.currency,
                                status:fd.status,txnDate:currentDate,acct:fd,acctNo:fd.acctNo,creditAmt:fd.currentRollover.normalInterestAmt,
                                bal:oldBal+fd.currentRollover.normalInterestAmt,txnRef:"FD Rollover Interest "+fd.currentRollover.id,
                                txnFile:txnFile1, txnCode:txnFile1.txnCode)
                         //debit tax
                        def txnFile2 = new TxnFile(txnParticulars:"Tax debit",currency:fd.product.currency,txnType:taxTxnTmp.txnType,status:ConfigItemStatus.read(2),
                                txnTimestamp:new Date().toTimestamp(),user:user,branch:branch,txnCode:taxTxnTmp.code,acctNo:fd.acctNo,
                                txnAmt:fd.currentRollover.taxAmt1,txnRef:"tax",depAcct:fd,txnDate:currentDate, txnTemplate:taxTxnTmp,
                                txnDescription:taxTxnTmp.description)                        
                        def acctLedger2 = new TxnDepositAcctLedger(txnType:taxTxnTmp.txnType,user:user,branch:branch,currency:fd.product.currency,
                                status:fd.status,txnDate:currentDate,acct:fd,acctNo:fd.acctNo,debitAmt:fd.currentRollover.taxAmt1,
                                bal:oldBal+(fd.currentRollover.normalInterestAmt-fd.currentRollover.taxAmt1),
                                txnRef:"FD Rollover Tax "+fd.currentRollover.id, txnFile:txnFile2, txnCode:txnFile2.txnCode)
                        txnFile1.save(failOnError:true,flush:true,validate:false)
                        acctLedger1.save(failOnError:true,flush:true,validate:false)
                        txnFile2.save(failOnError:true,flush:true,validate:false)
                        acctLedger2.save(failOnError:true,flush:true,validate:false)
                        
                        GlTransactionService.saveTxnBreakdown(txnFile1.id)
                        GlTransactionService.saveTxnBreakdown(txnFile2.id) 
                        
                        fd.currentRollover.endDate = currentDate
                        fd.currentRollover.status = RolloverStatus.get(2)
                        fd.currentRollover.save(failOnError:true, flush:true)
                        def oldRollover = fd.currentRollover
                        def rolloverInstance = new Rollover(
                            principalAmt:fd.ledgerBalAmt,
                            type:fd.currentRollover.type,deposit:fd,
                            ctd:fd.currentRollover.ctd,
                            startDate:currentDate,
                            endDate:currentDate.plus(fd.fixedDepositTermScheme.value.toInteger()),
                            status:RolloverStatus.get(1),
                            interestPaymentMode:fd.currentRollover.interestPaymentMode,
                            fundedDeposit:fd.currentRollover.fundedDeposit,
                            postMaturityInterestRate:fd.currentRollover.postMaturityInterestRate,
                            normalInterestAmt:0, preTermInterestAmt:0, 
                            taxAmt1:0, taxAmt2:0
                        )      
                        fd.addToRollovers(rolloverInstance).save(flush: true)
                        fd.currentRollover = rolloverInstance                                      
                        fd.acrintAmt = 0.00
                        fd.interestBalAmt = 0.00
                        fd.acrintDate = currentDate
                        fd.save(flush:true)  
                        
                        def daily = new DailyTimeDepositRollover(processDate:currentDate,
                            oldRollover:oldRollover, newRollover:rolloverInstance,
                            interest:acctLedger1, tax:acctLedger2)
                        daily.save(flush:true)
                    }
                   
                }
            }
        }
    }
    // charging of other fees during EOM codes
    private depositFeesProcessing(Date currentDate,Branch branch, UserMaster user){
        println currentDate
        def dl
        def monthlySaChg = Institution.findByParamCode('GEN.10242').paramValue.toInteger()
        def dormantChgTxn = Institution.findByParamCode('DEP.40120').paramValue.toInteger()
        def txn
        def legder
        Double chgAmt = 0.00D
        def chargeOnlyBelowAdb = Institution.findByParamCode('GEN.10246').paramValue
        if (monthlySaChg > 0) {
            def chgSa = DepositTaxFeeAndChargeScheme.get(monthlySaChg)
            def dOld
            dl = Deposit.findAllByTypeAndBranch(DepositType.get(1),branch)
            for (d in dl) {
                if (d.status.id == 1 || d.status.id == 7 || d.status.id == 8) {
                    continue
                }
                if (d.lmAveBalAmt < d.product.depositChargeStart || d.status.id == 5) {
                    if (d.status.id == 5 && chargeOnlyBelowAdb == 'TRUE') {
                        continue
                    }
                    if (d.ledgerBalAmt > chgSa.chargeAmt) {
                        chgAmt = chgSa.chargeAmt
                    } else {
                        chgAmt = d.ledgerBalAmt
                    }
                    if (d.status.id != 5) {
                        // check previous month ADB
                        Calendar cal = Calendar.getInstance();
                        cal.setTime(d.branch.runDate)
                        cal.add(Calendar.MONTH, -1);
                        cal.set(Calendar.DATE, 1);
                        Date firstDateOfPreviousMonth = cal.getTime();
                        cal.set(Calendar.DATE, cal.getActualMaximum(Calendar.DATE)); // changed calendar to cal
                        Date lastDateOfPreviousMonth = cal.getTime()  
                        def yy = lastDateOfPreviousMonth.format('yyyy')
                        def mm = new SimpleDateFormat("MM").format(lastDateOfPreviousMonth)
                        println 'Last EOM Date Check ----------'
                        println lastDateOfPreviousMonth
                        println yy
                        println mm
                        dOld = MonthlyBalance.findByRefMonthAndRefYearAndAccountNo(mm,yy,d.acctNo)
                        if (dOld) {
                            if (dOld.averageBal > d.product.depositChargeStart) {
                                chgAmt = 0
                            }
                        } else {
                            chgAmt = 0
                        }
                    }
                    println 'Charges >>>>>>>>'
                    println d.acctNo
                    println chgAmt
                    println d.lmAveBalAmt
                    if (chgAmt > 0) {
                        // apply charges
                        // update txnFile
                        txn = new TxnFile(acctNo:d.acctNo, branch:d.branch, currency:d.product.currency, depAcct:d,
                            status:ConfigItemStatus.get(2), txnAmt:chgAmt, txnCode:TxnTemplate.get(dormantChgTxn).code,
                            txnDate:currentDate, txnDescription:'SA Below ADB Charge', txnParticulars:'SA Below ADB Charge',
                            txnRef:currentDate.toString() + ' - ADB Chg', timeStamp:new Date().toTimestamp(),
                            txnType:TxnTemplate.get(dormantChgTxn).txnType, txnTemplate:TxnTemplate.get(dormantChgTxn),
                            user:user)
                        txn.save(flush:true, failOnError:true)
                    
                        // update ledger
                        def ledger = new TxnDepositAcctLedger(acctId:d, acctNo:d.acctNo, bal:d.ledgerBalAmt - chgAmt,
                            branch:d.branch, debitAmt:chgAmt, currency:d.product.currency, status:d.status,
                            txnDate:currentDate, txnFile:txn, user:user, txnRef:currentDate.toString() + ' - ADB Chg', 
                            txnType:txn.txnType)
                        ledger.save(flush:true, failOnError:true)
                    
                        // update deposit
                        d.availableBalAmt -= chgAmt
                        d.ledgerBalAmt -= chgAmt
                        if (d.availableBalAmt <= 0.00d) {
                            d.availableBalAmt = 0.00d
                        }
                        d.save(flush:true, failOnError:true)
                        
                        def monthlyCharge = new MonthlyDepositCharges(refDate:currentDate, deposit:d,
                            charges:txn, chargeType:2)
                        monthlyCharge.save(flush:true)
                        //create entry for glTxnBreakdown
                        GlTransactionService.saveTxnBreakdown(txn.id)
                    }
                }
            }
        }
        def monthlyCaChg = Institution.findByParamCode('GEN.10243').paramValue.toInteger()
        if (monthlyCaChg > 0) {
            def chgCa = DepositTaxFeeAndChargeScheme.get(monthlyCaChg)
            dl = Deposit.findAllByTypeAndBranch(DepositType.get(2),branch)
            for (d in dl) {
                if (d.lmAveBalAmt < d.product.depositChargeStart || d.status.id == 5) {
                    if (d.status.id == 5 && chargeOnlyBelowAdb == 'TRUE') {
                        continue
                    }                    
                    if (d.ledgerBalAmt > chgCa.chargeAmt) {
                        chgAmt = chgCa.chargeAmt
                    } else {
                        chgAmt = d.ledgerBalAmt
                    }
                    println 'Charges >>>>>>>>'
                    println d.acctNo
                    println chgAmt
                    println d.lmAveBalAmt
                    if (chgAmt > 0) {
                        // apply charges
                        // update txnFile
                        txn = new TxnFile(acctNo:d.acctNo, branch:d.branch, currency:d.product.currency, depAcct:d,
                            status:ConfigItemStatus.get(2), txnAmt:chgAmt, txnCode:TxnTemplate.get(dormantChgTxn).code,
                            txnDate:currentDate, txnDescription:'CA Below ADB Charge', txnParticulars:'CA Below ADB Charge',
                            txnRef:currentDate.toString() + ' - ADB Chg', timeStamp:new Date().toTimestamp(),
                            txnType:TxnTemplate.get(dormantChgTxn).txnType, txnTemplate:TxnTemplate.get(dormantChgTxn),
                            user:user)
                        txn.save(flush:true, failOnError:true)
                    
                        // update ledger
                        def ledger = new TxnDepositAcctLedger(acctId:d, acctNo:d.acctNo, bal:d.ledgerBalAmt - chgAmt,
                            branch:d.branch, debitAmt:chgAmt, currency:d.product.currency, status:d.status,
                            txnDate:currentDate, txnFile:txn, user:user, 
                            txnRef:currentDate.toString() + ' - ADB Chg', txnType:txn.txnType)
                        ledger.save(flush:true, failOnError:true)
                    
                        // update deposit
                        d.availableBalAmt -= chgAmt
                        d.ledgerBalAmt -= chgAmt
                        if (d.availableBalAmt <= 0.00d) {
                            d.availableBalAmt = 0.00d
                        }
                        d.save(flush:true, failOnError:true)
                        
                        def monthlyCharge = new MonthlyDepositCharges(refDate:currentDate, deposit:d,
                            charges:txn, chargeType:2)
                        monthlyCharge.save(flush:true)                    
                        //create entry for glTxnBreakdown
                        GlTransactionService.saveTxnBreakdown(txn.id)
                        
                    }
                }
            }            
        }        
    }
    
    // for updating of Deposit Last Transaction Date 
    private def PeriodicOpsUpdateDepositLastTxnDate (Date currentDate){
       	def tf = txnFile.findAll("from txn_file where txn_type in ( '3','4','5','6') and txn_Date=?",[currentDate])
	for (txnFile in tf)
	{
		def depositInstance = deposit.get(tf.depAcctId)
		depositInstance.lastTxnDate = runDate
		depositInstance.save(flush:TRUE)
	}
    }   
    private def monthlyBalanceUpdate(Date currentDate,Branch branch){
        def depositList = Deposit.createCriteria().list{
            and{
                ne("status",DepositStatus.read(1))
                ne("status",DepositStatus.read(8))
                eq("branch",branch)
            }
        }
        for(deposit in depositList){
            def monthlyBalanceInstance = new MonthlyBalance(accountNo:deposit.acctNo,
                refYear:currentDate.format('yyyy'),
                refMonth:new SimpleDateFormat("MM").format(currentDate),
                refDate:currentDate,
                accountStatus:deposit.status.id,
                accruedInterestCumulative:deposit.accruedIntPayable,
                accruedInterestThisMonth:deposit.accruedIntForTheMonth,
                appType:deposit.product.productType.id,
                averageBal:deposit.lmAveBalAmt,
                branch:deposit.branch,
                grossInterestCapital:deposit.lastInterestPosted,
                currency:deposit.product.currency,
                availableBal:deposit.availableBalAmt,
                closingBal:deposit.ledgerBalAmt,
                holdBal:deposit.holdBalAmt,
                lastTxnDate:deposit.lastTxnDate,
                // get from deposit.taxWithhled (new column)
                taxWithheld:deposit.taxWithheld
                //taxWithheld:0.00
            )
            monthlyBalanceInstance.save(validate:false)  
            
            // for fd, update interest balance and tax
            Double acrint
            if (deposit.product.productType.id == 3){
                deposit.interestBalAmt = deposit.acrintAmt
                deposit.save(flush:true)
            }
            
        }
        
    }
    def rolloverStatusUpdate(Date currentDate) {
         def rl = Rollover.createCriteria().list{
            and{
                eq("status",RolloverStatus.read(2))
                gt("endDate",currentDate)
            }
        }
        for(roll in rl){  
            roll.status = RolloverStatus.get(1)
            roll.save(flush:true)                
            println '-------------------------------------------------------'
            println roll.status
            println '-------------------------------------------------------'
        } 
    }
    
    private def dailyBalanceUpdate(Date currentDate,Branch branch){
         def depositList = Deposit.createCriteria().list{
            and{
                // eq("status",DepositStatus.read(2))
                eq("branch",branch)
            }
        }
        for(deposit in depositList){
            println 'daily balance >>>' + deposit
            def dailyBalanceInstance = new DailyBalance(accountNo:deposit.acctNo,
                refDate:currentDate,
                branch:branch,
                accountStatus:1,
                currency:icbs.admin.Currency.get(1),
                availableBal:deposit.availableBalAmt,
                closingBal:deposit.ledgerBalAmt,
                holdBal:deposit.holdBalAmt,
                refYear:currentDate.format('yyyy'),
                refMonth:new SimpleDateFormat("MM").format(currentDate),
                )
            dailyBalanceInstance.save(flush:true, validate:false)
            sessionFactory.currentSession.clear()
        }
        println 'finished!!! Daily Balance'
    }
    private def timeDepositDailyInterestCalculation(Date currentDate, Branch branch){
        def db = new Sql(dataSource)
        def sqlstmt  = "select id from deposit where type_id=3 and status_id in (1,2,3,4) and branch_id="+branch.id
        def fdList = db.rows(sqlstmt) 
        /*
         def fdList = Deposit.createCriteria().list{
            and{
                eq("type",DepositType.read(3))
                'in'("status",[DepositStatus.read(1),DepositStatus.read(2)])
                eq("branch",branch)
                lt("dateOpened",currentDate)
            }
        }
        */
        def duration_days
        def fd_term
        def interestAmt
        def preTermIntAmt
        def preTermTax
        def normalTax
        def fdTax
        def fdRoll
        def ptScheme
        def fd
        Integer i = 0
        
        for(f in fdList){
            fd = Deposit.get(f.id)
            if(!fd.isAttached()) {
                fd.attach()
            }
            fdRoll = fd.currentRollover
            ptScheme = fd.fixedDepositPreTermScheme
            preTermIntAmt = 0
            Date intStartDate
            Double intRate = 0.00
            Double oldIntAmt = 0.00
            /*
            if (fdRoll.startDate > fd.acrintDate){
                intStartDate = fdRoll.startDate
            } else {
                intStartDate = fd.acrintDate
            }
            */
           
            // include correction for rollover status
            if (fdRoll.status.id == 2 && fdRoll.endDate > currentDate) {
                fdRoll.status = RolloverStatus.get(1)
                fdRoll.save(flush:true, failOnError:true)
            } 
            
            //intStartDate = fdRoll.startDate
            intStartDate = fd.acrintDate
            use(TimeCategory){
                duration_days = (currentDate - intStartDate).days
            }
            oldIntAmt = fd.acrintAmt
            if (fdRoll.status.id == 1) {
                intRate = fd.interestRate.div(100)
            } else if (fdRoll.status.id == 2 && fdRoll.endDate < currentDate) {
                // completed
                // use post-maturity rate
                if (!fd.depositInterestScheme.fdPostMaturityRate) {
                    intRate = 0.00d
                } else {
                    intRate = fd.depositInterestScheme.fdPostMaturityRate.div(100)
                }
                use(TimeCategory){
                    duration_days = (currentDate - fdRoll.endDate).days
                }                
            }
            interestAmt = fd.ledgerBalAmt * duration_days * intRate.div(fd.depositInterestScheme.divisor)
            interestAmt = interestAmt.round(2)
            if (fd.currentRollover.interestPaymentMode.id == 1) {
                fd.acrintAmt = interestAmt + fd.grossRolloverInterestAmt
            } else {
                fd.acrintAmt = interestAmt
            }
            
            // no rollover
            if (fd.currentRollover.type.id == 1) {
                fd.acrintAmt = interestAmt + fd.grossRolloverInterestAmt  
            }  
                         
            fd.taxWithheld = fd.acrintAmt * fd.depositTaxChargeScheme.taxRate.div(100)
            fd.taxWithheld = fd.taxWithheld.round(2)
            
            if(!fd.isAttached()) {
                fd.attach()
            }
            fd.depositTaxChargeScheme.attach()
            
            /*println '<----- computation check start ---->'
            println fd.acctNo
            println fd.ledgerBalAmt
            println duration_days
            println intRate
            println fd.depositInterestScheme.divisor
            println interestAmt
            println intStartDate
            println currentDate
            println '<----- computation check end   ---->' */
            
            fd.save(flush:true,failOnError:true)
            i++
            if (i == 50 ){
                i = 1
                cleanUpDepGorm()
            }
            if(!fd.isAttached()) {
                fd.attach()
            }
            fd.fixedDepositPreTermScheme.attach()
            fdRoll = fd.currentRollover
            ptScheme = fd.fixedDepositPreTermScheme
            // time based rate
            
            if (ptScheme.type.id == 3){
                use(TimeCategory){
                    fd_term = (fdRoll.endDate - fdRoll.startDate).days
                }
                if (fd_term.div(2) > duration_days) {
                    preTermIntAmt = fd.ledgerBalAmt * duration_days * (fd.interestRate * ptScheme.term1stHalf.div(100)).div(fd.depositInterestScheme.divisor).div(100)  
                }else{
                    preTermIntAmt = fd.ledgerBalAmt * duration_days * (fd.interestRate * ptScheme.term2ndHalf.div(100)).div(fd.depositInterestScheme.divisor).div(100)                      
                }
                preTermIntAmt = preTermIntAmt.round(2)
            }    
            // savings rate
            if (ptScheme.type.id == 2){
                preTermIntAmt = fd.ledgerBalAmt * duration_days * ptScheme.rate.div(fd.depositInterestScheme.divisor).div(100) 
            }        
            // completed rollover so interest from previous rollover (ACRINT) needs to added for pre-term
            if ((fd.currentRollover.interestPaymentMode.id == 1) && (fd.grossRolloverInterestAmt > 0.00)) {
                // in of interest from previous rollover
                preTermIntAmt +=fd.grossRolloverInterestAmt
            } 
            preTermIntAmt = preTermIntAmt.round(2)
            // compute tax
            fdTax = DepositTaxFeeAndChargeScheme.get(fd.depositTaxChargeScheme.id)
            preTermTax = preTermIntAmt * fdTax.taxRate.div(100)
            preTermTax = preTermTax.round(2)
            normalTax = interestAmt * fdTax.taxRate.div(100)
            normalTax = normalTax.round(2)
            
            if (fdRoll.type.id == 1 && fdRoll.status.id == 2) {
                // matured no rollover
                preTermIntAmt = fd.acrintAmt
                preTermTax = fd.taxWithheld
            }
            if (fdRoll.type.id == 2 && fd.currentRollover.interestPaymentMode.id == 1 && fd.grossRolloverInterestAmt > 0) {
                // matured no rollover
                fdRoll.taxAmt1 = fd.taxWithheld
            } else {
                fdRoll.taxAmt1 = normalTax
            }            
            fdRoll.normalInterestAmt = interestAmt
            fdRoll.preTermInterestAmt = preTermIntAmt
            fdRoll.taxAmt2 = preTermTax
            fdRoll.save(flush:true,failOnError:true)
        }
    }
    def depositInterestPosting(currentDate, Branch branch, UserMaster user){
        Integer i = 0
        def intTxn = Institution.findByParamCode("DEP.40100").paramValue.toInteger()
        def taxTxn = Institution.findByParamCode("DEP.40110").paramValue.toInteger()
        def refMonth = new SimpleDateFormat("MM").format(currentDate)
        String quarters = "03/06/09/12"
        
        def depositList = Deposit.createCriteria().list{
            and{
                //eq("status",DepositStatus.read(2))
                eq("branch",branch)
                'in'("type",[DepositType.read(1),DepositType.read(2)])
            } 
        }
        for (deposit in depositList){
            deposit.depositInterestScheme.attach()
            if(!deposit.isAttached()) {
                deposit.attach()
            }
            // monthly capitalization
            if ((deposit.acrintAmt > 0) && (deposit.depositInterestScheme.depositCapitalizationFreq.id == 1)){
                // post int txn
                def tfInt = new TxnFile()
                tfInt.acctNo = deposit.acctNo
                
                tfInt.branch = deposit.branch
                tfInt.currency = deposit.product.currency
                tfInt.depAcct = deposit
                tfInt.status = ConfigItemStatus.read(2)
                tfInt.txnTimestamp = new Date().toTimestamp()
                tfInt.txnDate = currentDate
                tfInt.txnAmt = deposit.acrintAmt
                tfInt.txnCode = TxnTemplate.get(intTxn).code
                tfInt.txnType = TxnTemplate.get(intTxn).txnType
                tfInt.txnTemplate = TxnTemplate.get(intTxn)
                tfInt.txnDescription = TxnTemplate.get(intTxn).description
                tfInt.txnRef = currentDate.toString() + ' Int Posting'  
                tfInt.user = user
                tfInt.save(flush:true)	
                
                def dlInt = new TxnDepositAcctLedger()
                dlInt.acct = deposit
                dlInt.acctNo = deposit.acctNo
                dlInt.bal = deposit.ledgerBalAmt + deposit.acrintAmt
                dlInt.branch = deposit.branch
                dlInt.creditAmt = deposit.acrintAmt
                dlInt.currency = deposit.product.currency
                dlInt.status = deposit.status
                dlInt.txnDate = currentDate
                dlInt.txnFile = tfInt
                dlInt.txnRef = currentDate.toString() + ' Int Posting'
                dlInt.txnType = TxnTemplate.get(intTxn).txnType
                dlInt.user = user	
                dlInt.save(flush:true)
            
                // post tax txn
                def tfTax = new TxnFile()
                tfTax.acctNo = deposit.acctNo
                tfTax.branch = deposit.branch
                tfTax.currency = deposit.product.currency
                tfTax.depAcct = deposit
                tfTax.status = ConfigItemStatus.read(2)
                tfTax.txnTimestamp = new Date().toTimestamp()
                tfTax.txnDate = currentDate
                tfTax.txnAmt = deposit.acrintAmt * deposit.depositTaxChargeScheme.taxRate.div(100)
                tfTax.txnCode = TxnTemplate.get(taxTxn).code
                tfTax.txnType = TxnTemplate.get(taxTxn).txnType
                tfTax.txnTemplate = TxnTemplate.get(taxTxn)
                tfTax.txnDescription = TxnTemplate.get(taxTxn).description
                tfTax.txnRef = currentDate.toString() + ' Wholding Tax'  
                tfTax.user = user
                tfTax.save(flush:true)	
                
                def dlTax = new TxnDepositAcctLedger()
                dlTax.acct = deposit
                dlTax.acctNo = deposit.acctNo
                dlTax.bal = deposit.ledgerBalAmt + deposit.acrintAmt - (deposit.acrintAmt * deposit.depositTaxChargeScheme.taxRate.div(100))
                dlTax.debitAmt = deposit.acrintAmt * deposit.depositTaxChargeScheme.taxRate.div(100)
                dlTax.currency = deposit.product.currency
                dlTax.status = deposit.status
                dlTax.txnDate = currentDate
                dlTax.txnFile = tfTax
                dlTax.txnRef = currentDate.toString() + ' Wholding Tax'
                dlTax.txnType = TxnTemplate.get(taxTxn).txnType
                dlTax.user = user
                dlTax.branch = branch	
                dlTax.save(flush:true)     
                
                def acrintAmt = deposit.acrintAmt
                // update deposit
                deposit.ledgerBalAmt += deposit.acrintAmt - (deposit.acrintAmt * deposit.depositTaxChargeScheme.taxRate.div(100)) 
                deposit.availableBalAmt += deposit.acrintAmt - (deposit.acrintAmt * deposit.depositTaxChargeScheme.taxRate.div(100))
                // compute and update tax
                deposit.taxWithheld = deposit.acrintAmt * deposit.depositTaxChargeScheme.taxRate.div(100)
                deposit.lastInterestPosted = acrintAmt
                deposit.acrintAmt = 0.00
                deposit.interestBalAmt = 0.00
                deposit.accruedIntPayable = 0.00
                deposit.accruedTaxPayable = 0.00  
                deposit.lastCapitalizationDate = currentDate
                deposit.save(flush:true)
                
                def monthlyInterest = new MonthlyDepositInterest(refDate:currentDate, deposit:deposit, 
                    interest:tfInt, tax:tfTax)
                monthlyInterest.save(flush:true)
                
                GlTransactionService.saveTxnBreakdown(tfInt.id)
                GlTransactionService.saveTxnBreakdown(tfTax.id)
            }  
            // quarterly capitalization
            if ((deposit.acrintAmt > 0) && (deposit.depositInterestScheme.depositCapitalizationFreq.id == 2) && (quarters.indexOf( refMonth ) > 0)){
                // post int txn
                def tfInt = new TxnFile()
                tfInt.acctNo = deposit.acctNo
                tfInt.branch = deposit.branch
                tfInt.currency = deposit.product.currency
                tfInt.depAcct = deposit
                tfInt.status = ConfigItemStatus.read(2)
                tfInt.txnTimestamp = new Date().toTimestamp()
                tfInt.txnDate = currentDate
                tfInt.txnAmt = deposit.acrintAmt
                tfInt.txnCode = TxnTemplate.get(intTxn).code
                tfInt.txnType = TxnTemplate.get(intTxn).txnType
                tfInt.txnDescription = TxnTemplate.get(intTxn).description
                tfInt.txnTemplate = TxnTemplate.get(intTxn)
                tfInt.txnRef = currentDate.toString() + ' Int Posting'  
                tfInt.user = user
                tfInt.save(flush:true)	
                
                def dlInt = new TxnDepositAcctLedger()
                dlInt.acct = deposit
                dlInt.acctNo = deposit.acctNo
                dlInt.bal = deposit.ledgerBalAmt + deposit.acrintAmt
                dlInt.creditAmt = deposit.acrintAmt
                dlInt.currency = deposit.product.currency
                dlInt.status = deposit.status
                dlInt.txnDate = currentDate
                dlInt.txnFile = tfInt
                dlInt.txnRef = currentDate.toString() + ' Int Posting'
                dlInt.txnType = TxnTemplate.get(intTxn).txnType
                dlInt.user = user
                dlInt.branch = branch	
                dlInt.save(flush:true)
            
                // post tax txn
                def tfTax = new TxnFile()
                tfTax.acctNo = deposit.acctNo
                tfTax.branch = deposit.branch
                tfTax.currency = deposit.product.currency
                tfTax.depAcct = deposit
                tfTax.status = ConfigItemStatus.read(2)
                tfTax.txnTimestamp = new Date().toTimestamp()
                tfTax.txnDate = currentDate
                tfTax.txnAmt = deposit.acrintAmt * deposit.depositTaxChargeScheme.taxRate.div(100)
                tfTax.txnCode = TxnTemplate.get(taxTxn).code
                tfTax.txnType = TxnTemplate.get(taxTxn).txnType
                tfTax.txnDescription = TxnTemplate.get(taxTxn).description
                tfTax.txnTemplate = TxnTemplate.get(taxTxn)
                tfTax.txnRef = currentDate.toString() + ' Wholding Tax'  
                tfTax.user = user
                tfTax.branch = branch
                tfTax.save(flush:true)	
                
                def dlTax = new TxnDepositAcctLedger()
                dlTax.acct = deposit
                dlTax.acctNo = deposit.acctNo
                dlTax.bal = deposit.ledgerBalAmt + deposit.acrintAmt - (deposit.acrintAmt * deposit.depositTaxChargeScheme.taxRate.div(100))
                dlTax.debitAmt = deposit.acrintAmt * deposit.depositTaxChargeScheme.taxRate.div(100)
                dlTax.currency = deposit.product.currency
                dlTax.status = deposit.status
                dlTax.txnDate = currentDate
                dlTax.txnFile = tfTax
                dlTax.txnRef = currentDate.toString() + ' Wholding Tax'
                dlTax.txnType = TxnTemplate.get(taxTxn).txnType
                dlTax.user = user
                dlTax.branch = branch	
                dlTax.save(flush:true)     
                
                // update GL first for accruals before updating deposit account
                GlTransactionService.saveTxnBreakdown(tfInt.id)
                GlTransactionService.saveTxnBreakdown(tfTax.id)                
                def acrintAmt = deposit.acrintAmt
                // update deposit
                deposit.ledgerBalAmt += deposit.acrintAmt - (deposit.acrintAmt * deposit.depositTaxChargeScheme.taxRate.div(100)) 
                deposit.availableBalAmt += deposit.acrintAmt - (deposit.acrintAmt * deposit.depositTaxChargeScheme.taxRate.div(100))
                // compute and update tax
                deposit.taxWithheld = deposit.acrintAmt * deposit.depositTaxChargeScheme.taxRate.div(100)
                deposit.acrintAmt = 0.00
                deposit.lastInterestPosted = acrintAmt
                deposit.interestBalAmt = 0.00
                deposit.accruedIntPayable = 0.00
                deposit.accruedTaxPayable = 0.00 
                deposit.lastCapitalizationDate = currentDate
                deposit.save(flush:true)
                
                def monthlyInterest = new MonthlyDepositInterest(refDate:currentDate, deposit:deposit, 
                    interest:tfInt, tax:tfTax)
                monthlyInterest.save(flush:true)
            }              
            i++
            if (i == 50 ){
                i = 1
                cleanUpDepGorm()
            }                
        }
    }
    
    private def depositInterestCalculation(Date currentDate,Branch branch){
        
        def first_day_of_month = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(currentDate.format('yyyy') + "-" + (new Integer (new SimpleDateFormat("MM").format(currentDate)))+"-01"));
        def last_day_of_month = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(currentDate.format('yyyy') + "-" + (new Integer (new SimpleDateFormat("MM").format(currentDate))+1) + "-01")-1);
        def dailyDepBalance
        def refYear =  currentDate.format('yyyy')
        def refMonth = new SimpleDateFormat("MM").format(currentDate)
        Double interestRate
        Integer days
        Double averageBal
        Double divisor
        Double interestBalAmt
        //println first_day_of_month
        //println last_day_of_month
         def depositList = Deposit.createCriteria().list{
            and{
                //eq("status",DepositStatus.read(2))
                eq("branch",branch)
                'in'("type",[DepositType.read(1),DepositType.read(2)])
                'in'("status",[DepositStatus.read(2),DepositStatus.read(3),DepositStatus.read(4),DepositStatus.read(5),DepositStatus.read(6)])
            }
        }
        for(deposit in depositList){ 
            def result = DailyBalance.executeQuery("select sum(availableBal + holdBal),count(*) as days from DailyBalance where accountNo = ? and DATE(ref_date) >= DATE(?) and DATE(ref_date) <= Date(?)", [deposit.acctNo,first_day_of_month,last_day_of_month])
            println 'EOM Check ---------------------------------------------'
            println result
            println deposit.acctNo
            println first_day_of_month
            println last_day_of_month
            println '-------------------------------------------------------'
            days = result[0][1]
            averageBal = 0.00D
            if (result[0][0] != null) {
                averageBal = result[0][0].div(days)
            }
            deposit.lmAveBalAmt = averageBal
            deposit.lmAveBalAmt =deposit.lmAveBalAmt.round(2)
            
            //Average Daily Balance
            if(deposit.depositInterestScheme.depositInterestCalculation.id ==1 ){
                interestRate = deposit.interestRate.div(100)
                divisor = deposit.depositInterestScheme.divisor
                if (averageBal <= deposit.depositInterestScheme.minBalanceToEarnInterest) {
                   interestRate = 0.00D 
                }
                interestBalAmt = (averageBal*days).div(divisor)*interestRate
                interestBalAmt = interestBalAmt.round(2)
                //deposit.ledgerBalAmt = deposit.ledgerBalAmt +interestBalAmt
                //deposit.availableBalAmt = deposit.availableBalAmt +interestBalAmt
                if (deposit.status.id == 5 && !deposit.product.hasDepositDormancyInterest){
                    interestBalAmt = 0.00D
                }
                // check for AIP rule
                if (Institution.findByParamCode('DEP.40130').paramValue == 'TRUE') {
                    deposit.accruedIntForTheMonth = interestBalAmt.round(2)
                    deposit.accruedIntPayable += interestBalAmt.round(2)           
                    deposit.accruedTaxForTheMonth =  interestBalAmt.round(2) * deposit.depositTaxChargeScheme.taxRate.div(100)
                    deposit.accruedTaxForTheMonth = deposit.accruedTaxForTheMonth.round(2)
                    deposit.accruedTaxPayable += (interestBalAmt.round(2) * deposit.depositTaxChargeScheme.taxRate.div(100)) 
                    deposit.accruedTaxPayable = deposit.accruedTaxPayable.round(2)                    
                }
                deposit.interestBalAmt = deposit.acrintAmt
                deposit.acrintAmt += interestBalAmt
                deposit.acrintDate = currentDate
                deposit.save(flush:true)
            }
            //actual
            if(deposit.depositInterestScheme.depositInterestCalculation.id ==2){
                dailyDepBalance = DailyBalance.createCriteria().list{
                    and{
                            eq("accountNo",deposit.acctNo)
                            eq("refMonth",refMonth)
                            eq("refYear",refYear)
                        }
                }        
                interestRate = deposit.interestRate.div(100)
                println("interestRate: "+interestRate)
                divisor = deposit.depositInterestScheme.divisor
                println("divisor: "+divisor)
                interestBalAmt = 0.00
                for (db in dailyDepBalance){
                    if ((db.availableBal + db.holdBal) <= deposit.depositInterestScheme.minBalanceToEarnInterest) {
                        interestRate = 0.00D
	
                    }
                     println("loop values: ******************************")
                     println("db.availableBal.round(2): "+db.availableBal.round(2))
                     println("db.holdBal.round(2): "+db.holdBal.round(2))
                     interestBalAmt += (db.availableBal.round(2) + db.holdBal.round(2)).div(divisor)*interestRate
                     println("interestBalAmt: "+interestBalAmt.round(2))
                     interestBalAmt = interestBalAmt
                     interestRate = deposit.interestRate.div(100)
                     println("loop values: ******************************")
                }        
                 interestBalAmt = interestBalAmt.round(2)
                //deposit.ledgerBalAmt = deposit.ledgerBalAmt +interestBalAmt
                //deposit.availableBalAmt = deposit.availableBalAmt +interestBalAmt
                if (deposit.status.id == 5 && !deposit.product.hasDepositDormancyInterest){
                    interestBalAmt = 0.00D
                }                

                deposit.interestBalAmt = deposit.acrintAmt.round(2)
                deposit.acrintAmt += interestBalAmt.round(2)
                deposit.acrintDate = currentDate
                
                // check for AIP rule
                if (Institution.findByParamCode('DEP.40130').paramValue == 'TRUE') {
                    deposit.accruedIntForTheMonth = interestBalAmt.round(2)
                    deposit.accruedIntPayable += interestBalAmt.round(2)           
                    deposit.accruedTaxForTheMonth =  interestBalAmt.round(2) * deposit.depositTaxChargeScheme.taxRate.div(100)
                    deposit.accruedTaxForTheMonth = deposit.accruedTaxForTheMonth.round(2)
                    deposit.accruedTaxPayable += (interestBalAmt.round(2) * deposit.depositTaxChargeScheme.taxRate.div(100)) 
                    deposit.accruedTaxPayable = deposit.accruedTaxPayable.round(2)                    
                }
                deposit.save(flush:true)
            }
            //minimum monthly
             if(deposit.depositInterestScheme.depositInterestCalculation.id ==3){
                result = DailyBalance.executeQuery("select min(availableBal + holdBal),count(*) as days from DailyBalance where accountNo = ? and DATE(ref_date) >= DATE(?) and DATE(ref_date) < Date(?)", [deposit.acctNo,first_day_of_month,last_day_of_month])
                println result
                interestRate = deposit.interestRate.div(100)
                days = result[0][1]
                averageBal = result[0][0].div(days)
                divisor = deposit.depositInterestScheme.divisor
                interestBalAmt = (averageBal*days).div(divisor)*interestRate
                interestBalAmt = interestBalAmt.round(2)
                if (deposit.status.id == 5 && !deposit.product.hasDepositDormancyInterest){
                    interestBalAmt = 0.00D
                }
                //deposit.ledgerBalAmt = deposit.ledgerBalAmt +interestBalAmt
                //deposit.availableBalAmt = deposit.availableBalAmt +interestBalAmt
                // check for AIP rule
                if (Institution.findByParamCode('DEP.40130').paramValue == 'TRUE') {
                    deposit.accruedIntForTheMonth = interestBalAmt.round(2)
                    deposit.accruedIntPayable += interestBalAmt.round(2)           
                    deposit.accruedTaxForTheMonth =  interestBalAmt.round(2) * deposit.depositTaxChargeScheme.taxRate.div(100)
                    deposit.accruedTaxForTheMonth = deposit.accruedTaxForTheMonth.round(2)
                    deposit.accruedTaxPayable += (interestBalAmt.round(2) * deposit.depositTaxChargeScheme.taxRate.div(100)) 
                    deposit.accruedTaxPayable = deposit.accruedTaxPayable.round(2)                    
                }
                deposit.interestBalAmt = deposit.acrintAmt
                deposit.acrintAmt += interestBalAmt
                deposit.acrintDate = currentDate
                deposit.save(flush:true)
                
            }
            //minimum quarterly
            /*if(deposit.depositInterestScheme.depositInterestCalculation.id ==4){
                def result = DailyBalance.executeQuery("select min(closingBal),count(*) as days from DailyBalance where accountNo = ? and DATE(ref_date) >= DATE(?) and DATE(ref_date) < Date(?)", [deposit.acctNo,first_day_of_month,last_day_of_month])
                println result
                def interestRate = deposit.interestRate
                def days = result[0][1]
                def averageBal = result[0][0].div(days)
                def divisor = deposit.depositInterestScheme.divisor
                def interestBalAmt = (averageBal*days).div(divisor)*interestRate
                deposit.ledgerBalAmt = deposit.ledgerBalAmt +interestBalAmt
                deposit.availableBalAmt = deposit.availableBalAmt +interestBalAmt
                deposit.interestBalAmt = deposit.ledgerBalAmt
                deposit.save() 
            }*/
        }
    }  
    def depositClosingInterestCalculationandPosting(Deposit deposit, Date currentDate, UserMaster user){
        
        def first_day_of_month = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(currentDate.format('yyyy') + "-" + (new Integer (new SimpleDateFormat("MM").format(currentDate)))+"-01"));
        def last_day_of_month = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(currentDate.format('yyyy') + "-" + (new Integer (new SimpleDateFormat("MM").format(currentDate))+1) + "-01")-1);
        def dailyDepBalance
        def refYear =  currentDate.format('yyyy')
        def refMonth = new SimpleDateFormat("MM").format(currentDate)
        def intTxn = Institution.findByParamCode('DEP.40100').paramValue.toInteger()
        def taxTxn = Institution.findByParamCode('DEP.40110').paramValue.toInteger()
        
        Double interestBalAmt = 0.00
        if (deposit.type.id == 3 && deposit.currentRollover.preTermInterestAmt > 0.00d && deposit.acrintAmt > 0) {
            // interest calculation for FD
                def tfInt = new TxnFile()
                tfInt.acctNo = deposit.acctNo
                //tfInt.acctStatus= deposit.status.id
                tfInt.branch = deposit.branch
                tfInt.currency = deposit.product.currency
                tfInt.depAcct = deposit
                tfInt.status = ConfigItemStatus.read(2)
                tfInt.txnTimestamp = new Date().toTimestamp()
                tfInt.txnDate = currentDate
                tfInt.txnAmt = deposit.currentRollover.preTermInterestAmt
                tfInt.txnCode = TxnTemplate.get(intTxn).code
                tfInt.txnType = TxnTemplate.get(intTxn).txnType
                tfInt.txnDescription = TxnTemplate.get(intTxn).description
                tfInt.txnRef = currentDate.toString() + ' Int Posting'  
                tfInt.txnTemplate = TxnTemplate.get(intTxn)
                tfInt.user = user
                //tfInt.branch = deposit.branch
                
                // matured no rollover
                if (deposit.currentRollover.type.id == 1 && deposit.currentRollover.status.id == 2) {
                    // no rollover after maturity
                    tfInt.txnAmt = deposit.acrintAmt
                }
                tfInt.save(flush:true)	
                
                def dlInt = new TxnDepositAcctLedger()
                dlInt.acct = deposit
                dlInt.acctNo = deposit.acctNo
                dlInt.bal = deposit.ledgerBalAmt + deposit.currentRollover.preTermInterestAmt
                //dlInt.branchId = deposit.ledgerBalAmt.branch
                dlInt.creditAmt = deposit.currentRollover.preTermInterestAmt
                dlInt.currency = deposit.product.currency
                dlInt.status = deposit.status
                dlInt.txnDate = currentDate
                dlInt.txnFile = tfInt
                dlInt.txnRef = currentDate.toString() + ' Int Posting'
                dlInt.txnType = TxnTemplate.get(intTxn).txnType
                dlInt.user = user
                dlInt.branch = deposit.branch
                // matured no rollover
                if (deposit.currentRollover.type.id == 1 && deposit.currentRollover.status.id == 2) {
                    // no rollover after maturity
                    dlInt.creditAmt = deposit.acrintAmt
                }                
                dlInt.save(flush:true)
            
                // post tax txn
                def tfTax = new TxnFile()
                tfTax.acctNo = deposit.acctNo
                //tfTax.acctStatus= deposit.status.id
                tfTax.branch = deposit.branch
                tfTax.currency = deposit.product.currency
                tfTax.depAcct = deposit
                tfTax.status = ConfigItemStatus.read(2)
                tfTax.txnTimestamp = new Date().toTimestamp()
                tfTax.txnDate = currentDate
                tfTax.txnAmt = deposit.currentRollover.taxAmt2
                tfTax.txnCode = TxnTemplate.get(taxTxn).code
                tfTax.txnType = TxnTemplate.get(taxTxn).txnType
                tfTax.txnDescription = TxnTemplate.get(taxTxn).description
                tfTax.txnRef = currentDate.toString() + ' Wholding Tax'  
                tfTax.txnTemplate = TxnTemplate.get(taxTxn)
                tfTax.user = user
                //tfTax.branch = branch
                if (deposit.currentRollover.type.id == 1 && deposit.currentRollover.status.id == 2) {
                    // no rollover after maturity
                    tfTax.txnAmt = deposit.taxWithheld
                }
                tfTax.save(flush:true)	
                
                def dlTax = new TxnDepositAcctLedger()
                dlTax.acct = deposit
                dlTax.acctNo = deposit.acctNo
                dlTax.bal = deposit.ledgerBalAmt + deposit.currentRollover.preTermInterestAmt - deposit.currentRollover.taxAmt2
                //dlTax.branchId = deposit.ledgerBalAmt.branch
                dlTax.debitAmt = deposit.currentRollover.taxAmt2
                dlTax.currency = deposit.product.currency
                dlTax.status = deposit.status
                dlTax.txnDate = currentDate
                dlTax.txnFile = tfTax
                dlTax.txnRef = currentDate.toString() + ' Wholding Tax'
                dlTax.txnType = TxnTemplate.get(taxTxn).txnType
                dlTax.user = user
                dlTax.branch = deposit.branch
                if (deposit.currentRollover.type.id == 1 && deposit.currentRollover.status.id == 2) {
                    // no rollover after maturity
                    dlTax.debitAmt = deposit.taxWithheld
                }                
                dlTax.save(flush:true)     
                
                // update GL first for accruals before updating deposit account
                GlTransactionService.saveTxnBreakdown(tfInt.id)
                GlTransactionService.saveTxnBreakdown(tfTax.id)        
                // update deposit
                if (deposit.currentRollover.type.id == 1 && deposit.currentRollover.status.id == 2) {
                    // no rollover after maturity
                    deposit.ledgerBalAmt += deposit.acrintAmt - deposit.taxWithheld
                    deposit.availableBalAmt += deposit.acrintAmt - deposit.taxWithheld
                } else {               
                    deposit.ledgerBalAmt += deposit.currentRollover.preTermInterestAmt - deposit.currentRollover.taxAmt2
                    deposit.availableBalAmt += deposit.currentRollover.preTermInterestAmt - deposit.currentRollover.taxAmt2
                }
                // compute and update tax
                deposit.taxWithheld = 0.00
                deposit.acrintAmt = 0.00
                deposit.interestBalAmt= 0.00
                deposit.lastCapitalizationDate = currentDate
                deposit.save(flush:true)
            
            return
        }
        
        if (!deposit.interestRate) {
            // check for null interest rate
            return
        }
        println "TESTING! "
        if (deposit.depositInterestScheme.interestOnClosing && (deposit.type.id == 1 || deposit.type.id == 2) ){
            println "INTEREST ID: " + deposit.depositInterestScheme.depositInterestCalculation.id
            if(deposit.depositInterestScheme.depositInterestCalculation.id == 1){
                def result = DailyBalance.executeQuery("select sum(availableBal + holdBal),count(*) as days from DailyBalance where accountNo = ? and DATE(ref_date) >= DATE(?) and DATE(ref_date) < Date(?)", [deposit.acctNo,first_day_of_month,last_day_of_month])
                println result
                def interestRate = deposit.interestRate.div(100)
                def days = result[0][1]
                if (days != 0) {
                    def averageBal = result[0][0].div(days)
                    def divisor = deposit.depositInterestScheme.divisor
                    interestBalAmt = (averageBal*days).div(divisor)*interestRate
                    interestBalAmt = interestBalAmt.round(2)                    
                } else {
                    def averageBal = deposit.availableBal + deposit.holdBal
                    def divisor = deposit.depositInterestScheme.divisor
                    interestBalAmt = (averageBal*days).div(divisor)*interestRate
                    interestBalAmt = interestBalAmt.round(2)                       
                } 
                //deposit.ledgerBalAmt = deposit.ledgerBalAmt +interestBalAmt
                //deposit.availableBalAmt = deposit.availableBalAmt +interestBalAmt
                deposit.lastInterestPosted = deposit.acrintAmt
                deposit.lmAveBalAmt = averageBal
                deposit.lmAveBalAmt = deposit.lmAveBalAmt.round(2)
                //deposit.interestBalAmt = deposit.acrintAmt
                //deposit.interestBalAmt = deposit.interestBalAmt.round(2)
                deposit.acrintAmt += interestBalAmt
                deposit.acrintDate = currentDate
                deposit.save(flush:true)
            }
            //actual
            if(deposit.depositInterestScheme.depositInterestCalculation.id ==2){
                dailyDepBalance = DailyBalance.createCriteria().list{
                    and{
                            eq("accountNo",deposit.acctNo)
                            eq("refMonth",refMonth)
                            eq("refYear",refYear)
                        }
                }        
                def interestRate = deposit.interestRate.div(100)
                def divisor = deposit.depositInterestScheme.divisor
                
                // day 1
                //interestBalAmt += (deposit.availableBalAmt).div(divisor)*interestRate                
                
                for (db in dailyDepBalance){
                     interestBalAmt += (db.availableBal + db.holdBal).div(divisor)*interestRate
                }
                /*
                if (!dailyDepBalance) {
                    // first day of month
                    interestBalAmt += (deposit.availableBalAmt).div(divisor)*interestRate
                }
                */
                if (deposit.availableBalAmt  < deposit.depositInterestScheme.minBalanceToEarnInterest) {
                    // check minimum balance to earn interest
                    interestBalAmt = 0d
                }
                interestBalAmt = interestBalAmt.round(2)
                //deposit.ledgerBalAmt = deposit.ledgerBalAmt +interestBalAmt
                //deposit.availableBalAmt = deposit.availableBalAmt +interestBalAmt
                //deposit.interestBalAmt = deposit.acrintAmt
                //deposit.lastInterestPosted = interestBalAmt
                deposit.acrintAmt += interestBalAmt
                deposit.acrintDate = currentDate
                deposit.save(flush:true)
            }
            //minimum monthly
             if(deposit.depositInterestScheme.depositInterestCalculation.id ==3){
                    def result = DailyBalance.executeQuery("select min(availableBal + holdBal),count(*) as days from DailyBalance where accountNo = ? and DATE(ref_date) >= DATE(?) and DATE(ref_date) < Date(?)", [deposit.acctNo,first_day_of_month,last_day_of_month])
                println result
                def interestRate = deposit.interestRate.div(100)
                def days = result[0][1]
                def averageBal = result[0][0].div(days)
                def divisor = deposit.depositInterestScheme.divisor
                interestBalAmt = (averageBal*days).div(divisor)*interestRate
                interestBalAmt = interestBalAmt.round(2)
                //deposit.ledgerBalAmt = deposit.ledgerBalAmt +interestBalAmt
                //deposit.availableBalAmt = deposit.availableBalAmt +interestBalAmt
                //deposit.interestBalAmt = deposit.acrintAmt
                //deposit.lastInterestPosted = interestBalAmt
                deposit.acrintAmt += interestBalAmt
                deposit.acrintDate = currentDate
                deposit.save(flush:true)
                
            }
            
            // check if any interest then post
            if (deposit.acrintAmt > 0){
                println "TESTING INSERT HERE:"
                // post int txn
                def tfInt = new TxnFile()
                tfInt.acctNo = deposit.acctNo
                //tfInt.acctStatus= deposit.status.id
                tfInt.branch = deposit.branch
                tfInt.currency = deposit.product.currency
                tfInt.depAcct = deposit
                tfInt.status = ConfigItemStatus.read(2)
                tfInt.txnTimestamp = new Date().toTimestamp()
                tfInt.txnDate = currentDate
                tfInt.txnAmt = deposit.acrintAmt
                tfInt.txnCode = TxnTemplate.get(intTxn).code
                tfInt.txnType = TxnTemplate.get(intTxn).txnType
                tfInt.txnDescription = TxnTemplate.get(intTxn).description
                tfInt.txnRef = currentDate.toString() + ' Int Posting'  
                tfInt.txnTemplate = TxnTemplate.get(intTxn)
                tfInt.user = user
                //tfInt.branch = deposit.branch
                tfInt.save(flush:true)	
                
                def dlInt = new TxnDepositAcctLedger()
                dlInt.acct = deposit
                dlInt.acctNo = deposit.acctNo
                dlInt.bal = deposit.ledgerBalAmt + deposit.acrintAmt
                //dlInt.branchId = deposit.ledgerBalAmt.branch
                dlInt.creditAmt = deposit.acrintAmt
                dlInt.currency = deposit.product.currency
                dlInt.status = deposit.status
                dlInt.txnDate = currentDate
                dlInt.txnFile = tfInt
                dlInt.txnRef = currentDate.toString() + ' Int Posting'
                dlInt.txnType = TxnTemplate.get(intTxn).txnType
                dlInt.user = user
                dlInt.branch = deposit.branch	
                dlInt.save(flush:true)
            
                // post tax txn
                def tfTax = new TxnFile()
                tfTax.acctNo = deposit.acctNo
                //tfTax.acctStatus= deposit.status.id
                tfTax.branch = deposit.branch
                tfTax.currency = deposit.product.currency
                tfTax.depAcct = deposit
                tfTax.status = ConfigItemStatus.read(2)
                tfTax.txnTimestamp = new Date().toTimestamp()
                tfTax.txnDate = currentDate
                tfTax.txnAmt = deposit.acrintAmt * deposit.depositTaxChargeScheme.taxRate.div(100)
                tfTax.txnCode = TxnTemplate.get(taxTxn).code
                tfTax.txnType = TxnTemplate.get(taxTxn).txnType
                tfTax.txnDescription = TxnTemplate.get(taxTxn).description
                tfTax.txnRef = currentDate.toString() + ' Wholding Tax'  
                tfTax.txnTemplate = TxnTemplate.get(taxTxn)
                tfTax.user = user
                //tfTax.branch = branch
                tfTax.save(flush:true)	
                
                def dlTax = new TxnDepositAcctLedger()
                dlTax.acct = deposit
                dlTax.acctNo = deposit.acctNo
                dlTax.bal = deposit.ledgerBalAmt + deposit.acrintAmt - (deposit.acrintAmt * deposit.depositTaxChargeScheme.taxRate.div(100))
                //dlTax.branchId = deposit.ledgerBalAmt.branch
                dlTax.debitAmt = deposit.acrintAmt * deposit.depositTaxChargeScheme.taxRate.div(100)
                dlTax.currency = deposit.product.currency
                dlTax.status = deposit.status
                dlTax.txnDate = currentDate
                dlTax.txnFile = tfTax
                dlTax.txnRef = currentDate.toString() + ' Wholding Tax'
                dlTax.txnType = TxnTemplate.get(taxTxn).txnType
                dlTax.user = user
                dlTax.branch = deposit.branch	
                dlTax.save(flush:true)     
                
                // update GL first for accruals before updating deposit account
                GlTransactionService.saveTxnBreakdown(tfInt.id)
                GlTransactionService.saveTxnBreakdown(tfTax.id)        
                // update deposit
                deposit.ledgerBalAmt += deposit.acrintAmt - (deposit.acrintAmt * deposit.depositTaxChargeScheme.taxRate.div(100)) 
                deposit.availableBalAmt += deposit.acrintAmt - (deposit.acrintAmt * deposit.depositTaxChargeScheme.taxRate.div(100))
                // compute and update tax
                deposit.taxWithheld = deposit.acrintAmt * deposit.depositTaxChargeScheme.taxRate.div(100)
                deposit.acrintAmt = 0.00
                deposit.interestBalAmt= 0.00
                deposit.lastCapitalizationDate = currentDate
                deposit.save(flush:true)
                
            }
        }                   
    }    
}
