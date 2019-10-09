<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'payables.label', default: 'payables')}" />
		<title>Create Payable</title>

	</head>
	<body>
		<content tag="breadcrumbs">
		  <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/payables')}">Accounts Payable</a>
          <span class="fa fa-chevron-right"></span><span class="current">Create/Update AP</span>
		</content>

            <content tag="main-content">
		<div id="create-payables" class="content scaffold-create" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${payablesInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${payablesInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>${error.field} <g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form id="create" url="[resource:payablesInstance, action:'save']" >
				<fieldset class="form">
					<g:render template="/payables/formtemps/form"/>
				</fieldset>
			</g:form>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><g:submitButton name="create" form="create" value="${message(code: 'default.button.create.label', default: 'Create')}" /></li>
                    <li><g:link action="index"><g:message code="default.cancel.label" args="[entityName]" default="Cancel" /></g:link></li>
                </ul>
            </content>
	</body>

</html>
