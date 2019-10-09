<%@ page import="icbs.deposit.DepositTaxFeeAndChargeScheme" %>




<div class="fieldcontain form-group ${hasErrors(bean: depositTaxFeeAndChargeSchemeInstance, field: 'code', 'has-error')} required">
	<label class="control-label col-sm-4" for="code">
		<g:message code="depositTaxFeeAndChargeScheme.code.label" default="Code" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="code" maxlength="10" required="" value="${depositTaxFeeAndChargeSchemeInstance?.code}"class="form-control"/>

            <g:hasErrors bean="${depositTaxFeeAndChargeSchemeInstance}" field="code">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${depositTaxFeeAndChargeSchemeInstance}" field="code">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<div class="fieldcontain form-group ${hasErrors(bean: depositTaxFeeAndChargeSchemeInstance, field: 'description', 'has-error')} required">
	<label class="control-label col-sm-4" for="description">
		<g:message code="depositTaxFeeAndChargeScheme.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="description" required="" value="${depositTaxFeeAndChargeSchemeInstance?.description}"class="form-control"/>

            <g:hasErrors bean="${depositTaxFeeAndChargeSchemeInstance}" field="description">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${depositTaxFeeAndChargeSchemeInstance}" field="description">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: depositTaxFeeAndChargeSchemeInstance, field: 'name', 'has-error')} required">
	<label class="control-label col-sm-4" for="name">
		<g:message code="depositTaxFeeAndChargeScheme.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="name" maxlength="50" value="${depositTaxFeeAndChargeSchemeInstance?.name}"class="form-control"/>

            <g:hasErrors bean="${depositTaxFeeAndChargeSchemeInstance}" field="name">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${depositTaxFeeAndChargeSchemeInstance}" field="name">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: depositTaxFeeAndChargeSchemeInstance, field: 'type', 'has-error')} required">
	<label class="control-label col-sm-4" for="type">
		<g:message code="depositTaxFeeAndChargeScheme.type.label" default="Type" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="type" name="type.id" from="${icbs.lov.TaxFeeCharge.list()}" onchange="updateForm()"optionKey="id" required=""optionValue="description" value="${depositTaxFeeAndChargeSchemeInstance?.type?.id}" class="many-to-one form-control"/>

            <g:hasErrors bean="${depositTaxFeeAndChargeSchemeInstance}" field="type">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${depositTaxFeeAndChargeSchemeInstance}" field="type">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div id="tax-rate-form-group">
    <div class="fieldcontain form-group ${hasErrors(bean: depositTaxFeeAndChargeSchemeInstance, field: 'taxRate', 'has-error')} ">
            <label class="control-label col-sm-4" for="taxRate">
                    <g:message code="depositTaxFeeAndChargeScheme.taxRate.label" default="Tax Rate" />

            </label>
            <div class="col-sm-8"><g:field name="taxRate" value="${fieldValue(bean: depositTaxFeeAndChargeSchemeInstance, field: 'taxRate')}" class="form-control"/>

                <g:hasErrors bean="${depositTaxFeeAndChargeSchemeInstance}" field="taxRate">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${depositTaxFeeAndChargeSchemeInstance}" field="taxRate">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>
</div>
<div id="fee-rate-form-group">
    <div class="fieldcontain form-group ${hasErrors(bean: depositTaxFeeAndChargeSchemeInstance, field: 'feeRate', 'has-error')} ">
            <label class="control-label col-sm-4" for="feeRate">
                    <g:message code="depositTaxFeeAndChargeScheme.feeRate.label" default="Fee Rate" />

            </label>
            <div class="col-sm-8"><g:field name="feeRate" value="${fieldValue(bean: depositTaxFeeAndChargeSchemeInstance, field: 'feeRate')}" class="form-control"/>

                <g:hasErrors bean="${depositTaxFeeAndChargeSchemeInstance}" field="feeRate">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${depositTaxFeeAndChargeSchemeInstance}" field="feeRate">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>
    <div class="fieldcontain form-group ${hasErrors(bean: depositTaxFeeAndChargeSchemeInstance, field: 'feeRateBasis', 'has-error')} required">
	<label class="control-label col-sm-4" for="feeRateBasis">
		<g:message code="depositTaxFeeAndChargeScheme.feeRateBasis.label" default="Fee Rate Basis" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="feeRateBasis" value="${fieldValue(bean: depositTaxFeeAndChargeSchemeInstance, field: 'feeRateBasis')}" required="" class="form-control"/>

            <g:hasErrors bean="${depositTaxFeeAndChargeSchemeInstance}" field="feeRateBasis">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${depositTaxFeeAndChargeSchemeInstance}" field="feeRateBasis">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
    </div>
</div>
<div id="fee-amount-form-group">
    <div class="fieldcontain form-group ${hasErrors(bean: depositTaxFeeAndChargeSchemeInstance, field: 'feeAmt', 'has-error')} ">
            <label class="control-label col-sm-4" for="feeAmt">
                    <g:message code="depositTaxFeeAndChargeScheme.feeAmt.label" default="Fee Amount" />

            </label>
            <div class="col-sm-8"><g:field name="feeAmt" value="${fieldValue(bean: depositTaxFeeAndChargeSchemeInstance, field: 'feeAmt')}" class="form-control"/>

                <g:hasErrors bean="${depositTaxFeeAndChargeSchemeInstance}" field="feeAmt">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${depositTaxFeeAndChargeSchemeInstance}" field="feeAmt">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>
    <div class="fieldcontain form-group ${hasErrors(bean: depositTaxFeeAndChargeSchemeInstance, field: 'feeBaseAmtCondition', 'has-error')} ">
	<label class="control-label col-sm-4" for="feeBaseAmtCondition">
		<g:message code="depositTaxFeeAndChargeScheme.feeBaseAmtCondition.label" default="Fee Base Amount Condition" />
		
	</label>
	<div class="col-sm-8"><g:checkBox name="feeBaseAmtCondition" value="${depositTaxFeeAndChargeSchemeInstance?.feeBaseAmtCondition}" />

            <g:hasErrors bean="${depositTaxFeeAndChargeSchemeInstance}" field="feeBaseAmtCondition">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${depositTaxFeeAndChargeSchemeInstance}" field="feeBaseAmtCondition">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
    </div>
