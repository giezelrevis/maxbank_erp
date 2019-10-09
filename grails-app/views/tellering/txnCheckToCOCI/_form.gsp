<%@ page import="icbs.tellering.TxnCOCI" %>


<div class="form-group">
    <label class="control-label">Transaction Type</label>
    <div class="col-sm-6">
        <select id="txnTemplate" name="txnTemplate" class="many-to-one form-control">
            <option selected="selected" disabled="true">-- Select a transaction type --</option>
            <g:each in="${icbs.admin.TxnTemplate.findAllByTxnType(icbs.lov.TxnType.read(22),[sort:"code", order:"asc"])}" var="txnTemplateInstance">
                <option value="${txnTemplateInstance.id}" data-code="${txnTemplateInstance.code}">${txnTemplateInstance.codeDescription}</option>
            </g:each>
        </select>
    </div>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: txnCheckToCOCIInstance, field: 'totalChecks', 'has-error')} ">
    <label class="control-label col-sm-4" for="totalChecks">
        <g:message code="txnCheckToCOCI.totalChecks.label" default="Total Checks" />
    </label>

    <div class="col-sm-6">
        <g:textField name="totalChecks" value="0.00" class="form-control truncated"/>
    </div>             
</div>

<div class="form-group">
<div class="table-responsive">
    <table class="table table-hover table-condensed table-bordered table-striped" id="div_func">
        <thead>
                <tr>

                        <g:sortableColumn property="id" title="${message(code: 'txnCOCI.id.label', default: 'ID')}" />

                        <g:sortableColumn property="checkType" title="${message(code: 'txnCOCI.checkType.label', default: 'Check Type')}" />

                        <g:sortableColumn property="bank" title="${message(code: 'txnCOCI.bank.label', default: 'Bank')}" />

                        <th><g:message code="txnCOCI.acctNo.label" default="Account No." /></th>
                        
                        <g:sortableColumn property="checkDate" title="${message(code: 'txnCOCI.checkDate.label', default: 'Check Date')}" />
                        
                        <g:sortableColumn property="checkNo" title="${message(code: 'txnCOCI.checkNo.label', default: 'Check No.')}" />

                        <g:sortableColumn property="clearingDate" title="${message(code: 'txnCOCI.clearingDate.label', default: 'Clearing Date')}" />

                        <g:sortableColumn property="checkAmt" align="right" title="${message(code: 'txnCOCI.checkAmt.label', default: 'Amount')}" />
                        <g:sortableColumn property="txnCheckStatus" title="pos" />
                      
                        <th>Transfer</th>
                        
                </tr>
                <input class="btn btn-primary" type="button" id="toggle" value="Select All" onClick="do_this()" />
        </thead>
        <tbody>
           
            
        <g:each in="${TxnCOCIList}"  status="i" var="txnCOCIInstance">
                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                    
                        <td>${txnCOCIInstance.id}</td>

                        <td>${txnCOCIInstance.checkType.description}</td>
                        
                        <td>${fieldValue(bean: txnCOCIInstance, field: "bank.name")}</td>

                        <td>${fieldValue(bean: txnCOCIInstance, field: "acctNo")}</td>

                        <td><g:formatDate format="yyyy-MM-dd" date="${txnCOCIInstance.checkDate}"/></td>

                        <td>${fieldValue(bean: txnCOCIInstance, field: "checkNo")}</td>
                        
                      
                         <td><g:formatDate format="yyyy-MM-dd" date="${txnCOCIInstance.clearingDate}"/></td>
                        
                        <td>${fieldValue(bean: txnCOCIInstance, field: "checkAmt")}</td>
                        <td>${fieldValue(bean: txnCOCIInstance, field: "txnCheckStatus.description")}</td>
                        
                        <td>
                            <g:if test="${txnCOCIInstance.txnCheckStatus == icbs.lov.TxnCheckStatus.get(2)}">
                                <g:checkBox onclick="btnCompute()" name="cleared" value="${txnCOCIInstance.id}" checked="false"  />
                            </g:if>
                            <g:else>
                                <!--
                                <g:checkBox onclick="btnCompute()" name="cleared" value="${txnCOCIInstance.id}" checked="false" style="display:none" />
                                -->
                                <g:checkBox onclick="btnCompute()" name="cleared" value="${txnCOCIInstance.id}" checked="false" disabled="disabled"/>
                            </g:else>
                        </td>   
                        
                        <!--
                        <td><g:checkBox name="cleared" value="${txnCOCIInstance?.cleared}" checked="false" onclick="${remoteFunction(action:'toggleCheckStatus', id:txnCOCIInstance.id, params:'\'cleared=\' + this.checked')}" /></td>             
                        -->
                </tr>
        </g:each>
        </tbody>
    </table>
</div>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: txnCheckToCOCIInstance, field: 'txnAmt', 'has-error')} ">
    <label class="control-label col-sm-4" for="txnAmt">
        <g:message code="txnCheckToCOCI.txnAmt.label" default="Check Control Total" />
    </label>

    <div class="col-sm-6">
        <g:field id="txnAmt" name="txnAmt" disabled="" value="0.00" class="form-control"/>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: txnCheckToCOCIInstance, field: 'txnRef', 'has-error')} ">
    <label class="control-label col-sm-4" for="txnRef">
            <g:message code="txnCheckToCOCI.txnRef.label" default="Transaction Reference" />
    </label>

    <div class="col-sm-6">
        <g:textArea name="txnRef" value="${txnCheckToCOCIInstance?.txnRef}" class="form-control"/>
    </div>             
</div>

<script>
  
        function btnCompute(){
            
            var checkbox = document.getElementsByName('cleared');
          //   console.log('cb l :'+checkbox.length);
            var value_check = 0.00;accounting.formatNumber(value_check,2)
            for (i=0; i < checkbox.length; i++) {
                if (checkbox[i].checked) {
                    value_check += accounting.unformat(document.getElementById('div_func').rows[i+1].cells[7].innerText);
                  //  value_check += s;
                }
            }
            
            $('#txnAmt').val(accounting.formatNumber(value_check,2));
         //   console.log(value_check);
        }
  
</script>