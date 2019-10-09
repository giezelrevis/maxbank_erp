<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'userMaster.label', default: 'UserMaster')}" />
		<title>Create User</title>

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
          <span class="fa fa-chevron-right"></span><span class="current">Create User</span>
		</content>

    <content tag="main-content">
        <div id="create-userMaster" class="content scaffold-create" role="main">
			<g:if test="${flash.message}">
                           <!-- <div class="message" role="status">${flash.message}</div> -->
                            <script>
                                $(function(){
                                    var x = '${flash.message}';
                                        notify.message(x);
                                });
                            </script>
			</g:if>
                        <%--
			<g:hasErrors bean="${userMasterInstance}">
				<ul class="alert alert-danger alert-dismissable" role="alert">
					<g:eachError bean="${userMasterInstance}" var="error">
                                            <li><g:message error="${error}"/></li>
					</g:eachError>
				</ul>
			</g:hasErrors>
                        --%>

            <div class="nav-tab-container">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#tab_1" data-toggle="tab">User Details</a></li>
                    <li><a href="#tab_2" data-toggle="tab">Roles</a></li>
                </ul>
            </div>
            <g:form  name="create" id="create" url="[resource:userMasterInstance, action:'save']" >
                <div class="tab-content">
                    <div class="tab-pane active fade in" id="tab_1">

                            <fieldset class="form">
                                <g:render template="form" model="['mode':'create']"/>
                            </fieldset>
                    </div>
                    <div class="tab-pane fade in" id="tab_2">
                        <h3>Assign Roles to User</h3>
                        <fieldset>
                                <g:render template="role" />
                        </fieldset>

                    </div>
                </div>
            </g:form>
        </div>
    </content>

    <content tag="main-actions">
        <ul>
            <li><g:submitButton name="create" id="createuser" value="${message(code: 'default.button.create.label', default: 'Create')}" onclick="
                alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                    checkIfAllowed('ADM00502', 'form#create', 'Create New User.', null); 
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
                $( "#createuser" ).click(function() {
                         checkIfAllowed('ADM00502', 'form#create', 'Create New User.', null); // params: policyTemplate.code, form to be saved
                });
            }); 
        </script>
-->
    </content>
	</body>
</html>
