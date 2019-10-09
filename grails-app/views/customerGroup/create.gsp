<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'customerGroup.label', default: 'CustomerGroup')}" />
		<title>Create Customer Group</title>
	</head>
	<body>
                <content tag="breadcrumbs">
                    <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/customerGroup')}">Customer Group Maintenance</a>
                    <span class="fa fa-chevron-right"></span><span class="current">Create Customer Group</span>
                </content>
		<content tag="main-content">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${customerGroupInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${customerGroupInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form id="create" url="[resource:customerGroupInstance, action:'save']" >
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
			</g:form>
		</content>
		<content tag="main-actions">
			<ul>
				<li><g:submitButton name="create" id="newCustomerGroup" value="${message(code: 'default.button.create.label', default: 'Create')}" onclick="
                                alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                    checkIfAllowed('CFG00602', 'form#create', 'Override new Customer Group.', null); 
                                },
                                function(){
                                    return;
                                });                                          
                                    "/></li>
				<li><g:link action="index"><g:message code="default.cancel.label" args="[entityName]" default="Cancel" /></g:link></li>
			</ul>
                        <!--
                        <script type="text/javascript">
                            $(document).ready(function() {
                                $( "#newCustomerGroup" ).click(function() {
                                         checkIfAllowed('CFG00602', 'form#create', 'Override new Customer Group.', null); // params: policyTemplate.code, form to be saved
                                });
                            }); 
                        </script>
                        -->
		</content>
	</body>
</html>
