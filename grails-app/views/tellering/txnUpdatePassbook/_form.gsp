<%@ page import="icbs.tellering.TxnDepositAcctLedger" %>
<g:textField disable="disabled" name="pb" style="display:none"/>
<g:textField id="depAmt" name="depAmt" value="0" style="display:none"/>
<fieldset class="form-group">
    <g:if test="${!txnCashDepositInstance?.acct}">
        <input type="button" href="#" class="btn btn-primary" onclick="initializeDepositAcctSearchModal();modal.show()" value="Search Account"/>
    </g:if>
</fieldset>
   
<div id="depositDetDiv">
    <fieldset class="form-group">
        <g:render template='/tellering/details/depositDetails' />
    </fieldset>
</div>
