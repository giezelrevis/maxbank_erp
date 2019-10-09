<%@ page import="icbs.tellering.TxnCOCI" %>
<%@ page import="icbs.tellering.TxnDepositAcctLedger" %>

<div class="form-group">
    <label class="control-label">Transaction Type</label>
    <div class="col-sm-6">
        <select id="txnTemplate" name="txnTemplate" class="many-to-one form-control" onchange="testchange()">
            <option selected="selected" disabled="true">-- Select a transaction type --</option>
            <g:each in="${icbs.admin.TxnTemplate.findAllByConfigItemStatusAndTxnType(icbs.lov.ConfigItemStatus.read(2),icbs.lov.TxnType.read(6),[sort:"code", order:"asc"])}" var="txnTemplateInstance">
                <option value="${txnTemplateInstance.id}" data-require-passbook="${txnTemplateInstance.requirePassbook}" data-code="${txnTemplateInstance.code}">${txnTemplateInstance.codeDescription}</option>
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
    <g:if test="${!txnCheckEncashmentInstance?.acct}">
        <input type="button" href="#" class="btn btn-primary" onclick="initializeDepositAcctSearchModal();modal.show()" value="Search Account"/>
    </g:if>
</fieldset>

<div id="depositDetDiv">
    <fieldset class="form-group">
        <g:render template='/tellering/details/depositDetails' model="[depositInstance:txnCheckEncashmentInstance?.acct]"/>
        <g:if test="${txnCheckEncashmentInstance?.acct}">
            <g:render template='/tellering/details/signatureDetails' model="[depositInstance:txnCheckEncashmentInstance?.acct]"/>
            <g:render template='/tellering/details/signatoryDetails' model="[depositInstance:txnCheckEncashmentInstance?.acct]"/>
        </g:if>
    </fieldset>
</div>


<div class="fieldcontain form-group ${hasErrors(bean: txnCheckEncashmentInstance, field: 'passbookBal', 'has-error')} required">
    <label class="control-label">Passbook Balance</label>
    <div class="col-sm-6">
        <g:textField type="number" name="passbookBal" required="" value="" class="form-control truncated" readonly="true"/>
    </div>
    <div class="col-sm-2">
        <i id="passbookValidate" class="glyphicon hide" style="margin-top: 10px;"></i>
    </div>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: txnCheckEncashmentInstance, field: 'payee', 'has-error')} ">
    <label class="control-label col-sm-4" for="payee">
            <g:message code="txnCheckEncashment.payee.label" default="Payee" />
    </label>

    <div class="col-sm-6">
        <g:textField id="payee" name="payee" value="${txnCheckEncashmentInstance?.payee}"class="form-control"/>
    </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: txnCheckEncashmentInstance, field: 'checkDate', 'has-error')} ">
    <label class="control-label col-sm-4" for="checkDate">
        <g:message code="txnCheckEncashment.checkDate.label" default="Check Date" />
    </label>
    
    <div class="col-sm-6">
        <g:customDatePicker name="checkDate" precision="day" class="form-control"  value="${txnCheckEncashmentInstance?.checkDate}" default="none" noSelection="['': '']" />
    </div>
</div>
   

<div class="fieldcontain form-group ${hasErrors(bean: txnCheckEncashmentInstance, field: 'checkNo', 'has-error')} ">
    <label class="control-label col-sm-4" for="checkNo">
        <g:message code="txnCheckEncashment.checkNo.label" default="Check Number" />
    </label>
    <div class="col-sm-6">
        <g:textField type="number" id="checkNo" name="checkNo" required="" value="${txnCheckEncashmentInstance?.checkNo}"class="form-control"/>
    </div>
</div>


<div class="fieldcontain form-group ${hasErrors(bean: txnCheckEncashmentInstance, field: 'checkAmt', 'has-error')} ">
    <label class="control-label col-sm-4" for="checkAmt">
            <g:message code="txnCheckEncashment.checkAmt.label" default="Check Amount" />
    </label>
    
    <div class="col-sm-6">
        <g:textField type="number" id="checkAmt" name="checkAmt" required="" value="${txnCheckEncashmentInstance?.checkAmt}" class="form-control truncated"/>
    </div>
</div>

<!--
<div class="fieldcontain form-group ${hasErrors(bean: txnCheckEncashmentInstance, field: 'txnRef', 'has-error')} ">
    <label class="control-label col-sm-4" for="txnRef">
            <g:message code="txnCheckEncashment.txnRef.label" default="Transaction Reference" />
    </label>

    <div class="col-sm-6">
        <g:textArea name="txnRef" value="${txnCheckEncashmentInstance?.txnRef}"class="form-control"/>
    </div>             
</div>-->