<%@ page import="icbs.loans.LoanApplication" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'collateral.label', default: 'Collateral')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<g:javascript>    	    		
			var rem
			var chattel;
			var holdout;
			var pdc;

			// update form fields based on collateral type
    		updateForm = function() {
    			var collateralType = $('#collateralType').val();

    			if (collateralType == 1) {  // REM        				
    				if (!chattel)
						chattel = $('#chattel-form-group').detach();

					if (!holdout)
						holdout = $('#holdout-form-group').detach();

					if (!pdc)					
						pdc = $('#pdc-form-group').detach();

					rem.appendTo($('#form'));
					rem = null;
		    	} else if (collateralType == 2) {  // chattel		    		
		    		if (!rem)
						rem = $('#rem-form-group').detach();

					if (!holdout)
						holdout = $('#holdout-form-group').detach();

					if (!pdc)					
						pdc = $('#pdc-form-group').detach();

					chattel.appendTo($('#form'));
					chattel = null;
				} else if (collateralType == 3) {  // holdout		    		
					if (!rem)
						rem = $('#rem-form-group').detach();

					if (!chattel)
						chattel = $('#chattel-form-group').detach();

					if (!pdc)					
						pdc = $('#pdc-form-group').detach();

					holdout.appendTo($('#form'));
					holdout = null;
				} else if (collateralType == 4) {  // PDC
					if (!rem)
						rem = $('#rem-form-group').detach();

					if (!chattel)
						chattel = $('#chattel-form-group').detach();

					if (!holdout)					
						holdout = $('#holdout-form-group').detach();

					pdc.appendTo($('#form'));
					pdc = null;					
		    	} else {
		    		if (!rem)
						rem = $('#rem-form-group').detach();

					if (!chattel)
						chattel = $('#chattel-form-group').detach();

					if (!holdout)					
						holdout = $('#holdout-form-group').detach();

					if (!pdc)
						pdc = $('#holdout-form-group').detach();
		    	}
			};    	

        	icbs.Dependencies.Ajax.addLoadEvent(function(){
        		rem = $('#rem-form-group').detach();
				chattel = $('#chattel-form-group').detach();
				holdout = $('#holdout-form-group').detach();
				pdc = $('#pdc-form-group').detach();

            	updateForm();
            });
        </g:javascript>
	</head>
	<body>
        <content tag="main-content">
		<div id="create-collateral" class="content scaffold-create" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${collateralInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${collateralInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>

			<g:set var="loanApplicationInstance" value="${LoanApplication.get(params?.loanApplication)}" />
			<g:form url="[controller:loanApplication, action:'saveCollateral']" >
				<fieldset id="form" class="form">
					<g:render template="collateral"/>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</fieldset>
			</g:form>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                	<li><g:link action="show" id="${loanApplicationInstance.id}">View Loan Application</g:link></li>
                    <li><g:link action="showCollaterals" resource="${loanApplicationInstance}">View Collateral List</g:link></li>          
                    <li><button disabled="disabled">New Collateral</button></li>
                </ul>
            </content>
	</body>
</html>
