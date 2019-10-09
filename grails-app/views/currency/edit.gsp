<%@ page import="icbs.admin.Currency" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'currency.label', default: 'Currency')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<content tag="breadcrumbs">
		  <span class="fa fa-chevron-right"></span><a href="${createLink(uri:'/currency')}">Currency Maintenance</a>
          <span class="fa fa-chevron-right"></span><span class="current">Edit Currency</span>
		</content>
		<content tag="main-content">	
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${currencyInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${currencyInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form id="edit" url="[resource:currencyInstance, action:'update']" method="PUT" >
				<g:hiddenField name="version" value="${currencyInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
			</g:form>
		</content>
		<content tag="main-actions">
			<ul>
				<li><g:actionSubmit action="update" form="edit" value="${message(code: 'default.button.update.label', default: 'Update')}" onclick="
                                alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                    checkIfAllowed('ADM00103', 'form#edit', 'Edit Currency.', null); // params: policyTemplate.code, form to be saved
                                },
                                function(){
                                    return;
                                }); 
                                "/></li>
				<li><g:link action="show" id="${currencyInstance.id}">Cancel</g:link></li>
			</ul>
		</content>
	</body>
</html>
