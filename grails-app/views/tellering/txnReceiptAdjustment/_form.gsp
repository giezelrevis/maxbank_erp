<%@ page import="icbs.tellering.TxnFile" %>

<g:hiddenField id="CashReceiptAdjustment" name="CashReceiptAdjustment" value="0"/>
<div class="form-group">
    <label class="control-label">Transaction Type <span class="required-indicator">*</span></label>
    <div class="col-sm-6">
        <select id="txnTemplate" name="txnTemplate" class="many-to-one form-control">
            <option selected="selected" disabled="true">-- Select a transaction type --</option>
            <g:each in="${icbs.admin.TxnTemplate.findAllByTxnTypeAndMemoTxnType(icbs.lov.TxnType.read(19), icbs.lov.MemoTxnType.read(1),[sort:"code", order:"asc"])}" var="txnTemplateInstance">
                <option value="${txnTemplateInstance.id}" data-code="${txnTemplateInstance.code}">${txnTemplateInstance.codeDescription}</option>
            </g:each>
        </select>
    </div>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: txnReceiptAdjustmentInstance, field: 'txnAmt', 'has-error')} required">
    <label class="control-label">Transaction Amount <span class="required-indicator">*</span></label>
    <div class="col-sm-6">
        <g:textField type="number" name="txnAmt" required="" value="${txnReceiptAdjustmentInstance?.txnAmt}"class="form-control truncated" onkeyup="updateVar()"/>
   </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: txnReceiptAdjustmentInstance, field: 'txnRef', 'has-error')} required">
    <label class="control-label">Transaction Reference <span class="required-indicator">*</span></label>
    <div class="col-sm-6">
        <g:textArea name="txnRef" required="" value="${txnReceiptAdjustmentInstance?.txnRef}"class="form-control"/>
    </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: txnReceiptAdjustmentInstance, field: 'txnParticulars', 'has-error')} ">
    <label class="control-label">Particulars</label>
    <div class="col-sm-6">
        <g:textArea name="txnParticulars" maxlength="100" value="${txnReceiptAdjustmentInstance?.txnParticulars}"class="form-control"/>
    </div>             
</div>
