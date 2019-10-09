package icbs.tellering

import grails.transaction.Transactional
import groovy.json.JsonBuilder
import grails.converters.JSON
import grails.converters.deep.JSON
import javax.servlet.http.HttpSession
import java.text.DecimalFormat
import org.springframework.web.context.request.RequestContextHolder
import icbs.cif.Customer
import icbs.tellering.TxnBillsPayment
import icbs.loans.Loan
import icbs.loans.LoanInstallment
import icbs.loans.LoanLedger
import icbs.lov.LoanInstallmentStatus
import icbs.deposit.Deposit
import icbs.lov.TxnType
import icbs.admin.CheckDepositClearingType
import icbs.admin.TxnTemplate
import icbs.lov.CheckStatus
//add d2
import icbs.lov.TxnCheckStatus
import icbs.lov.ConfigItemStatus
import icbs.lov.DepositStatus
import icbs.lov.RolloverStatus
import icbs.tellering.TxnFile
import icbs.admin.Branch
import icbs.admin.UserMaster
import icbs.admin.Currency
import icbs.admin.CurrencyDetail
import icbs.admin.ProductTxn
import icbs.admin.PolicyException
import icbs.admin.Institution
import icbs.lov.ProductType
import icbs.deposit.Rollover
import groovy.sql.Sql
import icbs.tellering.TxnDepositAcctLedger
import icbs.tellering.TxnTellerBalance
import icbs.lov.YesNoNa
import icbs.lov.MemoTxnType
import icbs.lov.LoanAcctStatus
import icbs.tellering.TxnReversal								 
//added akdsauli
import icbs.deposit.Cheque
import icbs.deposit.StopPaymentOrder
import icbs.deposit.Chequebook
import org.hibernate.Session
import org.hibernate.SessionFactory							
										  

@Transactional
class TelleringController {
    
    def depositService
 //declared var for jasper params
    def jasperService
    def transactionFileId 
    def prevTxnDepAcctLedgerId
    def map
    def jrxmlTcId 
    def reprintPb
    def passbookline 
    def pbvalidate //account id
    def txnDepAccMinId 
    def userMasterId
    def type
    def pbList
    def pbPrintCode
    
    def userMasterService
    def policyService
    def glTransactionService
    def dataSource
    def depCheckOnusBal
    def auditLogService
    
    static allowedMethods = [save: "POST", update: ["PUT","POST"], delete: "DELETE"]
    def takeAction() {
        def txnFileInstance = TxnFile.get(params.txnFileInstanceId)
        if (txnFileInstance == null) {
            notFound()
            return
        }
        policyService.takeAction(txnFileInstance, ConfigItemStatus, 'txnFile', (boolean)params.isApproved)
    }
    
    
 /*PASSBOOK PRINTING --*/
     def printPassbookTransactions(){
         def txn = TxnFile.get(params.txnId.toInteger())
         //def pbLedger = TxnDepositAcctLedger.get(jrxmlTcId)
         def pbLedger = TxnDepositAcctLedger.findByTxnFile(txn)
         reprintPb = false
         render(view:'/tellering/printPassbookTransactions', model: [pbLedger:pbLedger])
         return    
     }
     
     def reprintPassbookShow(TxnDepositAcctLedger txnDepositAcctLedgerInstance) {
         def pbLedger = txnDepositAcctLedgerInstance
         session["jrxmlTcId"] = pbLedger.id
         println '...' + session["jrxmlTcId"]
         jrxmlTcId = pbLedger.id
         println '...' + pbLedger.id
         reprintPb = true
         render(view:'/tellering/reprintPassbookShow', model: [pbLedger:pbLedger])
         return      
     }
    
    def savePbLine(){
        println("PUMASOK SA savePbLine");         
        def pbLedger= TxnDepositAcctLedger.get(Integer.valueOf(params.ledgerId.toString().replace(',','')));
                   
        def pbLineNo = params.passbookLine.toInteger()
         println '......' + pbLedger
         println '......' + pbLineNo
         println '......' + session["type"]

         if (pbLineNo <= 0) {
             flash.message = 'Invalid line number'
             render(view:'/tellering/printPassbookTransactions', model: [pbLedger:pbLedger])
             return             
         }

//        // for current account use another function 
//	if (session["type"] == 2) {
//            if (pbLedger) {
//                savePbLineCa(pbLedger.id, pbLineNo)
//            } else {
//                savePbLineCa(0, pbLineNo)
//            }
//            
//            render(view:'/tellering/savePbLine', model: [pbLedger:pbLedger, pbLineNo:pbLineNo])
//            return
//        }
//        
//        // for time deposit use another function 
//	if (session["type"] == 3) {
//            if (pbLedger) {
//                savePbLineCa(pbLedger.id, pbLineNo)
//            } else {
//                savePbLineCa(0, pbLineNo)
//            }
//            render(view:'/tellering/savePbLine', model: [pbLedger:pbLedger, pbLineNo:pbLineNo])
//            return            
//        }
        
        // this is for savings
         if (session["type"] == 1 || session["type"] == 2) {
             def acct = TxnDepositAcctLedger.get(Integer.valueOf(params.ledgerId.toString().replace(',',''))).acct
             def tf = TxnDepositAcctLedger.get(Integer.valueOf(params.ledgerId.toString().replace(',',''))).txnFile
             def unposted = TxnDepositAcctLedger.findAllByAcctAndPassbookBalAndTxnFileLessThan(acct,0,tf, [sort: "txnFile", order: "asc"])
             List<String> list = new ArrayList<String>();
             def pbLine = new StringBuilder()
             def curLine = new StringBuilder()
             def balFwd = 0D
             def ledger = TxnDepositAcctLedger.get(Integer.valueOf(params.ledgerId.toString().replace(',',''))) 
             // for reprint
             if (reprintPb) {
                 println ('pumasok sa reprint')
                 tf = TxnDepositAcctLedger.get(Integer.valueOf(params.ledgerId.toString().replace(',',''))).txnFile
                 unposted = TxnDepositAcctLedger.findAllByAcctAndTxnFileGreaterThanEquals(acct,tf, [sort: "id", order: "asc"])                 
                 ledger = null
                 println 'reprint......'
                 println acct
                 println tf
                 println unposted
             }
             // create spaces for lines
             
             for (int i = 1; i < pbLineNo; i++) {
                 list.add(" ")
                 // add provision for middle
             }
            
             
            if (pbLineNo > 1){
                list.add(" ")
            }
             // build current transaction
             def isMiddle = true    
             
             // build unposted transactions
             if (unposted) {
                 for (up in unposted) {
                     pbLine = new StringBuilder()                     
                     // balance forwarded 
                     if (pbLineNo == 1 && up.acct.dateOpened != up.acct.branch.runDate) {
                         pbLine.append(up.txnDate.format("MM/dd/yyyy")).append("|BalanceForwarded") 
                         pbLine.append("|||")
                             
                         if (up.debitAmt > 0) {
                             balFwd = up.bal + up.debitAmt
                         } else {
                             balFwd = up.bal - up.creditAmt
                         }
                         def bfdf = new DecimalFormat("###,###,##0.00");
                         pbLine.append(bfdf.format(balFwd))   
                         list.add(pbLine)
                         pbLine = new StringBuilder()
                         
                     }
                                                           
                     // adjust for middle
                     if (pbLineNo > 13 && isMiddle){
                         list.add(" ")
                         list.add(" ")
                         list.add(" ")
                         isMiddle = false
                     }                        
                     pbLine.append(up.txnDate.format("MM/dd/yyyy")).append("|")
                     pbLine.append(up.txnFile.txnTemplate.shortDescription).append("|")
                     if (up.debitAmt > 0) {
                         def ddf = new DecimalFormat("###,###,##0.00");
                         pbLine.append(ddf.format(up.debitAmt)).append("|")
                     } else {
                         pbLine.append("|").append("")
                     }
                     if (up.creditAmt > 0) {
                         def cdf = new DecimalFormat("###,###,##0.00");
                         pbLine.append(cdf.format(up.creditAmt)).append("|")
                     } else {
                         pbLine.append("|").append("")
                     }                       
                     def bdf = new DecimalFormat("###,###,##0.00");
                     pbLine.append(bdf.format(up.bal)).append("|")  
                         
	
                     pbLine.append(String.format("%02d",pbLineNo)).append("|")
                     if(up.acct.type.id == 2){
                         pbLine.append(up.txnRef)
                     }
                     list.add(pbLine)
                     up.passbookBal = up.acct.ledgerBalAmt
                     up.save(flush:true)
                     pbLineNo++
                     if (pbLineNo == 26) {
                         pbLineNo = 1
                         isMiddle = true
                     }
                 }
                 // check for middle in case last unposted is near middle
                 if (pbLineNo > 13 && isMiddle){
                     list.add(" ")
                     list.add(" ")
                     list.add(" ")
                     isMiddle = false
                 }      
                 
                // add current transaction   
                 if (ledger) {                     
                     // if last unposted means new page, add balance forwarded
                     if (pbLineNo == 1 && ledger.acct.dateOpened != ledger.acct.branch.runDate) {
                         pbLine = new StringBuilder()
                         pbLine.append(ledger.txnDate.format("MM/dd/yyyy")).append("|BalanceForwarded") 
                         pbLine.append("|||")
                         
                         if (ledger.debitAmt > 0) {
                             balFwd = ledger.bal + ledger.debitAmt
                         } else {
                             balFwd = ledger.bal - ledger.creditAmt
                         }
                         def bfdf = new DecimalFormat("###,###,##0.00");
                         pbLine.append(bfdf.format(balFwd))                         
                        
                     } 
                                                              
                     curLine.append(ledger.txnDate.format("MM/dd/yyyy")).append("|")
                     curLine.append(ledger.txnFile.txnTemplate.shortDescription).append("|")
                     if (ledger.debitAmt > 0) {
                        def cddf = new DecimalFormat("###,###,##0.00");	
                        curLine.append(cddf.format(ledger.debitAmt)).append("|")
                    } else {
                        curLine.append("|").append("")
                    }
                    if (ledger.creditAmt > 0) {
                         def ccdf = new DecimalFormat("###,###,##0.00");
                         curLine.append(ccdf.format(ledger.creditAmt)).append("|")
                     } else {
                         curLine.append("|").append("")
                     } 
                     def cbdf = new DecimalFormat("###,###,##0.00");
                     curLine.append(cbdf.format(ledger.bal)).append("|")  
                     curLine.append(String.format("%02d",pbLineNo)).append("|")
                     if(ledger.acct.type.id == 2){
                         curLine.append(ledger.txnRef)
                     }
                    
                }
                list.add(curLine)
			  
             } else {
                 // no unposted just print current line
                 // as needed add balance forward                        }
                 println '<<<< CURRENT LINE >>>>>'                 
                 if (pbLineNo == 1 && ledger.acct.dateOpened != ledger.acct.branch.runDate) {
                     pbLine = new StringBuilder()
                     pbLine.append(ledger.txnDate.format("MM/dd/yyyy")).append("|BalanceForwarded") 
                     pbLine.append("|||")
                     
                         if (ledger.debitAmt > 0) {
                         balFwd = ledger.bal + ledger.debitAmt
                     } else {
                         balFwd = ledger.bal - ledger.creditAmt
                     }
                     def bfdf = new DecimalFormat("###,###,##0.00");
                     pbLine.append(bfdf.format(balFwd))    
					 
                     list.add(pbLine)                   
                   
                 } 
                 
                  // check for middle and adjust
             if (pbLineNo > 13) {
                 list.add(" ")
                 list.add(" ")
                 list.add(" ")     
             }
                                                       
                 //pbLine.append(ledger.txnDate.format("MM/dd/yyyy")).append("  ").append(String.format("%02d",ledger.passbookLine))
                 // println '>>>' + pbLine 
                 
                 if (ledger) {
                     curLine.append(ledger.txnDate.format("MM/dd/yyyy")).append("|")
                     curLine.append(ledger.txnFile.txnTemplate.shortDescription).append("|")
                     if (ledger.debitAmt > 0) {
                         def cddf = new DecimalFormat("###,###,##0.00");
                         curLine.append(cddf.format(ledger.debitAmt)).append("|")
                     } else {
                         curLine.append("|").append("")
                     }
                     if (ledger.creditAmt > 0) {
                         def ccdf = new DecimalFormat("###,###,##0.00");
                         curLine.append(ccdf.format(ledger.creditAmt)).append("|")
                     } else {
                         curLine.append("|").append("")
                     }                       
                     def cbdf = new DecimalFormat("###,###,##0.00");
                     curLine.append(cbdf.format(ledger.bal)).append("|")  
                     curLine.append(String.format("%02d",pbLineNo)).append("|")
                     if(ledger.acct.type.id == 2){
                         curLine.append(ledger.txnRef)
                     }                    
                 }                 
                 list.add(curLine)
                 println '----' + list
             }
             
            pbList = list
                
         }

         // end of passbook list implementation
         // need to change jasper output
         // pass as paramter the list
         def strPb
         pbPrintCode = UserMaster.get(session.user_id).username + new Date().toString()
									 
         for (int i = 0; i < pbList.size(); i++) {
             strPb = pbList.get(i);
             def x = new TxnPassbookLine(pbCode:pbPrintCode, pbLine:strPb)
             x.save(flush:true)
         }           
         render(view:'/tellering/savePbLine', model: [pbLedger:pbLedger, pbLineNo:pbLineNo]) 
     
         
    }
    def savePbLineCa(Integer pbLedgerId, Integer pbLineNoId){
         def pbLedger = TxnDepositAcctLedger.get(pbLedgerId)
         def pbLineNo = pbLineNoId
         println '......' + pbLedger
         println '......' + pbLineNo
         println '......' + session["type"]

         if (pbLineNo <= 0) {
             flash.message = 'Invalid line number'
             render(view:'/tellering/printPassbookTransactions', model: [pbLedger:pbLedger])
             return             
         }
        
        // this is for savings
         if (session["type"] == 1 || session["type"] == 2) {
             def acct = TxnDepositAcctLedger.get(jrxmlTcId).acct
             def tf = TxnDepositAcctLedger.get(jrxmlTcId).txnFile
             def unposted = TxnDepositAcctLedger.findAllByAcctAndPassbookBalAndTxnFileLessThan(acct,0,tf, [sort: "txnFile", order: "asc"])
             List<String> list = new ArrayList<String>();
             def pbLine = new StringBuilder()
             def curLine = new StringBuilder()
             def balFwd = 0D
             def ledger = TxnDepositAcctLedger.get(jrxmlTcId) 
             // for reprint
             if (reprintPb) {
                 tf = TxnDepositAcctLedger.get(jrxmlTcId).txnFile
                 unposted = TxnDepositAcctLedger.findAllByAcctAndTxnFileGreaterThanEquals(acct,tf, [sort: "txnFile", order: "asc"])
                 ledger = null
                 println 'reprint......'
                 println acct
                 println jrxmlTcId
                 println unposted
             }
             // create spaces for lines
             
             for (int i = 1; i < pbLineNo; i++) {
                 list.add(" ")
                 // add provision for middle
             }
             
             // build current transaction
             def isMiddle = true    
             
             // build unposted transactions
             if (unposted) {
                 for (up in unposted) {
                     pbLine = new StringBuilder()
                     // balance forwarded 
                     if (pbLineNo == 1 && up.acct.dateOpened != up.acct.branch.runDate) {
                         pbLine.append(up.txnDate.format("MM/dd/yyyy")).append("|BalanceForwarded") 
                         pbLine.append("|||")
                             
                         if (up.debitAmt > 0) {
                             balFwd = up.bal + up.debitAmt
                         } else {
                             balFwd = up.bal - up.creditAmt
                         }
                         def bfdf = new DecimalFormat("###,###,##0.00");
                         pbLine.append(bfdf.format(balFwd))   
                         list.add(pbLine)
                         pbLine = new StringBuilder()
                     }   
                     
                     // adjust for middle
                     if (pbLineNo > 13 && isMiddle){
                         list.add(" ")
                         list.add(" ")  
                         list.add(" ")
                         isMiddle = false
                     }                        
                     pbLine.append(up.txnDate.format("MM/dd/yyyy")).append("|")
                     pbLine.append(up.txnFile.txnTemplate.shortDescription).append("|")
                     if (up.debitAmt > 0) {
                         def ddf = new DecimalFormat("###,###,##0.00");
                         pbLine.append(ddf.format(up.debitAmt)).append("|")
                     } else {
                         pbLine.append("|").append("")
                     }
                     if (up.creditAmt > 0) {
                         def cdf = new DecimalFormat("###,###,##0.00");
                         pbLine.append(cdf.format(up.creditAmt)).append("|")
                     } else {
                         pbLine.append("|").append("")
                     }                       
                     def bdf = new DecimalFormat("###,###,##0.00");
                     pbLine.append(bdf.format(up.bal)).append("|")  
                         
	
                     pbLine.append(String.format("%02d",pbLineNo))
                     list.add(pbLine)
                     up.passbookBal = up.acct.ledgerBalAmt
                     up.save(flush:true)
                     pbLineNo++
                     if (pbLineNo == 26) {
                         pbLineNo = 1
                         isMiddle = true
                     }
                 }
                 // check for middle in case last unposted is near middle
                 if (pbLineNo > 13 && isMiddle){
                     list.add(" ")
                     list.add(" ")  
                     list.add(" ")
                     isMiddle = false
                 }      
                      
                 // add current transaction   
                 if (ledger) {
                     // if last unposted means new page, add balance forwarded
                     if (pbLineNo == 1 && ledger.acct.dateOpened != ledger.acct.branch.runDate) {
                         pbLine = new StringBuilder()
                         pbLine.append(ledger.txnDate.format("MM/dd/yyyy")).append("|BalanceForwarded") 
                         pbLine.append("|||")
                         
                         if (ledger.debitAmt > 0) {
                             balFwd = ledger.bal + ledger.debitAmt
                         } else {
                             balFwd = ledger.bal - ledger.creditAmt
                         }
                         def bfdf = new DecimalFormat("###,###,##0.00");
                         pbLine.append(bfdf.format(balFwd))                       
                     }                     
                     curLine.append(ledger.txnDate.format("MM/dd/yyyy")).append("|")
                     curLine.append(ledger.txnFile.txnTemplate.shortDescription).append("|")
                     if (ledger.debitAmt > 0) {
                        def cddf = new DecimalFormat("###,###,##0.00");	
                        curLine.append(cddf.format(ledger.debitAmt)).append("|")
                    } else {
                        curLine.append("|").append("")
                    }
                    if (ledger.creditAmt > 0) {
                         def ccdf = new DecimalFormat("###,###,##0.00");
                         curLine.append(ccdf.format(ledger.creditAmt)).append("|")
                     } else {
                         curLine.append("|").append("")
                     } 
                     def cbdf = new DecimalFormat("###,###,##0.00");
                     curLine.append(cbdf.format(ledger.bal)).append("|")  
                     curLine.append(String.format("%02d",pbLineNo))
                    
		  
                }
                list.add(curLine)
				 
             } else {
                 // no unposted just print current line
                 // as needed add balance forward
                 println '<<<< CURRENT LINE >>>>>'
                 if (pbLineNo == 1 && ledger.acct.dateOpened != ledger.acct.branch.runDate) {
                     pbLine = new StringBuilder()
                     pbLine.append(ledger.txnDate.format("MM/dd/yyyy")).append("|BalanceForwarded") 
                     pbLine.append("|||")
                     
                         if (ledger.debitAmt > 0) {
                         balFwd = ledger.bal + ledger.debitAmt
                     } else {
                         balFwd = ledger.bal - ledger.creditAmt
                     }
                     def bfdf = new DecimalFormat("###,###,##0.00");
                     pbLine.append(bfdf.format(balFwd))    
                     list.add(pbLine)
                 }
                  // check for middle and adjust
             if (pbLineNo > 13) {
                 list.add(" ")
                 list.add(" ")
                 list.add(" ")
                 
             }
                 //pbLine.append(ledger.txnDate.format("MM/dd/yyyy")).append("  ").append(String.format("%02d",ledger.passbookLine))
                 // println '>>>' + pbLine 
                 
                 if (ledger) {
                     curLine.append(ledger.txnDate.format("MM/dd/yyyy")).append("|")
                     curLine.append(ledger.txnFile.txnTemplate.shortDescription).append("|")
                     if (ledger.debitAmt > 0) {
                         def cddf = new DecimalFormat("###,###,##0.00");
                         curLine.append(cddf.format(ledger.debitAmt)).append("|")
                     } else {
                         curLine.append("|").append("")
                     }
                     if (ledger.creditAmt > 0) {
                         def ccdf = new DecimalFormat("###,###,##0.00");
                         curLine.append(ccdf.format(ledger.creditAmt)).append("|")
                     } else {
                         curLine.append("|").append("")
                     }                       
                     def cbdf = new DecimalFormat("###,###,##0.00");
                     curLine.append(cbdf.format(ledger.bal)).append("|")  
                     curLine.append(String.format("%02d",pbLineNo))                    
                 }                 
                 list.add(curLine)
                 println '----' + list
             }
             
            pbList = list
                
         }
         // end of passbook list implementation
         // need to change jasper output
         // pass as paramter the list
         def strPb
         pbPrintCode = UserMaster.get(session.user_id).username + new Date().toString()
         for (int i = 0; i < pbList.size(); i++) {
             strPb = pbList.get(i);
             def x = new TxnPassbookLine(pbCode:pbPrintCode, pbLine:strPb)
             x.save(flush:true)
         }           
         render(view:'/tellering/savePbLine', model: [pbLedger:pbLedger, pbLineNo:pbLineNo]) 
     
         
    }
    def savePbLineTd(){
         println("PUMASOK SA savePbLineTD");         
        def pbLedger= TxnDepositAcctLedger.get(Integer.valueOf(params.ledgerId.toString().replace(',','')));
                   
        def pbLineNo = params.passbookLine.toInteger()
         println '......' + pbLedger
         println '......' + pbLineNo
         println '......' + session["type"]

         if (pbLineNo <= 0) {
             flash.message = 'Invalid line number'
             render(view:'/tellering/printPassbookTransactions', model: [pbLedger:pbLedger])
             return             
         }
        
        // this is for savings
         if (session["type"] == 3) {
             def acct = TxnDepositAcctLedger.get(Integer.valueOf(params.ledgerId.toString().replace(',',''))).acct
             def tf = TxnDepositAcctLedger.get(Integer.valueOf(params.ledgerId.toString().replace(',',''))).txnFile
             def unposted = TxnDepositAcctLedger.findAllByAcctAndPassbookBalAndTxnFileLessThan(acct,0,tf, [sort: "txnFile", order: "asc"])
             List<String> list = new ArrayList<String>();
             def pbLine = new StringBuilder()
             def curLine = new StringBuilder()
             def balFwd = 0D
             def ledger = TxnDepositAcctLedger.get(Integer.valueOf(params.ledgerId.toString().replace(',',''))) 
             // for reprint
             if (reprintPb) {
                 tf = TxnDepositAcctLedger.get(Integer.valueOf(params.ledgerId.toString().replace(',',''))).txnFile
                 unposted = TxnDepositAcctLedger.findAllByAcctAndTxnFileGreaterThanEquals(acct,tf, [sort: "id", order: "asc"])
                 ledger = null
                 println 'reprint......'
                 println acct
                 println tf
                 println unposted
             }
             // create spaces for lines
             
             for (int i = 1; i < pbLineNo; i++) {
                 list.add(" ")
                 // add provision for middle
             }
              
             
            if (pbLineNo > 1){
                list.add(" ")
            }
             // build current transaction
             def isMiddle = true    
             
             // build unposted transactions
             if (unposted) {
                 for (up in unposted) {
                     pbLine = new StringBuilder()
                     // balance forwarded 
                     if (pbLineNo == 1 && up.acct.dateOpened != up.acct.branch.runDate) {
                         pbLine.append(up.txnDate.format("MM/dd/yyyy")).append("|BalanceForwarded") 
                         pbLine.append("|||")
                             
                         if (up.debitAmt > 0) {
                             balFwd = up.bal + up.debitAmt
                         } else {
                             balFwd = up.bal - up.creditAmt
                         }
                         def bfdf = new DecimalFormat("###,###,##0.00");
                         pbLine.append(bfdf.format(balFwd))   
                         list.add(pbLine)
                         pbLine = new StringBuilder()
                     }   
                     
                     // adjust for middle
                     if (pbLineNo > 13 && isMiddle){
                         list.add(" ")
                         list.add(" ")
                         list.add(" ")
                         isMiddle = false
                     }                        
                     pbLine.append(up.txnDate.format("MM/dd/yyyy")).append("|")
                     pbLine.append(up.txnFile.txnTemplate.shortDescription).append("|")
                     if (up.debitAmt > 0) {
                         def ddf = new DecimalFormat("###,###,##0.00");
                         pbLine.append(ddf.format(up.debitAmt)).append("|")
                     } else {
                         pbLine.append("|").append("")
                     }
                     if (up.creditAmt > 0) {
                         def cdf = new DecimalFormat("###,###,##0.00");
                         pbLine.append(cdf.format(up.creditAmt)).append("|")
                     } else {
                         pbLine.append("|").append("")
                     }                       
                     def bdf = new DecimalFormat("###,###,##0.00");
                     pbLine.append(bdf.format(up.bal)).append("|")  
                         
	
                     pbLine.append(String.format("%02d",pbLineNo))
                     list.add(pbLine)
                     up.passbookBal = up.acct.ledgerBalAmt
                     up.save(flush:true)
                     pbLineNo++
                     if (pbLineNo == 26) {
                         pbLineNo = 1
                         isMiddle = true
                     }
                 }
                 // check for middle in case last unposted is near middle
                 if (pbLineNo > 13 && isMiddle){
                     list.add(" ")
                     list.add(" ")
                      list.add(" ")
                     isMiddle = false
                 }      
                      
                 // add current transaction   
                 if (ledger) {
                     // if last unposted means new page, add balance forwarded
                     if (pbLineNo == 1 && ledger.acct.dateOpened != ledger.acct.branch.runDate) {
                         pbLine = new StringBuilder()
                         pbLine.append(ledger.txnDate.format("MM/dd/yyyy")).append("|BalanceForwarded") 
                         pbLine.append("|||")
                         
                         if (ledger.debitAmt > 0) {
                             balFwd = ledger.bal + ledger.debitAmt
                         } else {
                             balFwd = ledger.bal - ledger.creditAmt
                         }
                         def bfdf = new DecimalFormat("###,###,##0.00");
                         pbLine.append(bfdf.format(balFwd))                       
                     }                     
                     curLine.append(ledger.txnDate.format("MM/dd/yyyy")).append("|")
                     curLine.append(ledger.txnFile.txnTemplate.shortDescription).append("|")
                     if (ledger.debitAmt > 0) {
                        def cddf = new DecimalFormat("###,###,##0.00");	
                        curLine.append(cddf.format(ledger.debitAmt)).append("|")
                    } else {
                        curLine.append("|").append("")
                    }
                    if (ledger.creditAmt > 0) {
                         def ccdf = new DecimalFormat("###,###,##0.00");
                         curLine.append(ccdf.format(ledger.creditAmt)).append("|")
                     } else {
                         curLine.append("|").append("")
                     } 
                     def cbdf = new DecimalFormat("###,###,##0.00");
                     curLine.append(cbdf.format(ledger.bal)).append("|")  
                     curLine.append(String.format("%02d",pbLineNo))
                    
		  
                }
                list.add(curLine)
             } else {
                 // no unposted just print current line
                 // as needed add balance forward
                 println '<<<< CURRENT LINE >>>>>'
                 if (pbLineNo == 1 && ledger.acct.dateOpened != ledger.acct.branch.runDate) {
                     pbLine = new StringBuilder()
                     pbLine.append(ledger.txnDate.format("MM/dd/yyyy")).append("|BalanceForwarded") 
                     pbLine.append("|||")
                     
                         if (ledger.debitAmt > 0) {
                         balFwd = ledger.bal + ledger.debitAmt
                     } else {
                         balFwd = ledger.bal - ledger.creditAmt
                     }
                     def bfdf = new DecimalFormat("###,###,##0.00");
                     pbLine.append(bfdf.format(balFwd))    
                     list.add(pbLine)
                 }
                 
                // check for middle and adjust
             if (pbLineNo > 13) {
                 list.add(" ")
                 list.add(" ")
                 list.add(" ")
             }
                 //pbLine.append(ledger.txnDate.format("MM/dd/yyyy")).append("  ").append(String.format("%02d",ledger.passbookLine))
                 // println '>>>' + pbLine 
                 
                 if (ledger) {
                     curLine.append(ledger.txnDate.format("MM/dd/yyyy")).append("|")
                     curLine.append(ledger.txnFile.txnTemplate.shortDescription).append("|")
                     if (ledger.debitAmt > 0) {
                         def cddf = new DecimalFormat("###,###,##0.00");
                         curLine.append(cddf.format(ledger.debitAmt)).append("|")
                     } else {
                         curLine.append("|").append("")
                     }
                     if (ledger.creditAmt > 0) {
                         def ccdf = new DecimalFormat("###,###,##0.00");
                         curLine.append(ccdf.format(ledger.creditAmt)).append("|")
                     } else {
                         curLine.append("|").append("")
                     }                       
                     def cbdf = new DecimalFormat("###,###,##0.00");
                     curLine.append(cbdf.format(ledger.bal)).append("|")  
                     curLine.append(String.format("%02d",pbLineNo))                    
                 }                 
                 list.add(curLine)
                 println '----' + list
             }
             
            pbList = list
                
         }
         // end of passbook list implementation
         // need to change jasper output
         // pass as paramter the list
         def strPb
         pbPrintCode = UserMaster.get(session.user_id).username + new Date().toString()
         for (int i = 0; i < pbList.size(); i++) {
             strPb = pbList.get(i);
             def x = new TxnPassbookLine(pbCode:pbPrintCode, pbLine:strPb)
             x.save(flush:true)
         }           
         render(view:'/tellering/savePbLine', model: [pbLedger:pbLedger, pbLineNo:pbLineNo]) 
     
         
    }
    
     def printToPassbookTransactions(){  
         println '***' + pbList
         println '***' + pbPrintCode
         println '***' + session["type"]
         try {        
             if(session["type"] == 1){
                 params._name = "Passbook  Transaction SA"
                 params._format ="PDF"//required caps
                 params._file ="PassbookTransactionSA5.jasper" 
                 params.pbId = pbPrintCode
			
                 //params.printLines = pbList
             }
             else if(session["type"] == 3){
                 params._name = "Passbook Transaction FD"
                 params._format ="PDF"//required caps
                 params._file ="PassbookTransactionSA5.jasper" 
                 //params.id = jrxmlTcId 
                 params.pbId = pbPrintCode
             }
             else if(session["type"] == 2){
                 params._name = "Passbook Transaction CA"
                 params._format ="PDF"
                 params._file ="PassbookTransactionCA.jasper"  
                 //params.id = jrxmlTcId 
                 params.pbId = pbPrintCode
             }
             // build list for unposted transactions
             // unposted transactions are those txn_deposit_acct_ledger with passbook_bal = 0
             // applicable for savings and current accounts
             // can be edited as needed to change the middle and the columns for printing
             // result is printed to jasper as single line
             
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
        }
        catch(Exception e) {
            //deal with your exception here
            e.printStackTrace()
        }
    } 
    
    def createReport = {

        def txnFileInstance = null
        def senderInstance = null
        def beneficiaryInstance = null
        def txnTemplateInstance = null
        String indicator = "BAMF"
        def newtid
        
        txnFileInstance = TxnFile.get(params.tid)
        if(params.tid){
           newtid = (params.tid).toInteger()
        }
        if (txnFileInstance?.sender?.id) {
            senderInstance = Customer.get(txnFileInstance?.sender?.id)
        }
        if (txnFileInstance?.beneficiary?.id){
            beneficiaryInstance = Customer.get(txnFileInstance?.beneficiary?.id)
        }
        if (txnFileInstance?.txnType) {
            int txnTypeNo = txnFileInstance?.txnType.id.toInteger()
            println txnTypeNo
            txnTemplateInstance = TxnTemplate.get(txnTypeNo)
            println txnTemplateInstance.txnType.codeDescription
            if((txnTypeNo >= 1 && txnTypeNo <= 4) || (txnTypeNo >= 118 && txnTypeNo <= 121)){
                indicator = "Teller Cash"
                if(txnTypeNo >= 1 && txnTypeNo <= 2){
                    params._file = "txn_cash_from_vault"
                }
                if(txnTypeNo >= 3 && txnTypeNo <= 4){
                    params._file = "txn_teller_cash_transfer"
                }
                if(txnTypeNo >= 118 && txnTypeNo <= 119){
                    params._file = "txn_checks_to_COCI"
                }
                if(txnTypeNo >= 120 && txnTypeNo <= 121){
                    params._file = "txn_cash_to_vault"
                }
            }
            if((txnTypeNo >= 5 && txnTypeNo <= 32) || (txnTypeNo >= 79 && txnTypeNo <= 86)){
                indicator = "Deposit"
                if(txnTypeNo >= 5 && txnTypeNo <= 12){
                    params._file = "txn_cash_deposit"
                }
                if(txnTypeNo >= 13 && txnTypeNo <= 20){
                    params._file = "txn_check_deposit"
                }
                if(txnTypeNo >= 21 && txnTypeNo <= 30){
                    params._file = "txn_cash_withdrawal"
                }
                if(txnTypeNo >= 31 && txnTypeNo <= 32){
                    params._file = "txn_check_encashment"
                }
                if(txnTypeNo >= 79 && txnTypeNo <= 82){
                    params._file = "txn_fd_interest_withdrawal"
                }
                if(txnTypeNo >= 83 && txnTypeNo <= 86){
                    params._file = "txn_fd_pretermination"
                }
            }
            if(txnTypeNo >= 87 && txnTypeNo <= 117){
                indicator = "Other Cash/Check"
                if((txnTypeNo >= 87 && txnTypeNo <= 89) || (txnTypeNo >= 101 && txnTypeNo <= 103) || (txnTypeNo >= 116 && txnTypeNo <= 117)){
                    params._file = "txn_remittance"
                }
                if((txnTypeNo >= 104 && txnTypeNo <= 109) || (txnTypeNo >= 90 && txnTypeNo <= 95)){
                    params._file = "txn_bills_payment"
                }
                if((txnTypeNo >= 96 && txnTypeNo <= 100)){
                    params._file = "txn_cash_receipt"
                }
                if((txnTypeNo >= 114 && txnTypeNo <= 117)){
                    params._file = "txn_cash_payment"
                }
            }
            if((txnTypeNo >= 56 && txnTypeNo <= 78)){
                indicator = "Loan"
                if((txnTypeNo >= 56 && txnTypeNo <= 57) || (txnTypeNo >= 66 && txnTypeNo <= 69)){
                    params._file = "txn_loan_disbursement"
                }
                if((txnTypeNo >= 58 && txnTypeNo <= 65) || (txnTypeNo >= 70 && txnTypeNo <= 71)){
                    params._file = "txn_loan_payment"
                }
            }
        }
            
        println indicator
        
        println params
        
        def txn = TxnFile.getAll(newtid)
        
        chain(controller:'jasper',action:'index',model:[data:txn],params:params)
        
        return

    }
    
    def index(){ 
        //List of transactions
        session.map = null
    }
    
    def toggleCheckStatus() {
        def check = TxnCOCI.get(params.id)
        def statusTrue = CheckStatus.get(2)
        def statusFalse = CheckStatus.get(1)
        
        if (check){
            if (params.cleared == 'true'){
                check.cleared = 'true'
                check.checkStatus = statusTrue
            }
            else if (params.cleared == 'false'){
                check.cleared = 'false'
                check.checkStatus = statusFalse
            }
            save(flush:true,failOnError:true)
        }
        render ''
    }
    
    def showAddCheckAjax() {    
        render(template:"checks/form") as JSON
        return
    }
    
    def showChecksAjax() {
        render(template:"checks/list") as JSON
        return
    }
    
    def changeForm() {
        println params.checkTypeId
        def checkTypeInstance = CheckDepositClearingType.get(params.checkTypeId)
        
        if(!checkTypeInstance){
            println "debug1"
            notFound()
            return
        } else {
            println "debug2"
            render(template: '/tellering/checks/newForm', model: [checkTypeInstance:checkTypeInstance]) as JSON
            return
        }
    }
    
