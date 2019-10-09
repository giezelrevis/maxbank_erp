<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'userMessage.label', default: 'UserMessage')}" />
		<title>Compose Message</title>
	</head>
	<body>
            <content tag="main-content">
		<div id="create-userMessage" class="content scaffold-create" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${userMessageInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${userMessageInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form id="create" url="[resource:userMessageInstance, action:'save']" >
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
			</g:form>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                	<li>
                            <%-- <g:submitButton name="create" form="create" value="${message(code: 'default.button.send.label', default: 'Send')}" /> --%>
                            <a href="#" onclick="
                            if(empty(recipient.value))
                            {
                                alertify.alert(AppTitle,'<H4>Empty recipient not allowed!</H4>');
                                return;
                            } 
                            
                            if(document.getElementById('body').value == '')
                            {
                                alertify.alert(AppTitle,'<H4>Empty message not allowed!</H4>');
                                return;
                            }
                            alertify.confirm(AppTitle,'Are you sure you want to send message?',
                                function(){
                                    create.submit();; 
                                },
                                function(){
                                    return;
                                }); 
                            //create.submit();
                            
                            ">Send</a>
                        </li>
                </ul>
            </content>
	</body>
</html>