<%@ page import="icbs.tellering.TxnFile" %>
<g:hiddenField id="OtherCashPaymentAdjustment" name="OtherCashPaymentAdjustment" value="0"/>
<div class="form-group">
    <label class="control-label">Transaction Type</label>
    <div class="col-sm-6">
        <select id="txnTemplate" name="txnTemplate" class="many-to-one form-control" onchange="testchange();">
            <option selected="selected" disabled="true">-- Select a transaction type --</option>
            <g:each in="${icbs.admin.TxnTemplate.findAllByMemoTxnTypeAndTxnType(icbs.lov.MemoTxnType.read(1), icbs.lov.TxnType.read(21),[sort:"code", order:"asc"])}" var="txnTemplateInstance">
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

<div class="fieldcontain form-group ${hasErrors(bean: txnPaymentAdjustmentInstance, field: 'txnAmt', 'has-error')} required">
    <label class="control-label">Transaction Amount</label>
    <div class="col-sm-6">
        <g:textField type="number" id="txnAmt" name="txnAmt" required="" value="${txnPaymentAdjustmentInstance?.txnAmt}"class="form-control truncated"/>
   </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: txnPaymentAdjustmentInstance, field: 'txnRef', 'has-error')} required">
    <label class="control-label">Transaction Reference</label>
    <div class="col-sm-6">
        <g:textArea name="txnRef" required="" value="${txnPaymentAdjustmentInstance?.txnRef}"class="form-control"/>
    </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: txnPaymentAdjustmentInstance, field: 'txnParticulars', 'has-error')} ">
    <label class="control-label">Particulars</label>
    <div class="col-sm-6">
        <g:textArea name="txnParticulars" value="${txnPaymentAdjustmentInstance?.txnParticulars}"class="form-control"/>
    </div>             
</div>
