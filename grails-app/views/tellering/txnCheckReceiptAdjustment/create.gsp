<%@ page contentType="text/html;charset=UTF-8" %>


<!DOCTYPE html>

<html>
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <title>Other Check Receipt Transaction - General</title>            
    
        <asset:javascript src="telleringHelper.js"/>
        <g:javascript>
            function updateVar(){
                var amount = parseFloat($('#txnAmt').val().replace(',', ''));
                if (isNaN(amount))
                    amount = 0;
                $('#CashReceiptCheckAdjustment').val(amount);
            }
            function showChecks() {
                $.ajax({
                    type: 'POST',
                    url: "${createLink(controller:'tellering', action:'showChecksAjax')}",
                    success: function(msg){				    	
                        $('#check_table').html(msg);
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
                modal = new icbs.UI.Modal({id:"add-check-modal", url:"${createLink(controller: 'tellering', action:'showAddCheckAjax')}", title:"Add Check", modalClass:"null"});
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
                    </div>   
                </div>
            </g:if>
            <g:hasErrors bean="${txnCheckReceiptAdjustmentInstance}">
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
                            <g:eachError bean="${txnCheckReceiptAdjustmentInstance}" var="error">
                                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                            </g:eachError>
                        </ul>            
                    </div>
                </div>-->
            </g:hasErrors>        
            <g:form name="txnCheckReceiptAdjustmentForm" action="saveTellerOtherCheckReceiptAdjustmentTxn" controller="tellering">
                <g:render template='txnCheckReceiptAdjustment/form' model="[txnCheckReceiptAdjustmentInstance:txnCheckReceiptAdjustmentInstance]"/>
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
                    if($('#CashReceiptCheckAdjustment').val() == 0)
                    {
                        notify.message('Transaction amount required!|error|alert');return; 
                    } 
                    if($('#CashReceiptCheckAdjustment').val() < 0)
                    {
                        notify.message('Transaction amount must be greater than 0!|error|alert');return; 
                    }
                    if(!$('#txnRef').val()){
                        notify.message('Transaction reference required!|error|alert');return;   
                    }
                    if(!$('#txnParticulars').val()){
                        notify.message('Transaction particulars required!|error|alert');return;   
                    }
                    if($('#test_check').val() > 0 ){
                        if(accounting.unformat($('#test_checkAmt').val()) == accounting.unformat($('#txnAmt').val())){
                            alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                    //jQuery('#txnCheckReceiptAdjustmentForm').submit();
                                    checkIfAllowed($('#txnTemplate option:selected').data('code'), 'form#txnCheckReceiptAdjustmentForm', 'txnCheckReceiptAdjustmentOverride', $('#CashReceiptCheckAdjustment').val());
                                },
                                function(){
                                    return;
                                });
                        }
                        else{
                             notify.message('Total check amount is not equal to transaction amount.|error|alert');return;
                        }
                    }
                    else{
                         notify.message('Please input check first.|error|alert');return;
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
