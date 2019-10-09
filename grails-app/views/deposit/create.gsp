<!DOCTYPE html>
<html>
	<head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'deposit.label', default: 'Deposit')}" />
                <asset:javascript src="depositHelper.js"/>
                <title><g:message code="default.create.label" args="[entityName]" /></title>
                <g:javascript>
                    function changeRolloverForm(type){
                        
                        var fixedDepositTermScheme = document.getElementById('fixedDepositTermScheme');
                        var startDate = document.getElementById('currentRollover.startDate');
                        var endDate  =  document.getElementById('currentRollover.endDate');
                        var fundedDeposit = document.getElementById('currentRollover.fundedDeposit')
                        var interestPaymentMode = document.getElementById('currentRollover.interestPaymentMode');
                        if(depositInterestScheme){
                            depositInterestScheme=depositInterestScheme.value;
                        }else{
                            depositInterestScheme = null;
                        }
                        if(interestPaymentMode){
                            interestPaymentMode = interestPaymentMode.value
                        }else{
                            interestPaymentMode = null
                        }
                        if(startDate){
                            startDate=startDate.value;
                        }else{
                            startDate = null;
                        }
                        if(endDate){
                            endDate=endDate.value;
                        }else{
                            endDate = null;
                        }
                        
                        //Get 1 day in milliseconds
                        var one_day=1000*60*60*24;
                        var NewstartDate = new Date(parseFloat(startDate.substring(6, 10)),parseFloat(startDate.substring(0, 2)),parseFloat(startDate.substring(3, 5)));
                        var NewendDate = new Date(parseFloat(endDate.substring(6, 10)),parseFloat(endDate.substring(0, 2)),parseFloat(endDate.substring(3, 5)));
                        
                        // Convert both dates to milliseconds
                        var NewstartDate_ms = NewstartDate.getTime();
                        var NewendDate_ms = NewendDate.getTime();
                        
                        // Calculate the difference in milliseconds
                        var difference_ms = NewendDate_ms - NewstartDate_ms;
                        
                        // Convert back to days and return
                        var DateTot = Math.round(difference_ms/one_day)

                        $('#RollTerm').val(DateTot);
                        icbs.Deposit.Form.getForm('rollback',"${createLink(controller : 'deposit', action:'changeRolloverFormAjax')}",{fundedDeposit:fundedDeposit,type:type,fixedDepositTermScheme:fixedDepositTermScheme.value,startDate:startDate,endDate:endDate,product:product.value,depositInterestScheme:depositInterestScheme,interestPaymentMode:interestPaymentMode});           
                    }
                    function showSignatories(e){
                        if(e){
                            if(e.options[e.selectedIndex].value==1){
                                document.getElementById('signatory-main-div').style.display = 'none';
                            }else{
                                document.getElementById('signatory-main-div').style.display = 'block';
                            }
                        }
                    }
                    var modal;
                    
                    function changeTypeProductSchemeForm(changed){
                        if(changed!=null){
                            if(changed==="type"){
                                icbs.Deposit.Form.getForm('type',"${createLink(controller : 'deposit', action:'changeDepositFormAjax')}",$('#saveDepositForm').serialize());
                            }
                            if(changed==="product"){
                                 icbs.Deposit.Form.getForm('product',"${createLink(controller : 'deposit', action:'changeDepositFormAjax')}",$('#saveDepositForm').serialize());
                            }
                        }
                    }
                    function updateCustomerDetailsForm(params){
                        icbs.Deposit.Form.getForm('customerDetails',"${createLink(controller : 'deposit', action:'showCustomerDetailsAjax')}",params);
                    }
                    function initializeCustomerDetailsSearchModal(){
                        modal = new icbs.UI.Modal({id:"customerDetailsModal",url:"${createLink(controller : 'search', action:'search')}",title:"Search Customer",onCloseCallback:updateCustomerDetailsForm});
                    }
                    function addSignatoryAjax(params){
                        icbs.Deposit.Form.getForm('signatory',"${createLink(controller : 'deposit', action:'addSignatoryFormAjax')}",params);
                    }
                    function initializeSignatorySearchModal(){
                        modal = new icbs.UI.Modal({id:"signatorySearchModal",url:"${createLink(controller : 'search', action:'search')}",title:"Search Customer",onCloseCallback:addSignatoryAjax});
                    }
                    function updateRollbackDepositAccountForm(params){
                        params.boxName = "Transfer to Deposit Account";
                         icbs.Deposit.Form.getForm('rolloverDepositDetails',"${createLink(controller : 'deposit', action:'showDepositDetailsAjax')}",params);
                    }

                    function initializeRollbackToDepositModal(){
                        modal = new icbs.UI.Modal({id:"rollbackToDepositModal",url:"${createLink(controller : 'search', action:'search')}",title:"Search Deposit",onCloseCallback:updateRollbackDepositAccountForm,params:{'searchDomain':'deposit'}});
                        
                    }
   
                    function createnew()
                            {
                                if(!$('#type').val()){
                                    notify.message('Deposit type required!|error|alert');return;   
                                }
                                if(!$('#product').val()){
                                    notify.message('Deposit product required!|error|alert');return;   
                                }
                                if(!$('#depositInterestScheme').val()){
                                    notify.message('Deposit interest scheme required!|error|alert');return;   
                                }
                                if(type.value == 3){
                                    if(!$('#fixedDepositPreTermScheme').val()){
                                        notify.message('Fixed deposit preterm scheme required!|error|alert');return;   
                                    }
                                    if(!$('#fixedDepositermScheme').val()){
                                        notify.message('Fixed deposit term scheme required!|error|alert');return;   
                                    }
                                }
                                if($('#Customer_status').val() == 'Locked')
                                {
                                    notify.message("Unable to create deposit. Account is Locked!|error|alert");
                                    return;
                                }
                                if($('#Customer_status').val() == 'Cancelled')
                                {
                                    notify.message("Unable to create deposit. Account is Cancelled!|error|alert");
                                    return;
                                }
                                
                                if($('#Customer_status').val() != 'Pending' && $('#Customer_status').val() != ''){
                                    alertify.confirm(AppTitle,'Are you sure you want to Proceed?',
                                    function(){jQuery('#saveDepositForm').submit();},
                                    //function() {checkIfAllowed("DEP00200", 'form#saveDepositForm', 'saveDeposit');},
                                    function(){return;});
                                    
                                }else{
                                    if($('#Customer_status').val() != ''){
                                        notify.message('Update customer status first into "active".|info|alert');
                                        return;
                                    }else{
                                        notify.message('Select customer first.|info|alert');
                                        return;
                                    }
                                }
                            }
                            
                            
                    function createnewfirst()
                            {
                                if(!$('#type').val()){
                                    notify.message('Deposit type required!|error|alert');return;   
                                }
                                if(!$('#product').val()){
                                    notify.message('Deposit product required!|error|alert');return;   
                                }
                                if(!$('#depositInterestScheme').val()){
                                    notify.message('Deposit interest scheme required!|error|alert');return;   
                                }
                                if(type.value == 3){
                                    if(!$('#fixedDepositPreTermScheme').val()){
                                        notify.message('Fixed deposit preterm scheme required!|error|alert');return;   
                                    }
                                    if(!$('#fixedDepositermScheme').val()){
                                        notify.message('Fixed deposit term scheme required!|error|alert');return;   
                                    }
                                }
                                if($('#Customer_status').val() != 'Pending' && $('#Customer_status').val() != ''){
                                    if($('#DepTypeId').val() != 3){
                                        alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                        function(){
                                            //jQuery('#saveDepositForm').submit();
                                            checkIfAllowed("DEP00200", 'form#saveDepositForm', 'saveDeposit');
                                        },
                                        function(){
                                            return;
                                        }); 
                                    }else{
                                        if(parseFloat($('#RollTerm').val()) <= parseFloat($('#DepSchemValMax').val())){
                                            if(parseFloat($('#RollTerm').val()) >= parseFloat($('#DepSchemValMin').val())){
                                                alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                                function(){
                                                    jQuery('#saveDepositForm').submit();
                                                },
                                                function(){
                                                    return;
                                                });
                                            }else{
                                                notify.message('Term cannot be less than default min term.|error|alert');return;
                                            }
                                        }else{
                                            notify.message('Term cannot be greater than default max term.|error|alert');return;
                                        }
                                    }
                                    
                                }else{
                                    if($('#Customer_status').val() != ''){
                                        notify.message('Update customer status first into "active".|info|alert');
                                        return;
                                    }else{
                                        notify.message('Select customer first.|info|alert');
                                        return;
                                    }
                                }
                                
                                
                               
                            }
                            
                            
                </g:javascript>     

        </head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><span class="current">Create Deposit</span>
            </content>
            <content tag="main-content">
		<div id="create-deposit" class="content scaffold-create" role="main">
			<g:if test="${flash.message}">
                            <script>
                            $(function(){
                                var x = '${flash.message}';
                                notify.message(x);
                                $('#SlipTransaction').hide();
                            });
                            </script>
			</g:if>
			<g:hasErrors bean="${depositInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${depositInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
                        <g:if test="${firstCreate==true}">         
                                <g:form id="saveDepositForm"url="[controller:'deposit',action:'create']" >
                                    <g:hiddenField name="firstCreate" value="${firstCreate}"/>
                                    
                                    <fieldset class="form">
                                        <div id="typeAndProductSchemeDiv">
                                            <g:render template="form/deposit/typeAndProduct"/>
                                        </div>
                                    </fieldset>
                                </g:form>
                        </g:if>
                        <g:else>
                                <g:form id="saveDepositForm" url="[resource:depositInstance,controller:'deposit', action:'save']" >
                                        <g:hiddenField name="firstCreate" value="${firstCreate}"/>
                                        <fieldset class="form">
                                                <g:render template="form"/>
                                        </fieldset>
                                </g:form>
                        </g:else>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <g:if test="${!firstCreate}">
                    <li><a class="save" onclick="createnewfirst()">${message(code: 'default.button.create.label', default: 'Create')}</a></li>
                    <!--<li><a class="save" onclick="var con = confirm('Are you sure you want to create this Deposit Account?');
                                                                if(con){jQuery('#saveDepositForm').submit()
                                                                }else{
                                                                    return con
                                                                }">${message(code: 'default.button.create.label', default: 'Create')}</a></li> -->
                    </g:if>
                    <g:else>
                            <!--<li><a class="save" onclick="var con = confirm('Are you sure you want to Proceed?');
                                                                      if(con){jQuery('#saveDepositForm').submit()
                                                                      }else{
                                                                          return con
                                                                      }">Continue to Deposit Form</a></li>-->
                        
                    <li><a class="save" onclick="createnew()">Continue to Deposit Form</a></li>                                             
                    </g:else>
                    
                    <li><a href="#" onclick="alertify.confirm(AppTitle,'Are you sure you want to return to Deposits Search page? Your progress will not be saved.',
                                    function(){
                                    location.href='/icbs/deposit';},
                                    function(){});">Cancel</a></li> 
                </ul>
            </content>
	</body>
</html>
