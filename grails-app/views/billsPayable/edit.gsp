<%@ page import="icbs.gl.BillsPayable" %>
<!DOCTYPE html>
<html>
    <head>
	<meta name="layout" content="main">
	<g:set var="entityName" value="${message(code: 'billsPayable.label', default: 'BillsPayable')}" />
	<title>Edit Bills Payable Subsidiary Ledger</title>
    </head>
    <body>
        <content tag="main-content">
            <div id="edit-billsPayable" class="content scaffold-edit" role="main">
		<g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
		<g:hasErrors bean="${clearingBankInstance}">
                    <ul class="errors" role="alert">
			<g:eachError bean="${clearingBankInstance}" var="error">
                            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
			</g:eachError>
                    </ul>
		</g:hasErrors>
            	<g:form id="edit" url="[resource:billsPayableInstance, action:'update']" method="PUT" >
                    <fieldset class="form">
			<g:render template="form"/>
                    </fieldset>
		</g:form>
            </div>
        </content>
    
        <content tag="main-actions">
            <ul>
                <li><g:actionSubmit class="save" id="editClearingBank" name="edit" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" onclick="
                        alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                     checkIfAllowed('CFG00303', 'form#edit', 'Override edit cash in bank.', null); 
                                },
                                function(){
                                    return;
                                });                      
                    "/></li>
                <li><g:link action="show" id="${billsPayableInstance.id}">Cancel</g:link></li>
            </ul>
        </content>           
    </body>
</html>
