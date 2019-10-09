<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <asset:javascript src="depositHelper.js"/>
        <title>Fund Transfer</title>
        <g:javascript>
            var modal;
            function refreshForm(params){
                if(params.deposit){
                    icbs.Deposit.fundTransfer('changeFundedAcctFormCallback',"${createLink(controller : 'deposit', action:'changeFundTransferCreditAcct')}",{destinationAcct:params.deposit,fundingAcct:${fundTransferInstance?.fundingAcct?.id}});
                }
            }
            function initializeDepositSearchModal(){
                modal = new icbs.UI.Modal({id:"addFundTransferSearchModal",url:"${createLink(controller : 'search', action:'search', params:[searchDomain: "deposit"])}",title:"Search Deposit Accounts",onCloseCallback:refreshForm});
            }
            
            function SubmitTransfer()
            {

                if(nFix($('#amt').val()) == 0)

                {
                    notify.message("Transfer Amount is required!|error|alert");
                    return;
                }
                if(!$('#txnRef').val())
                {
                    notify.message("Transaction reference is required!|error|alert");
                    return;
                }
                if(!$('#txnDescription').val())
                {
                    notify.message("Transaction Description is required!|error|alert");
                    return;
                }
                alertify.confirm(AppTitle,"Do you want to continue with the transaction?",
                function(){
                //$('#transferFundsForm').submit();
                checkIfAllowed("DEP01100", 'form#transferFundsForm', 'transferFunds');
                },
                function(){ return; });
                
                
            }
        </g:javascript>
    </head>
    <body>
        <content tag="breadcrumbs">
            <span class="fa fa-chevron-right"></span><span class="current">Fund Transfer</span>
	</content>
        <content tag="main-content">
            <g:if test="${flash.message}">
                    <script>
                        $(function(){
                            var x = '${flash.message}';
                            notify.message(x);
                               
                        });
                </script>
            </g:if>
            <g:hasErrors bean="${fundTransferInstance}">
                <div id= "addCustomerRelatedError" class="box-body">
                    <div class="alert alert-danger alert-dismissable">
                        <i class="fa fa-ban"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Alert!</b> 
                        <ul class="errors" role="alert">
                            <div id="errorList">

                            </div>
                            <g:eachError bean="${fundTransferInstance}" var="error">
                                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                            </g:eachError>
                        </ul>            
                    </div>
                </div>
            </g:hasErrors>
            <fieldset>
                <legend>Debit Account</legend>
                <div class="row">
                    <div class="col-md-12">
                       <g:render template='/customer/details/newCustomerDetailedInfo' model="[customerInstance:fundTransferInstance?.fundingAcct?.customer]"/>
                    </div>
                    <div class="col-md-12">
                       <g:render template='details/depositDetails' model="[depositInstance:fundTransferInstance?.fundingAcct]"/>
                    </div>
                </div>
            </fieldset>
            <fieldset>
                <legend>Credit Account</legend>
                <div id="creditAccountDiv">
                    <g:render template='fundTransfer/templates/creditAccount' model="[fundTransferInstance:fundTransferInstance]"/>
                </div>
            </fieldset>
            <div class="row">
                <fieldset>
                    <legend>Transaction Details</legend>
                    <g:form name="transferFundsForm" action="saveFundTransfer" class="form-horizontal">
                        <div class="row" id="transactionDetailsDiv">
                            <g:render template='fundTransfer/templates/transactionDetails' model="[fundTransferInstance:fundTransferInstance]"/>
                        </div>
                    </g:form>
                </fieldset>
            </div>
        </content>
        <content tag="main-actions">
            <ul>
                <li><button onclick="SubmitTransfer()">Transfer Funds</button></li>

                <li><a href="#" onclick="alertify.confirm(AppTitle,'Are you sure you want to return to Deposit Inquiries page?',
                                    function(){
                                    var t_url = '/icbs/deposit/depositInquiry/${fundTransferInstance.fundingAcct?.id}';
                                    location.href=t_url;},
                                    function(){});">Return to Deposit Inquiry Page</a></li>

            </ul>                                        
        </content>
    </body>
</html>
