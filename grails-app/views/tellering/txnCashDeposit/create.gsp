<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="icbs.admin.TxnTemplate" %>

<!DOCTYPE html>

<html>
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <title>Cash Deposit Transaction</title>
        
        <script type="text/javascript" src="${resource(dir: 'js', file: 'customerSearch.js')}"></script>
        <asset:javascript src="checkPassbookBal.js"/>
        <asset:javascript src="telleringHelper.js"/>
        
        <g:javascript>
            var modal;
            function refreshForm(params){
                if(params.deposit){
                    icbs.Tellering.depositDetails('getDepositDetailsCallback',"${createLink(controller : 'tellering', action:'changeDepositDetails')}",{deposit:params.deposit});
                }
            }
            function initializeDepositAcctSearchModal(){
                modal = new icbs.UI.Modal({id:"addFundTransferSearchModal",url:"${createLink(controller : 'search', action:'search', params:[searchDomain: "deposit", module:"deposit" ])}",title:"Search Deposit Accounts",onCloseCallback:refreshForm});
            }
            function showSignature(){
                $('#openDepositSignature').modal({show:true})  
            }
            function showSignatories(){
                $('#openDepositSignatories').modal({show:true})  
            }
            
            function updateVar() {
                //DEPAMT = nFix($('#creditAmt').val());
                //if (isNaN(DEPAMT))
                //    DEPAMT = 0;
                depAmt.value = accounting.unformat(creditAmt.value);
                
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
            
            <g:hasErrors bean="${txnCashDepositInstance}">
                <script>
                    $(function
                        var x = '${it}';
                        notify.error(x);
                       // console.log(x)
                       // setTimeout(function(){ notify.success(x); }, 3000);
                    });
                </script>
            </g:hasErrors>
            
            <g:form name="txnCashDepositForm" action="saveTellerCashDepositTxn" controller="tellering">
                <div class="col-sm-10">
                    <g:render template='txnCashDeposit/form' model="[txnCashDepositInstance:txnCashDepositInstance]"/>
                </div>
            </g:form>

        </content>
        
         <!--Grails tag for jasper plugin-->
         <g:jasperReport action="printPassbookTransactions"  controller="tellering" format="PDF" name="Passbook"  jasper="Transaction">
         </g:jasperReport>
        
        <content tag="main-actions">
            <ul>
                <li><a class="save" onclick="
                        //console.log($('#dpstatus').html());
                        if(!$('#txnTemplate').val()){
                            notify.message('Transaction type Required!|error|alert');return; 
                        }
                        if($('#dpstatus').html() == '')
                        {
                            notify.message('Customer is required!|error|alert');return;  
                        }
                        if ($('#txnTemplate option:selected').data('requirePassbook')== 'Yes') {
                            if($('#IssuePassbook').html() != 'Yes') {
                                notify.message('No passbook issued!|error|alert');return;
                            }
                        }  
                        
                        if($('#depAmt').val()== 0){
                            notify.message('Zero deposit amount not allowed!|error|alert');return; 
                        }
                        if($('#depAmt').val() < 0){
                            notify.message('Deposit amount must be greater than 0!|error|alert');return; 
                        }
                        if(!$('#txnRef').val()){
                            notify.message('Transaction Reference Required!|error|alert');return;   
                        }
                        if($('#dpstatus').html() == 'Locked/Frozen')
                        {
                            notify.message('Account is Locked/Frozen, Cannot Proceed!|error|alert');return;  
                        }

                        if($('#dpstatus').html() == 'Cancelled')
                        {
                            notify.message('Account is Cancelled, Cannot Proceed!|error|alert');return;  
                        }
                        if($('#dpstatus').html() == 'Dormant')
                        {
                            notify.message('Account is Dormant, Cannot Proceed!|error|alert');return;  
                        }
                        if($('#dpstatus').html() == 'Closed')
                        {
                            notify.message('Account is closed, Cannot Proceed!|error|alert');return;  
                        }
                        if(nFix($('#passbookBal').val(),2) >= 0 ) {
                        
                            alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                            function(){
                                // jQuery('#txnCashDepositForm').submit();
                                checkIfAllowed($('#txnTemplate option:selected').data('code'), 'form#txnCashDepositForm', 'CashDepositOverride', $('#depAmt').val());
                                $('#passbooksw').val(0);
                               // $('#passbookBal').val(0);
                            },function(){
                            return;
                            });
                        }
                                                           ">${message(code: 'default.button.create.label', default: 'Create')}</a></li>
                <li><g:link action="index" >Tellering Index</g:link></li>
            </ul>                                        
        </content>
    </body>
</html>
