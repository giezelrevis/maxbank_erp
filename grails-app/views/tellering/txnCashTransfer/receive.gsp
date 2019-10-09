<%@ page contentType="text/html;charset=UTF-8" %>


<!DOCTYPE html>

<html>
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <title>Teller Cash Transfer Transaction (Receiving)</title>

        <script type="text/javascript">
            var c;
        </script>
        
    </head>

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
                                console.log("refreshCashOnHand: "+refreshCashOnHand);
                            });
                           // console.log(coh.length);
                            $('#cashoh').html(coh.substr(0,coh.length-1));

                        }   
                    });
                    xhttp.open('GET', '/icbs/tellering/getCashOnHand');
                    xhttp.send();
                }
            </g:javascript> 

                 
                <g:hiddenField id="txnfile" name="myField" value="${session["transactionFileId"]}" />
                <g:form name="txnCashTransferForm" controller="tellering">
                <g:render template='txnCashTransfer/receiveform' model="[txnCashTransferInstance:txnCashTransferInstance,sourcetxn:sourcetxn]"/>
                <g:actionSubmit id="tlrcashsave" value="Sum" action="receiveTellerCashTransferSave" style="display:none"/>
		<g:actionSubmit id="tlrcashcancel" value="Difference" action="receiveTellerCashCancel" style="display:none"/>
            </g:form>
               <g:if test="${flash.message}">
                    <script>
                            $(function(){
                                var x = '${flash.message}';
                                    //notify.message(x);
                                    console.log('log: '+x);
                                    alertify.alert(AppTitle,""+x, function(){
                                        asd();
                                    });
                            });
                            function asd(){
                                var w = window.open("${g.createLink(controller: 'tellering', action: 'printValidationSlip', params: [txnFile:session.transactionFileId])}",'_blank');
                                w.print();        
                            }
                    </script>
                    </br></br>
                    <div id="SlipTransaction" class="alert alert-success alert-dismissable" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                            <div> 
                            <a id="validationSlipClick" onclick="javascript:asd()" target="_blank">
                                <g:img dir="images" file="validate.png" width="35" height="35"/>
                                Validation Slip
                            </a>
                            </div>   
                    </div>
                </g:if>                
 
        </content>
         <!--Grails tag for jasper plugin-->
         <g:jasperReport action="printSLIP"  controller="tellering" format="PDF" name="TRANSACTION"  jasper="SLIP">
         </g:jasperReport>
        <content tag="main-actions">
            <ul>
                <li><a class="save" onclick="validateFunctionReceive();">${message(code: 'Receive', default: 'Receive')}</a></li>
                <li><a class="save" link action="" onclick="funcCancelTransaction(); ">Cancel Transaction</a></li>
                <li><g:link action="index">Tellering Index</g:link></li>
                <script>
                    function validateFunctionReceive(){
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
                        
                        if($('#txnTemplate').val() === '-- Select a transaction reference --') {
                            notify.message('No transaction to receive|error|alert'); 
                            return;
                        }if(!$('#txnTemplate').val()){ 
                            notify.message('No transaction to receive|error|alert'); 
                            return;
                        }else{
                            alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                    $('#tlrcashsave').click();
                                },
                                function(){
                                    return;
                                });
                        }
                    }
                    function funcCancelTransaction(){
                        if($('#txnTemplate').val() == '-- Select a transaction reference --'){ 
                            notify.message('No transaction to cancel.|error|alert'); 
                            return;
                        }else{
                            alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                            function(){
                                $('#tlrcashcancel').click();
                            },
                            function(){
                                return;
                            });
                        }
                    }
                </script>
            </ul>                                        
        </content>
    </body>
</html>
