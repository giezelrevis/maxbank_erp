<!DOCTYPE html>
<html>
    <head>
	<meta name="layout" content="main">
	<title>Create New Cash in Bank Subsidiary Ledger</title>
    </head>
    <body>
	<content tag="main-content">
            <div id="create-cashInBank" class="content scaffold-create" role="main">
		<g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
		</g:if>
		<g:hasErrors bean="${cashInBankInstance}">
                    <ul class="errors" role="alert">
			<g:eachError bean="${cashInBankInstance}" var="error">
			<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
			</g:eachError>
                    </ul>
		</g:hasErrors>
		<g:form id="create" url="[resource:cashInBankInstance, action:'save']" >
                    <fieldset class="form">
			<g:render template="form"/>
                    </fieldset>
                    <g:javascript>
             var onoff=""
                        function validateGlCode(){
                            var depcontra = $('#glContra').val();
                            var financialYear = $('#financialYear').val();
                            console.log("financialYear: "+financialYear);
                            if(depcontra==""){

                            }else{
                              //=================== AJAX FUNCTION to validate code if existing
                                var obj = { 
                                    depcontra: depcontra,
                                    financialYear: financialYear,
                                }; 
                                console.log(JSON.stringify(obj));
                                console.log("Object Loaded iwth data...");
                                $.ajax({
                                    type: "POST",
                                    contentType: "application/json",
                                    url: "${createLink(controller:'TxnTemplate', action:'validateExistingGlCodeAjax')}",
                                    data: JSON.stringify(obj),

                                    success: function(data){
                                        if(data.length >=1){
                                            onoff = ""
                                            //document.getElementById('gldescription').style.display = "block";
                                            $.each(data, function (_key, _value) {
                                                console.log(JSON.stringify(obj))
                                                console.log(_value.gl_code);
                                                console.log(_value.name);
                                                $('#gldescription').val(_value.name);

                                            });

                                        }else{
                                            onoff = "invalidGlCode";
                                            //document.getElementById('gldescription').style.display = "none";
                                            notify.message('Sorry, Invalid Gl Code!|error|alert');

                                        }
                                        console.log("onoff: "+onoff);


                                    },
                                    error: function(data){

                                    },

                                });                                            
                            }

                        }
        </g:javascript>
</g:form>
            </div>
	</content>
	<content tag="main-actions">
            <ul>
		<li><g:submitButton id="newCIB" name="create" value="${message(code: 'default.button.create.label', default: 'Create')}" onclick="
                        alertify.confirm(AppTitle,'Are you sure you want to continue create Cash in Bank ledger?',
                            function(){
                                    checkIfAllowed('ADM00102', 'form#create', 'Create New Cash in Bank Ledger', null); 
                                },
                                function(){
                                    return;
                            }); 
                "/></li>
		<li><g:link action="index"><g:message code="default.cancel.label" args="[entityName]" default="Cancel" /></g:link></li>
            </ul>
	</content>
    </body>
</html>
