
<%@ page import="icbs.tellering.TxnBreakdown" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'transactionBreakdown.label', default: 'TxnBreakdown')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
            <content tag="main-content">   
		<div id="show-transactionBreakdown" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list transactionBreakdown">
			
				<g:if test="${transactionBreakdownInstance?.debitAcct}">
				<li class="fieldcontain">
					<span id="debitAcct-label" class="property-label"><g:message code="transactionBreakdown.debitAcct.label" default="Debit Acct" /></span>
					
						<span class="property-value" aria-labelledby="debitAcct-label"><g:fieldValue bean="${transactionBreakdownInstance}" field="debitAcct"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${transactionBreakdownInstance?.creditAcct}">
				<li class="fieldcontain">
					<span id="creditAcct-label" class="property-label"><g:message code="transactionBreakdown.creditAcct.label" default="Credit Acct" /></span>
					
						<span class="property-value" aria-labelledby="creditAcct-label"><g:fieldValue bean="${transactionBreakdownInstance}" field="creditAcct"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${transactionBreakdownInstance?.debitAmt}">
				<li class="fieldcontain">
					<span id="debitAmt-label" class="property-label"><g:message code="transactionBreakdown.debitAmt.label" default="Debit Amt" /></span>
					
						<span class="property-value" aria-labelledby="debitAmt-label"><g:fieldValue bean="${transactionBreakdownInstance}" field="debitAmt"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${transactionBreakdownInstance?.creditAmt}">
				<li class="fieldcontain">
					<span id="creditAmt-label" class="property-label"><g:message code="transactionBreakdown.creditAmt.label" default="Credit Amt" /></span>
					
						<span class="property-value" aria-labelledby="creditAmt-label"><g:fieldValue bean="${transactionBreakdownInstance}" field="creditAmt"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${transactionBreakdownInstance?.txnDate}">
				<li class="fieldcontain">
					<span id="txnDate-label" class="property-label"><g:message code="transactionBreakdown.txnDate.label" default="Txn Date" /></span>
					
						<span class="property-value" aria-labelledby="txnDate-label"><g:formatDate date="${transactionBreakdownInstance?.txnDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${transactionBreakdownInstance?.currency}">
				<li class="fieldcontain">
					<span id="currency-label" class="property-label"><g:message code="transactionBreakdown.currency.label" default="Currency" /></span>
					
						<span class="property-value" aria-labelledby="currency-label"><g:link controller="currency" action="show" id="${transactionBreakdownInstance?.currency?.id}">${transactionBreakdownInstance?.currency?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:transactionBreakdownInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${transactionBreakdownInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
            </content>
             <content tag="main-actions">
                <ul>
                    <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                    <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                    <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
		</ul>
            </content>
	</body>
</html>
