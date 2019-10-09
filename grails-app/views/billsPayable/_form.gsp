<div class="fieldcontain form-group ${hasErrors(bean: billsPayableInstance, field: 'currency', 'has-error')} required">
    <label class="control-label col-sm-4" for="currency">Currency<span class="required-indicator">*</span></label>            
    <div class="col-sm-8">
        <g:select id="currency" name="currency.id" from="${icbs.admin.Currency.list()}" optionKey="id" optionValue="name" required="" value="${billsPayableInstance?.currency?.id}" class="many-to-one form-control"/>
        <g:hasErrors bean="${billsPayableInstance}" field="currency">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${billsPayableInstance}" field="currency">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: billsPayableInstance, field: 'glContra', 'has-error')} required">
    <label class="control-label col-sm-4" for="glContra">GL Account Code<span class="required-indicator">*</span></label>
    <div class="col-sm-8"><g:textField name="glContra" id="glContra" maxlength="25" required="" value="${billsPayableInstance?.glContra}" onblur="validateGlCode();" class="form-control"/>
        <g:hasErrors bean="${billsPayableInstance}" field="glContra">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${billsPayableInstance}" field="glContra">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>
<div id="glaccountdescription" class="fieldcontain form-group ${hasErrors(bean: txnTemplateInstance, field: 'depcontra', 'has-error')} required">
	<label class="control-label col-sm-4" for="memoTxnType">
		<g:message code="txnTemplate.memoTxnType.label" default="Gl Acct Description" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField readonly="true" name="gldescription" id="gldescription" maxlength="100" value="${txnTemplateInstance?.amlaCode}" onblur="validateGlCode();" class="form-control"/>

            <g:hasErrors bean="${txnTemplateInstance}" field="memoTxnType">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnTemplateInstance}" field="memoTxnType">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<div class="fieldcontain form-group ${hasErrors(bean: billsPayableInstance, field: 'creditorName', 'has-error')} required">
    <label class="control-label col-sm-4" for="creditorName">Creditor Name<span class="required-indicator">*</span></label>
    <div class="col-sm-8"><g:textField name="creditorName" maxlength="50" required="" value="${billsPayableInstance?.creditorName}"class="form-control"/>
        <g:hasErrors bean="${billsPayableInstance}" field="creditorName">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${billsPayableInstance}" field="creditorName">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: billsPayableInstance, field: 'dateOpened', 'has-error')}">
	<label class="control-label col-sm-4" for="dateOpened">
		Date Opened
		<span class="required-indicator">*</span>
	</label>
    <div class="col-sm-8"><g:customDatePicker name="dateOpened" precision="day" 
    class="form-control" value="${billsPayableInstance?.dateOpened}" />

        <g:hasErrors bean="${billsPayableInstance}" field="dateOpened">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${billsPayableInstance}" field="dateOpened">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: billsPayableInstance, field: 'dueDate', 'has-error')}">
	<label class="control-label col-sm-4" for="dueDate">
		Maturity Date
		<span class="required-indicator">*</span>
	</label>
    <div class="col-sm-8"><g:customDatePicker name="dueDate" precision="day" 
    class="form-control" value="${billsPayableInstance?.dueDate}" />

        <g:hasErrors bean="${billsPayableInstance}" field="dueDate">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${billsPayableInstance}" field="dueDate">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: billsPayableInstance, field: 'pnDate', 'has-error')}">
	<label class="control-label col-sm-4" for="pnDate">
		Promissory Note Date
		<span class="required-indicator">*</span>
	</label>
    <div class="col-sm-8"><g:customDatePicker name="pnDate" precision="day" 
    class="form-control" value="${billsPayableInstance?.pnDate}" />

        <g:hasErrors bean="${billsPayableInstance}" field="pnDate">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${billsPayableInstance}" field="pnDate">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: billsPayableInstance, field: 'pnNo', 'has-error')} required">
    <label class="control-label col-sm-4" for="pnNo">Promissory Note Number</label>
    <div class="col-sm-8"><g:textField name="pnNo" maxlength="50" required="" value="${billsPayableInstance?.pnNo}"class="form-control"/>
        <g:hasErrors bean="${billsPayableInstance}" field="pnNo">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${billsPayableInstance}" field="pnNo">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: billsPayableInstance, field: 'pdcIssuedText', 'has-error')} required">
    <label class="control-label col-sm-4" for="pdcIssuedText">Post Dated Check Issued</label>
    <div class="col-sm-8"><g:textField name="pdcIssuedText" maxlength="50" required="" value="${billsPayableInstance?.pdcIssuedText}"class="form-control"/>
        <g:hasErrors bean="${billsPayableInstance}" field="pdcIssuedText">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${billsPayableInstance}" field="pdcIssuedText">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: billsPayableInstance, field: 'accountName', 'has-error')} required">
    <label class="control-label col-sm-4" for="accountName">Account Name</label>
    <div class="col-sm-8"><g:textField name="accountName" maxlength="50" required="" value="${billsPayableInstance?.accountName}"class="form-control"/>
        <g:hasErrors bean="${billsPayableInstance}" field="accountName">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${billsPayableInstance}" field="accountName">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: billsPayableInstance, field: 'payee', 'has-error')} required">
    <label class="control-label col-sm-4" for="payee">Payee</label>
    <div class="col-sm-8"><g:textField name="payee" maxlength="50" required="" value="${billsPayableInstance?.payee}"class="form-control"/>
        <g:hasErrors bean="${billsPayableInstance}" field="payee">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${billsPayableInstance}" field="payee">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: billsPayableInstance, field: 'interestRate', 'has-error')} required">
    <label class="control-label col-sm-4" for="intRate">Interest Rate<span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
        <g:field class="form-control" type="number" name="interestRate" value="${billsPayableInstance?.interestRate}" />
        <g:hasErrors bean="${billsPayableInstance}" field="interestRate">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${billsPayableInstance}" field="interestRate">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>
<g:hiddenField id="financialYear" name="financialYear" value="${g.formatDate(date: (runDate), format: 'yyyy')}"/>