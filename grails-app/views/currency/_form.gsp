<%@ page import="icbs.admin.Currency" %>

<div class="fieldcontain form-group ${hasErrors(bean: currencyInstance, field: 'code', 'has-error')} required">
	<label class="control-label col-sm-4" for="code">
		<g:message code="currency.code.label" default="Code" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="code" maxlength="5" required="" value="${currencyInstance?.code}"class="form-control"/>

            <g:hasErrors bean="${currencyInstance}" field="code">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${currencyInstance}" field="code">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: currencyInstance, field: 'name', 'has-error')} required">
	<label class="control-label col-sm-4" for="name">
		<g:message code="currency.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="name" maxlength="50" required="" value="${currencyInstance?.name}"class="form-control"/>

            <g:hasErrors bean="${currencyInstance}" field="name">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${currencyInstance}" field="name">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div><g:hiddenField name="configItemStatus" value="2" /></div>
