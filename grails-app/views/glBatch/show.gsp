
<%@ page import="icbs.gl.GlBatch" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'glBatch.label', default: 'General Ledger Batch')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
            <content tag="main-content">   
		<div id="show-glBatch" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list glBatch">
			
				<g:if test="${glBatchInstance?.amount}">
				<li class="fieldcontain">
					<span id="amount-label" class="property-label"><g:message code="glBatch.amount.label" default="Amount" /></span>
					
						<span class="property-value" aria-labelledby="amount-label"><g:formatNumber format="###,###,##0.00" number="${glBatchInstance?.amount}"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${glBatchInstance?.batchId}">
				<li class="fieldcontain">
					<span id="batchId-label" class="property-label"><g:message code="glBatch.batchId.label" default="Batch Id" /></span>
					
						<span class="property-value" aria-labelledby="batchId-label"><g:fieldValue bean="${glBatchInstance}" field="batchId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${glBatchInstance?.batchType}">
				<li class="fieldcontain">
					<span id="batchType-label" class="property-label"><g:message code="glBatch.batchType.label" default="Batch Type" /></span>
					
						<span class="property-value" aria-labelledby="batchType-label"><g:fieldValue bean="${glBatchInstance}" field="batchType"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${glBatchInstance?.creditGL}">
				<li class="fieldcontain">
					<span id="creditGL-label" class="property-label"><g:message code="glBatch.creditGL.label" default="Credit GL" /></span>
					
						<span class="property-value" aria-labelledby="creditGL-label"><g:link controller="glAccount" action="show" id="${glBatchInstance?.creditGL?.id}">${glBatchInstance?.creditGL?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${glBatchInstance?.debitGl}">
				<li class="fieldcontain">
					<span id="debitGl-label" class="property-label"><g:message code="glBatch.debitGl.label" default="Debit Gl" /></span>
					
						<span class="property-value" aria-labelledby="debitGl-label"><g:link controller="glAccount" action="show" id="${glBatchInstance?.debitGl?.id}">${glBatchInstance?.debitGl?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${glBatchInstance?.lineNo}">
				<li class="fieldcontain">
					<span id="lineNo-label" class="property-label"><g:message code="glBatch.lineNo.label" default="Line No" /></span>
					
						<span class="property-value" aria-labelledby="lineNo-label"><g:fieldValue bean="${glBatchInstance}" field="lineNo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${glBatchInstance?.lineStatus}">
				<li class="fieldcontain">
					<span id="lineStatus-label" class="property-label"><g:message code="glBatch.lineStatus.label" default="Line Status" /></span>
					
						<span class="property-value" aria-labelledby="lineStatus-label"><g:fieldValue bean="${glBatchInstance}" field="lineStatus"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${glBatchInstance?.particulars}">
				<li class="fieldcontain">
					<span id="particulars-label" class="property-label"><g:message code="glBatch.particulars.label" default="Particulars" /></span>
					
						<span class="property-value" aria-labelledby="particulars-label"><g:fieldValue bean="${glBatchInstance}" field="particulars"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${glBatchInstance?.recordDate}">
				<li class="fieldcontain">
					<span id="recordDate-label" class="property-label"><g:message code="glBatch.recordDate.label" default="Record Date" /></span>
					
						<span class="property-value" aria-labelledby="recordDate-label"><g:formatDate date="${glBatchInstance?.recordDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${glBatchInstance?.reference}">
				<li class="fieldcontain">
					<span id="reference-label" class="property-label"><g:message code="glBatch.reference.label" default="Reference" /></span>
					
						<span class="property-value" aria-labelledby="reference-label"><g:fieldValue bean="${glBatchInstance}" field="reference"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${glBatchInstance?.txnType}">
				<li class="fieldcontain">
					<span id="txnType-label" class="property-label"><g:message code="glBatch.txnType.label" default="Txn Type" /></span>
					
						<span class="property-value" aria-labelledby="txnType-label"><g:fieldValue bean="${glBatchInstance}" field="txnType"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:glBatchInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${glBatchInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
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
