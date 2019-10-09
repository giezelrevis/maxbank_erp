<%@ page import="icbs.tellering.TxnFile" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <title>Transaction Cash Receive Success</title>
    </head>    
    <body>
        <content tag="main-content">

            <br> <br>
            
                    <script>
                            $(function(){
                                notify.message('Cash Transfer Successfully done!|success|alert');
                            });
                    </script>  
            <div class="row">
                <div class="form-horizontal">
                    <div class="col-md-8">
                        <div class="infowrap">
                            <table class="table table-bordered table-striped">
                                <legend class="section-header">Transaction Details</legend>
                                    <tr>
                                        <td> Transaction ID </td>
                                        <td>${txnFileInstance.id}</td>
                                    </tr>                                
                                    <tr>
                                        <td> Transaction Date </td>
                                        <td><g:formatDate  format="MM/dd/yyyy" date="${txnFileInstance?.txnDate}" /></td>
                                    </tr>
                                    <tr>
                                        <td> Transaction Type </td>
                                        <td><g:fieldValue bean="${txnFileInstance}" field="txnType.description"/></td>
                                    </tr>
                                    <tr>
                                        <td> Account Number </td>
                                        <td><g:fieldValue bean="${txnFileInstance}" field="acctNo"/></td>
                                    </tr>                                    
                                    <tr>
                                        <td> branch </td>
                                        <td><g:fieldValue bean="${txnFileInstance}" field="branch.name"/></td>
                                    </tr>                                     
                                    <tr>
                                        <td> Transaction Amount </td>
                                        <td><g:formatNumber format="###,###,##0.00" number="${txnFileInstance?.txnAmt}"/></td>
                                    </tr>

                                    <tr>
                                        <td> Transaction Code </td>
                                        <td><g:fieldValue bean="${txnFileInstance}" field="txnCode"/></td>
                                    </tr>
                                    <tr>
                                        <td> Transaction Template </td>
                                        <td><g:fieldValue bean="${txnFileInstance}" field="txnTemplate.description"/></td>
                                    </tr>                                      
                                    <tr>
                                        <td> Transaction Description </td>
                                        <td><g:fieldValue bean="${txnFileInstance}" field="txnDescription"/></td>
                                    </tr>  
                                    <tr>
                                        <td> Reference </td>
                                        <td><g:fieldValue bean="${txnFileInstance}" field="txnRef"/></td>
                                    </tr>
                                    <tr>
                                        <td> Particulars </td>
                                        <td><g:fieldValue bean="${txnFileInstance}" field="txnParticulars"/></td>
                                    </tr>
                                    <tr>
                                        <td> Status </td>
                                        <td><g:fieldValue bean="${txnFileInstance}" field="status.description"/> </td>
                                    </tr>
                                    <tr>
                                        <td> User </td>
                                        <td><g:fieldValue bean="${txnFileInstance}" field="user.username"/></td>
                                    </tr>                                    
                            </table>


                        </div>
                    </div>

                </div>
            </div>
                    <script>
                            function asd(){
                                var w = window.open("${g.createLink(controller: 'tellering', action: 'printValidationSlip', params: [txnFile:session.transactionFileId])}",'_blank');
                                w.print();        
                                }
                     </script>

                    <div id="SlipTransaction" class="alert alert-success alert-dismissable" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                            <div> 
                                <a onclick="javascript:asd()">
                                <g:img dir="images" file="validate.png" width="35" height="35"/>
                                Validation Slip
                                </a>
                            </div>   
                    </div>   

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
