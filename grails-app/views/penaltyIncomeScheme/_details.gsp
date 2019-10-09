<%@ page import="icbs.loans.PenaltyIncomeScheme" %>
<%@ page import="icbs.lov.ConfigItemStatus" %>
<%@ page import="icbs.admin.Product" %>


<div class="form-group fieldcontain ${hasErrors(bean: penaltyIncomeSchemeInstance, field: 'code', 'has-error')}">
	<label class="control-label col-sm-4" for="code">
		<g:message code="penaltyIncomeScheme.code.label" default="Code" />		
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
		<g:textField class="form-control" name="code" maxlength="10" value="${penaltyIncomeSchemeInstance?.code}"/>
		<g:hasErrors bean="${penaltyIncomeSchemeInstance}" field="code">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${penaltyIncomeSchemeInstance}" field="code">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: penaltyIncomeSchemeInstance, field: 'name', 'has-error')}">
	<label class="control-label col-sm-4" for="name">
		<g:message code="penaltyIncomeScheme.name.label" default="Name" />	
		<span class="required-indicator">*</span>	
	</label>
	<div class="col-sm-8">
		<g:textField class="form-control" name="name" maxlength="75" value="${penaltyIncomeSchemeInstance?.name}"/>
		<g:hasErrors bean="${penaltyIncomeSchemeInstance}" field="name">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${penaltyIncomeSchemeInstance}" field="name">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: penaltyIncomeSchemeInstance, field: 'basis', 'has-error')} ">
	<label class="control-label col-sm-4" for="basis">
		<g:message code="penaltyIncomeScheme.basis.label" default="Basis" />		
	</label>
	<div class="col-sm-8">
		<g:select class="form-control" id="basis" name="basis.id" from="${icbs.lov.LoanPenaltyBasis.list()}" optionKey="id" optionValue="description" value="${penaltyIncomeSchemeInstance?.basis?.id}"/>
		<g:hasErrors bean="${penaltyIncomeSchemeInstance}" field="basis">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${penaltyIncomeSchemeInstance}" field="basis">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: penaltyIncomeSchemeInstance, field: 'type', 'has-error')} ">
	<label class="control-label col-sm-4" for="type">
		<g:message code="penaltyIncomeScheme.type.label" default="Type" />		
	</label>
	<div class="col-sm-8">
		<g:select class="form-control" id="type" name="type.id" from="${icbs.lov.LoanPenaltyType.list()}" optionKey="id" optionValue="description" value="${penaltyIncomeSchemeInstance?.type?.id}" onchange="updateForm()"/>
		<g:hasErrors bean="${penaltyIncomeSchemeInstance}" field="type">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${penaltyIncomeSchemeInstance}" field="type">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div id="amount-form-group">
<div class="form-group fieldcontain ${hasErrors(bean: penaltyIncomeSchemeInstance, field: 'frequency', 'has-error')} ">
	<label class="control-label col-sm-4" for="frequency">
		<g:message code="penaltyIncomeScheme.frequency.label" default="Frequency" />
	</label>
	<div class="col-sm-8">
		<g:select class="form-control" id="frequency" name="frequency.id" from="${icbs.lov.LoanPenaltyFreq.list()}" optionKey="id" optionValue="description" value="${penaltyIncomeSchemeInstance?.frequency?.id}"/>
		<g:hasErrors bean="${penaltyIncomeSchemeInstance}" field="frequency">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${penaltyIncomeSchemeInstance}" field="frequency">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: penaltyIncomeSchemeInstance, field: 'defaultPenaltyAmount', 'has-error')}">
	<label class="control-label col-sm-4" for="defaultPenaltyAmount">
		<g:message code="penaltyIncomeScheme.defaultPenaltyAmount.label" default="Default Penalty Amount" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
		<g:field class="form-control" name="defaultPenaltyAmount" value="${fieldValue(bean: penaltyIncomeSchemeInstance, field: 'defaultPenaltyAmount')}"/>
		<g:hasErrors bean="${penaltyIncomeSchemeInstance}" field="defaultPenaltyAmount">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${penaltyIncomeSchemeInstance}" field="defaultPenaltyAmount">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: penaltyIncomeSchemeInstance, field: 'minPenaltyAmount', 'has-error')}">
	<label class="control-label col-sm-4" for="minPenaltyAmount">
		<g:message code="penaltyIncomeScheme.minPenaltyAmount.label" default="Min Penalty Amount" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
		<g:field class="form-control" name="minPenaltyAmount" value="${fieldValue(bean: penaltyIncomeSchemeInstance, field: 'minPenaltyAmount')}"/>
		<g:hasErrors bean="${penaltyIncomeSchemeInstance}" field="minPenaltyAmount">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${penaltyIncomeSchemeInstance}" field="minPenaltyAmount">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: penaltyIncomeSchemeInstance, field: 'maxPenaltyAmount', 'has-error')}">
	<label class="control-label col-sm-4" for="maxPenaltyAmount">
		<g:message code="penaltyIncomeScheme.maxPenaltyAmount.label" default="Max Penalty Amount" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
		<g:field class="form-control" name="maxPenaltyAmount" value="${fieldValue(bean: penaltyIncomeSchemeInstance, field: 'maxPenaltyAmount')}"/>
		<g:hasErrors bean="${penaltyIncomeSchemeInstance}" field="maxPenaltyAmount">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${penaltyIncomeSchemeInstance}" field="maxPenaltyAmount">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>
