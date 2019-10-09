<%@ page contentType="text/html;charset=UTF-8" %>


<!DOCTYPE html>

<html>
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <title>Other Cash Receipt Transaction - General</title>
        <g:javascript>
            function updateVar(){
                var amount = parseFloat($('#txnAmt').val().replace(',', ''));
                if (isNaN(amount))
                    amount = 0;
                $('#CashReceiptAdjustment').val(amount);
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
                        </div>   
                </div>
            </g:if>
             <g:hasErrors bean="${txnReceiptAdjustmentInstance}">
               <g:eachError bean="${txnReceiptAdjustmentInstance}" var="error">
                <script>
                    $(function(){
                        var x = '${it}';
                        notify.message(x);
                       // console.log(x)
                       // setTimeout(function(){ notify.success(x); }, 3000);
                    });
                </script>
                </g:eachError>
                <div id= "addCustomerRelatedError" class="box-body">
<!--                <div id= "addCustomerRelatedError" class="box-body">
                    <div class="alert alert-danger alert-dismissable">
                        <i class="fa fa-ban"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Alert!</b> 
                        <ul class="errors" role="alert">
                            <div id="errorList">
                            </div>
                            <g:eachError bean="${txnReceiptAdjustmentInstance}" var="error">
                                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                            </g:eachError>
                        </ul>            
                    </div>
                </div>-->
         </g:hasErrors>
            <g:form name="txnReceiptAdjustmentForm" action="saveTellerOtherCashReceiptAdjustmentTxn" controller="tellering">
                <g:render template='txnReceiptAdjustment/form' model="[txnReceiptAdjustmentInstance:txnReceiptAdjustmentInstance]"/>
            </g:form>
 
        </content>
        
          <!--Grails tag for jasper plugin-->
         <g:jasperReport action="printSLIP"  controller="tellering" format="PDF" name="TRANSACTION"  jasper="SLIP">
         </g:jasperReport>
        
        <content tag="main-actions">
            <ul>
                <li><a class="save" onclick="
                            if(!$('#txnTemplate').val()){
                            notify.message('Transaction Type Required!|error|alert');return;   
                            }
                            if($('#CashReceiptAdjustment').val() == 0)
                            {
                                notify.message('Transaction amount required!|error|alert');return; 
                            } 
                            if($('#CashReceiptAdjustment').val() < 0)
                            {
                                notify.message('Transaction amount must be greater than 0!|error|alert');return; 
                            }
                            if(!$('#txnRef').val()){
                                notify.message('Transaction Reference Required!|error|alert');return;   
                            }
                            if(!$('#txnParticulars').val()){
                                notify.message('Particulars Required!|error|alert');return;   
                            }
                            else{
                                alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                    //jQuery('#txnReceiptAdjustmentForm').submit();
                                    checkIfAllowed($('#txnTemplate option:selected').data('code'), 'form#txnReceiptAdjustmentForm', 'txnReceiptAdjustmentOverride', $('#CashReceiptAdjustment').val());
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
