<%@ page contentType="text/html;charset=UTF-8" %>


<!DOCTYPE html>

<html>
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <title>Loan Cash Payment Transaction</title>
        
        <script type="text/javascript" src="${resource(dir: 'js', file: 'customerSearch.js')}"></script>
        <asset:javascript src="telleringHelper.js"/>

        <g:javascript>
            function updateBreakdown() {
                var amount = accounting.unformat($('#paymentAmt').val());
                if (isNaN(amount))
                    amount = 0;
                $('#test_Loan').val(amount);

                var otherBalance = accounting.unformat($('#otherBalance').val());
                if(isNaN(otherBalance))
                otherBalance = 0;
                var taxBalance = accounting.unformat($('#taxBalance').val());
                if(isNaN(taxBalance))
                taxBalance = 0;
                var chargeBalance = accounting.unformat($('#chargeBalance').val());        
                if(isNaN(chargeBalance))
                chargeBalance = 0;
                var penaltyBalance = accounting.unformat($('#penaltyBalance').val());  
                if(isNaN(penaltyBalance))
                penaltyBalance = 0;
                var interestBalance = accounting.unformat($('#interestBalance').val());
                if(isNaN(interestBalance)) {
                    interestBalance = 0;
                } else {
                    if (interestBalance < 0)
                        interestBalance = 0;
                }
                
                var principalBalance = accounting.unformat($('#principalBalance').val());
                if(isNaN(principalBalance))
                principalBalance = 0;

//                $('#test_Loan1').val(otherBalance);
//                $('#test_Loan2').val(taxBalance);
//                $('#test_Loan3').val(chargeBalance);
//                $('#test_Loan4').val(penaltyBalance);
//                $('#test_Loan5').val(interestBalance);
//                $('#test_Loan6').val(principalBalance);

                if (amount > otherBalance) {
                    $('#others').val(addCommas(otherBalance.toFixed(2)));
                    amount =  amount - otherBalance;
                } else {
                    $('#others').val(addCommas((otherBalance - amount).toFixed(2)));
                    amount = 0;
                }

                if (amount > taxBalance) {
                    $('#tax').val(addCommas(taxBalance.toFixed(2)));
                    amount =  amount - taxBalance;
                } else {
                    $('#tax').val(addCommas((taxBalance - amount).toFixed(2)));
                    amount = 0;
                }

                if (amount > chargeBalance) {
                    $('#serviceCharge').val(addCommas(chargeBalance.toFixed(2)));
                    amount =  amount - chargeBalance;
                } else {
                    $('#serviceCharge').val(addCommas(amount.toFixed(2)));
                    amount = 0;
                }

                if (amount > penaltyBalance) {
                    $('#penalty').val(addCommas(penaltyBalance.toFixed(2)));
                    amount =  amount - penaltyBalance;
                } else {
                    $('#penalty').val(addCommas(amount.toFixed(2)));
                    amount = 0;
                }

                if (amount > interestBalance) {
                    $('#interest').val(addCommas(interestBalance.toFixed(2)));
                    amount =  amount - interestBalance;
                } else {
                    $('#interest').val(addCommas(amount.toFixed(2)));
                    amount = 0;
                }

                if (amount > principalBalance) {
                    $('#principal').val(addCommas(principalBalance.toFixed(2)));
                    amount =  amount - principalBalance;
                } else {
                    $('#principal').val(addCommas(amount.toFixed(2)));
                    amount = 0;
                }
            }
            
            function addCommas(nStr)
            {
                nStr += '';
                x = nStr.split('.');
                x1 = x[0];
                x2 = x.length > 1 ? '.' + x[1] : '';
                var rgx = /(\d+)(\d{3})/;
                while (rgx.test(x1)) {
                        x1 = x1.replace(rgx, '$1' + ',' + '$2');
                }
                return x1 + x2;
            }

            var modal;
            function refreshForm(params){
                if(params.loan2){
                    //icbs.Tellering.loanDetails('getLoanDetailsCallback',"${createLink(controller : 'tellering', action:'changeLoanDetails')}",{loan:params.loan2});
                    
                    $.ajax({
                        type: 'POST',
                        data: {loan:params.loan2},
                        url: "${createLink(controller:'tellering', action:'changeLoanDetails')}",
                        success: function(msg){
                            $('#loanId').val($(msg).find('#acctId').html());
                            $('#accountNo').html($(msg).find('#accountNo').html());
                            $('#customer').html($(msg).find('#customer').html());
                            $('#photo').html($(msg).find('#photo').html()); 
                            $('#openingDate').html($(msg).find('#openingDate').html());                                   
                            $('#status').html($(msg).find('#status').html());                           
                            $('#principal1').html($(msg).find('#principal1').html());
                            $('#intrest1').html($(msg).find('#intrest1').html());
                            $('#penalty1').html($(msg).find('#penalty1').html());
                            $('#sc1').html($(msg).find('#sc1').html());
                            $('#tax1').html($(msg).find('#tax1').html());
                            // update balance
                            $('#principalBalance').val($(msg).find('#principal').html());
                            $('#interestBalance').val($(msg).find('#interest').html());
                            $('#penaltyBalance').val($(msg).find('#penalty').html());
                            $('#chargeBalance').val($(msg).find('#serviceCharge').html());
                            $('#taxBalance').val($(msg).find('#tax').html());
                            $('#otherBalance').val($(msg).find('#others').html());

                            updateBreakdown();
                        },
                        error:function(XMLHttpRequest,textStatus,errorThrown){
                            alert(XMLHttpRequest+textStatus+errorThrown);
            		}
                    });
                    
                }
            }
            function initializeLoanAcctSearchModal(){
                modal = new icbs.UI.Modal({id:"loanModal",url:"${createLink(controller : 'loan', action:'search', params:[searchDomain: "loan"])}",title:"Search Loan Account",onCloseCallback:refreshForm});
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
            <g:hasErrors bean="${txnLoanCashRepaymentInstance}">
                <script>
                    $(function(){
                        var x = '${it}';
                        notify.error(x);
                       // console.log(x)
                       // setTimeout(function(){ notify.success(x); }, 3000);
                    });
                </script>
<!--            <div id= "addCustomerRelatedError" class="box-body">
                    <div class="alert alert-danger alert-dismissable">
                        <i class="fa fa-ban"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Alert!</b> 
                        <ul class="errors" role="alert">
                            <div id="errorList">
                            </div>
                            <g:eachError bean="${txnLoanCashRepaymentInstance}" var="error">
                                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                            </g:eachError>
                        </ul>            
                    </div>
                </div>-->
            </g:hasErrors>
            <g:form name="txnLoanCashRepaymentForm" action="saveTellerLoanCashRepaymentTxn" controller="tellering">
                <g:render template='txnLoanCashRepayment/form' model="[txnLoanCashRepaymentInstance:txnLoanCashRepaymentInstance]"/>
            </g:form>
 
        </content>
        
        <!--Grails tag for jasper plugin-->
         <g:jasperReport action="printSLIP"  controller="tellering" format="PDF" name="TRANSACTION"  jasper="SLIP">
         </g:jasperReport>
        
        <content tag="main-actions">
            <ul>
                <li><a class="save" onclick="
                        if(!$('#txnTemplate').val()){
                            notify.message('Transaction type required!|error|alert');return;   
                        }
                        if(!$('#loanId').val()){
                            notify.message('Customer required!|error|alert');return;   
                        }
                        if($('#test_Loan').val() == 0)
                        {
                            notify.message('Payment amount required!|error|alert');return; 
                        }
                        if($('#test_Loan').val() < 0)
                        {
                            notify.message('Payment amount must be greater than 0!|error|alert');return; 
                        }
                        // check for overpayment
                        // transferred to controller
                        //alert(accounting.unformat(accounting.unformat($('#principalBalance').val()).toFixed(2)) + accounting.unformat(accounting.unformat($('#interestBalance').val()).toFixed(2)) + accounting.unformat(accounting.unformat($('#penaltyBalance').val()).toFixed(2)) + accounting.unformat(accounting.unformat($('#chargeBalance').val()).toFixed(2)));
                        //alert($('#test_Loan').val());
                        //if (accounting.unformat(accounting.unformat($('#principalBalance').val()).toFixed(2)) + accounting.unformat(accounting.unformat($('#interestBalance').val()).toFixed(2)) + accounting.unformat(accounting.unformat($('#penaltyBalance').val()).toFixed(2)) + accounting.unformat(accounting.unformat($('#chargeBalance').val()).toFixed(2)) < $('#test_Loan').val()) {
                        //        notify.message('Loan overpayment!|error|alert');return; 
                        //}                        
                        if(!$('#txnRef').val()){
                            notify.message('Transaction reference required!|error|alert');return;   
                        }
                        else{
                            alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                            function(){
                                //jQuery('#txnLoanCashRepaymentForm').submit();
                                checkIfAllowed($('#txnTemplate option:selected').data('code'), 'form#txnLoanCashRepaymentForm', 'txnLoanCashRepaymentOverride', $('#test_Loan').val());
                            },
                            function(){
                                return;
                            });
                        }">${message(code: 'default.button.create.label', default: 'Create')}</a></li>
                <li><g:link action="index" >Tellering Index</g:link></li>
            </ul>                                        
        </content>
    </body>
</html>
