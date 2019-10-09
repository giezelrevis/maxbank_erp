<!DOCTYPE html>
<html>
    <head>
	<meta name="layout" content="main">
	<title>Create New Cash in Bank Checkbook</title>
    </head>
    <body>
	<content tag="main-content">
            <div id="create-cashInBankCheckBook" class="content scaffold-create" role="main">
		<g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
		</g:if>
		<g:hasErrors bean="${cashInBankInstance}">
                    <ul class="errors" role="alert">
			<g:eachError bean="${cashInBankInstance}" var="error">
			<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
			</g:eachError>
                    </ul>
		</g:hasErrors>
                <g:render template="cashInBankDetails"/>
		<g:form id="create" url="[resource:cashInBankInstance, action:'saveCb']" >
                    <fieldset class="form">
			<g:render template="cbForm"/>
                    </fieldset>
		</g:form>
            </div>
	</content>
	<content tag="main-actions">
            <ul>
		<li><g:submitButton id="newCIB" name="create" value="${message(code: 'default.button.create.label', default: 'Create')}" onclick="
                        alertify.confirm(AppTitle,'Are you sure you want to continue create Cash in Bank Checkbook?',
                            function(){
                                    checkIfAllowed('ADM00102', 'form#create', 'Create New Cash in Bank Checkbook', null); 
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
