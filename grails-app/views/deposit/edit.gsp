<%@ page import="icbs.deposit.Deposit" %>
<!DOCTYPE html>
<html>
	<head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'deposit.label', default: 'Deposit')}" />
                <asset:javascript src="depositHelper.js"/>
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
                <g:javascript>
                     function changeRolloverForm(type){
                        var fixedDepositTermScheme = document.getElementById('fixedDepositTermScheme');
                        var startDate = document.getElementById('currentRollover.startDate');
                        var endDate  =  document.getElementById('currentRollover.endDate');
                        var endDateReadyCalculator = document.getElementById('endDateCalculator').value;
                        //var fundedDeposit = document.getElementById('currentRollover.fundedDeposit')
                        var fundedDeposit = document.getElementById('depositFromSearch');
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
                            endDate = endDateReadyCalculator;
                        }else{
                            endDate = null;
                        }
                        if (interestPaymentMode == 2) {
                            if (!fundedDeposit) {
                                fundedDeposit = null
                            } else if (fundedDeposit != 0 ) {                               
                                fundedDeposit = document.getElementById('currentRollover.fundedDeposit.id').value;
                            } else {
                                fundedDeposit = null
                            }    
                        } else {
                            fundedDeposit = null
                        }
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
                            
                    function updateCustomerDetailsForm(params){
                        
                        icbs.Deposit.Form.getForm('customerDetails',"${createLink(controller : 'deposit', action:'showCustomerDetailsAjax')}",params);
                    }
                    function updateCustomerDetForm(params){
                        icbs.Deposit.Form.getForm('customerDetails',"${createLink(controller : 'deposit', action:'showCustomerDetailsAjax')}",params);
                    }
                    function initializeCustomerDetailsSearchModal(){
                    
                        modal = new icbs.UI.Modal({id:"customerDetailsModal",url:"${createLink(controller : 'search', action:'search')}",title:"Search Customer",onCloseCallback:updateCustomerDetForm});
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
        </g:javascript>   
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><span class="current">Edit Deposit</span>
            </content>
            <content tag="main-content">
		<div id="edit-deposit" class="content scaffold-edit" role="main">
			<g:if test="${flash.message}">
                            <!-- <div class="message" role="status">${flash.message}</div> -->
                            <script>
                                $(function(){
                                    var x = '${flash.message}';
                                        notify.message(x);
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
			<g:form id="saveDepositForm" url="[resource:depositInstance, action:'update']" method="PUT" >
				<g:hiddenField name="version" value="${depositInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
			</g:form>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                     <li><a class="save" onclick="
                                alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                    //jQuery('#saveDepositForm').submit();
                                    checkIfAllowed('DEP00300', 'form#saveDepositForm', 'saveDeposit');
                                },
                                function(){
                                    return;
                                });">${message(code: 'default.button.update.label', default: 'Update')}</a>
                     </li>
                                <li><a href=# onclick="alertify.confirm(AppTitle,'Are you sure you want to return to Deposits Search page? Your progress will not be saved.',
                                    function(){
                                    var t_url = '/icbs/deposit/depositInquiry/${depositInstance?.id}';
                                    location.href=t_url;},
                                    function(){});">Return to Deposit Inquiry Page</a></li> 
                                
                </ul>
            </content>
            
	</body>
</html>
