 <!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->
<%@ page contentType="text/html;charset=UTF-8" %>
<div class="row">
    <div class="col-md-4">
        
        <g:hiddenField id="txnType" name="tnxType.id" value="7"/>
        <g:hiddenField id="acct" name="acct.id" value="${remittanceInstance?.acct?.id?:depositInstance?.id}"/>
        <div class="form-group fieldcontain ${hasErrors(bean: remittanceInstance, field: 'type', 'has-error')} ">
            <label class="control-label col-sm-4"for="type">
                    <g:message code="remittance.type.label" default="Memo Type" />
            </label>
            <div class="col-sm-9">
                <g:select id="type" name="type.id" onchange="changeMemoForm('remittance')" from="${icbs.lov.MemoType.findAllByStatus(true)}" optionKey="id" optionValue ="description" value="2"class="form-control"/>
                <g:hasErrors bean="${remittanceInstance}" field="type">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${remittanceInstance}" field="type">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>
        <div class="form-group fieldcontain ${hasErrors(bean: remittanceInstance, field: 'txnTemplate', 'has-error')} ">
            <label class="control-label col-sm-4"for="txnTemplate">
                    <g:message code="remittance.txnTemplate.label" default="Transaction Code" />
            </label>
            <div class="col-sm-9">
                <g:select id="txnTemplate" name="txnTemplate.id" from="${icbs.admin.TxnTemplate.findAllByTxnTypeAndMemoTxnType(icbs.lov.TxnType.read(9),icbs.lov.MemoTxnType.read(2),[sort:"code", order:"asc"])}" optionKey="id" optionValue ="description" value="${adjustmentInstance?.txnTemplate?.id}"class="form-control"/>
                <g:hasErrors bean="${remittanceInstance}" field="txnTemplate">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${remittanceInstance}" field="txnTemplate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>
        <div class="form-group fieldcontain ${hasErrors(bean: remittanceInstance, field: 'amt', 'has-error')} ">
            <label class="control-label col-sm-4"for="amt">
                    <g:message code="remittance.amt.label" default="Amount" /><span class="required-indicator"> *</span>
            </label>
            <div class="col-sm-9">
                <g:textField id="RemitCreditAmt" name="amt" value="${remittanceInstance?.amt}" class="form-control truncated"/>
                <g:hasErrors bean="${remittanceInstance}" field="amt">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${remittanceInstance}" field="amt">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>
        <div class="form-group fieldcontain ${hasErrors(bean: remittanceInstance, field: 'txnRef', 'has-error')} ">
            <label class="control-label col-sm-4"for="txnRef">
                    <g:message code="remittance.txnRef.label" default="Transaction Reference" /><span class="required-indicator">*</span>
            </label>
            <div class="col-sm-9">
                <g:textField id="RemitCreditRef" name="txnRef" value="${remittanceInstance?.txnRef}" class="form-control"/>
                <g:hasErrors bean="${remittanceInstance}" field="txnRef">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${remittanceInstance}" field="txnRef">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>
        <div class="form-group fieldcontain ${hasErrors(bean: remittanceInstance, field: 'txnDescription', 'has-error')} ">
            <label class="control-label col-sm-4"for="ref">
                    <g:message code="remittance.txnDescription.label" default="Description" />
            </label>
            <div class="col-sm-9">
                <g:textField name="txnDescription" value="${remittanceInstance?.txnDescription}" class="form-control"/>
                <g:hasErrors bean="${remittanceInstance}" field="txnDescription">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${remittanceInstance}" field="txnDescription">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>
    </div>
 
    <div class="col-md-7">
        <div class="row">
            <!--<input type="button" class="btn btn-default form-control"href="#"onclick="initializeCustomerDetailsSearchModal();modal.show()"value="Search CIF"/>-->
        </div>
        <!--<fieldset class="form-group">-->
                <div id="customerDetailsDiv">
                <div class="section-container">
                    <input type="button" class="btn btn-default form-control"href="#"onclick="initializeCustomerDetailsSearchModal();modal.show()"value="Search CIF"/>
                </div>
                    <g:render template='/customer/details/customerDetails' model="[boxName:'Sender']"/>
                </div>
        <!--</fieldset>-->
       
        <g:submitButton name="submit" class="btn btn-primary" id="submitFrmRemit" style="display:none"/>
        <button  class="btn btn-primary" id="submitFrmRemitCredit"> Submit </button>
        <script>
            $('#submitFrmRemitCredit').on('click',function(f){
            f.preventDefault();
          
//            if(!$('#type').val()){
//                notify.message('Memo type is required!|error|alert');return;   
//            }
//            if(!$('#txnTemplate').val()){
//                notify.message('Transaction code is required!|error|alert');return;   
//            }
            if(!$('#RemitCreditAmt').val()){
                notify.message('Amount is required!|error|alert');return;  
            }
            if(parseFloat($('#RemitCreditAmt').val().replace(',','')) < 0){
                notify.message('Amount must be greater than 0!|error|alert');return;  
            }
            if(!$('#RemitCreditRef').val()){
                notify.message('Transaction reference is required!|error|alert');return;
            }
//            if(!$('#Memo_customer').val()){
//                notify.message('Customer is required!|error|alert');return;
//            }
            
            alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
            function(){
                $('#submitFrmRemit').click();
            },
            function(){
                return;
            });
            
          
            });   
        </script>
        <g:if test="${flash.message == "Memo Remittance Successfully made.|success|alert"}">
            <a class="btn btn-primary" onclick="alertify.confirm(AppTitle,'Print Memo Transaction - (Credit Remittance) Validation Slip?',
               function(){
                   var w = window.open('/icbs/deposit/MemoTransactionValidationSlip', '_blank');
                       w.print()
                   },
               function(){});">Validation</a>
        </g:if>
    </div>
</div>