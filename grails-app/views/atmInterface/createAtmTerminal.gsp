<!DOCTYPE html>
<html>
    <head>
	<meta name="layout" content="main">
	<title>Create ATM Terminal Mapping</title>
    </head>
    <body>
        <content tag="main-content">
            <div id="create-atmTerminal" class="content scaffold-create" role="main">
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <g:hasErrors bean="${atmTerminalInstance}">
                    <ul class="errors" role="alert">
                        <g:eachError bean="${currencyInstance}" var="error">
                            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                    </ul>
                </g:hasErrors>
                <g:form id="create" url="[resource:atmTerminalInstance, action:'saveAtmTerminal']" >
                    <fieldset class="form">
                        <g:render template="terminalform"/>
                    </fieldset>
                </g:form>
            </div>
        </content>
        <content tag="main-actions">
            <ul>
                <li><g:submitButton id="newAtmTerminal" name="create" value="${message(code: 'default.button.create.label', default: 'Create')}" onclick="
                            alertify.confirm(AppTitle,'Are you sure you want to continue create ATM Terminal?',
                            function(){
                                checkIfAllowed('ADM00102', 'form#create', 'Create New ATM Termninal', null); 
                            },
                            function(){
                                return;
                            }); 
                    "/></li>
                <li><g:link action="atmTerminalView"><g:message code="default.cancel.label" args="[entityName]" default="Cancel" /></g:link></li>
            </ul>
        </content>
    </body>
</html>
