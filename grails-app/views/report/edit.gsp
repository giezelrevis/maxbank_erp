<%@ page import="icbs.admin.Report" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'report.label', default: 'Report')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
            <content tag="main-content">
		<div id="edit-report" class="content scaffold-edit" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${reportInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${reportInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form id="edit" enctype="multipart/form-data" url="[resource:reportInstance, action:'update']" method="POST" >
				<g:hiddenField name="version" value="${reportInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
			</g:form>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                	<li><g:actionSubmit form="edit" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></li>
                	<li><g:link action="show" id="${reportInstance.id}">Cancel</g:link></li>
                </ul>
            </content>
            
	</body>
</html>
