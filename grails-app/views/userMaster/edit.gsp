<%@ page import="icbs.admin.UserMaster" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'userMaster.label', default: 'UserMaster')}" />
		<title>Edit User</title>
	</head>
	<body>
		<content tag="breadcrumbs">
		  <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/userMaster')}">User Management</a>
          <span class="fa fa-chevron-right"></span><span class="current">Edit User</span>
		</content>

    <content tag="main-content">
		<div id="edit-userMaster" class="content scaffold-edit" role="main">
			<g:if test="${flash.message}">
                <div class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div>
            </g:if>
			
			<g:hasErrors bean="${userMasterInstance}">
			<ul class="errors" role="alert">
                            <!--
				<g:eachError bean="${userMasterInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
                                -->
			</ul>
			</g:hasErrors>

			<div class="nav-tab-container">
              <ul class="nav nav-tabs">
                <li class="active"><a href="#tab_1" data-toggle="tab">User Details</a></li>
                <li><a href="#tab_2" data-toggle="tab">Roles</a></li>
              </ul>
            </div>

            <div class="tab-content">
            	<div class="tab-pane active fade in" id="tab_1">
            		<g:form id="edit" url="[resource:userMasterInstance, action:'update']" method="PUT" >
						<g:hiddenField name="version" value="${userMasterInstance?.version}" />
						<fieldset class="form">
							<g:render template="form" model="['mode':'edit']"/>
						</fieldset>
            	</div>
				<div class="tab-pane fade in" id="tab_2">
					<h3>Assign Roles to User</h3>
						<fieldset>
							<g:render template="role" />
						</fieldset>
					</g:form>
				</div>
			</div>

		</div>
    </content>

    <content tag="main-actions">
        <ul>
            <li><g:actionSubmit id="edituser" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" onclick="alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                    checkIfAllowed('ADM00503', 'form#edit', 'Edit User Information.', null); 
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
                $( "#edituser" ).click(function() {
                         checkIfAllowed('ADM00503', 'form#edit', 'Edit User Information.', null); // params: policyTemplate.code, form to be saved
                });
            }); 
        </script>
        -->
    </content>
            
	</body>
</html>
