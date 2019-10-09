<%@ page import="icbs.cif.Code" %>




<div class="fieldcontain form-group ${hasErrors(bean: codeInstance, field: 'type', 'has-error')} ">
	<label class="control-label col-sm-4" for="type">
		<g:message code="code.typeId.label" default="Type" />
		
	</label>
	<div class="col-sm-8"><g:select id="type" name="type.id"  from="${icbs.lov.Lov.findAllByGroupCodeAndStatus("CIFEXT",true)}" optionKey="id" optionValue ="itemValue" value="${codeInstance?.type?.id}" class="form-control" />

            <g:hasErrors bean="${codeInstance}" field="type">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${codeInstance}" field="type">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: codeInstance, field: 'value', 'has-error')} required">
	<label class="control-label col-sm-4" for="value">
		<g:message code="code.value.label" default="Value" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="value" maxlength="50" required="" value="${codeInstance?.value}"class="form-control"/>

            <g:hasErrors bean="${codeInstance}" field="value">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${codeInstance}" field="value">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

