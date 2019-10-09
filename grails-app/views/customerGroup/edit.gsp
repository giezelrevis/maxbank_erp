<%@ page import="icbs.admin.CustomerGroup" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'customerGroup.label', default: 'CustomerGroup')}" />
		<title>Edit Customer Group</title>
	</head>
	<body>
                <content tag="breadcrumbs">
                    <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/customerGroup')}">Customer Group Maintenance</a>
                    <span class="fa fa-chevron-right"></span><span class="current">Edit Customer Group</span>
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
			<g:form id="edit" url="[resource:customerGroupInstance, action:'update']" method="PUT" >
				<g:hiddenField name="version" value="${customerGroupInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
			</g:form>
		</content>
		<content tag="main-actions">
			<ul>
				<li><g:actionSubmit id="editCustomerGroup" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" onclick="
                                alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                    checkIfAllowed('CFG00603', 'form#edit', 'Override new Customer Group.', null) 
                                },
                                function(){
                                    return;
                                });                                        
                                    "/></li>
			</ul>
                        <!--
                        <script type="text/javascript">
                            $(document).ready(function() {
                                $( "#editCustomerGroup" ).click(function() {
                                         checkIfAllowed('CFG00603', 'form#edit', 'Override new Customer Group.', null); // params: policyTemplate.code, form to be saved
                                });
                            }); 
                        </script>
                        -->
		</content>
	</body>
</html>
