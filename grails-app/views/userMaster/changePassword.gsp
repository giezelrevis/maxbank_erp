<%@ page import="icbs.admin.UserMaster" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'userMaster.label', default: 'UserMaster')}" />
		<title>Change Password</title>

		
	</head>
	<body>
        <content tag="main-content">
            
            <g:if test="${msg}">
                    <!-- <div class="box-body">
                            <div class="alert alert-info alert-dismissable">
                                    <i class="fa fa-info"></i>
                                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                    <b>Message</b> <div class="message" role="status">${flash.success}</div>
                            </div>
                    </div> -->
                    <script>
                        $(function(){
                            var x = '${msg}';
                            if(x.indexOf('|success') > -1){
                                alertify.alert(AppTitle,x.split('|')[0],
                                function(){location.href = '/icbs/';});
                            }
                            else{
                                notify.message(x);
                            }
                        });
                    </script>
                </g:if>
		<div id="edit-userMaster" class="content scaffold-edit" role="main">
			<g:form id="changePassword" url="[resource:userMasterInstance, action:'saveChangePassword']" method="PUT" >
				<g:hiddenField name="version" value="${userMasterInstance?.version}" />
				<fieldset class="form">
					
					<div class="fieldcontain form-group ${hasErrors(bean: userMasterInstance, field: 'password', 'has-error')} required">
						<label class="control-label col-sm-4" for="password">
							<g:message code="userMaster.password.label" default="Current Password" />
							<span class="required-indicator">*</span>
						</label>
						<div class="col-sm-8"><g:passwordField name="password" maxlength="50" required="" class="form-control"/>

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

					<div class="fieldcontain form-group ${hasErrors(bean: userMasterInstance, field: 'newPassword', 'has-error')} required">
						<label class="control-label col-sm-4" for="newPassword">
							<g:message code="userMaster.newPassword.label" default="New Password" />
							<span class="required-indicator">*</span>
						</label>
						<div class="col-sm-8"><g:passwordField name="newPassword" maxlength="50" required="" class="form-control"/>

					            <g:hasErrors bean="${userMasterInstance}" field="newPassword">
					                <div class="controls">
					                        <span class="help-block">
					                            <g:eachError bean="${userMasterInstance}" field="newPassword">
					                                <g:message error="${it}" /><br/>
					                            </g:eachError>
					                        </span>
					                </div>
					            </g:hasErrors>
					        </div>             
					</div>

					<div class="fieldcontain form-group ${hasErrors(bean: userMasterInstance, field: 'confirmNewPassword', 'has-error')} required">
						<label class="control-label col-sm-4" for="confirmNewPassword">
							<g:message code="userMaster.confirmNewPassword.label" default="Confirm New Password" />
							<span class="required-indicator">*</span>
						</label>
						<div class="col-sm-8"><g:passwordField name="confirmNewPassword" maxlength="50" required="" class="form-control"/>

					            <g:hasErrors bean="${userMasterInstance}" field="confirmNewPassword">
					                <div class="controls">
					                        <span class="help-block">
					                            <g:eachError bean="${userMasterInstance}" field="confirmNewPassword">
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
                	<li><g:actionSubmit form="changePassword" action="saveChangePassword" value="${message(code: 'default.button.reset.label', default: 'Update')}" /></li>
                </ul>
            </content>
            
	</body>
</html>
