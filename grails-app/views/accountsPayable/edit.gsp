<!DOCTYPE html>
<html>
    <head>
	<meta name="layout" content="main">
	<title>Edit Accounts Payable Subsidiary Ledger</title>
    </head>
    <body>
	<content tag="main-content">
            <div id="create-accountsPayable" class="content scaffold-create" role="main">
		<g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
		</g:if>
		<g:hasErrors bean="${accountsPayableInstance}">
                    <ul class="errors" role="alert">
			<g:eachError bean="${accountsPayableInstance}" var="error">
			<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error.field} - ${error}"/></li>
			</g:eachError>
                    </ul>
		</g:hasErrors>
		<g:form id="create" url="[resource:accountsPayableInstance, action:'update']" >
                    <fieldset class="form">
			<g:render template="form"/>
                    </fieldset>
		</g:form>
            </div>
	</content>
	<content tag="main-actions">
            <ul>
		<li><g:submitButton id="newAR" name="create" value="${message(code: 'default.button.Update.label', default: 'Update')}" onclick="
                        alertify.confirm(AppTitle,'Are you sure you want to continue edit Accounts Payable ledger?',
                            function(){
                                    checkIfAllowed('ADM00102', 'form#create', 'Create New Accounts Payable Ledger', null); 
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
