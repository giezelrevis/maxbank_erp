<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'userMessage.label', default: 'UserMessage')}" />
		<title>Reply to Message</title>
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
			<g:form id="create" url="[resource:userMessageInstance, action:'saveReply']" >
				<fieldset class="form">
					<g:render template="reply_form"/>
				</fieldset>
			</g:form>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                	<li><g:submitButton name="create" form="create" value="${message(code: 'default.button.send.label', default: 'Send')}" /></li>
                </ul>
            </content>
	</body>
</html>