
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		
		<title>Edit ATM Terminal Information</title>
	</head>
	<body>
		<content tag="main-content">	
                    <g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
                    </g:if>
                    <g:form id="edit" controller="ATMInterface" url="[resource:atmTerminalInstance, action:'updateTerminal']" method="PUT" >
			<g:hiddenField name="version" value="${atmTerminalInstance?.version}" />
			<fieldset class="form">
                            <g:render template="terminalform"/>
			</fieldset>
                    </g:form>
		</content>
		<content tag="main-actions">
			<ul>
				<li><g:actionSubmit id="editAtmTerminal" name="edit" value="${message(code: 'default.button.create.label', default: 'Update')}"  onclick="
                                alertify.confirm(AppTitle,'Are you sure you want to update ATM Terminal Information?',
                                function(){
                                    checkIfAllowed('ADM00103', 'form#edit', 'Edit Terminal.', null); // params: policyTemplate.code, form to be saved
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
