package icbs.edi
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.converters.JSON
import org.codehaus.groovy.grails.web.json.JSONObject

import icbs.cif.Customer
import icbs.cif.Employment
import icbs.deposit.Deposit
import icbs.loans.Loan
import icbs.loans.DepEdRemittance
import icbs.loans.DepEdLoanRemDet
import icbs.lov.CustomerStatus
import icbs.loans.DepEdLoanCollection
import icbs.admin.Branch
import icbs.admin.Currency
import icbs.admin.UserMaster
import icbs.gl.GlBatchHdr
import icbs.gl.GlBatch
import icbs.lov.GlBatchHdrStatus
import icbs.gl.GlAccount

class ExportController {

    def index() { }


    def cif() {
    	def customers = Customer.list()

    	response.setHeader("Content-disposition", "attachment; filename=\"Customer Information.csv\"") 
    	response.contentType = "text/csv" 

    	def outs = response.outputStream 

    	outs << "Customer Name, Customer ID, Customer Type, Branch, Birth Date, Gender, Civil Status, Birth Place, Taxable?," +
            "Credit Limit, Resident Type, Risk Type, Firm Size, Nationality, Dosri Code, SSS No., GSIS No., TIN No., Passport No.," +
            "Address Type, Address, Postal Code, Phone 1, Phone 2, Fax 1, Fax2, Contact Type, Contact\n" 
        
       	customers.each() { customer ->
       		customer.contacts.each() { contact ->
       			customer.addresses.each() { address ->
       				outs << "\"" +
	       				customer.displayName + "\",\"" +
                        customer.customerId + "\",\"" +
	       				customer.type.description + "\",\"" +
		            	customer.branch.name + "\",\"" +
		            	customer.birthDate + "\",\"" +
		            	customer.gender.description + "\",\"" +
		            	customer.civilStatus.itemValue + "\",\"" +
		            	customer.birthPlace + "\",\"" +
		            	customer.isTaxable + "\",\"" +
		            	customer.creditLimit + "\",\"" +
                        customer.customerCode1.description + "\",\"" +
                        customer.customerCode2.description + "\",\"" +
                        customer.customerCode3.description + "\",\"" +
                        customer.nationality.itemValue + "\",\"" +
                        customer.dosriCode.description + "\",\"" +
                        customer.sssNo + "\",\"" +
                        customer.gisNo + "\",\"" +
                        customer.tinNo + "\",\"" +
                        customer.passportNo + "\",\"" +
		            	address.type.description + "\",\"" +
		            	address.address1 + " " + address.address2 + " " + address.address3 + "\",\"" +
                        address.postalCode + "\",\"" +
                        address.phone1 + "\",\"" +
                        address.phone2 + "\",\"" +
                        address.phone3 + "\",\"" +
                        address.phone4 + "\",\"" +
	            		contact.type.itemValue + "\",\"" +
	            		contact.contactValue + "\""
            		outs << "\n"	
       			}
            }
       	} 
    	outs.flush() 
    	outs.close() 
        println("Putang Inang Pokwang, Betty La Booba and ArnArn")
    }

    def deposit() {
    	def deposits = Deposit.list()

	response.setHeader("Content-disposition", "attachment; filename=\"Deposits.csv\"") 
    	response.contentType = "text/csv" 

    	def outs = response.outputStream

    	outs << "Customer Name, Customer ID, Account Number, Account Name, Branch, Type, Product, Ownership Type," +
            "Deposit Interest Scheme, Deposit Tax Charge Scheme, Fixed Deposit Pre Term Scheme, Date Opened, Date Closed," + 
            "Maturity Date, Interest Rate\n"

    	deposits.each() { deposit ->
    		outs << "\"" +
    			deposit.customer.displayName + "\",\"" +
                deposit.customer.customerId + "\",\"" +
    			deposit.acctNo + "\",\"" +
    			deposit.acctName + "\",\"" +
    			deposit.branch.name + "\",\"" +
    			deposit.type.description + "\",\"" +
    			deposit.product.name + "\",\"" +
    			deposit.ownershipType.description + "\",\"" +
                deposit.depositInterestScheme + "\",\"" +
                deposit.depositTaxChargeScheme + "\",\"" +
                deposit.fixedDepositPreTermScheme + "\",\"" +
                deposit.dateOpened + "\",\"" +
                deposit.dateClosed + "\",\"" +
                deposit.currentRollover.endDate + "\",\"" +
                deposit.interestRate + "\""
    		outs << "\n"	
    	}
        outs.flush() 
        outs.close()
    }

