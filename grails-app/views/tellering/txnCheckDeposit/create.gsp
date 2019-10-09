<%@ page contentType="text/html;charset=UTF-8" %>


<!DOCTYPE html>

<html>
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <title>Check Deposit Transaction</title>
        
        <script type="text/javascript" src="${resource(dir: 'js', file: 'customerSearch.js')}"></script>
        <asset:javascript src="telleringHelper.js"/>
        <asset:javascript src="checkPassbookBal.js"/>
        <asset:javascript src="checkCheckType.js"/>

        <g:javascript>
            
            function updateVar() {
                DEPAMT = parseFloat($('#creditAmt').val().replace(',', ''));
                if (isNaN(DEPAMT))
                    DEPAMT = 0;
                $('#depAmt').val(DEPAMT);
                
            }
            var modal;
            var deposit_id;
            function yay(){
                alert("weeew");
            }
            function refreshForm(params){
                if(params.deposit){
                    icbs.Tellering.depositDetails('getDepositDetailsCallback',"${createLink(controller : 'tellering', action:'changeDepositDetails')}",{flag:2, deposit:params.deposit});
                    deposit_id = params.deposit;
                    console.log(deposit_id);
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
            function showChecks() {
                $.ajax({
                    type: 'POST',
                    url: "${createLink(controller:'tellering', action:'showChecksAjax')}",
                    success: function(msg){				    	
                        $('#check_table').html(msg);
                        //console.log("$('#test_checkAmt').val(): "+$('#test_checkAmt').val());
                        $('#checkCTotal').val($('#test_checkAmt').val());
                },
                error:function(XMLHttpRequest,textStatus,errorThrown){
                    alert(XMLHttpRequest+textStatus+errorThrown);
                }
                });				
            }
            function addCheckAjax() {
                $.ajax({
                    type: 'POST',
                    <!-- may dagdag d2 -->
                    data: {deposit_id:deposit_id,checkType:$('#checkType').val(), bank:$('#bank').val(), acctNo:$('#acctNo').val(), checkDate:$('#checkDate').val(), checkNo:$('#checkNo').val(), clearingDate:$('#clearingDate').val(), checkAmt:$('#checkAmt').val(), txnCheckStatus:$('#txnCheckStatus').val()}, 
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
                                    <g:if test="${(txnCheckDepositInstance?.acct?.customer?.attachments?.find{it.isPrimarySig==true})?.id}"> <img width="240px" height="240px"src="${createLink(controller:'Attachment', action:'show', id: (depositInstance?.customer?.attachments?.find{it.isPrimarySig==true})?.id )}"/></g:if>
                               </div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <a href="#" data-dismiss="modal" class="btn">Close</a>
                        </div>
                    </div>
                </div>
            </div>
            
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
            
            <g:hasErrors bean="${txnCheckDepositInstance}">
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
                            <g:eachError bean="${txnCheckDepositInstance}" var="error">
                                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                            </g:eachError>
                        </ul>            
                    </div>
                </div>-->
            </g:hasErrors>
            
            <g:form name="txnCheckDepositForm" action="saveTellerCheckDepositTxn" controller="tellering">
                <g:render template='txnCheckDeposit/form' model="[txnCheckDepositInstance:txnCheckDepositInstance]"/>
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
                            notify.message('Transaction type Required!|error|alert');return; 
                    }
                    if ($('#txnTemplate option:selected').data('requirePassbook')== 'Yes') {
                        if($('#IssuePassbook').html() != 'Yes') {
                            notify.message('No passbook issued!|error|alert');return;
                        }
                    }                  
                    if($('#dpstatus').html() == '')
                    {
                        notify.message('Customer is required!|error|alert');return;  
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
                    if($('#depAmt').val()== 0){
                            notify.message('Zero deposit amount not allowed!|error|alert');return; 
                    }
                    if($('#depAmt').val() < 0){
                        notify.message('Deposit amount must be greater than 0!|error|alert');return; 
                    }
                    if(!$('#txnRef').val()){
                     notify.message('Transaction Reference Required!|error|alert');return;   
                    }
                    if($('#test_check').val() > 0 ){
                        var totChequeAmountvalue = $('#test_checkAmt').val();
                        var creditAmountValue = $('#creditAmt').val();
                        totChequeAmountvalue = parseFloat(totChequeAmountvalue.toString().replace(/,/g , ""));                        
                        creditAmountValue = parseFloat(creditAmountValue.toString().replace(/,/g , ""));
                        if (totChequeAmountvalue == creditAmountValue){
                            alertify.confirm('Are you sure you want to continue this transaction?',function(){
                                //jQuery('#txnCheckDepositForm').submit();
                                checkIfAllowed($('#txnTemplate option:selected').data('code'), 'form#txnCheckDepositForm', 'txnCheckDepositOverride', $('#depAmt').val());
                            },
                            function(){return;});
                        }
                        else {
                            notify.alert('Total Check Amount is not equal to Deposit Amount.');
                            return false;
                        }
                    }
                    else {
                        notify.alert('Please input check first.')
                        return false

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
