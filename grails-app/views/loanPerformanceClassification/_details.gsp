
<%@ page import="icbs.lov.LoanPerformanceClassification" %>
<%@ page import="icbs.lov.LoanFreq" %>
<%@ page import="icbs.lov.ConfigItemStatus" %>
<%@ page import="icbs.admin.Product" %>


<div class="form-group fieldcontain ${hasErrors(bean: loanPerformanceClassificationInstance, field: 'code', 'has-error')}">
	<label class="control-label col-sm-4" for="code">
		<g:message code="loanPerformanceClassification.code.label" default="Code" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
		<g:textField class="form-control" name="code" maxlength="10" value="${loanPerformanceClassificationInstance?.code}"/>
		<g:hasErrors bean="${loanPerformanceClassificationInstance}" field="code">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanPerformanceClassificationInstance}" field="code">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: loanPerformanceClassificationInstance, field: 'name', 'has-error')}">
	<label class="control-label col-sm-4" for="name">
		<g:message code="loanPerformanceClassification.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
		<g:textField class="form-control" name="name" maxlength="75" value="${loanPerformanceClassificationInstance?.name}"/>
		<g:hasErrors bean="${loanPerformanceClassificationInstance}" field="name">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanPerformanceClassificationInstance}" field="name">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: loanPerformanceClassificationInstance, field: 'prevClassification', 'has-error')} ">
	<label class="control-label col-sm-4" for="prevClassification">
		<g:message code="loanPerformanceClassification.prevClassification.label" default="Previous Classification" />
	</label>
	<div class="col-sm-8">
		<g:select class="form-control" id="prevClassification" name="prevClassification.id" from="${LoanPerformanceClassification.list()}" optionKey="id" optionValue="description" value="${loanPerformanceClassificationInstance?.prevClassification?.id}"/>
		<g:hasErrors bean="${loanPerformanceClassificationInstance}" field="prevClassification">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanPerformanceClassificationInstance}" field="prevClassification">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: loanPerformanceClassificationInstance, field: 'newClassification', 'has-error')} ">
	<label class="control-label col-sm-4" for="newClassification">
		<g:message code="loanPerformanceClassification.newClassification.label" default="New Classification" />
	</label>
	<div class="col-sm-8">
		<g:select class="form-control" id="newClassification" name="newClassification.id" from="${LoanPerformanceClassification.list()}" optionKey="id" optionValue="description" value="${loanPerformanceClassificationInstance?.newClassification?.id}"/>
		<g:hasErrors bean="${loanPerformanceClassificationInstance}" field="newClassification">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanPerformanceClassificationInstance}" field="newClassification">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: loanPerformanceClassificationInstance, field: 'type', 'has-error')} ">
	<label class="control-label col-sm-4" for="type">
		<g:message code="loanPerformanceClassification.type.label" default="Type" />
	</label>
	<div class="col-sm-8">
		<g:select class="form-control" id="type" name="type.id" from="${icbs.lov.LoanPerformanceClassificationType.list()}" optionKey="id" optionValue="description"  value="${loanPerformanceClassificationInstance?.type?.id}" onchange="updateForm()"/>
		<g:hasErrors bean="${loanPerformanceClassificationInstance}" field="type">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanPerformanceClassificationInstance}" field="type">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div id="amount-form-group">
<div class="form-group fieldcontain ${hasErrors(bean: loanPerformanceClassificationInstance, field: 'thresholdAmount', 'has-error')}">
	<label class="control-label col-sm-4" for="thresholdAmount">
		<g:message code="loanPerformanceClassification.thresholdAmount.label" default="Threshold Amount" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
		<g:field class="form-control" name="thresholdAmount" value="${fieldValue(bean: loanPerformanceClassificationInstance, field: 'thresholdAmount')}"/>
		<g:hasErrors bean="${loanPerformanceClassificationInstance}" field="thresholdAmount">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanPerformanceClassificationInstance}" field="thresholdAmount">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>
</div>

<div id="frequency-form-group">
<div class="form-group fieldcontain ${hasErrors(bean: loanPerformanceClassificationInstance, field: 'thresholdFreq', 'has-error')}">
    <label class="control-label col-sm-4" for="thresholdFreq">
        <g:message code="loanPerformanceClassification.thresholdFreq.label" default="Threshold Frequency" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
        <g:field class="form-control" name="thresholdFreq" type="number" value="${loanPerformanceClassificationInstance?.thresholdFreq}"/>
        <g:hasErrors bean="${loanPerformanceClassificationInstance}" field="thresholdFreq">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanPerformanceClassificationInstance}" field="thresholdFreq">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>
</div>
</div>