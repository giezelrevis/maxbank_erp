<%@ page import="icbs.loans.LoanDeductionScheme" %>
<%@ page import="icbs.lov.LoanDeductionCalculationType" %>
<%@ page import="icbs.lov.LoanDeductionSpecialCalculation" %>
<%@ page import="icbs.lov.ConfigItemStatus" %>
<%@ page import="icbs.admin.Product" %>


<div class="form-group fieldcontain ${hasErrors(bean: loanDeductionSchemeInstance, field: 'code', 'has-error')}">
	<label class="control-label col-sm-4" for="code">
		<g:message code="loanDeductionScheme.code.label" default="Code" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
		<g:textField class="form-control" name="code" maxlength="10" value="${loanDeductionSchemeInstance?.code}"/>
		<g:hasErrors bean="${loanDeductionSchemeInstance}" field="code">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanDeductionSchemeInstance}" field="code">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: loanDeductionSchemeInstance, field: 'name', 'has-error')}">
	<label class="control-label col-sm-4" for="name">
		<g:message code="loanDeductionScheme.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
		<g:textField class="form-control" name="name" maxlength="75" value="${loanDeductionSchemeInstance?.name}"/>
		<g:hasErrors bean="${loanDeductionSchemeInstance}" field="name">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanDeductionSchemeInstance}" field="name">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: loanDeductionSchemeInstance, field: 'description', 'has-error')} ">
	<label class="control-label col-sm-4" for="description">
		<g:message code="collateral.description.label" default="Description" />		
	</label>
	<div class="col-sm-8"><g:textArea name="description" value="${loanDeductionSchemeInstance?.description}" rows="3" class="form-control"/>

            <g:hasErrors bean="${loanDeductionSchemeInstance}" field="description">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${loanDeductionSchemeInstance}" field="description">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="form-group fieldcontain ${hasErrors(bean: loanDeductionSchemeInstance, field: 'specialCalculation', 'has-error')} ">
	<label class="control-label col-sm-4" for="specialCalculation">
		<g:message code="loanDeductionScheme.specialCalculation.label" default="Special Calculation" />
	</label>
	<div class="col-sm-8">
		<g:select class="form-control" id="specialCalculation" name="specialCalculation.id" from="${icbs.lov.LoanDeductionSpecialCalculation.list()}" optionKey="id" optionValue="description" value="${loanDeductionSchemeInstance?.specialCalculation?.id}"/>
		<g:hasErrors bean="${loanDeductionSchemeInstance}" field="specialCalculation">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanDeductionSchemeInstance}" field="specialCalculation">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: loanDeductionSchemeInstance, field: 'type', 'has-error')} ">
	<label class="control-label col-sm-4" for="type">
		<g:message code="loanDeductionScheme.type.label" default="Type" />
	</label>
	<div class="col-sm-8">
		<g:select class="form-control" id="type" name="type.id" from="${icbs.lov.LoanDeductionCalculationType.list()}" optionKey="id" optionValue="description" value="${loanDeductionSchemeInstance?.type?.id}" 
			onchange="updateForm()"/>
		<g:hasErrors bean="${loanDeductionSchemeInstance}" field="type">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanDeductionSchemeInstance}" field="type">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div id="amount-form-group" class="form-group fieldcontain ${hasErrors(bean: loanDeductionSchemeInstance, field: 'amount', 'has-error')}">
	<label class="control-label col-sm-4" for="amount">
		<g:message code="loanDeductionScheme.amount.label" default="Amount" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
		<g:field class="form-control" name="amount" value="${fieldValue(bean: loanDeductionSchemeInstance, field: 'amount')}"/>
		<g:hasErrors bean="${loanDeductionSchemeInstance}" field="amount">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanDeductionSchemeInstance}" field="amount">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div id="rate-form-group" class="form-group fieldcontain ${hasErrors(bean: loanDeductionSchemeInstance, field: 'rate', 'has-error')}">
	<label class="control-label col-sm-4" for="rate">
		<g:message code="loanDeductionScheme.rate.label" default="Rate (%)" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
		<g:field class="form-control" name="rate" value="${fieldValue(bean: loanDeductionSchemeInstance, field: 'rate')}"/>
		<g:hasErrors bean="${loanDeductionSchemeInstance}" field="rate">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanDeductionSchemeInstance}" field="rate">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div id="divisor-form-group" class="form-group fieldcontain ${hasErrors(bean: loanDeductionSchemeInstance, field: 'divisor', 'has-error')}">
	<label class="control-label col-sm-4" for="divisor">
		<g:message code="loanDeductionScheme.divisor.label" default="Divisor" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
		<g:field class="form-control" name="divisor" type="number" value="${loanDeductionSchemeInstance.divisor}"/>
		<g:hasErrors bean="${loanDeductionSchemeInstance}" field="divisor">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanDeductionSchemeInstance}" field="divisor">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: loanDeductionSchemeInstance, field: 'hasEirMode', 'has-error')} ">
	<label class="control-label col-sm-4" for="hasEirMode">
		<g:message code="loanDeductionScheme.hasEirMode.label" default="EIR Mode" />
	</label>
	<div class="col-sm-8">
		<g:checkBox class="form-control" name="hasEirMode" value="${loanDeductionSchemeInstance?.hasEirMode}" />
	</div>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: loanDeductionSchemeInstance, field: 'contraAcct', 'has-error')}">
    <label class="control-label col-sm-4" for="contraAcct">
        <g:message code="loanDeductionScheme.contraAcct.label" default="GL Contra Account" />
    </label>
    <div class="col-sm-8"><g:select id="contraAcct" name="contraAcct.id" from="${icbs.gl.GlAccount.findAllByBranch(icbs.admin.Branch.get(1))}" optionKey="id" optionValue="name" value="${loanDeductionSchemeInstance?.contraAcct?.id}" noSelection="['': '']" class="many-to-one form-control"/>

            <g:hasErrors bean="${loanDeductionSchemeInstance}" field="contraAcct">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${loanDeductionSchemeInstance}" field="contraAcct">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>