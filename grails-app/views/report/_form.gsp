<%@ page import="icbs.admin.Report" %>




<div class="fieldcontain form-group ${hasErrors(bean: reportInstance, field: 'name', 'has-error')} required">
	<label class="control-label col-sm-4" for="name">
		<g:message code="report.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="name" maxlength="100" required="" value="${reportInstance?.name}"class="form-control"/>

            <g:hasErrors bean="${reportInstance}" field="name">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${reportInstance}" field="name">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: reportInstance, field: 'reportGroup', 'has-error')} ">
	<label class="control-label col-sm-4" for="reportGroup">
		<g:message code="report.reportGroup.label" default="Report Group" />
		
	</label>
	<div class="col-sm-8"><g:select id="reportGroup" name="reportGroup.id" from="${icbs.lov.ReportGroup.list()}" optionKey="id" value="${reportInstance?.reportGroup?.id}" class="many-to-one form-control" noSelection="['null': '']"/>

            <g:hasErrors bean="${reportInstance}" field="reportGroup">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${reportInstance}" field="reportGroup">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: reportInstance, field: 'reportType', 'has-error')} ">
	<label class="control-label col-sm-4" for="reportType">
		<g:message code="report.reportType.label" default="Report Type" />
		
	</label>
	<div class="col-sm-8"><g:select id="reportType" name="reportType.id" from="${icbs.lov.ReportType.list()}" optionKey="id" value="${reportInstance?.reportType?.id}" class="many-to-one form-control" noSelection="['null': '']"/>

            <g:hasErrors bean="${reportInstance}" field="reportType">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${reportInstance}" field="reportType">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: reportInstance, field: 'sourceFile', 'has-error')} required">
	<label class="control-label col-sm-4" for="sourceFile">
		<g:message code="report.sourceFile.label" default="Source File" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><input type="file" name="file" />

            <g:hasErrors bean="${reportInstance}" field="sourceFile">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${reportInstance}" field="sourceFile">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: reportInstance, field: 'remarks', 'has-error')} ">
	<label class="control-label col-sm-4" for="remarks">
		<g:message code="report.remarks.label" default="Remarks" />
		
	</label>
	<div class="col-sm-8"><g:textArea name="remarks" value="${reportInstance?.remarks}"class="form-control"/>

            <g:hasErrors bean="${reportInstance}" field="remarks">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${reportInstance}" field="remarks">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div><g:hiddenField name="configItemStatus" value="2" /></div>
<div><g:hiddenField name="sourceFile" value="/web-app" /></div>