<%@ page contentType="text/html;charset=UTF-8" %>


<!DOCTYPE html>

<html>
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <title>Other Cash Receipt Transaction - Bills Payment</title>
        
        <script type="text/javascript" src="${resource(dir: 'js', file: 'customerSearch.js')}"></script>
        <asset:javascript src="telleringHelper.js"/>
        
        <g:javascript>
            function updateVar(){
                var amount = parseFloat($('#txnAmt').val().replace(',', ''));
                if (isNaN(amount))
                    amount = 0;
                $('#CashReceiptBills').val(amount);
            }
            function initializeCustomerDetailsSearchModal(div){
                field = 'sender';
                if(div == 'txnBeneficiaryDetailsDiv') {
                    field = 'beneficiary';
                }
                modal = new icbs.UI.Modal({id:"customerDetailsModal",url:"${createLink(controller : 'search', action:'search')}",title:"Search Customer",onCloseCallback:updateCustomerDetailsForm, onCloseCallbackParams: {div: div, field: field}});
            }
            function updateCustomerDetailsForm(params){
                icbs.Tellering.Form.getForm(params.div,"${createLink(controller : 'tellering', action:'showCustomerDetailsAjax')}", params);
            }
        </g:javascript>           
    </head>
    
    <body>
        <content tag="main-content">
            <g:if test="${flash.message}">
                <script>
                        $(function(){
                            var x = '${flash.message}';
                                notify.message(x);
                                $('#SlipTransaction').hide();
                                if(x.indexOf('|success') > -1){
                                $('#SlipTransaction').show();
                            }
                           // console.log(x)
                           // setTimeout(function(){ notify.success(x); }, 3000);
                        });
                </script>
                <div id="SlipTransaction" class="alert alert-success alert-dismissable" role="alert">
                   <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <div> 
                            <a onclick="
                                     var w = window.open('printValidationSlip', '_blank')
                                         w.print();
                                     ">
                                 <g:img dir="images" file="validate.png" width="35" height="35"/>
                                 Validation Slip
                            </a>
                            &nbsp;&nbsp;
                            <a onclick="
                                    var w = window.open('printTransactionSlip', '_blank')
                                        w.print();
                                    ">
                                 <g:img dir="images" file="transactionslip.png" width="35" height="35"/>
                                 Transaction Slip 
                            </a>
                        </div> 
                </div>
            </g:if> 
            
            <g:form name="txnBillsPaymentForm" action="saveTellerOtherCashReceiptBillsPaymentTxn" controller="tellering">
                <g:render template='txnBillsPayment/form' model="[txnBillsPaymentInstance:txnBillsPaymentInstance]"/>
            </g:form>
 
        </content>
         <!--Grails tag for jasper plugin-->
         <g:jasperReport action="printSLIP"  controller="tellering" format="PDF" name="TRANSACTION"  jasper="SLIP">
         </g:jasperReport>
        <content tag="main-actions">
            <ul>
                <li><a class="save" onclick="
                            if(!$('#txnTemplate').val()){
                                notify.message('Transaction type Required!|error|alert');return;   
                            }
                            if(!$('#txnDepID').val()){
                                notify.message('Customer Required!|error|alert');return;   
                            }
                            if($('#CashReceiptBills').val() == 0)
                            {
                                notify.message('Bill amount required!|error|alert');return; 
                            } 
                            if($('#CashReceiptBills').val() < 0)
                            {
                                notify.message('Bill amount must be greater than 0!|error|alert');return; 
                            }
                            if(!$('#txnRef').val()){
                                notify.message('Transaction reference Required!|error|alert');return;   
                            }
                            if(!$('#txnParticulars').val()){
                                notify.message('Transaction particulars Required!|error|alert');return;   
                            }
                            else{
                                alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                    //jQuery('#txnBillsPaymentForm').submit();
                                    checkIfAllowed($('#txnTemplate option:selected').data('code'), 'form#txnBillsPaymentForm', 'BillsPaymentOverride', $('#CashReceiptBills').val());
                                },
                                function(){
                                    return;
                                });
                            }">${message(code: 'default.button.create.label', default: 'Create')}</a></li>
                <li><g:link action="index">Tellering Index</g:link></li>
            </ul>                                        
        </content>
    </body>
</html>
