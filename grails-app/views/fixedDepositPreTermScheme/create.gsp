<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'fixedDepositPreTermScheme.label', default: 'FixedDepositPreTermScheme')}" />
		<title>Create Fixed Deposit Pre-Term Scheme</title>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/fixedDepositPreTermScheme')}">Fixed Deposit Pre-Term Scheme List</a>
                <span class="fa fa-chevron-right"></span><span class="current">Create Fixed Deposit Pre-Term Scheme</span>
            </content>
            <content tag="main-content">
		<div id="create-fixedDepositPreTermScheme" class="content scaffold-create" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${fixedDepositPreTermSchemeInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${fixedDepositPreTermSchemeInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form id="fixedDepositPreTermSchemeForm"url="[resource:fixedDepositPreTermSchemeInstance, action:'save']" >
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
			</g:form>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <!--<li><a href="#" onclick="$('#fixedDepositPreTermSchemeForm').submit()">Create</a></li>-->
                    <li><g:submitButton name="create" id="newFixedDepositPreTermScheme" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" onclick="
                    alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                    checkIfAllowed('CFG00902', 'form#fixedDepositPreTermSchemeForm', 'Override new Fixed Deposit PreTerm Scheme.', null);
                                },
                                function(){
                                    return;
                                }); 
                    "/></li>
                    <li><g:link class="list" action="index">Back to List</g:link></li>
                </ul>
                <!--
                <script type="text/javascript">
                    $(document).ready(function() {
                        $( "#newFixedDepositPreTermScheme" ).click(function() {
                                 checkIfAllowed('CFG0fixedDepositPreTermSchemeForm0902', 'form#', 'Override new Fixed Deposit PreTerm Scheme.', null); // params: policyTemplate.code, form to be saved
                        });
                    }); 
                </script>
                -->
            </content>
	</body>
</html>
