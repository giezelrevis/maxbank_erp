<%@ page import="icbs.deposit.FixedDepositPreTermScheme" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'fixedDepositPreTermScheme.label', default: 'FixedDepositPreTermScheme')}" />
		<title>Edit Fixed Deposit Pre-Term Scheme</title>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/fixedDepositPreTermScheme')}">Fixed Deposit Pre-Term Scheme List</a>
                <span class="fa fa-chevron-right"></span><span class="current">Edit Fixed Deposit Pre-Term Scheme</span>
            </content>
            <content tag="main-content">
		<div id="edit-fixedDepositPreTermScheme" class="content scaffold-edit" role="main">
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
			<g:form id="fixedDepositPreTermSchemeForm" url="[resource:fixedDepositPreTermSchemeInstance, action:'update']" method="PUT" >
				<g:hiddenField name="version" value="${fixedDepositPreTermSchemeInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
			</g:form>
		</div>
            </content>
            <content tag="main-actions">
                 <ul>
                        <!--<li><a href="#" onclick="$('#fixedDepositPreTermSchemeForm').submit()">Update</a></li>-->
      			<li><g:submitButton name="edit" id="editFixedDepositPreTermScheme" class="btn btn-primary" value="${message(code: 'default.button.Update.label', default: 'Update')}" onclick="
                            alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                    checkIfAllowed('CFG00903', 'form#fixedDepositPreTermSchemeForm', 'Override new Fixed Deposit PreTerm Scheme.', null); 
                                },
                                function(){
                                    return;
                                }); 
                            "/></li>
                        <li><g:link class="list" action="show" id="${fixedDepositPreTermSchemeInstance.id}">Back To Show</g:link></li>
	       	</ul>
                <!--    
                <script type="text/javascript">
                    $(document).ready(function() {
                        $( "#editFixedDepositPreTermScheme" ).click(function() {
                                 checkIfAllowed('CFG00903', 'form#fixedDepositPreTermSchemeForm', 'Override new Fixed Deposit PreTerm Scheme.', null); // params: policyTemplate.code, form to be saved
                        });
                    }); 
                </script>
                -->
            </content>        
	</body>
</html>
