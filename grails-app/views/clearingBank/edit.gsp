<%@ page import="icbs.admin.ClearingBank" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'clearingBank.label', default: 'ClearingBank')}" />
		<title>Edit Clearing Bank</title>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/clearingBank')}">Clearing Bank Information</a>
                <span class="fa fa-chevron-right"></span><span class="current">Edit Clearing Bank Information</span>
            </content>
            <content tag="main-content">
		<div id="edit-clearingBank" class="content scaffold-edit" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${clearingBankInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${clearingBankInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>

			<div class="nav-tab-container">
              <ul class="nav nav-tabs">
                <li class="active"><a href="#tab_1" data-toggle="tab">Clearing Bank Details</a></li>
                %{-- <li><a href="#tab_2" data-toggle="tab">Branches</a></li> --}%
              </ul>
            </div>

			<div class="tab-content">
            	<div class="tab-pane active fade in" id="tab_1">
            		<g:form id="edit" url="[resource:clearingBankInstance, action:'update']" method="PUT" >
						<fieldset class="form">
							<g:render template="form"/>
						</fieldset>
					</g:form>	
            	</div>
				%{-- <div class="tab-pane fade in" id="tab_2">
					<h3>Assign Clearing Bank to Branch</h3>
						<fieldset>
							<g:render template="branch" />
						</fieldset>
				</div> --}%
			</div>

		</div>
    </content>
    
    <content tag="main-actions">
        <ul>
            <li><g:actionSubmit class="save" id="editClearingBank" name="edit" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" onclick="
                        alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                     checkIfAllowed('CFG00303', 'form#edit', 'Override edit clearing bank.', null); 
                                },
                                function(){
                                    return;
                                });                      
                "/></li>
            <li><g:link action="show" id="${clearingBankInstance.id}">Cancel</g:link></li>
        </ul>
        <!--
        <script type="text/javascript">
            $(document).ready(function() {
                $( "#editClearingBank" ).click(function() {
                         checkIfAllowed('CFG00303', 'form#edit', 'Override edit clearing bank.', null); // params: policyTemplate.code, form to be saved
                });
            }); 
        </script>
        -->
    </content>
            
	</body>
</html>
