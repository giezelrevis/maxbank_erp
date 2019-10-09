<%@ page import="icbs.admin.CustomerGroup" %>


<div class="fieldcontain form-group ${hasErrors(bean: customerGroupInstance, field: 'code', 'has-error')} required">
	<label class="control-label col-sm-4" for="code">
		<g:message code="customerGroup.code.label" default="Code" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="code" maxlength="10" required="" value="${customerGroupInstance?.code}"class="form-control"/>

            <g:hasErrors bean="${customerGroupInstance}" field="code">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerGroupInstance}" field="code">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: customerGroupInstance, field: 'name', 'has-error')} required">
	<label class="control-label col-sm-4" for="name">
		<g:message code="customerGroup.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="name" maxlength="50" required="" value="${customerGroupInstance?.name}"class="form-control"/>

            <g:hasErrors bean="${customerGroupInstance}" field="name">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerGroupInstance}" field="name">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