    def loanAccount() {
        def loanAccounts = Loan.list()

        response.setHeader("Content-disposition", "attachment; filename=\"Loan Accounts.csv\"") 
        response.contentType = "text/csv" 

        def outs = response.outputStream

        outs << "Customer Name, Customer ID, Account No., Ownership Type, Branch, Product, Currency," +
            "Interest Income Scheme, Current Penalty Scheme, Past Due Penalty Scheme, Granted Amount, Interest Rate," +
            "Application Date, Opening Date, Maturity Date\n"

        loanAccounts.each() { loan ->
            outs << "\"" +
                loan.customer.displayName + "\",\"" +
                loan.customer.customerId + "\",\"" +
                loan.accountNo + "\",\"" +
                loan.ownershipType.description + "\",\"" +
                loan.branch.name + "\",\"" +
                loan.product.name + "\",\"" +
                loan.currency.name + "\",\"" +
                loan.interestIncomeScheme.name + "\",\"" +
                loan.currentPenaltyScheme.name + "\",\"" +
                loan.pastDuePenaltyScheme.name + "\",\"" +
                loan.grantedAmount + "\",\"" +
                loan.interestRate + "\",\"" +
                loan.applicationDate + "\",\"" +
                loan.openingDate + "\",\"" +
                loan.maturityDate + "\",\"" 
            outs << "\n" 
        }

        outs.flush() 
        outs.close()
    }

    def glTrialBalance() {

    }

    def glTransaction() {
    	
    }
    
    def depEdCollectionProcessing(){
        // display GSP
    }
    def loanCollectionProcessing(){
        // display GSP
    }    
    
