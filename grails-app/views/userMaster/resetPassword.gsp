<%@ page import="icbs.admin.UserMaster" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'userMaster.label', default: 'UserMaster')}" />
		<title>Reset Password</title>

		<script>
		    $(document).ready(function(){
		        $("#generate-password").click(function(){
		            $.get("${createLink(action:'generatePassword', 'controller':'userMaster')}", function(data, status) {
		                $('input[id="newPasswordHiddenField"]').val(data.password);
		                $('input[id="newPasswordTextField"]').val(data.password);
		            });
		        });
		    });
		</script>
	</head>
	<body>
		<content tag="breadcrumbs">
		  <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/userMaster')}">User Management</a>
          <span class="fa fa-chevron-right"></span><g:link action="show" resource="${userMasterInstance}">User Information</g:link>
          <span class="fa fa-chevron-right"></span><span class="current">Reset Password</span>
		</content>

            <content tag="main-content">
		<div id="edit-userMaster" class="content scaffold-edit" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${userMasterInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${userMasterInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form id="resetPassword" url="[resource:userMasterInstance, action:'saveResetPassword']" method="PUT" >
				<g:hiddenField name="version" value="${userMasterInstance?.version}" />
				<fieldset class="form">
					<div class="fieldcontain form-group">
						<label class="control-label col-sm-4" for="name">
							<g:message code="userMaster.name.label" default="User" />
						</label>
						<div class="col-sm-8"><g:textField name="name" value="${userMasterInstance?.name1 + ' ' + userMasterInstance?.name2}" class="form-control" disabled="disabled"/>
					        </div>             
					</div>

					<div class="fieldcontain form-group ${hasErrors(bean: userMasterInstance, field: 'password', 'has-error')} required">
					    <label class="control-label col-sm-4" for="password">
					        <g:message code="userMaster.password.label" default="Password" />
					        <span class="required-indicator">*</span>
					    </label>

					    <div class="col-sm-8">
					        <g:hiddenField id="newPasswordHiddenField" name="password" value="" />
					        <g:textField id="newPasswordTextField" name="p" required="" disabled="disabled" value="" size="30" />
					        <button type="button" id="generate-password" class="btn btn-primary">Generate Password</button>
					        <g:hasErrors bean="${userMasterInstance}" field="password">
					            <div class="controls">
					                    <span class="help-block">
					                        <g:eachError bean="${userMasterInstance}" field="password">
					                            <g:message error="${it}" /><br/>
					                        </g:eachError>
					                    </span>
					            </div>
					        </g:hasErrors>
					    </div>             
					</div>
				</fieldset>
			</g:form>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><g:actionSubmit id="resetUserPassword" action="saveResetPassword" value="${message(code: 'default.button.reset.label', default: 'Reset')}" /></li>
                    <li><g:link action="show" resource="${userMasterInstance}"><g:message code="default.cancel.label" args="[entityName]" default="Cancel" /></g:link></li>
                </ul>
                <!-- Override Script resulting to Invalid credential
                -->
                <script type="text/javascript">
                    $(document).ready(function() {
                        $( "#resetUserPassword" ).click(function() {
                                 checkIfAllowed('ADM00505', 'form#resetPassword', 'Reset User Password', null); // params: policyTemplate.code, form to be saved
                        });
                    }); 
                </script>
                
            </content>
            
	</body>
</html>
