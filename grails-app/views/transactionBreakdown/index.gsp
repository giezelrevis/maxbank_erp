
<%@ page import="icbs.tellering.TxnBreakdown" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'transactionBreakdown.label', default: 'TxnBreakdown')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
            <content tag="main-content">   
		<div id="list-transactionBreakdown" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
                        <g:form>
                            <div class="input-group">
                                <g:select name="max" value="${params.max}" from="[10, 20, 30, 40]" class="form-control input-sm pull-left"onchange="this.form.submit()" />
                            </div>
                            <div class="input-group">
                                <g:textField  type="text" name="query" class="form-control input-sm pull-right" style="width: 150px;" placeholder="Search"/>
                                <div class="input-group-btn">
                                    <g:submitButton name="search" class="btn btn-sm btn-default"><i class="fa fa-search"></i></g:submitButton>
                                </div>
                            </div>
                        </g:form>
			<div class="table-responsive">
                            <table class="table table-hover table-condensed table-bordered table-striped">
                                <thead>
					<tr>
					
						<g:sortableColumn property="debitAcct" title="${message(code: 'transactionBreakdown.debitAcct.label', default: 'Debit Acct')}" />
					
						<g:sortableColumn property="creditAcct" title="${message(code: 'transactionBreakdown.creditAcct.label', default: 'Credit Acct')}" />
					
						<g:sortableColumn property="debitAmt" title="${message(code: 'transactionBreakdown.debitAmt.label', default: 'Debit Amt')}" />
					
						<g:sortableColumn property="creditAmt" title="${message(code: 'transactionBreakdown.creditAmt.label', default: 'Credit Amt')}" />
					
						<g:sortableColumn property="txnDate" title="${message(code: 'transactionBreakdown.txnDate.label', default: 'Txn Date')}" />
					
						<th><g:message code="transactionBreakdown.currency.label" default="Currency" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${transactionBreakdownInstanceList}" status="i" var="transactionBreakdownInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${transactionBreakdownInstance.id}">${fieldValue(bean: transactionBreakdownInstance, field: "debitAcct")}</g:link></td>
					
						<td>${fieldValue(bean: transactionBreakdownInstance, field: "creditAcct")}</td>
					
						<td>${fieldValue(bean: transactionBreakdownInstance, field: "debitAmt")}</td>
					
						<td>${fieldValue(bean: transactionBreakdownInstance, field: "creditAmt")}</td>
					
						<td><g:formatDate date="${transactionBreakdownInstance.txnDate}" /></td>
					
						<td>${fieldValue(bean: transactionBreakdownInstance, field: "currency")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${TransactionBreakdownInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                    <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
		</ul>
            </content>
	</body>
</html>