    def addCheckAjax() {      
        def checkType = params?.checkType
        def bank = params?.bank
        //def acctNo = params?.acctNo
        def checkDate = params?.checkDate
        def checkNo = params?.checkNo
        def clearingDate = params?.checkDate
        def checkAmt = params?.checkAmt
        def checkStatus = CheckStatus.get(1)
//        add d2
        def txnCheckStatus = TxnCheckStatus.get(1)
//        println "Value "+txnCheckStatus

        println params
           
        def check = new TxnCOCI(checkType: checkType, bank: bank, checkDate: checkDate, checkNo: checkNo,  checkAmt: checkAmt, checkStatus: checkStatus, cleared:false)        
        //check.depAcct = Deposit.get(params?.deposit_id)
        check.acctNo = params?.acctNo
        check.clearingDate = Branch.get(1).runDate
        check.branch = UserMaster.get(session.user_id).branch
        check.currency = Currency.get(1)
        check.status = ConfigItemStatus.get(1)
        check.user = UserMaster.get(session.user_id)
//        add d2
        check.txnCheckStatus = txnCheckStatus
        
        if(check.clearingDate < check.checkDate)
        {
            def message = 'Post-dated check is not accepted'
            render(template:"checks/form", model:[check:check,message:message]) as JSON
            return
        }
        //println "CHECK TYPE: " + checkType
        if(!checkType){
            def message = 'Check type is required!'
            render(template:"checks/form", model:[check:check,message:message]) as JSON
            return
        }
        if(!bank)
        {
            if(checkType == '3'){
            }
            else{
                def message = 'bank is required!'
                render(template:"checks/form", model:[check:check,message:message]) as JSON
                return
            }
            
        }
        if(!params?.acctNo){
            def message = 'Account number is required!'
            render(template:"checks/form", model:[check:check,message:message]) as JSON
            return
        }
        if(!checkDate){
            def message = 'Check date is required!'
            render(template:"checks/form", model:[check:check,message:message]) as JSON
            return
        }
        if(!checkNo){
            def message = 'Check number is required!'
            render(template:"checks/form", model:[check:check,message:message]) as JSON
            return
        }
        if(!checkAmt){
            def message = 'Check amount is required!'
            render(template:"checks/form", model:[check:check,message:message]) as JSON
            return
        }
        
        if (!check.validate()) {
            check.errors.each {
            println it
            }    
            def message = 'Validation Error'
            render(template:"checks/form", model:[check:check,message:message]) as JSON
            return
        } 
        
        if(params?.checkType == '3'){
//            println "Checks params: " + params
            def depAcctNo = Deposit.findByAcctNo(params.acctNo)
//            println "Depositors ACCT: " + depAcctNo
            if(depAcctNo != null){
                def depCheckbook = Chequebook.findByDeposit(depAcctNo)
                //def depCheque = Cheque.findByChequebookAndChequeNo(depCheckbook,params.checkNo.toLong())
                def depCheque = Cheque.findByChequeNo(params.checkNo.toLong())
                def depChequeSpo = StopPaymentOrder.findByChequeAndStatus(depCheque, ConfigItemStatus.read(2))
                
                println depChequeSpo
                if(depChequeSpo){
                    def message = 'Check number has an active Stop Payment Order.'
                    render(template:"checks/form", model:[check:check,message:message]) as JSON
                    return
                }
//                println "Depositors ACCT Checkbook: " + depCheckbook
//                println "Depositors ACCT Check: " + depCheque//.chequeNo CheckStatus.get(2),
                // check owner
                
                //if(depCheque){
                if (depCheque.chequebook.deposit.id == depAcctNo.id) {
                    println "depCheque.status " + depCheque.status
                    if(depCheque.status == CheckStatus.get(2)){
//                        def checkTxnCOCI = TxnCOCI.findByAcctNoAndCheckStatusAndCheckNo(params?.acctNo,CheckStatus.get(3),checkNo)
//                        println "CHECK TXNCOCI: " + checkTxnCOCI
//                        
//                        def counterCheck
//                        session["checks"].each { tcoci_id, one,two,three,four,five,six ->
//                            //println "Number: " + tcoci_id
//                            println " test ${tcoci_id} , ${one},${two},${three},${four},${five},${six}"
//                            println "Cheque ${it}"
//                            println "LIST CHECKS ACC: " + session["checks"].acctNo
//                            println "LIST CHECKS CHECKNO: " + session["checks"].checkNo
//                            println "LIST CHECKS TYPE: " + session["checks"].checkType
//                        }
                        //if(checkTxnCOCI == null){
                            if((params?.checkAmt).toDouble() <= (depAcctNo.availableBalAmt).toDouble()){
                                check.cheque = depCheque
                                check.checkStatus = CheckStatus.get(3)
                            }
                            else{
                                def message = 'Check amount is greater than the account balance.'
                                render(template:"checks/form", model:[check:check,message:message]) as JSON
                                return
                            }
//                        }
//                        else{
//                                def message = 'Check number is already used.!'
//                                render(template:"checks/form", model:[check:check,message:message]) as JSON
//                                return
//                            }
                    }
                    else if (depCheque.status == CheckStatus.get(3)){
                            def message = 'Check number is already used...'
                            render(template:"checks/form", model:[check:check,message:message]) as JSON
                            return
                    }
                    else if (depCheque.status == CheckStatus.get(4)){
                            def message = 'Check number is canceled.'
                            render(template:"checks/form", model:[check:check,message:message]) as JSON
                            return
                    }
                    else if (depCheque.status == CheckStatus.get(5)){
                            def message = 'Check number is already cleared.'
                            render(template:"checks/form", model:[check:check,message:message]) as JSON
                            return
                    }
                } else { 
                    def message = 'Check number is not issued to this account.'
                    render(template:"checks/form", model:[check:check,message:message]) as JSON
                    return
                }
            }
            else{
                def message = 'Account number does not exist.'
                render(template:"checks/form", model:[check:check,message:message]) as JSON
                return
            }
        }
        
        check.save(flush:true);
       
        def checks
        if (session["checks"]) {
            checks = session["checks"]
        } else {
            checks = []
        }        
        checks.add(check)
        session["checks"] = checks
        println checks

        def message = "Check successfully added"
        render(template:"checks/form", model:[message:message]) as JSON

        return
    }
    
    def deleteCheckAjax() {
        def id = params?.id?.toInteger()
        session["checks"].remove(id)

        render "success"
        return
    }
    
    def validatePassbookBal() {
        if (!params.acctNo || !params.passbookBal) {
            render(text: false) as JSON
            return
        }

       // def depositInstance = Deposit.findByAcctNo(params.acctNo)
        //println 'PB '+params.passbookBal
       // println 'DI '+depositInstance.passbookBalAmt
        //println 'PR '+Float.parseFloat(params.passbookBal)
        //println  Deposit.findByAcctNo(params.acctNo).passbookBalAmt
       // println Double.parseDouble(('123,122.01').replace(',',''))
        def a = (Float.parseFloat(params.passbookBal)).toString()
        def b = (Deposit.findByAcctNo(params.acctNo).passbookBalAmt).toString()
        //println 'a : '+ a
        //println 'b : '+ b
        if(a == b) {
            render(text: true) as JSON
            return
        } else {
            render(text: false) as JSON
            return
        }
    }

    def showCustomerDetailsAjax(){
        println " params "+params.field
        if(params.customer){
            def customerInstance = Customer.read(params.customer)
            def sql = new Sql(dataSource) 
            def customerId= customerInstance.id.toInteger()
            
            if(!params.field.equals("sender") && !params.field.equals("beneficiary")){
                println " "+params.field
                println " makulit"
                def billspayment = sql.firstRow("select max(txn_file_id) from txn_bills_payment where id = (select max(id) FROM txn_bills_payment where beneficiary_id = "+customerId+")")
                prevTxnDepAcctLedgerId = billspayment.max
                println" bills payment "+prevTxnDepAcctLedgerId
            }
            if(params.field.equals("sender")){
                def row = sql.firstRow("select max(txn_file_id) from txn_remittance where id = (select max(id) FROM txn_remittance where sender_id = "+customerId+")")
                prevTxnDepAcctLedgerId = row.max
                println " remittance "+prevTxnDepAcctLedgerId
            }
            else{
                params.field
            }
            def field = 'customer'
            if (params.field) {
                field = params.field
            }
            
            render(template: '/customer/details/txnCustomerDetails', model: [customerInstance:customerInstance, field: field, prevTxnDepAcctLedgerId:prevTxnDepAcctLedgerId]) as JSON
        }
    }
    
    def changeLoanDetails(){
        def loanInstance = Loan.get(params.loan)
        def id_loan = params.loan
        userMasterId = UserMaster.get(session.user_id).id
        pbvalidate = id_loan
        def sql = new Sql(dataSource)
        def row = sql.firstRow("select max(txn_file_id) from txn_loan_payment_details where id = (select max(id) FROM txn_loan_payment_details where acct_id = "+id_loan+")")
        prevTxnDepAcctLedgerId = row.max
        println " txn file id max "+prevTxnDepAcctLedgerId
        if(!loanInstance){
            println "debug1"
            notFound()
            return
        }
        else {
            println "debug2"
//            if(loanInstance.status.id == 3){
//                println("WEEEEW")
//                render(template: '/tellering/txnLoanProceedsDisbursement/form')
//            }
//            else{
//                println "TEST HERE: "
//                println "Loan Instance: " + loanInstance
//                println "Loan balanceAmount: " + loanInstance?.balanceAmount
//                println "Loan interestBalanceAmount: " + loanInstance?.interestBalanceAmount
//                println "Loan penaltyBalanceAmount: " + loanInstance?.penaltyBalanceAmount
//                println "Loan serviceChargeBalanceAmount: " + loanInstance?.serviceChargeBalanceAmount
//                println "Loan taxBalanceAmount: " + loanInstance?.taxBalanceAmount
                render(template: '/tellering/details/loanDetails', model: [loanInstance:loanInstance,id_loan:id_loan, prevTxnDepAcctLedgerId:prevTxnDepAcctLedgerId, pbvalidate:pbvalidate]) as JSON
            return
        }
    }
    
     def changeDepositDetails(){
        userMasterId = UserMaster.get(session.user_id).id
        println "TEST PARAMS" 
        def acct_id = Deposit.get(params.deposit) 
        def acctid = acct_id.id.toInteger()
        pbvalidate =  acctid
        
        def sql = new Sql(dataSource) 
        def row = sql.firstRow("select max(passbook_line) from txn_deposit_acct_ledger where id = (select max(id) FROM txn_deposit_acct_ledger where acct_id = "+acctid+ ")")
        passbookline = row.max
        
        def txndepacctledgerID = sql.firstRow("select max(txn_file_id) from txn_deposit_acct_ledger where id = (select max(id) FROM txn_deposit_acct_ledger where acct_id = "+acctid+ ")")
        prevTxnDepAcctLedgerId = txndepacctledgerID.max
        
        
        def depositInstance = Deposit.get(params.deposit)
        def deposittype = depositInstance.type.id
        session["type"] = deposittype
        def id
        def rolloverInstance
        def rollenddate
        def dateclosing
        def branchrundate
        def flags = params.flag
        if(!flags)
        {
            flags = 0
        }
        //println "FLAG : " + flags
        if(depositInstance.type.id == 3){
            if(flags.toInteger() == 3){
                id = depositInstance.id
                rolloverInstance = depositInstance.currentRollover
                rollenddate = rolloverInstance.startDate
                branchrundate = Branch.get(depositInstance.branchId).runDate
            }
            else
            {
                id = depositInstance.id
                rolloverInstance = depositInstance.currentRollover
                dateclosing = depositInstance.dateClosed
                branchrundate = Branch.get(depositInstance.branchId).runDate
            }
        }
        if(!depositInstance){
            notFound()
            return
        }
          
        else {
            println "elsewhere?"

            if(depositInstance.status.id != 5){
                if(depositInstance.type.id == 3){
                     println "fd "
                        if(rollenddate != branchrundate && depositInstance.currentRollover.interestPaymentModeId != 1)
                        {
                            flash.message = "Transaction allowed in maturity date."
                        }
                        println '.............................'
                        println session["map"]
                        println '.............................'
                        if(session["map"] == 'reprint'){
                            println"Reprint render" 
                            render(template: '/tellering/details/depositDetails', model: [depositInstance:depositInstance]) as JSON
                            render(template:'/search/searchTemplate/deposit/reprintGrid/viewGrid', model: [depositInstance:depositInstance, params: params]) as JSON
                        }
                else{
                    render(template: '/tellering/details/depositDetails', model: [depositInstance:depositInstance,rolloverInstance:rolloverInstance,rollenddate:rollenddate,branchrundate:branchrundate,dateclosing:dateclosing,params:params, prevTxnDepAcctLedgerId:prevTxnDepAcctLedgerId, pbvalidate:pbvalidate]) as JSON
                    render(template: '/tellering/details/signatureDetails', model: [depositInstance:depositInstance]) as JSON
                    render(template: '/tellering/details/signatoryDetails', model: [depositInstance:depositInstance]) as JSON
                
                    }
 
                }
                else
                {
                      println "else "
                    println "not fd "+depositInstance.type.id + session["map"]
                    
                    rollenddate = 1
                    dateclosing = 1
                    branchrundate = 0
                    println '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<'
                    println session["map"]
                    println '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<'
                    if(session["map"] == 'reprint'){
                    println"Reprint render" 
                    render(template: '/tellering/details/depositDetails', model: [depositInstance:depositInstance]) as JSON
                    render(template:'/search/searchTemplate/deposit/reprintGrid/viewGrid', model: [depositInstance:depositInstance, params: params]) as JSON
                }
                else{
                     render(template: '/tellering/details/depositDetails', model: [depositInstance:depositInstance,rolloverInstance:rolloverInstance,rollenddate:rollenddate,branchrundate:branchrundate,dateclosing:dateclosing,params:params, prevTxnDepAcctLedgerId:prevTxnDepAcctLedgerId, pbvalidate:pbvalidate]) as JSON
                    render(template: '/tellering/details/signatureDetails', model: [depositInstance:depositInstance]) as JSON
                    render(template: '/tellering/details/signatoryDetails', model: [depositInstance:depositInstance]) as JSON
                }
                    
                   
                }
                
            }
        }
    }
    
    def search(Integer max) {
        println params
        params.max = Math.min(max ?: 10, 100)   
        def thisUser = UserMaster.get(session.user_id)

        if (params.sort == null) {
            params.sort = "id"
        }

        if (params.query == null || params.query.trim() == "") {  // show all instances
            /*
            def newTxnFile = TxnFile.findAllByUser(thisUser,params)
            def newCnt = TxnFile.countByUser(thisUser,params)
                
            println newTxnFile
            render(template:"details/txnDetails", model:[params:params, domainInstanceList:newTxnFile, domainInstanceCount:newCnt]) as JSON
            */
           println 'search transaction---------------->'
            def result = TxnFile.createCriteria().list(params) {                
                //idEq(params.query.trim().toLong())
                and {
                    eq("user",thisUser)
                    eq("txnDate",Branch.get(1).runDate)
                }

            }
            render(template:"details/txnDetails", model:[params:params, domainInstanceList:result, domainInstanceCount:result.totalCount]) as JSON
             
        } else {    // show query results
            def result = TxnFile.createCriteria().list(params) {                
                //idEq(params.query.trim().toLong())
                and {
                    eq("user",thisUser)
                    eq("txnDate",Branch.get(1).runDate)
                }
                or {
                    if (params.query.isNumber() ) {
                        eq("id",params.query.toLong())
                    } else {
                        ilike("acctNo", "%${params.query}%")
                        ilike("txnDescription", "%${params.query}%")
                        ilike("txnParticulars", "%${params.query}%")
                        ilike("txnRef", "%${params.query}%")
                        ilike("txnCode", "%${params.query}%")                        
                    }
                }
            }
            render(template:"details/txnDetails", model:[params:params, domainInstanceList:result, domainInstanceCount:result.totalCount]) as JSON
        }            
        return
    }
    
    def showTxnAjax() {
        def txnFileInstance = null
        def senderInstance = null
        def beneficiaryInstance = null
        def txnTemplateInstance = null
        String indicator = "BAMF"
        
        
        if (params?.id) {
            txnFileInstance = TxnFile.get(params?.id)
            if(txnFileInstance)
            {
                if (txnFileInstance?.sender?.id) {
                    println "-----MAY SENDER-----"
                    senderInstance = Customer.get(txnFileInstance?.sender?.id)
                }
                if (txnFileInstance?.beneficiary?.id){
                    println "-----MAY BENEFICIARY-----"
                    beneficiaryInstance = Customer.get(txnFileInstance?.beneficiary?.id)
                }
                if (txnFileInstance?.txnType) {
                    println "-----MAY TXNTYPE-----"
                    def txnTypeNo = txnFileInstance?.txnType.id
                    println txnTypeNo
                    txnTemplateInstance = TxnTemplate.get(txnTypeNo)
                    println txnTemplateInstance.txnType.codeDescription
                    if((txnTypeNo >= 1 && txnTypeNo <= 4) || (txnTypeNo >= 118 && txnTypeNo <= 121)){
                        indicator = "Teller Cash"
                    }
                    if((txnTypeNo >= 5 && txnTypeNo <= 32) || (txnTypeNo >= 79 && txnTypeNo <= 86)){
                        indicator = "Deposit"
                    }
                    if((txnTypeNo >= 5 && txnTypeNo <= 55) || (txnTypeNo >= 87 && txnTypeNo <= 117)){
                        indicator = "Other Cash/Check"
                    }
                    if((txnTypeNo >= 56 && txnTypeNo <= 78)){
                        indicator = "Loan"
                    }
                }
                println indicator
                println txnFileInstance
                println txnFileInstance.txnType.description
                println txnFileInstance.acctNo
                println txnFileInstance.branch.name
                println txnFileInstance.txnDate
                println txnFileInstance.txnAmt
                println txnFileInstance.txnCode
                println txnFileInstance.txnDescription
                println txnFileInstance.txnRef
                println txnFileInstance.txnParticulars
                println txnFileInstance.status
                println txnFileInstance.user.username

                render(template:"details/txnInfo", model:[txnFileInstance:txnFileInstance, senderInstance:senderInstance, beneficiaryInstance:beneficiaryInstance, txnTemplateInstance:txnTemplateInstance, indicator:indicator]) as JSON
                return
            } else {
                println "error???"
                render(template:"details/txnInfo")
                return
                
            }
        }
        
        
    }
 
/* Validation Slip Printing */    
     def printValidationSlip(){    
         println params.txnFile
         // def xxtransactionFileId = session.transactionFileId
         def xxtransactionFileId = params.txnFile.toInteger()
         def xxmap = session.map
         try {  
            if(xxmap == "loan"){
                println"loan validation"
                params._name = "Validation Slip Loan"
                params._format ="PDF"
                params._file ="ValidationSlipLoan.jasper" //jasper file
                params.txnID = xxtransactionFileId //parameter name & value
            }
            else if(xxmap == "loandisb"){
                println"validation loan disb"
                params._name = "Validation Slip Disb"
                params._format ="PDF"
                params._file ="ValidationSlipLoan.jasper" //jasper file
                params.txnID = xxtransactionFileId //parameter name & value
            }
            else if(xxmap == "deposit"){
                println"validation deposit at iba pa"
                params._name = "Validation Slip"
                params._format ="PDF"
                params._file ="ValidationSlip.jasper" //jasper file
                params.accountid = xxtransactionFileId //parameter name & value
            }
            
            else if(xxmap == "remittance"){
                println "remittance validation"
                params._name = "Validation Slip Remittance"
                params._format ="PDF"
                params._file ="ValidationSlipRemittance.jasper" //jasper file
                params.TxnFileRemittanceid = xxtransactionFileId //parameter name & value
            }
            else if(xxmap == "billspayment"){
                println "bills payment validation"
                params._name = "Validation Slip Bills Payment"
                params._format ="PDF"
                params._file ="ValidationSlipBillsPayment.jasper" //jasper file
                params.TxnFileBillsPaymentid =  xxtransactionFileId //parameter name & value
            }
            def reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            byte[] bytes = jasperService.generateReport(reportDef).toByteArray()

            response.outputStream << bytes
            response.outputStream.flush()
            
        }catch(Exception e) {
            //deal with your exception here
            e.printStackTrace()
        }
    }  
      
/*Transaction SLIP PRINTING */    
    def printTransactionSlip(){    
        //def xtransactionFileId = session.transactionFileId
        println params
        def xtransactionFileId = params.txnFile.toInteger()
        def xmap = session.map 
        try {    
            if(xmap == "loan")
            {   
                println"L O A N"
                params._name = "Loan Transactions SLIP"
                params._format ="PDF"//required caps
                params._file ="TransactionSlipLoan.jasper" //jasper file
                if(prevTxnDepAcctLedgerId == null){
                    params.PrevTxnFileID = null
                    params.LatesTxnFileID = xtransactionFileId
                    //params.TxnTemplateID = jrxmlTcId.toInteger() //deposit account id
                    params.TxnTemplateID = session["jrxmlTcId"].toInteger()
                }
                else{
                    params.PrevTxnFileID = prevTxnDepAcctLedgerId.toInteger()
                    params.LatesTxnFileID = xtransactionFileId
                    //params.TxnTemplateID = jrxmlTcId.toInteger() //template    id
                    params.TxnTemplateID = session["jrxmlTcId"].toInteger()
                }
            }
            else if(xmap == "deposit")
            {
                println "D E P O S I T"
                params._name = "Transactions SLIP"
                params._format ="PDF"//required caps
                params._file ="TransactionSlip.jasper" //jasper file
                if(prevTxnDepAcctLedgerId == null){
                    params.ledgerID1 = xtransactionFileId
                    params.ledgerID2 = xtransactionFileId
                    params.depositID = pbvalidate.toInteger() //deposit account id
                    params.usermasterID = userMasterId.toInteger()//user master id
                }
                else{
                    params.ledgerID1 = prevTxnDepAcctLedgerId.toInteger()// previous dep account ledger id
                    params.ledgerID2 = xtransactionFileId// latest dep account ledger id
                    params.depositID = pbvalidate.toInteger() //deposit account id
                    params.usermasterID = userMasterId.toInteger()//user master id
                }
            }
            else if(xmap == "remittance"){
                println "R E M I T T A N C E"
                params._name = "Other Transaction Remittance"
                params._format ="PDF"//required caps
                params._file ="TransactionSlipRemittance.jasper" //jasper file
                if(prevTxnDepAcctLedgerId == null){
                    params.txnRemittanceID1 = xtransactionFileId //remittance id
                    params.txnRemittanceID2 = xtransactionFileId
                }
                else{
                    params.txnRemittanceID1 = prevTxnDepAcctLedgerId.toInteger() //remittance id
                    params.txnRemittanceID2 = xtransactionFileId//remittance id
                }
            }
            else if(xmap == "loandisb"){
                println "L O A N D I S B"
                params._name = "Other Transaction Remittance"
                params._format ="PDF"//required caps
                params._file ="TransactionSlipLoanDisbursement.jasper" //jasper file
                params.loandisbID = xtransactionFileId //loan disb id 
            }
            else{
                println "B I L L S P A Y M E N T"
                params._name = "Other Transaction Bills Payment"
                params._format ="PDF"//required caps
                params._file ="TransactionSlipBillsPayment.jasper" //jasper file
                if(prevTxnDepAcctLedgerId == null){
                    params.txnBillsPaymentID1 = xtransactionFileId
                    params.txnBillsPaymentID2 = xtransactionFileId//bills payment id
                }
                else{
                    params.txnBillsPaymentID1 = prevTxnDepAcctLedgerId.toInteger() //previous remittance id
                    params.txnBillsPaymentID2 = xtransactionFileId//bills payment id
                }
            }
            
            def reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            byte[] bytes = jasperService.generateReport(reportDef).toByteArray()    
            
            response.outputStream << bytes
            response.outputStream.flush()
            
        }catch(Exception e) {
            //deal with your exception here
            e.printStackTrace()
        }
    }
    
    
    def ReprintPassbook(){
        
        def reprintPassbookInstance = servletContext.reprint
 
        def type = reprintPassbookInstance.type.toInteger()
        println"type" +type
        def startdate = Date.parse("yyyy-mm-dd", reprintPassbookInstance.startdate)
        def enddate = Date.parse("yyyy-mm-dd", reprintPassbookInstance.enddate)
        def id = reprintPassbookInstance.id.toInteger()
            
        try {
            if(type == 3){
                println"pumasok"
                params._name = "Reprint Passbook FD"
                params._format ="PDF"
                params._file ="Passbook_Transaction_FD.jrxml"
                //params.id = id
                params.pbId = pbPrintCode
                params.startdate = startdate
                params.enddate = enddate
            }
            else if(type == 1){
                params._name = "Reprint Passbook SA"
                params._format ="PDF"
                params._file ="Passbook_Transaction_SA.jrxml"  
                //params.id = id
                params.pbId = pbPrintCode
                params.startdate = startdate
                params.enddate = enddate
            }
            else{
                params._name = "Reprint Passbook CA"
                params._format ="PDF"//required caps
                params._file ="Passbook_Transaction_CA.jrxml"
                //params.id = id
                params.pbId = pbPrintCode
                params.startdate = startdate
                params.enddate = enddate
            }
            def reportDef = jasperService.buildReportDefinition(params, request.getLocale(), [])
            byte[] bytes = jasperService.generateReport(reportDef).toByteArray()    

            response.outputStream << bytes
            response.outputStream.flush()

            }catch(Exception e) {
                e.printStackTrace()
        }
    }
    
/*RE-PRINT PASSBOOK*/
    
    def saveTellerReprintPassbook(){       
        redirect(controller:"tellering", action:"createTellerReprintPassbook")
        println params
    }
    
    def createTellerReprintPassbook(TxnDepositAcctLedger ledger){
        render(view:'/tellering/txnReprintPassbook/create')
        def reprintPassbook = 'reprint'
        session["map"] = reprintPassbook
        
        
    }

    def createUpdatePassbook(TxnDepositAcctLedger ledger){
        render(view:'/tellering/txnUpdatePassbook/create')
        def updatePassbook = 'updatePassbook'
        session["map"] = updatePassbook
              
    }   
    
    def updatePassbook(){
        // to be filled in later
    }
/* FOREX transaction */

    def saveTellerForexTxn(TxnForex tc, TxnFile tf){       
        println params //Error check
        
        if(tc.hasErrors() || tf.hasErrors()){
            flash.message = 'Failed to transfer'
            render(view: '/tellering/txnForex/create', model: [txnForexInstance:tc])
        }
        else{
            def tb = new TxnCashCheckBlotter()
            tb.cashOutAmt = 0;
            tb.cashInAmt = 0;
            tb.checkInAmt = 0;
            tb.checkOutAmt = 0;
            
            def description = TxnTemplate.get(tf.txnType)
            tf.txnDescription = description.codeDescription
            tf.user = UserMaster.get(session.user_id)
            tf.save(flush: true)
            tf.txnDate = (new Date()).clearTime()
            tf.status = ConfigItemStatus.get(2)
            tc.status = ConfigItemStatus.get(2)
            
            tc.txnFile = tf
            tc.save(flush: true)
            tf.status = tf.status = ConfigItemStatus.get(2)
            tf.txnId = tc.id
            tf.save(flush: true)
            tb.txnFile = tf
            tb.save(flush:true)
            if(tb.id > 1){
                def tm = TxnCashCheckBlotter.get(tb.id - 1)
                tb.cashOutAmt = tm.cashOutAmt
                tb.cashInAmt += tm.cashInAmt
                tb.checkInAmt = tm.checkInAmt
                tb.checkOutAmt = tm.checkOutAmt
            }
            def amt = 0
            if(tc.netAmtPaidOut){
                tb.cashInAmt += tc.netAmtPaidOut
                amt = tc.netAmtPaidOut
            }
            tb.save(flush:true)

            def txnBreakdownInstance = new TxnBreakdown(creditAmt:amt, txnDate:tf.txnDate, txnFile:tf)
            txnBreakdownInstance.save(flush:true)

            userMasterService.updateTellerBalanceStatus(false)
            
            flash.message = 'Success'
            render(view: '/tellering/index', model: [txnForexInstance:new TxnForex()])
            
        }
    }
    def createTellerForexTxn(){
        def txnFileInstance = new TxnFile()
        def txnForexInstance = new TxnForex()
        render(view:'/tellering/txnForex/create', model: [txnForexInstance:txnForexInstance])       
    }
    
/* CASH FROM VAULT */

    def saveTellerCashFromVaultTxn(TxnTellerCash tc, TxnFile tf){       
        println params //Error check
        
       
        
        if(tc.hasErrors() || tf.hasErrors()){

            flash.message = 'Transaction Reference cannot be null (failed!)|error|alert'
            render(view: '/tellering/txnCashFromVault/create', model: [txnCashFromVaultInstance:tc])
        }
        else{
            def tb = new TxnCashCheckBlotter()
            def curval = params.tblinput
            def curidx = params.currencyidx
            def txn_teller_cashlist
            
            tb.cashOutAmt = 0;
            tb.cashInAmt = 0;
            tb.checkInAmt = 0;
            tb.checkOutAmt = 0;
            
           
            tf.branch = Branch.get(UserMaster.get(session.user_id).branchId)
           
            def txnBranch = Branch.get(UserMaster.get(session.user_id).branchId)
            
            tf.txnDescription = tf.txnTemplate.codeDescription
            tf.currency = Currency.get(tf.txnTemplate.currencyId)
            tf.txnCode = tf.txnTemplate.code
            tf.txnType = tf.txnTemplate.txnType
            tf.txnDate = txnBranch.runDate
            tf.txnTimestamp = new Date().toTimestamp()
            tf.user = UserMaster.get(session.user_id)            
            tf.save(flush:true,failOnError:true)
            
            curval.eachWithIndex  { valindex, index ->
               // println "val value ? " + valindex
                if(valindex.toInteger() >0)
                {
                    txn_teller_cashlist = new TxnTellerCash()
                    txn_teller_cashlist.currency = tf.currency
                    txn_teller_cashlist.currencydetail = CurrencyDetail.get(curidx[index].toInteger())
                    txn_teller_cashlist.txnFile = tf
                    txn_teller_cashlist.user = UserMaster.get(session.user_id)
                    txn_teller_cashlist.billcount = valindex.toInteger()
                    txn_teller_cashlist.txnRef = params.txnRef
                    def ta = params.txnAmt.replaceAll('(,)', '');
                    txn_teller_cashlist.txnAmt = ta.toDouble()
                
                    txn_teller_cashlist.save flush:true
                    println "value index? " + curidx[index]
                }  
            }
            
            //tc.currency = tf.currency
            //tc.txnFile = tf
            //tc.user = UserMaster.get(session.user_id)
            
            //tc.save(flush:true,failOnError:true)
            //tf.txnId = tc.id
            //tf.txnDate = new Date()
            
            tf.status = ConfigItemStatus.get(2)
            def amt = (tf.txnAmt).longValue()
            //def txntemp = tf.txnTemplate
            def isTxnAllowed =  policyService.isTxnAllowed(tf.txnTemplate.code, amt)
            if(isTxnAllowed == false) {
                tf.status = tf.status = ConfigItemStatus.get(1)
                policyService.createException('TLR00100', 'txnFile', tf.id, 'tellering/viewTellerTxnInquiry2/'+tf.id)
            }
            tf.save(flush:true,failOnError:true)
            tb.txnFile = tf
            tb.save(flush:true,failOnError:true)
            //if(tb.id > 1){
            //    def tm = TxnCashCheckBlotter.get(tb.id - 1)
            //    tb.cashOutAmt = tm.cashOutAmt
            //    tb.cashInAmt += tm.cashInAmt
            //    tb.checkInAmt = tm.checkInAmt
            //    tb.checkOutAmt = tm.checkOutAmt
            //}
            def cashIn = params.txnAmt.replaceAll('(,)', '')
            tb.cashInAmt += cashIn.toDouble() //tc.txnAmt
            tb.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tb.currency = Currency.get(tf.txnTemplate.currencyId)
            tb.user = UserMaster.get(session.user_id)
            tb.txnParticulars = tf.txnRef
            tb.save(flush:true,failOnError:true)
            
            //def txnBreakdownInstance = new TxnBreakdown(creditAmt:tf.txnAmt, txnDate:tf.txnDate, txnFile:tf)
            //txnBreakdownInstance.save(flush:true)
            //glTransactionService.saveTxnBreakdown(tf.id)
            
            userMasterService.updateTellerBalanceStatus(false)
            glTransactionService.saveTxnBreakdown(tf.id)            
             
            flash.message = 'Teller Cash From Vault (Success)|success|alert'
            //redirect(controller:"tellering", action: "createTellerCashFromVaultTxn")
            redirect(controller: "tellering", action: "txnSuccess")
            
            session["transactionFileId"] = tf.id.toInteger()
            println "Cash From Vault   "+session["transactionFileId"]  
            session["map"] = "deposit"
            println"map "+session["map"]

////          Calling jasper file
//            def list = TxnFile.findAllById(tf.id) 
//            params._file = "validation1.jasper"
//            params._format = "PDF"
//            params._name = "Validation"
//            chain(controller:'jasper',action:'index',model:[data:list],params:params)
            
//            render(view: '/tellering/index', model: [txnCashFromVaultInstance:new TxnTellerCash()])
        }
    }
    def createTellerCashFromVaultTxn(){
        // check user
        def user = UserMaster.get(session.user_id)
        if (user.cash){
            def txnFileInstance = new TxnFile()
            def txnCashFromVaultInstance = new TxnTellerCash()
            render(view:'/tellering/txnCashFromVault/create', model: [txnCashFromVaultInstance:txnCashFromVaultInstance])       
        }
        else{
            println user.cash
            flash.message = 'Error! No cash account defined'
            render(view: '/tellering/index')            
        }
    }
    
    def createPHPbreakdown()
    {
        //reyjie
        render(template: '/tellering/txnCashFromVault/php') as JSON
        return
    }
    
    def createUSDbreakdown()
    {
        //reyjie
        render(template: '/tellering/txnCashFromVault/usd') as JSON
        return
    }

    
/* CASH TO VAULT */

    def saveTellerCashToVaultTxn(TxnTellerCash tc, TxnFile tf){
        println params //Error check
        
        if(tc.hasErrors() || tf.hasErrors()){
            flash.message = 'Failed to transfer|error|alert'
            redirect(controller:"tellering", action: "createTellerCashToVaultTxn")
        }
        else{
            def tb = new TxnCashCheckBlotter()
            def curval = params.tblinput
            def curidx = params.currencyidx
            def txn_teller_cashlist
            
            
            tb.cashOutAmt = 0;
            tb.cashInAmt = 0;
            tb.checkInAmt = 0;
            tb.checkOutAmt = 0;
            
            tf.branch = Branch.get(UserMaster.get(session.user_id).branchId)
           
            def txnBranch = Branch.get(UserMaster.get(session.user_id).branchId)
            
            tf.txnDescription = tf.txnTemplate.codeDescription
            tf.currency = Currency.get(tf.txnTemplate.currencyId)
            tf.txnCode = tf.txnTemplate.code
            tf.txnDate = txnBranch.runDate
            tf.txnTimestamp = new Date().toTimestamp()
            tf.user = UserMaster.get(session.user_id) 
            tf.txnType = tf.txnTemplate.txnType
            tf.save(flush:true,failOnError:true)
            
            curval.eachWithIndex  { valindex, index ->
               // println "val value ? " + valindex
                if(valindex.toDouble() >0)
                {
                    txn_teller_cashlist = new TxnTellerCash()
                    txn_teller_cashlist.currency = tf.currency
                    txn_teller_cashlist.currencydetail = CurrencyDetail.get(curidx[index].toInteger())
                    txn_teller_cashlist.txnFile = tf
                    txn_teller_cashlist.user = UserMaster.get(session.user_id)
                    txn_teller_cashlist.billcount = valindex.toInteger()
                    txn_teller_cashlist.txnRef = params.txnRef
                    txn_teller_cashlist.txnAmt = params.txnAmt.replaceAll(",","").toDouble()
                
                    txn_teller_cashlist.save flush:true
                    println "value index? " + curidx[index]
                }  
            }
            
            
           // tc.txnFile = tf
         //   tc.user = UserMaster.get(session.user_id)
          //  tc.save(flush:true,failOnError:true)
            //tf.txnId = tc.id
            //tf.txnDate = new Date()
            tf.status = ConfigItemStatus.get(2)
            def amt = (tf.txnAmt).longValue()
            def isTxnAllowed =  policyService.isTxnAllowed(tf.txnTemplate.code, amt)
            if(isTxnAllowed == false) {
                tf.status = tf.status = ConfigItemStatus.get(1)
                policyService.createException('TLR00100', 'txnFile', tf.id, 'tellering/viewTellerTxnInquiry2/'+tf.id)
            }
            tf.save(flush:true,failOnError:true)
            tb.txnFile = tf
            tb.save(flush:true,failOnError:true)
            //if(tb.id > 1){
            //    def tm = TxnCashCheckBlotter.get(tb.id - 1)
            //    tb.cashOutAmt = tm.cashOutAmt
            //    tb.cashInAmt += tm.cashInAmt
            //    tb.checkInAmt = tm.checkInAmt
            //    tb.checkOutAmt = tm.checkOutAmt
            //}
            tb.cashOutAmt += params.txnAmt.replaceAll(",","").toDouble()
            tb.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tb.currency = Currency.get(tf.txnTemplate.currencyId)
            tb.user = UserMaster.get(session.user_id)
            tb.txnParticulars = tf.txnRef
            tb.save(flush:true,failOnError:true)
            
            //def txnBreakdownInstance = new TxnBreakdown(creditAmt:tf.txnAmt, txnDate:tf.txnDate, txnFile:tf)
            //txnBreakdownInstance.save(flush:true)
            
            userMasterService.updateTellerBalanceStatus(false)
            glTransactionService.saveTxnBreakdown(tf.id)
              
            flash.message = 'Teller Cash to Vault (Success)|success|alert'
            //redirect(controller: "tellering", action: "createTellerCashToVaultTxn")
            redirect(controller: "tellering", action: "txnSuccess")
            
            session["transactionFileId"] = tf.id.toInteger()
            println "Cash to Vault   "+session["transactionFileId"] 
            session["map"] = "deposit"
            println " map "+session["map"]
            
////          Calling jasper file
//            def list = TxnFile.findAllById(tf.id) 
//            params._file = "validation1.jasper"
//            params._format = "PDF"
//            params._name = "Validation"
//            chain(controller:'jasper',action:'index',model:[data:list],params:params)
            
//            render(view: '/tellering/index', model: [txnCashFromVaultInstance:new TxnTellerCash()])
        }
    }
    def createTellerCashToVaultTxn(){
        def user = UserMaster.get(session.user_id)
        if (user.cash){
            def txnFileInstance = new TxnFile()
            def txnCashToVaultInstance = new TxnTellerCash()
            render(view:'/tellering/txnCashToVault/create', model: [txnCashToVaultInstance:txnCashToVaultInstance])       
        }
        else{
            println user.cash
            flash.message = 'Error! No cash account defined'
            render(view: '/tellering/index')            
        } 
    }
    

/* TELLER CASH TRANSFER */

