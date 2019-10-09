
<%@ page import="icbs.admin.PolicyException" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'policyException.label', default: 'PolicyException')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
            <content tag="breadcrumbs">
		<span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/policyException')}">Policy Exception List</a>
                <span class="fa fa-chevron-right"></span><span class="current">Policy Exception Information</span>
	    </content>
            <content tag="main-content">   
		<div id="show-policyException" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list policyException">
			
				<g:if test="${policyExceptionInstance?.approvingUser}">
				<li class="fieldcontain">
					<span id="approvingUser-label" class="property-label"><g:message code="policyException.approvingUser.label" default="Approving User" /></span>
					<span class="property-value" aria-labelledby="approvingUser-label"><g:link controller="userMaster" action="show" id="${policyExceptionInstance?.approvingUser?.id}">${policyExceptionInstance?.approvingUser?.encodeAsHTML()}</g:link></span>
				</li>
				</g:if>
			
				<g:if test="${policyExceptionInstance?.dateOfAction}">
				<li class="fieldcontain">
					<span id="dateOfAction-label" class="property-label"><g:message code="policyException.dateOfAction.label" default="Date Of Action" /></span>
					<span class="property-value" aria-labelledby="dateOfAction-label"><g:formatDate date="${policyExceptionInstance?.dateOfAction}" /></span>
				</li>
				</g:if>
			
				<g:if test="${policyExceptionInstance?.isApproved}">
				<li class="fieldcontain">
					<span id="isApproved-label" class="property-label"><g:message code="policyException.isApproved.label" default="Is Approved" /></span>
					<span class="property-value" aria-labelledby="isApproved-label"><g:formatBoolean boolean="${policyExceptionInstance?.isApproved}" /></span>
				</li>
				</g:if>
			
				<g:if test="${policyExceptionInstance?.dateOfRequest}">
				<li class="fieldcontain">
					<span id="dateOfRequest-label" class="property-label"><g:message code="policyException.dateOfRequest.label" default="Date Of Request" /></span>
					<span class="property-value" aria-labelledby="dateOfRequest-label"><g:formatDate date="${policyExceptionInstance?.dateOfRequest}" /></span>
				</li>
				</g:if>
			
				<g:if test="${policyExceptionInstance?.module}">
				<li class="fieldcontain">
					<span id="module-label" class="property-label"><g:message code="policyException.module.label" default="Module" /></span>
					<span class="property-value" aria-labelledby="module-label"><g:link controller="module" action="show" id="${policyExceptionInstance?.module?.id}">${policyExceptionInstance?.module?.encodeAsHTML()}</g:link></span>
				</li>
				</g:if>
			
				<g:if test="${policyExceptionInstance?.recordUrl}">
				<li class="fieldcontain">
					<span id="recordUrl-label" class="property-label"><g:message code="policyException.recordUrl.label" default="Record Url" /></span>
					<span class="property-value" aria-labelledby="recordUrl-label"><g:fieldValue bean="${policyExceptionInstance}" field="recordUrl"/></span>
				</li>
				</g:if>
			
				<g:if test="${policyExceptionInstance?.requestingUser}">
				<li class="fieldcontain">
					<span id="requestingUser-label" class="property-label"><g:message code="policyException.requestingUser.label" default="Requesting User" /></span>
					<span class="property-value" aria-labelledby="requestingUser-label"><g:link controller="userMaster" action="show" id="${policyExceptionInstance?.requestingUser?.id}">${policyExceptionInstance?.requestingUser?.encodeAsHTML()}</g:link></span>
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:policyExceptionInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${policyExceptionInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
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
