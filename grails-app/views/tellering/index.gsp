<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>
    <title>Teller Transactions</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="main">
  </head>
  <body>
    <content tag="main-content">
        <g:if test="${flash.message}">
            <script>
                 $(function(){
                notify.message("${flash.message}");
                });
            </script>
            
            <!-- div class="box-body">
                    <div class="alert alert-success alert-dismissable" role="alert">
                        <div class="message" role="status">
                            <i class="fa fa-ban"></i>
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                            <strong>${flash.message}</strong>
                        </div>
                    </div>            
            </div -->
        </g:if>
        
        <ul>

<div class="row">
    <div class="col-md-6">
        <table class="table table-hover table-condensed table-bordered table-striped">
                <legend class="section-header">Teller Cash/Vault</legend>
                <tr><td><strong><g:link action="createTellerCashFromVaultTxn">Receive Cash from Vault</g:link></strong></td></tr>
                <tr><td><strong><g:link action="createTellerCashTransferTxn">Teller Cash Transfer</g:link></strong></td></tr>
                <tr><td><strong><g:link action="createTellerCheckToCOCITxn">Checks to COCI</g:link></strong></td></tr>
                <tr><td><strong><g:link action="createTellerCashToVaultTxn">Cash to Vault</g:link></strong></td></tr>
                
        </table>
    </div>
        
    <div class="col-md-6">
        <table class="table table-hover table-condensed table-bordered table-striped">
                <legend class="section-header">Others</legend>
                <!-- <tr><td><strong><g:link action="viewTxnSummary">View Transaction Summary</g:link></strong></td></tr> -->
                <tr><td><strong><g:link action="viewTellerTxnInquiry">Find Transaction</g:link></strong></td></tr>
                <tr><td><strong><g:link action="viewTellerReverseCancelTxn">Reverse/Cancel Transaction</g:link></strong></td></tr>
                <tr><td><strong><g:link action="createTellerReprintPassbook">Re-print Passbook</g:link></strong></td></tr>
                <tr><td><strong><g:link action="createUpdatePassbook">Update Passbook</g:link></strong></td></tr> 
        </table>
    </div>
</div>

 <div class="col-md-6">
        <table class="table table-hover table-condensed table-bordered table-striped">     
                <legend class="section-header">Account Cash/Check Transactions</legend>
                <tr><td><strong><g:link action="createTellerCashDepositTxn">Cash Deposit</g:link></strong></td></tr>
                <tr><td><strong><g:link action="createTellerCheckDepositTxn">Check Deposit</g:link></strong></td></tr>
                <tr><td><strong><g:link action="createTellerCashWithdrawalTxn">Cash Withdrawal</g:link></strong></td></tr>
                <tr><td><strong><g:link action="createTellerCheckEncashmentTxn">Check Encashment</g:link></strong></td></tr>
                <tr><td><strong><g:link action="createTellerFDInterestWithdrawalTxn">FD Interest Withdrawal</g:link></strong></td></tr>
                <tr><td><strong><g:link action="createTellerFDPreTerminationTxn">FD Pre-Termination</g:link></strong></td></tr>
                <tr><td><strong><g:link action="createTellerLoanCashRepaymentTxn">Loan Cash Payment</g:link></strong></td></tr>
                <tr><td><strong><g:link action="createTellerLoanCheckRepaymentTxn">Loan Check Payment</g:link></strong></td></tr>
                <tr><td><strong><g:link action="createTellerLoanCashSpecifiedRepaymentTxn">Loan Cash Specified Payment</g:link></strong></td></tr>
                <tr><td><strong><g:link action="createTellerLoanCheckSpecifiedRepaymentTxn">Loan Check Specified Payment</g:link></strong></td></tr>
                <tr><td><strong><g:link action="createTellerLoanProceedsDisbursementTxn">Loan Proceeds Disbursement</g:link></strong></td></tr> 
        </table>
    </div>

<div class="row">
    <div class="col-md-6">
        <table class="table table-hover table-condensed table-bordered table-striped">
                <legend class="section-header">Other Cash Transactions</legend>
                <%-- tr><td><strong><g:link action="">Forex Transaction</g:link></strong></td></tr --%>
                <tr><td><strong><g:link action="createTellerOtherCashReceiptRemittanceTxn">Other Cash Receipt - Remittance</g:link></strong></td></tr>
                <tr><td><strong><g:link action="createTellerOtherCashReceiptBillsPaymentTxn">Other Cash Receipt - Bills Payment</g:link></strong></td></tr>
                <tr><td><strong><g:link action="createTellerOtherCashReceiptAdjustmentTxn">Other Cash Receipt - General</g:link></strong></td></tr>
                <tr><td><strong><g:link action="createTellerOtherCheckReceiptRemittanceTxn">Other Check Receipt - Remittance</g:link></strong></td></tr>
                <tr><td><strong><g:link action="createTellerOtherCheckReceiptBillsPaymentTxn">Other Check Receipt - Bills Payment</g:link></strong></td></tr>
                <tr><td><strong><g:link action="createTellerOtherCheckReceiptAdjustmentTxn">Other Check Receipt - General</g:link></strong></td></tr>
                <tr><td><strong><g:link action="createTellerOtherCashPaymentRemittanceTxn">Other Cash Payment - Remittance</g:link></strong></td></tr>
                <tr><td><strong><g:link action="createTellerOtherCashPaymentAdjustmentTxn">Other Cash Payment - General</g:link></strong></td></tr>
        </table>
    </div>
    
   
</div>

     </ul>

    </content>
    
  </body>
</html>
