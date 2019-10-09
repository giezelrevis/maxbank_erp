<%@ page import="icbs.deposit.DepositTaxFeeAndChargeScheme" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'depositTaxFeeAndChargeScheme.label', default: 'DepositTaxFeeAndChargeScheme')}" />
		<title>Edit Deposit Taxes/Fees and Charges Scheme</title>
                 <g:javascript>
                    // update form fields based on type
                        updateForm = function() {
                            var type = $('#type').val();	
                            if (type == 1) {  // tax-rate
                                document.getElementById('tax-rate-form-group').style.display = 'block';
                                document.getElementById('fee-rate-form-group').style.display = 'none';
                                document.getElementById('charge-rate-form-group').style.display = 'none';
                                document.getElementById('charge-amount-form-group').style.display = 'none';
                                document.getElementById('fee-amount-form-group').style.display = 'none';
                            } 
                            if (type == 2) {  // tax-amount 
                                document.getElementById('tax-rate-form-group').style.display = 'none';
                                document.getElementById('fee-rate-form-group').style.display = 'none';
                                document.getElementById('charge-rate-form-group').style.display = 'none';
                                document.getElementById('charge-amount-form-group').style.display = 'none';
                                document.getElementById('fee-amount-form-group').style.display = 'none';
                            } 
                            if (type == 3) {  // fee-rate 
                                document.getElementById('tax-rate-form-group').style.display = 'none';
                                document.getElementById('fee-rate-form-group').style.display = 'block';
                                document.getElementById('charge-rate-form-group').style.display = 'none';
                                document.getElementById('charge-amount-form-group').style.display = 'none';
                                document.getElementById('fee-amount-form-group').style.display = 'none';
                            } 
                             if (type == 4) {  // fee-amt
                                document.getElementById('tax-rate-form-group').style.display = 'none';
                                document.getElementById('fee-rate-form-group').style.display = 'none';
                                document.getElementById('charge-rate-form-group').style.display = 'none';
                                document.getElementById('charge-amount-form-group').style.display = 'none';
                                document.getElementById('fee-amount-form-group').style.display = 'block';
                            } 
                            if (type == 5) {  // charge-rate 
                                document.getElementById('tax-rate-form-group').style.display = 'none';
                                document.getElementById('fee-rate-form-group').style.display = 'none';
                                document.getElementById('charge-rate-form-group').style.display = 'block';
                                document.getElementById('charge-amount-form-group').style.display = 'none';
                                document.getElementById('fee-amount-form-group').style.display = 'none';
                            } 
                            if (type == 6) {  // charge-amt 
                                document.getElementById('tax-rate-form-group').style.display = 'none';
                                document.getElementById('fee-rate-form-group').style.display = 'none';
                                document.getElementById('charge-rate-form-group').style.display = 'none';
                                document.getElementById('charge-amount-form-group').style.display = 'block';
                                document.getElementById('fee-amount-form-group').style.display = 'none';
                            } 
                        }
                        icbs.Dependencies.Ajax.addLoadEvent(function(){
                            updateForm();
                    });
                </g:javascript>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/depositTaxFeeAndChargeScheme')}">Deposit Taxes/Fees and Charges Scheme</a>
                <span class="fa fa-chevron-right"></span><span class="current">Edit Deposit Taxes/Fees and Charges Scheme</span>
            </content>
            <content tag="main-content">
		<div id="edit-depositTaxFeeAndChargeScheme" class="content scaffold-edit" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${depositTaxFeeAndChargeSchemeInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${depositTaxFeeAndChargeSchemeInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form id="depositTaxChargeSchemeForm" url="[resource:depositTaxFeeAndChargeSchemeInstance, action:'update']" method="PUT" >
				<g:hiddenField name="version" value="${depositTaxFeeAndChargeSchemeInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>

			</g:form>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                        <!--<li><a href="#" onclick="$('#depositTaxChargeSchemeForm').submit()">Update</a></li>-->
                        <li><g:submitButton name="create" id="editDepositTaxFeeChargeScheme" value="${message(code: 'default.button.update.label', default: 'Update')}" onclick="
                                alertify.confirm(AppTitle,'Are you sure you want to continue transaction?',
                                function(){
                                    checkIfAllowed('CFG01403', 'form#depositTaxChargeSchemeForm', 'Override edit Deposit Interest Scheme.', null);
                                },
                                function(){
                                    return;
                                });                                 
                            "/></li>
      			<li><g:link class="list" action="show" id="${depositTaxFeeAndChargeSchemeInstance.id}">Back To Show</g:link></li>
	       	</ul>
                <!--
                <script type="text/javascript">
                    $(document).ready(function() {
                        $( "#editDepositTaxFeeChargeScheme" ).click(function() {
                                 checkIfAllowed('CFG01403', 'form#depositTaxChargeSchemeForm', 'Override edit Deposit Interest Scheme.', null); // params: policyTemplate.code, form to be saved
                        });
                    }); 
                </script>
                -->
            </content>
            
	</body>
</html>