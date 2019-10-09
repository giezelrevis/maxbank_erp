<!DOCTYPE html>
<html>
    <head>
	<meta name="layout" content="main">
	<title>Create New ROPA</title>
    
    <g:javascript>
        function showLoanSearch() {				
            modal = new icbs.UI.Modal({id:"loanModal", url:"${createLink(controller: 'loan', action:'search')}", title:"Search Loan Account", onCloseCallback:updateLoanDetailsAjax});
            modal.show();
        }
        function updateLoanDetailsAjax(params) {
            if (params.loan2) {
                $('#loanID').val(params.loan2);
                
                $.ajax({
                    type: 'POST',
                    data: {id:params.loan2},
                    url: "${createLink(controller:'loan', action:'getLoanDetailsAjax')}",
                    success: function(msg){
                            console.log(msg);
                                $('#accountNo').val($(msg).find('#account-no').html());
                                $('#loanAccountName').val($(msg).find('#customer').html());                                
                    },
                    error:function(XMLHttpRequest,textStatus,errorThrown){
                        alert(XMLHttpRequest+textStatus+errorThrown);
                    }
                });
            }
        } 
        function validateGlCode(){
            var depcontra = $('#glContraLitigationExp').val();
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

                            $.each(data, function (_key, _value) {
                                console.log(JSON.stringify(obj))
                                console.log(_value.gl_code);
                                console.log(_value.name);
                                $('#gldescription').val(_value.name);

                            });

                        }else{
                            onoff = "invalidGlCode";

                            notify.message('Sorry, Invalid Gl Code!|error|alert');
                        }
                        console.log("onoff: "+onoff);
                    },
                    error: function(data){

                    },

                });                                            
            }

        }
        function validateGlCodeROPA(){
        console.log("ssssssssssssssssssss");
            var depcontra = $('#glContraRopa').val();
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

                            $.each(data, function (_key, _value) {
                                console.log(JSON.stringify(obj))
                                console.log(_value.gl_code);
                                console.log(_value.name);
                                $('#gldescriptionContra').val(_value.name);

                            });

                        }else{
                            onoff = "invalidGlCode";

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
    </head>
    <body>
	<content tag="main-content">
            <div id="create-ropa" class="content scaffold-create" role="main">
		<g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
		</g:if>
		<g:hasErrors bean="${ropaInstance}">
                    <ul class="errors" role="alert">
			<g:eachError bean="${ropaInstance}" var="error">
			<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error.field} - ${error}"/></li>
			</g:eachError>
                    </ul>
		</g:hasErrors>
		<g:form id="create" url="[resource:ropaInstance, action:'save']" >
                    <fieldset class="form">
			<g:render template="form"/>
                    </fieldset>
		</g:form>
            </div>
	</content>
	<content tag="main-actions">
            <ul>
		<li><g:submitButton id="newRopa" name="create" value="${message(code: 'default.button.create.label', default: 'Create')}" onclick="
                        alertify.confirm(AppTitle,'Are you sure you want to continue create ROPA?',
                            function(){
                                    checkIfAllowed('ADM00102', 'form#create', 'Create New ROPA', null); 
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
