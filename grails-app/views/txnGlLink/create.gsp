<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'txnGlLink.label', default: 'TxnGlLink')}" />
		<title>Create GL Transaction Link</title>
	</head>
	<body>
            <content tag="main-content">
		<div id="create-txnGlLink" class="content scaffold-create" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${txnGlLinkInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${txnGlLinkInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			%{-- <g:form url="[resource:txnGlLinkInstance, action:'save']" >
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</fieldset>
			</g:form> --}%
			
			<div class="nav-tab-container">
              <ul class="nav nav-tabs">
                <li class="active"><a href="#tab_1" data-toggle="tab">GL Transaction Link</a></li>
                <li><a href="#tab_2" data-toggle="tab">GL Link Entries</a></li>
              </ul>
            </div>

            <div class="tab-content">
            	<div class="tab-pane active fade in" id="tab_1">
            		<g:form id="create" url="[resource:txnGlLinkInstance, action:'save']" >
						<fieldset class="form">
							<g:render template="form"/>
						</fieldset>
            	</div>
				
				<div class="tab-pane fade in" id="tab_2">
					<h3>Assign GL Link Entries</h3>
						<fieldset>
							<g:render template="entries" />
						</fieldset>
					</g:form>
				</div>
			</div>
		</div>

		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><g:link class="list" action="index">Back</g:link></li>
                </ul>
            </content>
	</body>
</html>
