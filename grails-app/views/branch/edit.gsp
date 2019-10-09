<%@ page import="icbs.admin.Branch" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'branch.label', default: 'Branch')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<content tag="breadcrumbs">
		  <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/branch')}">Branch Maintenance</a>
          <span class="fa fa-chevron-right"></span><span class="current">Edit Branch</span>
		</content>

            <content tag="main-content">
				<div id="edit-branch" class="content scaffold-edit" role="main">
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
					<g:form id="edit" url="[resource:branchInstance, action:'update']" method="PUT" >
						<g:hiddenField name="version" value="${branchInstance?.version}" />
						<fieldset class="form">
							<g:render template="form" model="['mode':'edit']"/>
						</fieldset>
					</g:form>

				</div>
            </content>

            <content tag="main-actions">
                <ul>
                    <li><button id="update" type="button" class="btn btn-info btn-lg" onclick="
                        alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                    checkIfAllowed('ADM00203', 'form#edit', 'Update branch XXX.', null); // params: policyTemplate.code, form to be saved
                                },
                                function(){
                                    return;
                                });                         
                        ">Update</button></li>
                    <li><g:link action="show" id="${branchInstance.id}">Cancel</g:link></li>
                </ul>
                    <!--
	            <script type="text/javascript">
		            $(document).ready(function() {
		               	$( "#update" ).click(function() {
		             		 checkIfAllowed('ADM00203', 'form#edit', 'Update branch XXX.', null); // params: policyTemplate.code, form to be saved
		             		//checkIfAllowed('001001', 'form#edit', 'Update branch XXX.', 19);
		               	});
		            }); 
                        </script>
                    -->
            </content>
        

	</body>
</html>
