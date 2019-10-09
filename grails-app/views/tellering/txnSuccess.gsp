<%@ page import="icbs.tellering.TxnFile" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <title>Transaction Success</title>
    </head>    
    <body>
        <content tag="main-content">

            <br> <br>
          
            <div class="row">
                <div class="form-horizontal">
                    <div class="col-md-8">
                        <div class="infowrap">
                            <table class="table table-bordered table-striped">
                                <legend class="section-header">Transaction Details</legend>
                                    <tr>
                                        <td><label>Transaction ID</label></td>
                                        <td>${txnFileInstance.id}</td>
                                    </tr>                                
                                    <tr>
                                        <td><label>Transaction Date</label></td>
                                        <td><g:formatDate  format="MM/dd/yyyy" date="${txnFileInstance?.txnDate}" /></td>
                                    </tr>
                                    <tr>
                                        <td><label>Transaction Type</label></td>
                                        <td><g:fieldValue bean="${txnFileInstance}" field="txnType.description"/></td>
                                    </tr>
                                    <tr>
                                        <td><label>Account Number</label></td>
                                        <td><g:fieldValue bean="${txnFileInstance}" field="acctNo"/></td>
                                    </tr>                                    
                                    <tr>
                                        <td><label>Branch</label></td>
                                        <td><g:fieldValue bean="${txnFileInstance}" field="branch.name"/></td>
                                    </tr>                                     
                                    <tr>
                                        <td><label>Transaction Amount</label></td>
                                        <td><g:formatNumber format="###,###,##0.00" number="${txnFileInstance?.txnAmt}"/></td>
                                    </tr>

                                    <tr>
                                        <td><label>Transaction Code</label></td>
                                        <td><g:fieldValue bean="${txnFileInstance}" field="txnCode"/></td>
                                    </tr>
                                    <tr>
                                        <td><label>Transaction Template</label></td>
                                        <td><g:fieldValue bean="${txnFileInstance}" field="txnTemplate.description"/></td>
                                    </tr>                                      
                                    <tr>
                                        <td><label>Transaction Description</label></td>
                                        <td><g:fieldValue bean="${txnFileInstance}" field="txnDescription"/></td>
                                    </tr>  
                                    <tr>
                                        <td><label>Reference</label></td>
                                        <td><g:fieldValue bean="${txnFileInstance}" field="txnRef"/></td>
                                    </tr>
                                    <tr>
                                        <td><label>Particulars</label></td>
                                        <td><g:fieldValue bean="${txnFileInstance}" field="txnParticulars"/></td>
                                    </tr>
                                    <tr>
                                        <td><label>Status</label></td>
                                        <td><g:fieldValue bean="${txnFileInstance}" field="status.description"/> </td>
                                    </tr>
                                    <tr>
                                        <td><label>User</label></td>
                                        <td><g:fieldValue bean="${txnFileInstance}" field="user.username"/></td>
                                    </tr>                                    
                            </table>


                        </div>
                    </div>

                </div>
            </div>
    <script>
        function asd(){
            var w = window.open("${g.createLink(controller: 'tellering', action: 'printValidationSlip', params: [txnFile:txnFileInstance.id])}",'_blank');
            w.print();        
            }
        function genReportTLR001(){
                        reportlink = "${icbs.admin.Institution.get(94).paramValue}${icbs.admin.Report.get(20).baseParams}&output=${icbs.admin.Report.get(20).outputParam}";
                        reportlink = reportlink + "&reportUnit=${icbs.admin.Report.get(20).reportUnit}";             
                        reportlink = reportlink + "&txn_file_id_for_cashbreakdown=${txnFileInstance.id}";
                        reportlink = reportlink + "&generatedby=${icbs.admin.UserMaster.get(session.user_id).username}";
                        sendtojasperver(reportlink);
                    }
                    
        function genReportTSLP001(){
                        reportlink = "${icbs.admin.Institution.get(94).paramValue}${icbs.admin.Report.get(62).baseParams}&output=${icbs.admin.Report.get(62).outputParam}";
                        reportlink = reportlink + "&reportUnit=${icbs.admin.Report.get(62).reportUnit}";             
                        reportlink = reportlink + "&txn_file_id=${txnFileInstance.id}";
                        reportlink = reportlink + "&generatedby=${icbs.admin.UserMaster.get(session.user_id).username}";
                        sendtojasperver(reportlink);
                    }
    </script>
    <script>
        function txnslip(){
            var w = window.open("${g.createLink(controller: 'tellering', action: 'printTransactionSlip', params: [txnFile:txnFileInstance.id])}",'_blank');
            w.print();        
            }
    </script>
            <g:if test="${print=='PrintValidation-PrintTransactionSlip-PrintPassbook'}">
                <div id="SlipTransaction" class="alert alert-success alert-dismissable" role="alert">
                   <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <div> 
                            <a onclick="javascript:asd()">
                                <g:img dir="images" file="validate.png" width="35" height="35"/>
                                Validation Slip
                            </a>
                            &nbsp;&nbsp;
                            <a onclick="javascript:genReportTSLP001()">
                                <g:img dir="images" file="transactionslip.png" width="35" height="35"/>
                                 Transaction Slip1
                            </a>
                            &nbsp;&nbsp;
                            
                            <a onclick="
                               <%-- if ($('#passbookline').val() == 1 && $('#id').val() != $('#jrxmlTcId').val() ) {
                                    alertify.confirm(AppTitle,'Passbook page reach the maximum line, turn to next page.',
                                    function(){
                                    var w = window.open('printPassbookTransactions', '_blank');
                                        w.print(); 
                                    },
                                function(){return;});
                                }
                                --%>
                            
                                else {
                                     var w = window.open('printPassbookTransactions', '_blank');
                                    w.print(); 
                                }
                                ">
                                 <g:img dir="images" file="passbook-icon.jpg" width="35" height="35"/>
                                 <g:link action="printPassbookTransactions" params="${[txnId: txnFileInstance.id]}">Passbook</g:link>
                            </a>
                            
                            <p><input id="passbookline"  name="passbookline" required="" value="${passbookline}" style="display:none"/></p>
                            <p><input id="id"  name="id" required="" value="${id}" style="display:none"/></p>
                            <p><input id="jrxmlTcId"  name="jrxmlTcId" required="" value="${jrxmlTcId}" style="display:none"/></p>
                        </div>   
                </div>                
            </g:if>                    
            <g:if test="${print=='PrintValidation-PrintTransactionSlip'}">
                <div id="SlipTransaction" class="alert alert-success alert-dismissable" role="alert">
                   <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <div> 
                            <a onclick="javascript:asd()">
                                <g:img dir="images" file="validate.png" width="35" height="35"/>
                                Validation Slip
                            </a>
                            &nbsp;&nbsp;
                            <a onclick="javascript:txnslip()">
                                <g:img dir="images" file="transactionslip.png" width="35" height="35"/>
                                 Transaction Slip
                            </a>
                            &nbsp;&nbsp;
                            <p><input id="passbookline"  name="passbookline" required="" value="${passbookline}" style="display:none"/></p>
                            <p><input id="id"  name="id" required="" value="${id}" style="display:none"/></p>
                            <p><input id="jrxmlTcId"  name="jrxmlTcId" required="" value="${jrxmlTcId}" style="display:none"/></p>
                        </div>   
                </div>                
            </g:if>
            <g:if test="${print=='PrintValidation'}">
                <div id="SlipTransaction" class="alert alert-success alert-dismissable" role="alert">
                   <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <div> 
                            <a onclick="javascript:asd()">
                                <g:img dir="images" file="validate.png" width="35" height="35"/>
                                Validation Slip
                            </a>
                            <g:if test="${txnFileInstance?.txnTypeId==1 || txnFileInstance?.txnTypeId==2 || txnFileInstance?.txnTypeId==23}">
                                <a onclick="javascript:genReportTLR001()">
                                    <g:img dir="images" file="validate.png" width="35" height="35"/>
                                    Cash Transfer Slip
                                </a>
                            </g:if>
                            &nbsp;&nbsp;
                            <p><input id="passbookline"  name="passbookline" required="" value="${passbookline}" style="display:none"/></p>
                            <p><input id="id"  name="id" required="" value="${id}" style="display:none"/></p>
                            <p><input id="jrxmlTcId"  name="jrxmlTcId" required="" value="${jrxmlTcId}" style="display:none"/></p>
                        </div>   
                </div>                 
            </g:if>    

        </content>
        
        <content tag="main-actions">
            <ul>
                <li><g:link action="createTellerCashFromVaultTxn">Receive Cash from Vault</g:link></li>
                <li><g:link action="createTellerCashTransferTxn">Teller Cash Transfer</g:link></li>
                <li><g:link action="createTellerCheckToCOCITxn">Checks to COCI</g:link></li>
                <li><g:link action="createTellerCashToVaultTxn">Cash to Vault</g:link></li>
                <li><g:link action="createTellerCashDepositTxn">Cash Deposit</g:link></li>
                <li><g:link action="createTellerCheckDepositTxn">Check Deposit</g:link></li>
                <li><g:link action="createTellerCashWithdrawalTxn">Cash Withdrawal</g:link></li>
                <li><g:link action="createTellerCheckEncashmentTxn">Check Encashment</g:link></li>
                <li><g:link action="createTellerFDInterestWithdrawalTxn">FD Interest Withdrawal</g:link></li>
                <li><g:link action="createTellerFDPreTerminationTxn">FD Pre-Termination</g:link></li>
                <li><g:link action="createTellerLoanCashRepaymentTxn">Loan Cash Payment</g:link></li>
                <li><g:link action="createTellerLoanCheckRepaymentTxn">Loan Check Payment</g:link></li>
                <li><g:link action="createTellerLoanCashSpecifiedRepaymentTxn">Loan Cash Specified Payment</g:link></li>
                <li><g:link action="createTellerLoanCheckSpecifiedRepaymentTxn">Loan Check Specified Payment</g:link></li>
                <li><g:link action="createTellerLoanProceedsDisbursementTxn">Loan Proceeds Disbursement</g:link></li>
                <li><g:link action="createTellerOtherCashReceiptRemittanceTxn">Other Cash Receipt - Remittance</g:link></li>
                <li><g:link action="createTellerOtherCashReceiptBillsPaymentTxn">Other Cash Receipt - Bills Payment</g:link></li>
                <li><g:link action="createTellerOtherCashReceiptAdjustmentTxn">Other Cash Receipt - General</g:link></li>
                <li><g:link action="createTellerOtherCheckReceiptRemittanceTxn">Other Check Receipt - Remittance</g:link></li>
                <li><g:link action="createTellerOtherCheckReceiptBillsPaymentTxn">Other Check Receipt - Bills Payment</g:link></li>
                <li><g:link action="createTellerOtherCheckReceiptAdjustmentTxn">Other Check Receipt - General</g:link></li>
                <li><g:link action="createTellerOtherCashPaymentRemittanceTxn">Other Cash Payment - Remittance</g:link></li>
                <li><g:link action="createTellerOtherCashPaymentAdjustmentTxn">Other Cash Payment - General</g:link></li>
                <li><g:link action="viewTellerReverseCancelTxn">Reverse/Cancel Transaction</g:link></li>
            </ul>                                        
        </content>
    </body>
</html>