    def saveTellerCashTransferTxn(TxnTellerCash tc, TxnFile tf){
        println params //Error check
      //  println "transfer cash enter"
        
        if(tc.hasErrors() || tf.hasErrors()){
            flash.message = 'Transaction reference cannot be null (failed)|error|alert'
            redirect(controller: "tellering", action: "createTellerCashTransferTxn")
            //render(view: '/tellering/txnCashTransfer/create', model: [txnCashTransferInstance:tc])
        }
        
        else{
          //  println "transfer continue"
            def tb = new TxnCashCheckBlotter()
            def user = UserMaster.get(session.user_id)
            def targetuser = UserMaster.get(params.user)
            def txnBranch = Branch.get(user.branchId)
            def currency = Currency.get(tf.txnTemplate.currencyId)
            
            def curval = params.tblinput
            def curidx = params.currencyidx
            def txn_teller_cashlist
            

            // trnsaction file
            tf.branch = txnBranch
            tf.txnDescription = tf.txnTemplate.codeDescription
            tf.currency = currency
            tf.txnCode = tf.txnTemplate.code
            tf.txnDate = txnBranch.runDate
            tf.txnTimestamp = new Date().toTimestamp()
            tf.user = user
            tf.txnType = tf.txnTemplate.txnType
            tf.status = ConfigItemStatus.get(1) // pending create status
            
            def amt = (tf.txnAmt).longValue()
            def isTxnAllowed =  policyService.isTxnAllowed(tf.txnTemplate.code, amt)
            tf.save(flush:true,failOnError:true)
            
            //if(isTxnAllowed == false) {
            //    tf.status = tf.status = ConfigItemStatus.get(1)
            //    policyService.createException('TLR00200', 'txnFile', tf.id, 'tellering/viewTellerTxnInquiry2/'+tf.id)
           // } else {
                //tf.status = tf.status = ConfigItemStatus.get(1)
                policyService.createException('TLR00200', 'TxnFile', tf.id, 'tellering/receiveTellerCashTransfer',targetuser.id)
               // 'TLR00200',
               // 'txnFile',
               // tf.id,
               // '/tellering/receiveTellerCashTransfer',
               // targetuser.id
                
                
                
            //}
           // tf.save(flush:true,failOnError:true)
            curval.eachWithIndex  { valindex, index ->
               // println "val value ? " + valindex
                if(valindex.toInteger() >0)
                {
                    txn_teller_cashlist = new TxnTellerCash()
                    txn_teller_cashlist.currency = tf.currency
                    txn_teller_cashlist.currencydetail = CurrencyDetail.get(curidx[index].toInteger())
                    txn_teller_cashlist.txnFile = tf
                    txn_teller_cashlist.user = user
                    txn_teller_cashlist.billcount = valindex.toInteger()
                    txn_teller_cashlist.txnRef = params.txnRef
                    txn_teller_cashlist.txnAmt = params.txnAmt.replace(',', '').toDouble()
                
                    txn_teller_cashlist.save flush:true
                    println "value index? " + curidx[index]
                }  
            }
            
            
           // tc.currency = currency
           // tc.txnFile = tf
           // tc.user = user
           // tc.save(flush:true,failOnError:true)
            //tf.txnId = tc.id
            //tf.txnDate = new Date()
            //tf.status = ConfigItemStatus.get(2)
            
            
          //  flash.message = "error not,asdasd,asdasd, equal|error"
            //tf.save(flush:true,failOnError:true)
            
            // Blotter
            tb.cashOutAmt = 0;
            tb.cashInAmt = 0;
            tb.checkInAmt = 0;
            tb.checkOutAmt = 0;
            
            tb.txnFile = tf
           // tb.save(flush:true)
            //if(tb.id > 1){
            //    def tm = TxnCashCheckBlotter.get(tb.id - 1)
            //    tb.cashOutAmt = tm.cashOutAmt
            //    tb.cashInAmt += tm.cashInAmt
            //    tb.checkInAmt = tm.checkInAmt
            //    tb.checkOutAmt = tm.checkOutAmt
            //}
            tb.cashOutAmt += params.txnAmt.replace(',', '').toDouble()
            tb.branch = Branch.get(user.branchId)
            tb.currency = currency
            tb.user = user // UserMaster.get(session.user_id)
            tb.txnParticulars = tf.txnRef
            
            tb.save(flush:true,failOnError:true)
            
            //def txnBreakdownInstance = new TxnBreakdown(creditAmt:tf.txnAmt, txnDate:tf.txnDate, txnFile:tf)
            //txnBreakdownInstance.save(flush:true)
            
            userMasterService.updateTellerBalanceStatus(false)
            glTransactionService.saveTxnBreakdown(tf.id)
             
            flash.message = 'Teller Cash Transfer (Success)|success|alert'
            //redirect(controller: "tellering", action: "createTellerCashTransferTxn")
            redirect(controller: "tellering", action: "txnSuccess")
            
            session["transactionFileId"] = tf.id.toInteger()
            println "Cash Transafer   "+session["transactionFileId"] 
            session["map"] = "deposit"
            println" map "+session["map"]
            //render(view: '/tellering/index', model: [txnCashFromVaultInstance:new TxnTellerCash()])
                    
            // for receiving teller, create transaction
            /*
            def tfRec = new TxnFile()
            tfRec.branch =  Branch.get(UserMaster.get(params.user).branchId)
            //def DescRec = TxnTemplate.get(tf.txnType.toInteger())
            tfRec.txnDescription = tf.txnTemplate.codeDescription
            tfRec.currency = Currency.get(tf.txnTemplate.currencyId)
            tfRec.txnCode = tf.txnTemplate.code
            tfRec.txnAmt = tf.txnAmt
            tfRec.txnTemplate = tf.txnTemplate
            tfRec.txnRef = tf.txnRef
            tfRec.txnType = tf.txnTemplate.txnType
            tfRec.txnDate = txnBranch.runDate
            tfRec.txnTimestamp = new Date().toTimestamp()
            tfRec.user = UserMaster.get(session.user_id)    
            tfRec.status = ConfigItemStatus.get(1)
            tfRec.save(flush:true,failOnError:true)
            
            //tfRec.txnId = tc.id
            //tf.txnDate = new Date()
           
            def tbRec = new TxnCashCheckBlotter()
            tbRec.cashOutAmt = 0;
            tbRec.cashInAmt = tf.txnAmt;
            tbRec.checkInAmt = 0;
            tbRec.checkOutAmt = 0;
            
            tbRec.branch = Branch.get(UserMaster.get(params.user).branchId)
            tbRec.currency = Currency.get(tf.txnTemplate.currencyId)
            tbRec.user = UserMaster.get(params.user)
            tbRec.txnParticulars = tf.txnRef
              
            tfRec.save(flush: true)
            tbRec.txnFile = tf
            tbRec.save(flush:true,failOnError:true)
            
            HttpSession session = RequestContextHolder.currentRequestAttributes().getSession();
            //def txnBreakdownInstance = new TxnBreakdown(debitAcct:UserMaster.get(session.user_id).name, creditAcct:user, debitAmt:tf.txnAmt, creditAmt:tf.txnAmt, txnDate:tf.txnDate, txnFile:tf)
            //txnBreakdownInstance.save(flush:true)
            
            //userMasterService.updateTellerBalanceStatus(false)
            //flash.message = 'Success'
            
////          Calling jasper file
//            def list = TxnFile.findAllById(tf.id) 
//            params._file = "validation1.jasper"
//            params._format = "PDF"
//            params._name = "Validation"
//            chain(controller:'jasper',action:'index',model:[data:list],params:params)
            */
            //render(view: '/tellering/index', model: [txnCashTransferInstance:new TxnTellerCash()])
        }
    }
    def createTellerCashTransferTxn(){
      def db = new Sql(dataSource)
      def user = UserMaster.get(session.user_id)
        if (user.cash){
            //def jList = db.rows("select A.id,concat(name1,' ',name2) as name from user_master A LEFT JOIN (select id,role_id,user_master_id from user_role)B  on A.id = B.user_master_id where B.role_id in (select id from role where code LIKE '%TELLER%' or code LIKE '%CASHIER%') and A.id != ?",[user.id])
           def sqlstmt  = "select id,concat(name1,' ',name2,' ',name3) as name from user_master where designation_id = 2 and  config_item_status_id = 2 and branch_id = "+user.branch.id+" and id != " + user.id
          //  println sqlstmt
            def jList = db.rows(sqlstmt)
          //  println jList
            def txnFileInstance = new TxnFile()
            def txnCashTransferInstance = new TxnTellerCash()
            render(view:'/tellering/txnCashTransfer/create', model: [txnCashTransferInstance:txnCashTransferInstance,jList:jList])       
        }
        else{
            println user.cash
            flash.message = 'Error! No cash account defined'
            render(view: '/tellering/index')            
        }      
    }
    
/* CHECK TO COCI */

    //def saveTellerCheckToCOCITxn(TxnCOCI tc, TxnFile tf){
    def saveTellerCheckToCOCITxn(TxnCOCI tc){
        println params //Error check
        
        if(tc.hasErrors()){
            flash.message = 'Failed to transfer|error'
            render(view: '/tellering/txnCheckToCOCI/create', model: [txnCheckToCOCIInstance:new TxnCOCI()])
        }
        
        def checkedList = params.list('cleared')
        //get list of books. this will return only the selected books
        Double totChkAmt = 0.00d
        def selectedChecks = TxnCOCI.getAll(checkedList)  
        def currency
        for(result in selectedChecks){
            // -----------------
            // 1 = pending, 2 = with teller, 3 = with cashier, 4 = Cancelled
            result.txnCheckStatus = TxnCheckStatus.get(3)
            // i dont know what to do with checkStatus
            //result.checkStatus = 
            totChkAmt += result.checkAmt
            result.save(flush:true,failOnError:true)
            currency = result.txnFile.currency
        }
        def tf = new TxnFile()
        tf.txnAmt = totChkAmt
        tf.branch = UserMaster.get(session.user_id).branch
        tf.txnDescription = 'Checks to COCI'
        tf.currency = currency
        tf.txnCode = TxnTemplate.get(params.txnTemplate.toInteger()).code
        tf.txnTemplate = TxnTemplate.get(params.txnTemplate.toInteger())
        tf.txnDate = Branch.get(1).runDate
        tf.txnTimestamp = new Date().toTimestamp()
        tf.user = UserMaster.get(session.user_id)
        tf.txnType = TxnTemplate.get(params.txnTemplate.toInteger()).txnType
        tf.txnRef = UserMaster.get(session.user_id).username + '-Checks to COCI'
        tf.txnParticulars = 'Checks to COCI'
        tf.status = ConfigItemStatus.get(2) // pending create status
        tf.save(flush:true, failOnError:true)    
        //def amt = (tf.txnAmt).longValue()
            
        def tb = new TxnCashCheckBlotter()
        tb.cashOutAmt = 0
        tb.cashInAmt = 0
        tb.checkInAmt = 0
            // -----------------
            
        tb.txnFile = tf
        tb.checkOutAmt = totChkAmt
        tb.branch = Branch.get(UserMaster.get(session.user_id).branchId)
        tb.currency = tf.currency
        tb.user = UserMaster.get(session.user_id)
        tb.txnParticulars = 'Checks to COCI'
        tb.save(flush:true,failOnError:true)
            
            
            //now manipulate the result as you wish ...
            
        userMasterService.updateTellerBalanceStatus(false)
        glTransactionService.saveTxnBreakdown(tf.id)        
        /*
        if(tc.hasErrors()){
            flash.message = 'Failed to transfer|error'
            render(view: '/tellering/txnCheckToCOCI/create', model: [txnCheckToCOCIInstance:tc])
        }
        else{
            def tb = new TxnCashCheckBlotter()
            def tf = tc.txnFile
            tb.cashOutAmt = 0;
            tb.cashInAmt = 0;
            tb.checkInAmt = 0;
            tb.checkOutAmt = 0;
            
            println "txnFile "+ newtf.txnCode
            
          //  tf.branch = Branch.get(UserMaster.get(session.user_id).branchId)
           
            def txnBranch = Branch.get(UserMaster.get(session.user_id).branchId)
            
            //tf.txnDescription = tf.txnDescription
           // tf.currency = tf.currency
           // tf.txnCode = tf.txnCode
           // tf.txnDate = txnBranch.runDate
           // tf.txnAmt = tc.txnAmt // params.totalChecks.toLong()
            tf.txnTimestamp = new Date().toTimestamp()
            tf.user = UserMaster.get(session.user_id)            
            tf.save(flush:true,failOnError:true)
          //  tf.txnType = tf.txnTemplate.txnType
            
            tf.txnDate = new Date()
            tf.status = ConfigItemStatus.get(2)
            def amt = (tf.txnAmt).longValue()
            def isTxnAllowed =  policyService.isTxnAllowed(tf.txnTemplate.code, amt)
            if(isTxnAllowed == false) {
                tf.status = tf.status = ConfigItemStatus.get(1)
                policyService.createException('TLR00100', 'txnFile', tf.id, 'tellering/viewTellerTxnInquiry2/'+tf.id)
            }
            tf.save(flush:true,failOnError:true)
            tb.txnFile = tf
            tb.save(flush:true,failOnError:true)
            //if(tb.id > 1){
            //    def tm = TxnCashCheckBlotter.get(tb.id - 1)
            //    tb.cashOutAmt = tm.cashOutAmt
            //    tb.cashInAmt += tm.cashInAmt
            //    tb.checkInAmt = tm.checkInAmt
            //    tb.checkOutAmt = tm.checkOutAmt
            //}
            tb.checkOutAmt += tf.txnAmt
            tb.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tb.currency = Currency.get(tf.txnTemplate.currencyId)
            tb.user = UserMaster.get(session.user_id)
            tb.txnParticulars = tf.txnRef
            tb.save(flush:true,failOnError:true)
          */  
            //def txnBreakdownInstance = new TxnBreakdown(creditAmt:tf.txnAmt, txnDate:tf.txnDate, txnFile:tf)
            //txnBreakdownInstance.save(ffailOnErrorlush:true)
            

//            flash.message = 'Success'       

          //  userMasterService.updateTellerBalanceStatus(false)
           // glTransactionService.saveTxnBreakdown(tf.id)

            
            //transactionFileId = tf
           // println " TELLER   "+transactionFileId   
            flash.message = 'Teller Checks to COCI (Success)|success'
            //redirect(controller: "tellering", action: "createTellerCheckToCOCITxn")
            redirect(controller: "tellering", action: "txnSuccess")
            
            session["transactionFileId"] = tf.id.toInteger()
            println "Cash Transafer   "+session["transactionFileId"] 
            session["map"] = "deposit"
            println" map "+session["map"]            
////          Calling jasper file
//            def list = TxnFile.findAllById(tf.id) 
//            params._file = "validation1.jasper"
//            params._format = "PDF"
//            params._name = "Validation"
//            chain(controller:'jasper',action:'index',model:[data:list],params:params)
            
//            render(view: '/tellering/index', model: [txnCheckToCOCIInstance:new TxnFile()])
      //  }
    }
    def createTellerCheckToCOCITxn(){
        def user = UserMaster.get(session.user_id)
        if (user.cash){
            println "parameter "+params
            def statConfig = ConfigItemStatus.get(2)
            def chktxnStatus = TxnCheckStatus.get(2)
            //def TxnCOCIList = TxnCOCI.findAllByStatusAndClearedAndTxnCheckStatus(statConfig,'false',chktxnStatus).list())
            def TxnCOCIList = TxnCOCI.createCriteria().list (params) {  
                eq('cleared', 'false')
                eq('txnCheckStatus', chktxnStatus)
                eq('status', statConfig)
                eq('user', user ) 
            }
       
            //respond TxnCOCIList, model:[params:params,TxnCOCIInstanceCount: TxnCOCIList.totalCount]
            
            def statlist1 = TxnCOCIList.status
            println " asdf "+ statlist1
            def txnFileInstance = new TxnFile()
            def txnCheckToCOCIInstance = new TxnCOCI()
            render(view:'/tellering/txnCheckToCOCI/create', model: [txnCheckToCOCIInstance:txnCheckToCOCIInstance, TxnCOCIList: TxnCOCIList, TxnCOCIInstanceCount: TxnCOCIList.totalCount])
           
        } else {
            println user.cash
            flash.message = 'Error! No cash account defined'
            render(view: '/tellering/index')            
        }  
    }
    
    
    
/* OTHER CASH RECEIPT BILLS PAYMENT */

    def saveTellerOtherCashReceiptBillsPaymentTxn(TxnBillsPayment tc, TxnFile tf){
        println params //Error check
        
        if(tc.hasErrors() || tf.hasErrors()){
            flash.message = 'Failed to transfer.|error'
            render(view: '/tellering/txnBillsPayment/create', model: [txnBillsPaymentInstance:tc])
        }
        else{
            def tb = new TxnCashCheckBlotter()
            tb.cashOutAmt = 0;
            tb.cashInAmt = 0;
            tb.checkInAmt = 0;
            tb.checkOutAmt = 0;
            
            tf.branch = Branch.get(UserMaster.get(session.user_id).branchId)
           
            def txnBranch = Branch.get(UserMaster.get(session.user_id).branchId)
            
            tf.txnDescription = tf.txnTemplate.codeDescription
            tf.currency = Currency.get(tf.txnTemplate.currencyId)
            tf.txnCode = tf.txnTemplate.code
            tf.txnDate = txnBranch.runDate
            tf.txnTimestamp = txnBranch.runDate
            tf.user = UserMaster.get(session.user_id)   
            tf.txnType = tf.txnTemplate.txnType
            tf.save(flush:true,failOnError:true)
            
            tc.txnFile = tf
            tc.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tc.currency = Currency.get(tf.txnTemplate.currencyId)
            tc.status = ConfigItemStatus.get(2)
            tc.txnDate = txnBranch.runDate
            tc.save(flush:true,failOnError:true)
            //tf.txnId = tc.id
            //tf.txnDate = new Date()
            tf.txnType = tf.txnTemplate.txnType
            tf.status = ConfigItemStatus.get(2)
            def amt = (tf.txnAmt).longValue()
            def isTxnAllowed =  policyService.isTxnAllowed(tf.txnTemplate.code, amt)
            if(isTxnAllowed == false) {
                tf.status = ConfigItemStatus.get(1)
                policyService.createException('1001', 'txnFile', tf.id, 'tellering/viewTellerTxnInquiry2/'+tf.id)
            }
            tf.save(flush:true,failOnError:true)
            tb.txnFile = tf
            tb.save(flush:true,failOnError:true)
            //if(tb.id > 1){
            //    def tm = TxnCashCheckBlotter.get(tb.id - 1)
            //    tb.cashOutAmt = tm.cashOutAmt
            //    tb.cashInAmt += tm.cashInAmt
            //    tb.checkInAmt = tm.checkInAmt
            //    tb.checkOutAmt = tm.checkOutAmt
            //}
            tb.cashInAmt += tc.txnAmt
            tb.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tb.currency = Currency.get(tf.txnTemplate.currencyId)
            tb.user = UserMaster.get(session.user_id)
            tb.txnParticulars = tf.txnParticulars
            tb.save(flush:true,failOnError:true)
            
            //def txnBreakdownInstance = new TxnBreakdown(creditAmt:tf.txnAmt, txnDate:tf.txnDate, txnFile:tf)
            //txnBreakdownInstance.save(flush:true)
            
            userMasterService.updateTellerBalanceStatus(false)
            glTransactionService.saveTxnBreakdown(tf.id)
//            flash.message = 'Success'

          
            flash.message = 'Transaction complete.|success'
            //redirect(controller: "tellering", action: "createTellerOtherCashReceiptBillsPaymentTxn")
            redirect(controller: "tellering", action: "txnSuccess")
            
            session["transactionFileId"] = tf.id.toInteger()
            println " Other Cash receipt Bills Payment "+session["transactionFileId"]   
            session["map"] = "billspayment"
            println"map "+session["map"]
////          Calling jasper file
//            def list = TxnFile.findAllById(tf.id) 
//            params._file = "validation1.jasper"
//            params._format = "PDF"
//            params._name = "Validation"
//            chain(controller:'jasper',action:'index',model:[data:list],params:params)
            
//            render(view: '/tellering/index', model: [txnBillsPaymentInstance:new TxnBillsPayment()])
        }
    }
    def createTellerOtherCashReceiptBillsPaymentTxn(){
       
        def user = UserMaster.get(session.user_id)
        if (user.cash){
            def txnFileInstance = new TxnFile()
            def txnBillsPaymentInstance = new TxnBillsPayment()
            render(view:'/tellering/txnBillsPayment/create', model: [txnBillsPaymentInstance:txnBillsPaymentInstance])       
        }
        else{
            println user.cash
            flash.message = 'Error! No cash account defined.|error'
            render(view: '/tellering/index')            
        }        
    }
   
    
/* OTHER CHECK RECEIPT BILLS PAYMENT */

    def saveTellerOtherCheckReceiptBillsPaymentTxn(TxnBillsPayment tc, TxnFile tf){
        println params //Error check
        
        //println session["checks"].id
        
        //params.coci.each {
        //  println params.coci
        //    def tcoci = new TxnCOCI()
        //   tc.addToChecks(tcoci)
        //    tcoci.status = ConfigItemStatus.get(2)
        //    tcoci.txnFile = tc            
        //    tcoci.save(flush:true)
        //}
        

        
        if(tc.hasErrors() || tf.hasErrors()){
            flash.message = 'Failed to transfer.|error'
           // render(view: '/tellering/txnCheckBillsPayment/create', model: [txnCheckBillsPaymentInstance:tc])
           redirect(action :"createTellerOtherCheckReceiptBillsPaymentTxn")
        }
        else{
            def tb = new TxnCashCheckBlotter()
            tb.cashOutAmt = 0;
            tb.cashInAmt = 0;
            tb.checkInAmt = 0;
            tb.checkOutAmt = 0;
            
            tf.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            
            def txnBranch = Branch.get(UserMaster.get(session.user_id).branchId)
            
            tf.txnDescription = tf.txnTemplate.codeDescription
            tf.currency = Currency.get(tf.txnTemplate.currencyId)
            tf.txnCode = tf.txnTemplate.code
            tf.txnDate = txnBranch.runDate
            tf.txnTimestamp = new Date().toTimestamp()
            tf.user = UserMaster.get(session.user_id)  
            tf.beneficiary = Customer.get(params.customer)
            tf.save(flush:true,failOnError:true)
            
            tc.txnFile = tf
            tc.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tc.currency = Currency.get(tf.txnTemplate.currencyId)
            tc.status = ConfigItemStatus.get(2)
            tc.txnDate = txnBranch.runDate
            tc.beneficiary = Customer.get(params.customer)
            tc.save(flush:true,failOnError:true)
            //tf.txnId = tc.id
            //tf.txnDate = new Date()
            tf.txnType = tf.txnTemplate.txnType
            tf.status = ConfigItemStatus.get(2)
            def amt = (tf.txnAmt).longValue()
            def isTxnAllowed =  policyService.isTxnAllowed(tf.txnTemplate.code, amt)
            if(isTxnAllowed == false) {
                tf.status = ConfigItemStatus.get(1)
                policyService.createException('1001', 'txnFile', tf.id, 'tellering/viewTellerTxnInquiry2/'+tf.id)
            }
            tf.save(flush:true,failOnError:true)
            tb.txnFile = tf
            tb.save(flush:true,failOnError:true)
            //if(tb.id > 1){
            //    def tm = TxnCashCheckBlotter.get(tb.id - 1)
            //    tb.cashOutAmt = tm.cashOutAmt
            //    tb.cashInAmt += tm.cashInAmt
            //    tb.checkInAmt = tm.checkInAmt
            //    tb.checkOutAmt = tm.checkOutAmt
            //}
            tb.checkInAmt += tc.txnAmt
            tb.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tb.currency = Currency.get(tf.txnTemplate.currencyId)
            tb.user = UserMaster.get(session.user_id)
            tb.txnParticulars = tf.txnParticulars
            tb.save(flush:true,failOnError:true)
            
            session["checks"].id.each {tcoci_id ->
                def tcoci = TxnCOCI.get(tcoci_id)
                tcoci.status = ConfigItemStatus.get(2)
                tcoci.txnCheckStatus = TxnCheckStatus.get(2)
                println "CHECK STATUS " + tcoci.txnCheckStatus
                tcoci.txnFile = tf
                
                def checkClearDate = tcoci.checkType.clearingDate
                tcoci.clearingDate = checkClearDate
                
                if(tcoci.checkType == CheckDepositClearingType.get(3)){
                    def checks = Cheque.findByChequeNo(tcoci.checkNo)
                    def chequebookInstance = checks.chequebook 
                    checks.chequeAmt = tcoci.checkAmt
                    checks.chequeDate = tcoci.checkDate
                    checks.isChequeClrOnUs = true
                    checks.status = CheckStatus.get(3)
                    checks.save(flush:true,failOnError:true)
                    
                    chequebookInstance.chequesUsed += 1
                    chequebookInstance.save(flush:true,failOnError:true)
                    
                    debitOnus(checks)
                    
                    tcoci.txnCheckStatus = TxnCheckStatus.get(3)
                    tcoci.cleared = true
                    tcoci.clearingDate = tf.txnDate
                }                
                tcoci.save(flush:true,failOnError:true)
            }
            //def txnBreakdownInstance = new TxnBreakdown(creditAmt:tf.txnAmt, txnDate:tf.txnDate, txnFile:tf)
            //txnBreakdownInstance.save(flush:true)
            
            
            userMasterService.updateTellerBalanceStatus(false)
            glTransactionService.saveTxnBreakdown(tf.id)
            //flash.message = 'Success'
            
            
            flash.message = 'Transaction complete.|success'
            //redirect(action: 'createTellerOtherCheckReceiptBillsPaymentTxn')
            redirect(controller: "tellering", action: "txnSuccess")
            
            session["transactionFileId"] = tf.id.toInteger()
            println "Other Check Receipt Bills Payment   "+ session["transactionFileId"]
            session["map"] = "billspayment"
            println"map "+session["map"]
////          calling jasper file
//            def list = TxnFile.findAllById(tf.id) 
//            params._file = "validation1.jasper"
//            params._format = "PDF"
//            params._name = "Validation"
//            chain(controller:'jasper',action:'index',model:[data:list],params:params)
            
        }
    }
    def createTellerOtherCheckReceiptBillsPaymentTxn(){
        def user = UserMaster.get(session.user_id)
        if (user.coci){
            def txnFileInstance = new TxnFile()
            def txnCOCIInstance = new TxnCOCI()
            def txnCheckBillsPaymentInstance = new TxnBillsPayment()
            session["checks"] = []
        render(view:'/tellering/txnCheckBillsPayment/create', model: [txnCheckBillsPaymentInstance:txnCheckBillsPaymentInstance])       
        }
        else{
            println user.cash
            flash.message = 'Error! No COCI account defined.|error'
            render(view: '/tellering/index')            
        }
        
    }

    
/* OTHER CHECK RECEIPT ADJUSTMENT */
// other check receipt general

    def saveTellerOtherCheckReceiptAdjustmentTxn(TxnFile tc){
        println params //Error check
        //println params.coci
        
        if(tc.hasErrors()){
            println 'Error'
            flash.message = 'Failed to transfer.|error'
            redirect(controller: "tellering", action:"createTellerOtherCheckReceiptAdjustmentTxn")
        }
        else{
            def tb = new TxnCashCheckBlotter()
            tb.cashOutAmt = 0;
            tb.cashInAmt = 0;
            tb.checkInAmt = 0;
            tb.checkOutAmt = 0;
            
            tc.branch = Branch.get(UserMaster.get(session.user_id).branchId)
           
            def txnBranch = Branch.get(UserMaster.get(session.user_id).branchId)
            
            tc.txnDescription = tc.txnTemplate.codeDescription
            tc.currency = Currency.get(tc.txnTemplate.currencyId)
            tc.txnCode = tc.txnTemplate.code
            tc.txnDate = txnBranch.runDate
            tc.txnTimestamp = new Date().toTimestamp()
            tc.user = UserMaster.get(session.user_id)  
            tc.txnType = tc.txnTemplate.txnType
            tc.save(flush:true,failOnError:true)
            
            //tf.txnDate = new Date()
            tc.status = ConfigItemStatus.get(2)
            def amt = (tc.txnAmt).longValue()
            def isTxnAllowed =  policyService.isTxnAllowed(tc.txnTemplate.code, amt)
            //if(isTxnAllowed == false) {
            //    tf.status = ConfigItemStatus.get(1)
            //    policyService.createException('1001', 'txnFile', tf.id, 'tellering/viewTellerTxnInquiry2/'+tc.id)
            //}
            tc.save(flush:true,failOnError:true)
            
            tb.txnFile = tc
            tb.checkInAmt += tc.txnAmt
            tb.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tb.currency = Currency.get(tc.txnTemplate.currencyId)
            tb.user = UserMaster.get(session.user_id)
            tb.txnParticulars = tc.txnParticulars
            tb.save(flush:true,failOnError:true)
            
            session["checks"].id.each { tcoci_id ->
                def tcoci = TxnCOCI.get(tcoci_id)
                tcoci.status = ConfigItemStatus.get(2)
                tcoci.txnCheckStatus = TxnCheckStatus.get(2)
                tcoci.txnFile = tc
                
                def checkClearDate = tcoci.checkType.clearingDate
                tcoci.clearingDate = checkClearDate
                
                if(tcoci.checkType == CheckDepositClearingType.get(3)){
                    def checks = Cheque.findByChequeNo(tcoci.checkNo)
                    def chequebookInstance = checks.chequebook 
                    checks.chequeAmt = tcoci.checkAmt
                    checks.chequeDate = tcoci.checkDate
                    checks.isChequeClrOnUs = true
                    checks.status = CheckStatus.get(3)
                    checks.save(flush:true,failOnError:true)
                    
                    chequebookInstance.chequesUsed += 1
                    chequebookInstance.save(flush:true,failOnError:true)
                    
                    debitOnus(checks)
                    
                    tcoci.txnCheckStatus = TxnCheckStatus.get(3)
                    tcoci.cleared = true
                    tcoci.clearingDate = tc.txnDate
                }                
                tcoci.save(flush:true,failOnError:true)
            }
            //def txnBreakdownInstance = new TxnBreakdown(creditAmt:tf.txnAmt, txnDate:tf.txnDate, txnFile:tf)
            //txnBreakdownInstance.save(flush:true)
            
            
            userMasterService.updateTellerBalanceStatus(false)
            glTransactionService.saveTxnBreakdown(tc.id)
             
            flash.message = 'Transactiom completed..|success'
            //redirect(controller: "tellering", action: "createTellerOtherCheckReceiptAdjustmentTxn")
            redirect(controller: "tellering", action: "txnSuccess")
            
            session["transactionFileId"] = tc.id.toInteger()
            println "Other Check Receipt General   "+session["transactionFileId"]  
            session["map"] = "deposit"
            println"map "+session["map"]
////          calling jasper file
//            def list = TxnFile.findAllById(tf.id) 
//            params._file = "validation1.jasper"
//            params._format = "PDF"
//            params._name = "Validation"
//            chain(controller:'jasper',action:'index',model:[data:list],params:params)
            
//            render(view: '/tellering/index', model: [txnCheckReceiptAdjustmentInstance:new TxnFile()])
        }
    }
    def createTellerOtherCheckReceiptAdjustmentTxn(){
        
        def user = UserMaster.get(session.user_id)
        if (user.coci){
            def txnCOCIInstance = new TxnCOCI()
            def txnCheckReceiptAdjustmentInstance = new TxnFile()
            session["checks"] = []
            render(view:'/tellering/txnCheckReceiptAdjustment/create', model: [txnCheckReceiptAdjustmentInstance:txnCheckReceiptAdjustmentInstance])       
        }
        else{
            println user.cash
            flash.message = 'Error! No COCI account defined.|error'
            render(view: '/tellering/index')            
        }        
    }
    
/* OTHER CASH PAYMENT ADJUSTMENT */
// other cash payment general

    def saveTellerOtherCashPaymentAdjustmentTxn(TxnFile tc){
        println params //Error check
        
        if(tc.hasErrors()){
            flash.message = 'Failed to transfer.|error'
            redirectt(controller: "tellering", "createTellerOtherCashPaymentAdjustmentTxn")
        }
        else{
            def tb = new TxnCashCheckBlotter()
            tb.cashOutAmt = 0;
            tb.cashInAmt = 0;
            tb.checkInAmt = 0;
            tb.checkOutAmt = 0;
            
            tc.branch = Branch.get(UserMaster.get(session.user_id).branchId)
           
            def txnBranch = Branch.get(UserMaster.get(session.user_id).branchId)
            
            tc.txnDescription = tc.txnTemplate.codeDescription
            tc.currency = Currency.get(tc.txnTemplate.currencyId)
            tc.txnCode = tc.txnTemplate.code
            tc.txnDate = txnBranch.runDate
            //tc.txnAmt = parseFloat(params.txnAmt.replace(',',''))
            tc.txnTimestamp = new Date().toTimestamp()
            tc.user = UserMaster.get(session.user_id) 
            tc.txnType = tc.txnTemplate.txnType
            tc.save(flush:true,failOnError:true)
            tc.status = ConfigItemStatus.get(2)
            
            
            def amt = (tc.txnAmt).longValue()
            def isTxnAllowed =  policyService.isTxnAllowed(tc.txnTemplate.code, amt)
            if(isTxnAllowed == false) {
                tc.status = ConfigItemStatus.get(1)
                policyService.createException('1001', 'txnFile', tc.id, 'tellering/viewTellerTxnInquiry2/'+tc.id)
            }
            tc.save(flush:true,failOnError:true)
            tb.txnFile = tc
//            tb.save(flush:true,failOnError:true)
            //if(tb.id > 1){
            //    def tm = TxnCashCheckBlotter.get(tb.id - 1)
            //    tb.cashOutAmt = tm.cashOutAmt
            //    tb.cashInAmt += tm.cashInAmt
            //    tb.checkInAmt = tm.checkInAmt
            //    tb.checkOutAmt = tm.checkOutAmt
            //}
            tb.cashOutAmt += tc.txnAmt
            tb.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tb.currency = Currency.get(tc.txnTemplate.currencyId)
            tb.user = UserMaster.get(session.user_id)
            tb.txnParticulars = tc.txnParticulars
            tb.save(flush:true,failOnError:true)
            
            //def txnBreakdownInstance = new TxnBreakdown(creditAmt:tf.txnAmt, txnDate:tf.txnDate, txnFile:tf)
            //txnBreakdownInstance.save(flush:true)
            
            
            userMasterService.updateTellerBalanceStatus(false)
            glTransactionService.saveTxnBreakdown(tc.id)
            
            flash.message = 'Transaction complete.|success'
            //redirect(controller: "tellering", action: "createTellerOtherCashPaymentAdjustmentTxn")
            redirect(controller: "tellering", action: "txnSuccess")
            
            session["transactionFileId"] = tc.id.toInteger()
            println "Cash Payment General "+session["transactionFileId"]  
            session["map"] = "deposit"
            println " map "+session["map"] 
////          Calling jasper file
//            def list = TxnFile.findAllById(tf.id) 
//            params._file = "validation1.jasper"
//            params._format = "PDF"
//            params._name = "Validation"
//            chain(controller:'jasper',action:'index',model:[data:list],params:params)
            
//            render(view:'/tellering/index', model: [txnPaymentAdjustmentInstance:new TxnFile()])
        }
    }
    def createTellerOtherCashPaymentAdjustmentTxn(){
        
        def user = UserMaster.get(session.user_id)
        if (user.cash){
            def txnPaymentAdjustmentInstance = new TxnFile()
            render (view:'/tellering/txnPaymentAdjustment/create', model: [txnPaymentAdjustmentInstance:txnPaymentAdjustmentInstance])
        }
        else{
            println user.cash
            flash.message = 'Error! No cash account defined.|error'
            render(view: '/tellering/index')            
        }        
    }
    
/* OTHER CASH RECEIPT ADJUSTMENT */
//other cash receipt general
    
