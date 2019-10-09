<%@ page import="icbs.deposit.FixedDepositTermScheme" %>




<div class="fieldcontain form-group ${hasErrors(bean: fixedDepositTermSchemeInstance, field: 'code', 'has-error')} required">
	<label class="control-label col-sm-4" for="code">
		<g:message code="fixedDepositTermScheme.code.label" default="Code" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="code" maxlength="10" required="" value="${fixedDepositTermSchemeInstance?.code}"class="form-control"/>

            <g:hasErrors bean="${fixedDepositTermSchemeInstance}" field="code">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${fixedDepositTermSchemeInstance}" field="code">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<div class="fieldcontain form-group ${hasErrors(bean: fixedDepositTermSchemeInstance, field: 'name', 'has-error')} required">
	<label class="control-label col-sm-4" for="name">
		<g:message code="fixedDepositTermScheme.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="name" maxlength="50" value="${fixedDepositTermSchemeInstance?.name}"class="form-control"/>

            <g:hasErrors bean="${fixedDepositTermSchemeInstance}" field="name">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${fixedDepositTermSchemeInstance}" field="name">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: fixedDepositTermSchemeInstance, field: 'description', 'has-error')} ">
	<label class="control-label col-sm-4" for="description">
		<g:message code="fixedDepositTermScheme.description.label" default="Description" />
		
	</label>
	<div class="col-sm-8"><g:textArea name="description" cols="40" rows="5" maxlength="255" value="${fixedDepositTermSchemeInstance?.description}"class="form-control"/>

            <g:hasErrors bean="${fixedDepositTermSchemeInstance}" field="description">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${fixedDepositTermSchemeInstance}" field="description">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: fixedDepositTermSchemeInstance, field: 'value', 'has-error')} required">
	<label class="control-label col-sm-4" for="value">
		<g:message code="fixedDepositTermScheme.value.label" default="Value" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="value" maxlength="50" required="" value="${fixedDepositTermSchemeInstance?.value}"class="form-control"/>

            <g:hasErrors bean="${fixedDepositTermSchemeInstance}" field="value">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${fixedDepositTermSchemeInstance}" field="value">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: fixedDepositTermSchemeInstance, field: 'termMin', 'has-error')} required">
	<label class="control-label col-sm-4" for="termMin">
		<g:message code="fixedDepositTermScheme.termMin.label" default="Term Min" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="termMin" value="${fieldValue(bean: fixedDepositTermSchemeInstance, field: 'termMin')}" required="" class="form-control"/>

            <g:hasErrors bean="${fixedDepositTermSchemeInstance}" field="termMin">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${fixedDepositTermSchemeInstance}" field="termMin">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: fixedDepositTermSchemeInstance, field: 'termMax', 'has-error')} required">
	<label class="control-label col-sm-4" for="termMax">
		<g:message code="fixedDepositTermScheme.termMax.label" default="Term Max" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="termMax" value="${fieldValue(bean: fixedDepositTermSchemeInstance, field: 'termMax')}" required="" class="form-control"/>

            <g:hasErrors bean="${fixedDepositTermSchemeInstance}" field="termMax">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${fixedDepositTermSchemeInstance}" field="termMax">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<g:if test="${fixedDepositTermSchemeInstance?.id}">
    <div class="fieldcontain form-group ${hasErrors(bean: fixedDepositTermSchemeInstance, field: 'status', 'has-error')} ">
            <label class="control-label col-sm-4" for="status">
                    <g:message code="fixedDepositTermScheme.status.label" default="Status" />

            </label>
            <div class="col-sm-8"><g:select id="status" name="status.id" from="${icbs.lov.ConfigItemStatus.list()}" optionKey="id" optionValue="description"value="${fixedDepositTermSchemeInstance?.status?.id}" class="many-to-one form-control" noSelection="['null': '']"/>

                <g:hasErrors bean="${fixedDepositTermSchemeInstance}" field="status">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${fixedDepositTermSchemeInstance}" field="status">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>
</g:if>
