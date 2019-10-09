<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'branch.label', default: 'Branch')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
		<content tag="breadcrumbs">
		  <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/branch')}">Branch Maintenance</a>
          <span class="fa fa-chevron-right"></span><span class="current">Create Branch</span>
		</content>

        <content tag="main-content">
		<div id="create-branch" class="content scaffold-create" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${branchInstance}">
			<ul class="errors" role="alert">    
				<g:eachError bean="${branchInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form  id="create" url="[resource:branchInstance, action:'save']" >
				<fieldset class="form">
					<g:render template="form"  model="['mode':'create']"/>
				</fieldset>
			</g:form>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><g:submitButton name="createBranch" id="createBranch" value="${message(code: 'default.button.create.label', default: 'Create')}" /></li>
                    <li><g:link action="index"><g:message code="default.cancel.label" args="[entityName]" default="Cancel" /></g:link></li>
                </ul>
                <script type="text/javascript">
		            $(document).ready(function() {
		               	$( "#createBranch" ).click(function() {
		             		 checkIfAllowed('ADM00202', 'form#create', 'Update branch XXX.', null); // params: policyTemplate.code, form to be saved
		               	});
		            }); 
                        </script>
            </content>
	</body>
</html>
