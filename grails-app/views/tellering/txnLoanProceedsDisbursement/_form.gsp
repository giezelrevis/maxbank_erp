<%@ page import="icbs.tellering.TxnLoanPaymentDetails" %>

<div class="form-group">
    <label class="control-label">Transaction Type</label>
    <div class="col-sm-6">
        <select id="txnTemplate" name="txnTemplate" class="many-to-one form-control" onchange="testchange()">
            <option selected="selected" disabled="true">-- Select a transaction type --</option>
            <g:each in="${icbs.admin.TxnTemplate.findAllByTxnType(icbs.lov.TxnType.read(11),[sort:"code", order:"asc"])}" var="txnTemplateInstance">
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
    <div class="col-sm-10">
        <fieldset class="form-group">
            <g:if test="${!txnLoanProceedsDisbursementInstance?.acct}">
                <input type="button" href="#" class="btn btn-primary" onclick="initializeLoanAcctSearchModal();modal.show()" value="Search Account"/>
            </g:if>
        </fieldset>
        <g:hiddenField id="loanId" name="loanId"/>
        <g:hiddenField id="Net_Proceeds" name="Net_Proceeds"/>
        <g:hiddenField id="Net_Disburse" name="Net_Disburse"/>
        <g:hiddenField id="DisburseAmt" name="DisburseAmt"/>
        <g:hiddenField id="TotalProceeds" name="TotalProceeds" value="0"/>
        <%--<g:render template='/tellering/details/loanDetails' model="[loanInstance:txnLoanProceedsDisbursementInstance?.acct]"/>--%>
        
        <div class="section-container">
        <fieldset>
        <legend class="section-header">Account Information</legend>
        <div class="infowrap">
        <div class="col-xs-8 col-sm-6 col-md-6">
             <dl class="dl-horizontal">
                <dt>Account Number</dt>
                <dd id="accountNo"></dd>
            </dl>            
            <dl class="dl-horizontal">
                <dt>Account Name</dt>
                <dd id="customer"></dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Date Opened</dt>
                <dd id="openingDate"></dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Status</dt>
                <dd id="status"></dd>
            </dl>        
            <dl class="dl-horizontal">
                <dt>Granted Amount</dt>
                <dd id="grantedAmt"></dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Amount for Disbursement</dt>
                <dd id="totalNetProceeds1"></dd>
            </dl>
        </div>
        </div>
        <div class="infowrap">
            <dl class="dl-horizontal">
                <dd id="photo"><g:if test="${(loanInstance?.customer?.attachments?.find{it.isPrimaryPhoto==true})?.id}"> <img width="120px" style="float:right" height="120px"src="${createLink(controller:'Attachment', action:'show', id: (loanInstance?.customer?.attachments?.find{it.isPrimaryPhoto==true})?.id )}"/></g:if></dd>
            </dl>
        </div>
        </fieldset>
        </div>
    </div>
</fieldset>

<div class="fieldcontain form-group ${hasErrors(bean: txnLoanProceedsDisbursementInstance, field: 'totalNetProceeds', 'has-error')} required">
    <label class="control-label">Net Proceeds</label>
    <div class="col-sm-6">
        <g:textField id="totalNetProceeds" type="number" name="totalNetProceeds" required="" class="form-control truncated" onkeyup="updateBreakdown()"/>
   </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: txnLoanProceedsDisbursementInstance, field: 'txnRef', 'has-error')} required">
    <label class="control-label col-sm-4" for="txnRef">
        <g:message code="txnLoanProceedsDisbursement.txnRef.label" default="Transaction Reference" />
    </label>
    <div class="col-sm-6">
        <g:textArea name="txnRef" required="" value="${txnLoanProceedsDisbursementInstance?.txnRef}"class="form-control"/>
    </div>             
</div>