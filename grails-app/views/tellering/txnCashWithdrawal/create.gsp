<%@ page contentType="text/html;charset=UTF-8" %>


<!DOCTYPE html>

<html>
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <title>Cash Withdrawal Transaction</title>
        
        <script type="text/javascript" src="${resource(dir: 'js', file: 'customerSearch.js')}"></script>
        <asset:javascript src="telleringHelper.js"/>
        <asset:javascript src="checkPassbookBal.js"/>
        
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
            function updateVar() {
                //DEPAMT = nFix(debitAmt.value); //parseFloat($('#debitAmt').val().replace(',', ''));
                //if (isNaN(DEPAMT))
                //    DEPAMT = 0;
                //$('#depAmt').val(DEPAMT);
                depAmt.value = accounting.unformat(debitAmt.value);
            }
            var modal;
            var flag;
            flag = 0;
            function refreshForm(params){
                if(params.deposit){
                    icbs.Tellering.depositDetails('getDepositDetailsCallback',"${createLink(controller : 'tellering', action:'changeDepositDetails')}",{flag:1, deposit:params.deposit});
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
                            &nbsp;&nbsp;
                            
                            <a onclick="
                                if ($('#passbookline').val() == 1 && $('#id').val() != $('#jrxmlTcId').val() ) {
                                    alertify.confirm(AppTitle,'Passbook page reach the maximum line, turn to next page.',
                                        function(){
                                        var w = window.open('printPassbookTransactions', '_blank');
                                        w.print(); 
                                    },
                                function(){return;});
                                }
                                
                                else {
                                    var w = window.open('printPassbookTransactions', '_blank');
                                        w.print(); 
                                }
                                ">
                                 <g:img dir="images" file="passbook-icon.jpg" width="35" height="35"/>
                                 Passbook
                            </a>
                                <p><input id="passbookline"  name="passbookline" required="" value="${passbookline}" style="display:none"/></p>
                                    <p><input id="id"  name="id" required="" value="${id}" style="display:none"/></p>
                                <p><input id="jrxmlTcId"  name="jrxmlTcId" required="" value="${jrxmlTcId}" style="display:none"/></p>
                        </div>   
                </div>
            </g:if>
            
            <g:hasErrors bean="${txnCashWithdrawalInstance}">
                <script>
                    $(function(){
                        var x = '${it}';
                        notify.message(x);
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
                            <g:eachError bean="${txnCashWithdrawalInstance}" var="error">
                                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                            </g:eachError>
                        </ul>            
                    </div>
                </div>-->
            </g:hasErrors>
            
            <g:form name="txnCashWithdrawalForm" action="saveTellerCashWithdrawalTxn" controller="tellering">
                <div class="col-sm-10">
                    <g:render template='txnCashWithdrawal/form' model="[txnCashWithdrawalInstance:txnCashWithdrawalInstance]"/>
                </div>
            </g:form>

        </content>
        
         <!--Grails tag for jasper plugin-->
         <g:jasperReport action="printSLIP"  controller="tellering" format="PDF" name="TRANSACTION"  jasper="SLIP">
         </g:jasperReport>
        
        <content tag="main-actions">
            <ul>
                <li><a href="#" onClick="validateFieldCashWithdraw();">Create</a></li>
                
                <li><g:link action="index" >Tellering Index</g:link></li>
                <script>
                    function validateFieldCashWithdraw(){
                        
                        var debitAmtValue = $('#debitAmt').val()
                        var nanValueValidator = NaN;
                        debitAmtValue = parseFloat(debitAmtValue.replace(/,/g , ""));
                        
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
                        

                        if(!$('#txnTemplate').val()){
                            notify.message('Transaction type Required!|error|alert');return; 
                        } if ($('#txnTemplate option:selected').data('requirePassbook')== 'Yes') {
                            
                            if($('#IssuePassbook').html() != 'Yes') {
                                notify.message('No passbook issued!|error|alert');return;
                            }
                        }if($('#dpstatus').html() == ''){
                            notify.message('Customer is required!|error|alert');return;  
                        }if($('#dpstatus').html() == 'Locked/Frozen'){
                            notify.message('Account is Locked/Frozen, Cannot Proceed!|error|alert');return;  
                        }if($('#dpstatus').html() == 'Cancelled'){
                            notify.message('Account is Cancelled, Cannot Proceed!|error|alert');return;  
                        }if($('#dpstatus').html() == 'Dormant'){
                            notify.message('Account is Dormant, Cannot Proceed!|error|alert');return;  
                        }if(debitAmtValue==null || debitAmtValue=="" || isNaN(debitAmtValue)==true){
                            notify.message('Withdrawal amount is Null!, Cannot Proceed!|error|alert');return;  
                        }if(debitAmtValue==0 || debitAmtValue<0){
                            notify.message('Withdrawal amount cannot be equal or less then Zero (0) value|error|alert');return; 
                        }if(refreshCashOnHand <=0){
                            notify.message('Unable to continue transaction. Not enough cash on hand!|error|alert');return; 
                        }
                        console.log("qweeeeee : "+refreshCashOnHand+" debitAmtValue: "+debitAmtValue);
                        if(refreshCashOnHand < debitAmtValue){
                            notify.message('Unable to continue transaction. Withdrawal amount cannot be greater than the CASH ON HAND!|error|alert');return; 
                        }
                        var passbookBalanceAmount = $('#passbookBal').val()
                        passbookBalanceAmount = parseFloat(passbookBalanceAmount.replace(/,/g , ""));
                        console.log("ss: "+passbookBalanceAmount);

                        if(passbookBalanceAmount < debitAmtValue){
                            notify.message('Withdrawal amount must be less than available balance!|error|alert');return; 
                        }if(!$('#txnRef').val()){
                            notify.message('Transaction Reference Required!|error|alert');
                            return;
                        }else{
                            
                            alertify.confirm(AppTitle,"Are you sure you want to continue this transaction?",
                            function(){
                                checkIfAllowed($('#txnTemplate option:selected').data('code'), 'form#txnCashWithdrawalForm', 'txnCashWithdrawalOverride', $('#depAmt').val());
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