    def loanCollMixedBatch(){
        // display gsp
    }
    def processDepEd() {
        println params
        Double amtDue
        Double amtDueFull
        Double totDedLn
        Double amtLeft
        String sa
        // should replace prList from Institution
        String prList = '002-088,002-089,002-095,003-088,003-089,003-095,004-088,004-089,004-095'
        if(params.checkClearing){
            def f = request.getFile('checkClearing')
            if (f.empty) {
                flash.message = 'file cannot be empty'
                render(view:"depEdCollectionProcessing")
                return
            }else{
                def batchSerial = new Date().toTimestamp().toString()
                Double prinDue = 0.00D
                Double intDue = 0.00D
                Double penDue = 0.00D
                Double balDue = 0.00D
                //parse
                BufferedReader reader = new BufferedReader(new InputStreamReader(f.getInputStream(), "UTF-8"));
                def lineCount = -1
                try {
                    for (String line = reader.readLine(); line != null; line = reader.readLine()) {
                        ++lineCount
                        println lineCount
                        if (lineCount==0){
                            continue
                        }
                        String[] fields = line.split(',');
                        def depEdRem = new DepEdRemittance(batchSerial:batchSerial, regNo:fields[0], divCode:fields[1], staCode:fields[2] ,
                            empCode:fields[3], fnPre:fields[4], fName:fields[5], lName:fields[6], midName:fields[7], appel:fields[8], dedCode:fields[9], 
                            DedIdNo:fields[10], effYear:fields[11], effMm:fields[12], terYy:fields[13], terMm:fields[14], 
                            dedAmt:fields[15].toDouble(), policyNo:fields[16], agent:fields[17], principal:fields[18].toDouble(), 
                            interest:fields[19].toDouble(), charges:fields[20].toDouble(),proceeds:fields[21].toDouble(), agency:fields[22], 
                            downDate:fields[23], payrDate:fields[24])
                        
                        def customer = Customer.createCriteria().list(){
                            and{
                                eq("status",CustomerStatus.get(2))
                                employments{
                                    and{
                                        eq("employmentId",fields[3])
                                    }
                                }
                            }
                        }
                        if (customer) {
                            for (c in customer) {
                                depEdRem.customer = c
                            }
                        }
                        //depEdRem.customer = Employment.findAllByEmploymentId(fields[3]).customer
                        depEdRem.dedAmt =  depEdRem.dedAmt.div(100)
                        depEdRem.save(flush:true)
                        
                        // aggregate the totals
                        if (depEdRem.customer) {
                            println batchSerial
                            println depEdRem.customer
                            def totDepEd = DepEdLoanRemDet.findByBatchSerialAndCustomer(batchSerial,depEdRem.customer)
                            //def totDepEd = DepEdLoanRemDet.findByBatchSerial(batchSerial)
                            println totDepEd
                            if (totDepEd) {
                                totDepEd.remAmount += depEdRem.dedAmt
                                totDepEd.save(flush:true)
                                println "------> EXISTING"
                            } else {
                                println "------> NEW"

                                def newDepEdTot = new DepEdLoanRemDet(customer:depEdRem.customer, batchSerial:batchSerial, 
                                    remAmount:depEdRem.dedAmt)
                                newDepEdTot.save(flush:true, validateOnError:true)
                                println batchSerial+'>>>'
                                println newDepEdTot.batchSerial+'>>>'
                            }
                        } else {
                            // deped employee id not found 
                        }
                    }
                    // distribute to loans
                    def totDepEd = DepEdLoanRemDet.findAllByBatchSerial(batchSerial)
                    for (tot in totDepEd) {
                        def loanList = Loan.createCriteria().list() {
                            and {
                                    eq("customer", tot.customer)
                                    gt("balanceAmount", 0.00D)
                                }
                            order("openingDate", "desc")    
                        }         
                        amtLeft = tot.remAmount
                        for (l in loanList) {
                            // check branch and product
                            if (l.product.code == 600) {
                                // do nonthing
                            } else if (l.product.code == 92) {  
                                // do not include this product
                                continue;
                            } else if (prList.indexOf(l.accountNo.substring(0, 6)) > 0)  {
                                // do nothing
                            } else {
                                // move to next record
                                continue;
                            }
                            prinDue = 0.00
                            intDue = 0.00
                            penDue = 0.00
                            balDue = 0.00
                            if (l.overduePrincipalBalance) {
                                prinDue = l.overduePrincipalBalance
                            }
                            if (l.interestBalanceAmount) {
                                intDue = l.interestBalanceAmount
                            }
                            if (l.penaltyBalanceAmount) {
                                penDue = l.penaltyBalanceAmount
                            }
                            if (l.balanceAmount) {
                                balDue = l.balanceAmount
                            }
                            if (prinDue >= balDue) {
                                amtDue = balDue + intDue + penDue
                            } else {
                                amtDue = prinDue + intDue + penDue
                            }                            
                            amtDueFull = 0.00
                            if ((amtLeft > 0) && (amtDue > 0)) {
                                //if (amtLeft > amtDue) {
                                    // amount greater than full loan
                                    //if (amtLeft > amtDueFull) {
                                    //    amtDue = amtDueFull
                                    //}
                                    // amount greater than due  but less than full amount
                                    //if (amtLeft >= amtDue) {
                                    //    amtDue = amtLeft
                                    //}
                                //}
                                // amount less than amount due
                                if (amtLeft < amtDue) {
                                    amtDue = amtLeft
                                }    
                                def x = new DepEdLoanCollection(depEdLoanRemDet:tot, loan:l, branch:l.branch, 
                                    customer:tot.customer,paymentAmt:amtDue, batchSerial:batchSerial)
                                x.save(flush:true, validateOnError:true)                  
                                amtLeft = amtLeft - amtDue
                            }
                        }
                        if (amtLeft > 0) {
                            // credit to savings
                            //def emps = tot.customer.listAllEmployment()
                            sa = null
                            for (em in tot.customer.employments) {
                                sa = em.debitAccount
                            }
                            def depSa = Deposit.findByAcctNo(sa)
                            if (depSa) {
                                def x = new DepEdLoanCollection(depEdLoanRemDet:tot, deposit:depSa, branch:depSa.branch, 
                                    customer:tot.customer,paymentAmt:amtLeft, batchSerial:batchSerial)
                                x.save(flush:true, validateOnError:true)                                    
                            } else {
                                // no deposit so this is AP
                                def x = new DepEdLoanCollection(depEdLoanRemDet:tot, branch:tot.customer.branch, 
                                    customer:tot.customer,paymentAmt:amtLeft, batchSerial:batchSerial)
                                x.save(flush:true, validateOnError:true)                                    
                                
                            }
                        }
                    }
                    //println "count!"+ cmd.count

                } finally {
                  reader.close();
                }  
                //cmd.validate()
                // create batch for each branch
                def gHdr
                def gLine
                def nLine
                def totCr
                def bl = Branch.list()
                for (b in bl) {
                    def depEdBatch = DepEdLoanCollection.findAllByBatchSerialAndBranch(batchSerial, b)
                    if (depEdBatch) {
                        // create new batch header
                        gHdr = new GlBatchHdr(batchId: batchSerial+b.id,
                            batchName:'DEPED-'+b.name+'-'+b.runDate.toString(), batchCurrency:Currency.get(1),
                            branch:b, batchType:'1',totalDebit:0.00D, totalCredit:0.00D, isLocked:false,
                            isBalanced:false, txnDate:b.runDate,  valueDate:b.runDate, status:GlBatchHdrStatus.get(1))
                        gHdr.save(flush:true,validateOnError:true)
                        // create batch details
                        nLine = 0
                        totCr = 0
                        for (db in depEdBatch) {
                            if (db.loan) {
                                // create loan batch
                                nLine++
                                gLine = new GlBatch(batchId:gHdr.batchId, batchType:'5', recordDate:b.runDate,
                                    amount:db.paymentAmt, particulars:'Dep Ed Collection-'+db.customer.displayName, 
                                    currency:Currency.get(1), creditAccount:db.loan.accountNo,
                                    credit:db.paymentAmt, account:db.loan.accountNo, reference:'DepEd-'+batchSerial, 
                                    accountName: db.customer.displayName, lineNo:nLine.toString())
                                gLine.save(flush:true,validateOnError:true)
                                totCr += db.paymentAmt                                
                            } else if (db.deposit) {
                                // credit deposit line
                                nLine++
                                gLine = new GlBatch(batchId:gHdr.batchId, batchType:'2', recordDate:b.runDate,
                                    amount:db.paymentAmt, particulars:'Dep Ed Collection-'+db.customer.displayName, 
                                    currency:Currency.get(1), creditAccount:db.deposit.acctNo,
                                    credit:db.paymentAmt, account:db.deposit.acctNo, reference:'DepEd-'+batchSerial, 
                                    accountName: db.customer.displayName, lineNo:nLine.toString())
                                gLine.save(flush:true,validateOnError:true)
                                totCr += db.paymentAmt                                
                            } else {
                                // credit AP line
                                nLine++
                                gLine = new GlBatch(batchId:gHdr.batchId, batchType:'8', recordDate:b.runDate,
                                    amount:db.paymentAmt, particulars:'Dep Ed Collection-'+db.customer.displayName+' A/P', 
                                    currency:Currency.get(1), creditAccount:'2-30-06-01-00-00-00-00-06',
                                    credit:db.paymentAmt, account:'2-30-06-01-00-00-00-00-06', reference:'DepEd-'+batchSerial, 
                                    accountName: 'ACCOUNTS PAYABLE - GENERAL', lineNo:nLine.toString())
                                gLine.save(flush:true,validateOnError:true)
                                totCr += db.paymentAmt                                
                            }

                        }
                        // total credit
                        gHdr.totalCredit = totCr
                        gHdr.save(flush:true,validateOnError:true)
                    }
                }

                flash.message = 'Deped Upload Completed!'
                render(view:"depEdCollectionProcessing")
                println("Nag sulod na diri")
                return
            }
        }
        render(view:"depEdCollectionProcessing")        
    }
    def processLoanColl(){
        if(params.checkClearing){
            def f = request.getFile('checkClearing')
            if (f.empty) {
                flash.message = 'file cannot be empty'

                render(view:"loanCollectionProcessing")
                return
            } else {
                def batchSerial = new Date().toTimestamp().toString()
                def batchLn
                def txnAmt
                def txnType
                def batchPrin
                def batchInt
                def batchPen
                def batchRef
                def loan
                def apAmt
                
                // gl batch related
                def gHdr
                def gLine
                def nLine
                def totCr
                // new batch header
                gHdr = new GlBatchHdr(batchId: batchSerial+Branch.get(1).id,
                            batchName:'LOAN COLLECTION - '+Branch.get(1).runDate.toString(), batchCurrency:Currency.get(1),
                            branch:Branch.get(1), batchType:'1',totalDebit:0.00D, totalCredit:0.00D, isLocked:false,
                            isBalanced:false, txnDate:Branch.get(1).runDate,  valueDate:Branch.get(1).runDate, 
                            status:GlBatchHdrStatus.get(1), createdBy:UserMaster.get(session.user_id))
                gHdr.save(flush:true,validateOnError:true)                
                nLine = 0
                totCr = 0

                //parse
                BufferedReader reader = new BufferedReader(new InputStreamReader(f.getInputStream(), "UTF-8"));
                def lineCount = -1
                try {
                    for (String line = reader.readLine(); line != null; line = reader.readLine()) {
                        ++lineCount
                        println lineCount
                        if (lineCount==0){
                            continue
                        }
                        String[] fields = line.split(',');
                        batchLn = fields[0] // BBB-PPP-SSSSS-D format
                        txnType = fields[1].toInteger()
                        txnAmt = fields[2].toDouble()
                        batchPrin = fields[3].toDouble() //no decimal format without comma, if none should be 000
                        batchInt = fields[4].toDouble() //no decimal format without comma, if none should be 000
                        batchPen = fields[5].toDouble() // no decimal format without comma, if none should be 000
                        batchRef = fields[6]
                        if (txnAmt > 0) {
                            txnAmt = txnAmt.div(100)
                        }
                        if (batchPrin > 0) {
                            batchPrin = batchPrin.div(100)
                        }
                        if (batchInt > 0) {
                            batchInt = batchInt.div(100)
                        }
                        if (batchPen > 0) {
                            batchPen = batchPen.div(100)
                        }
                        
                        println 'field check ********'
                        println fields[0]
                        println fields[1]
                        println fields[2]
                        println fields[3]
                        println fields[4]
                        println fields[5]
                        println fields[6]
                        println '********************'
                        // get loan account
                        loan = Loan.findByAccountNo(batchLn) 
                        if (loan) {
                            // after loan has been validated check amount due in case of overpayment

                            apAmt = 0.00D
                            if (txnAmt > (loan.balanceAmount + loan.interestBalanceAmount + loan.penaltyBalanceAmount)) {
                                apAmt = txnAmt - loan.balanceAmount - loan.interestBalanceAmount - loan.penaltyBalanceAmount
                                txnAmt = loan.balanceAmount + loan.interestBalanceAmount + loan.penaltyBalanceAmount
                                batchPrin = loan.balanceAmount
                                batchInt = loan.interestBalanceAmount
                                batchPen = loan.penaltyBalanceAmount                                
                            }
                            // regular
                            if (txnType == 5) {
                                nLine++
                                gLine = new GlBatch(batchId:gHdr.batchId, batchType:'5', recordDate:Branch.get(1).runDate,

                                    amount:txnAmt, 
                                    particulars:'Loan Collection Reg - '+loan.customer.displayName, 
                                    currency:Currency.get(1), creditAccount:loan.accountNo,
                                    credit:txnAmt, account:loan.accountNo, 
                                    reference:batchRef, accountName: loan.customer.displayName,

                                    lineNo:nLine.toString())
                                gLine.save(flush:true,validateOnError:true)
                                totCr += txnAmt                                  
                            }
                            // specified
                            if (txnType == 6) {
                                nLine++
                                gLine = new GlBatch(batchId:gHdr.batchId, batchType:'6', recordDate:Branch.get(1).runDate,
                                    amount:batchPrin + batchInt + batchPen, 
                                    particulars:'Loan Collection Spec -'+loan.customer.displayName, 
                                    currency:Currency.get(1), creditAccount:loan.accountNo,
                                    credit:batchPrin + batchInt + batchPen, account:loan.accountNo, 
                                    reference:batchRef, accountName: loan.customer.displayName, 
                                    principal:batchPrin, interest:batchInt, penalty:batchPen,
                                    lineNo:nLine.toString())
                                gLine.save(flush:true,validateOnError:true)

                                totCr += txnAmt                                
                            }
                            // create credit to GL for excess
                            if (apAmt > 0) {
                                nLine++
                                gLine = new GlBatch(batchId:gHdr.batchId, batchType:'8', recordDate:Branch.get(1).runDate,

                                    amount:apAmt, 
                                    particulars:'Overpayment -'+loan.customer.displayName, 
                                    currency:Currency.get(1), creditAccount:'2-30-12-00-00-00-00-00-01',
                                    credit:apAmt, account:'2-30-12-00-00-00-00-00-01', 
                                    reference:batchRef, accountName: 'Loan Refund Payable', 
                                    principal:0.00, interest:0.00, penalty:0.00,
                                    lineNo:nLine.toString())
                                gLine.save(flush:true,validateOnError:true)
                                totCr += apAmt                                  
                            } 
                        }
                    }
                } finally {
                  reader.close();
                }
                // update header for total credit
                gHdr.totalCredit = totCr
                gHdr.save(flush:true, failOnError:true)
                
                // display gsp
                flash.message = 'Import Completed, please proceed to GL Batch for processing. Batch: ' + gHdr.id
                render(view:"loanCollectionProcessing")
                return                
            }
        } else {
            flash.message = 'invalid params'

            render(view:"loanCollectionProcessing")
            return            
        }
    }
    
