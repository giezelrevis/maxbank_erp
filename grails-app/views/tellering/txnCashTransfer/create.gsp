<%@ page contentType="text/html;charset=UTF-8" %>


<!DOCTYPE html>

<html>
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <title>Teller Cash Transfer Transaction</title>

        <script type="text/javascript">
            var c;
        </script>
        <script type="text/javascript" src="${resource(dir: 'js', file: 'cashtransfer.js')}"></script>
    </head>
    
    
    <g:javascript>
            
            function add_commas(number){
                number = '' + number;
                if (number.length > 3) {
                        var mod = number.length % 3;
                        var output = (mod > 0 ? (number.substring(0,mod)) : '');
                        for (i=0 ; i < Math.floor(number.length / 3); i++) {
                                if ((mod == 0) && (i == 0))
                                        output += number.substring(mod+ 3 * i, mod + 3 * i + 3);
                                else
                                        output+= ',' + number.substring(mod + 3 * i, mod + 3 * i + 3);
                        }
                        return (output);
                }
                else return number;
            }
            
        </g:javascript>
    
    <body>
        <content tag="main-content">
            <g:javascript>
                var refreshCashOnHand = 0;
                $(document).ready(function() {
                    console.log("ready");
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
            </g:javascript>    
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
            <g:hasErrors bean="${txnCashTransferInstance}">
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
                            <g:eachError bean="${txnCashTransferInstance}" var="error">
                                <li <g:if test="${error in org.springframework.validation.FieldError}"> data-field-id="${error.field}"</g:if> ><g:message error="${error}"/></li>
                            </g:eachError>
                        </ul>            
                    </div>
                </div>-->
            </g:hasErrors>
            
            <g:form name="txnCashTransferForm" action="saveTellerCashTransferTxn" controller="tellering">
                <g:render template='txnCashTransfer/form' model="[txnCashTransferInstance:txnCashTransferInstance]"/>
            </g:form>
 
        </content>
        <!--Grails tag for jasper plugin-->
         <g:jasperReport action="printSLIP"  controller="tellering" format="PDF" name="TRANSACTION"  jasper="SLIP">
         </g:jasperReport>
        <content tag="main-actions">
            <ul>
                <li><a href='#' onclick="validateTelleringCashTransfer();">Create</a></li>
                <li><g:link action="receiveTellerCashTransfer">Receive Cash Transfer</g:link></li>
                <li><g:link action="index" >Tellering Index</g:link></li>
                <script>
                    function validateTelleringCashTransfer(){
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
                        
                        var txnAmtfromForm = $('#txnAmt').val();
                        txnAmtfromForm = txnAmtfromForm.replace(/,/g , '');
                        console.log("txnAmtfromForm: "+txnAmtfromForm);
                        var txnTot = accounting.unformat($('#txnAmt').val()),
                        tot = accounting.unformat($('#total').val());
                        
                        console.log("Total cash on hand: "+refreshCashOnHand);
                        
                        if( txnTot != tot )
                        {
                            notify.message('Unable to continue, Breakdown Total and Total Cash is not equal!|error|alert'); 
                            return;
                        } 
                        if(txnAmtfromForm == "" || txnAmtfromForm==null){
                            notify.message('Unable to continue, Total Cash Transferred Cannot be null!|error|alert'); 
                            return;
                        }
                        if(parseFloat(txnAmtfromForm) <= 0){
                            notify.message('Unable to continue, Total Cash Transferred Cannot be equal or less than Zero (0)!|error|alert'); 
                            return;
                        }
                        if(refreshCashOnHand < parseFloat(txnAmtfromForm)){
                            notify.message('Unable to continue, Total Cash Transferred Cannot be Greater than the Total cash on hand!|error|alert'); 
                            return;
                        }
                        if(refreshCashOnHand <= 0)
                        {
                            notify.message('Not enough Cash on hand!|error|alert'); 
                            return;
                        }                        
                        
                        if(!$('#txnTemplate').val())
                        {
                            notify.message('Transaction type required!|error|alert'); 
                            return;
                        }
                        if($('#user').val() == 'null')
                        {
                            notify.message('Destination Teller required!|error|alert'); 
                            return;
                        }
                        if(!$('#txnRef').val())
                        {
                            notify.message('Transaction Reference required!|error|alert'); 
                            return;
                        }
                        else{
                            alertify.confirm(AppTitle,"Are you sure you want to continue this transaction?",
                              function(){
                                checkIfAllowed($('#txnTemplate option:selected').data('code'), 'form#txnCashTransferForm', 'txnCashTransferOverride', $('#txnAmt').val());
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