</div>

<div id="rate-form-group">
<div class="form-group fieldcontain ${hasErrors(bean: penaltyIncomeSchemeInstance, field: 'defaultPenaltyRate', 'has-error')}">
	<label class="control-label col-sm-4" for="defaultPenaltyRate">
		<g:message code="penaltyIncomeScheme.defaultPenaltyRate.label" default="Default Penalty Rate (%)" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
		<g:field class="form-control" name="defaultPenaltyRate" value="${fieldValue(bean: penaltyIncomeSchemeInstance, field: 'defaultPenaltyRate')}"/>
		<g:hasErrors bean="${penaltyIncomeSchemeInstance}" field="defaultPenaltyRate">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${penaltyIncomeSchemeInstance}" field="defaultPenaltyRate">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: penaltyIncomeSchemeInstance, field: 'minPenaltyRate', 'has-error')}">
	<label class="control-label col-sm-4" for="minPenaltyRate">
		<g:message code="penaltyIncomeScheme.minPenaltyRate.label" default="Min Penalty Rate (%)" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
		<g:field class="form-control" name="minPenaltyRate" value="${fieldValue(bean: penaltyIncomeSchemeInstance, field: 'minPenaltyRate')}" requmaxiremaxd=""/>
		<g:hasErrors bean="${penaltyIncomeSchemeInstance}" field="minPenaltyRate">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${penaltyIncomeSchemeInstance}" field="minPenaltyRate">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: penaltyIncomeSchemeInstance, field: 'maxPenaltyRate', 'has-error')}">
	<label class="control-label col-sm-4" for="maxPenaltyRate">
		<g:message code="penaltyIncomeScheme.maxPenaltyRate.label" default="Max Penalty Rate (%)" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
		<g:field class="form-control" name="maxPenaltyRate" value="${fieldValue(bean: penaltyIncomeSchemeInstance, field: 'maxPenaltyRate')}"/>
		<g:hasErrors bean="${penaltyIncomeSchemeInstance}" field="maxPenaltyRate">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${penaltyIncomeSchemeInstance}" field="maxPenaltyRate">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: penaltyIncomeSchemeInstance, field: 'divisor', 'has-error')}">
	<label class="control-label col-sm-4" for="divisor">
		<g:message code="penaltyIncomeScheme.divisor.label" default="Divisor" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
		<g:field class="form-control" name="divisor" type="number" value="${penaltyIncomeSchemeInstance.divisor}"/>
		<g:hasErrors bean="${penaltyIncomeSchemeInstance}" field="divisor">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${penaltyIncomeSchemeInstance}" field="divisor">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>				
</div>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: penaltyIncomeSchemeInstance, field: 'gracePeriod', 'has-error')}">
	<label class="control-label col-sm-4" for="gracePeriod">
		<g:message code="penaltyIncomeScheme.gracePeriod.label" default="Grace Period" />
	</label>
	<div class="col-sm-8">
		<g:field class="form-control" name="gracePeriod" type="number" value="${penaltyIncomeSchemeInstance.gracePeriod}"/>
		<g:hasErrors bean="${penaltyIncomeSchemeInstance}" field="gracePeriod">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${penaltyIncomeSchemeInstance}" field="gracePeriod">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>		
</div>

<div class="form-group fieldcontain ${hasErrors(bean: penaltyIncomeSchemeInstance, field: 'canChangePenaltyRate', 'has-error')} ">
	<label class="control-label col-sm-4" for="canChangePenaltyRate">
		<g:message code="penaltyIncomeScheme.canChangePenaltyRate.label" default="Changeable Penalty Rate" />	
	</label>
	<div class="col-sm-8">
		<g:checkBox class="form-control" name="canChangePenaltyRate" value="${penaltyIncomeSchemeInstance?.canChangePenaltyRate}" />
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: penaltyIncomeSchemeInstance, field: 'hasWeekendMode', 'has-error')} ">
	<label class="control-label col-sm-4" for="hasWeekendMode">
		<g:message code="penaltyIncomeScheme.hasWeekendMode.label" default="Weekend Mode" />		
	</label>
	<div class="col-sm-8">
		<g:checkBox class="form-control" name="hasWeekendMode" value="${penaltyIncomeSchemeInstance?.hasWeekendMode}" />
	</div>
</div>


