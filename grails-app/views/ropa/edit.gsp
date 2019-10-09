<%@ page import="icbs.loans.ROPA" %>
<!DOCTYPE html>
<html>
    <head>
	<meta name="layout" content="main">
	<g:set var="entityName" value="${message(code: 'ROPA.label', default: 'ROPA')}" />
	<title>Edit ROPA Information</title>
    </head>
    <body>
        <content tag="main-content">
            <div id="edit-ROPA" class="content scaffold-edit" role="main">
		<g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
		<g:hasErrors bean="${ropaInstance}">
                    <ul class="errors" role="alert">
			<g:eachError bean="${ropaInstance}" var="error">
                            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
			</g:eachError>
                    </ul>
		</g:hasErrors>
                <g:render template="ropadDetails"/>
                <g:form id="editRopa" name="editRopa" url="[action:'updateRopa',controller:'Ropa']">
                    <fieldset class="form">
			<g:render template="editForm"/>
                    </fieldset>
		</g:form>
            </div>
        </content>
    
        <content tag="main-actions">
            <ul>
                <li><a href="#" onClick="callAlertSendEdit();" >UpdateNow</a></li>
                <li><g:link action="show" id="${ropaInstance?.id}">Cancel</g:link></li>
                <script>
                    function callAlertSendEdit(){
                        alertify.confirm(AppTitle,'Are you sure you want to save ROPA Information?',
                            function(){
                                checkIfAllowed('CFG00303', 'form#editRopa', 'Override edit ROPA', null); 
                            },
                            function(){
                                return;
                            }
                        ); 
                    }
                </script>
            </ul>
        </content>           
    </body>
</html>
