<%@ page contentType="text/html;charset=UTF-8" %>


<!DOCTYPE html>

<html>
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <title>Other Cash Payment Transaction - General</title>


    </head>
    
    <body>
        <content tag="main-content">
            <script>
                var refreshCashOnHand = 0;
            $( document ).ready(function() {
                refreshCashOnhandNow();
            });
            function refreshCashOnhandNow(){
                console.log("refreshing cash on hand... ");
                var xhttp = new XMLHttpRequest();

                if (!xhttp) {
                  alert('Giving up :( Cannot create an XMLHTTP instance');
                  return false;
                }

                xhttp.onreadystatechange = (function(){
                    if (xhttp.readyState == 4 && xhttp.status == 200) {
                        var coh = 'Cash on Hand :';
                        totJSON = xhttp.responseText;
                        $.each(JSON.parse(totJSON),function(key,val){
                            coh += ' ' + val.code + ' ' + accounting.formatNumber((val.cashin - val.cashout),2) + ' |';

                            //totalcashin = val.cashin - val.cashout;
                            refreshCashOnHand = accounting.formatNumber((val.cashin - val.cashout),2)
                            
                        });
                       // console.log(coh.length);
                        $('#cashoh').html(coh.substr(0,coh.length-1));

                    }   
                });
                xhttp.open('GET', '/icbs/tellering/getCashOnHand');
                xhttp.send();
            }
            </script>    
            
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
            <g:hasErrors bean="${txnPaymentAdjustmentInstance}">
                    <script>
                        $(function(){
                            var x = '${it}';
                            notify.error(x);
                           // console.log(x)
                           // setTimeout(function(){ notify.success(x); }, 3000);
                        });
                    </script> 
<!--                <div id= "addCustomerRelatedError" class="box-body">
                    <div class="alert alert-danger alert-dismissable">
                        <i class="fa fa-ban"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Alert!</b> 
                        <ul class="errors" role="alert">
                            <div id="errorList">
                            </div>
                            <g:eachError bean="${txnPaymentAdjustmentInstance}" var="error">
                                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                            </g:eachError>
                        </ul>            
                    </div>
                </div>-->
            </g:hasErrors>
            <g:form name="txnPaymentAdjustmentForm" action="saveTellerOtherCashPaymentAdjustmentTxn" controller="tellering">
                <g:render template='txnPaymentAdjustment/form' model="[txnPaymentAdjustmentInstance:txnPaymentAdjustmentInstance]"/>
            </g:form>
 
        </content>
        
          <!--Grails tag for jasper plugin-->
         <g:jasperReport action="printSLIP"  controller="tellering" format="PDF" name="TRANSACTION"  jasper="SLIP">
         </g:jasperReport>
        
        <content tag="main-actions">
            <ul>
                <li><a class="save" onclick="validateOtherCashPaymentGeneral();">Create</a></li>
                <li><g:link action="index" >Tellering Index</g:link></li>
                <script>
                    function validateOtherCashPaymentGeneral(){
                    // =============== refresh cash on hand before condition ============
                            refreshCashOnhandNow();
                    //======================================================  
                         console.log("Create already click CASH ON HAND: "+refreshCashOnHand);
                        //refreshCashOnHand = parseFloat(refreshCashOnHand.replace(/,/g , ""));
                        console.log("new cash on hand: "+refreshCashOnHand);
                        
                        if(parseFloat(refreshCashOnHand)==0){
                           
                            refreshCashOnHand = parseFloat(refreshCashOnHand);
                        }else{
                            refreshCashOnHand = parseFloat(refreshCashOnHand.replace(/,/g , ""));
                        }
                    
                        totalcash = +totalcash.toFixed(2);
                        console.log("pasok na dito sa loggggggg....: "+totalcash);
                        if(!$('#txnTemplate').val()){
                            notify.message('Transaction type required!|error|alert');return;   
                        }
                        console.log("txn amount:::::: "+$('#txnAmt').val());
                        var newtxnAmt =  $('#txnAmt').val().replace(/,/g , "");
                        
                        console.log("newtxnAmt: "+newtxnAmt);
                        if(newtxnAmt == 0)
                        {
                            notify.message('Transaction amount required!|error|alert');return; 
                        } 
                        if(newtxnAmt < 0)
                        {
                            notify.message('Transaction amount must be greater than 0!|error|alert');return; 
                        }
                        if(!$('#txnRef').val()){
                            notify.message('Transaction reference required!|error|alert');return;   
                        }
                        
                        if(refreshCashOnHand < newtxnAmt)
                        {
                            notify.message('Unable to continue transaction. Not enough cash on hand!|error|alert');return;   
                        }                         
                        if(!$('#txnParticulars').val()){
                            notify.message('Particulars required!|error|alert');return;   
                        }
                        else{
                            alertify.confirm("AppTitle,'Are you sure you want to continue this transaction?",
                              function(){
                                checkIfAllowed($('#txnTemplate option:selected').data('code'), 'form#txnPaymentAdjustmentForm', 'txnPaymentAdjustmentOverride', $('#txnAmt').val());
                              },
                              function(){
                                alertify.error('Canceled');
                              });                        
                        }
                        
                    }
                </script>
            </ul>                                        
        </content>
    </body>
</html>
