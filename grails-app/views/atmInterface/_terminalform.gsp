<%@ page import="icbs.atm.AtmTerminalMapping" %>

<div class="fieldcontain form-group ${hasErrors(bean: atmTerminalInstance, field: 'terminalCode', 'has-error')} required">
	<label class="control-label col-sm-4" for="terminalCode">
		<g:message code="atmTerminalInstance.terminalCode.label" default="Terminal Code" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="terminalCode" maxlength="10" required="" value="${atmTerminalInstance?.terminalCode}"class="form-control"/>
            <g:hasErrors bean="${atmTerminalInstance}" field="terminalCode">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${atmTerminalMappingInstance}" field="terminalCode">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: atmTerminalInstance, field: 'remarks', 'has-error')} required">
	<label class="control-label col-sm-4" for="remarks">
		<g:message code="atmTerminalInstance.remarks.label" default="Remarks" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textArea name="remarks" rows="5" cols="50" required="" value="${atmTerminalInstance?.remarks}"class="form-control"/>
            <g:hasErrors bean="${atmTerminalInstance}" field="remarks">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${atmTerminalInstance}" field="remarks">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: atmTerminalInstance, field: 'branch', 'has-error')} required">
	<label class="control-label col-sm-4" for="branch">
		<g:message code="atmTerminalInstance.branch.label" default="Branch" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="branch" name="branch.id" from="${icbs.admin.Branch.findAll{status.id == 2}}" optionKey="id" optionValue="name" required="" value="${atmTerminalInstance?.branch?.id}"  class="many-to-one form-control"/>

            <g:hasErrors bean="${atmTerminalInstance}" field="branch">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${atmTerminalInstance}" field="branch">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<div><g:hiddenField name="terminalStatus" value="2" /></div>
