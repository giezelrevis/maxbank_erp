<%@ page import="icbs.admin.GlConfigSettings" %>




<div class="fieldcontain form-group ${hasErrors(bean: glConfigSettingsInstance, field: 'currency', 'has-error')} required">
	<label class="control-label col-sm-4" for="currency">
		<g:message code="glConfigSettings.currency.label" default="Currency" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="currency" name="currency.id" from="${icbs.admin.Currency.findAll{configItemStatus.id == 2}}" optionKey="id" required="" value="${glConfigSettingsInstance?.currency?.id}" class="many-to-one form-control"/>

            <g:hasErrors bean="${glConfigSettingsInstance}" field="currency">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${glConfigSettingsInstance}" field="currency">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: glConfigSettingsInstance, field: 'revaluationPolicy', 'has-error')} required">
	<label class="control-label col-sm-4" for="revaluationPolicy">
		<g:message code="glConfigSettings.revaluationPolicy.label" default="Revaluation Policy" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="revaluationPolicy" required="" value="${glConfigSettingsInstance?.revaluationPolicy}"class="form-control"/>

            <g:hasErrors bean="${glConfigSettingsInstance}" field="revaluationPolicy">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${glConfigSettingsInstance}" field="revaluationPolicy">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: glConfigSettingsInstance, field: 'taxMonthEnd', 'has-error')} required">
	<label class="control-label col-sm-4" for="taxMonthEnd">
		<g:message code="glConfigSettings.taxMonthEnd.label" default="Tax Month End" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="taxMonthEnd" type="number" value="${glConfigSettingsInstance.taxMonthEnd}" required="" class="form-control"/>

            <g:hasErrors bean="${glConfigSettingsInstance}" field="taxMonthEnd">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${glConfigSettingsInstance}" field="taxMonthEnd">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: glConfigSettingsInstance, field: 'errorAcct', 'has-error')} required">
	<label class="control-label col-sm-4" for="errorAcct">
		<g:message code="glConfigSettings.errorAcct.label" default="Error Acct" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="errorAcct" name="errorAcct.id" from="${icbs.gl.GlAccount.list()}" optionKey="id" required="" value="${glConfigSettingsInstance?.errorAcct?.id}" class="many-to-one form-control"/>

            <g:hasErrors bean="${glConfigSettingsInstance}" field="errorAcct">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${glConfigSettingsInstance}" field="errorAcct">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

