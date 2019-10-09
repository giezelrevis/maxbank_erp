<div class="fieldcontain form-group ${hasErrors(bean: accountsPayableInstance, field: 'currency', 'has-error')} required">
    <label class="control-label col-sm-4" for="currency">Currency<span class="required-indicator">*</span></label>            
    <div class="col-sm-8">
        <g:select id="currency" name="currency.id" from="${icbs.admin.Currency.list()}" optionKey="id" optionValue="name" required="" value="${accountsPayableInstance?.currency?.id}" class="many-to-one form-control"/>
        <g:hasErrors bean="${accountsPayableInstance}" field="currency">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${accountsPayableInstance}" field="currency">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: accountsPayableInstance, field: 'glContra', 'has-error')} required">
    <label class="control-label col-sm-4" for="glContra">GL Account Code<span class="required-indicator">*</span></label>
    <div class="col-sm-8"><g:textField name="glContra" id="glContra" maxlength="25" required="" value="${accountsPayableInstance?.glContra}" onblur="validateGlCode();" class="form-control"/>
        <g:hasErrors bean="${accountsPayableInstance}" field="glContra">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${accountsPayableInstance}" field="glContra">
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
<div class="fieldcontain form-group ${hasErrors(bean: accountsPayableInstance, field: 'payable', 'has-error')} required">
    <label class="control-label col-sm-4" for="payable">Payable<span class="required-indicator">*</span></label>
    <div class="col-sm-8"><g:textField name="payable" maxlength="100" required="" value="${accountsPayableInstance?.payable}"class="form-control"/>
        <g:hasErrors bean="${accountsReceivableInstance}" field="payable">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${accountsPayableInstance}" field="payable">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

 <g:hiddenField name="accountsPayableId" id="accountsPayableId" value="${params.id}" />

<div class="fieldcontain form-group ${hasErrors(bean: accountsPayableInstance, field: 'particulars', 'has-error')} required">
    <label class="control-label col-sm-4" for="particulars">Particulars</label>
    <div class="col-sm-8"><g:textField name="particulars" maxlength="200" required="" value="${accountsPayableInstance?.particulars}"class="form-control"/>
        <g:hasErrors bean="${accountsPayableInstance}" field="particulars">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${accountsPayableInstance}" field="particulars">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>
<g:hiddenField id="financialYear" name="financialYear" value="${g.formatDate(date: (runDate), format: 'yyyy')}"/>