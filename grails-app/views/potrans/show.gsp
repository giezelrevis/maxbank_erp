
<%@ page import="accounting.bankpayables.AccountsPayables" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'accountsPayables.label', default: 'accountsPayables')}" />
		<title>AP Information</title>
	</head>
	<body>
		<content tag="breadcrumbs">
		  <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/potrans')}">AP Maintenance</a>
          <span class="fa fa-chevron-right"></span><span class="current">AP Information</span>
		</content>

            <content tag="main-content">   
		<div id="show-accountsPayables" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ul class="property-list accountsPayables">
			
				<g:if test="${accountsPayablesInstance?.reference}">
				<li class="fieldcontain">
					<span id="reference-label" class="property-label"><g:message code="payables.reference.label" default="Reference" /></span>
					
						<span class="property-value" aria-labelledby="reference-label"><g:fieldValue bean="${accountsPayablesInstance}" field="reference"/></span>
					
				</li>
				</g:if>

				<g:if test="${accountsPayablesInstance?.amount}">
				<li class="fieldcontain">
					<span id="amount-label" class="property-label"><g:message code="payables.amount.label" default="Amount" /></span>
					
						<span class="property-value" aria-labelledby="amount-label"><g:fieldValue bean="${accountsPayablesInstance}" field="amount"/></span>
					
				</li>
				</g:if>
			
			
			</ul>
			<g:form url="[resource:accountsPayablesInstance, action:'update']" method="PUT">
				<fieldset class="buttons">
				<g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.Disburse.label', default: 'Disburse')}" />
				</fieldset>
			</g:form>
		</div>
            </content>
             <content tag="main-actions">
<!--                 <ul>
                    <li><g:link class="create" action="create"><g:message code="default.newupdate.label" args="[entityName]" default="New AP" /></g:link></li>
                    <li><g:link action="edit" id="${accountsPayablesInstance.id}">Edit AP</g:link></li>
				</ul> -->
            </content>
	</body>
</html>
