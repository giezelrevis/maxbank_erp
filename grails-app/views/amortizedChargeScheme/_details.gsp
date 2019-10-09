<%@ page import="icbs.loans.AmortizedChargeScheme" %>
<%@ page import="icbs.lov.LoanServiceChargeType" %>
<%@ page import="icbs.lov.LoanServiceChargeBasis" %>
<%@ page import="icbs.lov.LoanInstallmentFreq" %>
<%@ page import="icbs.lov.ConfigItemStatus" %>
<%@ page import="icbs.admin.Product" %>


<div class="form-group fieldcontain ${hasErrors(bean: amortizedChargeSchemeInstance, field: 'code', 'has-error')}">
	<label class="control-label col-sm-4" for="code">
		<g:message code="amortizedChargeScheme.code.label" default="Code" />
		<span class="required-indicator">*</span>	
	</label>
	<div class="col-sm-8">
		<g:textField class="form-control" name="code" maxlength="10" value="${amortizedChargeSchemeInstance?.code}"/>
		<g:hasErrors bean="${amortizedChargeSchemeInstance}" field="code">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${amortizedChargeSchemeInstance}" field="code">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: amortizedChargeSchemeInstance, field: 'name', 'has-error')}">
	<label class="control-label col-sm-4" for="name">
		<g:message code="amortizedChargeScheme.name.label" default="Name" />	
		<span class="required-indicator">*</span>		
	</label>
	<div class="col-sm-8">
		<g:textField class="form-control" name="name" maxlength="75" value="${amortizedChargeSchemeInstance?.name}"/>
		<g:hasErrors bean="${amortizedChargeSchemeInstance}" field="name">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${amortizedChargeSchemeInstance}" field="name">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: amortizedChargeSchemeInstance, field: 'basis', 'has-error')} ">
	<label class="control-label col-sm-4" for="basis">
		<g:message code="amortizedChargeScheme.basis.label" default="Basis" />
	</label>
	<div class="col-sm-8">
		<g:select class="form-control" id="basis" name="basis.id" from="${icbs.lov.LoanServiceChargeBasis.list()}" optionKey="id" optionValue="description" value="${amortizedChargeSchemeInstance?.basis?.id}"/>
		<g:hasErrors bean="${amortizedChargeSchemeInstance}" field="basis">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${amortizedChargeSchemeInstance}" field="basis">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<%--<div class="form-group fieldcontain ${hasErrors(bean: amortizedChargeSchemeInstance, field: 'frequency', 'has-error')} ">
	<label class="control-label col-sm-4" for="frequency">
		<g:message code="amortizedChargeScheme.frequency.label" default="Frequency" />
	</label>
	<div class="col-sm-8">
		<g:select class="form-control" id="frequency" name="frequency.id" from="${icbs.lov.LoanInstallmentFreq.list()}" optionKey="id" optionValue="description" value="${amortizedChargeSchemeInstance?.frequency?.id}"/>
		<g:hasErrors bean="${amortizedChargeSchemeInstance}" field="frequency">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${amortizedChargeSchemeInstance}" field="frequency">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>--%>

<div class="form-group fieldcontain ${hasErrors(bean: amortizedChargeSchemeInstance, field: 'type', 'has-error')} ">
	<label class="control-label col-sm-4" for="type">
		<g:message code="amortizedChargeScheme.type.label" default="Type" />
	</label>
	<div class="col-sm-8">
		<g:select class="form-control" id="type" name="type.id" from="${icbs.lov.LoanServiceChargeType.list()}" optionKey="id" optionValue="description" value="${amortizedChargeSchemeInstance?.type?.id}" onchange="updateForm()"/>
		<g:hasErrors bean="${amortizedChargeSchemeInstance}" field="type">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${amortizedChargeSchemeInstance}" field="type">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div id="amount-form-group" class="form-group fieldcontain ${hasErrors(bean: amortizedChargeSchemeInstance, field: 'amount', 'has-error')}">
	<label class="control-label col-sm-4" for="amount">
		<g:message code="amortizedChargeScheme.amount.label" default="Service Charge Amount" />	
		<span class="required-indicator">*</span>	
	</label>
	<div class="col-sm-8">
		<g:field class="form-control" name="amount" value="${fieldValue(bean: amortizedChargeSchemeInstance, field: 'amount')}"/>
		<g:hasErrors bean="${amortizedChargeSchemeInstance}" field="amount">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${amortizedChargeSchemeInstance}" field="amount">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div id="rate-form-group" class="form-group fieldcontain ${hasErrors(bean: amortizedChargeSchemeInstance, field: 'rate', 'has-error')}">
	<label class="control-label col-sm-4" for="rate">
		<g:message code="amortizedChargeScheme.rate.label" default="Service Charge Rate (%)" />
		<span class="required-indicator">*</span>	
	</label>
	<div class="col-sm-8">
		<g:field class="form-control" name="rate" value="${fieldValue(bean: amortizedChargeSchemeInstance, field: 'rate')}"/>
		<g:hasErrors bean="${amortizedChargeSchemeInstance}" field="rate">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${amortizedChargeSchemeInstance}" field="rate">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: amortizedChargeSchemeInstance, field: 'hasEirMode', 'has-error')} ">
	<label class="control-label col-sm-4" for="hasEirMode">
		<g:message code="amortizedChargeScheme.hasEirMode.label" default="EIR Mode" />		
	</label>
	<div class="col-sm-8">
		<g:checkBox class="form-control" name="hasEirMode" value="${amortizedChargeSchemeInstance?.hasEirMode}" />
	</div>
</div>
