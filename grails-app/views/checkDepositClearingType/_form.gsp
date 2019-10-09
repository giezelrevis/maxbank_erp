<%@ page import="icbs.admin.CheckDepositClearingType" %>




<div class="fieldcontain form-group ${hasErrors(bean: checkDepositClearingTypeInstance, field: 'code', 'has-error')} required">
	<label class="control-label col-sm-4" for="code">
		<g:message code="checkDepositClearingType.code.label" default="Code" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="code" maxlength="10" required="" value="${checkDepositClearingTypeInstance?.code}"class="form-control"/>

            <g:hasErrors bean="${checkDepositClearingTypeInstance}" field="code">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${checkDepositClearingTypeInstance}" field="code">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: checkDepositClearingTypeInstance, field: 'description', 'has-error')} required">
	<label class="control-label col-sm-4" for="description">
		<g:message code="checkDepositClearingType.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="description" maxlength="100" required="" value="${checkDepositClearingTypeInstance?.description}"class="form-control"/>

            <g:hasErrors bean="${checkDepositClearingTypeInstance}" field="description">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${checkDepositClearingTypeInstance}" field="description">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: checkDepositClearingTypeInstance, field: 'shortDescription', 'has-error')} required">
	<label class="control-label col-sm-4" for="shortDescription">
		<g:message code="checkDepositClearingType.shortDescription.label" default="Short Description" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="shortDescription" maxlength="50" required="" value="${checkDepositClearingTypeInstance?.shortDescription}"class="form-control"/>

            <g:hasErrors bean="${checkDepositClearingTypeInstance}" field="shortDescription">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${checkDepositClearingTypeInstance}" field="shortDescription">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: checkDepositClearingTypeInstance, field: 'isOnUs', 'has-error')} ">
	<label class="control-label col-sm-4" for="isOnUs">
		<g:message code="checkDepositClearingType.isOnUs.label" default="On Us Type" />
		
	</label>
	<div class="col-sm-8"><g:checkBox name="isOnUs" class="form-control" value="${checkDepositClearingTypeInstance?.isOnUs}" />

            <g:hasErrors bean="${checkDepositClearingTypeInstance}" field="isOnUs">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${checkDepositClearingTypeInstance}" field="isOnUs">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: checkDepositClearingTypeInstance, field: 'hasVariableClearingDays', 'has-error')} ">
	<label class="control-label col-sm-4" for="hasVariableClearingDays">
		<g:message code="checkDepositClearingType.hasVariableClearingDays.label" default="Variable Clearing" />
		
	</label>
	<div class="col-sm-8"><g:checkBox name="hasVariableClearingDays" class="form-control" value="${checkDepositClearingTypeInstance?.hasVariableClearingDays}" />

            <g:hasErrors bean="${checkDepositClearingTypeInstance}" field="hasVariableClearingDays">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${checkDepositClearingTypeInstance}" field="hasVariableClearingDays">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: checkDepositClearingTypeInstance, field: 'clearingDays', 'has-error')} ">
	<label class="control-label col-sm-4" for="clearingDays">
		<g:message code="checkDepositClearingType.clearingDays.label" default="Clearing Days" />
		
	</label>
	<div class="col-sm-8"><g:field name="clearingDays" type="number" value="${checkDepositClearingTypeInstance.clearingDays}" class="form-control"/>

            <g:hasErrors bean="${checkDepositClearingTypeInstance}" field="clearingDays">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${checkDepositClearingTypeInstance}" field="clearingDays">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: checkDepositClearingTypeInstance, field: 'currency', 'has-error')} required">
	<label class="control-label col-sm-4" for="currency">
		<g:message code="checkDepositClearingType.currency.label" default="Currency" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="currency" name="currency.id" from="${icbs.admin.Currency.findAll{configItemStatus.id == 2}}" optionKey="id" optionValue="name" required="" value="${checkDepositClearingTypeInstance?.currency?.id}" class="many-to-one form-control"/>

            <g:hasErrors bean="${checkDepositClearingTypeInstance}" field="currency">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${checkDepositClearingTypeInstance}" field="currency">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div><g:hiddenField name="configItemStatus" value="2" /></div>