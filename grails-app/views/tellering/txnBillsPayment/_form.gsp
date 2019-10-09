<%@ page import="icbs.tellering.TxnBillsPayment" %>

<g:hiddenField name="txnDepID" id="txnDepID" value="${customerInstance?.id}"/>
<g:hiddenField id="CashReceiptBills" name="CashReceiptBills" value="0"/>
<div class="form-group">
    <label class="control-label">Transaction Type</label>
    <div class="col-sm-6">
        <select id="txnTemplate" name="txnTemplate" class="many-to-one form-control">
            <option selected="selected" disabled="true">-- Select a transaction type --</option>
            <g:each in="${icbs.admin.TxnTemplate.findAllByTxnTypeAndMemoTxnType(icbs.lov.TxnType.read(19), icbs.lov.MemoTxnType.read(3),[sort:"code", order:"asc"])}" var="txnTemplateInstance">
                <option value="${txnTemplateInstance.id}" data-code="${txnTemplateInstance.code}">${txnTemplateInstance.codeDescription}</option>
            </g:each>
        </select>
    </div>
</div>

<fieldset class="form-group">
<g:if test="${!txnCashReceiptRemittanceInstance?.beneficiary}">
    <input type="button" href="#" class="btn btn-primary" onclick="initializeCustomerDetailsSearchModal('txnBeneficiaryDetailsDiv');modal.show()"value="Search Customer"/>
</g:if>
</fieldset>

<fieldset class="form-group">
    <div class="col-sm-10" id="txnBeneficiaryDetailsDiv">
        <g:render template='/customer/details/txnCustomerDetails' model="[customerInstance:txnBillsPaymentInstance?.beneficiary]"/>
    </div>
</fieldset>

<div class="fieldcontain form-group ${hasErrors(bean: txnBillsPaymentInstance, field: 'txnAmt', 'has-error')} required">
    <label class="control-label">Bill Amount</label>
    <div class="col-sm-6">
        <g:textField type="number" name="txnAmt" required="" value="${txnBillsPaymentInstance?.txnAmt}"class="form-control truncated" onkeyup="updateVar()"/>
   </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: txnBillsPaymentInstance, field: 'txnRef', 'has-error')} required">
    <label class="control-label col-sm-4" for="txnRef">
        <g:message code="txnBillsPayment.txnRef.label" default="Transaction Reference" />
    </label>
    <div class="col-sm-6">
        <g:textArea name="txnRef" required="" value="${txnBillsPaymentInstance?.txnRef}"class="form-control"/>
    </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: txnBillsPaymentInstance, field: 'txnParticulars', 'has-error')} ">
    <label class="control-label col-sm-4" for="txnParticulars">
        <g:message code="txnBillsPayment.txnParticulars.label" default="Particulars" />
    </label>
    <div class="col-sm-6">
        <g:textArea name="txnParticulars" maxlength="100" value="${txnBillsPaymentInstance?.txnParticulars}"class="form-control"/>
    </div>             
</div>
