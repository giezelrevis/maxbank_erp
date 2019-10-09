<%@ page import="icbs.tellering.TxnRemittance" %>
<g:hiddenField name="txnDepIDSender" id="txnDepIDSender" value="${customerInstance?.id}"/>
<g:hiddenField name="txnDepIDBenef" id="txnDepIDBenef" value="${customerInstance?.id}"/>
<g:hiddenField name="txnIdent" id="txnIdent"/>
<g:hiddenField id="OtherCashPaymentRemit" name="OtherCashPaymentRemit" value="0"/>

<div class="form-group">
    <label class="control-label">Transaction Type</label>
    <div class="col-sm-6">
        <select id="txnTemplate" name="txnTemplate" class="many-to-one form-control" onchange="testchange()">
            <option selected="selected" disabled="true">-- Select a transaction type --</option>
            <g:each in="${icbs.admin.TxnTemplate.findAllByTxnTypeAndMemoTxnType(icbs.lov.TxnType.read(21), icbs.lov.MemoTxnType.read(2),[sort:"code", order:"asc"])}" var="txnTemplateInstance">
                <option value="${txnTemplateInstance.id}" data-code="${txnTemplateInstance.code}">${txnTemplateInstance.codeDescription}</option>
            </g:each>
        </select>
    </div>
</div>
<input type="text" id="currency_id" value=0 style="display:none">
<script>
    
    var totalcash = 0;

   function testchange()
   {
        console.log($('#txnTemplate').val());
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (xhttp.readyState == 4 && xhttp.status == 200) {
                //console.log(JSON.parse(xhttp.responseText).currency);
                currency_id.value = JSON.parse(xhttp.responseText).currency;
                $.each(JSON.parse(totJSON),function(key,value){
                    if(value.currency_id == currency_id.value)
                    {
                        totalcash = value.cashin - value.cashout;  
                    }
                });
            }
        }
        xhttp.open("POST", "getCurrencyOnTemplate?recid="+$('#txnTemplate').val(),true);
        xhttp.send();
   }
</script>
<fieldset class="form-group">
    <g:if test="${!txnCashPaymentRemittanceInstance?.sender}">
        <input type="button" href="#" class="btn btn-primary" onclick="initializeCustomerDetailsSearchModal('txnSenderDetailsDiv');modal.show()"value="Search Sender"/>
    </g:if>
</fieldset>

<fieldset class="form-group">
    <div class="col-sm-10" id="txnSenderDetailsDiv">
        <g:render template='/customer/details/txnCustomerDetails' model="[customerInstance:txnCashPaymentRemittanceInstance?.sender]"/>
    </div>
</fieldset>

<fieldset class="form-group">
    <g:if test="${!txnCashPaymentRemittanceInstance?.beneficiary}">
        <input type="button" href="#" class="btn btn-primary" onclick="initializeCustomerDetailsSearchModal('txnBeneficiaryDetailsDiv');modal.show()"value="Search Beneficiary"/>
    </g:if>
</fieldset>

<fieldset class="form-group">
    <div class="col-sm-10" id="txnBeneficiaryDetailsDiv">
        <g:render template='/customer/details/txnCustomerDetails' model="[customerInstance:txnCashPaymentRemittanceInstance?.beneficiary]"/>
    </div>
</fieldset>

<div class="fieldcontain form-group ${hasErrors(bean: txnCashPaymentRemittanceInstance, field: 'txnAmt', 'has-error')} required">
    <label class="control-label">Remittance Amount</label>
    <div class="col-sm-6">
        <g:textField type="number" name="txnAmt" required="" value="${txnCashPaymentRemittanceInstance?.txnAmt}"class="form-control truncated" onkeyup="updateVar()"/>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: txnRemittanceInstance, field: 'controlNo', 'has-error')} ">
    <label class="control-label col-sm-4" for="controlNo">
        <g:message code="txnRemittance.controlNo.label" default="Control Number" />
    </label>
    <div class="col-sm-6">
        <g:textField name="controlNo" value="${txnRemittanceInstance?.controlNo}"class="form-control"/>
    </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: txnRemittanceInstance, field: 'txnParticulars', 'has-error')} ">
    <label class="control-label col-sm-4" for="txnParticulars">
        <g:message code="txnRemittance.txnParticulars.label" default="Particulars" />
    </label>
    <div class="col-sm-6">
        <g:textArea name="txnParticulars" value="${txnRemittanceInstance?.txnParticulars}"class="form-control"/>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: txnCashReceiptRemittanceInstance, field: 'txnRef', 'has-error')} ">
    <label class="control-label col-sm-4" for="txnRef">
        <g:message code="txnCashReceiptRemittance.txnRef.label" default="Payout Instructions" /></label>
    <div class="col-sm-6">
        <g:textArea name="txnRef" value="${txnCashReceiptRemittanceInstance?.txnRef}"class="form-control"/>
    </div>             
</div>

