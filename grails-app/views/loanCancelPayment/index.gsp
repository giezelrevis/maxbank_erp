
<%@ page import="icbs.tellering.TxnLoanPaymentDetails" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'TxnLoanPaymentDetails.label', default: 'Loan Payments')}" />
		<title>Reverse Loan Payment</title>
	</head>
	<body>
		<content tag="breadcrumbs">
          <span class="fa fa-chevron-right"></span><span class="current">RLP</span>
		</content>

            <content tag="main-content">   
		<div id="list-loanLedger" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>

            <g:form class="form-inline">
				<div class="form-group">
					<g:select name="max" value="${params.max}" from="[5, 10, 15, 20]" class="form-control input-sm pull-left"onchange="this.form.submit()" />
				</div>
				<div class="right">
					<div class="form-group">
						<g:textField  type="text" name="query" class="form-control input-sm pull-right" style="width: 150px;" placeholder="Search"/>
					</div>
					<g:submitButton name="Search" class="btn btn-sm btn-default"><i class="fa fa-search"></i></g:submitButton>
				</div>
			</g:form>
			
			<div class="table-responsive">
            <table class="table table-bordered table-rounded table-striped table-hover">
                <thead>
                            <tr>
                                <g:sortableColumn property="id" title="Txn ID" />
                                <g:sortableColumn property="loan.accountNo" title="Loan Account" />
                                <g:sortableColumn property="loan.customer.displayName" title="Borrower's Name" />
                                <g:sortableColumn property="txnFile.txnDate" title="Transaction Date" />
                                <g:sortableColumn property="txnFile.txnAmt" title="Transaction Amt" />
                                <g:sortableColumn property="txnRef" title="Transaction Reference" />
                                <td><label>Action</label></td>					
                            </tr>
				</thead>
				<tbody>
				<g:each in="${txnLoanPaymentDetailsInstanceList}" status="i" var="txnLoanPaymentDetailsInstance">
				<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                    <td align="right">${txnLoanPaymentDetailsInstance?.txnFile?.id}</td>
                                    <td>${txnLoanPaymentDetailsInstance?.acctNo}</td>	
                                    <td>${txnLoanPaymentDetailsInstance?.acct?.customer?.displayName}</td>	
                                    <td><g:formatDate format="MM/dd/yyyy" date="${txnLoanPaymentDetailsInstance?.txnDate}"/></td>
                                    <td align="right"><g:formatNumber format="###,###,##0.00" number="${txnLoanPaymentDetailsInstance?.txnFile?.txnAmt}" /></td>
                                    <td>${txnLoanPaymentDetailsInstance?.txnRef}</td>
                                    <td><g:link class="btn btn-secondary" action="reverseLoanPaymentTxn" id="${txnLoanPaymentDetailsInstance.id}">Reverse</g:link></td>
				</tr>
                            </g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${TxnLoanPaymentDetailsInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><g:link class="create" action="create">New/Update Payables</g:link></li>
				</ul>
            </content>
	</body>
</html>
