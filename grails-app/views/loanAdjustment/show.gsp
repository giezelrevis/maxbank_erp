<%@ page import="icbs.loans.LoanLedger" %>
<%@ page import="icbs.tellering.TxnBreakdown" %>
<%@ page import="icbs.gl.GlAccount" %>
<%@ page import="icbs.admin.Currency" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loanLedger.label', default: 'LoanLedger')}" />
		<title>View Loan Ledger Transaction Details</title>
              
	</head>
	<body>
        <content tag="main-content">   
		<div id="show-loanLedger" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
                <div class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div>
            </g:if>
                <g:textField name="loanid" id="loanid" value="${loanLedgerInstance?.loan?.id}"style="display:none"  />
                <div class="col-md-12">  
                    <div class="section-container">
                        <legend class="section-header" style="background-color: #00ace6;color: white;font-weight: bold;">Loan Ledger Details</legend>
                       
                         <table class="table table-bordered table-striped">
                            <tbody>
                               
                                <tr>
                                    <td style="font-weight:bold" width="30%">Loan Account</td>
                                    <td width="70%"><g:link action="show" controller="loan" id="${loanLedgerInstance?.loan?.id}">${loanLedgerInstance?.loan?.accountNo}</g:link></td>
                                </tr>
                                <tr>
                                    <td style="font-weight:bold" width="30%">Borrower Name</td>
                                    <td width="70%"><g:link controller="customer" action="customerInquiry" id="${loanLedgerInstance?.loan?.customer?.id}">${loanLedgerInstance?.loan?.customer?.displayName}</g:link></td>
                                </tr>
                                <g:if test="${loanLedgerInstance?.deposit}">
                                <tr>
                                    <td style="font-weight:bold" width="30%">Deposit Account</td>
                                    <td width="70%">${loanLedgerInstance?.deposit?.acctNo}</td>
                                </tr>
                                </g:if>
                                <tr>
                                    <td style="font-weight:bold" width="30%">Transaction ID</td>
                                    <td width="70%">${loanLedgerInstance?.txnFile?.id}</td>
                                </tr>
                                <tr>
                                    <td style="font-weight:bold" width="30%">Transaction Type</td>
                                    <td width="70%">${loanLedgerInstance?.txnType?.description}</td>
                                </tr>
                                <tr>
                                    <td style="font-weight:bold" width="30%">Transaction Code</td>
                                    <td width="70%">${loanLedgerInstance?.txnTemplate?.description}</td>
                                </tr>
                                <tr>
                                    <td style="font-weight:bold" width="30%">Transaction Reference</td>
                                    <td width="70%">${loanLedgerInstance?.txnRef}</td>
                                </tr>
                                <tr>
                                    <td style="font-weight:bold" width="30%">Transaction Particulars</td>
                                    <td width="70%">${loanLedgerInstance?.txnParticulars}</td>
                                </tr>
                                <tr>
                                    <td style="font-weight:bold" width="30%">Transaction Date</td>
                                    <td width="70%"><g:formatDate date="${loanLedgerInstance?.txnDate}" type="date" style="FULL"/></td>
                                </tr>
                                <tr>
                                    <td style="font-weight:bold" width="30%">Transaction Amount</td>
                                    <td width="70%"><g:formatNumber format="###,###,##0.00" number="${loanLedgerInstance?.txnFile?.txnAmt}" /></td>
                                </tr>
                            </tbody>
                        </table>    

                            </div>
                            <div class="section-container">
                                <legend class="section-header" style="background-color: #00ace6;color: white;font-weight: bold;">Loan Ledger Financial Details</legend>
                                <table class="table table-bordered table-striped">
                                    <tbody>
                                        <g:if test="${loanLedgerInstance?.principalDebit != 0}">
                                        <tr>
                                            <td style="font-weight:bold" width="30%">Principal Debit</td>
                                            <td width="70%"><g:formatNumber format="###,###,##0.00" number="${loanLedgerInstance?.principalDebit}" /></td>
                                        </tr>
                                        </g:if>
                                        <g:if test="${loanLedgerInstance?.principalCredit != 0}">
                                        <tr>
                                            <td style="font-weight:bold" width="30%">Principal Credit</td>
                                            <td width="70%"><g:formatNumber format="###,###,##0.00" number="${loanLedgerInstance?.principalCredit}" /></td>
                                        </tr>
                                        </g:if>
                                        <tr>
                                            <td style="font-weight:bold" width="30%">Principal Balance</td>
                                            <td width="70%"><g:formatNumber format="###,###,##0.00" number="${loanLedgerInstance?.principalBalance}" /></td>
                                        </tr>
                                        <g:if test="${loanLedgerInstance?.interestDebit != 0}">
                                        <tr>
                                            <td style="font-weight:bold" width="30%">Interest Debit</td>
                                            <td width="70%"><g:formatNumber format="###,###,##0.00" number="${loanLedgerInstance?.interestDebit}" /></td>
                                        </tr>
                                        </g:if>
                                        <g:if test="${loanLedgerInstance?.interestCredit != 0}">
                                        <tr>
                                            <td style="font-weight:bold" width="30%">Interest Credit</td>
                                            <td width="70%"><g:formatNumber format="###,###,##0.00" number="${loanLedgerInstance?.interestCredit}" /></td>
                                        </tr>
                                        </g:if>
                                         <tr>
                                            <td style="font-weight:bold" width="30%">Interest Balance</td>
                                            <td width="70%"><g:formatNumber format="###,###,##0.00" number="${loanLedgerInstance?.interestBalance}" /></td>
                                        </tr>
                                        <g:if test="${loanLedgerInstance?.penaltyDebit != 0}">
                                         <tr>
                                            <td style="font-weight:bold" width="30%">Penalty Debit</td>
                                            <td width="70%"><g:formatNumber format="###,###,##0.00" number="${loanLedgerInstance?.penaltyDebit}" /></td>
                                        </tr>
                                        </g:if>
                                        <g:if test="${loanLedgerInstance?.penaltyCredit != 0}">
                                         <tr>
                                            <td style="font-weight:bold" width="30%">Penalty Credit</td>
                                            <td width="70%"><g:formatNumber format="###,###,##0.00" number="${loanLedgerInstance?.penaltyCredit}" /></td>
                                        </tr>
                                        </g:if>
                                        <tr>
                                            <td style="font-weight:bold" width="30%">Penalty Balance</td>
                                            <td width="70%"><g:formatNumber format="###,###,##0.00" number="${loanLedgerInstance?.penaltyBalance}" /></td>
                                        </tr>
                                        <g:if test="${loanLedgerInstance?.chargesDebit != 0}">
                                        <tr>
                                            <td style="font-weight:bold" width="30%">Charges Debit</td>
                                            <td width="70%"><g:formatNumber format="###,###,##0.00" number="${loanLedgerInstance?.chargesDebit}" /></td>
                                        </tr>
                                        </g:if>
                                        <g:if test="${loanLedgerInstance?.chargesCredit != 0}">
                                        <tr>
                                            <td style="font-weight:bold" width="30%">Charges Credit</td>
                                            <td width="70%"><g:formatNumber format="###,###,##0.00" number="${loanLedgerInstance?.chargesCredit}" /></td>
                                        </tr>
                                        </g:if>
                                        <tr>
                                            <td style="font-weight:bold" width="30%">Charges Balance</td>
                                            <td width="70%"><g:formatNumber format="###,###,##0.00" number="${loanLedgerInstance?.chargesBalance}" /></td>
                                        </tr>
                                    </tbody>
                                </table>    
				
			</div>
                        <div class="section-container">
                            <legend class="section-header" style="background-color: #00ace6;color: white;font-weight: bold;">General Ledger Entries</legend>
                            <div class="table-responsive">
                                <table class="table table-hover table-condensed table-bordered table-striped">
                                <thead>
                                    <th><label>Debit</label></th>
                                    <th><label>Debit Amount</label></th>
                                    <th><label>Credit</label></th>
                                    <th><label>Credit Amount</label></th>
                                </thead>  
                                <tbody>
                                <g:each in="${TxnBreakdown.findAllByTxnFile(loanLedgerInstance?.txnFile)}" status="i" var="t">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        <td>${t.debitAcct}
                                            <g:if test="${t.debitAcct}">
                                            </br>    
                                            ${GlAccount.findByCodeAndBranchAndCurrencyAndFinancialYear(t.debitAcct,t.branch,Currency.get(1),t.branch.runDate.format("yyyy")).name}
                                            </g:if>
                                            </td>
                                        <td align="right"><g:formatNumber format="###,###,##0.00" number="${t.debitAmt}" /></td>
                                             
                                        <td>${t.creditAcct}
                                            <g:if test="${t.creditAcct}">
                                            </br>    
                                            ${GlAccount.findByCodeAndBranchAndCurrencyAndFinancialYear(t.creditAcct,t.branch,Currency.get(1),t.branch.runDate.format("yyyy")).name}
                                            </g:if>
                                            </td>
                                        <td align="right"><g:formatNumber format="###,###,##0.00" number="${t.creditAmt}" /></td>
                                   </tr>
                                </g:each>
                                </tbody>   
                            </table>     
                        </div>    
			<%--<g:form url="[controller:loanAdjustment, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" controller="loanAdjustment" id="${loanLedgerInstance.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>--%>
                    </div>                    
		</div>
        </content>
         <content tag="main-actions">
            <ul>
                <li><g:link action="create">New Loan Non-Cash Transaction</g:link></li>
                <!-- <li><g:link action="index">Search Loan Adjustment</g:link></li> -->
                <li><g:link target="_blank" controller="loanAdjustment" action="printValidation" > Validation Slip </g:link></li>
                <li><g:link action="index">Search Loan Non-Cash Transaction</g:link></li>
            </ul>
        </content>
	</body>
</html>
