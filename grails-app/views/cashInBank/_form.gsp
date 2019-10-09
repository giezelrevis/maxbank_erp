<%@ page import="icbs.gl.CashInBank" %>

<div class="fieldcontain form-group ${hasErrors(bean: cashInBankInstance, field: 'type', 'has-error')} required">
    <label class="control-label col-sm-4" for="type">Deposit Type<span class="required-indicator">*</span></label>            
    <div class="col-sm-8">
        <g:select id="type" name="type.id" from="${icbs.lov.DepositType.list()}" optionKey="id" optionValue="description" required="" value="${cashInBankInstance?.type?.id}" class="many-to-one form-control"/>
        <g:hasErrors bean="${cashInBankInstance}" field="type">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${cashInBankInstance}" field="type">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: cashInBankInstance, field: 'currency', 'has-error')} required">
    <label class="control-label col-sm-4" for="currency">Deposit Currency<span class="required-indicator">*</span></label>            
    <div class="col-sm-8">
        <g:select id="currency" name="currency.id" from="${icbs.admin.Currency.list()}" optionKey="id" optionValue="name" required="" value="${cashInBankInstance?.currency?.id}" class="many-to-one form-control"/>
        <g:hasErrors bean="${cashInBankInstance}" field="currency">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${cashInBankInstance}" field="currency">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: cashInBankInstance, field: 'bankName', 'has-error')} required">
    <label class="control-label col-sm-4" for="bankName">Bank Name<span class="required-indicator">*</span></label>
    <div class="col-sm-8"><g:textField name="bankName" maxlength="30" required="" value="${cashInBankInstance?.bankName}"class="form-control"/>
        <g:hasErrors bean="${cashInBankInstance}" field="bankName">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${cashInBankInstance}" field="bankName">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: cashInBankInstance, field: 'bankBranch', 'has-error')} required">
    <label class="control-label col-sm-4" for="bankBranch">Branch Name<span class="required-indicator">*</span></label>
    <div class="col-sm-8"><g:textField name="bankBranch" maxlength="25" required="" value="${cashInBankInstance?.bankBranch}"class="form-control"/>
        <g:hasErrors bean="${cashInBankInstance}" field="bankBranch">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${cashInBankInstance}" field="bankBranch">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: cashInBankInstance, field: 'bankAddress', 'has-error')} required">
    <label class="control-label col-sm-4" for="bankAddress">Bank Address</label>
    <div class="col-sm-8"><g:textField name="bankAddress" maxlength="50" required="" value="${cashInBankInstance?.bankAddress}"class="form-control"/>
        <g:hasErrors bean="${cashInBankInstance}" field="bankAddress">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${cashInBankInstance}" field="bankAddress">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: cashInBankInstance, field: 'acctNo', 'has-error')} required">
    <label class="control-label col-sm-4" for="acctNo">Account Number<span class="required-indicator">*</span></label>
    <div class="col-sm-8"><g:textField name="acctNo" maxlength="25" required="" value="${cashInBankInstance?.acctNo}"class="form-control"/>
        <g:hasErrors bean="${cashInBankInstance}" field="acctNo">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${cashInBankInstance}" field="acctNo">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: cashInBankInstance, field: 'intRate', 'has-error')} required">
    <label class="control-label col-sm-4" for="intRate">Interest Rate<span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
        <g:field class="form-control" type="number" name="intRate" value="${fieldValue(bean: cashInBankInstance, field: 'intRate')}" />
        <g:hasErrors bean="${cashInBankInstance}" field="intRate">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${cashInBankInstance}" field="intRate">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: cashInBankInstance, field: 'openDate', 'has-error')}">
	<label class="control-label col-sm-4" for="openDate">
		Date Opened 
		<span class="required-indicator">*</span>
	</label>
    <div class="col-sm-8"><g:customDatePicker name="openDate" precision="day" 
    class="form-control" value="${cashInBankInstance?.openDate}" />

        <g:hasErrors bean="${cashInBankInstance}" field="openDate">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${cashInBankInstance}" field="openDate">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: cashInBankInstance, field: 'maturityDate', 'has-error')}">
    <label class="control-label col-sm-4" for="maturityDate">Maturity Date </label>
    <div class="col-sm-8"><g:customDatePicker name="maturityDate" precision="day" 
    class="form-control" value="${cashInBankInstance?.maturityDate}" />

        <g:hasErrors bean="${cashInBankInstance}" field="maturityDate">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${cashInBankInstance}" field="maturityDate">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: cashInBankInstance, field: 'glContra', 'has-error')} required">
    <label class="control-label col-sm-4" for="glContra">GL Account Code<span class="required-indicator">*</span></label>
    <div class="col-sm-8"><g:textField name="glContra" id="glContra" maxlength="25" required="" value="${cashInBankInstance?.glContra}" onblur="validateGlCode();" class="form-control"/>
        <g:hasErrors bean="${cashInBankInstance}" field="glContra">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${cashInBankInstance}" field="glContra">
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

<div class="fieldcontain form-group ${hasErrors(bean: cashInBankInstance, field: 'remarks', 'has-error')} required">
    <label class="control-label col-sm-4" for="remarks">Remarks</label>
    <div class="col-sm-8"><g:textField name="remarks" maxlength="100" required="" value="${cashInBankInstance?.remarks}"class="form-control"/>
        <g:hasErrors bean="${cashInBankInstance}" field="remarks">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${cashInBankInstance}" field="remarks">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>
<g:hiddenField id="financialYear" name="financialYear" value="${g.formatDate(date: (runDate), format: 'yyyy')}"/>