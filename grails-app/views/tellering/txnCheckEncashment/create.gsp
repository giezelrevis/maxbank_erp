<%@ page contentType="text/html;charset=UTF-8" %>


<!DOCTYPE html>

<html>
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <title>Teller Check Encashment Transaction</title>
        
        <asset:javascript src="telleringHelper.js"/>

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
            var modal;
            function refreshForm(params){
                if(params.deposit){
                    icbs.Tellering.depositDetails('getDepositDetailsCallback',"${createLink(controller : 'tellering', action:'changeDepositDetails')}",{flag:4, deposit:params.deposit});
                }
            }
            function initializeDepositAcctSearchModal(){
                modal = new icbs.UI.Modal({id:"addFundTransferSearchModal",url:"${createLink(controller : 'search', action:'search', params:[searchDomain: "deposit"])}",title:"Search Deposit Accounts",onCloseCallback:refreshForm});
            }
            function showSignature(){
                $('#openDepositSignature').modal({show:true})  
            }
            function showSignatories(){
                $('#openDepositSignatories').modal({show:true})  
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
            <div class="modal" id="openDepositSignature">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">Deposit Signature</h4>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <g:if test="${(depositInstance?.customer?.attachments?.find{it.isPrimarySig==true})?.id}"> <img width="240px" height="240px"src="${createLink(controller:'Attachment', action:'show', id: (depositInstance?.customer?.attachments?.find{it.isPrimarySig==true})?.id )}"/></g:if>
                               </div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <a href="#" data-dismiss="modal" class="btn">Close</a>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="modal" id="openDepositSignatories">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">Other Owners/Signatories</h4>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                            <div class="col-xs-12 col-sm-6 col-md-6">
                                <div class="section-container">
                                    <fieldset>
                                        <div class="infowrap">
                                            <dl class="dl-horizontal">
                                                <dt>Ownership Type</dt>
                                                <dd>${depositInstance?.ownershipType?.description}</dd>
                                            </dl>
                                            <div class="table-responsive col-md-12">
                                                <g:if test="${depositInstance?.signatories?.size()>0}">
                                                    <table id="signatoryTable" class="table table-hover table-condensed table-striped">
                                                        <tr>
                                                            <td><label>CID</label></td>
                                                            <td><label>Name</label></td>
                                                            <td><label>Signatory</label></td>
                                                        </tr>
                                                        <tbody height="100px">
                                                            <div id="signatoryList">
                                                                <g:each var="signatory" in="${depositInstance?.signatories}" status="i">
                                                                    <g:if test="${signatory.status.id!=3}">
                                                                        <g:render template='form/signatory/onetomany/signatory' model="[signatory:signatory,i:i,displayOnly:'true']"/>
                                                                    </g:if>
                                                                </g:each>
                                                        </tbody>
                                                    </table>
                                                </g:if>
                                            </div>
                                            <dl class="dl-horizontal">
                                                <dt>Signatory Rules</dt>
                                                <dd>${depositInstance?.sigRules}</dd>
                                            </dl>
                                            <dl class="dl-horizontal">
                                                <dt>Signatory Remarks</dt>
                                                <dd>${depositInstance?.sigRemarks}</dd>
                                            </dl>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="#" data-dismiss="modal" class="btn">Close</a>
                        </div>
                    </div>
                </div>
            </div>


            <g:hasErrors bean="${txnCheckEncashmentInstance}">
                <script>
                    $(function(){
                        var x = '${it}';
                        notify.alert(x);
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
                            <g:eachError bean="${txnCheckEncashmentInstance}" var="error">
                                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                            </g:eachError>
                        </ul>            
                    </div>
                </div>-->
            </g:hasErrors>
            <g:form name="txnCheckEncashmentForm" action="saveTellerCheckEncashmentTxn" controller="tellering">
                <g:render template='txnCheckEncashment/form' model="[txnCheckEncashmentInstance:txnCheckEncashmentInstance]"/>
            </g:form>
 
        </content>
        
         <!--Grails tag for jasper plugin-->
         <g:jasperReport action="printSLIP"  controller="tellering" format="PDF" name="TRANSACTION"  jasper="SLIP">
         </g:jasperReport>
        
        <content tag="main-actions">
            <ul>
                <li><a class="save" onclick="funcValidateCheckEncash();">${message(code: 'default.button.create.label', default: 'Create')}</a></li>
                    
                
                
                <li><g:link action="index" >Tellering Index</g:link></li>
                <script>
                    function funcValidateCheckEncash(){
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
                    var chkAmt = accounting.unformat($('#checkAmt').val());
                    if(!$('#txnTemplate').val()){
                        notify.message('Transaction type Required!|error|alert');return; 
                    }
                    if($('#dpstatus').html() == ''){
                        notify.message('Customer is required!|error|alert');return;  
                    }
                    if($('#dpstatus').html() == 'Closed'){
                        notify.message('Account is closed, Cannot Proceed!|error|alert');return;  
                    }if(!$('#payee').val()){
                        notify.message('Empty Payee not allowed!|error|alert');return;
                    }
                if($('#checkDate').val() == ''){
                        notify.message('Check date is required!|error|alert');return;  
                    }
                if($('#checkNo').val() == ''){
                        notify.message('Check number is required!|error|alert');return;  
                    }
                if(isNaN($('#checkNo').val())){
                        notify.message('Cannot accept character value for Check Number!|error|alert');return;  
                }
                if(chkAmt==0){ notify.message('Zero amount not allowed!|error|alert'); return; 
                }
                if(chkAmt < 0){
                    notify.message('Negative amount not allowed!|error|alert'); return;
                }
//              if(!$('#txnRef').val()){ notify.message('Transaction Reference empty!|error|alert');return;};
                
                totalcash = +totalcash.toFixed(2);
                chkAmt = +chkAmt.toFixed(2);
                
                if(refreshCashOnHand < chkAmt)
                {
                    notify.message('Unable to continue transaction. Not enough cash on hand!|error|alert');return;   
                }
                
                
               // if(parseFloat($('#txnAmt').val()) != parseFloat($('#totalChecks').val())){ notify.message('Total Checks and Check Control do not match!|error|alert'); return;};
                alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                    function(){
                       //jQuery('#txnCheckEncashmentForm').submit();
                       checkIfAllowed($('#txnTemplate option:selected').data('code'), 'form#txnCheckEncashmentForm', 'txnCheckEncashmentOverride', $('#checkAmt').val());
                    },function(){
                       return;
                    });
                }
                </script>
            </ul>                                        
        </content>
    </body>
</html>
