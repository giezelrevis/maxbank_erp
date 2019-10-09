<%@ page import="icbs.gl.CfgAcctGlTemplate" %>




<div class="fieldcontain form-group ${hasErrors(bean: cfgAcctGlTemplateInstance, field: 'description', 'has-error')} required">
	<label class="control-label col-sm-4" for="description">
		<g:message code="cfgAcctGlTemplate.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="description" required="" value="${cfgAcctGlTemplateInstance?.description}"class="form-control"/>

            <g:hasErrors bean="${cfgAcctGlTemplateInstance}" field="description">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${cfgAcctGlTemplateInstance}" field="description">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: cfgAcctGlTemplateInstance, field: 'type', 'has-error')} required">
	<label class="control-label col-sm-4" for="type">
		<g:message code="cfgAcctGlTemplate.type.label" default="Type" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="type" required="" value="${cfgAcctGlTemplateInstance?.type}"class="form-control"/>

            <g:hasErrors bean="${cfgAcctGlTemplateInstance}" field="type">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${cfgAcctGlTemplateInstance}" field="type">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


