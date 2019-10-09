<%@ page contentType="text/html;charset=UTF-8" %>


<!DOCTYPE html>

<html>
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <title>Loan Check Payment Transaction</title>
        
        <script type="text/javascript" src="${resource(dir: 'js', file: 'customerSearch.js')}"></script>
        <asset:javascript src="telleringHelper.js"/>

        <g:javascript>
            function updateBreakdown() {
                var amount = accounting.unformat($('#paymentAmt').val());
                if (isNaN(amount))
                    amount = 0;
                    $('#test_Loan').val(amount);

                var otherBalance = accounting.unformat($('#otherBalance').val().replace(',', ''));
                if(isNaN(otherBalance))
                otherBalance = 0;
                var taxBalance = accounting.unformat($('#taxBalance').val().replace(',', ''));
                if(isNaN(taxBalance))
                taxBalance = 0;
                var chargeBalance = accounting.unformat($('#chargeBalance').val().replace(',', ''));        
                if(isNaN(chargeBalance))
                chargeBalance = 0;
                var penaltyBalance = accounting.unformat($('#penaltyBalance').val().replace(',', ''));  
                if(isNaN(penaltyBalance))
                penaltyBalance = 0;
                var interestBalance = accounting.unformat($('#interestBalance').val().replace(',', ''));
                if(isNaN(interestBalance)) {
                    interestBalance = 0;
                } else {
                    if (interestBalance < 0)
                        interestBalance = 0;
                }
                var principalBalance = accounting.unformat($('#principalBalance').val().replace(',', ''));
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
            
            function showChecks() {
                $.ajax({
                    type: 'POST',
                    url: "${createLink(controller:'tellering', action:'showChecksAjax')}",
                    success: function(msg){				    	
                        $('#check_table').html(msg);
                        $('#totalAmtCheccckPayment').val($('#Check_Control_Total').val());
                        console.log("total check payment: "+$('#totalAmtCheccckPayment').val());
                        
                },
                error:function(XMLHttpRequest,textStatus,errorThrown){
                    alert(XMLHttpRequest+textStatus+errorThrown);
                }
                });				
            }
            function addCheckAjax() {            	
                $.ajax({
                    type: 'POST',
                    data: {checkType:$('#checkType').val(), bank:$('#bank').val(), acctNo:$('#acctNo').val(), checkDate:$('#checkDate').val(), checkNo:$('#checkNo').val(), clearingDate:$('#clearingDate').val(), checkAmt:$('#checkAmt').val()},
                    url: "${createLink(controller:'tellering', action:'addCheckAjax')}",
                    success: function(msg){
                    $('#add-check-modal .modal-body').html(msg);
                    $('#add-check-modal').on('hidden.bs.modal', function() {
                        showChecks();
                    });						
                },
                error:function(XMLHttpRequest,textStatus,errorThrown){
                    alert(XMLHttpRequest+textStatus+errorThrown);
                }
            });				
            }
            function deleteCheckAjax(id) {
            	if (confirm('Are you sure?')) {
                    $.ajax({
                        type: 'POST',
                        data: {id:id},
                        url: "${createLink(controller:'tellering', action:'deleteCheckAjax')}",
                        success: function(msg){
                            showChecks();
                        },
                        error:function(XMLHttpRequest,textStatus,errorThrown){
                            alert(XMLHttpRequest+textStatus+errorThrown);
                        }
                    });
                }
            }
            function showAddChecks() {
                modal = new icbs.UI.Modal({id:"add-check-modal", url:"${createLink(controller: 'tellering', action:'showAddCheckAjax')}", title:"Add Check"});
                modal.show();
            }
            function validateOnUs() {
                $.ajax({
                        type: 'POST',
                        data: {checkTypeId:$('#checkType').val()},
                        url: "${createLink(controller:'tellering', action:'changeForm')}",
                        success: function(msg){
                           if($(msg).find('#is-on-us').html() == "true"){
                                $('#bank').attr('disabled','true');
                                $('#acct').attr('disabled','true');
                           }
                           else{
                                $('#bank').removeAttr('disabled','true');
                                $('#acct').removeAttr('disabled','true');
                           }
                        },
                        error:function(XMLHttpRequest,textStatus,errorThrown){
                            alert(XMLHttpRequest+textStatus+errorThrown);
                        }
                    });
            }
        </g:javascript> 
            
        <script type="text/javascript">
            $(function(){
             

                $('#btnAddMore').click(function(){
                    var lastRow = $('.check-table tbody > tr:last');
                    var lastIndex = parseInt(lastRow.attr('data-index'));
                    lastRow.find('select').select2('destroy');
                    var clonedRow = lastRow.clone();
                    
                    clonedRow.attr('data-index', lastIndex + 1);
                    $.each(clonedRow.find('[data-name]'), function(index,data) {
                        data = $(data);
                        data.attr('name', 'coci[' + (lastIndex + 1) + '].' + data.attr('data-name'));
                    });
                                   
                    <!--Gets the last row and appends appendRow when correct row is found-->
                    $('.check-table tbody > tr:last').after(clonedRow);

                    $('.check-table tbody').find('select').select2({allowClear: true});
                    datepickerInitializer();
                });

                <!--Deletes a row-->
                $(document).on('click', '.deleteThisRow',function(){
                    var rowLength = $('.check-table tbody > tr').size();

                    if(rowLength > 1){
                        deleteRow($(this));
                    }
                });

                function deleteRow(currentNode){
                    currentNode.parent().parent().remove();
                }
            });
        </script>               
    </head>
    
    <body>
        <content tag="main-content">
            <div class="modal" id="add-check-modal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">Add Check</h4>
                        </div>
                        <div class="modal-body">
                        </div>
                        <div class="modal-footer">
                            <a href="#" data-dismiss="modal" class="btn">Close</a>
                            <a href="#" class="btn btn-primary" onclick="addCheckAjax()">Add</a>
                        </div>
                    </div>
                </div>
            </div>
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
            <g:hasErrors bean="${txnLoanCheckRepaymentInstance}">
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
                            <g:eachError bean="${txnLoanCheckRepaymentInstance}" var="error">
                                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                            </g:eachError>
                        </ul>            
                    </div>
                </div>-->
            </g:hasErrors>
            <g:form name="txnLoanCheckRepaymentForm" action="saveTellerLoanCheckRepaymentTxn" controller="tellering">
                <g:render template='txnLoanCheckRepayment/form' model="[txnLoanCheckRepaymentInstance:txnLoanCheckRepaymentInstance]"/>
            </g:form>
 
        </content>
        
        <!--Grails tag for jasper plugin-->
         <g:jasperReport action="printSLIP"  controller="tellering" format="PDF" name="TRANSACTION"  jasper="SLIP">
         </g:jasperReport>
        
        <content tag="main-actions">
            <script>
                function createnew()
                {
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
                    //if (accounting.unformat(accounting.unformat($('#principalBalance').val()).toFixed(2)) + accounting.unformat(accounting.unformat($('#interestBalance').val()).toFixed(2)) + accounting.unformat(accounting.unformat($('#penaltyBalance').val()).toFixed(2)) + accounting.unformat(accounting.unformat($('#chargeBalance').val()).toFixed(2)) < $('#test_Loan').val()) {
                    //   notify.message('Loan overpayment!|error|alert');return; 
                    //}                    
                    if(!$('#txnRef').val()){
                        notify.message('Transaction reference required!|error|alert');return;   
                    }
                    var totChequeAmountvalue = $('#totalAmtCheccckPayment').val();
                    var paymentAmountValue = $('#paymentAmt').val();
                    console.log("totChequeAmountvalue: "+totChequeAmountvalue);
                    console.log("paymentAmountValue: "+paymentAmountValue);
                    totChequeAmountvalue = parseFloat(totChequeAmountvalue.toString().replace(/,/g , ""));                        
                    paymentAmountValue = parseFloat(paymentAmountValue.toString().replace(/,/g , ""));
                   
                    if(accounting.unformat($('#test_check').val()) > 0 ){
                        if (totChequeAmountvalue == paymentAmountValue){
                            alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                            function(){
                                
                                //jQuery('#txnLoanCheckRepaymentForm').submit();
                                checkIfAllowed($('#txnTemplate option:selected').data('code'), 'form#txnLoanCheckRepaymentForm', 'txnLoanCheckRepaymentOverride', $('#paymentAmt').val());
                            },
                            function(){
                                return;
                            });
                        }
                        else {
                            notify.message('Total Check Amount is not equal to Payment Amount!|error|alert');return;
                        }    
                    }
                    else{
                        notify.message('Please input check first!|error|alert');return;
                    }
                }
            </script>
            <ul>
                <li><a class="save" onclick="createnew()">${message(code: 'default.button.create.label', default: 'Create')}</a></li>
                <li><g:link action="index" >Tellering Index</g:link></li>
            </ul>                                    
        </content>
    </body>
</html>
