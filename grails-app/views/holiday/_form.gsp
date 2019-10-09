<%@ page import="icbs.admin.Holiday" %>




<div class="fieldcontain form-group ${hasErrors(bean: holidayInstance, field: 'code', 'has-error')} required">
	<label class="control-label col-sm-4" for="code">
		<g:message code="holiday.code.label" default="Code" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="code" maxlength="10" required="" value="${holidayInstance?.code}"class="form-control"/>

            <g:hasErrors bean="${holidayInstance}" field="code">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${holidayInstance}" field="code">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: holidayInstance, field: 'description', 'has-error')} required">
	<label class="control-label col-sm-4" for="description">
		<g:message code="holiday.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="description" maxlength="100" required="" value="${holidayInstance?.description}"class="form-control"/>

            <g:hasErrors bean="${holidayInstance}" field="description">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${holidayInstance}" field="description">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: holidayInstance, field: 'holidayDate', 'has-error')} ">
	<label class="control-label col-sm-4" for="holidayDate">
		<g:message code="holidayInstance.holidayDate.label" default="Holiday Date" />
                <span class="required-indicator">*</span>

	</label>
	<div class="col-sm-8"><g:customDatePicker name="holidayDate" precision="day" class="form-control"  value="${holidayInstance?.holidayDate}" default="none" noSelection="['': '']" />

            <g:hasErrors bean="${holidayInstance}" field="holidayDate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${holidayInstance}" field="holidayDate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<!--
<div class="fieldcontain form-group ${hasErrors(bean: holidayInstance, field: 'month', 'has-error')} required">
	<label class="control-label col-sm-4" for="month">
		<g:message code="holiday.month.label" default="Date" />
		<span class="required-indicator">*</span>
	</label>
	
    <div class="col-sm-8"><g:select id="month" name="month.id" required="" from="${icbs.lov.Month.list()}" optionKey="id" optionValue="description" value="${holidayInstance?.month?.id}" noSelection="['null': '']" style="width:150px; clear:both; margin-right:5px; " /><g:select id="day" name="day" required="" from="${1..31}" value="${holidayInstance?.day}" noSelection="['null': '']" style="width:70px;"/>

            <g:hasErrors bean="${holidayInstance}" field="month">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${holidayInstance}" field="month">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
-->

<div class="fieldcontain form-group ${hasErrors(bean: holidayInstance, field: 'type', 'has-error')} required">
	<label class="control-label col-sm-4" for="type">
		<g:message code="holiday.type.label" default="Type" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">

<g:radioGroup name="type"
                  values="${icbs.admin.Holiday$Type?.values()}"
                  labels="${icbs.admin.Holiday$Type.values()*.name()}"
                  value="${holidayInstance?.type?.name()}">
  ${it.radio} <g:message code="${it.label}" />&nbsp;
</g:radioGroup>

            <g:hasErrors bean="${holidayInstance}" field="type">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${holidayInstance}" field="type">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: holidayInstance, field: 'institutionWideHoliday', 'has-error')} ">
	<label class="control-label col-sm-4" for="institutionWideHoliday">
		<g:message code="holidayInstance.institutionWideHoliday.label" default="Bankwide Holiday" />
		
	</label>
        <div class="col-sm-8"><g:checkBox name="institutionWideHoliday" class="form-control" value="${holidayInstance?.institutionWideHoliday}" />
            <g:hasErrors bean="${holidayInstance}" field="institutionWideHoliday">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${holidayInstance}" field="institutionWideHoliday">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<div><g:hiddenField name="configItemStatus" value="2" /></div>