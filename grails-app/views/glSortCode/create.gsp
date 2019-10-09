<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'glSortCode.label', default: 'GlSortCode')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
            <content tag="main-content">
		<div id="create-glSortCode" class="content scaffold-create" role="main">
			<g:if test="${flash.message}">
			<!-- <div class="message" role="status">${flash.message}</div> -->
                            <script>
                            $(function(){
                                var x = '${flash.message}';
                                notify.message(x);
                            });
                            </script>                            
			</g:if>
			<g:hasErrors bean="${glSortCodeInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${glSortCodeInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form id="create" url="[resource:glSortCodeInstance, action:'save']" >
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<!-- 
                                <fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</fieldset> 
                                -->
			</g:form>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><a href="#" onClick="alertOverridefunc();">Create</a></li>
                    <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                    <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                    <script>
                        function alertOverridefunc(){
                            checkIfAllowed("GEN00204", newGlSortCodeAuthCallback);   
                        }
                        function newGlSortCodeAuthCallback(){
                            alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                    // sending form into controller;
                                    document.getElementById("create").submit();
                                },
                                function(){
                                    return;
                                });
                        }
                    </script>
                </ul>
            </content>
	</body>
</html>
