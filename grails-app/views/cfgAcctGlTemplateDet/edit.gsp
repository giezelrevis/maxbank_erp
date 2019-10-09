<%@ page import="icbs.gl.CfgAcctGlTemplateDet" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cfgAcctGlTemplateDet.label', default: 'CfgAcctGlTemplateDet')}" />
		<title>Edit ${cfgAcctGlTemplateDetInstance?.glDescription.encodeAsHTML()}</title>
	</head>
	<body>
             <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><span class="current">Edit GL Link Account Entries</span>
            </content>
            <content tag="main-content">
		<div id="edit-cfgAcctGlTemplateDet" class="content scaffold-edit" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${cfgAcctGlTemplateDetInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${cfgAcctGlTemplateDetInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:cfgAcctGlTemplateDetInstance, action:'update']" method="PUT" >
				<g:hiddenField name="version" value="${cfgAcctGlTemplateDetInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				%{-- <fieldset class="buttons">
					<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</fieldset> --}%
			</g:form>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></li>
                    <li><g:link action="show" id="${cfgAcctGlTemplateDetInstance.id}">Back</g:link></li>
                </ul>
            </content>
            
	</body>
</html>
