<%@ page import="icbs.tellering.TxnBreakdown" %>




<div class="fieldcontain form-group ${hasErrors(bean: transactionBreakdownInstance, field: 'debitAcct', 'has-error')} required">
	<label class="control-label col-sm-4" for="debitAcct">
		<g:message code="transactionBreakdown.debitAcct.label" default="Debit Acct" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="debitAcct" required="" value="${transactionBreakdownInstance?.debitAcct}"class="form-control"/>

            <g:hasErrors bean="${transactionBreakdownInstance}" field="debitAcct">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${transactionBreakdownInstance}" field="debitAcct">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>
</div>


<div class="fieldcontain form-group ${hasErrors(bean: transactionBreakdownInstance, field: 'creditAcct', 'has-error')} required">
	<label class="control-label col-sm-4" for="creditAcct">
		<g:message code="transactionBreakdown.creditAcct.label" default="Credit Acct" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="creditAcct" required="" value="${transactionBreakdownInstance?.creditAcct}"class="form-control"/>

            <g:hasErrors bean="${transactionBreakdownInstance}" field="creditAcct">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${transactionBreakdownInstance}" field="creditAcct">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>
</div>


<div class="fieldcontain form-group ${hasErrors(bean: transactionBreakdownInstance, field: 'debitAmt', 'has-error')} required">
	<label class="control-label col-sm-4" for="debitAmt">
		<g:message code="transactionBreakdown.debitAmt.label" default="Debit Amt" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="debitAmt" required="" value="${transactionBreakdownInstance?.debitAmt}"class="form-control"/>

            <g:hasErrors bean="${transactionBreakdownInstance}" field="debitAmt">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${transactionBreakdownInstance}" field="debitAmt">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>
</div>


<div class="fieldcontain form-group ${hasErrors(bean: transactionBreakdownInstance, field: 'creditAmt', 'has-error')} ">
	<label class="control-label col-sm-4" for="creditAmt">
		<g:message code="transactionBreakdown.creditAmt.label" default="Credit Amt" />

	</label>
	<div class="col-sm-8"><g:textField name="creditAmt" value="${transactionBreakdownInstance?.creditAmt}"class="form-control"/>

            <g:hasErrors bean="${transactionBreakdownInstance}" field="creditAmt">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${transactionBreakdownInstance}" field="creditAmt">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>
</div>


<div class="fieldcontain form-group ${hasErrors(bean: transactionBreakdownInstance, field: 'txnDate', 'has-error')} ">
	<label class="control-label col-sm-4" for="txnDate">
		<g:message code="transactionBreakdown.txnDate.label" default="Txn Date" />

	</label>
	<div class="col-sm-8"><g:customDatePicker name="txnDate" precision="day" class="form-control"  value="${transactionBreakdownInstance?.txnDate}" default="none" noSelection="['': '']" />

            <g:hasErrors bean="${transactionBreakdownInstance}" field="txnDate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${transactionBreakdownInstance}" field="txnDate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>
</div>


<div class="fieldcontain form-group ${hasErrors(bean: transactionBreakdownInstance, field: 'currency', 'has-error')} ">
	<label class="control-label col-sm-4" for="currency">
		<g:message code="transactionBreakdown.currency.label" default="Currency" />

	</label>
	<div class="col-sm-8"><g:select id="currency" name="currency.id" from="${icbs.admin.Currency.findAll{configItemStatus.id == 2}}" optionKey="id" value="${transactionBreakdownInstance?.currency?.id}" class="many-to-one form-control" noSelection="['null': '']"/>

            <g:hasErrors bean="${transactionBreakdownInstance}" field="currency">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${transactionBreakdownInstance}" field="currency">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>
</div>
