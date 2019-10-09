<div class="fieldcontain form-group ${hasErrors(bean: accountsReceivableInstance, field: 'currency', 'has-error')} required">
    <label class="control-label col-sm-4" for="currency">Currency<span class="required-indicator">*</span></label>            
    <div class="col-sm-8">
        <g:select id="currency" name="currency.id" from="${icbs.admin.Currency.list()}" optionKey="id" optionValue="name" required="" value="${accountsReceivableInstance?.currency?.id}" class="many-to-one form-control"/>
        <g:hasErrors bean="${accountsReceivableInstance}" field="currency">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${accountsReceivableInstance}" field="currency">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>
<div class="fieldcontain form-group ${hasErrors(bean: accountsReceivableInstance, field: 'glContra', 'has-error')} required">
    <label class="control-label col-sm-4" for="glContra">GL Account Code<span class="required-indicator">*</span></label>
    <div class="col-sm-8"><g:textField name="glContra" id="glContra" maxlength="25" required="" value="${accountsReceivableInstance?.glContra}" onblur="validateGlCode();" class="form-control"/>
        <g:hasErrors bean="${accountsReceivableInstance}" field="glContra">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${accountsReceivableInstance}" field="glContra">
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
<div class="fieldcontain form-group ${hasErrors(bean: accountsReceivableInstance, field: 'receivableName', 'has-error')} required">
    <label class="control-label col-sm-4" for="receivableName">Receivable</label>
    <div class="col-sm-8"><g:textField name="receivableName" maxlength="100" required="" value="${accountsReceivableInstance?.receivableName}"class="form-control"/>
        <g:hasErrors bean="${accountsReceivableInstance}" field="receivableName">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${accountsReceivableInstance}" field="receivableName">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: accountsReceivableInstance, field: 'description', 'has-error')} required">
    <label class="control-label col-sm-4" for="description">Description</label>
    <div class="col-sm-8"><g:textField name="description" maxlength="100" required="" value="${accountsReceivableInstance?.description}"class="form-control"/>
        <g:hasErrors bean="${accountsReceivableInstance}" field="description">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${accountsReceivableInstance}" field="description">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: accountsReceivableInstance, field: 'reference', 'has-error')} required">
    <label class="control-label col-sm-4" for="reference">Reference</label>
    <div class="col-sm-8"><g:textField name="reference" maxlength="100" required="" value="${accountsReceivableInstance?.reference}"class="form-control"/>
        <g:hasErrors bean="${accountsReceivableInstance}" field="reference">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${accountsReceivableInstance}" field="reference">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>
<g:hiddenField id="financialYear" name="financialYear" value="${g.formatDate(date: (runDate), format: 'yyyy')}"/>