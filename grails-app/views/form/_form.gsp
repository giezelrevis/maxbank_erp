<%@ page import="icbs.admin.Form" %>




<div class="fieldcontain form-group ${hasErrors(bean: formInstance, field: 'name', 'has-error')} required">
	<label class="control-label col-sm-4" for="name">
		<g:message code="form.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="name" maxlength="100" required="" value="${formInstance?.name}"class="form-control"/>

            <g:hasErrors bean="${formInstance}" field="name">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${formInstance}" field="name">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: formInstance, field: 'sourceFile', 'has-error')} required">
	<label class="control-label col-sm-4" for="sourceFile">
		<g:message code="form.sourceFile.label" default="Source File" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><input type="file" name="file" />

            <g:hasErrors bean="${formInstance}" field="sourceFile">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${formInstance}" field="sourceFile">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div><g:hiddenField name="configItemStatus" value="2" /></div>
<div><g:hiddenField name="sourceFile" value="/web-app" /></div>