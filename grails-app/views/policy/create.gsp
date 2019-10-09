<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'policy.label', default: 'Policy')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>

		<content tag="breadcrumbs">
		  <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/policy')}">Policy Management</a>
          <span class="fa fa-chevron-right"></span><span class="current">Create Policy</span>
		</content>

    <content tag="main-content">
		<div id="create-policy" class="content scaffold-create" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${policyInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${policyInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>

			<div class="nav-tab-container">
              <ul class="nav nav-tabs">
                <li class="active"><a href="#tab_1" data-toggle="tab">Policy Details</a></li>
                <li id="txntab"><a href="#tab_2" data-toggle="tab">Transactions</a></li>
                <li><a href="#tab_3" data-toggle="tab">Roles</a></li>
                <li><a href="#tab_4" data-toggle="tab">Approvers</a></li>
              </ul>
            </div>

            <div class="tab-content">
            	<div class="tab-pane active fade in" id="tab_1">
            		<g:form name="create" id="create" url="[resource:policyInstance, action:'save']" >
						<fieldset class="form">
							<g:render template="form"/>
						</fieldset>
            	</div>
            	<div class="tab-pane fade in" id="tab_2">
					<h3>Assign Policy to Transactions</h3>
						<fieldset>
							<g:render template="txnTemplate" />
						</fieldset>
				</div>
				<div class="tab-pane fade in" id="tab_3">
					<h3>Assign Policy to Roles</h3>
						<fieldset>
							<g:render template="role" />
						</fieldset>
				</div>
				<div class="tab-pane fade in" id="tab_4">
					<h3>Assign Approvers</h3>
						<fieldset>
							<g:render template="approver" />
						</fieldset>
					</g:form>
				</div>
			</div>

		</div>
        </content>

        <content tag="main-actions">
            <ul>
                <li><g:submitButton id="newPolicy" name="create" value="${message(code: 'default.button.create.label', default: 'Create')}" onclick="
                        alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                    checkIfAllowed('ADM00402', 'form#create', 'Created a new policyc.', null);                               
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
		               	$( "#newPolicy" ).click(function() {
		             		 checkIfAllowed('ADM00402', 'form#create', 'Created a new policyc.', null); // params: policyTemplate.code, form to be saved
		               	});
		            }); 
                </script>
                -->
        </content>
	</body>
</html>
