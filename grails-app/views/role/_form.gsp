<%@ page import="icbs.admin.Role" %>




<div class="fieldcontain form-group ${hasErrors(bean: roleInstance, field: 'code', 'has-error')} required">
	<label class="control-label col-sm-4" for="code">
		<g:message code="role.code.label" default="Code" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="code" maxlength="10" required="" value="${roleInstance?.code}"class="form-control"/>

            <g:hasErrors bean="${roleInstance}" field="code">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${roleInstance}" field="code">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: roleInstance, field: 'name', 'has-error')} required">
	<label class="control-label col-sm-4" for="name">
		<g:message code="role.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="name" maxlength="50" required="" value="${roleInstance?.name}"class="form-control"/>

            <g:hasErrors bean="${roleInstance}" field="name">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${roleInstance}" field="name">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div><g:hiddenField name="configItemStatus" value="2" /></div>

