
<%@ page import="icbs.admin.Report" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'report.label', default: 'Report')}" />
		<title>Report Information</title>
	</head>
	<body>
            <content tag="main-content">   
		<div id="show-report" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ul class="property-list report">
			
				<g:if test="${reportInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="report.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${reportInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${reportInstance?.reportGroup}">
				<li class="fieldcontain">
					<span id="reportGroup-label" class="property-label"><g:message code="report.reportGroup.label" default="Report Group" /></span>
					
						<span class="property-value" aria-labelledby="reportGroup-label"><g:link controller="reportGroup" action="show" id="${reportInstance?.reportGroup?.id}">${reportInstance?.reportGroup?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${reportInstance?.reportType}">
				<li class="fieldcontain">
					<span id="reportType-label" class="property-label"><g:message code="report.reportType.label" default="Report Type" /></span>
					
						<span class="property-value" aria-labelledby="reportType-label"><g:link controller="reportType" action="show" id="${reportInstance?.reportType?.id}">${reportInstance?.reportType?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${reportInstance?.sourceFile}">
				<li class="fieldcontain">
					<span id="sourceFile-label" class="property-label"><g:message code="report.sourceFile.label" default="Source File" /></span>
					
						<span class="property-value" aria-labelledby="sourceFile-label"><g:fieldValue bean="${reportInstance}" field="sourceFile"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${reportInstance?.remarks}">
				<li class="fieldcontain">
					<span id="remarks-label" class="property-label"><g:message code="report.remarks.label" default="Remarks" /></span>
					
						<span class="property-value" aria-labelledby="remarks-label"><g:fieldValue bean="${reportInstance}" field="remarks"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${reportInstance?.configItemStatus}">
				<li class="fieldcontain">
					<span id="configItemStatus-label" class="property-label"><g:message code="report.configItemStatus.label" default="Config Item Status" /></span>
					
						<span class="property-value" aria-labelledby="configItemStatus-label">${reportInstance?.configItemStatus?.description}</span>
					
				</li>
				</g:if>
			
			</ul>
			<g:form id="show" url="[resource:reportInstance, action:'delete']" method="DELETE">
			</g:form>
		</div>
            </content>
             <content tag="main-actions">
                <ul>
                    <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
                    <li><g:link action="edit" resource="${reportInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link></li>
                    <li><g:actionSubmit form="show" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></li>
				</ul>
            </content>
	</body>
</html>
