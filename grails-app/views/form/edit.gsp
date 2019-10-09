<%@ page import="icbs.admin.Form" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'form.label', default: 'Form')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<content tag="breadcrumbs">
		  <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/form')}">Form Designer</a>
          <span class="fa fa-chevron-right"></span><span class="current">Edit Form</span>
		</content>
        <content tag="main-content">
		<div id="edit-form" class="content scaffold-edit" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${formInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${formInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form id="edit" enctype="multipart/form-data" url="[resource:formInstance, action:'update']" method="POST" >
				<g:hiddenField name="version" value="${formInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					
				</fieldset>
			</g:form>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><g:actionSubmit form="edit" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></li>
                    <li><g:link action="show" id="${formInstance.id}">Cancel</g:link></li>
                </ul>
            </content>
            
	</body>
</html>