    def saveTellerOtherCashReceiptAdjustmentTxn(TxnFile tc){
        println params //Error check
        
        if(tc.hasErrors()){
            flash.message = 'Failed to transfer.|error|alert'
            redirect(action: "createTellerOtherCashReceiptAdjustmentTxn")
        }
        else{
            def tb = new TxnCashCheckBlotter()
            tb.cashOutAmt = 0;
            tb.cashInAmt = 0;
            tb.checkInAmt = 0;
            tb.checkOutAmt = 0;
            
            tc.branch = Branch.get(UserMaster.get(session.user_id).branchId)
           
            def txnBranch = Branch.get(UserMaster.get(session.user_id).branchId)
            
            tc.txnDescription = tc.txnTemplate.codeDescription
            tc.currency = Currency.get(tc.txnTemplate.currencyId)
            tc.txnCode = tc.txnTemplate.code
            tc.txnDate = txnBranch.runDate
            tc.txnTimestamp = new Date().toTimestamp()
            tc.user = UserMaster.get(session.user_id)  
            tc.txnType = tc.txnTemplate.txnType
            tc.save(flush:true,failOnError:true)
            tc.status = ConfigItemStatus.get(2)
            def amt = (tc.txnAmt).longValue()
            def isTxnAllowed =  policyService.isTxnAllowed(tc.txnTemplate.code, amt)
            if(isTxnAllowed == false) {
                tc.status = ConfigItemStatus.get(1)
                policyService.createException('1001', 'txnFile', tc.id, 'tellering/viewTellerTxnInquiry2/'+tc.id)
            }
            tc.save(flush:true,failOnError:true)
            tb.txnFile = tc
            tb.save(flush:true,failOnError:true)
            //if(tb.id > 1){
            //    def tm = TxnCashCheckBlotter.get(tb.id - 1)
            //    tb.cashOutAmt = tm.cashOutAmt
            //    tb.cashInAmt += tm.cashInAmt
            //    tb.checkInAmt = tm.checkInAmt
            //    tb.checkOutAmt = tm.checkOutAmt
            //}
            tb.cashInAmt += tc.txnAmt
            tb.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tb.currency = Currency.get(tc.txnTemplate.currencyId)
            tb.user = UserMaster.get(session.user_id)
            tb.txnParticulars = tc.txnParticulars
            tb.save(flush:true,failOnError:true)
            
            //def txnBreakdownInstance = new TxnBreakdown(creditAmt:tf.txnAmt, txnDate:tf.txnDate, txnFile:tf)
            //txnBreakdownInstance.save(flush:true)
            
            userMasterService.updateTellerBalanceStatus(false)
            glTransactionService.saveTxnBreakdown(tc.id)

            flash.message = 'Transaction complete.|success|alert'
            //redirect(controller: "tellering", action: "createTellerOtherCashReceiptAdjustmentTxn")
            //redirect(controller: "tellering", action: "txnSuccess")
            redirect(controller: "tellering", action: "txnSuccess")
            
            session["transactionFileId"] = tc.id.toInteger()
            println "Other Cash Receipt General   "+session["transactionFileId"]
            session["map"] = "deposit"
            println "map "+session["map"] 
////          Calling jasper file
//            def list = TxnFile.findAllById(tf.id) 
//            params._file = "validation1.jasper"
//            params._format = "PDF"
//            params._name = "Validation"
//            chain(controller:'jasper',action:'index',model:[data:list],params:params)
            
//            render(view:'/tellering/index', model: [txnReceiptAdjustmentInstance:new TxnFile()])
        }
    }
    def createTellerOtherCashReceiptAdjustmentTxn(){
        
        def user = UserMaster.get(session.user_id)
        if (user.cash){
            def txnReceiptAdjustmentInstance = new TxnFile()
            render (view:'/tellering/txnReceiptAdjustment/create', model: [txnReceiptAdjustmentInstance:txnReceiptAdjustmentInstance])
        }
        else{
            println user.cash
            flash.message = 'Error! No cash account defined.|error|alert'
            render(view: '/tellering/index')            
        }
        
    }
    
/* OTHER CASH PAYMENT REMITTANCE */
    
    def saveTellerOtherCashPaymentRemittanceTxn(TxnRemittance tc, TxnFile tf){
        println params //Error check
        
        if(tc.hasErrors() || tf.hasErrors()){
            flash.message = 'Failed to transfer.|error'
            render(view:'/tellering/txnCashPaymentRemittance/create', model: [txnCashPaymentRemittanceInstance:tc])
        }
        else{         
            def tb = new TxnCashCheckBlotter()
            tb.cashOutAmt = 0;
            tb.cashInAmt = 0;
            tb.checkInAmt = 0;
            tb.checkOutAmt = 0;
            
            tf.branch = Branch.get(UserMaster.get(session.user_id).branchId)
           
            def txnBranch = Branch.get(UserMaster.get(session.user_id).branchId)
            
            tf.txnDescription = tf.txnTemplate.codeDescription
            tf.currency = Currency.get(tf.txnTemplate.currencyId)
            tf.txnCode = tf.txnTemplate.code
            tf.txnDate = txnBranch.runDate
            tf.txnTimestamp = new Date().toTimestamp()
//            tf.txnAmt = parseFloat(params.txnAmt.replace(',',''))
            tf.user = UserMaster.get(session.user_id)  
            tf.txnType = tf.txnTemplate.txnType
            tf.status = ConfigItemStatus.get(2)
            tf.save(flush:true,failOnError:true)
            
            tc.txnFile = tf
            tc.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tc.user = UserMaster.get(session.user_id)
            tc.currency = Currency.get(tf.txnTemplate.currencyId)
            tc.status = ConfigItemStatus.get(2)
            tc.txnDate = txnBranch.runDate
            tc.save(flush:true,failOnError:true)
            //tf.txnId = tc.id
            //tf.txnDate = new Date()
            
            def amt = (tf.txnAmt).longValue()
            def isTxnAllowed =  policyService.isTxnAllowed(tf.txnTemplate.code, amt)
            if(isTxnAllowed == false) {
                tf.status = ConfigItemStatus.get(1)
                policyService.createException('1001', 'txnFile', tf.id, 'tellering/viewTellerTxnInquiry2/'+tf.id)
            }
            tf.save(flush:true,failOnError:true)
            tb.txnFile = tf
//            tb.save(flush:true,failOnError:true)
            //if(tb.id > 1){
            //    def tm = TxnCashCheckBlotter.get(tb.id - 1)
            //    tb.cashOutAmt = tm.cashOutAmt
            //    tb.cashInAmt += tm.cashInAmt
            //    tb.checkInAmt = tm.checkInAmt
            //    tb.checkOutAmt = tm.checkOutAmt
            //}
            tb.cashOutAmt += tc.txnAmt
            tb.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tb.currency = Currency.get(tf.txnTemplate.currencyId)
            tb.user = UserMaster.get(session.user_id)
            tb.txnParticulars = tf.txnParticulars
            tb.save(flush:true,failOnError:true)
            
            //def txnBreakdownInstance = new TxnBreakdown(creditAmt:tf.txnAmt, txnDate:tf.txnDate, txnFile:tf)
            //txnBreakdownInstance.save(flush:true)
            
            userMasterService.updateTellerBalanceStatus(false)
            glTransactionService.saveTxnBreakdown(tf.id)
            
        
            flash.message = 'Transaction complete.|success'
            //redirect(controller: "tellering", action: "createTellerOtherCashPaymentRemittanceTxn")
            redirect(controller: "tellering", action: "txnSuccess")
            
            session["transactionFileId"] = tf.id.toInteger()
            println "Other Cash Payment remittance   "+session["transactionFileId"]  
            session["map"] = "remittance"
            println"map "+session["map"]
            
////          Calling jasper file
//            def list = TxnFile.findAllById(tf.id) 
//            params._file = "validation1.jasper"
//            params._format = "PDF"
//            params._name = "Validation"
//            chain(controller:'jasper',action:'index',model:[data:list],params:params)
            
//            render(view:'/tellering/index', model: [txnCashPaymentRemittanceInstance:new TxnRemittance()])
        }
    }
    def createTellerOtherCashPaymentRemittanceTxn(){
        def user = UserMaster.get(session.user_id)
        if (user.cash){
            def txnFileInstance = new TxnFile()
            def txnCashPaymentRemittanceInstance = new TxnRemittance()
            render (view:'/tellering/txnCashPaymentRemittance/create', model: [txnCashPaymentRemittanceInstance:txnCashPaymentRemittanceInstance])
           
        }
        else{
            println user.cash
            flash.message = 'Error! No cash account defined.|error'
            render(view: '/tellering/index')            
        }        
    }
    
/* OTHER CASH RECEIPT REMITTANCE */
    
    def saveTellerOtherCashReceiptRemittanceTxn(TxnRemittance tc, TxnFile tf){
        println params //Error check
        println "params "+params.sender
        if(tc.hasErrors() || tf.hasErrors()){
            println tc.errors
            println tf.errors
            flash.message = 'Failed to transfer.|error|alert'
            render(view:'/tellering/txnCashReceiptRemittance/create', model: [txnCashReceiptRemittanceInstance:tc])
        }
        else{
//            println "txnCashReceiptRemittanceInstance "+txnCashReceiptRemittanceInstance
            def tb = new TxnCashCheckBlotter()
            tb.cashOutAmt = 0;
            tb.cashInAmt = 0;
            tb.checkInAmt = 0;
            tb.checkOutAmt = 0;
            
            tf.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            //def description = TxnTemplate.get(tf.txnType.toInteger())
            def txnBranch = Branch.get(UserMaster.get(session.user_id).branchId)
            
            tf.txnDescription = tf.txnTemplate.codeDescription
            tf.currency = Currency.get(tf.txnTemplate.currencyId)
            tf.txnCode = tf.txnTemplate.code
            tf.txnDate = txnBranch.runDate
            tf.txnTimestamp = new Date().toTimestamp()
            tf.user = UserMaster.get(session.user_id)            
            tf.save(flush:true,failOnError:true)
            tc.txnFile = tf
            tc.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tc.user = UserMaster.get(session.user_id)
            tc.currency = Currency.get(tf.txnTemplate.currencyId)
            tc.status = ConfigItemStatus.get(2)
            tc.txnDate = txnBranch.runDate
            tc.save(flush:true,failOnError:true)
            //tf.txnId = tc.id
            //tf.txnDate = new Date()
            tf.txnType = tf.txnTemplate.txnType
            tf.status = ConfigItemStatus.get(2)
            def amt = (tf.txnAmt).longValue()
            def isTxnAllowed =  policyService.isTxnAllowed(tf.txnTemplate.code, amt)
            if(isTxnAllowed == false) {
                tf.status = ConfigItemStatus.get(1)
                policyService.createException('1001', 'txnFile', tf.id, 'tellering/viewTellerTxnInquiry2/'+tf.id)
            }
            tf.save(flush:true,failOnError:true)
            tb.txnFile = tf
            tb.save(flush:true,failOnError:true)
            //if(tb.id > 1){
            //    def tm = TxnCashCheckBlotter.get(tb.id - 1)
            //    tb.cashOutAmt = tm.cashOutAmt
            //    tb.cashInAmt += tm.cashInAmt
            //    tb.checkInAmt = tm.checkInAmt
            //    tb.checkOutAmt = tm.checkOutAmt
            //}
            tb.cashInAmt += tc.txnAmt
            tb.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tb.currency = Currency.get(tf.txnTemplate.currencyId)
            tb.user = UserMaster.get(session.user_id)
            tb.txnParticulars = tf.txnParticulars
            tb.save(flush:true,failOnError:true)
            
            //def txnBreakdownInstance = new TxnBreakdown(creditAmt:tf.txnAmt, txnDate:tf.txnDate, txnFile:tf)
            //txnBreakdownInstance.save(flush:true)
            
            userMasterService.updateTellerBalanceStatus(false)
            glTransactionService.saveTxnBreakdown(tf.id)

            
            flash.message = 'Transaction complete.|success|alert'
            //redirect(controller: "tellering", action: "createTellerOtherCashReceiptRemittanceTxn")
            redirect(controller: "tellering", action: "txnSuccess")

            session["transactionFileId"] = tf.id.toInteger()
            println "Other cash receipt remittance   "+session["transactionFileId"]
            session["map"] = "remittance"
            println"map "+session["map"]
////          Calling jasper file
//            def list = TxnFile.findAllById(tf.id) 
//            params._file = "validation1.jasper"
//            params._format = "PDF"
//            params._name = "Validation"
//            chain(controller:'jasper',action:'index',model:[data:list],params:params)
            
//            render(view:'/tellering/index', model: [txnCashReceiptRemittanceInstance:new TxnRemittance()])
        }
    }
    def createTellerOtherCashReceiptRemittanceTxn(){
        
        def user = UserMaster.get(session.user_id)
        if (user.cash){
            def txnFileInstance = new TxnFile()
            def txnCashReceiptRemittanceInstance = new TxnRemittance()
            render (view:'/tellering/txnCashReceiptRemittance/create', model: [txnCashReceiptRemittanceInstance:txnCashReceiptRemittanceInstance])
        }
        else{
            flash.message = 'Error! No cash account defined.|error|alert'
            render(view: '/tellering/index')            
        }        
    }
    
/* OTHER CHECK RECEIPT REMITTANCE */
    
    def saveTellerOtherCheckReceiptRemittanceTxn(TxnRemittance tc, TxnFile tf){
        println params //Error check
        
        if(tc.hasErrors() || tf.hasErrors()){
            flash.message = 'Failed to transfer.|error'
            redirect(action: "createTellerOtherCheckReceiptRemittanceTxn")
            //render(view:'/tellering/txnCheckReceiptRemittance/create', model: [txnCheckReceiptRemittanceInstance:tc])
        }
        else{
            def tb = new TxnCashCheckBlotter()
            tb.cashOutAmt = 0;
            tb.cashInAmt = 0;
            tb.checkInAmt = 0;
            tb.checkOutAmt = 0;
            
            tf.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            
            def txnBranch = Branch.get(UserMaster.get(session.user_id).branchId)
            
            tf.txnDescription = tf.txnTemplate.codeDescription
            tf.currency = Currency.get(tf.txnTemplate.currencyId)
            tf.txnCode = tf.txnTemplate.code
            tf.txnDate = txnBranch.runDate
            tf.txnTimestamp = new Date().toTimestamp()
            tf.user = UserMaster.get(session.user_id)            
            tf.txnType = tf.txnTemplate.txnType
            tf.save(flush:true,failOnError:true)
            
            tc.txnFile = tf
            tc.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tc.user = UserMaster.get(session.user_id)
            tc.currency = Currency.get(tf.txnTemplate.currencyId)
            tc.status = ConfigItemStatus.get(2)
            tc.txnDate = txnBranch.runDate
            tc.save(flush:true,failOnError:true)
            //tf.txnId = tc.id
            //tf.txnDate = new Date()
            tf.txnType = tf.txnTemplate.txnType
            tf.status = ConfigItemStatus.get(2)
            def amt = (tf.txnAmt).longValue()
            def isTxnAllowed =  policyService.isTxnAllowed(tf.txnTemplate.code, amt)
            if(isTxnAllowed == false) {
                tf.status = ConfigItemStatus.get(1)
                policyService.createException('1001', 'txnFile', tf.id, 'tellering/viewTellerTxnInquiry2/'+tf.id)
            }
            tf.save(flush:true,failOnError:true)
            tb.txnFile = tf
            tb.save(flush:true,failOnError:true)
            //if(tb.id > 1){
            //    def tm = TxnCashCheckBlotter.get(tb.id - 1)
            //    tb.cashOutAmt = tm.cashOutAmt
            //    tb.cashInAmt += tm.cashInAmt
            //    tb.checkInAmt = tm.checkInAmt
            //    tb.checkOutAmt = tm.checkOutAmt
            //}
            tb.checkInAmt += tc.txnAmt
            tb.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tb.currency = Currency.get(tf.txnTemplate.currencyId)
            tb.user = UserMaster.get(session.user_id)
            tb.txnParticulars = tf.txnParticulars
            tb.save(flush:true,failOnError:true)
            
            session["checks"].id.each {tcoci_id ->
                def tcoci = TxnCOCI.get(tcoci_id)
                tcoci.status = ConfigItemStatus.get(2)
                tcoci.txnCheckStatus = TxnCheckStatus.get(2)
                println "CHECK STATUS " + tcoci.txnCheckStatus
                tcoci.txnFile = tf
               
                def checkClearDate = tcoci.checkType.clearingDate
                tcoci.clearingDate = checkClearDate
                if(tcoci.checkType == CheckDepositClearingType.get(3)){
                    def checks = Cheque.findByChequeNo(tcoci.checkNo)
                    def chequebookInstance = checks.chequebook 
                    checks.chequeAmt = tcoci.checkAmt
                    checks.chequeDate = tcoci.checkDate
                    checks.isChequeClrOnUs = true
                    checks.status = CheckStatus.get(3)
                    checks.save(flush:true,failOnError:true)
                    
                    chequebookInstance.chequesUsed += 1
                    chequebookInstance.save(flush:true,failOnError:true)
                    
                    debitOnus(checks)
                    
                    tcoci.txnCheckStatus = TxnCheckStatus.get(3)
                    tcoci.cleared = true
                    tcoci.clearingDate = tf.txnDate
                }                 
                tcoci.save(flush:true,failOnError:true)
            }            
            
            //def txnBreakdownInstance = new TxnBreakdown(creditAmt:tf.txnAmt, txnDate:tf.txnDate, txnFile:tf)
            //txnBreakdownInstance.save(flush:true)
            
            userMasterService.updateTellerBalanceStatus(false)
            glTransactionService.saveTxnBreakdown(tf.id)      
            
            flash.message = 'Transaction complete...|success'
            //redirect(controller: "tellering", action: "createTellerOtherCheckReceiptRemittanceTxn")
            redirect(controller: "tellering", action: "txnSuccess")
            
            session["transactionFileId"] = tf.id.toInteger()
            println "Other Check receipt remittance  "+session["transactionFileId"]
            session["map"] = "remittance"
            //println"map "+session["map"]map 
////          calling jasper file
//            def list = TxnFile.findAllById(tf.id) 
//            params._file = "validation1.jasper"
//            params._format = "PDF"
//            params._name = "Validation"
//            chain(controller:'jasper',action:'index',model:[data:list],params:params)
//            
//            render(view:'/tellering/index', model: [txnCheckReceiptRemittanceInstance:new TxnRemittance()])
        }
    }
    def createTellerOtherCheckReceiptRemittanceTxn(){
       
        def user = UserMaster.get(session.user_id)
        if (user.cash){
            def txnFileInstance = new TxnFile()
            def txnCOCIInstance = new TxnCOCI()
            session["checks"] = []
            def txnCheckReceiptRemittanceInstance = new TxnRemittance()
            render (view:'/tellering/txnCheckReceiptRemittance/create', model: [txnCheckReceiptRemittanceInstance:txnCheckReceiptRemittanceInstance])
        }
        else{
            flash.message = 'Error! No cash account defined.|error'
            render(view: '/tellering/index')            
        }        
        
    }
    
/* CASH DEPOSIT */
    @Transactional
    def saveTellerCashDepositTxn(TxnDepositAcctLedger tc, TxnFile tf){
        println params //Error check
							
										  
        
        if(tc.hasErrors() || tf.hasErrors()){
            flash.message = 'Failed to transfer|error|alert'
            redirect(controller: "tellering", action: "createTellerCashDepositTxn")
        }
        else{
            def depositInstance = Deposit.get(params.deposit.id);
            def temp = ((params.creditAmt).replace(',','')).toDouble();
          
												 
																		
            def txnTemp = tf.txnTemplate
            def branch = Branch.get(depositInstance.branchId)
            def acctProduct = ProductTxn.findAllWhere(product:depositInstance.product,txnTemplate:txnTemp)
//            println "PROD" + depositInstance.product
//            println "txnTemps" + txnTemp
            def depLedger = TxnDepositAcctLedger.findAllWhere(acctNo:depositInstance.acctNo)
            def userBranch = UserMaster.get(session.user_id)
            if (depositInstance.statusId == 5){
                flash.message = 'Dormant Account|error|alert'
                render(view: '/tellering/txnCashDeposit/create', model: [txnCashDepositInstance:tc])
                return    
            }
            
            // transaction not allowed for product
            if (!acctProduct) {
                flash.message = 'Transaction not allowed for product|error|alert'
                render(view: '/tellering/txnCashDeposit/create', model: [txnCashDepositInstance:tc])
                return                
            }
            
            // check opening deposit
            if (!depLedger){
                if (temp < depositInstance.product.minOpen){
                    flash.message = 'Product requires minimum opening deposit|error|alert'
                    render(view: '/tellering/txnCashDeposit/create', model: [txnCashDepositInstance:tc])
                    return 
                }
            }
            
            // fd deposit check
            if (depositInstance.product.productType == ProductType.get(3) && depositInstance.currentRollover.startDate != branch.runDate){
                flash.message = 'Transaction not allowed for FD|error|alert'
                render(view: '/tellering/txnCashDeposit/create', model: [txnCashDepositInstance:tc])
                return                                
            }
            // interbranch transactions account check
            if (depositInstance.branch != userBranch.branch && txnTemp.interbranchTxn != YesNoNa.get(1)){
            //if (depositInstance.branch != userBranch.branch && tf.txnTemplateId == 5 && txnTemp.interbranchTxn != 1){
                flash.message = 'Interbranch transaction for Other branch account only|error|alert'
                render(view: '/tellering/txnCashDeposit/create', model: [txnCashDepositInstance:tc])
                return                                                
            }
            
            //    
            
            // update instances
            tf.acctNo = depositInstance.acctNo
            tf.depAcct = depositInstance
            //tf.currency = Currency.get(depositInstance.product.currencyId)
            tf.currency = Currency.get(txnTemp.currencyId)
            println "CURRENCY " + tf.currency
            tf.user = UserMaster.get(session.user_id)
            tf.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tf.txnAmt = temp
            tf.txnCode = txnTemp.code
            tf.txnDate = branch.runDate
            tf.txnTimestamp = new Date().toTimestamp()
            tf.txnDescription = txnTemp.codeDescription
            tf.status = ConfigItemStatus.get(2)
            tf.save(flush:true,failOnError:true)
            
            tc.acct = depositInstance
            tc.txnType = tf.txnTemplate.txnType
            tc.acctNo = depositInstance.acctNo
            tc.bal = depositInstance.ledgerBalAmt + temp
            tc.branch = branch
            //tc.currency = Currency.get(depositInstance.product.currencyId)
            tc.currency = Currency.get(txnTemp.currencyId)
            println "CURRENCY " + tc.currency
            tc.txnDate = branch.runDate
            tc.user = UserMaster.get(session.user_id)
            tc.status = DepositStatus.get(2)
            tc.passbookBal = 0
            tc.save(flush:true,failOnError:true)
            
            depositInstance.ledgerBalAmt += temp;            
            depositInstance.availableBalAmt += temp;
            //depositInstance.outstandingBalAmt += temp;
            depositInstance.save(flush:true,failOnError:true)
           
           if (txnTemp.requirePassbook  == YesNoNa.get(1))
            { 
                println "PUSH"
                depositInstance.passbookBalAmt = depositInstance.ledgerBalAmt
                depositInstance.save(flush:true,failOnError:true);
                tc.passbookBal = depositInstance.ledgerBalAmt
                tc.save(flush:true)
                jrxmlTcId = tc.id.toInteger()  //tc id 
                if(passbookline == null){
                    // tc.passbookLine = 1;
                    println " pumasok sa null"
                }
               
                else if(passbookline >=1 && passbookline <=26 ){
                  //  def val = passbookline + 1 
                    // tc.passbookLine = val
                    println " pumasok sa 1 - 26"
                }
                else{
                     // tc.passbookLine = 1;
                }     
                  
                    tc.save(flush:true,failOnError:true)

            }
//            For passbook validation
            //passbookline = tc.passbookLine
            def sql = new Sql(dataSource) 
            def row = sql.firstRow("select min(id) from txn_deposit_acct_ledger where acct_id = "+pbvalidate)
            if (row.min != null) {
                txnDepAccMinId = row.min.toInteger() //min id
            }
            
            
            def tb = new TxnCashCheckBlotter()
            tb.cashOutAmt = 0;
            tb.cashInAmt = 0;
            tb.checkInAmt = 0;
            tb.checkOutAmt = 0;
                        
            tc.txnFile = tf
            tc.save(flush:true,failOnError:true)
            tf.txnType = tf.txnTemplate.txnType
            //tf.txnId = tc.id
            //tf.txnDate = new Date()
            //def description = TxnTemplate.get(tf.txnType.toInteger())
            //tf.txnDescription = description.codeDescription
            //tf.status = ConfigItemStatus.get(2)
            def amt = (temp).longValue()
            def isTxnAllowed =  policyService.isTxnAllowed(txnTemp.code, amt)
            if(isTxnAllowed == false) {
                tf.status = ConfigItemStatus.get(1)
                policyService.createException('TLR00300', 'txnFile', tf.id, 'tellering/viewTellerTxnInquiry2/'+tf.id)
            }
            tf.save(flush:true,failOnError:true)
            tb.txnFile = tf
            tb.save(flush:true,failOnError:true)
            //if(tb.id > 1){
            //    def tm = TxnCashCheckBlotter.get(tb.id - 1)
            //    tb.cashOutAmt = tm.cashOutAmt
            //    tb.cashInAmt += tm.cashInAmt
            //    tb.checkInAmt = tm.checkInAmt
            //    tb.checkOutAmt = tm.checkOutAmt
            //}
            tb.cashInAmt += temp;
            tb.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            //tb.currency = Currency.get(depositInstance.product.currencyId)
            tb.currency = Currency.get(txnTemp.currencyId)
            println "CURRENCY " + tb.currency
            tb.user = UserMaster.get(session.user_id)
            tb.txnParticulars = tf.txnRef + ' ' + tf.acctNo
            tb.save(flush:true,failOnError:true)          
            //def txnBreakdownInstance = new TxnBreakdown(creditAmt:tf.txnAmt, txnDate:tf.txnDate, txnFile:tf)
            //txnBreakdownInstance.save(flush:true)
            
            userMasterService.updateTellerBalanceStatus(false)
            glTransactionService.saveTxnBreakdown(tf.id)
            
            flash.message = 'Cash Deposit Transaction (Success)|success|alert'
            //redirect(controller: "tellering", action:"createTellerCashDepositTxn")
            redirect(controller: "tellering", action: "txnSuccess")
            
            session["transactionFileId"] = tf.id.toInteger()
            println "Cash Deposit   "+session["transactionFileId"]  
            session["map"] = "deposit"
            println"map "+session["map"]
////          Calling jasper file
//            def list = TxnFile.findAllById(tf.id) 
//            params._file = "validation1.jasper"
//            params._format = "PDF"
//            params._name = "Validation"
//            chain(controller:'jasper',action:'index',model:[data:list],params:params)s
//            render(view: '/tellering/index', model: [txnCashDepositInstance:new TxnDepositAcctLedger()])
        }
        
    }

    def createTellerCashDepositTxn(){
        session["map"] = 'deposit'
        def user = UserMaster.get(session.user_id)
        if (user.cash){
            def txnFileInstance = new TxnFile()
            def txnCashDepositInstance = new TxnDepositAcctLedger()
            render(view:'/tellering/txnCashDeposit/create', model: [txnCashDepositInstance:txnCashDepositInstance, id:txnDepAccMinId, jrxmlTcId:jrxmlTcId, passbookline:passbookline]) //added params for passbook validation        
        }
        else{
            flash.message = 'Error! No cash account defined'
            render(view: '/tellering/index')            
        }        
    }

    
/* CHECK DEPOSIT */
    
    def saveTellerCheckDepositTxn(TxnDepositAcctLedger tc, TxnFile tf){
        println params //Error check
        
						   
											 
        if(tc.hasErrors() || tf.hasErrors() || !params.deposit.id){
            flash.message = 'Failed to transfer|error'
            redirect(controller: "tellering", action: "createTellerCheckDepositTxn")
        }
        else{
            def depositInstance = Deposit.get(params.deposit.id);
												  
												 
																		 
            def temp = (params.creditAmt.replace(',','')).toDouble();
            println "bal: " + temp
            def txnTemp = tf.txnTemplate
            def branch = Branch.get(depositInstance.branchId)
            def acctProduct = ProductTxn.findAllWhere(product:depositInstance.product,txnTemplate:txnTemp)
            def depLedger = TxnDepositAcctLedger.findAllWhere(acctNo:depositInstance.acctNo)
            def userBranch = UserMaster.get(session.user_id)
//            println "product "+depositInstance.product
//             println "template "+txnTemp
            
            if (depositInstance.statusId == 5){
                flash.message = 'Dormant Account|info'
                render(view: '/tellering/txnCashDeposit/create', model: [txnCashDepositInstance:tc])
                return    
            }
            
            // transaction not allowed for product
            if (!acctProduct) {
                flash.message = 'Transaction not allowed for product|error'
                render(view: '/tellering/txnCheckDeposit/create', model: [txnCheckDepositInstance:tc])
                return                
            }
            
            // check opening deposit
            if (!(depLedger) && temp < depositInstance.product.minOpen){
                flash.message = 'Product requires minimum opening deposit|info'
                render(view: '/tellering/txnCheckDeposit/create', model: [txnCheckDepositInstance:tc])
                return                                
            }

            // fd deposit check
            if (depositInstance.product.productType == ProductType.get(3) && depositInstance.currentRollover.startDate != branch.runDate){
                if (branch.runDate != depositInstance.currentRollover.endDate){
                    flash.message = 'Transaction not allowed for FD - start/maturity|error'
                    render(view: '/tellering/txnCashDeposit/create', model: [txnCashDepositInstance:tc])
                    return                                
                }
            }
            // interbranch transactions account check
            if (depositInstance.branch != userBranch.branch && txnTemp.interbranchTxn != YesNoNa.get(1)){
            //if (depositInstance.branch != userBranch.branch && tf.txnTemplateId == 7 && txnTemp.interbranchTxn != 1){
                flash.message = 'Interbranch transaction for Other branch account only|info'
                render(view: '/tellering/txnCheckDeposit/create', model: [txnCheckDepositInstance:tc])
                return                                                
            }
            
            // on-us check deposit validation
            session["checks"].id.each { tcoci_id ->
               // def tcoci_id = it.toInteger()
                println "txncoci id: "+tcoci_id
                def tcoci = TxnCOCI.get(tcoci_id)
                if(tcoci.checkType == CheckDepositClearingType.get(3)){
                    def onusDep = Deposit.findByAcctNo(tcoci.acctNo)
                    if (onusDep) {
                        def onusChk = Cheque.findByChequeNo(tcoci.checkNo)
                        if (onusChk) {
                            if (!onusChk.chequebook) {
                                flash.message = 'Check not issued [' + tcoci.checkNo + ']|error'
                                render(view: '/tellering/txnCashDeposit/create', model: [txnCashDepositInstance:tc])
                                return                                  
                            }
                            // validate SPO
                            def spo = StopPaymentOrder.findByChequeAndStatus(onusChk, ConfigItemStatus.read(2))
                            if (spo) {
                                flash.message = 'Check stopped [' + tcoci.checkNo + ']|error'
                                render(view: '/tellering/txnCashDeposit/create', model: [txnCashDepositInstance:tc])
                                return                                 
                            }

                            if (onusChk.chequebook.deposit.acctNo == onusDep.acctNo) {
                                if (onusDep.availableBalAmt < tcoci.checkAmt)
                                    flash.message = 'DAIF Account [' + tcoci.acctNo + ']|error'
                                    render(view: '/tellering/txnCashDeposit/create', model: [txnCashDepositInstance:tc])
                                    return                                 
                            } else {
                                flash.message = 'On-us check number and Account does not match|error'
                                render(view: '/tellering/txnCashDeposit/create', model: [txnCashDepositInstance:tc])
                                return                                  
                            }
                        } else {
                            flash.message = 'Invalid On-us check number [' + tcoci.checkNo + ']|error'
                            render(view: '/tellering/txnCashDeposit/create', model: [txnCashDepositInstance:tc])
                            return                              
                        }
                    } else {
                        flash.message = 'Invalid On-us Account [' + tcoci.acctNo + ']|error'
                        render(view: '/tellering/txnCashDeposit/create', model: [txnCashDepositInstance:tc])
                        return                         
                    }
                }                
            }            
            // update instances
            tf.acctNo = depositInstance.acctNo
            tf.depAcct = depositInstance
            //tf.currency = Currency.get(depositInstance.product.currencyId)
            tf.currency = Currency.get(txnTemp.currencyId)
            println "CURRENCY " + tf.currency 
            tf.user = UserMaster.get(session.user_id)
            tf.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tf.txnAmt = temp
            tf.txnCode = txnTemp.code
            tf.txnDate = branch.runDate
            tf.txnTimestamp = new Date().toTimestamp()
            tf.txnDescription = txnTemp.codeDescription
            tf.status = ConfigItemStatus.get(2)
            tf.save(flush:true,failOnError:true)
            
            tc.acct = depositInstance
            tc.txnType = tf.txnTemplate.txnType
            tc.acctNo = depositInstance.acctNo
            tc.bal = depositInstance.ledgerBalAmt + temp
            tc.branch = branch
            //tc.currency = Currency.get(depositInstance.product.currencyId)
            tc.currency = Currency.get(txnTemp.currencyId)
            println "CURRENCY " + tc.currency 
            tc.txnDate = branch.runDate
            tc.user = UserMaster.get(session.user_id)
            tc.status = DepositStatus.get(2)
            tc.passbookBal = 0
            tc.save(flush:true,failOnError:true)
            
            depositInstance.ledgerBalAmt += temp;
            if (depositInstance.unclearedCheckBalAmt == null)
            {
                depositInstance.unclearedCheckBalAmt = temp;
            }
            else
            {depositInstance.unclearedCheckBalAmt += temp;}
            
            //depositInstance.outstandingBalAmt += temp;
            depositInstance.save(flush:true,failOnError:true)
            
            if (txnTemp.requirePassbook == YesNoNa.get(1))
            {
                depositInstance.passbookBalAmt = depositInstance.ledgerBalAmt
                depositInstance.save(flush:true,failOnError:true)
                tc.passbookBal = depositInstance.ledgerBalAmt
                tc.save(flush:true)
                jrxmlTcId = tc.id.toInteger() //tc id
  
                if(passbookline == null){
                    //tc.passbookLine = 1;
                    println " pumasok sa null"
                }
               
                else if(passbookline >=1 && passbookline <=26 ){
                   // def val = passbookline + 1 
                    //tc.passbookLine = val
                    println " pumasok sa 1 - 26"
                }
                else{
                     //tc.passbookLine = 1;
                     println " pumasok sa else"
                }     
                   
                    tc.save(flush:true,failOnError:true)      
            
            }
//            For passbook validation
            //passbookline = tc.passbookLine 
            def sql = new Sql(dataSource) 
            def row = sql.firstRow("select min(id) from txn_deposit_acct_ledger where acct_id = "+pbvalidate)
            if(row.min != null){
               txnDepAccMinId = row.min.toInteger() //min id  
            }
            else{
                //walang laman
            }
            def tb = new TxnCashCheckBlotter()
            tb.cashOutAmt = 0;
            tb.cashInAmt = 0;
            tb.checkInAmt = 0;
            tb.checkOutAmt = 0;
                        
            tc.txnFile = tf
            tc.save(flush:true,failOnError:true)
            tf.txnType = tf.txnTemplate.txnType
            //tf.txnId = tc.id
            //tf.txnDate = new Date()
            //def description = TxnTemplate.get(tf.txnType.toInteger())
            //tf.txnDescription = description.codeDescription
            //tf.status = ConfigItemStatus.get(2)
            def amt = temp
            println("amt: "+amt)
            def isTxnAllowed =  policyService.isTxnAllowed(txnTemp.code, amt)
            if(isTxnAllowed == false) {
                tf.status = ConfigItemStatus.get(1)
                policyService.createException('TLR00300', 'txnFile', tf.id, 'tellering/viewTellerTxnInquiry2/'+tf.id)
            }
            tf.save(flush:true,failOnError:true)
            tb.txnFile = tf
            tb.save(flush:true,failOnError:true)
            //if(tb.id > 1){
            //    def tm = TxnCashCheckBlotter.get(tb.id - 1)
            //    tb.cashOutAmt = tm.cashOutAmt
            //    tb.cashInAmt += tm.cashInAmt
            //    tb.checkInAmt = tm.checkInAmt
            //    tb.checkOutAmt = tm.checkOutAmt
            //}
            println("tb.checkInAmt: "+tb.checkInAmt)
            println("temp: "+temp)
            tb.checkInAmt += temp;
            println("tb.checkInAmt: "+tb.checkInAmt)
            tb.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            //tb.currency = Currency.get(depositInstance.product.currencyId)
            tb.currency = Currency.get(txnTemp.currencyId)
            println "CURRENCY " + tb.currency 
            tb.user = UserMaster.get(session.user_id)
            tb.txnParticulars = tf.txnRef + ' ' + tf.acctNo
            tb.save(flush:true)            
            

            session["checks"].id.each { tcoci_id ->
               // def tcoci_id = it.toInteger()
                println "txncoci id: "+tcoci_id
                def tcoci = TxnCOCI.get(tcoci_id)
                tcoci.status = ConfigItemStatus.get(2)
                tcoci.txnCheckStatus = TxnCheckStatus.get(2)
                tcoci.txnFile = tf
                tcoci.depAcct = depositInstance
                def checkClearDate = tcoci.checkType.clearingDate //CheckDepositClearingType.get(tcoci.checkType).clearingDate
                tcoci.clearingDate = checkClearDate
                //tcoci.checkAmt = depositInstance.unclearedCheckBalAmt
                //println "CHECK TOTAL AMT " + tcoci.checkAmt
                
                if(tcoci.checkType == CheckDepositClearingType.get(3)){
                    def checks = Cheque.findByChequeNo(tcoci.checkNo)
                    def chequebookInstance = checks.chequebook 
                    checks.chequeAmt = tcoci.checkAmt
                    println("the cheque amount in condition: "+tcoci.checkAmt)
                    checks.chequeDate = tcoci.checkDate
                    checks.clrAcctNo = depositInstance.acctNo
                    checks.isChequeClrOnUs = true
                    checks.status = CheckStatus.get(3)
                    checks.save(flush:true,failOnError:true)
                    
                    chequebookInstance.chequesUsed += 1
                    chequebookInstance.save(flush:true,failOnError:true)
                    
                    debitOnus(checks)
                    
                    tcoci.txnCheckStatus = TxnCheckStatus.get(3)
                    tcoci.cleared = true
                    tcoci.clearingDate = tf.txnDate
                    
                    depositInstance.unclearedCheckBalAmt -= tcoci.checkAmt
                    depositInstance.availableBalAmt += tcoci.checkAmt
                    depositInstance.save(flush:true, failOnError:true)
                }
                
                tcoci.save(flush:true,failOnError:true)
            }
            //def txnBreakdownInstance = new TxnBreakdown(creditAmt:tf.txnAmt, txnDate:tf.txnDate, txnFile:tf)
            //txnBreakdownInstance.save(flush:true)
            
            
            userMasterService.updateTellerBalanceStatus(false)
            glTransactionService.saveTxnBreakdown(tf.id)
            
            flash.message = 'Transaction Complete..|success'
            //redirect(controller: "tellering", action: "createTellerCheckDepositTxn")
            redirect(controller: "tellering", action: "txnSuccess")
            
            session["transactionFileId"] = tf.id.toInteger()
            println "Check Deposit "+session["transactionFileId"]  
            session["map"] = "deposit"
            println"map "+session["map"]

//          Calling jasper file
//            def list = TxnFile.findAllById(tf.id) 
//            params._file = "validation1.jasper"
//            params._format = "PDF"
//            params._name = "Validation"
//            chain(controller:'jasper',action:'index',model:[data:list],params:params)

        }
    }
    def debitOnus(Cheque cheque) {
        // update txn file
        def txnType = TxnTemplate.read(Institution.findByParamCode('GLS.60112').paramValue.toInteger())
        def depositInstance = cheque.chequebook.deposit
        
        def txnFile1 = new TxnFile(txnDate:Branch.get(1).runDate,txnParticulars:'ONUS',
            currency:depositInstance.product.currency.id,txnType:txnType.txnType,status:ConfigItemStatus.read(2),
            txnTimestamp:new Date().toTimestamp(),user:UserMaster.get(session.user_id),branch:depositInstance.branch,
            txnCode:txnType.code, txnDescription:txnType.description,acctNo:depositInstance.acctNo,
            txnAmt:cheque.chequeAmt,txnRef:'onus '+ cheque.chequeNo.toString(),depAcct:depositInstance,txnTemplate:txnType)
            txnFile1.save(flush:true,validate:false, failOnError:true)
        println("****************************************************************************")    
        println("checque Amount Debit Onus : "+cheque.chequeAmt)     
        println("before debit deposit availableBalAmt: "+depositInstance.availableBalAmt)
        depositInstance.availableBalAmt-=cheque.chequeAmt
        println("debited deposit available Bal Amt: "+depositInstance.availableBalAmt)
        println("debited deposit ledger Bal Amt: "+depositInstance.ledgerBalAmt)
        depositInstance.ledgerBalAmt-=cheque.chequeAmt
        println("after debiting ledgerBalAmt: "+depositInstance.ledgerBalAmt)
        println("****************************************************************************")
        depositInstance.save(flush:true, failOnError:true)
                        
        // update ledger
        def acctLedger1 = new TxnDepositAcctLedger(txnType:txnType.txnType,user:UserMaster.get(session.user_id),branch:depositInstance.branch,
            currency:depositInstance.product.currency,status:depositInstance.status,txnDate:Branch.get(1).runDate,
            txnFile:txnFile1,acct:depositInstance,acctNo:depositInstance.acctNo,debitAmt:cheque.chequeAmt,
            bal:depositInstance.ledgerBalAmt,txnRef:'onus '+ cheque.chequeNo.toString())
        acctLedger1.save(flush:true, validate:false, failOnError:true)                       
        glTransactionService.saveOnusGl(txnFile1)        
    }
    