    def loanCollMixedBatchProcess(){
        if(params.checkClearing){
            def f = request.getFile('checkClearing')
            if (f.empty) {
                flash.message = 'file cannot be empty'

                render(view:"loanCollMixedBatch")
                return
            } else {
                def batchSerial = new Date().toTimestamp().toString()
                def batchLn
                def txnAmt
                def txnType
                def batchPrin
                def batchInt
                def batchPen
                def batchRef
                def loan
                def dep
                def apAmt
                
                // gl batch related
                def gHdr
                def gLine
                def nLine
                def totCr
                def totDr
                // new batch header
                gHdr = new GlBatchHdr(batchId: batchSerial+Branch.get(1).id,
                            batchName:'LOAN Coll Mixed Batch - '+Branch.get(1).runDate.toString(), batchCurrency:Currency.get(1),
                            branch:Branch.get(1), batchType:'1',totalDebit:0.00D, totalCredit:0.00D, isLocked:false,
                            isBalanced:false, txnDate:Branch.get(1).runDate,  valueDate:Branch.get(1).runDate, 
                            status:GlBatchHdrStatus.get(1), createdBy:UserMaster.get(session.user_id))
                gHdr.save(flush:true,validateOnError:true)                
                nLine = 0
                totCr = 0
                totDr = 0
                //parse
                BufferedReader reader = new BufferedReader(new InputStreamReader(f.getInputStream(), "UTF-8"));
                def lineCount = -1
                try {
                    for (String line = reader.readLine(); line != null; line = reader.readLine()) {
                        ++lineCount
                        println lineCount
                        if (lineCount==0){
                            continue
                        }
                        String[] fields = line.split(',');
                        batchLn = fields[0] // BBB-PPP-SSSSS-D format
                        txnType = fields[1].toInteger()
                        txnAmt = fields[2].toDouble()
                        batchPrin = fields[3].toDouble() //no decimal format without comma, if none should be 000
                        batchInt = fields[4].toDouble() //no decimal format without comma, if none should be 000
                        batchPen = fields[5].toDouble() // no decimal format without comma, if none should be 000
                        batchRef = fields[6]
                        if (txnAmt > 0) {
                            txnAmt = txnAmt.div(100)
                        }
                        if (batchPrin > 0) {
                            batchPrin = batchPrin.div(100)
                        }
                        if (batchInt > 0) {
                            batchInt = batchInt.div(100)
                        }
                        if (batchPen > 0) {
                            batchPen = batchPen.div(100)
                        }
                        
                        println 'field check ********'
                        println fields[0]
                        println fields[1]
                        println fields[2]
                        println fields[3]
                        println fields[4]
                        println fields[5]
                        println fields[6]
                        println '********************'
                        // get loan account
                        loan = Loan.findByAccountNo(batchLn) 
                        if (loan) {
                            // after loan has been validated check amount due in case of overpayment

                            apAmt = 0.00D
                            if (txnAmt > (loan.balanceAmount + loan.interestBalanceAmount + loan.penaltyBalanceAmount)) {
                                apAmt = txnAmt - loan.balanceAmount - loan.interestBalanceAmount - loan.penaltyBalanceAmount
                                txnAmt = loan.balanceAmount + loan.interestBalanceAmount + loan.penaltyBalanceAmount
                                batchPrin = loan.balanceAmount
                                batchInt = loan.interestBalanceAmount
                                batchPen = loan.penaltyBalanceAmount                                
                            }
                            // regular
                            if (txnType == 5) {
                                nLine++
                                gLine = new GlBatch(batchId:gHdr.batchId, batchType:'5', recordDate:Branch.get(1).runDate,

                                    amount:txnAmt, 
                                    particulars:'Loan Collection Reg - '+loan.customer.displayName, 
                                    currency:Currency.get(1), creditAccount:loan.accountNo,
                                    credit:txnAmt, account:loan.accountNo, 
                                    reference:batchRef, accountName: loan.customer.displayName,
                                    lineNo:nLine.toString())
                                gLine.save(flush:true,validateOnError:true)
                                totCr += txnAmt                                  
                            }
                            // specified
                            if (txnType == 6) {
                                nLine++
                                gLine = new GlBatch(batchId:gHdr.batchId, batchType:'6', recordDate:Branch.get(1).runDate,
                                    amount:batchPrin + batchInt + batchPen, 
                                    particulars:'Loan Collection Spec -'+loan.customer.displayName, 
                                    currency:Currency.get(1), creditAccount:loan.accountNo,
                                    credit:batchPrin + batchInt + batchPen, account:loan.accountNo, 
                                    reference:batchRef, accountName: loan.customer.displayName, 
                                    principal:batchPrin, interest:batchInt, penalty:batchPen,
                                    lineNo:nLine.toString())
                                gLine.save(flush:true,validateOnError:true)

                                totCr += txnAmt                                
                            }
                            // create credit to GL for excess
                            if (apAmt > 0) {
                                nLine++
                                gLine = new GlBatch(batchId:gHdr.batchId, batchType:'8', recordDate:Branch.get(1).runDate,
                                    amount:apAmt, 
                                    particulars:'Overpayment -'+loan.customer.displayName, 
                                    currency:Currency.get(1), creditAccount:'2-30-12-00-00-00-00-00-01',
                                    credit:apAmt, account:'2-30-12-00-00-00-00-00-01', 
                                    reference:batchRef, accountName: 'Loan Refund Payable', 
                                    principal:0.00, interest:0.00, penalty:0.00,
                                    lineNo:nLine.toString())
                                gLine.save(flush:true,validateOnError:true)
                                totCr += apAmt                                  
                            } 
                        } else if (txnType == 1){
                            // debit to deposit
                            dep = Deposit.findByAcctNo(batchLn)
                            if (dep) {
                                nLine++
                                gLine = new GlBatch(batchId:gHdr.batchId, batchType:'1', recordDate:Branch.get(1).runDate,
                                    amount:txnAmt, 
                                    particulars:'loan recovery - ' + dep.customer.displayName, 
                                    currency:dep.product.currency, debitAccount:dep.acctNo,
                                    debit:txnAmt, account:dep.acctNo, 
                                    reference:batchRef, accountName: dep.customer.displayName, 
                                    lineNo:nLine.toString())
                                gLine.save(flush:true,validateOnError:true)
                                totDr += txnAmt                                    
                            }
                        }
                    }
                } finally {
                  reader.close();
                }
                // update header for total credit
                gHdr.totalCredit = totCr
                gHdr.totalDebit = totDr
                gHdr.save(flush:true, failOnError:true)
                
                // display gsp
                flash.message = 'Import Completed, please proceed to GL Batch for processing. Batch: ' + gHdr.id
                render(view:"loanCollMixedBatch")
                return                
            }
        } else {
            flash.message = 'invalid params'

            render(view:"loanCollMixedBatch")
            return            
        }        
    }
    def importGlTransactions(){
        // display view
    }
    
