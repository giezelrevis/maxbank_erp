<%@ page import="icbs.admin.CheckDepositClearingType" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'checkDepositClearingType.label', default: 'CheckDepositClearingType')}" />
		<title>Edit Check Deposit Clearing Type</title>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/checkDepositClearingType')}">Check Deposit Clearing Type</a>
                <span class="fa fa-chevron-right"></span><span class="current">Edit Check Deposit Clearing Type</span>
            </content>
            <content tag="main-content">
		<div id="edit-checkDepositClearingType" class="content scaffold-edit" role="main">
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
            		<g:form id="edit" url="[resource:checkDepositClearingTypeInstance, action:'update']" method="PUT" >
						<g:hiddenField name="version" value="${checkDepositClearingTypeInstance?.version}" />
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
                    <li><g:submitButton name="edit" id="editDepositClearingType" class="btn btn-primary" value="${message(code: 'default.button.save.label', default: 'Update')}" onclick="
                        alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                    checkIfAllowed('CFG00403', 'form#edit', 'Override edit Check Deposit Clearing Type.', null)
                                },
                                function(){
                                    return;
                                });                            
                        "/></li>
                    <li><g:link action="show" id="${checkDepositClearingTypeInstance.id}">Cancel</g:link></li>
                </ul>
                <!--
                <script type="text/javascript">
                    $(document).ready(function() {
                        $( "#editDepositClearingType" ).click(function() {
                                 checkIfAllowed('CFG00403', 'form#edit', 'Override edit Check Deposit Clearing Type.', null); // params: policyTemplate.code, form to be saved
                        });
                    }); 
                </script>
                -->
            </content>
            
	</body>
</html>
