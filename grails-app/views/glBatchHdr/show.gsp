
<%@ page import="icbs.gl.GlBatchHdr" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'glBatchHdr.label', default: 'GlBatchHdr')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
            <content tag="main-content">   
		<div id="show-glBatchHdr" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list glBatchHdr">
			
				<g:if test="${glBatchHdrInstance?.contraGl}">
				<li class="fieldcontain">
					<span id="contraGl-label" class="property-label"><g:message code="glBatchHdr.contraGl.label" default="Contra Gl" /></span>
					
						<span class="property-value" aria-labelledby="contraGl-label"><g:link controller="glAccount" action="show" id="${glBatchHdrInstance?.contraGl?.id}">${glBatchHdrInstance?.contraGl?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${glBatchHdrInstance?.errorGl}">
				<li class="fieldcontain">
					<span id="errorGl-label" class="property-label"><g:message code="glBatchHdr.errorGl.label" default="Error Gl" /></span>
					
						<span class="property-value" aria-labelledby="errorGl-label"><g:link controller="glAccount" action="show" id="${glBatchHdrInstance?.errorGl?.id}">${glBatchHdrInstance?.errorGl?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${glBatchHdrInstance?.batchType}">
				<li class="fieldcontain">
					<span id="batchType-label" class="property-label"><g:message code="glBatchHdr.batchType.label" default="Batch Type" /></span>
					
						<span class="property-value" aria-labelledby="batchType-label"><g:fieldValue bean="${glBatchHdrInstance}" field="batchType"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${glBatchHdrInstance?.batchParticulars}">
				<li class="fieldcontain">
					<span id="batchParticulars-label" class="property-label"><g:message code="glBatchHdr.batchParticulars.label" default="Batch Particulars" /></span>
					
						<span class="property-value" aria-labelledby="batchParticulars-label"><g:fieldValue bean="${glBatchHdrInstance}" field="batchParticulars"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${glBatchHdrInstance?.loanAcct}">
				<li class="fieldcontain">
					<span id="loanAcct-label" class="property-label"><g:message code="glBatchHdr.loanAcct.label" default="Loan Acct" /></span>
					
						<span class="property-value" aria-labelledby="loanAcct-label"><g:link controller="loan" action="show" id="${glBatchHdrInstance?.loanAcct?.id}">${glBatchHdrInstance?.loanAcct?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${glBatchHdrInstance?.txnType}">
				<li class="fieldcontain">
					<span id="txnType-label" class="property-label"><g:message code="glBatchHdr.txnType.label" default="Txn Type" /></span>
					
						<span class="property-value" aria-labelledby="txnType-label"><g:fieldValue bean="${glBatchHdrInstance}" field="txnType"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${glBatchHdrInstance?.batchCurrency}">
				<li class="fieldcontain">
					<span id="batchCurrency-label" class="property-label"><g:message code="glBatchHdr.batchCurrency.label" default="Batch Currency" /></span>
					
						<span class="property-value" aria-labelledby="batchCurrency-label"><g:link controller="currency" action="show" id="${glBatchHdrInstance?.batchCurrency?.id}">${glBatchHdrInstance?.batchCurrency?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${glBatchHdrInstance?.batchId}">
				<li class="fieldcontain">
					<span id="batchId-label" class="property-label"><g:message code="glBatchHdr.batchId.label" default="Batch Id" /></span>
					
						<span class="property-value" aria-labelledby="batchId-label"><g:fieldValue bean="${glBatchHdrInstance}" field="batchId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${glBatchHdrInstance?.batchName}">
				<li class="fieldcontain">
					<span id="batchName-label" class="property-label"><g:message code="glBatchHdr.batchName.label" default="Batch Name" /></span>
					
						<span class="property-value" aria-labelledby="batchName-label"><g:fieldValue bean="${glBatchHdrInstance}" field="batchName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${glBatchHdrInstance?.branch}">
				<li class="fieldcontain">
					<span id="branch-label" class="property-label"><g:message code="glBatchHdr.branch.label" default="Branch" /></span>
					
						<span class="property-value" aria-labelledby="branch-label"><g:link controller="branch" action="show" id="${glBatchHdrInstance?.branch?.id}">${glBatchHdrInstance?.branch?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${glBatchHdrInstance?.isBalanced}">
				<li class="fieldcontain">
					<span id="isBalanced-label" class="property-label"><g:message code="glBatchHdr.isBalanced.label" default="Is Balanced" /></span>
					
						<span class="property-value" aria-labelledby="isBalanced-label"><g:formatBoolean boolean="${glBatchHdrInstance?.isBalanced}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${glBatchHdrInstance?.isLocked}">
				<li class="fieldcontain">
					<span id="isLocked-label" class="property-label"><g:message code="glBatchHdr.isLocked.label" default="Is Locked" /></span>
					
						<span class="property-value" aria-labelledby="isLocked-label"><g:formatBoolean boolean="${glBatchHdrInstance?.isLocked}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${glBatchHdrInstance?.totalCredit}">
				<li class="fieldcontain">
					<span id="totalCredit-label" class="property-label"><g:message code="glBatchHdr.totalCredit.label" default="Total Credit" /></span>
					
						<span class="property-value" aria-labelledby="totalCredit-label"><g:formatNumber format="###,###,##0.00" number="${glBatchHdrInstance?.totalCredit}"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${glBatchHdrInstance?.totalDebit}">
				<li class="fieldcontain">
					<span id="totalDebit-label" class="property-label"><g:message code="glBatchHdr.totalDebit.label" default="Total Debit" /></span>
					
						<span class="property-value" aria-labelledby="totalDebit-label"><g:formatNumber format="###,###,##0.00" number="${glBatchHdrInstance?.totalDebit}"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:glBatchHdrInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${glBatchHdrInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
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
