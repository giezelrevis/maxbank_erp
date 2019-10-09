
<%@ page import="icbs.admin.GlConfigSettings" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'glConfigSettings.label', default: 'GlConfigSettings')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
            <content tag="main-content">   
		<div id="show-glConfigSettings" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list glConfigSettings">
			
				<g:if test="${glConfigSettingsInstance?.currency}">
				<li class="fieldcontain">
					<span id="currency-label" class="property-label"><g:message code="glConfigSettings.currency.label" default="Currency" /></span>
					
						<span class="property-value" aria-labelledby="currency-label"><g:link controller="currency" action="show" id="${glConfigSettingsInstance?.currency?.id}">${glConfigSettingsInstance?.currency?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${glConfigSettingsInstance?.revaluationPolicy}">
				<li class="fieldcontain">
					<span id="revaluationPolicy-label" class="property-label"><g:message code="glConfigSettings.revaluationPolicy.label" default="Revaluation Policy" /></span>
					
						<span class="property-value" aria-labelledby="revaluationPolicy-label"><g:fieldValue bean="${glConfigSettingsInstance}" field="revaluationPolicy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${glConfigSettingsInstance?.taxMonthEnd}">
				<li class="fieldcontain">
					<span id="taxMonthEnd-label" class="property-label"><g:message code="glConfigSettings.taxMonthEnd.label" default="Tax Month End" /></span>
					
						<span class="property-value" aria-labelledby="taxMonthEnd-label"><g:fieldValue bean="${glConfigSettingsInstance}" field="taxMonthEnd"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${glConfigSettingsInstance?.errorAcct}">
				<li class="fieldcontain">
					<span id="errorAcct-label" class="property-label"><g:message code="glConfigSettings.errorAcct.label" default="Error Acct" /></span>
					
						<span class="property-value" aria-labelledby="errorAcct-label"><g:link controller="glAccount" action="show" id="${glConfigSettingsInstance?.errorAcct?.id}">${glConfigSettingsInstance?.errorAcct?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:glConfigSettingsInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${glConfigSettingsInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
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