    def createTellerCheckDepositTxn(){
        session["map"] = 'deposit'
        def user = UserMaster.get(session.user_id)
        if (user.coci){
            def txnFileInstance = new TxnFile()
            def txnCOCIInstance = new TxnCOCI()
            def txnCheckDepositInstance = new TxnDepositAcctLedger()
            session["checks"] = [] 
            render(view:'/tellering/txnCheckDeposit/create', model: [txnCheckDepositInstance:txnCheckDepositInstance, id:txnDepAccMinId, jrxmlTcId:jrxmlTcId, passbookline:passbookline]) //added params for passbook validation       
        }
        else{
            flash.message = 'Error! No COCI account defined'
            render(view: '/tellering/index')            
        }        
    }
    
/* CASH WITHDRAWAL */
    
    def saveTellerCashWithdrawalTxn(TxnDepositAcctLedger tc, TxnFile tf){
        println params //Error check
        
						   
											
        if(tc.hasErrors() || tf.hasErrors()){
            flash.message = 'Failed to transfer.|error|alert'
            render(view: '/tellering/txnCashWithdrawal/create', model: [txnCashWithdrawalInstance:tc])
        }
        else{
            def depositInstance = Deposit.get(params.deposit.id);
            //def temp = params.debitAmtreplaceAll(","," ").toDouble();
												  
												 
																								 
            def temp = params.debitAmt.replaceAll(",","").toDouble();
            def txnTemp = tf.txnTemplate
            def branch = Branch.get(depositInstance.branchId)
            def acctProduct = ProductTxn.findAllWhere(product:depositInstance.product,txnTemplate:txnTemp)
            def depLedger = TxnDepositAcctLedger.findAllWhere(acctNo:depositInstance.acctNo)
            def userBranch = UserMaster.get(session.user_id)
            
            if (depositInstance.statusId == 5){
                flash.message = 'Dormant Account.|info|alert'
                redirect(controller: "tellering" , action: "createTellerCashWithdrawalTxn")
                //render(view: '/tellering/txnCashWithdrawal/create', model: [txnCashWithdrawalInstance:tc])
                return    
            }
            
            if (depositInstance.currentRollover) {
                if (depositInstance.currentRollover.startDate != branch.runDate )
                {
                    flash.message = 'Fixed/Time Deposit not yet matured.|info|alert'
                    redirect(controller: "tellering" , action: "createTellerCashWithdrawalTxn")
                    //render(view: '/tellering/txnCashWithdrawal/create', model: [txnCashWithdrawalInstance:tc])
                    return    
                }                
                else
                {
                    if(depositInstance.currentRollover.typeId == 1  && depositInstance.currentRollover.startDate == branch.runDate){
                        flash.message = 'Transaction not allowed due to Rollover option. |info|alert'
                        redirect(controller: "tellering" , action: "createTellerCashWithdrawalTxn")
                        return                    
                    }
                }
            }
            
            // transaction not allowed for product
            if (!acctProduct) {
                flash.message = 'Transaction not allowed for product.|error|alert'
                redirect(controller: "tellering" , action: "createTellerCashWithdrawalTxn")
                //render(view: '/tellering/txnCashWithdrawal/create', model: [txnCashWithdrawalInstance:tc])
                return                
            }

            // interbranch transactions account check
            if (depositInstance.branch != userBranch.branch && txnTemp.interbranchTxn != YesNoNa.get(1)){
            //if (depositInstance.branch != userBranch.branch && tf.txnTemplateId == 9 && txnTemp.interbranchTxn != 1){
                flash.message = 'Interbranch transaction for Other branch account only.|info|alert'
                redirect(controller: "tellering" , action: "createTellerCashWithdrawalTxn")
                //render(view: '/tellering/txnCashWithdrawal/create', model: [txnCashWithdrawalInstance:tc])
                return                                                
            }
            //println "temp? "+temp
            //println "depositInstance.availableBalAmt? "+depositInstance.availableBalAmt
            
            if (temp > depositInstance.availableBalAmt){
                flash.message = 'Amount greater than available balance.|info|alert'
                redirect(controller: "tellering" , action: "createTellerCashWithdrawalTxn")
               // render(view: '/tellering/txnCashWithdrawal/create', model: [txnCashWithdrawalInstance:tc])
                return                                                                    
            }
            
            // update instances
            tf.acctNo = depositInstance.acctNo
            tf.depAcct = depositInstance
            //tf.currency = Currency.get(depositInstance.product.currencyId)
            tf.currency = Currency.get(txnTemp.currencyId)
            println "CURRENCY " + tf.currency
            tf.user = UserMaster.get(session.user_id)
            
            tf.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tf.txnAmt = temp
            tf.txnCode = txnTemp.code
            tf.txnDate = branch.runDate
            tf.txnTimestamp = new Date().toTimestamp()
            tf.txnDescription = txnTemp.codeDescription
            tf.txnType = tf.txnTemplate.txnType
            tf.status = ConfigItemStatus.get(2)
            
            def amt = (temp).longValue()
            def isTxnAllowed =  policyService.isTxnAllowed(txnTemp.code, amt)
            if(isTxnAllowed == false) {
                tf.status = ConfigItemStatus.get(1)
                policyService.createException('TLR00300', 'txnFile', tf.id, 'tellering/viewTellerTxnInquiry2/'+tf.id)
            }
            
            tf.save(flush:true,failOnError:true)
            
            
            tc.acct = depositInstance
            tc.txnType = tf.txnTemplate.txnType
            tc.acctNo = depositInstance.acctNo
            tc.bal = depositInstance.ledgerBalAmt - temp
            tc.branch = branch
            //tc.currency = Currency.get(depositInstance.product.currencyId)
            tc.currency = Currency.get(txnTemp.currencyId)
            println "CURRENCY " + tc.currency
            tc.txnDate = branch.runDate
            tc.user = UserMaster.get(session.user_id)
            tc.status = DepositStatus.get(2)
            tc.passbookBal = 0
            println "????????? "+txnTemp.requirePassbook
            
            tc.txnFile = tf
            tc.save(flush:true,failOnError:true)
            
            depositInstance.ledgerBalAmt -= temp;            
            depositInstance.availableBalAmt -= temp;
            //depositInstance.outstandingBalAmt -= temp;
            //depositInstance.save(flush:true,failOnError:true)
            if (txnTemp.requirePassbook == YesNoNa.get(1))
            {
                depositInstance.passbookBalAmt = depositInstance.ledgerBalAmt
                depositInstance.save(flush:true,failOnError:true);
                tc.passbookBal = depositInstance.ledgerBalAmt
                tc.save(flush:true)
                jrxmlTcId = tc.id.toInteger() //tc id
                if(passbookline == null){
                    //tc.passbookLine = 1;
                    println " pumasok sa null"
                }
               
                else if(passbookline >=1 && passbookline <=26 ){
                    //def val = passbookline + 1 
                    //tc.passbookLine = val
                    println " pumasok sa 1 - 26"
                }
                else{
                     //tc.passbookLine = 1;
                     println " pumasok sa else"
                }     
                   
                    tc.save(flush:true,failOnError:true)  
                
            }
//            For passbook validation
            //passbookline = tc.passbookLine 
            def sql = new Sql(dataSource) 
            def row = sql.firstRow("select min(id) from txn_deposit_acct_ledger where acct_id = "+pbvalidate)
            if(row.min != null){
                txnDepAccMinId = row.min.toInteger() //min id                  
            }
            
            def tb = new TxnCashCheckBlotter()
            tb.cashOutAmt = 0;
            tb.cashInAmt = 0;
            tb.checkInAmt = 0;
            tb.checkOutAmt = 0;
                        
            
           // tc.save(flush:true,failOnError:true)
            
            //tf.txnId = tc.id
            //tf.txnDate = new Date()
            //def description = TxnTemplate.get(tf.txnType.toInteger())
            //tf.txnDescription = description.codeDescription
            //tf.status = ConfigItemStatus.get(2)
            
            //tf.save(flush:true,failOnError:true)
            
            tb.txnFile = tf
            tb.save(flush:true,failOnError:true)
            //if(tb.id > 1){
            //    def tm = TxnCashCheckBlotter.get(tb.id - 1)
            //    tb.cashOutAmt = tm.cashOutAmt
            //    tb.cashInAmt += tm.cashInAmt
            //    tb.checkInAmt = tm.checkInAmt
            //    tb.checkOutAmt = tm.checkOutAmt
            //}
            tb.cashOutAmt += temp;
            tb.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            //tb.currency = Currency.get(depositInstance.product.currencyId)
            tb.currency = Currency.get(txnTemp.currencyId)
            println "CURRENCY " + tb.currency
            tb.user = UserMaster.get(session.user_id)
            tb.txnParticulars = tf.txnRef + ' ' + tf.acctNo
            tb.save(flush:true,failOnError:true)
            //def txnBreakdownInstance = new TxnBreakdown(creditAmt:tf.txnAmt, txnDate:tf.txnDate, txnFile:tf)
            //txnBreakdownInstance.save(flush:true)
            
            userMasterService.updateTellerBalanceStatus(false)
            glTransactionService.saveTxnBreakdown(tf.id)        
              
            flash.message = 'Transaction complete.|success|alert'
            //redirect(controller: "tellering" , action: "createTellerCashWithdrawalTxn")
            redirect(controller: "tellering", action: "txnSuccess")
            
            session["transactionFileId"] = tf.id.toInteger()
            println" Cash Withdrawal "+session["transactionFileId"]
            session["map"] = "deposit"
            println" map "+session["map"] 
////          Calling jasper file
//            def list = TxnFile.findAllById(tf.id) 
//            params._file = "validation1.jasper"
//            params._format = "PDF"
//            params._name = "Validation"
//            chain(controller:'jasper',action:'index',model:[data:list],params:params)
            
//            render(view: '/tellering/index', model: [txnCashWithdrawalInstance:new TxnDepositAcctLedger()])
        }
    }
    def createTellerCashWithdrawalTxn(){
        session["map"] = 'deposit'
        def user = UserMaster.get(session.user_id)
        if (user.cash){
            def txnFileInstance = new TxnFile()
            def txnCashWithdrawalInstance = new TxnDepositAcctLedger()
            render(view:'/tellering/txnCashWithdrawal/create', model: [txnCashWithdrawalInstance:txnCashWithdrawalInstance, id:txnDepAccMinId, jrxmlTcId:jrxmlTcId, passbookline:passbookline]) //added params for passbook validation       
        }
        else{
            flash.message = 'Error! No cash account defined.|error|alert'
            render(view: '/tellering/index')            
        }        
    }
    
/* FIXED DEPOSIT INTEREST WITHDRAWAL */
    
    def saveTellerFDInterestWithdrawalTxn(TxnDepositAcctLedger tc, TxnFile tf){
        //println "TEST PARAMS: " params //Error check
        
        if(tc.hasErrors() || tf.hasErrors()){
            flash.message = 'Failed to transfer.|error|alert'
            render(view: '/tellering/txnFDInterestWithdrawal/create', model: [txnFDInterestWithdrawalInstance:tc])
        }
        else{
            def depositInstance = Deposit.get(params.deposit.id);
            //def temp = params.debitAmt.replaceAll(",", "").toDouble();

            def txnTemp = tf.txnTemplate
            def branch = Branch.get(depositInstance.branchId)
            def acctProduct = ProductTxn.findAllWhere(product:depositInstance.product,txnTemplate:txnTemp)
            //println "TESTING " + depositInstance.product + "-" + txnTemp
            def depLedger = TxnDepositAcctLedger.findAllWhere(acctNo:depositInstance.acctNo)
            def userBranch = UserMaster.get(session.user_id)
            
            if (depositInstance.statusId == 5){
                flash.message = 'Dormant Account.|info|alert'
                render(view: '/tellering/txnFDInterestWithdrawal/create', model: [txnFDInterestWithdrawalInstance:tc])
                return    
            }
            // transaction not allowed for product
            if (!acctProduct) {
                flash.message = 'Transaction not allowed for product.|error|alert'
                render(view: '/tellering/txnFDInterestWithdrawal/create', model: [txnFDInterestWithdrawalInstance:tc])
                return                
            }
            // interbranch transactions account check
            if (depositInstance.branch != userBranch.branch && txnTemp.interbranchTxn != YesNoNa.get(1)){
                flash.message = 'Interbranch transaction for Other branch account only.|info|alert'
                render(view: '/tellering/txnFDInterestWithdrawal/create', model: [txnFDInterestWithdrawalInstance:tc])
                return                                                
            }
            // calculate the interest and taz
            Double grossInt = 0
            Double taxAmt = 0
            Double intWdlAmt = 0
            Double totWdlAmt = 0
            Double NetRollInt = 0 
            
            //grossInt = depositInstance.acrintAmt
            taxAmt = depositInstance?.currentRollover?.taxAmt1
            intWdlAmt = depositInstance?.acrintAmt
            totWdlAmt = intWdlAmt - taxAmt
            /*
            if (depositInstance?.currentRollover?.startDate < branch.runDate && depositInstance?.currentRollover?.typeId == 2 && depositInstance?.currentRollover?.interestPaymentModeId == 1)
            {
               totWdlAmt = depositInstance?.acrintAmt
            }
            else
            {
               totWdlAmt = depositInstance?.netRolloverInterestAmt
            }
            */  
            // post interest and tax transactions
            def intTxn = Institution.findByParamCode('DEP.40100').paramValue.toInteger()
            def taxTxn = Institution.findByParamCode('DEP.40110').paramValue.toInteger()
            
            def tfInt = new TxnFile(acctNo:depositInstance.acctNo, branch:depositInstance.branch, currency:depositInstance.product.currency,
                depAcct:depositInstance, status:ConfigItemStatus.read(2), txnTimestamp:new Date().toTimestamp(), txnDate:branch.runDate,
                txnAmt:intWdlAmt, txnCode:TxnTemplate.get(intTxn).code, 
                txnType:TxnTemplate.get(intTxn).txnType, txnDescription:TxnTemplate.get(intTxn).description, 
                txnRef:branch.runDate.toString() + ' Int Posting', txnTemplate:TxnTemplate.get(intTxn), user:UserMaster.get(session.user_id))
            tfInt.save(flush:true)	
                
            def dlInt = new TxnDepositAcctLedger(acct:depositInstance, acctNo:depositInstance.acctNo, 
                bal:depositInstance.ledgerBalAmt + intWdlAmt, 
                creditAmt:intWdlAmt, currency:depositInstance.product.currency,
                status:depositInstance.status, txnDate:branch.runDate, txnFile:tfInt, txnRef:branch.runDate.toString() + ' Int Posting',
                txnType:TxnTemplate.get(intTxn).txnType, user:UserMaster.get(session.user_id), branch:depositInstance.branch)	
            dlInt.save(flush:true)
            
            // post tax txn
            def tfTax = new TxnFile(acctNo:depositInstance.acctNo, branch:depositInstance.branch, currency:depositInstance.product.currency,
                depAcct:depositInstance, status:ConfigItemStatus.read(2), txnTimestamp:new Date().toTimestamp(),
                txnDate:branch.runDate, txnAmt:taxAmt, txnCode:TxnTemplate.get(taxTxn).code, txnType:TxnTemplate.get(taxTxn).txnType,
                txnDescription:TxnTemplate.get(taxTxn).description, txnRef:branch.runDate.toString() + ' Wholding Tax',
                txnTemplate:TxnTemplate.get(taxTxn), user:UserMaster.get(session.user_id))
                //tfTax.branch = branch
            tfTax.save(flush:true)	
                
            def dlTax = new TxnDepositAcctLedger(acct:depositInstance, acctNo:depositInstance.acctNo,
                bal:depositInstance.ledgerBalAmt + intWdlAmt - taxAmt, debitAmt:taxAmt, currency:depositInstance.product.currency,
                status:depositInstance.status, txnDate:branch.runDate, txnFile:tfTax, txnRef:branch.runDate.toString() + ' Wholding Tax',
                txnType:TxnTemplate.get(taxTxn).txnType, user:UserMaster.get(session.user_id), branch:depositInstance.branch)	
            dlTax.save(flush:true)     
                
            // update GL first for accruals before updating deposit account
            glTransactionService.saveTxnBreakdown(tfInt.id)
            glTransactionService.saveTxnBreakdown(tfTax.id)        
            
            //println "Interest " + intWdlAmt
            // update instances
            tf.acctNo = depositInstance.acctNo
            tf.depAcct = depositInstance
            //tf.currency = Currency.get(depositInstance.product.currencyId)
            tf.currency = Currency.get(txnTemp.currencyId)
            println "CURRENCY " + tf.currency
            tf.user = UserMaster.get(session.user_id)
            tf.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tf.txnAmt = totWdlAmt
            tf.txnCode = txnTemp.code
            tf.txnDate = branch.runDate
            tf.txnTimestamp = new Date().toTimestamp()
            tf.txnDescription = txnTemp.codeDescription
            tf.txnRef = params.txnRef
            tf.status = ConfigItemStatus.get(2)
            tf.txnType = txnTemp.txnType
            tf.save(flush:true,failOnError:true)
            
            tc.acct = depositInstance
            tc.txnType = tf.txnTemplate.txnType
            tc.acctNo = depositInstance.acctNo
            tc.bal = depositInstance.ledgerBalAmt 
            tc.branch = branch
            tc.txnType = tf.txnTemplate.txnType
            tc.txnRef = params.txnRef
            tc.debitAmt = intWdlAmt - taxAmt
            //tc.currency = Currency.get(depositInstance.product.currencyId)
            tc.currency = Currency.get(txnTemp.currencyId)
            println "CURRENCY " + tc.currency
            tc.txnDate = branch.runDate
            tc.user = UserMaster.get(session.user_id)
            tc.status = DepositStatus.get(2)
            tc.txnFile = tf
            tc.save(flush:true,failOnError:true)
            
            /*
            def taxLedger = new TxnDepositAcctLedger()
            taxLedger.acct = depositInstance
            taxLedger.acctNo = depositInstance.acctNo
            taxLedger.bal = depositInstance.ledgerBalAmt 
            taxLedger.branch = branch
            taxLedger.txnType = tf.txnTemplate.txnType
            taxLedger.txnRef = params.txnRef //'Withholding Tax'
            taxLedger.creditAmt = taxAmt
            //taxLedger.currency = Currency.get(depositInstance.product.currencyId)
            taxLedger.currency = Currency.get(txnTemp.currencyId)
            println "CURRENCY " + taxLedger.currency
            taxLedger.txnDate = branch.runDate
            taxLedger.user = UserMaster.get(session.user_id)
            taxLedger.status = DepositStatus.get(2)
            taxLedger.txnFile = tf
            taxLedger.save(flush:true,failOnError:true)
            */
            depositInstance.acrintAmt = 0.0
            depositInstance.grossRolloverInterestAmt = 0.0
            depositInstance.acrintDate = branch.runDate
            depositInstance.save(flush:true,failOnError:true)

//            def intWdl = New TxnDepositAcctLedger()
//            intWdl.acct = depositInstance
//            intWdl.acctNo = depositInstance.acctNo
//            intWdl.bal = depositInstance.ledgerBalAmt 
//            intWdl.branch = branch
//            intWdl.txnType = TxnTemplate.get(params.txnTypeId)
//            intWdl.txnRef = 'Interest Withdrawal'
//            intWdl.creditAmt = intWdlAmt
//            intWdl.currency = Currency.get(depositInstance.product.currencyId)
//            intWdl.txnDate = branch.runDate
//            intWdl.user = UserMaster.get(session.user_id)
//            intWdl.status = ConfigItemStatus.get(2)
//            intWdl.save(flush:true,failOnError:true)
            
            def amt = (tf.txnAmt).longValue()
            def isTxnAllowed =  policyService.isTxnAllowed(txnTemp.code, amt)
            if(isTxnAllowed == false) {
                tf.status = ConfigItemStatus.get(1)
                policyService.createException('1001', 'txnFile', tf.id, 'tellering/viewTellerTxnInquiry2/'+tf.id)
            }
            tf.save(flush: true)
            def tb = new TxnCashCheckBlotter()
            tb.txnFile = tf
            tb.cashOutAmt = totWdlAmt;
            tb.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            //tb.currency = Currency.get(depositInstance.product.currencyId)
            tb.currency = Currency.get(txnTemp.currencyId)
            println "CURRENCY " + tb.currency
            tb.user = UserMaster.get(session.user_id)
            tb.txnParticulars = tf.txnRef
            tb.save(flush:true,failOnError:true)
            
            if (txnTemp.requirePassbook  == YesNoNa.get(1))
            { 
                println "PUSH"
                depositInstance.passbookBalAmt = depositInstance.ledgerBalAmt
                depositInstance.save(flush:true,failOnError:true);
                
                jrxmlTcId = tc.id.toInteger() //tc id

                if(passbookline == null){
                    //tc.passbookLine = 1;
                    println " pumasok sa null"
                }
               
                else if(passbookline >=1 && passbookline <=26 ){
                    //def val = passbookline + 1 
                    //tc.passbookLine = val
                    println " pumasok sa 1 - 26"
                }
                else{
                     //tc.passbookLine = 1;
                     println " pumasok sa else"
                }     
                   
                    tc.save(flush:true,failOnError:true)      
            }
//            For passbook validation
            //passbookline = tc.passbookLine 
            def sql = new Sql(dataSource) 
            def row = sql.firstRow("select min(id) from txn_deposit_acct_ledger where acct_id = "+pbvalidate)
            if (row.min != null) {
                txnDepAccMinId = row.min.toInteger() //min id 
            }
             
            
            userMasterService.updateTellerBalanceStatus(false)
            glTransactionService.saveTxnBreakdown(tf.id)
            
            //update for deposit and rollover if interest is withdraw
            depositInstance.acrintDate = branch.runDate
//            depositInstance.currentRollover.normalInterestAmt = 0
//            depositInstance.currentRollover.taxAmt1 = 0
            depositInstance.netRolloverInterestAmt = 0
            depositInstance.taxWithheld = 0
            depositInstance.save(flush:true,failOnError:true)
              
            flash.message = 'Transaction complete.|success|alert'
            //redirect(controller: "tellering", action: "createTellerFDInterestWithdrawalTxn")
            redirect(controller: "tellering", action: "txnSuccess")
            
            session["transactionFileId"] = tf.id.toInteger()
            println "FD Interest Withdrawal   "+session["transactionFileId"]
            session["map"] = "deposit"
            println"map "+session["map"]
////          Calling jasper file
//            def list = TxnFile.findAllById(tf.id) 
//            params._file = "validation1.jasper"
//            params._format = "PDF"
//            params._name = "Validation"
//            chain(controller:'jasper',action:'index',model:[data:list],params:params)
            
//            render(view: '/tellering/index', model: [txnFDInterestWithdrawalInstance:new TxnDepositAcctLedger()])
        }
    }
    def createTellerFDInterestWithdrawalTxn(){
        session["map"] = 'deposit'
        def user = UserMaster.get(session.user_id)
        if (user.cash){
            def txnFileInstance = new TxnFile()
            def txnFDInterestWithdrawalInstance = new TxnDepositAcctLedger()
            render(view:'/tellering/txnFDInterestWithdrawal/create', model: [txnFDInterestWithdrawalInstance:txnFDInterestWithdrawalInstance, id:txnDepAccMinId, jrxmlTcId:jrxmlTcId, passbookline:passbookline]) //added params for passbook validation         
        }
        else{
            flash.message = 'Error! No cash account defined.|error|alert'
            render(view: '/tellering/index')            
        }        
        
    }
    
/* FIXED DEPOSIT PRETERMINATION */
    
    def saveTellerFDPreTerminationTxn(TxnDepositAcctLedger tc, TxnFile tf){
        //println params //Error check
        
        if(tc.hasErrors() || tf.hasErrors()){
            flash.message = 'Failed to transfer.|error|alert'
            render(view: '/tellering/txnFDPreTermination/create', model: [txnFDPreTerminationInstance:tc])
        }
        else{
            //println "TEST HERE :"
            def tb = new TxnCashCheckBlotter()
            def depositInstance = Deposit.get(params.deposit.id);
//            def temp = params.debitAmt.toDouble();
            def txnTemp = tf.txnTemplate
            def branch = Branch.get(depositInstance.branchId)
            def acctProduct = ProductTxn.findAllWhere(product:depositInstance.product,txnTemplate:txnTemp)
            def depLedger = TxnDepositAcctLedger.findAllWhere(acctNo:depositInstance.acctNo)
            def userBranch = UserMaster.get(session.user_id)
            
            //println "TESTING " + depositInstance.product + "-" + txnTemp
            if (depositInstance.statusId == 5){
                //println "TEST HERE : 5"
                flash.message = 'Dormant Account.|info|alert'
                //render(view: '/tellering/txnCashWithdrawal/create', model: [txnCashWithdrawalInstance:tc])
                render(view: '/tellering/txnFDPreTermination/create', model: [txnFDPreTerminationInstance:tc])
                return    
            }
            
            if (txnTemp.requirePassbook  == YesNoNa.get(1))
            { 
                  //tc id
                if(passbookline == null){
                    //tc.passbookLine = 1;
                    println " pumasok sa null"
                }
               
                else if(passbookline >=1 && passbookline <=26 ){
                    //def val = passbookline + 1 
                    //tc.passbookLine = val
                    println " pumasok sa 1 - 26"
                }
                else{
                     //tc.passbookLine = 1;
                     println " pumasok sa else"
                }     
                   
                    tc.save(flush:true,failOnError:true)      
                    jrxmlTcId = tc.id.toInteger()
            }
//            For passbook validation
            //passbookline = tc.passbookLine 
            def sql = new Sql(dataSource) 
            def row = sql.firstRow("select min(id) from txn_deposit_acct_ledger where acct_id = "+pbvalidate)
            if (row.min != null) {
                txnDepAccMinId = row.min.toInteger() //min id
            }
             
            
            // transaction not allowed for product
            if (!acctProduct) {
                //println "TEST HERE : 6"
                flash.message = 'Transaction not allowed for product.|error|alert'
                render(view: '/tellering/txnFDPreTermination/create', model: [txnFDPreTerminationInstance:tc])
                return                
            }

            // interbranch transactions account check
            if (depositInstance.branch != userBranch.branch && txnTemp.interbranchTxn != YesNoNa.get(1)){
                //println "TEST HERE :B"
                flash.message = 'Interbranch transaction for Other branch account only.|info|alert'
                render(view: '/tellering/txnFDPreTermination/create', model: [txnFDPreTerminationInstance:tc])
                return                                                
            }
            // calculate the interest and taz
            Double grossInt = 0
            Double taxAmt = 0
            Double intWdlAmt = 0
            Double totWdlAmt = 0
            def fdPreTermAmt = depositInstance?.ledgerBalAmt
            //grossInt = deposintInstance.acrintAmt
            taxAmt = depositInstance?.currentRollover?.taxAmt2
            intWdlAmt = depositInstance?.currentRollover?.preTermInterestAmt
            totWdlAmt = intWdlAmt - taxAmt
            
            

            // update instances
            tf.acctNo = depositInstance.acctNo
            tf.depAcct = depositInstance
            //tf.currency = Currency.get(depositInstance.product.currencyId)
            tf.currency = Currency.get(txnTemp.currencyId)
            println "CURRENCY " + tf.currency
            tf.user = UserMaster.get(session.user_id)
            tf.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tf.txnAmt = fdPreTermAmt
            tf.txnCode = txnTemp.code
            tf.txnDate = branch.runDate
            tf.txnParticulars = 'FD Principal Payout'
            tf.txnTimestamp = new Date().toTimestamp()
            tf.txnDescription = txnTemp.codeDescription
            tf.txnRef = params.txnRef
            tf.status = ConfigItemStatus.get(2)
            tf.txnType = txnTemp.txnType
            tf.save(flush:true,failOnError:true)
            
            tc.acct = depositInstance
            tc.txnType = tf.txnTemplate.txnType
            tc.acctNo = depositInstance.acctNo
            tc.bal = depositInstance.ledgerBalAmt - fdPreTermAmt
            tc.branch = branch
            tc.txnType = tf.txnTemplate.txnType
            tc.txnRef = params.txnRef
            //tc.bal = depositInstance.ledgerBalAmt + grossInt
            tc.debitAmt = fdPreTermAmt
            //tc.currency = Currency.get(depositInstance.product.currencyId)
            tc.currency = Currency.get(txnTemp.currencyId)
            println "CURRENCY " + tc.currency
            tc.txnDate = branch.runDate
            tc.user = UserMaster.get(session.user_id)
            tc.status = DepositStatus.get(2)
            tc.txnFile = tf
            tc.save(flush:true,failOnError:true)
            /*
            def taxLedger = new TxnDepositAcctLedger()
            taxLedger.acct = depositInstance
            taxLedger.acctNo = depositInstance.acctNo
            taxLedger.bal = (depositInstance.ledgerBalAmt + totWdlAmt)
            taxLedger.branch = branch
            taxLedger.txnType = tf.txnTemplate.txnType
            taxLedger.txnRef = params.txnRef //'Withholding Tax'
            taxLedger.creditAmt = taxAmt
            //taxLedger.bal = depositInstance.ledgerBalAmt + grossInt - taxAmt
            //taxLedger.currency = Currency.get(depositInstance.product.currencyId)
            taxLedger.currency = Currency.get(txnTemp.currencyId)
            println "CURRENCY " + taxLedger.currency
            taxLedger.txnDate = branch.runDate
            taxLedger.user = UserMaster.get(session.user_id)
            taxLedger.status = DepositStatus.get(2)
            taxLedger.txnFile = tf
            taxLedger.save(flush:true,failOnError:true)
            */

            depositInstance.ledgerBalAmt = 0.0
            depositInstance.availableBalAmt = 0.0
            depositInstance.passbookBalAmt = 0.0
            depositInstance.acrintAmt = 0.0
            depositInstance.save(flush:true,failOnError:true)
            
//            def intWdl = New TxnDepositAcctLedger()
//            intWdl.acct = depositInstance
//            intWdl.acctNo = depositInstance.acctNo
//            intWdl.bal = depositInstance.ledgerBalAmt 
//            intWdl.branch = branch
//            intWdl.txnType = TxnTemplate.get(params.txnTypeId)
//            intWdl.txnRef = 'FD Pre-termination'
//            intWdl.bal = 0.0
//            intWdl.creditAmt = intWdlAmt
//            intWdl.currency = Currency.get(depositInstance.product.currencyId)
//            intWdl.txnDate = branch.runDate
//            intWdl.user = UserMaster.get(session.user_id)
//            intWdl.status = ConfigItemStatus.get(2)
//            intWdl.save(flush:true,failOnError:true)
            
            
            def amt = (tf.txnAmt).longValue()
            def isTxnAllowed =  policyService.isTxnAllowed(txnTemp.code, amt)
            if(isTxnAllowed == false) {
                tf.status = ConfigItemStatus.get(1)
                policyService.createException('1001', 'txnFile', tf.id, 'tellering/viewTellerTxnInquiry2/'+tf.id)
            }
            tf.save(flush: true)
            tb.txnFile = tf
//            tb.save(flush:true)
//            if(tb.id > 1){
//                def tm = TxnCashCheckBlotter.get(tb.id - 1)
//                tb.cashOutAmt += tm.cashOutAmt
//                tb.cashInAmt = tm.cashInAmt
//                tb.checkInAmt = tm.checkInAmt
//                tb.checkOutAmt = tm.checkOutAmt
//            }
            tb.cashOutAmt = fdPreTermAmt
            tb.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tb.currency = depositInstance.product.currency
            //tb.currency = Currency.get(txnTemp.currencyId)
            println "CURRENCY " + tb.currency
            tb.user = UserMaster.get(session.user_id)
            tb.txnParticulars = tf.txnRef
            tb.save(flush:true)
            
//            def txnBreakdownInstance = new TxnBreakdown(debitAmt:tf.txnAmt, txnDate:tf.txnDate, txnFile:tf)
//            txnBreakdownInstance.save(flush:true)
            
            userMasterService.updateTellerBalanceStatus(false)
            glTransactionService.saveTxnBreakdown(tf.id)
            
            //update for deposit and rollover if interest is withdraw
            depositInstance.acrintDate = branch.runDate
            depositInstance.currentRollover.preTermInterestAmt = 0
            depositInstance.currentRollover.taxAmt2 = 0
            depositInstance.currentRollover.status = RolloverStatus.get(3)
            depositInstance.save(flush:true,failOnError:true)
            
            flash.message = 'Transaction complete.|success|alert'
            //redirect(controller: "tellering", action: "createTellerFDPreTerminationTxn")
            redirect(controller: "tellering", action: "txnSuccess")
            
            session["transactionFileId"] = tf.id.toInteger()
            println "FD Pre Termination   "+session["transactionFileId"]   
            session["map"] = "deposit"
            println"map "+session["map"]
////          Calling jasper file
//            def list = TxnFile.findAllById(tf.id) 
//            params._file = "validation1.jasper"
//            params._format = "PDF"
//            params._name = "Validation"
//            chain(controller:'jasper',action:'index',model:[data:list],params:params)
            
//            render(view: '/tellering/index', model: [txnFDPreTerminationInstance:new TxnDepositAcctLedger()])
        }
    }
    def createTellerFDPreTerminationTxn(){
        session["map"] = 'deposit'
        def user = UserMaster.get(session.user_id)
        if (user.cash){
            def txnFileInstance = new TxnFile()
            def txnFDPreTerminationInstance = new TxnDepositAcctLedger()
            render(view:'/tellering/txnFDPreTermination/create', model: [txnFDPreTerminationInstance:txnFDPreTerminationInstance, id:txnDepAccMinId, jrxmlTcId:jrxmlTcId, passbookline:passbookline]) //added params for passbook validation       
        }
        else{
            flash.message = 'Error! No cash account defined.|error|alert'
            render(view: '/tellering/index')            
        }        
    }
    
    
/* LOAN CASH REPAYMENT */
    
