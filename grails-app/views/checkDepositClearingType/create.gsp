<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'checkDepositClearingType.label', default: 'CheckDepositClearingType')}" />
		<title>Create Check Deposit Clearing Type</title>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/checkDepositClearingType')}">Check Deposit Clearing Type</a>
                <span class="fa fa-chevron-right"></span><span class="current">Create Check Deposit Clearing Type</span>
            </content>
            <content tag="main-content">
		<div id="create-checkDepositClearingType" class="content scaffold-create" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${checkDepositClearingTypeInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${checkDepositClearingTypeInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>

			<div class="nav-tab-container">
              <ul class="nav nav-tabs">
                <li class="active"><a href="#tab_1" data-toggle="tab">Check Deposit Clearing Type Details</a></li>
                %{-- <li><a href="#tab_2" data-toggle="tab">Branches</a></li> --}%
              </ul>
            </div>

            <div class="tab-content">
            	<div class="tab-pane active fade in" id="tab_1">
            		<g:form id="create" url="[resource:checkDepositClearingTypeInstance, action:'save']" >
						<fieldset class="form">
							<g:render template="form"/>
						</fieldset>
					</g:form>	
            	</div>
				%{-- <div class="tab-pane fade in" id="tab_2">
					<h3>Assign Check Deposit Clearing Type to Branch</h3>
						<fieldset>
							<g:render template="branch" />
						</fieldset>
				</div> --}%
			</div>

		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><g:submitButton name="create" id="newDepositClearingType" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" onclick="
                        alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                    checkIfAllowed('CFG00402', 'form#create', 'Override new Check Deposit Clearing Type.', null);
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
                        $( "#newDepositClearingType" ).click(function() {
                                 checkIfAllowed('CFG00402', 'form#create', 'Override new Check Deposit Clearing Type.', null); // params: policyTemplate.code, form to be saved
                        });
                    }); 
                </script>    
                -->
            </content>
	</body>
</html>
