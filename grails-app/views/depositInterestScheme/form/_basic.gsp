<%@ page import="icbs.deposit.DepositInterestScheme" %>
<div class="fieldcontain form-group ${hasErrors(bean: depositInterestSchemeInstance, field: 'code', 'has-error')} required">
	<label class="control-label col-sm-4" for="code">
		<g:message code="depositInterestScheme.code.label" default="Code" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="code" maxlength="10" value="${depositInterestSchemeInstance?.code}"class="form-control"/>

            <g:hasErrors bean="${depositInterestSchemeInstance}" field="code">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${depositInterestSchemeInstance}" field="code">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: depositInterestSchemeInstance, field: 'name', 'has-error')} required">
	<label class="control-label col-sm-4" for="name">
		<g:message code="depositInterestScheme.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="name" maxlength="50" value="${depositInterestSchemeInstance?.name}"class="form-control"/>

            <g:hasErrors bean="${depositInterestSchemeInstance}" field="name">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${depositInterestSchemeInstance}" field="name">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<div class="fieldcontain form-group ${hasErrors(bean: depositInterestSchemeInstance, field: 'depositInterestStart', 'has-error')} required">
	<label class="control-label col-sm-4" for="depositInterestStart">
		<g:message code="depositInterestScheme.depositInterestStart.label" default="Deposit Interest Start" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="depositInterestStart" name="depositInterestStart.id" from="${icbs.lov.DepositInterestStart.list()}" optionKey="id"optionValue="description" required="" value="${depositInterestSchemeInstance?.depositInterestStart?.id}" class="many-to-one form-control"/>

            <g:hasErrors bean="${depositInterestSchemeInstance}" field="depositInterestStart">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${depositInterestSchemeInstance}" field="depositInterestStart">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: depositInterestSchemeInstance, field: 'interestRate', 'has-error')} required">
	<label class="control-label col-sm-4" for="interestRate">
		<g:message code="depositInterestScheme.interestRate.label" default="Interest Rate" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="interestRate" value="${fieldValue(bean: depositInterestSchemeInstance, field: 'interestRate')}"  class="form-control"/>

            <g:hasErrors bean="${depositInterestSchemeInstance}" field="interestRate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${depositInterestSchemeInstance}" field="interestRate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: depositInterestSchemeInstance, field: 'divisor', 'has-error')} required">
	<label class="control-label col-sm-4" for="divisor">
		<g:message code="depositInterestScheme.divisor.label" default="Divisor" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="divisor"  value="${depositInterestSchemeInstance.divisor}" class="form-control"/>

            <g:hasErrors bean="${depositInterestSchemeInstance}" field="divisor">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${depositInterestSchemeInstance}" field="divisor">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: depositInterestSchemeInstance, field: 'minInterestRate', 'has-error')} required">
	<label class="control-label col-sm-4" for="minInterestRate">
		<g:message code="depositInterestScheme.minInterestRate.label" default="Min Interest Rate" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="minInterestRate" value="${fieldValue(bean: depositInterestSchemeInstance, field: 'minInterestRate')}"  class="form-control"/>

            <g:hasErrors bean="${depositInterestSchemeInstance}" field="minInterestRate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${depositInterestSchemeInstance}" field="minInterestRate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: depositInterestSchemeInstance, field: 'maxInterestRate', 'has-error')} required">
	<label class="control-label col-sm-4" for="maxInterestRate">
		<g:message code="depositInterestScheme.maxInterestRate.label" default="Max Interest Rate" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="maxInterestRate" value="${fieldValue(bean: depositInterestSchemeInstance, field: 'maxInterestRate')}"  class="form-control"/>

            <g:hasErrors bean="${depositInterestSchemeInstance}" field="maxInterestRate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${depositInterestSchemeInstance}" field="maxInterestRate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: depositInterestSchemeInstance, field: 'fdPostMaturityRate', 'has-error')} required">
	<label class="control-label col-sm-4" for="interestRate">
		<g:message code="depositInterestScheme.fdPostMaturityRate.label" default="FD Post Maturity Interest Rate" />
	</label>
	<div class="col-sm-8"><g:field name="fdPostMaturityRate" value="${fieldValue(bean: depositInterestSchemeInstance, field: 'fdPostMaturityRate')}"  class="form-control"/>

            <g:hasErrors bean="${depositInterestSchemeInstance}" field="fdPostMaturityRate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${depositInterestSchemeInstance}" field="fdPostMaturityRate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: depositInterestSchemeInstance, field: 'fdMonthlyTransfer', 'has-error')} ">
	<label class="control-label col-sm-4" for="fdMonthlyTransfer">
		<g:message code="depositInterestScheme.fdMonthlyTransfer.label" default="FD Monthly Transfer" />
		
	</label>
	<div class="col-sm-8"><g:checkBox name="fdMonthlyTransfer" class="" value="${depositInterestSchemeInstance?.fdMonthlyTransfer}" />

            <g:hasErrors bean="${depositInterestSchemeInstance}" field="fdMonthlyTransfer">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${depositInterestSchemeInstance}" field="fdMonthlyTransfer">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: depositInterestSchemeInstance, field: 'minBalanceToEarnInterest', 'has-error')} required">
	<label class="control-label col-sm-4" for="minBalanceToEarnInterest">
		<g:message code="depositInterestScheme.minBalanceToEarnInterest.label" default="Min Balance To Earn Interest" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="minBalanceToEarnInterest" value="${fieldValue(bean: depositInterestSchemeInstance, field: 'minBalanceToEarnInterest')}" class="form-control"/>

            <g:hasErrors bean="${depositInterestSchemeInstance}" field="minBalanceToEarnInterest">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${depositInterestSchemeInstance}" field="minBalanceToEarnInterest">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: depositInterestSchemeInstance, field: 'canChangeInterestRate', 'has-error')} ">
	<label class="control-label col-sm-4" for="canChangeInterestRate">
		<g:message code="depositInterestScheme.canChangeInterestRate.label" default="Can Change Interest Rate" />
		
	</label>
	<div class="col-sm-8"><g:checkBox name="canChangeInterestRate" class="" value="${depositInterestSchemeInstance?.canChangeInterestRate}" />

            <g:hasErrors bean="${depositInterestSchemeInstance}" field="canChangeInterestRate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${depositInterestSchemeInstance}" field="canChangeInterestRate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: depositInterestSchemeInstance, field: 'isAccrual', 'has-error')} ">
	<label class="control-label col-sm-4" for="isAccrual">
		<g:message code="depositInterestScheme.isAccrual.label" default="Is Accrual" />
		
	</label>
	<div class="col-sm-8"><g:checkBox name="isAccrual" class="" value="${depositInterestSchemeInstance?.isAccrual}" />

            <g:hasErrors bean="${depositInterestSchemeInstance}" field="isAccrual">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${depositInterestSchemeInstance}" field="isAccrual">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<div class="fieldcontain form-group ${hasErrors(bean: depositInterestSchemeInstance, field: 'interestOnClosing', 'has-error')} ">
	<label class="control-label col-sm-4" for="interestOnClosing">
		<g:message code="depositInterestScheme.interestOnClosing.label" default="Payout interest on closing" />
		
	</label>
	<div class="col-sm-8"><g:checkBox name="interestOnClosing" class="" value="${depositInterestSchemeInstance?.interestOnClosing}" />

            <g:hasErrors bean="${depositInterestSchemeInstance}" field="interestOnClosing">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${depositInterestSchemeInstance}" field="interestOnClosing">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: depositInterestSchemeInstance, field: 'isGraduated', 'has-error')} ">
	<label class="control-label col-sm-4" for="isGraduated">
		<g:message code="depositInterestScheme.isGraduated.label" default="Is Graduated" />
		
	</label>
	<div class="col-sm-8">
            <g:if test="${depositInterestSchemeInstance?.id}">
                <g:hiddenField id="isGraduated" name="isGraduated" class="form-control" value="${depositInterestSchemeInstance?.isGraduated}" />
                <g:checkBox id="isGraduated" name="isGraduated" disabled class="" value="${depositInterestSchemeInstance?.isGraduated}" />
            </g:if>
            <g:else>
                <g:checkBox id="isGraduated" name="isGraduated" onchange="isGraduatedChecked()"class="" value="${depositInterestSchemeInstance?.isGraduated}" />
            </g:else>
            <g:hasErrors bean="${depositInterestSchemeInstance}" field="isGraduated">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${depositInterestSchemeInstance}" field="isGraduated">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<div class="fieldcontain form-group ${hasErrors(bean: depositInterestSchemeInstance, field: 'depositCapitalizationFreq', 'has-error')} required">
	<label class="control-label col-sm-4" for="depositCapitalizationFreq">
		<g:message code="depositInterestScheme.depositCapitalizationFreq.label" default="Deposit Capitalization Freq" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="depositCapitalizationFreq" name="depositCapitalizationFreq.id" from="${icbs.lov.DepositCapitalizationFreq.list()}" optionKey="id"optionValue="description" required="" value="${depositInterestSchemeInstance?.depositCapitalizationFreq?.id}" class="many-to-one form-control"/>

            <g:hasErrors bean="${depositInterestSchemeInstance}" field="depositCapitalizationFreq">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${depositInterestSchemeInstance}" field="depositCapitalizationFreq">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: depositInterestSchemeInstance, field: 'depositInterestCalculation', 'has-error')} required">
	<label class="control-label col-sm-4" for="depositInterestCalculation">
		<g:message code="depositInterestScheme.depositInterestCalculation.label" default="Deposit Interest Calculation" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="depositInterestCalculation" name="depositInterestCalculation.id" from="${icbs.lov.DepositInterestCalculation.list()}" optionKey="id"optionValue="description" required="" value="${depositInterestSchemeInstance?.depositInterestCalculation?.id}" class="many-to-one form-control"/>

            <g:hasErrors bean="${depositInterestSchemeInstance}" field="depositInterestCalculation">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${depositInterestSchemeInstance}" field="depositInterestCalculation">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<g:if test="${depositInterestSchemeInstance?.id}">
    <div class="fieldcontain form-group ${hasErrors(bean: depositInterestSchemeInstance, field: 'status', 'has-error')} ">
            <label class="control-label col-sm-4" for="status">
                    <g:message code="depositInterestScheme.status.label" default="Status" />

            </label>
            <div class="col-sm-8"><g:select id="status" name="status.id" from="${icbs.lov.ConfigItemStatus.list()}" optionKey="id" optionValue="description" value="${depositInterestSchemeInstance?.status?.id}" class="many-to-one form-control" noSelection="['null': '']"/>

                <g:hasErrors bean="${depositInterestSchemeInstance}" field="status">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${depositInterestSchemeInstance}" field="status">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>
</g:if>