    def saveTellerLoanCashRepaymentTxn(TxnLoanPaymentDetails tc, TxnFile tf){
        println "TEST PARAMS : " + params //Error check
        
        if(tc.hasErrors() || tf.hasErrors()){
            flash.message = 'Failed to transfer.|error|alert'
            render(view: '/tellering/txnLoanCashRepayment/create', model: [txnLoanCashRepaymentInstance:tc])
        }
        else{
            def loanInstance = Loan.get(params?.loanId)
            def tb = new TxnCashCheckBlotter()
            def txnTemp = tf.txnTemplate
            def branch = Branch.get(loanInstance.branchId)
            def userBranch = UserMaster.get(session.user_id)
            def acctProduct = ProductTxn.findAllWhere(product:loanInstance.product,txnTemplate:txnTemp)
            //println "TESTING LOAN " + loanInstance.product + "-" + txnTemp
            //println "Deposit B: " + depositInstance.branchId
            //println "Loan B: " + loanInstance.branchId
            
            // transaction not allowed for product
            if (!acctProduct) {
                flash.message = 'Transaction not allowed for product.|error|alert'
                render(view: '/tellering/txnLoanCashRepayment/create', model: [txnLoanCashRepaymentInstance:tc])
                return                
            }
            // interbranch transactions account check
            if (loanInstance.branch != userBranch.branch && txnTemp.interbranchTxn != YesNoNa.get(1)){
                flash.message = 'Interbranch transaction for Other branch account only.|info|alert'
                render(view: '/tellering/txnLoanCashRepayment/create', model: [txnLoanCashRepaymentInstance:tc])
                return                                                
            }
            
            tb.cashOutAmt = 0;
            tb.cashInAmt = 0;
            tb.checkInAmt = 0;
            tb.checkOutAmt = 0;
            
            Double paymentAmt = (params?.paymentAmt.replaceAll(",","")).toDouble()
            Double tempPaymentAmt = paymentAmt            

            // pay service charge
            Double totalServiceChargePaid = 0
            totalServiceChargePaid = Double.parseDouble(params.serviceCharge.replaceAll(",",""))
            // pay penalty
            Double totalPenaltyPaid = 0
            totalPenaltyPaid = Double.parseDouble(params.penalty.replaceAll(",",""))
            // pay interest
            Double totalInterestPaid = 0
            totalInterestPaid = Double.parseDouble(params.interest.replaceAll(",",""))
            // pay principal
            Double totalPrincipalPaid = 0
            totalPrincipalPaid = Double.parseDouble(params.principal.replaceAll(",",""))
            
            Double totalAmountDue = loanInstance.balanceAmount + loanInstance.interestBalanceAmount + loanInstance.penaltyBalanceAmount + loanInstance.serviceChargeBalanceAmount
            totalAmountDue = totalAmountDue.round(2)
            if (paymentAmt > totalAmountDue) {
                flash.message = 'Loan Overpayment.|info|alert'
                render(view: '/tellering/txnLoanCashRepayment/create', model: [txnLoanCashRepaymentInstance:tc])
                return  
            }
            
            tf.acctNo = loanInstance.accountNo
            tf.loanAcct = loanInstance
            tf.currency = Currency.get(loanInstance.product.currencyId)
            tf.user = UserMaster.get(session.user_id)
            tf.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tf.txnAmt = (params?.paymentAmt.replaceAll(",","")).toDouble()
            tf.txnCode = txnTemp.code
            tf.txnDate = branch.runDate
            tf.txnTimestamp = new Date().toTimestamp()
            tf.txnDescription = txnTemp.codeDescription
            tf.status = ConfigItemStatus.get(2)
            tf.txnType = txnTemp.txnType
            tf.save(flush:true,failOnError:true)
                        
            def amt = (tf.txnAmt).longValue()
            def isTxnAllowed =  policyService.isTxnAllowed(txnTemp.code, amt)
            if(isTxnAllowed == false) {
                tf.status = ConfigItemStatus.get(1)
                policyService.createException('1001', 'txnFile', tf.id, 'tellering/viewTellerTxnInquiry2/'+tf.id)
            }
            tf.save(flush: true)
//            if(tb.id > 1){
//                def tm = TxnCashCheckBlotter.get(tb.id - 1)
//                tb.cashOutAmt = tm.cashOutAmt
//                tb.cashInAmt += tm.cashInAmt
//                tb.checkInAmt = tm.checkInAmt
//                tb.checkOutAmt = tm.checkOutAmt
//            }
            

//            // pay service charge
//            Double totalServiceChargePaid = 0
//            for(installment in loanInstance?.loanInstallments.findAll{it.status.id == 3L || it.status.id == 4L}.sort{it.sequenceNo}) {
//                if (tempPaymentAmt > 0) {
//                    Double dueServiceCharge = (installment?.serviceChargeInstallmentAmount - installment?.serviceChargeInstallmentPaid)
//
//                    if (tempPaymentAmt > dueServiceCharge) {                    
//                        installment.serviceChargeInstallmentPaid += dueServiceCharge
//                        totalServiceChargePaid += dueServiceCharge
//                        tempPaymentAmt -= dueServiceCharge                        
//                        dueServiceCharge = 0
//                    } else {
//                        installment.serviceChargeInstallmentPaid += tempPaymentAmt
//                        totalServiceChargePaid += tempPaymentAmt
//                        dueServiceCharge = dueServiceCharge - tempPaymentAmt                        
//                        tempPaymentAmt = 0                        
//                    }
//                }
//            }
//
////            // pay penalty
////            Double totalPenaltyPaid = 0
//            for(installment in loanInstance?.loanInstallments.findAll{it.status.id == 3L || it.status.id == 4L}.sort{it.sequenceNo}) {
//                if (tempPaymentAmt > 0) {
//                    Double duePenalty = (installment?.penaltyInstallmentAmount - installment?.penaltyInstallmentPaid)
//
//                    if (tempPaymentAmt > duePenalty) {
//                        installment.penaltyInstallmentPaid += duePenalty
//                        totalPenaltyPaid += duePenalty
//                        tempPaymentAmt -= duePenalty                        
//                        duePenalty = 0
//                    } else {
//                        installment.penaltyInstallmentPaid += tempPaymentAmt
//                        totalPenaltyPaid += tempPaymentAmt
//                        duePenalty = duePenalty - tempPaymentAmt
//                        tempPaymentAmt = 0                        
//                    }
//                }
//            }
//
////            // pay interest
////            Double totalInterestPaid = 0
//            for(installment in loanInstance?.loanInstallments.findAll{it.status.id == 3L || it.status.id == 4L}.sort{it.sequenceNo}) {
//                if (tempPaymentAmt > 0) {
//                    Double dueInterest = (installment?.interestInstallmentAmount - installment?.interestInstallmentPaid)
//
//                    if (tempPaymentAmt > dueInterest) {
//                        installment.interestInstallmentPaid += dueInterest
//                        totalInterestPaid += dueInterest
//                        tempPaymentAmt -= dueInterest
//                        dueInterest = 0
//                    } else {
//                        installment.interestInstallmentPaid += tempPaymentAmt
//                        totalInterestPaid += tempPaymentAmt
//                        dueInterest = dueInterest - tempPaymentAmt
//                        tempPaymentAmt = 0                        
//                    }
//                }
//            }
//
////            // pay principal
////            Double totalPrincipalPaid = 0
//            for(installment in loanInstance?.loanInstallments.findAll{it.status.id == 3L || it.status.id == 4L}.sort{it.sequenceNo}) {
//                if (tempPaymentAmt > 0) {
//                    Double duePrincipal = (installment?.principalInstallmentAmount - installment?.principalInstallmentPaid)
//
//                    if (tempPaymentAmt > duePrincipal) {
//                        installment.principalInstallmentPaid += duePrincipal
//                        totalPrincipalPaid += duePrincipal
//                        tempPaymentAmt -= duePrincipal
//                        duePrincipal = 0
//                    } else {
//                        installment.principalInstallmentPaid += tempPaymentAmt
//                        totalPrincipalPaid += tempPaymentAmt
//                        duePrincipal = duePrincipal - tempPaymentAmt
//                        tempPaymentAmt = 0                        
//                    }
//                }
//            }

            // upate loan
//            println "principal " + totalPrincipalPaid
//            println "interest " + totalInterestPaid
//            println "penalty " + totalPenaltyPaid
//            println "service " + totalServiceChargePaid
            def totalLoan = (loanInstance.balanceAmount + loanInstance.interestBalanceAmount 
                             + loanInstance.penaltyBalanceAmount + loanInstance.serviceChargeBalanceAmount)
            def totalLoanPayment = (totalPrincipalPaid + totalInterestPaid + totalPenaltyPaid + totalServiceChargePaid)
            
            loanInstance.balanceAmount -= totalPrincipalPaid
            loanInstance.interestBalanceAmount -= totalInterestPaid
            loanInstance.penaltyBalanceAmount -= totalPenaltyPaid
            loanInstance.serviceChargeBalanceAmount -= totalServiceChargePaid
            loanInstance.lastTransactionNo = tf.id
            def txnSeqNo
            if(loanInstance.transactionSequenceNo == null)
            {
                txnSeqNo = 0
//                println "TEST SEQ.1 " + txnSeqNo
            }
            else
            {
                txnSeqNo = loanInstance.transactionSequenceNo
//                println "TEST SEQ.2 " + txnSeqNo
            }
            loanInstance.transactionSequenceNo = txnSeqNo + 1    
            loanInstance.lastTransactionDate = branch.runDate
            loanInstance.lastCustormerTransactionDate = branch.runDate            
            //loanInstance.save(flush:true)
            loanInstance.save(flush:true,failOnError:true)
            tc.acct = loanInstance
            tc.acctNo = loanInstance.accountNo
            //tc.balForwarded = (totalLoan - totalLoanPayment)
            tc.balForwarded = loanInstance.balanceAmount + totalPrincipalPaid
            tc.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tc.currency = Currency.get(loanInstance.product.currencyId)
            //tc.grtAmt = loanInstance.accountNo
            tc.interestAmt = totalInterestPaid
            tc.interestBalAfterPayment = loanInstance.interestBalanceAmount
            tc.otherAmt = 0
            //tc.pastDueInterestAmt = loanInstance.accountNo
            tc.paymentAmt = (params?.paymentAmt.replaceAll(",","")).toDouble()
            tc.penaltyAmt = totalPenaltyPaid
            tc.penaltyBalAfterPayment = loanInstance.penaltyBalanceAmount
            tc.principalAmt = totalPrincipalPaid
            tc.principalBalAfterPayment = loanInstance.balanceAmount
            tc.serviceChargeAmt = totalServiceChargePaid
            tc.totalNetProceeds = loanInstance.totalNetProceeds
            tc.txnDate = branch.runDate
            tc.txnFile = tf
            tc.txnRef = tf.txnRef
            tc.user = UserMaster.get(session.user_id)
            tc.save(flush:true,failOnError:true)

            // create loan ledger entry
            def loanLedgerEntry = new LoanLedger(loan: loanInstance, txnFile: tf, txnDate: branch.runDate, txnTemplate: tf.txnTemplate, txnRef: tf.txnRef, //txnType: MemoTxnType.get(4),
                principalCredit: totalPrincipalPaid, principalBalance: loanInstance.balanceAmount, 
                interestCredit: totalInterestPaid, interestBalance: loanInstance.interestBalanceAmount, 
                penaltyCredit: totalPenaltyPaid, penaltyBalance: loanInstance.penaltyBalanceAmount,
                chargesCredit: totalServiceChargePaid, chargesBalance: loanInstance.serviceChargeBalanceAmount)
            //loanLedgerEntry.save(flush:true)
            loanLedgerEntry.save(flush:true,failOnError:true)
            
//            tb.cashInAmt += loanInstance.balanceAmount
//            tb.cashInAmt += loanInstance.interestBalanceAmount
//            tb.cashInAmt += loanInstance.penaltyBalanceAmount
//            tb.cashInAmt += loanInstance.serviceChargeBalanceAmount
            tb.cashInAmt = tf.txnAmt
            tb.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tb.currency = Currency.get(loanInstance.product.currencyId)
            tb.user = UserMaster.get(session.user_id)
            tb.txnParticulars = tf.txnRef
            tb.txnFile = tf
            //tb.save(flush:true)
            tb.save(flush:true,failOnError:true)
            
            //def txnBreakdownInstance = new TxnBreakdown(creditAmt:tb.cashInAmt, txnDate:tf.txnDate, txnFile:tf)
            //txnBreakdownInstance.save(flush:true)
            
            userMasterService.updateTellerBalanceStatus(false)
            glTransactionService.saveTxnBreakdown(tf.id)
             
            flash.message = 'Transaction complete.|success|alert'
            //redirect(controller: "tellering", action: "createTellerLoanCashRepaymentTxn")
            redirect(controller: "tellering", action: "txnSuccess")
            
            session["transactionFileId"] = tf.id.toInteger()
            session["jrxmlTcId"] = params.txnTemplate.toInteger()
            println "Loan Cash Payment   "+session["transactionFileId"] 
            println " Txn Template "+session["jrxmlTcId"]
            session["map"] = "loan"
////          Calling jasper file
//            def list = TxnFile.findAllById(tf.id) 
//            params._file = "validation1.jasper"
//            params._format = "PDF"
//            params._name = "Validation"
//            chain(controller:'jasper',action:'index',model:[data:list],params:params)
            
//            render(view: '/tellering/index', model: [txnLoanCashRepaymentInstance:new TxnLoanPaymentDetails()])
        }
    }
    def createTellerLoanCashRepaymentTxn(){
        
        def user = UserMaster.get(session.user_id)
        if (user.cash){
            def txnFileInstance = new TxnFile()        
            def txnLoanCashRepaymentInstance = new TxnLoanPaymentDetails()                
            render(view:'/tellering/txnLoanCashRepayment/create', model: [txnLoanCashRepaymentInstance:txnLoanCashRepaymentInstance])       
        }
        else{
            flash.message = 'Error! No cash account defined.|error|alert'
            render(view: '/tellering/index')            
        }        
    }
    
    
/* CHECK ENCASHMENT */

    def saveTellerCheckEncashmentTxn(TxnCOCI tc, TxnFile tf){
       println "params??? "+params //Error check
        
       if(tc.hasErrors() || tf.hasErrors()){
            flash.message = 'Failed to transfer|error|alert'
            render(view: '/tellering/txnCheckEncashment/create', model: [txnCheckEncashmentInstance:tc])
            //redirect(controller: "tellering", action: "createTellerCheckEncashmentTxn")
        }

        else{
            def depositInstance = Deposit.get(params.deposit.id);
            def temp = params.checkAmt.replace(',','').toDouble();

            def txnTemp = tf.txnTemplate
            def branch = Branch.get(depositInstance.branchId)
            def acctProduct = ProductTxn.findAllWhere(product:depositInstance.product,txnTemplate:txnTemp)
            def depLedger = TxnDepositAcctLedger.findAllWhere(acctNo:depositInstance.acctNo)
            def userBranch = UserMaster.get(session.user_id)
            def txnCheque = Cheque.findByChequeNo(tc.checkNo)
            def spo = StopPaymentOrder.findByChequeAndStatus(txnCheque, ConfigItemStatus.read(2))
            def issueChequeList = Chequebook.findAllWhere(deposit:depositInstance)
            
            if (depositInstance.statusId == 5){
                flash.message = 'Dormant Account|info|alert'
                redirect(controller: "tellering", action: "createTellerCheckEncashmentTxn")
               // render(view: '/tellering/txnCheckEncashment/create', model: [txnCheckEncashmentInstance:tc])
                return    
            }
            
            // transaction not allowed for product
            if (!acctProduct) {
                flash.message = 'Transaction not allowed for product|info|alert'
                redirect(controller: "tellering", action: "createTellerCheckEncashmentTxn")
                //render(view: '/tellering/txnCheckEncashment/create', model: [txnCheckEncashmentInstance:tc])
                return                
            }

            // interbranch transactions account check
            if (depositInstance.branch != userBranch.branch && txnTemp.interbranchTxn != YesNoNa.get(1)){
                flash.message = 'Interbranch transaction for Other branch account only|info|alert'
                redirect(controller: "tellering", action: "createTellerCheckEncashmentTxn")
                //render(view: '/tellering/txnCheckEncashment/create', model: [txnCheckEncashmentInstance:tc])
                return                                                
            }
            
            if (temp > depositInstance.availableBalAmt){
                flash.message = 'Amount greater than available balance|error|alert'
                redirect(controller: "tellering", action: "createTellerCheckEncashmentTxn")
                //render(view: '/tellering/txnCheckEncashment/create', model: [txnCheckEncashmentInstance:tc])
                return                                                                    
            }
            
            if (!txnCheque){
                flash.message = 'Invalid Check Number|error|alert'
                redirect(controller: "tellering", action: "createTellerCheckEncashmentTxn")
                //render(view: '/tellering/txnCheckEncashment/create', model: [txnCheckEncashmentInstance:tc])
                return                                                                                    
            }
            
            if (txnCheque.status == CheckStatus.get(3) || txnCheque.status == CheckStatus.get(4)){
                flash.message = 'Check already used/Cancelled|error|alert'
                redirect(controller: "tellering", action: "createTellerCheckEncashmentTxn")
                //render(view: '/tellering/txnCheckEncashment/create', model: [txnCheckEncashmentInstance:tc])
                return                                                                                                                    
            }
            if (tc.checkDate > branch.runDate){
                flash.message = 'Post Dated Check|error|alert'
               // render(view: '/tellering/txnCheckEncashment/create', model: [txnCheckEncashmentInstance:tc])
                redirect(controller: "tellering", action: "createTellerCheckEncashmentTxn")
                return                                                                                                    
            }
            if (spo){
                flash.message = 'Check Stopped|error|alert'
               // render(view: '/tellering/txnCheckEncashment/create', model: [txnCheckEncashmentInstance:tc])
                redirect(controller: "tellering", action: "createTellerCheckEncashmentTxn")
                return                                                                                                    
            }
            // verify account and check relationship
            Boolean goodCheck = false
            //each (checkbook in issueChequeList){
            issueChequeList.each {checkbook ->
                if (params.checkNo.toLong() >= checkbook.seriesStart && params.checkNo.toLong() <= checkbook.seriesEnd ){
                    goodCheck = true
                }
            }
            if (!goodCheck){
                flash.message = 'Check Not issued for this account|error|alert'
                redirect(controller: "tellering", action: "createTellerCheckEncashmentTxn")
                //render(view: '/tellering/txnCheckEncashment/create', model: [txnCheckEncashmentInstance:tc])
                return                                                                                                                    
            }
             // update instances
            tf.acctNo = depositInstance.acctNo
            tf.depAcct = depositInstance
            tf.currency = Currency.get(depositInstance.product.currencyId)
            tf.user = UserMaster.get(session.user_id)
            tf.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tf.txnAmt = temp
            tf.txnCode = txnTemp.code
            tf.txnDate = branch.runDate
            tf.txnTimestamp = new Date().toTimestamp()
            tf.txnDescription = txnTemp.codeDescription
            tf.txnRef = txnCheque.chequeNo
            tf.status = ConfigItemStatus.get(2)
            tf.txnType = txnTemp.txnType
            tf.save(flush: true)
            
            tc.depAcct = depositInstance
            tc.txnFile = tf
            tc.acctNo = depositInstance.acctNo
            //tc.bal = depositInstance.ledgerBalAmt - temp
            tc.branch = branch
            tc.currency = Currency.get(depositInstance.product.currencyId)
            //tc.txnDate = branch.runDate
            tc.user = UserMaster.get(session.user_id)
            tc.status = ConfigItemStatus.get(2)
            tc.save(flush: true)
            
            depositInstance.ledgerBalAmt -= temp;
            depositInstance.availableBalAmt -= temp;
            //depositInstance.outstandingBalAmt -= temp;
            
            if (depositInstance.outstandingBalAmt == null)
            {
                depositInstance.outstandingBalAmt = temp;
            }
            else
            {depositInstance.outstandingBalAmt -= temp;}
        
            depositInstance.save(flush:true)
            if (txnTemp.requirePassbook == 1)
            {
                depositInstance.passbookBalAmt = depositInstance.ledgerBalAmt
                depositInstance.save(flush:true);
            }
            
            //txnCheque.chequeDate = params.checkDate
            txnCheque.chequeDate = new Date(params.checkDate).toTimestamp()
            txnCheque.isChequeClrOnUs = false
            txnCheque.chequeAmt = temp
            txnCheque.status = CheckStatus.get(3)
            txnCheque.payeeName = params.payee
            txnCheque.save(flush:true,failOnError:true)
            
            def chequebookInstance = txnCheque.chequebook
            chequebookInstance.chequesUsed += 1
            chequebookInstance.save(flush:true,failOnError:true)
            
            def tb = new TxnCashCheckBlotter()
            tb.cashOutAmt = 0;
            tb.cashInAmt = 0;
            tb.checkInAmt = 0;
            tb.checkOutAmt = 0;
                        
            tc.txnFile = tf
            tc.save(flush: true)
          //  tf.txnType = tf.txnTemplate.txnType
            //tf.txnId = tc.id
            //tf.txnDate = new Date()
            //def description = TxnTemplate.get(tf.txnType.toInteger())
            //tf.txnDescription = description.codeDescription
            //tf.status = ConfigItemStatus.get(2)
            def amt = (temp).longValue()
          //  def isTxnAllowed =  policyService.isTxnAllowed(txnTemp.code, amt)
          //  if(isTxnAllowed == false) {
          //      tf.status = ConfigItemStatus.get(1)
          //      policyService.createException('TLR00600', 'txnFile', tf.id, 'tellering/viewTellerTxnInquiry2/'+tf.id)
          //  }
           // tf.save(flush: true)
            tb.txnFile = tf
          //  tb.save(flush:true)
            //if(tb.id > 1){
            //    def tm = TxnCashCheckBlotter.get(tb.id - 1)
            //    tb.cashOutAmt = tm.cashOutAmt
            //    tb.cashInAmt += tm.cashInAmt
            //    tb.checkInAmt = tm.checkInAmt
            //    tb.checkOutAmt = tm.checkOutAmt
            //}
            tb.cashOutAmt += temp;
            tb.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tb.currency = Currency.get(depositInstance.product.currencyId)
            tb.user = UserMaster.get(session.user_id)
            tb.txnParticulars = tf.txnRef
            tb.save(flush:true)            
            //def txnBreakdownInstance = new TxnBreakdown(creditAmt:tf.txnAmt, txnDate:tf.txnDate, txnFile:tf)
            //txnBreakdownInstance.save(flush:true)
           
            
            def tdaL = new TxnDepositAcctLedger()
            tdaL.acct = depositInstance
            tdaL.acctNo = depositInstance.acctNo
            tdaL.bal = depositInstance.ledgerBalAmt
            tdaL.branch = branch
            tdaL.currency = Currency.get(depositInstance.product.currencyId)
            tdaL.debitAmt = temp
            tdaL.passbookBal = depositInstance.ledgerBalAmt
            tdaL.status = DepositStatus.get(2)
            tdaL.txnDate = branch.runDate
            tdaL.txnFile = tf
            tdaL.txnRef = txnCheque.chequeNo
            tdaL.txnType = tf.txnTemplate.txnType
            tdaL.user = UserMaster.get(session.user_id)
            tdaL.save(flush:true)
            

            userMasterService.updateTellerBalanceStatus(false)
            glTransactionService.saveTxnBreakdown(tf.id)

            flash.message = 'Transaction Success|success|alert'
            //redirect(controller: "tellering" , action: "createTellerCheckEncashmentTxn")
            redirect(controller: "tellering", action: "txnSuccess")
            
            session["transactionFileId"] = tf.id.toInteger()
            println " Check Encashment   "+session["transactionFileId"]   
            session["map"] = "deposit"
            println"map "+session["map"]
            
////          Calling jasper file
//            def list = TxnFile.findAllById(tf.id) 
//            params._file = "validation1.jasper"
//            params._format = "PDF"
//            params._name = "Validation"
//            chain(controller:'jasper',action:'index',model:[data:list],params:params)
            
//            render(view: '/tellering/index', model: [txnCheckEncashmentInstance:new TxnCOCI()])
        
    }
    }
    def createTellerCheckEncashmentTxn(){
        session["map"] = 'deposit'
        def user = UserMaster.get(session.user_id)
        if (user.cash){
            def txnFileInstance = new TxnFile()
            def txnCheckEncashmentInstance = new TxnCOCI()
            render(view:'/tellering/txnCheckEncashment/create', model: [txnCheckEncashmentInstance:txnCheckEncashmentInstance])       
        }
        else{
            flash.message = 'Error! No cash account defined'
            render(view: '/tellering/index')            
        }        
        
    }
    
    
/* LOAN CHECK REPAYMENT */
    
    def saveTellerLoanCheckRepaymentTxn(TxnLoanPaymentDetails tc, TxnFile tf){
        println params //Error check
        
        if(tc.hasErrors() || tf.hasErrors()){
            flash.message = 'Failed to transfer.|error|alert'
            render(view: '/tellering/txnLoanCheckRepayment/create', model: [txnLoanCheckRepaymentInstance:tc])
        }
        else{
            def tb = new TxnCashCheckBlotter()
            def loanInstance = Loan.get(params?.loanId)
            def txnTemp = tf.txnTemplate
            def branch = Branch.get(loanInstance.branchId)
            def userBranch = UserMaster.get(session.user_id)
            def acctProduct = ProductTxn.findAllWhere(product:loanInstance.product,txnTemplate:txnTemp)
            //println "TESTING LOAN " + loanInstance.product + "-" + txnTemp
            
            // transaction not allowed for product
            if (!acctProduct) {
                flash.message = 'Transaction not allowed for product|error|alert'
                render(view: '/tellering/txnLoanCheckRepayment/create', model: [txnLoanCheckRepaymentInstance:tc])
                return                
            }
            // interbranch transactions account check
            if (loanInstance.branch != userBranch.branch && txnTemp.interbranchTxn != YesNoNa.get(1)){
                flash.message = 'Interbranch transaction for Other branch account only|info|alert'
                render(view: '/tellering/txnLoanCheckRepayment/create', model: [txnLoanCashSpecifiedRepaymentInstance:tc])
                return                                                
            }
            Double paymentAmt = (params?.paymentAmt.replaceAll(",","")).toDouble()
            Double tempPaymentAmt = paymentAmt    
            
            // pay service charge
            Double totalServiceChargePaid = 0
            totalServiceChargePaid = Double.parseDouble(params.serviceCharge.replaceAll(",",""))
            // pay penalty
            Double totalPenaltyPaid = 0
            totalPenaltyPaid = Double.parseDouble(params.penalty.replaceAll(",",""))
            // pay interest
            Double totalInterestPaid = 0
            totalInterestPaid = Double.parseDouble(params.interest.replaceAll(",",""))
            // pay principal
            Double totalPrincipalPaid = 0
            totalPrincipalPaid = Double.parseDouble(params.principal.replaceAll(",",""))
            
            Double totalAmountDue = loanInstance.balanceAmount + loanInstance.interestBalanceAmount + loanInstance.penaltyBalanceAmount + loanInstance.serviceChargeBalanceAmount
            totalAmountDue = totalAmountDue.round(2)
            if (paymentAmt > totalAmountDue) {
                flash.message = 'Loan Overpayment.|info|alert'
                render(view: '/tellering/txnLoanCashRepayment/create', model: [txnLoanCashRepaymentInstance:tc])
                return  
            }
            tb.cashOutAmt = 0;
            tb.cashInAmt = 0;
            tb.checkInAmt = 0;
            tb.checkOutAmt = 0;
            
            tf.acctNo = loanInstance.accountNo
            tf.loanAcct = loanInstance
            tf.currency = Currency.get(loanInstance.product.currencyId)
            tf.user = UserMaster.get(session.user_id)
            tf.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tf.txnAmt = (params?.paymentAmt.replaceAll(",","")).toDouble()
            tf.txnCode = txnTemp.code
            tf.txnDate = branch.runDate
            tf.txnTimestamp = new Date().toTimestamp()
            tf.txnDescription = txnTemp.codeDescription
            tf.status = ConfigItemStatus.get(2)
            tf.txnType = txnTemp.txnType
            tf.save(flush:true,failOnError:true)
            
            def amt = (tf.txnAmt).longValue()
            def isTxnAllowed =  policyService.isTxnAllowed(txnTemp.code, amt)
            if(isTxnAllowed == false) {
                tf.status = ConfigItemStatus.get(1)
                policyService.createException('1001', 'txnFile', tf.id, 'tellering/viewTellerTxnInquiry2/'+tf.id)
            }
            tf.save(flush: true)
//            if(tb.id > 1){
//                def tm = TxnCashCheckBlotter.get(tb.id - 1)
//                tb.cashOutAmt = tm.cashOutAmt
//                tb.cashInAmt = tm.cashInAmt
//                tb.checkInAmt += tm.checkInAmt
//                tb.checkOutAmt = tm.checkOutAmt
//            }
            
            //def loanInstance = Loan.get(params?.loanId)



//            // pay service charge
//            Double totalServiceChargePaid = 0
//            for(installment in loanInstance?.loanInstallments.findAll{it.status.id == 3L || it.status.id == 4L}.sort{it.sequenceNo}) {
//                if (tempPaymentAmt > 0) {
//                    Double dueServiceCharge = (installment?.serviceChargeInstallmentAmount - installment?.serviceChargeInstallmentPaid)
//
//                    if (tempPaymentAmt > dueServiceCharge) {                    
//                        installment.serviceChargeInstallmentPaid += dueServiceCharge
//                        totalServiceChargePaid += dueServiceCharge
//                        tempPaymentAmt -= dueServiceCharge                        
//                        dueServiceCharge = 0
//                    } else {
//                        installment.serviceChargeInstallmentPaid += tempPaymentAmt
//                        totalServiceChargePaid += tempPaymentAmt
//                        dueServiceCharge = dueServiceCharge - tempPaymentAmt                        
//                        tempPaymentAmt = 0                        
//                    }
//                }
//            }
//
//            // pay penalty
//            Double totalPenaltyPaid = 0
//            for(installment in loanInstance?.loanInstallments.findAll{it.status.id == 3L || it.status.id == 4L}.sort{it.sequenceNo}) {
//                if (tempPaymentAmt > 0) {
//                    Double duePenalty = (installment?.penaltyInstallmentAmount - installment?.penaltyInstallmentPaid)
//
//                    if (tempPaymentAmt > duePenalty) {
//                        installment.penaltyInstallmentPaid += duePenalty
//                        totalPenaltyPaid += duePenalty
//                        tempPaymentAmt -= duePenalty                        
//                        duePenalty = 0
//                    } else {
//                        installment.penaltyInstallmentPaid += tempPaymentAmt
//                        totalPenaltyPaid += tempPaymentAmt
//                        duePenalty = duePenalty - tempPaymentAmt
//                        tempPaymentAmt = 0                        
//                    }
//                }
//            }
//
//            // pay interest
//            Double totalInterestPaid = 0
//            for(installment in loanInstance?.loanInstallments.findAll{it.status.id == 3L || it.status.id == 4L}.sort{it.sequenceNo}) {
//                if (tempPaymentAmt > 0) {
//                    Double dueInterest = (installment?.interestInstallmentAmount - installment?.interestInstallmentPaid)
//
//                    if (tempPaymentAmt > dueInterest) {
//                        installment.interestInstallmentPaid += dueInterest
//                        totalInterestPaid += dueInterest
//                        tempPaymentAmt -= dueInterest
//                        dueInterest = 0
//                    } else {
//                        installment.interestInstallmentPaid += tempPaymentAmt
//                        totalInterestPaid += tempPaymentAmt
//                        dueInterest = dueInterest - tempPaymentAmt
//                        tempPaymentAmt = 0                        
//                    }
//                }
//            }
//
//            // pay principal
//            Double totalPrincipalPaid = 0
//            for(installment in loanInstance?.loanInstallments.findAll{it.status.id == 3L || it.status.id == 4L}.sort{it.sequenceNo}) {
//                if (tempPaymentAmt > 0) {
//                    Double duePrincipal = (installment?.principalInstallmentAmount - installment?.principalInstallmentPaid)
//
//                    if (tempPaymentAmt > duePrincipal) {
//                        installment.principalInstallmentPaid += duePrincipal
//                        totalPrincipalPaid += duePrincipal
//                        tempPaymentAmt -= duePrincipal
//                        duePrincipal = 0
//                    } else {
//                        installment.principalInstallmentPaid += tempPaymentAmt
//                        totalPrincipalPaid += tempPaymentAmt
//                        duePrincipal = duePrincipal - tempPaymentAmt
//                        tempPaymentAmt = 0                        
//                    }
//                }
//            }
    
//            println "principal " + totalPrincipalPaid
//            println "interest " + totalInterestPaid
//            println "penalty " + totalPenaltyPaid
//            println "service " + totalServiceChargePaid
            def totalLoan = (loanInstance.balanceAmount + loanInstance.interestBalanceAmount 
                             + loanInstance.penaltyBalanceAmount + loanInstance.serviceChargeBalanceAmount)
            def totalLoanPayment = (totalPrincipalPaid + totalInterestPaid + totalPenaltyPaid + totalServiceChargePaid)
            
            // upate loan
            loanInstance.balanceAmount -= totalPrincipalPaid
            loanInstance.interestBalanceAmount -= totalInterestPaid
            loanInstance.penaltyBalanceAmount -= totalPenaltyPaid
            loanInstance.serviceChargeBalanceAmount -= totalServiceChargePaid
            loanInstance.lastTransactionNo = tf.id
            def txnSeqNo
            if(loanInstance.transactionSequenceNo == null)
            {
                txnSeqNo = 0
//                println "TEST SEQ.1 " + txnSeqNo
            }
            else
            {
                txnSeqNo = loanInstance.transactionSequenceNo
//                println "TEST SEQ.2 " + txnSeqNo
            }
            loanInstance.transactionSequenceNo = txnSeqNo + 1      
            loanInstance.lastTransactionDate = branch.runDate
            //loanInstance.lastCustomerTransactionDate = branch.runDate
            loanInstance.lastCustormerTransactionDate = branch.runDate  
            //loanInstance.save(flush:true)
            loanInstance.save(flush:true,failOnError:true)
            
            tc.acct = loanInstance
            tc.acctNo = loanInstance.accountNo
            //tc.balForwarded = (totalLoan - totalLoanPayment)
            tc.balForwarded = loanInstance.balanceAmount + totalPrincipalPaid
            tc.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tc.currency = Currency.get(loanInstance.product.currencyId)
            //tc.grtAmt = loanInstance.accountNo
            tc.interestAmt = totalInterestPaid
            tc.interestBalAfterPayment = loanInstance.interestBalanceAmount
            tc.otherAmt = 0
            //tc.pastDueInterestAmt = loanInstance.accountNo
            tc.paymentAmt = (params?.paymentAmt.replaceAll(",","")).toDouble()
            tc.penaltyAmt = totalPenaltyPaid
            tc.penaltyBalAfterPayment = loanInstance.penaltyBalanceAmount
            tc.principalAmt = totalPrincipalPaid
            tc.principalBalAfterPayment = loanInstance.balanceAmount
            tc.serviceChargeAmt = totalServiceChargePaid
            tc.totalNetProceeds = loanInstance.totalNetProceeds
            tc.txnDate = branch.runDate
            tc.txnFile = tf
            tc.txnRef = tf.txnRef
            tc.user = UserMaster.get(session.user_id)
            tc.save(flush:true,failOnError:true)
            
//            tb.checkInAmt += loanInstance.balanceAmount
//            tb.checkInAmt += loanInstance.interestBalanceAmount
//            tb.checkInAmt += loanInstance.penaltyBalanceAmount
//            tb.checkInAmt += loanInstance.serviceChargeBalanceAmount
            tb.checkInAmt = tf.txnAmt
            tb.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tb.currency = Currency.get(loanInstance.product.currencyId)
            tb.user = UserMaster.get(session.user_id)
            tb.txnParticulars = tf.txnRef
            tb.txnFile = tf
            tb.save(flush:true,failOnError:true)

            // create loan ledger entry
            def loanLedgerEntry = new LoanLedger(loan: loanInstance, txnFile: tf, txnDate: branch.runDate, txnTemplate: tf.txnTemplate, txnRef: tf.txnRef, // txnType: TxnType.get(11),
                principalCredit: totalPrincipalPaid, principalBalance: loanInstance.balanceAmount, 
                interestCredit: totalInterestPaid, interestBalance: loanInstance.interestBalanceAmount, 
                penaltyCredit: totalPenaltyPaid, penaltyBalance: loanInstance.penaltyBalanceAmount,
                chargesCredit: totalServiceChargePaid, chargesBalance: loanInstance.serviceChargeBalanceAmount)
            loanLedgerEntry.save(flush:true,failOnError:true)
            
            session["checks"].id.each {tcoci_id ->
                def tcoci = TxnCOCI.get(tcoci_id)
                tcoci.status = ConfigItemStatus.get(2)
                tcoci.txnCheckStatus = TxnCheckStatus.get(2)
                println "CHECK STATUS " + tcoci.txnCheckStatus
                tcoci.txnFile = tf
               
                def checkClearDate = tcoci.checkType.clearingDate
                tcoci.clearingDate = checkClearDate
                //tcoci.depAcct = depositInstance
                
                if(tcoci.checkType == CheckDepositClearingType.get(3)){
                    def checks = Cheque.findByChequeNo(tcoci.checkNo)
                    def chequebookInstance = checks.chequebook 
                    checks.chequeAmt = tcoci.checkAmt
                    checks.chequeDate = tcoci.checkDate
                    checks.isChequeClrOnUs = true
                    checks.status = CheckStatus.get(3)
                    checks.save(flush:true,failOnError:true)
                    
                    chequebookInstance.chequesUsed += 1
                    chequebookInstance.save(flush:true,failOnError:true)
                    
                    debitOnus(checks)
                    
                    tcoci.txnCheckStatus = TxnCheckStatus.get(3)
                    tcoci.cleared = true
                    tcoci.clearingDate = tf.txnDate
                    
                }                 
                tcoci.save(flush:true,failOnError:true)
            }
            
            //def txnBreakdownInstance = new TxnBreakdown(creditAmt:tb.checkInAmt, txnDate:tf.txnDate, txnFile:tf)
            //txnBreakdownInstance.save(flush:true)
            
            userMasterService.updateTellerBalanceStatus(false)
            glTransactionService.saveTxnBreakdown(tf.id)
           
            flash.message = 'Transaction complete.|success|alert'
            //redirect(controller: "tellering", action: "createTellerLoanCheckRepaymentTxn")
            redirect(controller: "tellering", action: "txnSuccess")
            
            session["transactionFileId"] = tf.id.toInteger()
            session["jrxmlTcId"] = params.txnTemplate.toInteger()
            println "Loan Check Payment   "+session["transactionFileId"]
            println " Txn Template "+session["jrxmlTcId"]
            session["map"] = "loan"
////          Calling jasper file
//            def list = TxnFile.findAllById(tf.id) 
//            params._file = "validation1.jasper"
//            params._format = "PDF"
//            params._name = "Validation"
//            chain(controller:'jasper',action:'index',model:[data:list],params:params)
            
//            render(view: '/tellering/index', model: [txnLoanCheckRepaymentInstance:new TxnLoanPaymentDetails()])
        }
    }
    def createTellerLoanCheckRepaymentTxn(){
        
        def user = UserMaster.get(session.user_id)
        if (user.coci){
            def txnFileInstance = new TxnFile()        
            def txnLoanCheckRepaymentInstance = new TxnLoanPaymentDetails()                
            session["checks"] = []
            render(view:'/tellering/txnLoanCheckRepayment/create', model: [txnLoanCheckRepaymentInstance:txnLoanCheckRepaymentInstance])       
        }
        else{
            flash.message = 'Error! No COCI account defined.|error|alert'
            render(view: '/tellering/index')            
        }        
    }
    
/* LOAN CASH SPECIFIED REPAYMENT */
    
