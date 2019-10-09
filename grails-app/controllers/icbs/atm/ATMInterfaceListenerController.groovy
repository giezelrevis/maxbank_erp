package icbs.atm

import grails.converters.JSON
import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.json.JSONObject
import org.springframework.web.context.request.RequestContextHolder
import javax.servlet.http.HttpSession
import icbs.admin.UserMaster
import icbs.admin.Branch
import icbs.admin.TxnTemplate
import icbs.admin.ProductTxn
import icbs.deposit.Deposit
import icbs.atm.AtmMsgRequest
import icbs.atm.AtmMsgResponse
import icbs.atm.AtmTxn
import icbs.atm.AtmBitmap
import icbs.atm.AtmTable
import icbs.atm.AtmTxnMapping
import icbs.lov.ConfigItemStatus
import icbs.lov.DepositStatus
import icbs.lov.TxnType
import icbs.tellering.TxnCashCheckBlotter
import icbs.tellering.TxnDepositAcctLedger
import icbs.tellering.TxnFile
import java.text.DecimalFormat
import icbs.admin.Currency
import groovy.sql.Sql
import icbs.admin.Institution

//import org.apache.poi.ss.formula.functions.FinanceLib
//import org.apache.poi.ss.formula.functions.Irr

class ATMInterfaceListenerController {

    def isTelleringActiveService
    def policyService
    def userMasterService
    def glTransactionService
    def dataSource
    
    def index(){
        
    }
    
    @Transactional
    def echoTest(){ // ECHO
        def jsonObject = new JSONObject()
        jsonObject = jsonObject.put('echoResponse', params.echoResponse)
        render jsonObject
        return
    }
    
