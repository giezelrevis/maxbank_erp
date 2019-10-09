<%@ page contentType="text/html;charset=UTF-8" %>


<!DOCTYPE html>

<html>
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <title>Cash To Vault Transaction</title>

        <!-- Page specific CSS and JS -->
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'cashtovault.css')}" type="text/css">
        <script type="text/javascript">
            var c;
        </script>
        <script type="text/javascript" src="${resource(dir: 'js', file: 'cashtovault.js')}"></script>
        
        <g:javascript>
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
            <g:hasErrors bean="${txnCashToVaultInstance}">    
                <script>
                    $(function(){
                        var x = '${it}';
                        notify.error(x);
                       // console.log(x)
                       // setTimeout(function(){ notify.success(x); }, 3000);
                    });
                </script>
            </g:hasErrors>     
            <g:form name="txnCashToVaultForm" action="saveTellerCashToVaultTxn" controller="tellering">
                <g:render template='txnCashToVault/form' model="[txnCashToVaultInstance:txnCashToVaultInstance]"/>
            </g:form>
 
        </content>
        
         <!--Grails tag for jasper plugin-->
         <g:jasperReport action="printSLIP"  controller="tellering" format="PDF" name="TRANSACTION"  jasper="SLIP">
         </g:jasperReport>
        
        <content tag="main-actions">
            <ul>
                <li><a id="save" class="save" onclick="cashToVaultTransaction();">Create</a></li>
                <li><g:link action="index" onclick="return confirm('Are you sure you want to return to the Tellering Index page?');">Tellering Index</g:link></li>
                <script>
                    function cashToVaultTransaction(){
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
                        
                        var chkAmt = accounting.unformat($('#txnAmt').val());
                        txnTotal = accounting.unformat($('#total').val());
                        
                        if(!$('#txnTemplate').val())
                        {
                            notify.message('Transaction type required!|error|alert'); 
                            return;
                        }

                        if(chkAmt != txnTotal)
                        {
                            console.log(c);
                            notify.message('Unable to continue, Breakdown Total and Total Cash is not equal!|error|alert'); 
                            return;
                        } 
                        if($('#txnAmt').val() == null || $('#txnAmt').val() == ""){
                            notify.message('Unable to continue, Total Cash Cannot be null!|error|alert'); 
                            return;
                        }
                        if(chkAmt <=0 ){
                            notify.message('Unable to continue, Total Cash Cannot be equal or less than zero (0)!|error|alert'); 
                            return;
                        }
                        totalcash = +totalcash.toFixed(2);
                        chkAmt = +chkAmt.toFixed(2);
                        //alert(chkAmt);
                        //alert(totalcash);
                        console.log("the chkamt: "+chkAmt);
                        if(refreshCashOnHand < chkAmt)
                        {
                            notify.message('Unable to continue transaction. Total Cash Cannot be greater than the cash on hand!|error|alert');return;   
                        }
                        if(!$('#txnRef').val())
                        {
                            notify.message('Transaction Reference required!|error|alert'); 
                            return;
                        }
                        else{
                            alertify.confirm(AppTitle,"Are you sure you want to create this transaction?",
                              function(){
                                checkIfAllowed($('#txnTemplate option:selected').data('code'), 'form#txnCashToVaultForm', 'txnCashToVaultOverride', $('#txnAmt').val());
                              },
                              function(){
                                alertify.error('Canceled!');
                              });
                        }
                    }
                </script>
               
            </ul>                                        
        </content>
    </body>
</html>
