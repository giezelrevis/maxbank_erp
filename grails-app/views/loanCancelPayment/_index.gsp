
<%@ page import="icbs.tellering.TxnLoanPaymentDetails" %>
<!DOCTYPE html>
<html>
    <head>
	<meta name="layout" content="main">
	<g:set var="entityName" value="${message(code: 'TxnLoanPaymentDetails.label', default: 'Loan Payments')}" />
	<title>Reverse Loan Payment</title>
    </head>
    <body>
        <content tag="main-content">   
            <div id="list-loanLedger" class="content scaffold-list" role="main">
		<g:if test="${flash.message}">
                    <div class="box-body">
                        <div class="alert alert-info alert-dismissable">
                            <i class="fa fa-info"></i>
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                            <b>Message</b> <div class="message" role="status">${flash.message}</div>
                        </div>
                    </div>
                </g:if>
                <g:form>            	
                    <div class="row">
                        <div class="col-md-12">
                            <div class="col-md-2">
				<g:select name="max" value="${params.max}" from="[25, 50, 75, 100]" class="form-control input-sm" onchange="this.form.submit()" />
                            </div>
				        
                            <div class="input-group col-md-10">
				<g:textField  type="text" name="query" class="form-control" placeholder="Enter Search value"/>
                                <div class="input-group-btn">
                                    <g:submitButton name="Search" class="btn btn-primary"></g:submitButton>
                                </div>
                            </div>
                        </div>
                    </div>	
                </g:form> 

		<div class="table-responsive">
                    <table class="table table-hover table-condensed table-bordered table-striped">
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
                    <g:paginate total="${txnLoanPaymentDetailInstanceCount ?: 0}" params="${params}" />
		</div>
            </div>
	</content>
	<content tag="main-actions">
	    <ul>
	        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
            </ul>
        </content>
    </body>
</html>
