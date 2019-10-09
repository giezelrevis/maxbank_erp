<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'holiday.label', default: 'Holiday')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>

		<content tag="breadcrumbs">
		  <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/holiday')}">Holiday Settings</a>
          <span class="fa fa-chevron-right"></span><span class="current">Create Holiday</span>
		</content>

    <content tag="main-content">
		<div id="create-holiday" class="content scaffold-create" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${holidayInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${holidayInstance}" var="error">
				<!-- <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li> -->
				</g:eachError>
			</ul>
			</g:hasErrors>

			<div class="nav-tab-container">
              <ul class="nav nav-tabs">
                <li class="active"><a href="#tab_1" data-toggle="tab">Holiday Details</a></li>
                <li><a href="#tab_2" data-toggle="tab">Branches</a></li>
              </ul>
            </div>

            <div class="tab-content">
            	<div class="tab-pane active fade in" id="tab_1">
            		<g:form form="create" id="create" url="[resource:holidayInstance, action:'save']" >
						<fieldset class="form">
							<g:render template="form"/>
						</fieldset>
            	</div>
				<div class="tab-pane fade in" id="tab_2">
					<h3>Assign Holiday to Branch</h3>
						<fieldset>
							<g:render template="branch" />
						</fieldset>
					</g:form>
				</div>
			</div>

		</div>
    </content>
    <content tag="main-actions">
        <ul>
            <li><g:submitButton id="newHoliday" name="create" value="${message(code: 'default.button.create.label', default: 'Create')}" onclick="
                alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                    checkIfAllowed('ADM00302', 'form#create', 'Created a new holiday.', null);                               
                                    },
                                function(){
                                    return;
                                });                    
                "/></li>
            <li><g:link action="index"><g:message code="default.cancel.label" args="[entityName]" default="Cancel" /></g:link></li>
            <!--
            <script type="text/javascript">
		            $(document).ready(function() {
		               	$( "#newHoliday" ).click(function() {
		             		 checkIfAllowed('ADM00302', 'form#create', 'Created a new holiday.', null); // params: policyTemplate.code, form to be saved
		               	});
		            }); 
            </script>
            -->
        </ul>
    </content>
	</body>
</html>
