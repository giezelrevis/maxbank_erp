
<%@ page import="icbs.tellering.TxnLoanPaymentDetails" %>

<!DOCTYPE html>
<html>
    <head>
	<meta name="layout" content="main">
	<g:set var="entityName" value="${message(code: 'txnLoanPaymentDetails.label', default: 'txnLoanPaymentDetails')}" />
	<title>Reverse Loan Payment</title>      
    </head>
    <body>
    <content tag="main-content">   
	<div id="show-txnLoanPaymentDetails" class="content scaffold-show" role="main">
            <g:if test="${flash.message}">
                <div class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div>               
            </g:if>
            
            <div class="col-md-12">  
                <div class="section-container">
                    <legend class="section-header">Loan Payment Transaction Details</legend>
                    <div class="fieldcontain form-group">
                        <dl class="dl-horizontal">
                            <dt>Loan Account</dt>
                            <dd><g:link action="show" controller="loan" id="${txnLoanPaymentDetailsInstance?.acct?.id}">${txnLoanPaymentDetailsInstance?.acct?.accountNo}</g:link></dd>
                        </dl>    
                        <dl class="dl-horizontal">
                            <dt>Borrower Name</dt>
                            <dd><g:link controller="customer" action="customerInquiry" id="${txnLoanPaymentDetailsInstance?.acct?.customer?.id}">${txnLoanPaymentDetailsInstance?.acct?.customer?.displayName}</g:link></dd>
                        </dl> 
                        <dl class="dl-horizontal">
                            <dt>Transaction ID</dt>
                            <dd>${txnLoanPaymentDetailsInstance?.txnFile?.id}</dd>
                        </dl> 
                        <dl class="dl-horizontal">
                            <dt>Transaction Reference</dt>
                            <dd>${txnLoanPaymentDetailsInstance?.txnRef}</dd>
                        </dl>      
                        <dl class="dl-horizontal">
                            <dt>Transaction Date</dt>
                            <dd><g:formatDate format="MM/dd/yyyy" date="${txnLoanPaymentDetailsInstance?.txnDate}"/></dd>
                        </dl>    
                        <dl class="dl-horizontal">
                            <dt>Transaction Amount</dt>
                             <dd><g:formatNumber format="###,###,##0.00" number="${txnLoanPaymentDetailsInstance?.txnFile?.txnAmt}" /></dd>
                        </dl>    
                        <dl class="dl-horizontal">
                            <dt>Principal Amount</dt>
                             <dd><g:formatNumber format="###,###,##0.00" number="${txnLoanPaymentDetailsInstance?.principalAmt}" /></dd>
                        </dl> 
                        <dl class="dl-horizontal">
                            <dt>Interest Amount</dt>
                             <dd><g:formatNumber format="###,###,##0.00" number="${txnLoanPaymentDetailsInstance?.interestAmt}" /></dd>
                        </dl> 
                        <dl class="dl-horizontal">
                            <dt>Penalty Amount</dt>
                             <dd><g:formatNumber format="###,###,##0.00" number="${txnLoanPaymentDetailsInstance?.penaltyAmt}" /></dd>
                        </dl>  
                        <dl class="dl-horizontal">
                            <dt>Service Charge Amount</dt>
                             <dd><g:formatNumber format="###,###,##0.00" number="${txnLoanPaymentDetailsInstance?.serviceChargeAmt}" /></dd>
                        </dl> 
                   </div>
                </div>
            </div>                    
        </div>
    </content>
    <content tag="main-actions">
        <ul>
            <li><g:link action="create">Reverse Loan Payment</g:link></li>
            <li><g:link action="index">Return to Index</g:link></li>
        </ul>
    </content>
</body>
</html>