    @Transactional
    def createTransaction(){ // TRANSACTION
        def jsonObject = new JSONObject()
        def msgLength = (params.msgLength).toInteger()
        def reqMsgLength = (params.reqMsgLength).toInteger()
        def binBitmap = params.reqBinBitmap
        def reqMsg = params.reqMsg
        def headerSize = new Character[2]
        def txnType = new Character[2]
        def header = new Character[3]
        def newAcctNo = new Character[16]
        def hex = new Character[16]
        def newBinBitmap = new Character[128]
        def elementArray = new String[128]
        def delims = "[,]"
        def responseMti = "0210"
        def bitValue = ""
        def response2 = ""
        def hexStr1 = ""
        def hexStr2 = ""
        def iHeaderSize = 0
        def responseLength = 0
        def tempHeader
        def acctNo1
        def acctNo2
        def element
        def decimal
        char c;
        char m;
        int j = 0;
        int k = 0;
        int i = 0;
        int a = 0;
        int b = 0;
        
        
        
        // ****************************************************************************
        // 1. SAVE TO ATM MSG REQUEST TABLE
        // ****************************************************************************
        def atmMsgRequestInstance = new AtmMsgRequest(sourceIp:params.sourceIp, msgLength:Integer.parseInt(params.msgLength), dateReceived:new Date(), msgContent:params.msgContent)
        atmMsgRequestInstance.save(flush:true)
        
        // ****************************************************************************
        // 2. PARSE USING BISO FORMAT
        // ****************************************************************************
        for(i = 0; i < 128; i++){
            elementArray.putAt(i, "")
            if(i == 0)
                newBinBitmap.putAt(i, '1')
            else
                newBinBitmap.putAt(i, '0')
        }
        i = 1
        println "reqMsgLength :"+reqMsgLength
        println "reqMsg :"+reqMsg
        while(i < 128 && k < reqMsgLength){
            c = binBitmap.charAt(i)
            j = 0
           // println "i :"+i
            if(c == '1'){ // Element is active
                element = AtmBitmap.findByElementNo(i+1)
                if(element){ // Element actually exists
                    if(element.isVar == false){  // Element length is not variable
                        header = new Character[element.length]
                        while(j < element.length){
                            m = reqMsg.charAt(k)
                            header.putAt(j, m)
                            j++
                            if(k < reqMsgLength)
                                k++
                        }
                        if(element.elementNo == 3){
                            txnType.putAt(0, header[0])
                            txnType.putAt(1, header[1])
                        }
                    }
                    else if(element.isVar == true){ // Element length is variable
                        headerSize = new Character[element.length] // Get size of header first
                        while(j < element.length){
                            m = reqMsg.charAt(k)
                            headerSize.putAt(j, m)
                            j++
                            if(k < reqMsgLength)
                                k++
                        }
                        if (!headerSize.equals("  "))
                            iHeaderSize = Integer.parseInt(new String(headerSize))
                        else
                            iHeaderSize = 0
                        if(iHeaderSize > 0)
                            header = new Character[iHeaderSize]
                        else{
                            if(k < reqMsgLength)
                                k++
                        }
                        j = 0
                        while(j < iHeaderSize && iHeaderSize > 0){
                            m = reqMsg.charAt(k)
                            header.putAt(j, m)
                            j++
                            if(k < reqMsgLength)
                                k++
                        }
                    }
                }
                if(element.elementNo == 102){ // Formatting acctNo1 and acctNo2
                    b = 4;
                    println "element no :"+element.elementNo
                    println "headerSize :"+iHeaderSize
                    tempHeader = new Character[iHeaderSize-1]
                    for(a = 0; a < iHeaderSize-1; a++){
                        if(a == 3 || a == 7 || a == 13)
                                tempHeader.putAt(a, '-')
                        else{
                            tempHeader.putAt(a, header[b])
                            if(b < 16)
                                b++
                        }
                        println "a :"+a
                        println "tempHeader :"+tempHeader
                    }
                    if(element.elementNo == 102)
                        acctNo1 = new String(tempHeader)
                    else if(element.elementNo == 103)
                        acctNo2 = new String(tempHeader)
                }
                if(element.elementNo == 103){ // Formatting acctNo1 and acctNo2
                    if(elementArray[1] == '481000' || elementArray[1] == '482000' || elementArray[1] == '101022' || elementArray[1] == '102022'){
                       b = 0;
                       tempHeader = new Character[iHeaderSize]
                     
                      for(a = 0; a < iHeaderSize; a++){
                        tempHeader.putAt(a, header[b])
                        b++
                        println "a :"+a
                        println "tempHeader :"+tempHeader
                      }                       
                    }
                    else{
                       tempHeader = new Character[iHeaderSize-1]
                       b = 4;
                    println "element no :"+element.elementNo
                    println "headerSize :"+iHeaderSize
                      for(a = 0; a < iHeaderSize-1; a++){
                        if(a == 3 || a == 7 || a == 13){
                            if(elementArray[1] == '481000' || elementArray[1] == '482000'){
                                if(header[b] != null){
                                  tempHeader.putAt(a, header[b])
                                  if(b < 16)
                                    b++
                                }
                            }
                            else
                                tempHeader.putAt(a, '-')
                        }
                        else{
                            tempHeader.putAt(a, header[b])
                            if(b < 16)
                                b++
                        }
                        println "a :"+a
                        println "tempHeader :"+tempHeader
                      }                       
                    }
 
                    if(element.elementNo == 102)
                        acctNo1 = new String(tempHeader)
                    else if(element.elementNo == 103)
                        acctNo2 = new String(tempHeader)
                }                
                println "i :"+i
                elementArray.putAt(i-1, new String(header))
                println "elementArray[1] :"+elementArray[1]
            }
            i++
        }
        println "dito 1"
        // ****************************************************************************
        // 3. SAVE TO ATM TXN TABLE
        // ****************************************************************************
        def ATMUSerID = UserMaster.get(Institution.findByParamCode('DEP.40125').paramValue.toInteger())
        def ATMTxnType = TxnType.get(Institution.findByParamCode('DEP.40127').paramValue.toInteger())
        def ATMTxnTemplate = TxnTemplate.get(Institution.findByParamCode('DEP.40126').paramValue.toInteger())
        def atmTxnInstance = new AtmTxn(requestMsg:AtmMsgRequest.get(atmMsgRequestInstance.id), txnDate:new Date(), status:ConfigItemStatus.get(1))
        def ATMBillsTemplate = TxnTemplate.get(Institution.findByParamCode('DEP.40128').paramValue.toInteger())
        //if(params.reqCode == "0420"){
            //def atmTxnReverseInstance = atmTxnInstance.id 
            
        //}
        if(!elementArray[1].equals("")){
            atmTxnInstance.txnCode = elementArray[1]
            println "elementArray[1] :"+elementArray[1]
            println "params.reqCode :"+params.reqCode
            def atmMti = AtmTable.findByAtmTxnCodeAndMti(elementArray[1],params.reqCode)
            println "atmMti :"+atmMti
            if(atmMti){
                atmTxnInstance.mti = atmMti.mti
            }
            else
                elementArray.putAt(37, "30") // Invalid MTI
        }
        if(!elementArray[39].equals("")){ // Terminal no.
            atmTxnInstance.atmTerminal = elementArray[37]
        }
        if(!elementArray[0].equals("")){ // Card no.
            atmTxnInstance.atmCardNumber = elementArray[0]
        }
        if(!elementArray[35].equals("")){ // Txn. ref.
            atmTxnInstance.txnRef = elementArray[35]
        }
        if(!elementArray[26].equals("")){ // Txn. charges
            atmTxnInstance.txnChargeAmt = elementArray[26].toDouble()
        }
        if(!elementArray[5].equals("")){ // Txn. date
            Date d = Date.parse('MMDDhhmm', elementArray[5])
            atmTxnInstance.txnDate = d
        }
        elementArray.putAt(37, "") // Response code
        
        // ****************************************************************************
        // 4. PERFORM VALIDATION
        // ****************************************************************************
        /*HttpSession session = RequestContextHolder.currentRequestAttributes().getSession();
        if(session.user_id){
            def branch = UserMaster.get(session.user_id).branch
            if(branch.isTelleringActive == false){
                jsonObject = jsonObject.put('error', "Error: Branch is running a periodic process.")
                render jsonObject
                return
            }
        }*/
        
        def acctType = ""
        def acct2Type = ""
        def strTxnName = ""

        if(!acctNo1.equals("")){
            def acct1 = Deposit.findByAcctNo(acctNo1)
            if(acct1){ // Account exists!
                if(acct1.product.productType.id == 1)
                    acctType = "10"
                else
                    acctType = "20"
                if((acct1.status == DepositStatus.get(5)) || (acct1.status == DepositStatus.get(7)))
                    elementArray.putAt(37, "62") // Dormant / closed account
                else{
                    def branchInstance = Branch.get(acct1.branchId)
                    atmTxnInstance.acct1 = acctNo1
                    if((new String(txnType) == "30") || (new String(txnType) == "92")){ // INQUIRY || MINI STATEMENT
                        println 'inquiry..'
                        atmTxnInstance.bal1 = acct1.ledgerBalAmt
                        atmTxnInstance.bal2 = acct1.availableBalAmt
                        elementArray.putAt(37, "00")
                    }
                    else if((new String(txnType) == "10") || (new String(txnType) == "48")  || (new String(txnType) == "44")){ // WITHDRAWAL | BILLS PAYMENT || ELOAD
                        println "Withdrawal / Bills Payment!"
                        if(new String(txnType) == "48") {
                            strTxnName = "BILLS"
                            println '1'
                            println ATMTxnTemplate
                            println '2'
                               println ATMBillsTemplate
                            ATMTxnTemplate = ATMBillsTemplate
                        }
                        else
                        {
                           if(new String(txnType) == "44")
                             strTxnName = "ELOAD"
                           else
                             strTxnName = "WDL"
                           
                        }    
                        if(!elementArray[2].equals("") || !elementArray[28].equals("")){ // Txn amt and charge amount
                            atmTxnInstance.txnAmt = elementArray[2].toDouble()*(1/100)
                            // check for charges
                            def chgAmt = 0.00D
                            if(!elementArray[28].equals("")){
                               chgAmt = elementArray[28].toDouble()*(1/100)
                            }
                            if(params.reqCode == "0200"){
                                responseMti = "0210"
                                def txnTemp = TxnTemplate.get(14) // Change to: TxnTemplate.findAllWhere(mti:atmMti.mti, txnCode:elementArray[1])
                                
                                def productTxnInstance = ProductTxn.findAllWhere(product:acct1.product,txnTemplate:ATMTxnTemplate)
                                //def acctLedgerInstance = TxnDepositAcctLedger.findAllWhere(acctNo:acctNo1)
                                    println acct1.product
                                    println ATMTxnTemplate
                                if (!productTxnInstance){
                                    elementArray.putAt(37, "05") // Transaction not allowed for product
                                    println 'Transaction not allowed for product'
                                    println acct1.product
                                    println ATMTxnTemplate
                                } else if ((atmTxnInstance.txnAmt + chgAmt) > acct1.availableBalAmt){
                                    elementArray.putAt(37, "51") // Insufficient account balance
                                    println 'Insufficient account balance'
                                } else {
                                    println ' else{'
                                    def nCurrency = Currency.get(acct1.product.currencyId)
                                    def txnTemplateTemp
                                    
                                    if (new String(txnType) == "10"){
                                        txnTemplateTemp = "11"
                                    } else {
                                        txnTemplateTemp = "16"
                                    }
                                    if (atmTxnInstance.txnAmt > 0){                                                                          
                                        def atmTxnReference = params.reqCode+elementArray[1]+atmTxnInstance.txnRef
                                        def txnFileInstance = new TxnFile(acctNo:acct1.acctNo, depAcct:acct1, currency:acct1.product.currency, 
                                            branch:acct1.branch, txnAmt:atmTxnInstance.txnAmt, txnCode:ATMTxnTemplate.code, txnDate:acct1.branch.runDate, 
                                            txnTimestamp:new Date().toTimestamp(), txnDescription:ATMTxnTemplate.codeDescription, status:2, 
                                            txnParticulars:strTxnName, txnType:ATMTxnTemplate.txnType, txnTemplate:ATMTxnTemplate, user:ATMUSerID,
                                            txnRef: atmTxnReference,acctStatus:acct1.status.id)
                                        txnFileInstance.save(flush:true, failOnError:true)

                                        acct1.ledgerBalAmt -= atmTxnInstance.txnAmt          
                                        acct1.availableBalAmt -= atmTxnInstance.txnAmt
                                        acct1.save(flush:true)
                                    
                                        def acctLedgerInstance = new TxnDepositAcctLedger(acct:txnFileInstance.depAcctId, acctNo:acct1.acctNo, 
                                            branch:branchInstance.id, debitAmt:atmTxnInstance.txnAmt, txnDate:branchInstance.runDate, 
                                            bal:acct1.ledgerBalAmt,txnFile:txnFileInstance.id, currency:acct1.product.currency, status:2, 
                                            txnType:ATMTxnTemplate.txnType, txnRef:strTxnName, txnCode:ATMTxnTemplate.code,user:ATMUSerID)
                                        acctLedgerInstance.save(flush:true)
                                    
                                        atmTxnInstance.bal1 = acct1.ledgerBalAmt
                                        atmTxnInstance.bal2 = acct1.availableBalAmt
                                        if (ATMTxnTemplate.requirePassbook == 1){
                                            acct1.passbookBalAmt = acct1.ledgerBalAmt
                                            acct1.save(flush:true,failOnError:true)
                                        }
                                        def tb = new TxnCashCheckBlotter(cashOutAmt:0, cashInAmt:0, checkInAmt:0, checkOutAmt:0)

                                        //txnFileInstance.txnType = txnFileInstance.txnTemplate.txnType
                                        def amt = (atmTxnInstance.txnAmt).longValue()
                                        /*
                                        def isTxnAllowed =  policyService.isTxnAllowed(txnTemp.code, amt)
                                        if(isTxnAllowed == false) {
                                            txnFileInstance.status = ConfigItemStatus.get(1)
                                            policyService.createException('TLR00300', 'txnFile', txnFileInstance.id, 'tellering/viewTellerTxnInquiry2/'+txnFileInstance.id)
                                        }
                                        */
                                        //txnFileInstance.save(flush:true,failOnError:true)
                                        tb.txnFile = txnFileInstance
                                    
                                        atmTxnInstance.txnFile1 = txnFileInstance.id 
                                        atmTxnInstance.save(flush:true)
                                        tb.save(flush:true,failOnError:true)
                                        tb.cashOutAmt += atmTxnInstance.txnAmt
                                        //tb.branch = Branch.get(UserMaster.get(session.user_id))
                                        tb.branch = acctLedgerInstance.branch
                                        tb.currency = Currency.get(acct1.product.currencyId)
                                        //tb.user = UserMaster.get(session.user_id)
                                        tb.txnParticulars = txnFileInstance.txnParticulars
                                        tb.save(flush:true,failOnError:true)
                                        //userMasterService.updateTellerBalanceStatus(false)
                                    
                                        Long defATMId = txnFileInstance.id
                                        glTransactionService.saveTxnBreakdown(defATMId)
                                    }
                                    if (chgAmt > 0) {
                                        def ATMTxnTemplate2 = TxnTemplate.get(Institution.findByParamCode('DEP.40150').paramValue.toInteger())
                                        def atmTxnReference2 = params.reqCode+elementArray[1]+atmTxnInstance.txnRef
                                        def txnFileInstance2 = new TxnFile(acctNo:acct1.acctNo, depAcct:acct1, currency:acct1.product.currency, 
                                            branch:acct1.branch, txnAmt:chgAmt, txnCode:ATMTxnTemplate2.code, txnDate:acct1.branch.runDate, 
                                            txnTimestamp:new Date().toTimestamp(), txnDescription:ATMTxnTemplate.codeDescription, status:2, 
                                            txnParticulars:strTxnName, txnType:ATMTxnTemplate2.txnType, txnTemplate:ATMTxnTemplate2, user:ATMUSerID,
                                            txnRef: atmTxnReference2,acctStatus:acct1.status.id)
                                        txnFileInstance2.save(flush:true, failOnError:true)   
                                        def acctLedgerInstance2 = new TxnDepositAcctLedger(acct:txnFileInstance2.depAcctId, acctNo:acct1.acctNo, 
                                            branch:branchInstance.id, debitAmt:chgAmt, txnDate:branchInstance.runDate, 
                                            bal:acct1.ledgerBalAmt,txnFile:txnFileInstance2.id, currency:acct1.product.currency, status:2, 
                                            txnType:ATMTxnTemplate2.txnType, txnRef:strTxnName, txnCode:ATMTxnTemplate2.code,user:ATMUSerID)
                                        acctLedgerInstance2.save(flush:true) 
                                        
                                        acct1.ledgerBalAmt -= chgAmt          
                                        acct1.availableBalAmt -= chgAmt
                                        acct1.save(flush:true)
                                                                            
                                        atmTxnInstance.bal1 = acct1.ledgerBalAmt
                                        atmTxnInstance.bal2 = acct1.availableBalAmt
                                        glTransactionService.saveTxnBreakdown(txnFileInstance2.id)
                                    }
                                }
                            } else if(params.reqCode == "0420"){
                                responseMti = "0430"
                                if(!elementArray[9].equals("")){ // SEQ
                                    // CHECK IF TRANSACTION IS ALREADY REVERSED
                                    println "atmTxnInstance.txnRef :"+atmTxnInstance.txnRef
                                    def atmTxnRevInstance = AtmTxn.findByTxnRefAndMti(atmTxnInstance.txnRef,'0200')
                                    if(atmTxnRevInstance){
                                        if(atmTxnRevInstance.isReversed == true)
                                            elementArray.putAt(37, "05") // Catch all
                                        else{
                                            def nCurrency = Currency.get(acct1.product.currencyId)
                                            //do reversal process here
                                            println 'reversal'
                                            println "atmTxnRevInstance :"+atmTxnRevInstance
                                            println "atmTxnRevInstance.txnFile1.id : "+atmTxnRevInstance.txnFile1
                                            def txnFileRevInstance = TxnFile.get(atmTxnRevInstance.txnFile1)
                                            if(txnFileRevInstance){
                                                
                                            if(new String(txnType) == "48")
                                                strTxnName = "BILLSRev" 
                                            else
                                            {
                                                if(new String(txnType) == "44")
                                                   strTxnName = "ELOADRev"
                                                else
                                                   strTxnName = "WDLRev"
                                            }   
                                            def txnTempRev = TxnTemplate.get(22)
                                            def txnTemplateTemp
                                            txnTemplateTemp = "16"
                                            
                                                println 'pumasok'
                                                //def db = new Sql(dataSource)
                                                //def acctLedgerRevInstance = db.rows("select * from txn_deposit_acct_ledger where txn_file_id="+txnFileRevInstance.id)
                                                println 'continue'
                                                // if(acctLedgerRevInstance){
                                                    //println "acctLedgerRevInstance.bal :"+Double.parseDouble(acctLedgerRevInstance.bal.replaceAll(",",""))
                                                    //println "acctLedgerRevInstance.bal :"+Double.parseDouble(acctLedgerRevInstance.bal)
                                                    //println "acct1.ledgerBalAmt :"+acct1.ledgerBalAmt
                                                    //println "atmTxnRevInstance.txnAmt :"+atmTxnRevInstance.txnAmt
                                                    println 'dito'
                                                    def doubleValue1 = acct1.ledgerBalAmt
                                                    println 'dito 2'
                                                    def doubleValue2 = atmTxnRevInstance.txnAmt
                                                    println 'dito 3'
                                                    //def doubleValue3 = doubleValue1 + doubleValue2
                                                    //println "doubleValue :"+doubleValue
                                                    println "acct1.ledgerBalAmt : "+String.format("%12.0f", acct1.ledgerBalAmt).replace(" ", "0").toDouble()
                                                    //acctLedgerRevInstance.bal = doubleValue3
                                                    //acctLedgerRevInstance.bal = acct1.ledgerBalAmt + atmTxnRevInstance.txnAmt
                                                    //def acctLedgerRevInstance = new TxnFile(txnTemplate:txnTemplateTemp)
                                                   /* println "acctLedgerRevInstance.bal :"+acctLedgerRevInstance.bal
                                                    println "acctLedgerRevInstance.acctNo :"+acctLedgerRevInstance.acctNo
                                                    println "branchInstance.id :"+branchInstance.id
                                                    println "atmTxnInstance.txnAmt :"+atmTxnInstance.txnAmt
                                                    println "branchInstance.runDate :"+branchInstance.runDate
                                                    println "doubleValue3 :"+doubleValue3
                                                    println "txnFileInstance.id :"+txnFileInstance.id
                                                    println "nCurrency :"+nCurrency
                                                    */
                                                    
                                                    //println "doubleValue3 :"+doubleValue3
                                                    println "atmTxnRevInstance.txnAmt :"+atmTxnRevInstance.txnAmt
                                                    acct1.ledgerBalAmt += atmTxnRevInstance.txnAmt  
                                                    println "AAA"
                                                    acct1.availableBalAmt += atmTxnRevInstance.txnAmt
                                                    println "BBB"
                                                    println "acct1.ledgerBalAmt :"+acct1.ledgerBalAmt
                                                    println "acct1.availableBalAmt :"+acct1.availableBalAmt
                                                    acct1.save(flush:true)
                                                    
                                                    println "acctNo : "+txnFileRevInstance.acctNo
                                                    println "branch : "+branchInstance.id
                                                    println "txnAmt :"+atmTxnInstance.txnAmt
                                                    println "txnDate :"+branchInstance.runDate
                                                    println "Bal :"+acct1.availableBalAmt
                                                    println "TxnFileId :"+txnFileRevInstance.id

                                                    // branch:branchInstance.id,
                                                    println "CCC"
                                                    //atmTxnReverseInstance.bal1 = acct1.ledgerBalAmt
                                                    println "DDD"
                                                    //atmTxnReverseInstance.bal2 = acct1.availableBalAmt
                                                    println "EEE"
                                                    //atmTxnReverseInstance.save(flush:true,failOnError:true)
                                                    println "FFF"    
                                                    def acctLedgerRevInstance = new TxnDepositAcctLedger(acctNo:txnFileRevInstance.acctNo,  branch:branchInstance.id, acctId:txnFileRevInstance.depAcctId, creditAmt:atmTxnInstance.txnAmt, txnDate:branchInstance.runDate, bal:acct1.availableBalAmt,txnFile:txnFileRevInstance.id, currency:nCurrency, status:2, txnType:9, txnRef:'ATM WDL-Reversal')
                                                    println "GGG"
                                                    acctLedgerRevInstance.save(flush:true)
                                                    println "HHH"
                                                    
                                                def txnRefReversal = '0200'+elementArray[1]+elementArray[35]
                                                 
                                                def txnFileInstance2 = TxnFile.findByTxnRef(txnRefReversal)
                                                   // def txnFileInstance2 = new TxnFile(acctNo:acct1.acctNo, depAcct:acct1.id, currency:nCurrency, branch:branchInstance.id, txnAmt:atmTxnInstance.txnAmt, txnCode:txnTempRev.code, txnDate:branchInstance.runDate, txnTimestamp:new Date().toTimestamp(), txnDescription:txnTempRev.codeDescription, status:2, txnParticulars:strTxnName, txnType:9, txnTemplate:txnTemplateTemp)
                                                   txnFileInstance2.status = ConfigItemStatus.read(4)
                                                    txnFileInstance2.save(flush:true)
                                                
                                                    //def tb = new TxnCashCheckBlotter(cashOutAmt:0, cashInAmt:0, checkInAmt:0, checkOutAmt:0)

                                                    //tb.cashOutAmt -= atmTxnRevInstance.txnAmt
                                                    //tb.save(flush:true,failOnError:true)

                                                    // userMasterService.updateTellerBalanceStatus(false)
                                                   // Long defATMId = txnFileInstance2.id
                                                    glTransactionService.reverseTxn(txnFileInstance2)
                                                    responseMti = "0430"
                                                    atmTxnRevInstance.isReversed = true
                                                    atmTxnRevInstance.save(flush:true)
                                              //  }
                                              //  else
                                              //      elementArray.putAt(37, "05") // Catch all
                                            } else
                                                elementArray.putAt(37, "05") // Catch all
                                        }
                                    } else
                                        elementArray.putAt(37, "05") // Catch all
                                } else
                                    elementArray.putAt(37, "05") // Catch all
                            }
                        } else
                            elementArray.putAt(37, "13") // Invalid amount
                    } else{
                        if(!acctNo2.equals("")){
                          if(!(new String(txnType) == "10")){
                            def acct2 = Deposit.findByAcctNo(acctNo2)
                            if(acct2){ // Account2 exists!
                                if(acct2.product.productType.id == 1)
                                    acct2Type = "10"
                                else
                                    acct2Type = "20"
                                if((acct2.status == DepositStatus.get(5)) || (acct2.status == DepositStatus.get(7)))
                                    elementArray.putAt(37, "62")
                                else{
                                    atmTxnInstance.acct2 = acctNo2
                                    def branch2Instance = Branch.get(acct2.branchId)
                                    if((new String(txnType) == "40") || (new String(txnType) == "21")){ // Fund Transfer
                                        if(params.reqCode == "0200"){
                                            //atmTxnInstance.txnAmt = elementArray[2].toDouble()
                                            atmTxnInstance.txnAmt = elementArray[2].toDouble()*(1/100)
                                            responseMti = "0210"
                                            acct1.ledgerBalAmt -= atmTxnInstance.txnAmt
                                            acct1.availableBalAmt -= atmTxnInstance.txnAmt
                                            acct1.interestBalAmt -= atmTxnInstance.txnAmt
                                            acct2.ledgerBalAmt += atmTxnInstance.txnAmt
                                            acct2.availableBalAmt += atmTxnInstance.txnAmt
                                            acct2.interestBalAmt += atmTxnInstance.txnAmt
                                            def atmFtDr = TxnTemplate.get(Institution.findByParamCode("DEP.40121").paramValue.toInteger())    
                                            def atmFtCr = TxnTemplate.get(Institution.findByParamCode("DEP.40122").paramValue.toInteger())    
                                            
                                            def txnFile1Instance = new TxnFile(txnParticulars:AtmTable.findByAtmTxnCode(elementArray[1]).atmDescription,
                                                currency:acct1.product.currency,acctStatus:acct1.status.id,
                                                status:ConfigItemStatus.read(2),txnTimestamp:new Date().toTimestamp(),
                                                branch:branchInstance,acctNo:acct1.acctNo,txnCode: atmFtDr.code,
                                                txnAmt:atmTxnInstance.txnAmt,txnRef:atmTxnInstance.txnRef,
                                                depAcct:acct1,txnDate:acct1.branch.runDate, txnDescription:AtmTable.findByAtmTxnCode(elementArray[1]).atmDescription,
                                                txnTemplate:atmFtDr,txnType:atmFtDr.txnType,user:ATMUSerID)
                                            def txnFile2Instance = new TxnFile(txnParticulars:AtmTable.findByAtmTxnCode(elementArray[1]).atmDescription,
                                                currency:acct2.product.currency,acctStatus:acct2.status.id,status:ConfigItemStatus.read(2),
                                                txnTimestamp:new Date().toTimestamp(),branch:branch2Instance,acctNo:acct2.acctNo,txnCode: atmFtCr.code,
                                                txnAmt:atmTxnInstance.txnAmt,txnRef:atmTxnInstance.txnRef,
                                                depAcct:acct2,txnDate:acct2.branch.runDate, txnDescription:AtmTable.findByAtmTxnCode(elementArray[1]).atmDescription,
                                                txnTemplate:atmFtCr,txnType:atmFtCr.txnType,user:ATMUSerID)
                                            def acctLedger1Instance = new TxnDepositAcctLedger(acct:acct1, 
                                                acctNo:acct1.acctNo, branch:branchInstance, 
                                                debitAmt:atmTxnInstance.txnAmt,txnDate:branchInstance.runDate, 
                                                bal:acct1.ledgerBalAmt, txnFile:txnFile1Instance, 
                                                currency:acct1.product.currency, status:2, txnType:atmFtDr.txnType, 
                                                txnRef:atmTxnInstance.txnRef, txnCode:atmFtDr.code, user:ATMUSerID)

                                            def acctLedger2Instance = new TxnDepositAcctLedger(acct:acct2, 
                                                acctNo:acct2.acctNo, branch:acct2.branch, 
                                                debitAmt:atmTxnInstance.txnAmt,txnDate:branchInstance.runDate, 
                                                bal:acct2.ledgerBalAmt,txnFile:txnFile2Instance, 
                                                currency:acct2.product.currency, status:2, txnType:atmFtCr.txnType, 
                                                txnRef:atmTxnInstance.txnRef,txnCode:atmFtCr.code, user:ATMUSerID)
                                            
                                            txnFile1Instance.save(flush:true)
                                            txnFile2Instance.save(flush:true)
                                            acctLedger1Instance.save(flush:true,failOnError:true)
                                            acctLedger2Instance.save(flush:true,failOnError:true)
                                            glTransactionService.saveTxnBreakdown(txnFile1Instance.id)
                                            glTransactionService.saveTxnBreakdown(txnFile2Instance.id)
                                            //atmTxnInstance.txnFile1 = txnFile1Instance
                                            //atmTxnInstance.txnFile2 = txnFile2Instance
                                            
                                        } else if(params.reqCode == "0420"){
                                            if(!elementArray[9].equals("")){ // SEQ
                                                // CHECK IF TRANSACTION IS ALREADY REVERSED
                                                def atmTxnRevInstance = AtmTxn.findByTxnRef(atmTxnInstance.txnRef)
                                                if(atmTxnRevInstance){
                                                    if(atmTxnRevInstance.isReversed == true)
                                                        elementArray.putAt(37, "05") // Catch all
                                                    else{
                                                        atmTxnInstance.txnAmt = elementArray[2].toDouble()
                                                        atmTxnRevInstance.isReversed = true
                                                        atmTxnRevInstance.save(flush:true)
                                                        acct1.ledgerBalAmt += atmTxnInstance.txnAmt
                                                        acct1.availableBalAmt += atmTxnInstance.txnAmt
                                                        acct1.interestBalAmt += atmTxnInstance.txnAmt
                                                        acct2.ledgerBalAmt -= atmTxnInstance.txnAmt
                                                        acct2.availableBalAmt -= atmTxnInstance.txnAmt
                                                        acct2.interestBalAmt -= atmTxnInstance.txnAmt
                                                        responseMti = "0430"
                                                        def acctLedgerRevInstance = new TxnDepositAcctLedger(acctNo:txnFileRevInstance.acctNo,  branch:branchInstance.id, acctId:txnFileRevInstance.depAcctId, creditAmt:atmTxnInstance.txnAmt, txnDate:branchInstance.runDate, bal:acct1.availableBalAmt,txnFile:txnFileRevInstance.id, currency:nCurrency, status:2, txnType:9, txnRef:'ATM FT-Reversal')
                                                        acctLedgerRevInstance.save(flush:true)                                                        
                                                        glTransactionService.reverseTxn(atmTxnRevInstance.txnFile1)
                                                    }
                                                } else
                                                    elementArray.putAt(37, "05") // Catch all
                                            } else
                                                elementArray.putAt(37, "05") // Catch all
                                        }
                                    }
                                }
                            } else { // Account does not exist!
                                if(acct2Type == "10")
                                    elementArray.putAt(37, "53")
                                else if(acct2Type == "20")
                                    elementArray.putAt(37, "52")
                            }
                         }
                        }
                    }
                }
                def msg = "";
                double availableBal, ledgerBal, unclearedFunds;

                availableBal =  acct1.availableBalAmt.toDouble() * 100;
                ledgerBal = acct1.ledgerBalAmt.toDouble() * 100;
                
                unclearedFunds = ledgerBal - availableBal;
                
                msg = new StringBuilder().append(msg).append(acctType).append("01608C").append(String.format("%12.0f", ledgerBal).replace(" ", "0")).toString()
                msg = new StringBuilder().append(msg).append(acctType).append("02608C").append(String.format("%12.0f", availableBal).replace(" ", "0")).toString()
                msg = new StringBuilder().append(msg).append(acctType).append("03608C").append(String.format("%12.0f", unclearedFunds).replace(" ", "0")).toString()

               // String aString = Double.toString(ledgerBal);
                //aString = String.format("%12s",aString);
               // println "aString :"+aString
                
                elementArray.putAt(52, msg)
            }
            else{ // Account does not exist!
                if(acctType == "10")
                    elementArray.putAt(37, "53")
                else if(acctType == "20")
                    elementArray.putAt(37, "52")
            }
        }
      
        // ****************************************************************************
        // 5. CREATE REPLY MESSAGE
        // ****************************************************************************
        
        println "elementArray :"+elementArray
        def atmTableInstance = AtmTable.findByAtmTxnCodeAndMti(elementArray[1],params.reqCode)
        //def atmMti = AtmTable.findByAtmTxnCodeAndMti(elementArray[1],params.reqCode)
        def atmBitmapInstance
        def bitValLength = 0
        String[] tokens = atmTableInstance.bitEnabled.split(delims)
        
        println "tokens "+tokens
        
        if(new String(txnType) == "21"){
           elementArray.putAt(16, "0000") // merchant
           elementArray.putAt(35, "000000000000") // retrieval ref number
           elementArray.putAt(47, "608")  // currency code
        }
        
        if(new String(txnType) == "92"){ // mini statement
           
            println "mini statement"
            def db = new Sql(dataSource)
            def acctMiniStatement = db.rows("select (select count(*) from txn_deposit_acct_ledger where acct_no = '"+acctNo1+"') as totCount,txn_date as txnDate,txn_ref as txnRef,case when credit_amt != 0 then credit_amt when debit_amt !=0 then debit_amt else 0 end as trnAmount,bal from txn_deposit_acct_ledger where acct_no='"+acctNo1+"' order by id desc")
            
            def miniStat = ''
           
               for(i=1; i <= acctMiniStatement[1].totCount; i++){
                if (i > 10){
                    break
                }                   
                def tDate = acctMiniStatement[i-1].txnDate.toString()
                miniStat = miniStat + tDate.substring(0,10) + ' ' + acctMiniStatement[i-1].txnRef + ' ' + String.format("%12.2f", acctMiniStatement[i-1].trnAmount) + ' ' + String.format("%12.2f", acctMiniStatement[i-1].bal) 
                if (i != acctMiniStatement[1].totCount){
                    if (i != 10){
                       miniStat = miniStat + ';'
                    }
                }
               }

            println "miniStat :"+miniStat
            elementArray.putAt(125, miniStat)
        }        
        
        if(elementArray[37].equals(""))
            elementArray.putAt(37, "00") // Transaction OK!
        for(i = 0; i < tokens.length; i++){
            bitValue = elementArray[tokens[i].toInteger()-2]
            println "bitValue :"+bitValue
            atmBitmapInstance = AtmBitmap.findByElementNo(tokens[i].toInteger())
            if(atmBitmapInstance){
                if(atmBitmapInstance.isVar == true){
                    println "header format :"+String.format("%"+atmBitmapInstance.length+"s", bitValue.length()).replace(" ", "0").toString()
                    //bitValLength = (bitValue.length()).toString()
                    bitValLength = String.format("%"+atmBitmapInstance.length+"s", bitValue.length()).replace(" ", "0").toString()
                    response2 = new StringBuilder().append(response2).append(bitValLength).append(bitValue).toString()
                    responseLength += bitValLength.length()
                }
                else
                    response2 = new StringBuilder().append(response2).append(bitValue).toString()
                    
                newBinBitmap.putAt(tokens[i].toInteger()-1, '1')
                responseLength += bitValue.length()
            }
        }
        k = 0
        for(i = 0; i < 8; i++){
            for(j = 0; j < 16; j++){
                hex.putAt(j, newBinBitmap[k])
                //println "newBinBitmap :"+newBinBitmap[k]
                if(k < 128)
                    k++
            }
            decimal = Integer.parseInt(new String(hex),2)
            hexStr1 = Integer.toString(decimal,16)
            println "hexStr1 :"+hexStr1

            hexStr2 = new StringBuilder().append(hexStr2).append(String.format("%4s", hexStr1).replace(" ", "0")).toString()
            tokens = tokens.toString()
        }
        responseLength += 36
        response2 = new StringBuilder().append(String.format("%4s", responseLength.toString()).replace(" ", "0")).append(responseMti).append(hexStr2).append(response2).toString()
        def atmMsgResponseInstance = new AtmMsgResponse(destinationIp:params.sourceIp, msgLength:responseLength, dateSent:new Date(), msgContent:response2)
        atmMsgResponseInstance.save(flush:true,failOnError:true)
        atmTxnInstance.responseDate = new Date()
        atmTxnInstance.responseMsg = atmMsgResponseInstance
        
        if(params.reqCode == "0420") {
            def d = Deposit.findByAcctNo(atmTxnInstance.acct1) 
            println atmTxnInstance.txnAmt+" amount"
             println d.ledgerBalAmt + " amount"
             println d.availableBalAmt + " amount"
         atmTxnInstance.bal1 = d.ledgerBalAmt 
                                                    //println "DDD"
        atmTxnInstance.bal2 = d.availableBalAmt 
        }
        atmTxnInstance.save(flush:true)
        if(response2.length() == responseLength){
            jsonObject = jsonObject.put('response', response2)
        }
        else{
            response2 = response2.replaceAll("\\n", "");
            response2 = response2.replaceAll("\\r", "");
            jsonObject = jsonObject.put('response', response2)
        }        
        println "response2 :"+response2
        render jsonObject
        return
    }   
}
