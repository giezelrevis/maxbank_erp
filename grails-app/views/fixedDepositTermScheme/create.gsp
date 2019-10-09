<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'fixedDepositTermScheme.label', default: 'FixedDepositTermScheme')}" />
		<title>Create Fixed Deposit Term Scheme</title>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/fixedDepositTermScheme')}">Fixed Deposit Term Scheme List</a>
                <span class="fa fa-chevron-right"></span><span class="current">Create Fixed Deposit Term Scheme</span>
            </content>
            <content tag="main-content">
		<div id="create-fixedDepositTermScheme" class="content scaffold-create" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${fixedDepositTermSchemeInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${fixedDepositTermSchemeInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form id="fixedDepositTermSchemeForm" url="[resource:fixedDepositTermSchemeInstance, action:'save']" >
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
			</g:form>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <!--<li><a href="#" onclick="$('#fixedDepositTermSchemeForm').submit()">Create</a></li>-->
                    <li><g:submitButton name="create" id="newfixedDepositTermScheme" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" onclick="
                        alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                    checkIfAllowed('CFG01502', 'form#fixedDepositTermSchemeForm', 'Override new fixed deposit term scheme form.', null);
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
                        $( "#newfixedDepositTermScheme" ).click(function() {
                                 checkIfAllowed('CFG01502', 'form#fixedDepositTermSchemeForm', 'Override new fixed deposit term scheme form.', null); // params: policyTemplate.code, form to be saved
                        });
                    }); 
                </script>
                -->
            </content>
	</body>
</html>
