<%@ page import="icbs.deposit.Rollover" %>




<div class="fieldcontain form-group ${hasErrors(bean: rolloverInstance, field: 'rolloverSequence', 'has-error')} required">
	<label class="control-label col-sm-4" for="rolloverSequence">
		<g:message code="rollover.rolloverSequence.label" default="Rollover Sequence" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="rolloverSequence" type="number" value="${rolloverInstance.rolloverSequence}" required="" class="form-control"/>

            <g:hasErrors bean="${rolloverInstance}" field="rolloverSequence">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${rolloverInstance}" field="rolloverSequence">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: rolloverInstance, field: 'startDate', 'has-error')} required">
	<label class="control-label col-sm-4" for="startDate">
		<g:message code="rollover.startDate.label" default="Start Date" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:customDatePicker name="startDate" precision="day" class="form-control"  value="${rolloverInstance?.startDate}"  />

            <g:hasErrors bean="${rolloverInstance}" field="startDate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${rolloverInstance}" field="startDate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: rolloverInstance, field: 'endDate', 'has-error')} required">
	<label class="control-label col-sm-4" for="endDate">
		<g:message code="rollover.endDate.label" default="End Date" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:customDatePicker name="endDate" precision="day" class="form-control"  value="${rolloverInstance?.endDate}"  />

            <g:hasErrors bean="${rolloverInstance}" field="endDate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${rolloverInstance}" field="endDate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: rolloverInstance, field: 'rolloverType', 'has-error')} required">
	<label class="control-label col-sm-4" for="rolloverType">
		<g:message code="rollover.rolloverType.label" default="Rollover Type" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="rolloverType" name="rolloverType.id" from="${icbs.lov.RolloverType.list()}" optionKey="id" required="" value="${rolloverInstance?.rolloverType?.id}" class="many-to-one form-control"/>

            <g:hasErrors bean="${rolloverInstance}" field="rolloverType">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${rolloverInstance}" field="rolloverType">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: rolloverInstance, field: 'principalAmt', 'has-error')} required">
	<label class="control-label col-sm-4" for="principalAmt">
		<g:message code="rollover.principalAmt.label" default="Principal Amt" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="principalAmt" value="${fieldValue(bean: rolloverInstance, field: 'principalAmt')}" required="" class="form-control"/>

            <g:hasErrors bean="${rolloverInstance}" field="principalAmt">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${rolloverInstance}" field="principalAmt">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: rolloverInstance, field: 'preTermInterestAmt', 'has-error')} required">
	<label class="control-label col-sm-4" for="preTermInterestAmt">
		<g:message code="rollover.preTermInterestAmt.label" default="Pre Term Interest Amt" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="preTermInterestAmt" value="${fieldValue(bean: rolloverInstance, field: 'preTermInterestAmt')}" required="" class="form-control"/>

            <g:hasErrors bean="${rolloverInstance}" field="preTermInterestAmt">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${rolloverInstance}" field="preTermInterestAmt">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: rolloverInstance, field: 'taxAmt1', 'has-error')} ">
	<label class="control-label col-sm-4" for="taxAmt1">
		<g:message code="rollover.taxAmt1.label" default="Tax Amt1" />
		
	</label>
	<div class="col-sm-8"><g:field name="taxAmt1" value="${fieldValue(bean: rolloverInstance, field: 'taxAmt1')}" class="form-control"/>

            <g:hasErrors bean="${rolloverInstance}" field="taxAmt1">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${rolloverInstance}" field="taxAmt1">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: rolloverInstance, field: 'taxAmt2', 'has-error')} ">
	<label class="control-label col-sm-4" for="taxAmt2">
		<g:message code="rollover.taxAmt2.label" default="Tax Amt2" />
		
	</label>
	<div class="col-sm-8"><g:field name="taxAmt2" value="${fieldValue(bean: rolloverInstance, field: 'taxAmt2')}" class="form-control"/>

            <g:hasErrors bean="${rolloverInstance}" field="taxAmt2">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${rolloverInstance}" field="taxAmt2">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: rolloverInstance, field: 'taxAmt3', 'has-error')} ">
	<label class="control-label col-sm-4" for="taxAmt3">
		<g:message code="rollover.taxAmt3.label" default="Tax Amt3" />
		
	</label>
	<div class="col-sm-8"><g:field name="taxAmt3" value="${fieldValue(bean: rolloverInstance, field: 'taxAmt3')}" class="form-control"/>

            <g:hasErrors bean="${rolloverInstance}" field="taxAmt3">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${rolloverInstance}" field="taxAmt3">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: rolloverInstance, field: 'ctd', 'has-error')} ">
	<label class="control-label col-sm-4" for="ctd">
		<g:message code="rollover.ctd.label" default="Ctd" />
		
	</label>
	<div class="col-sm-8"><g:select id="ctd" name="ctd.id" from="${icbs.deposit.CTD.list()}" optionKey="id" value="${rolloverInstance?.ctd?.id}" class="many-to-one form-control" noSelection="['null': '']"/>

            <g:hasErrors bean="${rolloverInstance}" field="ctd">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${rolloverInstance}" field="ctd">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: rolloverInstance, field: 'rolloverStatus', 'has-error')} ">
	<label class="control-label col-sm-4" for="rolloverStatus">
		<g:message code="rollover.rolloverStatus.label" default="Rollover Status" />
		
	</label>
	<div class="col-sm-8"><g:select id="rolloverStatus" name="rolloverStatus.id" from="${icbs.lov.RolloverStatus.list()}" optionKey="id" value="${rolloverInstance?.rolloverStatus?.id}" class="many-to-one form-control" noSelection="['null': '']"/>

            <g:hasErrors bean="${rolloverInstance}" field="rolloverStatus">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${rolloverInstance}" field="rolloverStatus">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: rolloverInstance, field: 'interestPaymentMode', 'has-error')} ">
	<label class="control-label col-sm-4" for="interestPaymentMode">
		<g:message code="rollover.interestPaymentMode.label" default="Interest Payment Mode" />
		
	</label>
	<div class="col-sm-8"><g:select id="interestPaymentMode" name="interestPaymentMode.id" from="${icbs.lov.InterestPaymentMode.list()}" optionKey="id" value="${rolloverInstance?.interestPaymentMode?.id}" class="many-to-one form-control" noSelection="['null': '']"/>

            <g:hasErrors bean="${rolloverInstance}" field="interestPaymentMode">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${rolloverInstance}" field="interestPaymentMode">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: rolloverInstance, field: 'deposit', 'has-error')} required">
	<label class="control-label col-sm-4" for="deposit">
		<g:message code="rollover.deposit.label" default="Deposit" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="deposit" name="deposit.id" from="${icbs.deposit.Deposit.list()}" optionKey="id" required="" value="${rolloverInstance?.deposit?.id}" class="many-to-one form-control"/>

            <g:hasErrors bean="${rolloverInstance}" field="deposit">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${rolloverInstance}" field="deposit">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: rolloverInstance, field: 'normalInterestAmt', 'has-error')} required">
	<label class="control-label col-sm-4" for="normalInterestAmt">
		<g:message code="rollover.normalInterestAmt.label" default="Normal Interest Amt" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="normalInterestAmt" value="${fieldValue(bean: rolloverInstance, field: 'normalInterestAmt')}" required="" class="form-control"/>

            <g:hasErrors bean="${rolloverInstance}" field="normalInterestAmt">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${rolloverInstance}" field="normalInterestAmt">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