    def importDepositList(){
        // display view
    }
    
    def processImportGl(){
        println("params: "+params)
        if(params.checkClearing){
            if(params.branch == "" || params.branch == null){
                flash.message = 'Branch is required! cannot be empty'
                render(view:"importGlTransactions")
                return
            }
            def f = request.getFile('checkClearing')
            if (f.empty) {
                flash.message = 'file cannot be empty'
                render(view:"importGlTransactions")
                return
            }

           
            else {
                def branch = Branch.get(params.branch)
                def batchName = params.name
                def batchSerial = new Date().toTimestamp().toString()
                def batchLn
                def txnAmt
                def txnType
                def batchPrin
                def batchInt
                def batchPen
                def batchRef
                def batchPart
                def gl
                def loan
                def dep
                def apAmt
                def finYear = branch.runDate.format('yyyy').toInteger()
                // gl batch related
                def gHdr
                def gLine
                def nLine
                def totCr
                def totDr
                // new batch header
                gHdr = new GlBatchHdr(batchId: batchSerial+Branch.get(1).id,
                            batchName:batchName, batchCurrency:Currency.get(1),
                            branch:branch, batchType:'1',totalDebit:0.00D, totalCredit:0.00D, isLocked:false,
                            isBalanced:false, txnDate:branch.runDate,  valueDate:branch.runDate, 
                            status:GlBatchHdrStatus.get(1), createdBy:UserMaster.get(session.user_id))
                gHdr.save(flush:true,validateOnError:true)                
                nLine = 0
                totCr = 0
                totDr = 0
                //parse
                BufferedReader reader = new BufferedReader(new InputStreamReader(f.getInputStream(), "UTF-8"));
                def lineCount = -1
                try {
                    for (String line = reader.readLine(); line != null; line = reader.readLine()) {
                        ++lineCount
                        println lineCount
                        if (lineCount==0){
                            continue
                        }
                        String[] fields = line.split(',');
                        batchLn = fields[0] // BBB-PPP-SSSSS-D format
                        txnType = fields[1].toInteger()
                        txnAmt = fields[2].toDouble()
                        batchRef = fields[3]
                        batchPart = fields[4]
                        if (txnAmt > 0) {
                            txnAmt = txnAmt.div(100)
                        }
                        
                        println 'field check ********'
                        println fields[0]
                        println fields[1]
                        println fields[2]
                        println '********************'
                        // get loan account
                        gl = GlAccount.findByCodeAndBranchAndCurrencyAndFinancialYear(batchLn, branch, Currency.get(1), finYear) 
                        if (gl) {
                            // debit
                            if (txnType == 7) {
                                nLine++
                                gLine = new GlBatch(batchId:gHdr.batchId, batchType:'7', recordDate:branch.runDate,
                                    amount:txnAmt, 
                                    particulars:batchPart, 
                                    currency:Currency.get(1), debitAccount:gl.code,
                                    debit:txnAmt, account:gl.code, 
                                    reference:batchRef, accountName: gl.name, 
                                    lineNo:nLine.toString())
                                gLine.save(flush:true,validateOnError:true)
                                totDr += txnAmt                                  
                            }
                            // credit
                            if (txnType == 8) {
                                nLine++
                                gLine = new GlBatch(batchId:gHdr.batchId, batchType:'8', recordDate:branch.runDate,
                                    amount:txnAmt, 
                                    particulars:batchPart, 
                                    currency:Currency.get(1), creditAccount:gl.code,
                                    credit:txnAmt, account:gl.code, 
                                    reference:batchRef, accountName:gl.name, 
                                    lineNo:nLine.toString())
                                gLine.save(flush:true,validateOnError:true)
                                totCr += txnAmt                                
                            }
                        } else if (txnType == 1) {
                            // debit deposit
                            dep = Deposit.findByAcctNo(batchLn)
                            if (dep) {
                                nLine++
                                gLine = new GlBatch(batchId:gHdr.batchId, batchType:'1', recordDate:branch.runDate,
                                    amount:txnAmt, 
                                    particulars:batchPart, 
                                    currency:dep.currency, debitAccount:dep.acctNo,
                                    debit:txnAmt, account:dep.acctNo, 
                                    reference:batchRef, accountName: dep.customer.displayName, 
                                    lineNo:nLine.toString())
                                gLine.save(flush:true,validateOnError:true)
                                totDr += txnAmt                                 
                            }
                        } else if (txnType == 2) {
                            // credit deposit
                            dep = Deposit.findByAcctNo(batchLn)
                            if (dep) {
                                nLine++
                                gLine = new GlBatch(batchId:gHdr.batchId, batchType:'2', recordDate:branch.runDate,
                                    amount:txnAmt, 
                                    particulars:batchPart, 
                                    currency:Currency.get(1), creditAccount:dep.acctNo,
                                    credit:txnAmt, account:dep.acctNo, 
                                    reference:batchRef, accountName:dep.customer.displayName, 
                                    lineNo:nLine.toString())
                                gLine.save(flush:true,validateOnError:true)
                                totCr += txnAmt                                 
                            }
                        } else if (txnType == 3) {
                            // debit deposit icc
                            dep = Deposit.findByAcctNo(batchLn)
                            if (dep) {
                                nLine++
                                gLine = new GlBatch(batchId:gHdr.batchId, batchType:'3', recordDate:branch.runDate,
                                    amount:txnAmt, 
                                    particulars:batchPart, 
                                    currency:dep.currency, debitAccount:dep.acctNo,
                                    debit:txnAmt, account:dep.acctNo, 
                                    reference:batchRef, accountName: dep.customer.displayName, 
                                    lineNo:nLine.toString())
                                gLine.save(flush:true,validateOnError:true)
                                totDr += txnAmt                                 
                            }
                        } else if (txnType == 4) {
                            // debit loan
                            loan = Loan.findByAccountNo(batchLn)
                            if (loan) {
                                nLine++
                                gLine = new GlBatch(batchId:gHdr.batchId, batchType:'4', recordDate:Branch.get(1).runDate,
                                    amount:txnAmt, 
                                    particulars:batchPart, 
                                    currency:Currency.get(1), debitAccount:loan.accountNo,
                                    debit:txnAmt, account:loan.accountNo, 
                                    reference:batchRef, accountName: loan.customer.displayName,
                                    lineNo:nLine.toString())
                                gLine.save(flush:true,validateOnError:true)
                                totDr += txnAmt                                
                            }                        
                        } else if (txnType == 5) {
                            // credit loan
                            loan = Loan.findByAccountNo(batchLn)
                            if (loan) {
                                nLine++
                                gLine = new GlBatch(batchId:gHdr.batchId, batchType:'5', recordDate:Branch.get(1).runDate,
                                    amount:txnAmt, 
                                    particulars:batchPart, 
                                    currency:Currency.get(1), creditAccount:loan.accountNo,
                                    credit:txnAmt, account:loan.accountNo, 
                                    reference:batchRef, accountName: loan.customer.displayName,
                                    lineNo:nLine.toString())
                                gLine.save(flush:true,validateOnError:true)
                                totCr += txnAmt                                
                            }
                        } else if (txnType == 6) {
                            // credit loan specified
                        }
                            
                    }
                } finally {
                  reader.close();
                }
                // update header for total credit
                gHdr.totalCredit = totCr
                gHdr.totalDebit = totDr
                gHdr.save(flush:true, failOnError:true)
                
                // display gsp
                flash.message = 'Import Completed, please proceed to GL Batch for processing.  Batch: ' + gHdr.id

                render(view:"importGlTransactions")
                return                
            }
        } else {
            flash.message = 'invalid params'

            render(view:"importGlTransactions")
            return            


        }        
    }
    def processImportDeposit(){
        if(params.checkClearing){
            def f = request.getFile('checkClearing')
            if (f.empty) {
                flash.message = 'file cannot be empty'
                render(view:"importDepositList")
                return
            } else {
                def branch = UserMaster.get(session.user_id).branch
                def batchSerial = new Date().toTimestamp().toString()
                def batchLn
                def txnAmt
                def txnType
                def batchPrin
                def batchInt
                def batchPen
                def batchRef
                def dep
                def apAmt
                def batchPart
                def finYear = branch.runDate.format('yyyy').toInteger()
                // gl batch related
                def gHdr
                def gLine
                def nLine
                def totCr
                def totDr
                // new batch header
                gHdr = new GlBatchHdr(batchId: batchSerial+Branch.get(1).id,
                            batchName:'DEP'+branch.runDate.toString(), batchCurrency:Currency.get(1),
                            branch:branch, batchType:'1',totalDebit:0.00D, totalCredit:0.00D, isLocked:false,
                            isBalanced:false, txnDate:branch.runDate,  valueDate:branch.runDate, 
                            status:GlBatchHdrStatus.get(1), createdBy:UserMaster.get(session.user_id))
                gHdr.save(flush:true,validateOnError:true)                
                nLine = 0
                totCr = 0
                totDr = 0
                //parse
                BufferedReader reader = new BufferedReader(new InputStreamReader(f.getInputStream(), "UTF-8"));
                def lineCount = -1
                try {
                    for (String line = reader.readLine(); line != null; line = reader.readLine()) {
                        ++lineCount
                        println lineCount
                        if (lineCount==0){
                            continue
                        }
                        String[] fields = line.split(',');
                        batchLn = fields[0] // BBB-PPP-SSSSS-D format
                        txnType = fields[1].toInteger()
                        txnAmt = fields[2].toDouble()
                        batchRef = fields[3]
                        batchPart = fields[4]
                        if (txnAmt > 0) {
                            txnAmt = txnAmt.div(100)
                        }
                        
                        println 'field check ********'
                        println fields[0]
                        println fields[1]
                        println fields[2]
                        println '********************'
                        // get loan account
                        dep = Deposit.findByAcctNo(batchLn) 
                        if (dep) {
                            // debit deposit
                            if (txnType == 1) {
                                nLine++
                                gLine = new GlBatch(batchId:gHdr.batchId, batchType:'1', recordDate:branch.runDate,
                                    amount:txnAmt, 
                                    particulars:batchPart, 
                                    currency:dep.currency, debitAccount:dep.acctNo,
                                    debit:txnAmt, account:dep.acctNo, 
                                    reference:batchRef, accountName: dep.customer.displayName, 
                                    lineNo:nLine.toString())
                                gLine.save(flush:true,validateOnError:true)
                                totDr += txnAmt                                  
                            }
                            // credit
                            if (txnType == 2) {
                                nLine++
                                gLine = new GlBatch(batchId:gHdr.batchId, batchType:'2', recordDate:branch.runDate,
                                    amount:txnAmt, 
                                    particulars:batchPart, 
                                    currency:Currency.get(1), creditAccount:dep.acctNo,
                                    credit:txnAmt, account:dep.acctNo, 
                                    reference:batchRef, accountName:dep.customer.displayName, 
                                    lineNo:nLine.toString())
                                gLine.save(flush:true,validateOnError:true)
                                totCr += txnAmt                                
                            }
                        }
                    }
                } finally {
                  reader.close();
                }
                // update header for total credit
                gHdr.totalCredit = totCr
                gHdr.totalDebit = totDr
                gHdr.save(flush:true, failOnError:true)
                
                // display gsp
                flash.message = 'Import Completed, please proceed to GL Batch for processing. Batch: ' + gHdr.id
                render(view:"importDepositList")
                return                
            }
        } else {
            flash.message = 'invalid params'
            render(view:"importDepositList")
            return            
        }   
    }
}
