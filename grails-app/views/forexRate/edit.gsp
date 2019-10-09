<%@ page import="icbs.admin.ForexRate" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'forexRate.label', default: 'ForexRate')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
            <content tag="main-content">
		<div id="edit-forexRate" class="content scaffold-edit" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${forexRateInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${forexRateInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:forexRateInstance, action:'update']" method="PUT" >
				<g:hiddenField name="version" value="${forexRateInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<br/>
				<fieldset class="buttons">
					<g:actionSubmit class="hidden" id="updateForexRatebtn" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</fieldset>
			</g:form>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><a href="#" onclick="alertifyDialogUpdateForex();">Update Forex Rate</a></li>
                    <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                    <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                    <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
                    <script>
                        function alertifyDialogUpdateForex(){
                            alertify.confirm(AppTitle,"Are you sure you want to Update this Forex Rate?",
                            function(){
                              $('#updateForexRatebtn').click();
                            },
                            function(){
                              alertify.error('Canceled!');
                            });
                        }
                    </script>
                </ul>
            </content>
            
	</body>
</html>
