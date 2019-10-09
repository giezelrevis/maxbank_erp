<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<div class="row">
    <div class="col-md-6">
        <g:hiddenField id="txnType" name="tnxType.id" value="7"/>
        <g:hiddenField id="acct"name="acct.id" value="${billsPaymentInstance?.acct?.id?:depositInstance?.id}"/>
        <div class="form-group fieldcontain ${hasErrors(bean: billsPaymentInstance, field: 'type', 'has-error')} ">
            <label class="control-label col-sm-4"for="type">
                    <g:message code="billsPayment.type.label" default="Memo Type" />
            </label>
            <div class="col-sm-8">
                <g:select id="type" name="type.id" onchange="changeMemoForm('billsPayment')" from="${icbs.lov.MemoType.findAllByIdInListAndStatus([1],true)}" optionKey="id" optionValue ="description" value="${billsPaymentInstance?.type?.id}"class="form-control"/>
                <g:hasErrors bean="${billsPaymentInstance}" field="type">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${billsPaymentInstance}" field="type">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>
        <div class="form-group fieldcontain ${hasErrors(bean: billsPaymentInstance, field: 'txnTemplate', 'has-error')} ">
            <label class="control-label col-sm-4"for="txnTemplate">
                    <g:message code="billsPayment.txnTemplate.label" default="Transaction Template" />
            </label>
            <div class="col-sm-8">
                <g:select id="txnTemplate" name="txnTemplate.id" from="${icbs.admin.TxnTemplate.findAllByTxnTypeAndMemoTxnType(icbs.lov.TxnType.read(7),icbs.lov.MemoTxnType.read(3),[sort:"code", order:"asc"])}" optionKey="id" optionValue ="description" value="${billsPaymentInstance?.txnTemplate?.id}"class="form-control"/>
                <g:hasErrors bean="${billsPaymentInstance}" field="txnTemplate">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${billsPaymentInstance}" field="txnTemplate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>
        <div class="form-group fieldcontain ${hasErrors(bean: billsPaymentInstance, field: 'amt', 'has-error')} ">
            <label class="control-label col-sm-4"for="amt">
                    <g:message code="billsPayment.amt.label" default="Amount" /><span class="required-indicator"> *</span>
            </label>
            <div class="col-sm-8">
                <g:textField id="BillsDebitAmt" name="amt" value="${billsPaymentInstance?.amt}" class="form-control truncated"/>
                <g:hasErrors bean="${billsPaymentInstance}" field="amt">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${billsPaymentInstance}" field="amt">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>
        
        <div class="form-group fieldcontain ${hasErrors(bean: billsPaymentInstance, field: 'txnRef', 'has-error')} ">
            <label class="control-label col-sm-4"for="amt">
                    <g:message code="billsPayment.txnRef.label" default="Transaction Reference" /><span class="required-indicator"> *</span>
            </label>
            <div class="col-sm-8">
                <g:textField id="BillsDebitRef" name="txnRef" value="${billsPaymentInstance?.txnRef}" class="form-control"/>
                <g:hasErrors bean="${billsPaymentInstance}" field="txnRef">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${billsPaymentInstance}" field="txnRef">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>
        
        
        <div class="form-group fieldcontain ${hasErrors(bean: billsPaymentInstance, field: 'txnDescription', 'has-error')} ">
            <label class="control-label col-sm-4"for="ref">
                    <g:message code="billsPayment.txnDescription.label" default="Description" />
            </label>
            <div class="col-sm-8">
                <g:textField name="txnDescription" value="${billsPaymentInstance?.txnDescription}" class="form-control"/>
                <g:hasErrors bean="${billsPaymentInstance}" field="txnDescription">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${billsPaymentInstance}" field="txnDescription">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <g:submitButton name="submit" class="btn btn-primary" id="submitFrmBills" style="display:none"/>
        <button  class="btn btn-primary" id="submitFrmBillsDebit"> Submit </button>
        <script>
            $('#submitFrmBillsDebit').on('click',function(f){
            f.preventDefault();
          
//            if(!$('#type').val()){
//                notify.message('Memo type is required!|error|alert');return;   
//            }
//            if(!$('#txnTemplate').val()){
//                notify.message('Transaction code is required!|error|alert');return;   
//            }
            if(!$('#BillsDebitAmt').val()){
                notify.message('Amount is required!|error|alert');return;   
            }
            if(!$('#BillsDebitRef').val()){
                notify.message('Transaction reference is required!|error|alert');return;   
            }
            
            alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
            function(){
                $('#submitFrmBills').click();
            },
            function(){
                return;
            });
            
            });   
         </script>
         <g:if test="${flash.message == "Bills Payment Successfully made.|success|alert"}">
            <a class="btn btn-primary" onclick="alertify.confirm(AppTitle,'Print Memo Transaction - (Debit Bills Payment) Validation Slip?',
               function(){
                   var w = window.open('/icbs/deposit/MemoTransactionValidationSlip', '_blank');
                       w.print()
                   },
               function(){});">Validation</a>
        </g:if>
    </div>
</div>