    def saveTellerLoanCashSpecifiedRepaymentTxn(TxnLoanPaymentDetails tc, TxnFile tf){
        println params //Error check
        
        if(tc.hasErrors() || tf.hasErrors()){
            flash.message = 'Failed to transfer.|error|alert'
            render(view: '/tellering/txnLoanCashSpecifiedRepayment/create', model: [txnLoanCashSpecifiedRepaymentInstance:tc])
        }
        else{
            def tb = new TxnCashCheckBlotter()
            def loanInstance = Loan.get(params?.loanId)
            def txnTemp = tf.txnTemplate
            def branch = Branch.get(loanInstance.branchId)
            def userBranch = UserMaster.get(session.user_id)
            def acctProduct = ProductTxn.findAllWhere(product:loanInstance.product,txnTemplate:txnTemp)
//            println "TESTING " + loanInstance.product + "-" + txnTemp
            
            // transaction not allowed for product
            if (!acctProduct) {
                flash.message = 'Transaction not allowed for product.|error|alert'
                render(view: '/tellering/txnLoanCashSpecifiedRepayment/create', model: [txnLoanCashSpecifiedRepaymentInstance:tc])
                return                
            }
            // interbranch transactions account check
            if (loanInstance.branch != userBranch.branch && txnTemp.interbranchTxn != YesNoNa.get(1)){
                flash.message = 'Interbranch transaction for Other branch account only.|info|alert'
                render(view: '/tellering/txnLoanCashSpecifiedRepayment/create', model: [txnLoanCashSpecifiedRepaymentInstance:tc])
                return                                                
            }
            
             // pay service charge
            Double totalServiceChargePaid = 0
            if (params.serviceChargeInstallmentAmount)
            {
                totalServiceChargePaid = Double.parseDouble(params.serviceChargeInstallmentAmount.replaceAll(",",""))
            }
            else
            {
                totalServiceChargePaid = 0
            }
            
            // pay penalty
            Double totalPenaltyPaid = 0
            if (params.penaltyInstallmentAmount)
            {
                totalPenaltyPaid = Double.parseDouble(params.penaltyInstallmentAmount.replaceAll(",",""))
            }
            else
            {
                totalPenaltyPaid = 0
            }
            
            // pay interest
            Double totalInterestPaid = 0
            if (params.interestInstallmentAmount)
            {
                totalInterestPaid = Double.parseDouble(params.interestInstallmentAmount.replaceAll(",",""))
            }
            else
            {
                totalInterestPaid = 0
            }
            // pay principal
            Double totalPrincipalPaid = 0
            if (params.principalInstallmentAmount)
            {
                totalPrincipalPaid = Double.parseDouble(params.principalInstallmentAmount.replaceAll(",",""))
            }
            else
            {
                totalPrincipalPaid = 0
            }
            
            if (totalPrincipalPaid > loanInstance.balanceAmount){
                flash.message = 'ERROR: Principal Payment Greater than loan balance'
                render(view:'/tellering/txnLoanCashSpecifiedRepayment/create', model: [txnLoanCashSpecifiedRepaymentInstance:tc])       
                return
            }
//            
//            if (totalInterestPaid > loanInstance.interestBalanceAmount){
//                flash.message = 'Interest Payment Greater than interest balance'
//                render(view:'/tellering/txnLoanCashSpecifiedRepayment/create', model: [txnLoanCashSpecifiedRepaymentInstance:tc])       
//                return
//            }
//            
//            if (totalPenaltyPaid > loanInstance.penaltyBalanceAmount){
//                flash.message = 'Penalty Payment Greater than penalty balance'
//                render(view:'/tellering/txnLoanCashSpecifiedRepayment/create', model: [txnLoanCashSpecifiedRepaymentInstance:tc])       
//                return
//            }
//            
//            if (totalServiceChargePaid > loanInstance.serviceChargeBalanceAmount){
//                flash.message = 'Service Charge Payment Greater than service charge balance'
//                render(view:'/tellering/txnLoanCashSpecifiedRepayment/create', model: [txnLoanCashSpecifiedRepaymentInstance:tc])       
//                return
//            }
            
            tb.cashOutAmt = 0;
            tb.cashInAmt = 0;
            tb.checkInAmt = 0;
            tb.checkOutAmt = 0;
            
            tf.acctNo = loanInstance.accountNo
            tf.loanAcct = loanInstance
            tf.currency = Currency.get(loanInstance.product.currencyId)
            tf.user = UserMaster.get(session.user_id)
            tf.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tf.txnAmt = (params?.paymentAmt.replaceAll(",","")).toDouble()
            tf.txnCode = txnTemp.code
            tf.txnDate = branch.runDate
            tf.txnTimestamp = new Date().toTimestamp()
            tf.txnDescription = txnTemp.codeDescription
            tf.status = ConfigItemStatus.get(2)
            tf.txnType = txnTemp.txnType
            tf.save(flush:true,failOnError:true)
            
            def amt = (tf.txnAmt).longValue()
            def isTxnAllowed =  policyService.isTxnAllowed(txnTemp.code, amt)
            if(isTxnAllowed == false) {
                tf.status = ConfigItemStatus.get(1)
                policyService.createException('1001', 'txnFile', tf.id, 'tellering/viewTellerTxnInquiry2/'+tf.id)
            }
            tf.save(flush: true)
            
            def totalLoan = (loanInstance.balanceAmount + loanInstance.interestBalanceAmount 
                             + loanInstance.penaltyBalanceAmount + loanInstance.serviceChargeBalanceAmount)
            def totalLoanPayment = (totalPrincipalPaid + totalInterestPaid + totalPenaltyPaid + totalServiceChargePaid)
            
            loanInstance.balanceAmount -= totalPrincipalPaid
            loanInstance.interestBalanceAmount -= totalInterestPaid
            loanInstance.penaltyBalanceAmount -= totalPenaltyPaid
            loanInstance.serviceChargeBalanceAmount -= totalServiceChargePaid
            loanInstance.lastTransactionNo = tf.id
            def txnSeqNo
            if(loanInstance.transactionSequenceNo == null)
            {
                txnSeqNo = 0
//                println "TEST SEQ.1 " + txnSeqNo
            }
            else
            {
                txnSeqNo = loanInstance.transactionSequenceNo
//                println "TEST SEQ.2 " + txnSeqNo
            }
            loanInstance.transactionSequenceNo = txnSeqNo + 1    
            loanInstance.lastTransactionDate = branch.runDate
            loanInstance.lastCustormerTransactionDate = branch.runDate            
            //loanInstance.save(flush:true)
            loanInstance.save(flush:true,failOnError:true)
            
            tc.acct = loanInstance
            tc.acctNo = loanInstance.accountNo
            //tc.balForwarded = (totalLoan - totalLoanPayment)
            tc.balForwarded = loanInstance.balanceAmount + totalPrincipalPaid
            tc.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tc.currency = Currency.get(loanInstance.product.currencyId)
            //tc.grtAmt = loanInstance.accountNo
            tc.interestAmt = totalInterestPaid
            tc.interestBalAfterPayment = loanInstance.interestBalanceAmount
            tc.otherAmt = 0
            //tc.pastDueInterestAmt = loanInstance.accountNo
            tc.paymentAmt = (params?.paymentAmt.replaceAll(",","")).toDouble()
            tc.penaltyAmt = totalPenaltyPaid
            tc.penaltyBalAfterPayment = loanInstance.penaltyBalanceAmount
            tc.principalAmt = totalPrincipalPaid
            tc.principalBalAfterPayment = loanInstance.balanceAmount
            tc.serviceChargeAmt = totalServiceChargePaid
            tc.totalNetProceeds = loanInstance.totalNetProceeds
            tc.txnDate = branch.runDate
            tc.txnFile = tf
            tc.txnRef = tf.txnRef
            tc.user = UserMaster.get(session.user_id)
            tc.save(flush:true,failOnError:true)

            // create loan ledger entry
            def loanLedgerEntry = new LoanLedger(loan: loanInstance, txnFile: tf, txnDate: branch.runDate, txnTemplate: tf.txnTemplate, txnRef: tf.txnRef, //txnType: TxnType.get(11),
                principalCredit: totalPrincipalPaid, principalBalance: loanInstance.balanceAmount, 
                interestCredit: totalInterestPaid, interestBalance: loanInstance.interestBalanceAmount, 
                penaltyCredit: totalPenaltyPaid, penaltyBalance: loanInstance.penaltyBalanceAmount,
                chargesCredit: totalServiceChargePaid, chargesBalance: loanInstance.serviceChargeBalanceAmount)
            loanLedgerEntry.save(flush:true,failOnError:true)
            
            //if(tb.id > 1){
            //    def tm = TxnCashCheckBlotter.get(tb.id - 1)
            //    tb.cashOutAmt = tm.cashOutAmt
            //    tb.cashInAmt += tm.cashInAmt
            //    tb.checkInAmt = tm.checkInAmt
            //    tb.checkOutAmt = tm.checkOutAmt
            //}
//            tb.cashInAmt += tc.principalAmt
//            tb.cashInAmt += tc.interestAmt
//            tb.cashInAmt += tc.penaltyAmt
//            tb.cashInAmt += tc.serviceChargeAmt
//            tb.cashInAmt += tc.grtAmt
            tb.cashInAmt = tf.txnAmt
            tb.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tb.currency = Currency.get(loanInstance.product.currencyId)
            tb.user = UserMaster.get(session.user_id)
            tb.txnParticulars = tf.txnRef
            tb.txnFile = tf
            tb.save(flush:true,failOnError:true)
            
//            def txnBreakdownInstance = new TxnBreakdown(creditAmt:tb.cashInAmt, txnDate:tf.txnDate, txnFile:tf)
//            txnBreakdownInstance.save(flush:true)
            
            userMasterService.updateTellerBalanceStatus(false)
            glTransactionService.saveTxnBreakdown(tf.id)
            
            flash.message = 'Transaction complete.|success|alert'
            //redirect(controller: "tellering", action: "createTellerLoanCashSpecifiedRepaymentTxn")
            redirect(controller: "tellering", action: "txnSuccess")
            
            session["transactionFileId"] = tf.id.toInteger()
            session["jrxmlTcId"] = params.txnTemplate.toInteger()
            println "Loan Cash Specified "+session["transactionFileId"] 
            println " Txn Template "+session["jrxmlTcId"]
            session["map"] = "loan"
            println"map "+session["map"]
////          Calling jasper file
//            def list = TxnFile.findAllById(tf.id) 
//            params._file = "validation1.jasper"
//            params._format = "PDF"
//            params._name = "Validation"
//            chain(controller:'jasper',action:'index',model:[data:list],params:params)
            
//            render(view: '/tellering/index', model: [txnLoanCashSpecifiedRepaymentInstance:new TxnLoanPaymentDetails()])
        }
    }
    def createTellerLoanCashSpecifiedRepaymentTxn(){

        def user = UserMaster.get(session.user_id)
        if (user.cash){
            def loanInstallmentInstance = new LoanInstallment()
            def txnFileInstance = new TxnFile()
            def txnLoanCashSpecifiedRepaymentInstance = new TxnLoanPaymentDetails()
            render(view:'/tellering/txnLoanCashSpecifiedRepayment/create', model: [txnLoanCashSpecifiedRepaymentInstance:txnLoanCashSpecifiedRepaymentInstance])       
        }
        else{
            flash.message = 'Error! No cash account defined.|error|alert'
            render(view: '/tellering/index')            
        }        
        
    }

    
/* LOAN CHECK SPECIFIED REPAYMENT */
    
    def saveTellerLoanCheckSpecifiedRepaymentTxn(TxnLoanPaymentDetails tc, TxnFile tf){
        println params //Error check
        
        if(tc.hasErrors() || tf.hasErrors()){
            flash.message = 'Failed to transfer.|error|alert'
            render(view: '/tellering/txnLoanCheckSpecifiedRepayment/create', model: [txnLoanCheckSpecifiedRepaymentInstance:tc])
        }
        else{
            def tb = new TxnCashCheckBlotter()
            def loanInstance = Loan.get(params?.loanId)
            def txnTemp = tf.txnTemplate
            def branch = Branch.get(loanInstance.branchId)
            def userBranch = UserMaster.get(session.user_id)
            def acctProduct = ProductTxn.findAllWhere(product:loanInstance.product,txnTemplate:txnTemp)
            
            // transaction not allowed for product
            if (!acctProduct) {
                flash.message = 'Transaction not allowed for product.|error|alert'
                render(view: '/tellering/txnLoanCheckSpecifiedRepayment/create', model: [txnLoanCheckSpecifiedRepaymentInstance:tc])
                return                
            }
            // interbranch transactions account check
            if (loanInstance.branch != userBranch.branch && txnTemp.interbranchTxn != YesNoNa.get(1)){
                flash.message = 'Interbranch transaction for Other branch account only.|info|alert'
                render(view: '/tellering/txnLoanCheckSpecifiedRepayment/create', model: [txnLoanCashSpecifiedRepaymentInstance:tc])
                return                                                
            }
            
            // pay service charge
            Double totalServiceChargePaid = 0
            if (params.serviceChargeInstallmentAmount)
            {
                totalServiceChargePaid = Double.parseDouble(params.serviceChargeInstallmentAmount.replaceAll(",",""))
            }
            else
            {
                totalServiceChargePaid = 0
            }
            
            // pay penalty
            Double totalPenaltyPaid = 0
            if (params.penaltyInstallmentAmount)
            {
                totalPenaltyPaid = Double.parseDouble(params.penaltyInstallmentAmount.replaceAll(",",""))
            }
            else
            {
                totalPenaltyPaid = 0
            }
            
            // pay interest
            Double totalInterestPaid = 0
            if (params.interestInstallmentAmount)
            {
                totalInterestPaid = Double.parseDouble(params.interestInstallmentAmount.replaceAll(",",""))
            }
            else
            {
                totalInterestPaid = 0
            }
            // pay principal
            Double totalPrincipalPaid = 0
            if (params.principalInstallmentAmount)
            {
                totalPrincipalPaid = Double.parseDouble(params.principalInstallmentAmount.replaceAll(",",""))
            }
            else
            {
                totalPrincipalPaid = 0
            }
            
           if (totalPrincipalPaid > loanInstance.balanceAmount){
                flash.message = 'ERROR: Principal Payment Greater than loan balance'
                render(view:'/tellering/txnLoanCheckSpecifiedRepayment/create', model: [txnLoanCheckSpecifiedRepaymentInstance:tc])       
                return
            }
//            
//            if (totalInterestPaid > loanInstance.interestBalanceAmount){
//                flash.message = 'Interest Payment Greater than interest balance'
//                render(view:'/tellering/txnLoanCheckSpecifiedRepayment/create', model: [txnLoanCheckSpecifiedRepaymentInstance:tc])       
//                return
//            }
//            
//            if (totalPenaltyPaid > loanInstance.penaltyBalanceAmount){
//                flash.message = 'Penalty Payment Greater than penalty balance'
//                render(view:'/tellering/txnLoanCheckSpecifiedRepayment/create', model: [txnLoanCheckSpecifiedRepaymentInstance:tc])       
//                return
//            }
//            
//            if (totalServiceChargePaid > loanInstance.serviceChargeBalanceAmount){
//                flash.message = 'Service Charge Payment Greater than service charge balance'
//                render(view:'/tellering/txnLoanCheckSpecifiedRepayment/create', model: [txnLoanCheckSpecifiedRepaymentInstance:tc])       
//                return
//            }
            
            tb.cashOutAmt = 0;
            tb.cashInAmt = 0;
            tb.checkInAmt = 0;
            tb.checkOutAmt = 0;
            
            tf.acctNo = loanInstance.accountNo
            tf.loanAcct = loanInstance
            tf.currency = Currency.get(loanInstance.product.currencyId)
            tf.user = UserMaster.get(session.user_id)
            tf.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tf.txnAmt = (params?.paymentAmt.replaceAll(",","")).toDouble()
            tf.txnCode = txnTemp.code
            tf.txnDate = branch.runDate
            tf.txnTimestamp = new Date().toTimestamp()
            tf.txnDescription = txnTemp.codeDescription
            tf.status = ConfigItemStatus.get(2)
            tf.txnType = txnTemp.txnType
            tf.save(flush:true,failOnError:true)
            
            def amt = (tf.txnAmt).longValue()
            def isTxnAllowed =  policyService.isTxnAllowed(txnTemp.code, amt)
            if(isTxnAllowed == false) {
                tf.status = ConfigItemStatus.get(1)
                policyService.createException('1001', 'txnFile', tf.id, 'tellering/viewTellerTxnInquiry2/'+tf.id)
            }
            tf.save(flush: true)
            
            def totalLoan = (loanInstance.balanceAmount + loanInstance.interestBalanceAmount 
                             + loanInstance.penaltyBalanceAmount + loanInstance.serviceChargeBalanceAmount)
            def totalLoanPayment = (totalPrincipalPaid + totalInterestPaid + totalPenaltyPaid + totalServiceChargePaid)
            
            loanInstance.balanceAmount -= totalPrincipalPaid
            loanInstance.interestBalanceAmount -= totalInterestPaid
            loanInstance.penaltyBalanceAmount -= totalPenaltyPaid
            loanInstance.serviceChargeBalanceAmount -= totalServiceChargePaid
            loanInstance.lastTransactionNo = tf.id
            def txnSeqNo
            if(loanInstance.transactionSequenceNo == null)
            {
                txnSeqNo = 0
//                println "TEST SEQ.1 " + txnSeqNo
            }
            else
            {
                txnSeqNo = loanInstance.transactionSequenceNo
//                println "TEST SEQ.2 " + txnSeqNo
            }
            loanInstance.transactionSequenceNo = txnSeqNo + 1   
            loanInstance.lastTransactionDate = branch.runDate
            loanInstance.lastCustormerTransactionDate  = branch.runDate            
            loanInstance.save(flush:true,failOnError:true)
            
            tc.acct = loanInstance
            tc.acctNo = loanInstance.accountNo
            //tc.balForwarded = (totalLoan - totalLoanPayment)
            tc.balForwarded = loanInstance.balanceAmount + totalPrincipalPaid
            tc.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tc.currency = Currency.get(loanInstance.product.currencyId)
            //tc.grtAmt = loanInstance.accountNo
            tc.interestAmt = totalInterestPaid
            tc.interestBalAfterPayment = loanInstance.interestBalanceAmount
            tc.otherAmt = 0
            //tc.pastDueInterestAmt = loanInstance.accountNo
            tc.paymentAmt = (params?.paymentAmt.replaceAll(",","")).toDouble()
            tc.penaltyAmt = totalPenaltyPaid
            tc.penaltyBalAfterPayment = loanInstance.penaltyBalanceAmount
            tc.principalAmt = totalPrincipalPaid
            tc.principalBalAfterPayment = loanInstance.balanceAmount
            tc.serviceChargeAmt = totalServiceChargePaid
            tc.totalNetProceeds = loanInstance.totalNetProceeds
            tc.txnDate = branch.runDate
            tc.txnFile = tf
            tc.txnRef = tf.txnRef
            tc.user = UserMaster.get(session.user_id)
            tc.save(flush:true,failOnError:true)
            
            // create loan ledger entry
            def loanLedgerEntry = new LoanLedger(loan: loanInstance,  txnFile: tf, txnDate: branch.runDate, txnTemplate: tf.txnTemplate, txnRef: tf.txnRef,  // txnType: TxnType.get(11),
                principalCredit: totalPrincipalPaid, principalBalance: loanInstance.balanceAmount, 
                interestCredit: totalInterestPaid, interestBalance: loanInstance.interestBalanceAmount, 
                penaltyCredit: totalPenaltyPaid, penaltyBalance: loanInstance.penaltyBalanceAmount,
                chargesCredit: totalServiceChargePaid, chargesBalance: loanInstance.serviceChargeBalanceAmount)
            loanLedgerEntry.save(flush:true,failOnError:true)
            
            //if(tb.id > 1){
            //    def tm = TxnCashCheckBlotter.get(tb.id - 1)
            //    tb.cashOutAmt = tm.cashOutAmt
            //    tb.cashInAmt = tm.cashInAmt
            //    tb.checkInAmt += tm.checkInAmt
            //    tb.checkOutAmt = tm.checkOutAmt
            //}
//            tb.checkInAmt += tc.principalAmt
//            tb.checkInAmt += tc.interestAmt
//            tb.checkInAmt += tc.penaltyAmt
//            tb.checkInAmt += tc.serviceChargeAmt
//            tb.checkInAmt += tc.grtAmt
            tb.checkInAmt = tf.txnAmt
            tb.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tb.currency = Currency.get(loanInstance.product.currencyId)
            tb.user = UserMaster.get(session.user_id)
            tb.txnParticulars = tf.txnRef
            tb.txnFile = tf
            tb.save(flush:true,failOnError:true)
            
            session["checks"].id.each {tcoci_id ->
                def tcoci = TxnCOCI.get(tcoci_id)
                tcoci.status = ConfigItemStatus.get(2)
                tcoci.txnCheckStatus = TxnCheckStatus.get(2)
                println "CHECK STATUS " + tcoci.txnCheckStatus
                tcoci.txnFile = tf
                
                if(tcoci.checkType == CheckDepositClearingType.get(3)){
                    def checks = Cheque.findByChequeNo(tcoci.checkNo)
                    def chequebookInstance = checks.chequebook 
                    checks.chequeAmt = tcoci.checkAmt
                    checks.chequeDate = tcoci.checkDate
                    checks.isChequeClrOnUs = true
                    checks.status = CheckStatus.get(3)
                    checks.save(flush:true,failOnError:true)
                    
                    chequebookInstance.chequesUsed += 1
                    chequebookInstance.save(flush:true,failOnError:true)
                    
                    debitOnus(checks)
                    
                    tcoci.txnCheckStatus = TxnCheckStatus.get(3)
                    tcoci.cleared = true
                    tcoci.clearingDate = tf.txnDate
                }   
                
                def checkClearDate = tcoci.checkType.clearingDate
                tcoci.clearingDate = checkClearDate
                //tcoci.depAcct = depositInstance
                tcoci.save(flush:true,failOnError:true)
            }
            //def txnBreakdownInstance = new TxnBreakdown(creditAmt:tb.checkInAmt, txnDate:tf.txnDate, txnFile:tf)
            //txnBreakdownInstance.save(flush:true)
            
            userMasterService.updateTellerBalanceStatus(false)
            glTransactionService.saveTxnBreakdown(tf.id)
            
            flash.message = 'Transaction complete.|success|alert'
            //redirect(controller: "tellering", action: "createTellerLoanCheckSpecifiedRepaymentTxn")
            redirect(controller: "tellering", action: "txnSuccess")
            
            session["transactionFileId"] = tf.id.toInteger()
            session["jrxmlTcId"] = params.txnTemplate.toInteger()
            println "Loan check Specified   "+session["transactionFileId"] 
            println " Txn Template "+session["jrxmlTcId"] 
            session["map"] = "loan"
            println"map "+ session["map"]
////          Calling jasper file
//            def list = TxnFile.findAllById(tf.id) 
//            params._file = "validation1.jasper"
//            params._format = "PDF"
//            params._name = "Validation"
//            chain(controller:'jasper',action:'index',model:[data:list],params:params)
            
//            render(view: '/tellering/index', model: [txnLoanCheckSpecifiedRepaymentInstance:new TxnLoanPaymentDetails()])
        }
    }
    def createTellerLoanCheckSpecifiedRepaymentTxn(){
        
        def user = UserMaster.get(session.user_id)
        if (user.coci){
            def loanInstallmentInstance = new LoanInstallment()
            def txnFileInstance = new TxnFile()
            def txnCOCIInstance = new TxnCOCI()
            def txnLoanCheckSpecifiedRepaymentInstance = new TxnLoanPaymentDetails()
            session["checks"] = []
            render(view:'/tellering/txnLoanCheckSpecifiedRepayment/create', model: [txnLoanCheckSpecifiedRepaymentInstance:txnLoanCheckSpecifiedRepaymentInstance])       
        }
        else{
            flash.message = 'Error! No cash account defined.|error|alert'
            render(view: '/tellering/index')            
        }
        
    }
    
/* LOAN PROCEEDS DISBURSEMENT */
    
    def saveTellerLoanProceedsDisbursementTxn(TxnLoanPaymentDetails tc, TxnFile tf){
        println "PARAMS TEST: " + params //Error check
        
        if(tc.hasErrors() || tf.hasErrors()){
            flash.message = 'Failed to transfer.|error|alert'
            render(view: '/tellering/txnLoanProceedsDisbursement/create', model: [txnLoanProceedsDisbursementInstance:tc])
        }
        else{
            def tb = new TxnCashCheckBlotter()
            def loanInstance = Loan.get(params?.loanId)
            def txnTemp = tf.txnTemplate
            def branch = Branch.get(UserMaster.get(session.user_id).branchId)
            def userBranch = UserMaster.get(session.user_id)
            def acctProduct = ProductTxn.findAllWhere(product:loanInstance.product,txnTemplate:txnTemp)
            //println "TESTING " + loanInstance.product + "-" + txnTemp
            //checking if partial disbursement is allowed
            if (Institution.get(80).paramValue == 'TRUE' && loanInstance?.loanKindOfLoan.id == 1)
            {
                if (loanInstance.totalNetProceeds != Double.parseDouble(params.totalNetProceeds.replaceAll(",","")))
                {
                flash.message = 'Partial Disbursement is not Allowed.|info|alert'
                render(view: '/tellering/txnLoanProceedsDisbursement/create', model: [txnLoanProceedsDisbursementInstance:tc])
                return   
                }
            }
            
            // transaction not allowed for product
            if (!acctProduct) {
                flash.message = 'Transaction not allowed for product.|error|alert'
                render(view: '/tellering/txnLoanProceedsDisbursement/create', model: [txnLoanProceedsDisbursementInstance:tc])
                return                
            }
            // interbranch transactions account check
            if (loanInstance.branch != userBranch.branch && txnTemp.interbranchTxn != YesNoNa.get(1)){
                flash.message = 'Interbranch transaction for Other branch account only.|info|alert'
                render(view: '/tellering/txnLoanProceedsDisbursement/create', model: [txnLoanProceedsDisbursementInstance:tc])
                return                                                
            }
            
//            if (params.totalNetProceeds.toDouble() > loanInstance.totalNetProceeeds){
//                flash.message = 'Amount greater than total net proceeds'
//                render(view: '/tellering/txnLoanProceedsDisbursement/create', model: [txnLoanProceedsDisbursementInstance:tc])
//                return
//            }       
            Double totalDisbursement = 0
            totalDisbursement = Double.parseDouble(params.totalNetProceeds.replaceAll(",",""))
            
            if (totalDisbursement > (loanInstance.totalNetProceeds - loanInstance.totalDisbursementAmount)) {
                flash.message = 'Net proceeds exceeds disbursement amount.|info|alert'
                render(view: '/tellering/txnLoanProceedsDisbursement/create', model: [txnLoanProceedsDisbursementInstance:tc])
                return                  
            }
            tb.cashOutAmt = 0;
            tb.cashInAmt = 0;
            tb.checkInAmt = 0;
            tb.checkOutAmt = 0;
            
            tf.acctNo = loanInstance.accountNo
            tf.loanAcct = loanInstance
            tf.currency = Currency.get(loanInstance.product.currencyId)
            tf.user = UserMaster.get(session.user_id)
            tf.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tf.txnAmt = totalDisbursement
            tf.txnCode = txnTemp.code
            tf.txnDate = branch.runDate
            tf.txnTimestamp = new Date().toTimestamp()
            tf.txnDescription = txnTemp.codeDescription
            tf.status = ConfigItemStatus.get(2)
            tf.txnType = txnTemp.txnType
            tf.save(flush:true,failOnError:true)
            
            def amt = (tf.txnAmt).longValue()
            def isTxnAllowed =  policyService.isTxnAllowed(txnTemp.code, amt)
            if(isTxnAllowed == false) {
                tf.status = ConfigItemStatus.get(1)
                policyService.createException('1001', 'txnFile', tf.id, 'tellering/viewTellerTxnInquiry2/'+tf.id)
            }
            tf.save(flush: true)
            
            loanInstance.balanceAmount += totalDisbursement
            loanInstance.totalDisbursementAmount += totalDisbursement
            loanInstance.lastTransactionNo = tf.id
            def txnSeqNo
            if(loanInstance.transactionSequenceNo == null)
            {
                txnSeqNo = 0
                //println "TEST SEQ.1 " + txnSeqNo
            }
            else
            {
                txnSeqNo = loanInstance.transactionSequenceNo
                //println "TEST SEQ.2 " + txnSeqNo
            }
            loanInstance.transactionSequenceNo = txnSeqNo + 1  
            loanInstance.lastTransactionDate = branch.runDate
            loanInstance.lastCustormerTransactionDate = branch.runDate    
            if(loanInstance.totalDisbursementAmount == loanInstance.totalNetProceeds)
            {
                loanInstance.status = LoanAcctStatus.get(4)
            }
            loanInstance.save(flush:true,failOnError:true)
            
            // create loan ledger entry
            def loanLedgerEntry = new LoanLedger(loan: loanInstance, txnFile: tf, txnDate: branch.runDate, txnTemplate: tf.txnTemplate, txnRef: tf.txnRef,  // txnType: TxnType.get(11),
                principalDedit: totalDisbursement, principalBalance: loanInstance.balanceAmount)
            loanLedgerEntry.save(flush:true,failOnError:true)
            
            //if(tb.id > 1){
            //    def tm = TxnCashCheckBlotter.get(tb.id - 1)
            //    tb.cashOutAmt += tm.cashOutAmt
            //    tb.cashInAmt = tm.cashInAmt
            //    tb.checkInAmt = tm.checkInAmt
            //    tb.checkOutAmt = tm.checkOutAmt
            //}
            tb.cashOutAmt = totalDisbursement
            tb.branch = Branch.get(UserMaster.get(session.user_id).branchId)
            tb.currency = Currency.get(loanInstance.product.currencyId)
            tb.user = UserMaster.get(session.user_id)
            tb.txnParticulars = tf.txnRef
            tb.txnFile = tf
            tb.save(flush:true,failOnError:true)
            
            
            //def txnBreakdownInstance = new TxnBreakdown(debitAmt:tb.cashOutAmt, txnDate:tf.txnDate, txnFile:tf)
            //txnBreakdownInstance.save(flush:true)
            
            userMasterService.updateTellerBalanceStatus(false)
            glTransactionService.saveTxnBreakdown(tf.id)
  
            flash.message = 'Transaction complete.|success|alert'
            //redirect(controller: "tellering", action: "createTellerLoanProceedsDisbursementTxn")
            redirect(controller: "tellering", action: "txnSuccess")
            
            session["transactionFileId"] = tf.id.toInteger()
            println "Loan Proceed Disbursement   "+session["transactionFileId"]
            session["map"] = "loandisb"
            println"map "+session["map"] 
////          Calling jasper file
//            def list = TxnFile.findAllById(tf.id) 
//            params._file = "validation1.jasper"
//            params._format = "PDF"
//            params._name = "Validation"
//            chain(controller:'jasper',action:'index',model:[data:list],params:params)
            
//            render(view: '/tellering/index', model: [txnLoanProceedsDisbursementInstance:new TxnLoanPaymentDetails()])
        }
    }
    def createTellerLoanProceedsDisbursementTxn(){
        
        def user = UserMaster.get(session.user_id)
        def flag_ = 6
        if (user.cash){
            def txnFileInstance = new TxnFile()
            def txnLoanProceedsDisbursementInstance = new TxnLoanPaymentDetails()
            render(view:'/tellering/txnLoanProceedsDisbursement/create', model: [txnLoanProceedsDisbursementInstance:txnLoanProceedsDisbursementInstance,flag_:flag_])       
        }
        else{
            flash.message = 'Error! No cash account defined.|error|alert'
            render(view: '/tellering/index')            
        }        
    }
        
/* TRANSACTION INQUIRY */

    def viewTellerTxnInquiry(){
        render (view:'/tellering/txnInquiry/view');
    }
    
    def viewTellerTxnInquiry2(TxnFile tf){
        
        def txnFileInstance = null
        def senderInstance = null
        def beneficiaryInstance = null
        def txnTemplateInstance = null
        String indicator = "BAMF"
        
            txnFileInstance = TxnFile.get(tf.id)
            if (txnFileInstance?.sender?.id) {
                senderInstance = Customer.get(txnFileInstance?.sender?.id)
                sample = Customer.get(txnFileInstance?.sender?.id)
            }
            if (txnFileInstance?.beneficiary?.id){
                beneficiaryInstance = Customer.get(txnFileInstance?.beneficiary?.id)
            }
            if (txnFileInstance?.txnType) {
                int txnTypeNo = txnFileInstance?.txnType.toInteger()
                println txnTypeNo
                txnTemplateInstance = TxnTemplate.get(txnTypeNo)
                println txnTemplateInstance.txnType.codeDescription
                if((txnTypeNo >= 1 && txnTypeNo <= 4) || (txnTypeNo >= 118 && txnTypeNo <= 121)){
                    indicator = "Teller Cash"
                }
                if((txnTypeNo >= 5 && txnTypeNo <= 32) || (txnTypeNo >= 79 && txnTypeNo <= 86)){
                    indicator = "Deposit"
                }
                if((txnTypeNo >= 5 && txnTypeNo <= 55) || (txnTypeNo >= 87 && txnTypeNo <= 117)){
                    indicator = "Other Cash/Check"
                }
                if((txnTypeNo >= 56 && txnTypeNo <= 78)){
                    indicator = "Loan"
                }
            }
        
        println indicator

        render(view:'/tellering/txnInquiry2/view', model:[txnFileInstance:txnFileInstance, senderInstance:senderInstance, beneficiaryInstance:beneficiaryInstance, txnTemplateInstance:txnTemplateInstance, indicator:indicator])
        return
    }

    def viewTellerOtherTxn(Integer max){
        
         
        //=================================================================
        // params.max = Math.min(max ?: 50, 100)
        
        //respond Institution.listOrderById(params), model:[InstitutionInstanceCount: Institution.count()]
        params.max = Math.min(max ?: 10, 100)

        if (params.sort == null) {  // default ordering
            
        }

        if (params.query == null || params.query=="") {  // show all instances
            def otherTxn = TxnFile.createCriteria().list(params) {
                and{
                    eq("user",UserMaster.get(session.user_id))   
                    eq("txnDate",Branch.get(1).runDate)
                }
                order("id", "asc")
            }  
           
           render(view:'/tellering/tellerBalancing/viewTellerOtherTxn.gsp', model: [params:params,otherTxn: otherTxn,otherTxnInstanceCount:otherTxn.totalCount])  
            
        }
        else {    // show query results
            def otherTxn = TxnFile.createCriteria().list(params) {
                and{
                    
                    eq("user",UserMaster.get(session.user_id))   
                    eq("txnDate",Branch.get(1).runDate)
                    
                    eq("id",params.query.toLong())
                }
                
            } 
            render(view:'/tellering/tellerBalancing/viewTellerOtherTxn.gsp', model: [params:params,otherTxn: otherTxn,otherTxnInstanceCount:otherTxn.totalCount])
        }  
        //=================================================================
    }
    
