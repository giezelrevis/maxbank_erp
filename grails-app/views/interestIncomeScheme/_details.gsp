<%@ page import="icbs.loans.InterestIncomeScheme" %>
<%@ page import="icbs.lov.LoanInstallmentType" %>
<%@ page import="icbs.lov.LoanCalculation" %>
<%@ page import="icbs.lov.LoanAdvancedInterestType" %>
<%@ page import="icbs.lov.ConfigItemStatus" %>
<%@ page import="icbs.admin.Product" %>


<div class="form-group fieldcontain ${hasErrors(bean: interestIncomeSchemeInstance, field: 'code', 'has-error')}">
	<label class="control-label col-sm-4" for="code">
		<g:message code="interestIncomeScheme.code.label" default="Code" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
		<g:textField class="form-control" name="code" maxlength="10" value="${interestIncomeSchemeInstance?.code}"/>
		<g:hasErrors bean="${interestIncomeSchemeInstance}" field="code">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${interestIncomeSchemeInstance}" field="code">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: interestIncomeSchemeInstance, field: 'name', 'has-error')} ">
	<label class="control-label col-sm-4" for="name">
		<g:message code="interestIncomeScheme.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
		<g:textField class="form-control" name="name" maxlength="75" value="${interestIncomeSchemeInstance?.name}"/>
		<g:hasErrors bean="${interestIncomeSchemeInstance}" field="name">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${interestIncomeSchemeInstance}" field="name">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: interestIncomeSchemeInstance, field: 'installmentType', 'has-error')} ">
	<label class="control-label col-sm-4" for="installmentType">
		<g:message code="interestIncomeScheme.installmentType.label" default="Installment Type" />
	</label>
	<div class="col-sm-8">
		<g:select class="form-control" id="installmentType" name="installmentType.id" from="${icbs.lov.LoanInstallmentType.list()}" optionKey="id" optionValue="description" value="${interestIncomeSchemeInstance?.installmentType?.id}"/>
		<g:hasErrors bean="${interestIncomeSchemeInstance}" field="installmentType">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${interestIncomeSchemeInstance}" field="installmentType">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: interestIncomeSchemeInstance, field: 'installmentCalcType', 'has-error')} ">
	<label class="control-label col-sm-4" for="installmentCalcType">
		<g:message code="interestIncomeScheme.installmentCalcType.label" default="Installment Calculation Type" />
	</label>
	<div class="col-sm-8">
		<g:select class="form-control" id="installmentCalcType" name="installmentCalcType.id" from="${icbs.lov.LoanCalculation.list()}" optionKey="id" optionValue="description" value="${interestIncomeSchemeInstance?.installmentCalcType?.id}" onchange="updateForm()"/>
		<g:hasErrors bean="${interestIncomeSchemeInstance}" field="installmentCalcType">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${interestIncomeSchemeInstance}" field="installmentCalcType">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: interestIncomeSchemeInstance, field: 'advInterestType', 'has-error')} ">
	<label class="control-label col-sm-4" for="advInterestType">
		<g:message code="interestIncomeScheme.advInterestType.label" default="Advanced Interest Type" />
	</label>
	<div class="col-sm-8">
		<g:select class="form-control" id="advInterestType" name="advInterestType.id" from="${icbs.lov.LoanAdvancedInterestType.list()}" optionKey="id" optionValue="description" value="${interestIncomeSchemeInstance?.advInterestType?.id}"/>
		<g:hasErrors bean="${interestIncomeSchemeInstance}" field="advInterestType">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${interestIncomeSchemeInstance}" field="advInterestType">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: interestIncomeSchemeInstance, field: 'defaultInterestRate', 'has-error')} ">
	<label class="control-label col-sm-4" for="defaultInterestRate">
		<g:message code="interestIncomeScheme.defaultInterestRate.label" default="Default Interest Rate (%)" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
		<g:field class="form-control" name="defaultInterestRate" value="${fieldValue(bean: interestIncomeSchemeInstance, field: 'defaultInterestRate')}" />
		<g:hasErrors bean="${interestIncomeSchemeInstance}" field="defaultInterestRate">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${interestIncomeSchemeInstance}" field="defaultInterestRate">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: interestIncomeSchemeInstance, field: 'pastDueInterestRate', 'has-error')} ">
	<label class="control-label col-sm-4" for="pastDueInterestRate">
		<g:message code="interestIncomeScheme.pastDueInterestRate.label" default="Past Due Interest Rate (%)" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
		<g:field class="form-control" name="pastDueInterestRate" value="${fieldValue(bean: interestIncomeSchemeInstance, field: 'pastDueInterestRate')}" />
		<g:hasErrors bean="${interestIncomeSchemeInstance}" field="pastDueInterestRate">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${interestIncomeSchemeInstance}" field="pastDueInterestRate">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: interestIncomeSchemeInstance, field: 'minInterestRate', 'has-error')} ">
	<label class="control-label col-sm-4" for="minInterestRate">
		<g:message code="interestIncomeScheme.minInterestRate.label" default="Min Interest Rate (%)" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
		<g:field class="form-control" name="minInterestRate" value="${fieldValue(bean: interestIncomeSchemeInstance, field: 'minInterestRate')}" />
		<g:hasErrors bean="${interestIncomeSchemeInstance}" field="minInterestRate">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${interestIncomeSchemeInstance}" field="minInterestRate">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: interestIncomeSchemeInstance, field: 'maxInterestRate', 'has-error')} ">
	<label class="control-label col-sm-4" for="maxInterestRate">
		<g:message code="interestIncomeScheme.maxInterestRate.label" default="Max Interest Rate (%)" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
		<g:field class="form-control" name="maxInterestRate" value="${fieldValue(bean: interestIncomeSchemeInstance, field: 'maxInterestRate')}" />
		<g:hasErrors bean="${interestIncomeSchemeInstance}" field="maxInterestRate">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${interestIncomeSchemeInstance}" field="maxInterestRate">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: interestIncomeSchemeInstance, field: 'divisor', 'has-error')} ">
	<label class="control-label col-sm-4" for="divisor">
		<g:message code="interestIncomeScheme.divisor.label" default="Divisor" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
		<g:field class="form-control" name="divisor" type="number" value="${interestIncomeSchemeInstance.divisor}" />
		<g:hasErrors bean="${interestIncomeSchemeInstance}" field="divisor">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${interestIncomeSchemeInstance}" field="divisor">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: interestIncomeSchemeInstance, field: 'gracePeriod', 'has-error')} ">
	<label class="control-label col-sm-4" for="gracePeriod">
		<g:message code="interestIncomeScheme.gracePeriod.label" default="Grace Period" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
		<g:field class="form-control" name="gracePeriod" type="number" value="${interestIncomeSchemeInstance.gracePeriod}" />
		<g:hasErrors bean="${interestIncomeSchemeInstance}" field="gracePeriod">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${interestIncomeSchemeInstance}" field="gracePeriod">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: interestIncomeSchemeInstance, field: 'hasBalloonMode', 'has-error')} ">
	<label class="control-label col-sm-4" for="hasBalloonMode">
		<g:message code="interestIncomeScheme.hasBalloonMode.label" default="Balloon Mode" />		
	</label>
	<div class="col-sm-8">
		<g:checkBox class="form-control" name="hasBalloonMode" value="${interestIncomeSchemeInstance?.hasBalloonMode}" />
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: interestIncomeSchemeInstance, field: 'canChangeInterestRate', 'has-error')} ">
	<label class="control-label col-sm-4" for="canChangeInterestRate">
		<g:message code="interestIncomeScheme.canChangeInterestRate.label" default="Changeable Interest Rate" />
	</label>
	<div class="col-sm-8">
		<g:checkBox class="form-control" name="canChangeInterestRate" value="${interestIncomeSchemeInstance?.canChangeInterestRate}" />
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: interestIncomeSchemeInstance, field: 'hasInterestAccrual', 'has-error')} ">
	<label class="control-label col-sm-4" for="hasInterestAccrual">
		<g:message code="interestIncomeScheme.hasInterestAccrual.label" default="Interest Accrual" />
	</label>
	<div class="col-sm-8">
		<g:checkBox class="form-control" name="hasInterestAccrual" value="${interestIncomeSchemeInstance?.hasInterestAccrual}" />
	</div>
</div>

<%--<div class="form-group fieldcontain ${hasErrors(bean: interestIncomeSchemeInstance, field: 'status', 'has-error')} ">
	<label class="control-label col-sm-4" for="status">
		<g:message code="interestIncomeScheme.status.label" default="Status" />
	</label>
	<div class="col-sm-8">
		<g:select class="form-control" id="status" name="status.id" from="${icbs.lov.ConfigItemStatus.list()}" optionKey="id" optionValue="description" value="${interestIncomeSchemeInstance?.status?.id}"/>
		<g:hasErrors bean="${interestIncomeSchemeInstance}" field="status">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${interestIncomeSchemeInstance}" field="status">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>--%>