</div>
<div id="charge-rate-form-group">
    <div class="fieldcontain form-group ${hasErrors(bean: depositTaxFeeAndChargeSchemeInstance, field: 'chargeRate', 'has-error')} ">
            <label class="control-label col-sm-4" for="chargeRate">
                    <g:message code="depositTaxFeeAndChargeScheme.chargeRate.label" default="Charge Rate" />

            </label>
            <div class="col-sm-8"><g:field name="chargeRate" value="${fieldValue(bean: depositTaxFeeAndChargeSchemeInstance, field: 'chargeRate')}" class="form-control"/>

                <g:hasErrors bean="${depositTaxFeeAndChargeSchemeInstance}" field="chargeRate">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${depositTaxFeeAndChargeSchemeInstance}" field="chargeRate">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>
    <div class="fieldcontain form-group ${hasErrors(bean: depositTaxFeeAndChargeSchemeInstance, field: 'chargeRateBasis', 'has-error')} required">
	<label class="control-label col-sm-4" for="chargeRateBasis">
		<g:message code="depositTaxFeeAndChargeScheme.chargeRateBasis.label" default="Charge Rate Basis" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="chargeRateBasis" value="${fieldValue(bean: depositTaxFeeAndChargeSchemeInstance, field: 'chargeRateBasis')}" required="" class="form-control"/>

            <g:hasErrors bean="${depositTaxFeeAndChargeSchemeInstance}" field="chargeRateBasis">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${depositTaxFeeAndChargeSchemeInstance}" field="chargeRateBasis">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
    </div>
</div>
<div id="charge-amount-form-group">
    <div class="fieldcontain form-group ${hasErrors(bean: depositTaxFeeAndChargeSchemeInstance, field: 'chargeAmt', 'has-error')} ">
            <label class="control-label col-sm-4" for="chargeAmt">
                    <g:message code="depositTaxFeeAndChargeScheme.chargeAmt.label" default="Charge Amount" />

            </label>
            <div class="col-sm-8"><g:field name="chargeAmt" value="${fieldValue(bean: depositTaxFeeAndChargeSchemeInstance, field: 'chargeAmt')}" class="form-control"/>

                <g:hasErrors bean="${depositTaxFeeAndChargeSchemeInstance}" field="chargeAmt">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${depositTaxFeeAndChargeSchemeInstance}" field="chargeAmt">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: depositTaxFeeAndChargeSchemeInstance, field: 'specialCalculation', 'has-error')} required">
	<label class="control-label col-sm-4" for="specialCalculation">
		<g:message code="depositTaxFeeAndChargeScheme.specialCalculation.label" default="Special Calculation" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="specialCalculation" name="specialCalculation.id" from="${icbs.lov.TfcSpecialCalculationType.list()}" optionKey="id" required="" optionValue="description"value="${depositTaxFeeAndChargeSchemeInstance?.specialCalculation?.id}" class="many-to-one form-control"/>

            <g:hasErrors bean="${depositTaxFeeAndChargeSchemeInstance}" field="specialCalculation">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${depositTaxFeeAndChargeSchemeInstance}" field="specialCalculation">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: depositTaxFeeAndChargeSchemeInstance, field: 'gracePeriod', 'has-error')} required">
	<label class="control-label col-sm-4" for="gracePeriod">
		<g:message code="depositTaxFeeAndChargeScheme.gracePeriod.label" default="Grace Period" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="gracePeriod" type="number" value="${depositTaxFeeAndChargeSchemeInstance.gracePeriod}" required="" class="form-control"/>

            <g:hasErrors bean="${depositTaxFeeAndChargeSchemeInstance}" field="gracePeriod">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${depositTaxFeeAndChargeSchemeInstance}" field="gracePeriod">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: depositTaxFeeAndChargeSchemeInstance, field: 'isApplyToClosingBal', 'has-error')} ">
	<label class="control-label col-sm-4" for="isApplyToClosingBal">
		<g:message code="depositTaxFeeAndChargeScheme.isApplyToClosingBal.label" default="Is Apply To Closing Bal" />
		
	</label>
	<div class="col-sm-8"><g:checkBox name="isApplyToClosingBal" value="${depositTaxFeeAndChargeSchemeInstance?.isApplyToClosingBal}" />

            <g:hasErrors bean="${depositTaxFeeAndChargeSchemeInstance}" field="isApplyToClosingBal">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${depositTaxFeeAndChargeSchemeInstance}" field="isApplyToClosingBal">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: depositTaxFeeAndChargeSchemeInstance, field: 'minAmtException', 'has-error')} ">
	<label class="control-label col-sm-4" for="minAmtException">
		<g:message code="depositTaxFeeAndChargeScheme.minAmtException.label" default="Min Amt Exception" />
		
	</label>
	<div class="col-sm-8"><g:field name="minAmtException" value="${fieldValue(bean: depositTaxFeeAndChargeSchemeInstance, field: 'minAmtException')}" class="form-control"/>

            <g:hasErrors bean="${depositTaxFeeAndChargeSchemeInstance}" field="minAmtException">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${depositTaxFeeAndChargeSchemeInstance}" field="minAmtException">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