    def showGlEntries(TxnFile txnFileInstance){
        if (txnFileInstance){
            def glEntries = TxnBreakdown.findAllByTxnFile(txnFileInstance) 
            render(view:'/tellering/tellerBalancing/showGlEntries.gsp',model:[glEntries:glEntries,txnFileInstance:txnFileInstance]) 
        } else {
            render(view:'/tellering/index')
        }
    }
/* TELLER BALANCING */

    def viewTellerBalancing(){
        //def txnBalancing = new TxnTellerCash()
        //getCashOnHand()
        render(view:'/tellering/tellerBalancing/create')    
        //redirect
            
        //render(view:'/tellering/tellerBalancing/view', model: [txnBalancing:txnBalancing]) 
        //def tellerBalancingInstance = new TellerBalancingCommand()
        //render (view:'/tellering/tellerBalancing/view', model:[tellerBalancingInstance]);
    }
    
    def viewTellerCashTxn() {
        def tbCash = TxnCashCheckBlotter.createCriteria().list() {
            and{
                eq("user",UserMaster.get(session.user_id))   
                //eq("txnFile.txnDate",Branch.get(1).runDate)
            }
            order("txnFile", "asc")
        }  
        render(view:'/tellering/tellerBalancing/viewTellerCashTxn',model:[tbCash:tbCash]) 
    }
    
    def comfirmTellerBalance(){
        // March 8 - 10, 2016 - reyjie.u.roque@gmail.com
        // - Redo teller balance code, 
        // - Added new table TxnTellerBalance that auto populate during login activity
        // - Added per currency teller balance
        // - MISSNG: LogAudit Entry
        //println params
        def BranchDate = UserMaster.get(session.user_id).branch.runDate
        def userMaster = UserMaster.get(session.user_id)
        def currency = Currency.get(params.txnTemplate.toInteger())
        def txnBalanceTeller = TxnTellerBalance.findByUserAndTxnDateAndCurrency(userMaster,BranchDate,currency)
        def cashOnHand = (params.txnAmt).replace(',','').toDouble()
        Double valComp = txnBalanceTeller.cashIn - txnBalanceTeller.cashOut
        Integer cnt = txnBalanceTeller.count()
        flash.message = 'Teller Balance Error:# Cash on Hand does not match with the system cash!|error|alert'
        //println txnBalanceTeller
        //println 'coh? '+ cashOnHand
        //println txnBalanceTeller.cashIn
        //println txnBalanceTeller.cashOut
        //println 'comp? ' + (valComp)
        //println 'cnt? ' + cnt
        assert cnt != 0
        if(cnt != 0)
        {
            //println 'asdasdkjhakjsdassd'
            //println txnBalanceTeller
            if(txnBalanceTeller.isBalance != true)
            {
                //println "121212"
                if(cashOnHand == (txnBalanceTeller.cashIn - txnBalanceTeller.cashOut))
                {
                    //println "33333333"
                    txnBalanceTeller.isBalance = true
                    txnBalanceTeller.lastBalanceAmt = cashOnHand
                    txnBalanceTeller.save flush:true
                }
                
                if(txnBalanceTeller.isBalance == true)
                {
                    flash.message = 'Congratulations, you have balanced!|success|alert'
                }
            }
        }
        
        
        def user = UserMaster.get(session.user_id)
        
        TxnTellerBalance.findAllByUserAndTxnDateAndIsBalance(userMaster,BranchDate,false).each{ tellerbal ->
            if((tellerbal.cashIn + tellerbal.cashOut) == 0)
            {
                tellerbal.isBalance = true
                tellerbal.save flush:true
            }
        }
        
        txnBalanceTeller = TxnTellerBalance.findAllByUserAndTxnDateAndIsBalance(userMaster,BranchDate,false)
        cnt = txnBalanceTeller.size()
        if(cnt != 0)
        {
            flash.message = 'You still have unbalanced transaction on other currency!|warning|alert'
            user.isTellerBalanced = false
        } else {
            user.isTellerBalanced = true
            flash.message = 'Congratulations, you have balanced!|success|alert'     
        }
        user.save(flush:true)
        
        
        //if()
        
        /*
         * 
         * 
        def bList = TxnCashCheckBlotter.findAllByUser(UserMaster.get(session.user_id))
        Double cashIn = 0
        Double cashOut = 0
        Double  cashNet = 0

        def cashOnHand = params.txnAmt.replace(',', '').toDouble()
       
        for (b in bList){
            cashIn += b.cashInAmt
            cashOut += b.cashOutAmt 
        }
        cashNet = cashIn - cashOut
      
        
        if (cashNet != cashOnHand){
            flash.message = 'Teller Balance Error: Cash on Hand does not match with the system cash!|error|alert'
        }
        else{
            def user = UserMaster.get(session.user_id)
            user.isTellerBalanced = true
            user.save(flush:true)
            flash.message = 'Congratulations, you have balanced!|success|alert'    
        }
        
        
        println cashNet
        */
        // println session
        //println params
        //redirect (view:'/tellering/index');
        
        auditLogService.insert('120', 'TLR02300', 'Teller Transaction View', 'txnTellerBalance' , null, null, 'tellering/viewTellerBalancing', userMaster.id)
        
        redirect(controller:"tellering", action: "index")
        
        
    }
    // added by jm
    def forceBalancePerUser(){
        def json = request.JSON
      
        println("########### value from ajax #################################")
        println("saccountNo :"+json.id)
        //auditLogService.insert('100', 'LON00600',loanSweepInstanceee.fundedLoan.accountNo + ' Add loan sweep ' + loanSweepInstanceee.depositAccount.acctNo, 'LoanRecovery', null, null, null, loanSweepInstanceee.id)
        def userMasterForceBalanceUser = UserMaster.get(json.id.toInteger())
        def dUsername = userMasterForceBalanceUser.username
        println("userMasterForceBalanceUser: "+userMasterForceBalanceUser)
        userMasterForceBalanceUser.isTellerBalanced = true
        userMasterForceBalanceUser.save(flush: true)
        auditLogService.insert('120', 'TLR02300', 'Force Balanced User '+dUsername, 'txnTellerBalance' , null, null, 'periodicOps/EODCheck', userMasterForceBalanceUser.id)
        //flash.message = 'Congratulations, you have force balanced user '+dUsername+'|success|alert'  
        println("savingggg.....")
        def sql = new Sql(dataSource)
        def queryall = "select * from branch limit 1"
        def resultqueryall = sql.rows(queryall)
        render resultqueryall as JSON
    }
    def forceBalanceAllUser(){
        def userMasterInstanceList = UserMaster.createCriteria().list(params) {
            and {
                eq("isTellerBalanced", false)
                eq("configItemStatus", ConfigItemStatus.read(2))
            }
        }
        if(userMasterInstanceList){
            for (usrLst in userMasterInstanceList) {
                println("usrLst.id: "+usrLst.id )
                def updateIsTellerBalance = UserMaster.get(usrLst.id)
                def dUsername = updateIsTellerBalance.username
                updateIsTellerBalance.isTellerBalanced = true
                updateIsTellerBalance.save(flush: true)
                auditLogService.insert('120', 'TLR02300', 'Force Balanced User '+dUsername, 'txnTellerBalance' , null, null, 'periodicOps/EODCheck', updateIsTellerBalance.id)
                //flash.message = 'Congratulations, you have force balanced user '+dUsername+'|success|alert'  
                println("savingggg.....")
                println("per rows: "+updateIsTellerBalance)
            }
        }else{
            
        }
        
        def sql = new Sql(dataSource)
        def queryall = "select * from branch limit 1"
        def resultqueryall = sql.rows(queryall)
        render resultqueryall as JSON
    }
    def getCurrencyOnTemplate()
    {
      //println params.txnTemplate.id  
       println params
      //def 
    //  println params.recid
    //  println params.txn
    
        def retcur = TxnTemplate.get(params.recid.toInteger()).currency
       
        //def retcur = "test"
        
       // "retcur.id"
      render(text: '{"currency":'+retcur.id+'}') as JSON
      return

    }
    
    
    def getCashOnHand()
    {
        def BranchDate = UserMaster.get(session.user_id).branch.runDate
        def sql = "SELECT SUM(A.cash_in_amt) cashin, "
            sql += "SUM(A.cash_out_amt) cashout,"
            sql += "B.name,B.code,B.id currency_id,C.txn_date "
            sql += "FROM txn_cash_check_blotter A "
            sql += "LEFT JOIN currency B ON A.currency_id = B.id AND B.config_item_status_id = 2 "
            sql += "LEFT JOIN txn_file C ON A.txn_file_id = C.id "
            sql += "WHERE A.user_id = "+session.user_id+" AND SUBSTRING(to_char(C.txn_date, 'YYYY-MM-DD HH24:MI:SS') from 1 for 10) = SUBSTRING('"+BranchDate+"' from 1 for 10) "
            //sql += "AND B.id IN (SELECT DISTINCT X.currency_id FROM currency_detail X "
            //sql += "WHERE X.currency_id IN (SELECT id FROM currency WHERE config_item_status_id = 2)) "
            sql += "GROUP BY B.name,B.code,C.txn_date,B.id "
        //println sql
       // println BranchDate
        def db = new Sql(dataSource)
        def sqlresult = db.rows(sql)
       // println sqlresult
        def txnTellerBalanceInstance
        def dt
        def newdate
        //SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")
        
        sqlresult.each{ values ->
            //println values
            //if(CurrencyDetail.findAllByCurrency(Currency.get(values.currency_id)))
           // {
                txnTellerBalanceInstance = TxnTellerBalance.findByCurrencyAndTxnDateAndUser(Currency.get(values.currency_id),values.txn_date,UserMaster.get(session.user_id))
                txnTellerBalanceInstance.cashIn = values.cashin
                txnTellerBalanceInstance.cashOut = values.cashout
                txnTellerBalanceInstance.isBalance = (values.cashin - values.cashout) == txnTellerBalanceInstance.lastBalanceAmt
                //if(values.cashin - values.cashout > txnTellerBalanceInstance.lastBalanceAmt)
               // {
                    
                //}
                txnTellerBalanceInstance.save flush:true
            //}   
        }
        
        def results = new JsonBuilder(sqlresult).toPrettyString()
        //println results
        render(text: results) as JSON
        return            
        
    }
    
/* TRANSACTION REVERSAL/CANCELLATION */

    def viewTellerReverseCancelTxn(){
        def txnReversalInstance = new TxnDepositAcctLedger()
        render(view:'/tellering/txnReversal/view', model: [txnReversalInstance:txnReversalInstance, id:txnDepAccMinId, jrxmlTcId:jrxmlTcId, passbookline:passbookline]) //added params for passbook validation        
        
        //render (view:'/tellering/txnReversal/view');
    }
    
    def reverseTxn() {
        println "params? "+params
        if (params) {
            //def thisid = params.id.toInteger()
            def tf = TxnFile.get(params.txnID)
            // check if already cancelled
            println tf
            if(!tf)
            {
                flash.message = 'Transaction not found!|error|alert'
                redirect(controller: "tellering", action: "viewTellerReverseCancelTxn")
                return
            } else
            {
                if (tf.status == ConfigItemStatus.read(4)) {
                    flash.message = 'Transaction already cancelled|error|alert'
                    redirect(controller: "tellering", action: "viewTellerReverseCancelTxn")
                    return
                }

                // only allow reversal for same user
                if (tf.user != UserMaster.get(session.user_id)) {
                    flash.message = 'Transaction to reverse has different user|error|alert'
                    redirect(controller: "tellering", action: "viewTellerReverseCancelTxn")
                    return
                }

                if (tf.txnDate != Branch.get(1).runDate) {
                    flash.message = 'Reversal only allowed for current date|error|alert'
                    redirect(controller: "tellering", action: "viewTellerReverseCancelTxn")   
                    return
                }
                
                if (tf.txnType.id == 7 || tf.txnType.id == 8 || tf.txnType.id == 9 || tf.txnType.id == 16 ) {
                    flash.message = 'Reversal only allowed for cash/COCI transactions|error|alert'
                    redirect(controller: "tellering", action: "viewTellerReverseCancelTxn")   
                    return
                }   
                if (tf.txnType.id == 17 || tf.txnType.id == 18) {
                    flash.message = 'Reversal not allowed for FD Int Wdl and/or Pre-term Transactions|error|alert'
                    redirect(controller: "tellering", action: "viewTellerReverseCancelTxn")   
                    return
                }                
                if (tf.txnType.id >= 24) {
                    flash.message = 'System transaction reversal not allowed|error|alert'
                    redirect(controller: "tellering", action: "viewTellerReverseCancelTxn")   
                    return
                }  
                if (tf.txnType.id == 4) {
                    def rtcoci = TxnCOCI.findAllByTxnFile(tf)
                    Boolean isCleared = false
                    for (tc in rtcoci) {
                        if (tc.checkStatus.id == 5) {
                            isCleared = true
                        }
                    }                    
                    if (isCleared) {
                        flash.message = 'Cannot reverse check already cleared |error|alert'
                        redirect(controller: "tellering", action: "viewTellerReverseCancelTxn")   
                        return
                    }

                }       
                // check ending balance for transaction
                if ((tf.txnType.id == 3) || (tf.txnType.id == 4)){
                    if (tf.txnAmt > tf.depAcct.availableBalAmt) {
                        flash.message = 'Cannot reverse - negative available balance result |error|alert'
                        redirect(controller: "tellering", action: "viewTellerReverseCancelTxn")   
                        return                        
                    }
                }
                // check in transactions
                if ((tf.txnType.id == 4) || (tf.txnType.id == 13) || (tf.txnType.id == 15) || (tf.txnType.id == 20)) {
                    def tcoci = TxnCOCI.findAllByTxnFile(tf)
                    for (tc in tcoci) {
                        tc.status = ConfigItemStatus.get(4)
                        tc.save(flush:true)
                    }
                }

                // check encashment
                if (tf.txnType.id == 6) {
                    def  txnCheque = Cheque.findByChequeNo(tf.txnRef)
                    if (txnCheque) {
                        txnCheque.chequeDate = null
                        txnCheque.isChequeClrOnUs = null
                        txnCheque.chequeAmt = null
                        txnCheque.status = CheckStatus.get(2)
                        txnCheque.payeeName = null
                        txnCheque.save(flush:true,failOnError:true)       
                    } 
                }
                //save to txnid and particulars to txn_reversal
                def insrtToTxnReversal = new TxnReversal(txnFile:params.txnID, txnParticulars:params.txnParticulars,txnReference:params.txnReference)		
                    insrtToTxnReversal.save(flush:true)
                def tlrBlotter = TxnCashCheckBlotter.findByTxnFile(tf)
                if (tlrBlotter) {
                   def cashIn = tlrBlotter.cashInAmt
                   def cashOut = tlrBlotter.cashOutAmt
                   def checkIn = tlrBlotter.checkInAmt
                   def checkOut = tlrBlotter.checkOutAmt
                   def rvsBlotter = new TxnCashCheckBlotter(branch:tlrBlotter.branch, cashInAmt:cashOut, cashOutAmt:cashIn,
                        checkInAmt:checkOut, checkOutAmt:checkIn, currency:tlrBlotter.currency, txnFile:tlrBlotter.txnFile,
                        txnParticulars:'Txn Reversal', user:tlrBlotter.user)
                    rvsBlotter.save(flush:true)
                }

                def dep = tf.depAcct
                if ((tf.txnType.id == 3) || (tf.txnType.id == 9) || (tf.txnType.id == 27) ) {    
                    if (dep.ledgerBalAmt >= tf.txnAmt) {
                       dep.ledgerBalAmt -= tf.txnAmt 
                    }
                    if (dep.availableBalAmt >= tf.txnAmt) {
                       dep.availableBalAmt -= tf.txnAmt
                    }  
                }

                if (tf.txnType.id == 4) {
                   dep.ledgerBalAmt -= tf.txnAmt
                }

                if ((tf.txnType.id == 5) || (tf.txnType.id == 6) || (tf.txnType.id == 26)) {  
                    dep.ledgerBalAmt += tf.txnAmt
                    dep.availableBalAmt += tf.txnAmt 
                }
                
                if (dep) {
                    dep.save(flush:true)
                    // reversal in ledger
                    def tl = new TxnDepositAcctLedger(acct:dep, acctNo:dep.acctNo, bal:dep.ledgerBalAmt, branch:dep.branch,
                        currency:dep.product.currency, status:dep.status, passbookBal:dep.passbookBalAmt, 
                        txnDate:tf.txnDate, txnFile:tf, txnRef:'TXN REV-'+tf.txnRef, txnType:tf.txnType, user:tf.user)
                    if ((tf.txnType.id == 3) || (tf.txnType.id == 4) || (tf.txnType.id == 9) || (tf.txnType.id == 27) ) {
                        tl.debitAmt = tf.txnAmt
                    } else {
                        tl.creditAmt = tf.txnAmt
                    }
                    tl.save(flush:true)
                }
                def loan = tf.loanAcct
                // loan repayment
                if ((tf.txnType.id == 12) || (tf.txnType.id == 13) || (tf.txnType.id == 14) || (tf.txnType.id == 15)) {
                   def lp = TxnLoanPaymentDetails.findByTxnFile(tf) 
                   loan.balanceAmount += lp.principalAmt
                   loan.interestBalanceAmount += lp.interestAmt
                   loan.penaltyBalanceAmount += lp.penaltyAmt
                   loan.serviceChargeBalanceAmount += lp.serviceChargeAmt
                   loan.save(flush:true)
                   
                   def ll = new LoanLedger(loan:loan, txnTemplate:tf.txnTemplate, txnDate:tf.txnDate, txnRef:'TXN REV-'+tf.txnRef,
                        txnCode:tf.txnCode, txnParticulars:tf.txnParticulars, principalDebit:lp.principalAmt, 
                        principalBalance:loan.balanceAmount, interestDebit:lp.interestAmt, interestBalance:loan.interestBalanceAmount,
                        penaltyDebit:lp.penaltyAmt, penaltyBalance:loan.penaltyBalanceAmount, chargesDebit:lp.serviceChargeAmt,
                        chargesBalance:loan.serviceChargeBalanceAmount, txnFile:tf)
                   ll.save(flush:true)
                }
                // loan disbursement
                if (tf.txnType.id == 11) {
                    loan.balanceAmount -= tf.txnAmt
                    loan.totalDisbursementAmount -= tf.txnAmt
                    loan.save(flush:true)
                    
                    def ll = new LoanLedger(loan:loan, txnTemplate:tf.txnTemplate, txnDate:tf.txnDate, txnRef:'TXN REV-'+tf.txnRef,
                        txnCode:tf.txnCode, txnParticulars:tf.txnParticulars, principalCredit:tf.txnAmt, 
                        principalBalance:loan.balanceAmount, txnFile:tf)
                   ll.save(flush:true)                
               }
                
                tf.status = ConfigItemStatus.get(4)
                tf.save(flush:true)

                flash.message = "Reversal Complete..|success|alert"
                glTransactionService.reverseTxn(tf)
                userMasterService.updateTellerBalanceStatus(false)
            }
        }
        
        //render (view:'/tellering/txnReversal/view')
        def reverseTransactionFileInstance = TxnFile.get(params.txnID)
        //def getRefereceAndParticularsReverseInstance = TxnReversal.FindByTxnFile(161024)
        def getRecordsc = TxnReversal.createCriteria()
        def getRefereceAndParticularsReverseInstance = getRecordsc.list {
           
            and { 
                eq("txnFile", TxnFile.get(params.txnID))
            }
        }
        //respond reverseTransactionFileInstance
        render(view: '/tellering/reverseTxn',model:[reverseTransactionFileInstance:reverseTransactionFileInstance,getRefereceAndParticularsReverseInstance:getRefereceAndParticularsReverseInstance]); 
    }

    /* VIEW TRANSACTION SUMMARY */
    def viewTxnSummary(){
        render(view: '/tellering/txnSummaryView/viewSummary'); 
    }
    
    def receiveTellerCashJSON()
    {
      //println params.txnTemplate.id  
    //  println params.recid
      //def 
    //  println params.recid
    //  println params.txn
      
      def db = new Sql(dataSource)
      def sql = "select 9999"
      if(params.txn.toInteger()==0)
      {
            sql = "SELECT A.*,concat(TRIM(B.name1),' ',TRIM(B.name2),' ',TRIM(B.name3)) fullname FROM txn_file A LEFT JOIN user_master B ON A.user_id = B.id WHERE A.id = "+params.recid
      } else {
            sql = "SELECT *,txn_amt total FROM txn_teller_cash WHERE txn_file_id = "+params.recid
          
      }
     // println sql
      def results = new JsonBuilder(db.rows(sql)).toPrettyString()
      render(text: results) as JSON
      return

    }
    
    def receiveTellerCashTransfer()
    {
        // SELECT * FROM txn_file WHERE txn_type_id = 2 AND status_id = 1 AND id in (SELECT record_id FROM policy_exception WHERE requesting_user_id = 2)
        def db = new Sql(dataSource)
        //def user = UserMaster.get(session.user_id)
        def sql = "SELECT A.*,B.id policy_id  FROM txn_file A LEFT JOIN policy_exception B ON A.id=B.record_id  WHERE A.txn_type_id = 2 AND A.status_id = 1 AND A.id in (SELECT record_id FROM policy_exception WHERE date_of_action IS NULL AND requesting_user_id = "+session.user_id+")"
       // println sql
        def sourcetxn = db.rows(sql)
     //   println sourcetxn
      //  def sourcetlrcash = ''
       // println sourcetxn
        println("receiveTellerCashTransfer: entered")
        println("txn File Id: "+session["transactionFileId"])
        println(" validator value: "+session["doneTransact"])
        def txnReceivedSuccessInstance = TxnFile.get(session["transactionFileId"])
        println("result: "+txnReceivedSuccessInstance)
        if(session["doneTransact"] == "true"){
            session["doneTransact"] = "false"
            render(view: '/tellering/txnReceiveSuccess',model:[txnCashTransferInstance:new TxnTellerCash(),sourcetxn:sourcetxn,txnFileInstance:txnReceivedSuccessInstance]);
        }else{
            render(view: '/tellering/txnCashTransfer/receive',model:[txnCashTransferInstance:new TxnTellerCash(),sourcetxn:sourcetxn]); 
        }        
        
    }
    def txnReceiveSuccess(){
        
    }
    
    def receiveTellerCashTransferSave(TxnTellerCash tc)
    {
        session["doneTransact"] = ""
        println params
        println("tc: "+tc)
        def sourcetf = TxnFile.get(params.txnTemplate)
        def tf = new TxnFile()
        def txnBranch = Branch.get(UserMaster.get(session.user_id).branchId) 
        def txnUserMaster = UserMaster.get(session.user_id)
        def tb = new TxnCashCheckBlotter()
        def pcx = PolicyException.findByRecordId(params.txnTemplate)
        //def tc = new TxnTellerCash()
        def curval = params.tblinput
        def curidx = params.currencyidx
        def txn_teller_cashlist
        
       
         
        sourcetf.status = ConfigItemStatus.get(2)
        sourcetf.save flush:true,failOnError:true
        
        tf.branch = sourcetf.branch
        tf.currency = sourcetf.currency
        tf.status = ConfigItemStatus.get(2)
        tf.txnAmt = sourcetf.txnAmt
        tf.txnCode = sourcetf.txnCode
        tf.txnDate = txnBranch.runDate
        tf.txnDescription = sourcetf.txnDescription
        tf.txnRef = sourcetf.txnRef
        tf.txnParticulars = 'Receive Cash Transfer'
        tf.txnTemplate = sourcetf.txnTemplate
        tf.txnTimestamp = new Date().toTimestamp()
        tf.txnType = sourcetf.txnType
        tf.user = txnUserMaster
        
        println("tc.hasErrors(): "+tc.hasErrors())
        println("tc.hasErrors(): "+tf.hasErrors())
        if(tc.hasErrors() || tf.hasErrors()){
            flash.message = 'Failed to Receive Teller Cash Transfer|error'
            redirect(controller: "tellering", action: "receiveTellerCashTransfer")
            //render(view: '/tellering/txnCashTransfer/create', model: [txnCashTransferInstance:new TxnTellerCash()])
        }
        
        
        tf.save flush:true,failOnError:true
        
        curval.eachWithIndex  { valindex, index ->
        // println "val value ? " + valindex
            if(valindex.toInteger() >0)
            {
                txn_teller_cashlist = new TxnTellerCash()
                txn_teller_cashlist.currency = sourcetf.currency
                txn_teller_cashlist.currencydetail = CurrencyDetail.get(curidx[index].toInteger())
                txn_teller_cashlist.txnFile = tf
                txn_teller_cashlist.user = txnUserMaster
                txn_teller_cashlist.billcount = valindex.toInteger()
                txn_teller_cashlist.txnRef = params.txnRef
                txn_teller_cashlist.txnAmt = params.txnAmt.replace(',', '').toDouble()

                txn_teller_cashlist.save flush:true
                println "value index? " + curidx[index]
            }  
        }
        //tc.user = txnUserMaster
        //tc.currency = sourcetf.currency
        //tc.txnFile = tf
        //tc.save flush:true,failOnError:true
      //   tc.user = UserMaster.get(session.user_id)
      //   tc.save flush:true
        
        tb.cashOutAmt = 0;
        tb.cashInAmt = 0;
        tb.checkInAmt = 0;
        tb.checkOutAmt = 0;
        tb.txnFile = tf
        
        tb.cashInAmt = tf.txnAmt
        tb.branch = txnBranch
        tb.currency = sourcetf.currency
        tb.user = txnUserMaster
        tb.txnParticulars = tf.txnRef
        tb.save flush:true,failOnError:true
        

       // HttpSession session = RequestContextHolder.currentRequestAttributes().getSession();
        
        userMasterService.updateTellerBalanceStatus(false)
        glTransactionService.saveTxnBreakdown(tf.id)

        policyService.updateException('TxnFile',(int) (long) pcx.id,true)
 
        flash.message = 'Teller Cash Transfer (Receive - Success)|success'
        println("flash.message: "+flash.message)
        flash.message = 'Teller Cash Transfer (Receive - Success)|success'
        //redirect(controller: "tellering", action: "receiveTellerCashTransfer")
        def db = new Sql(dataSource)
        //def user = UserMaster.get(session.user_id)
        def sql = "SELECT A.*,B.id policy_id  FROM txn_file A LEFT JOIN policy_exception B ON A.id=B.record_id  WHERE A.txn_type_id = 2 AND A.status_id = 1 AND A.id in (SELECT record_id FROM policy_exception WHERE date_of_action IS NULL AND requesting_user_id = "+session.user_id+")"
       // println sql
        def sourcetxn = db.rows(sql)
        
        //redirect(controller: "tellering", action: "txnSuccess")
        
        transactionFileId = tf.id.toInteger()
        println "Receive teller cash   "+transactionFileId
        flash.message = 'Teller Cash Transfer (Receive - Success)|success'
        map = "deposit"
        
        session["transactionFileId"] = tf.id.toInteger()
        session["map"] = "deposit"
        println"map "+session["map"]
        session["doneTransact"] = "true"
        println("flash message value: "+flash.message)
        def txnReceivedSuccessInstance = TxnFile.get(tf.id.toInteger())
        println("result: "+txnReceivedSuccessInstance) 
        //render(view: '/tellering/txnCashTransfer/receive',model:[txnCashTransferInstance:new TxnTellerCash(),sourcetxn:sourcetxn]);
        //render(view: '/tellering/txnReceiveSuccess',model:[txnCashTransferInstance:new TxnTellerCash(),sourcetxn:sourcetxn,txnFileInstance:txnReceivedSuccessInstance]);
        
    }
    
    def receiveTellerCashCancel(TxnTellerCash tc)
    {
       // println params.txnTemplate
       // println "tellercancel"

        def tf = TxnFile.get(params.txnTemplate)
        def txnBranch = Branch.get(UserMaster.get(session.user_id).branchId) 
        def txnUserMaster = tf.user //UserMaster.get(session.user_id)
        def tb = new TxnCashCheckBlotter()
        def pcx = PolicyException.findByRecordId(params.txnTemplate)
        
        if(tc.hasErrors() || tf.hasErrors()){
            flash.message = 'Failed to Receive Teller Cash Transfer|error|alert'
            render (view:'/tellering/receiveTellerCashTransfer')   
            //redirect(controller: "tellering", action: "receiveTellerCashTransfer")
            //render(view: '/tellering/txnCashTransfer/create', model: [txnCashTransferInstance:new TxnTellerCash()])
        }

        /*
        tf.status = ConfigItemStatus.get(7)
        tf.save flush:true,failOnError:true

        
        tb.cashOutAmt = 0;
        tb.cashInAmt = 0;
        tb.checkInAmt = 0;
        tb.checkOutAmt = 0;
        tb.txnFile = tf

        tb.cashInAmt = tf.txnAmt
        tb.branch = txnBranch
        tb.currency = tf.currency
        tb.user = txnUserMaster
        tb.txnParticulars = tf.txnRef
        tb.save flush:true,failOnError:true

        userMasterService.updateTellerBalanceStatus(false)
        glTransactionService.saveTxnBreakdown(tf.id)
        */
        policyService.updateException('TxnFile',(int) (long) pcx.id,false)

        flash.message = 'Teller Cash Transfer (REJECTED)|warning|alert'
        //render (view:'/tellering/receiveTellerCashTransfer')   
        redirect(controller:"tellering", action: "index")
      //  redirect(controller: "tellering", action: "receiveTellerCashTransfer")

    }
    
    // initial tellerbalancing domain entry
   // def initTellerBalance()
   // {
   //     def curlist = Currency.getAll()
   //     println curlist
        
   // }
    
    // tellering cash from vault - JS get currency breakdown from txntemplate
    // -- teller cash from vault transaction
    def getTellerCashFromVaultTxnBreakDown()
    {
        println "istellerbalance ? "+params.istellerbalance
        println "recid? "+params.recid
        def curlist
        def txnTemplateInstance
        
        if(params.istellerbalance)
        {
            curlist = CurrencyDetail.findAllByCurrency(Currency.get(params.recid.toInteger()))
        } else {
            txnTemplateInstance = TxnTemplate.get(params.recid.toInteger())
            curlist = CurrencyDetail.findAllByCurrency(txnTemplateInstance.currency)
        }
        //println txnTemplateInstance
       
       // def curlist = CurrencyDetail.findAllByCurrency(txnTemplateInstance.currency)
     //   println  curlist
    //    println curlist.size()
        def jStr = new String[curlist.size()]
        def i = 0
        curlist.each{ itemlist ->
            jStr[i] = '{"id":'+itemlist.id+',"index":'+itemlist.index+',"longdesc":"'+itemlist.longdescription+'","shortdesc":"'+itemlist.shortdescription+'","value":"'+itemlist.currencyvalue+'"}'
            //itemlist = curlist[it]
          
            //println itemlist as JSON
            i++
        }
        def results = new JsonBuilder(jStr)
        //println jStr
        render(text:results) as JSON
        
        
        
    }
    
    def txnSuccess() {

        def txnFileInstance = TxnFile.get(session["transactionFileId"])
        def txnTypeId = txnFileInstance.txnType.id
        if (txnTypeId == 16 || txnTypeId == 38 || txnTypeId == 35  ) {
            session["transactionFileId"] = txnFileInstance.id.toInteger()
            //session["jrxmlTcId"] = txnFileInstance.txnTemplate.toInteger()
            println "Loan   "+session["transactionFileId"] 
            println " Txn Template "+session["jrxmlTcId"]
            session["map"] = "loan"
        }
        else {
        
        }
        if (txnTypeId == 3 || txnTypeId == 4 || txnTypeId == 5 || txnTypeId == 6) {
            session["transactionFileId"] = txnFileInstance.id.toInteger()
            // deposit, wdl, encashment
            if (txnFileInstance.txnTemplate.requirePassbook.id == 1) {
                flash.message = 'PrintValidation-PrintTransactionSlip-PrintPassbook'
            } else {
                flash.message = 'PrintValidation-PrintTransactionSlip'
            }
            render(view:'/tellering/txnSuccess', model: [txnFileInstance:txnFileInstance, id:txnDepAccMinId, jrxmlTcId:jrxmlTcId, passbookline:passbookline, print:flash.message])  
        } else if (txnTypeId == 17 || txnTypeId == 18) {
            // fd interest and pre-term
            if (txnFileInstance.txnTemplate.requirePassbook.id == 1) {
                flash.message = 'PrintValidation-PrintTransactionSlip-PrintPassbook'
            } else {
                flash.message = 'PrintValidation-PrintTransactionSlip'
            }            
            render(view:'/tellering/txnSuccess', model: [txnFileInstance:txnFileInstance, id:txnDepAccMinId, jrxmlTcId:jrxmlTcId, passbookline:passbookline, print:flash.message])
        } else if (txnTypeId == 12 || txnTypeId == 13 || txnTypeId == 14 || txnTypeId == 15) {
            // loan payments
            flash.message = 'PrintValidation-PrintTransactionSlip'
            render(view:'/tellering/txnSuccess', model: [txnFileInstance:txnFileInstance, print:flash.message])
        } else if (txnTypeId == 11) {
            // loan disbursement
            flash.message = 'PrintValidation-PrintTransactionSlip'
            render(view:'/tellering/txnSuccess', model: [txnFileInstance:txnFileInstance, print:flash.message])            
        } else {
            flash.message = 'PrintValidation'
            render(view:'/tellering/txnSuccess', model: [txnFileInstance:txnFileInstance, print:flash.message])
            //respond txnFileInstance 
        }
        
    }
    def txnReprint(TxnFile txnFileInstance){

        //def txnFileInstance = TxnFile.get(session["transactionFileId"])
        def txnTypeId = txnFileInstance.txnType.id
        if (txnTypeId == 16 || txnTypeId == 38 || txnTypeId == 35  ) {
            session["transactionFileId"] = txnFileInstance.id.toInteger()
            //session["jrxmlTcId"] = txnFileInstance.txnTemplate.toInteger()
            println "Loan   "+session["transactionFileId"] 
            println " Txn Template "+session["jrxmlTcId"]
            session["map"] = "loan"
        }
        else {
        
        }
        if (txnTypeId == 3 || txnTypeId == 4 || txnTypeId == 5 || txnTypeId == 6) {
            session["transactionFileId"] = txnFileInstance.id.toInteger()
            // deposit, wdl, encashment
            if (txnFileInstance.txnTemplate.requirePassbook.id == 1) {
                flash.message = 'PrintValidation-PrintTransactionSlip-PrintPassbook'
            } else {
                flash.message = 'PrintValidation-PrintTransactionSlip'
            }
            render(view:'/tellering/txnSuccess', model: [txnFileInstance:txnFileInstance, id:txnDepAccMinId, jrxmlTcId:jrxmlTcId, passbookline:passbookline, print:flash.message])  
        } else if (txnTypeId == 17 || txnTypeId == 18) {
            // fd interest and pre-term
            if (txnFileInstance.txnTemplate.requirePassbook.id == 1) {
                flash.message = 'PrintValidation-PrintTransactionSlip-PrintPassbook'
            } else {
                flash.message = 'PrintValidation-PrintTransactionSlip'
            }            
            render(view:'/tellering/txnSuccess', model: [txnFileInstance:txnFileInstance, id:txnDepAccMinId, jrxmlTcId:jrxmlTcId, passbookline:passbookline, print:flash.message])
        } else if (txnTypeId == 12 || txnTypeId == 13 || txnTypeId == 14 || txnTypeId == 15) {
            // loan payments
            flash.message = 'PrintValidation-PrintTransactionSlip'
            render(view:'/tellering/txnSuccess', model: [txnFileInstance:txnFileInstance, print:flash.message])
        } else if (txnTypeId == 11) {
            // loan disbursement
            flash.message = 'PrintValidation-PrintTransactionSlip'
            render(view:'/tellering/txnSuccess', model: [txnFileInstance:txnFileInstance, print:flash.message])            
        } else {
            flash.message = 'PrintValidation'
            render(view:'/tellering/txnSuccess', model: [txnFileInstance:txnFileInstance, print:flash.message])
            //respond txnFileInstance 
        }
        
    }
}

    

@grails.validation.Validateable
class TellerBalancingCommand {
    
    Double txnAmt
    Integer bills1000
    Integer bills500
    Integer bills200
    Integer bills100
    Integer bills50
    Integer bills20
    Integer coins10
    Integer coins5
    Integer coins1
    Integer coins025
    Integer coins010
    Integer coins005
    Integer coins001
    Double total1000
    Double total500
    Double total200
    Double total100
    Double total50
    Double total20
    Double total10
    Double total5
    Double total1
    Double total025
    Double total010
    Double total005
    Double total001
    
    static constraints = {
        txnAmt nullable:true
        bills1000 nullable:true
        bills500 nullable:true
        bills200 nullable:true
        bills100 nullable:true
        bills50 nullable:true
        bills20 nullable:true
        coins10 nullable:true
        coins5 nullable:true
        coins1 nullable:true
        coins025 nullable:true
        coins010 nullable:true
        coins005 nullable:true
        coins001 nullable:true
        total1000 nullable:true
        total500 nullable:true
        total200 nullable:true
        total100 nullable:true
        total50 nullable:true
        total20 nullable:true
        total10 nullable:true
        total5 nullable:true
        total1 nullable:true
        total025 nullable:true
        total010 nullable:true
        total005 nullable:true
        total001 nullable:true
    }
    
    static mapping = {
        id sqlType: 'int', generator: 'increment'
    }
    
}

