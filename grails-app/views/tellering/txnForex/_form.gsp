<%@ page import="icbs.tellering.TxnForex" import="icbs.tellering.TxnFile" %>

<div class="form-group">
    <label class="control-label">Transaction Type</label>
    <div class="col-sm-6">
        <select id="txnType" name="txnType" required="true" class="many-to-one form-control">
            <option selected="selected" disabled="true">-- Select a transaction type --</option>
            <g:each in="${icbs.admin.TxnTemplate.findAllByTxnType(icbs.lov.TxnType.read(23))}" var="txnTemplateInstance">
                <option value="${txnTemplateInstance.id}">${txnTemplateInstance.codeDescription}</option>
            </g:each>
        </select>
    </div>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: txnForexInstance, field: 'exchangeRate', 'has-error')} ">
    <label class="control-label col-sm-4" for="exchangeRate">
        <g:message code="txnForex.exchangeRate.label" default="Exchange Rate" />
    </label>

    <div class="col-sm-6">
        <g:field name="exchangeRate" required="true" value="${fieldValue(bean: txnForexInstance, field: 'exchangeRate')}" class="txn-amt form-control"/>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: txnForexInstance, field: 'receivedAmt', 'has-error')} ">
    <label class="control-label col-sm-4" for="receivedAmt">
        <g:message code="txnForex.receivedAmt.label" default="Received Amount" />
    </label>

    <div class="col-sm-6">
        <g:field name="receivedAmt" required="true" value="${fieldValue(bean: txnForexInstance, field: 'receivedAmt')}" class="txn-amt form-control"/>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: txnForexInstance, field: 'paidOutAmt', 'has-error')} ">
    <label class="control-label col-sm-4" for="paidOutAmt">
        <g:message code="txnForex.paidOutAmt.label" default="Paid Out Amount" />
    </label>

    <div class="col-sm-6">
        <g:field name="paidOutAmt" required="true" value="${fieldValue(bean: txnForexInstance, field: 'paidOutAmt')}" class="txn-amt form-control"/>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: txnForexInstance, field: 'chargesAmt', 'has-error')} ">
    <label class="control-label col-sm-4" for="chargesAmt">
        <g:message code="txnForex.chargesAmt.label" default="Charges Amount" />
    </label>

    <div class="col-sm-6">
        <g:field name="chargesAmt" required="true" value="${fieldValue(bean: txnForexInstance, field: 'chargesAmt')}" class="txn-amt form-control"/>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: txnForexInstance, field: 'netAmtPaidOut', 'has-error')} ">
    <label class="control-label col-sm-4" for="netAmtPaidOut">
        <g:message code="txnForex.netAmtPaidOut.label" default="Net Amount Paid Out" />
    </label>

    <div class="col-sm-6">
        <g:field name="netAmtPaidOut" required="true" value="${fieldValue(bean: txnForexInstance, field: 'netAmtPaidOut')}" class="txn-amt form-control"/>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: txnForexInstance, field: 'txnParticulars', 'has-error')} ">
    <label class="control-label col-sm-4" for="txnParticulars">
            <g:message code="txnForex.txnParticulars.label" default="Transaction Particulars" />
    </label>

    <div class="col-sm-6">
        <g:textArea name="txnParticulars" required="true" value="${txnForexInstance?.txnParticulars}"class="form-control"/>
    </div>             
</div>