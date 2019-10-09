<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'currency.label', default: 'Currency')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
		<content tag="breadcrumbs">
		  <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/currency')}">Currency Maintenance</a>
          <span class="fa fa-chevron-right"></span><span class="current">Create Currency</span>
		</content>
		<content tag="main-content">
			<div id="create-currency" class="content scaffold-create" role="main">
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
				<g:form id="create" url="[resource:currencyInstance, action:'save']" >
					<fieldset class="form">
						<g:render template="form"/>
					</fieldset>
				</g:form>
			</div>
		</content>
		<content tag="main-actions">
			<ul>
                            
			<li><g:submitButton id="newCcy" name="create" value="${message(code: 'default.button.create.label', default: 'Create')}" onclick="
                                alertify.confirm(AppTitle,'Are you sure you want to continue create currency?',
                                function(){
                                    checkIfAllowed('ADM00102', 'form#create', 'Create New Currency.', null); 
                                },
                                function(){
                                    return;
                                }); 
                        "/></li>
			<li><g:link action="index"><g:message code="default.cancel.label" args="[entityName]" default="Cancel" /></g:link></li>
			</ul>
		</content>
	</body>
</html>
