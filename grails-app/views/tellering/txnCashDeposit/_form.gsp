<%@ page import="icbs.tellering.TxnDepositAcctLedger" %>
<g:textField disable="disabled" name="pb" style="display:none"/>
<g:textField id="depAmt" name="depAmt" value="0" style="display:none"/>
<div class="form-group">
    <label class="control-label">Transaction Type</label>
    <div class="col-sm-6">
        <select id="txnTemplate" name="txnTemplate" class="many-to-one form-control">
            <option selected="selected" disabled="true">-- Select a transaction type --</option>
            
                <g:each in="${icbs.admin.TxnTemplate.findAllByConfigItemStatusAndTxnType(icbs.lov.ConfigItemStatus.read(2),icbs.lov.TxnType.read(3),[sort:"code", order:"asc"])}" var="txnTemplateInstance">
                <option value="${txnTemplateInstance.id}" data-require-passbook="${txnTemplateInstance.requirePassbook}" data-code="${txnTemplateInstance.code}">${txnTemplateInstance.codeDescription}</option>
            </g:each>
        </select>
    </div>
</div>

<fieldset class="form-group">
    <g:if test="${!txnCashDepositInstance?.acct}">
        <input type="button" href="#" class="btn btn-primary" onclick="initializeDepositAcctSearchModal();modal.show()" value="Search Account"/>
    </g:if>
</fieldset>

<div id="depositDetDiv">
    <fieldset class="form-group">
        <g:render template='/tellering/details/depositDetails' model="[depositInstance:txnCashDepositInstance?.acct]"/>
        <g:if test="${txnCashDepositInstance?.acct}">
            
            <g:render template='/tellering/details/signatureDetails' model="[depositInstance:txnCashDepositInstance?.acct]"/>
            <g:render template='/tellering/details/signatoryDetails' model="[depositInstance:txnCashDepositInstance?.acct]"/>
           
        </g:if>
    </fieldset>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: txnCashDepositInstance, field: 'passbookBal', 'has-error')} required" style="display:none">
    <label class="control-label">Passbook Balance</label>
    <div class="col-sm-6">
        <g:textField  id="passbookBal" name="passbookBal" required=""  value="${txnCashDepositInstance?.passbookBal}" class="form-control truncated"/>
        <g:textField  id="passbooksw" name="passbooksw" value="${txnCashDepositInstance?.passbookBal}" class="form-control" style="display:none"/>
    </div>
    <div class="col-sm-2">
        <i id="passbookValidate" class="glyphicon hide" style="margin-top: 10px;"></i>
    </div>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: txnCashDepositInstance, field: 'creditAmt', 'has-error')} required">
    <label class="control-label">Deposit Amount</label>
    <div class="col-sm-6">
        <input  id="creditAmt"  name="creditAmt" required="" value="${txnCashDepositInstance?.creditAmt}" class="form-control truncated" onkeyup="updateVar()"/>
   </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: txnCashDepositInstance, field: 'txnRef', 'has-error')} required" >
    <label class="control-label col-sm-4" for="txnRef">
        <g:message code="txnCashDeposit.txnRef.label" default="Transaction Reference" />
    </label>
    <div class="col-sm-6">
        <g:textArea id="txnRef" name="txnRef" required="" value="${txnCashDepositInstance?.txnRef}"class="form-control"/>
    </div>             
</div>