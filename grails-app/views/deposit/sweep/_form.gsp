<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->
<%@ page contentType="text/html;charset=UTF-8" %>
<g:hiddenField name="id" value="${sweepInstance?.id}"/>
<g:hiddenField name="fundingDeposit.id" value="${sweepInstance?.fundingDeposit?.id}"/>

<div class="fieldcontain form-group ${hasErrors(bean: sweepInstance, field: 'fundedDeposit', 'has-error')} required">
	<label class="control-label col-sm-4" for="fundedDeposit">
		<g:message code="sweep.fundedDeposit.label" default="Funded Acct" />
		<span class="required-indicator">*</span>
	</label>
        <div class="col-sm-8">
            <g:if test="${!edit}">
                <input type="button" href="#"onclick="initializeDepositSearchModal();modal.show()"value="Search Deposits"/>
            </g:if>
            <g:hiddenField id="fundedDeposit" name="fundedDeposit.id" value="${sweepInstance?.fundedDeposit?.id}"/>
            <g:textField id="fundedDeposit" name="fundedDeposit.acctNo" disabled="disabled" value="${sweepInstance?.fundedDeposit?.acctNo}"/>
            
            <g:hasErrors bean="${sweepInstance}" field="fundedDeposit">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${sweepInstance}" field="fundedDeposit">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: sweepInstance, field: 'rule', 'has-error')} required">
	<label class="control-label col-sm-4" for="rule">
		<g:message code="sweep.rule.label" default="Rule" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="rule" onchange="updateForm()"name="rule.id" from="${icbs.lov.SweepRule.list()}" optionKey="id" optionValue="description"required="" value="${sweepInstance?.rule?.id}" class="many-to-one form-control"/>

            <g:hasErrors bean="${sweepInstance}" field="rule">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${sweepInstance}" field="rule">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<div id="fixed-amount-div" style="<g:if test="${holdInstance?.type?.id==3}">display:block</g:if><g:else>display:none</g:else>">
<div class="fieldcontain form-group ${hasErrors(bean: sweepInstance, field: 'fundLimitAmt', 'has-error')} ">
	<label class="control-label col-sm-4" for="fundLimitAmt">
		<g:message code="sweep.fundLimitAmt.label" default="Fund Limit Amt" />
		
	</label>
	<div class="col-sm-8"><g:field name="fundLimitAmt" value="${fieldValue(bean: sweepInstance, field: 'fundLimitAmt')}" class="form-control"/>

            <g:hasErrors bean="${sweepInstance}" field="fundLimitAmt">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${sweepInstance}" field="fundLimitAmt">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
</div>
<div id="variable-amount-div" style="<g:if test="${standingOrderInstance?.type?.id==4}">display:block</g:if><g:else>display:none</g:else>">
<div class="fieldcontain form-group ${hasErrors(bean: sweepInstance, field: 'fundLimitPercentage', 'has-error')}">
	<label class="control-label col-sm-4" for="fundLimitPercentage">
		<g:message code="sweep.fundLimitPercentage.label" default="Fund Limit Percentage" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="fundLimitPercentage" value="${fieldValue(bean: sweepInstance, field: 'fundLimitPercentage')}" required="" class="form-control"/>

            <g:hasErrors bean="${sweepInstance}" field="fundLimitPercentage">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${sweepInstance}" field="fundLimitPercentage">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
</div>
<div class="fieldcontain form-group ${hasErrors(bean: sweepInstance, field: 'ordinalNum', 'has-error')} required">
	<label class="control-label col-sm-4" for="ordinalNum">
		<g:message code="sweep.ordinalNum.label" default="Ordinal Num" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="ordinalNum" type="number" min="0" value="${sweepInstance.ordinalNum}" required="" class="form-control"/>

            <g:hasErrors bean="${sweepInstance}" field="ordinalNum">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${sweepInstance}" field="ordinalNum">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<div class="fieldcontain form-group ${hasErrors(bean: sweepInstance, field: 'remarks', 'has-error')} ">
	<label class="control-label col-sm-4" for="remarks">
		<g:message code="sweep.remarks.label" default="Remarks" />
		
	</label>
	<div class="col-sm-8"><g:textArea name="remarks" cols="40" rows="5" maxlength="255" value="${sweepInstance?.remarks}"class="form-control"/>

            <g:hasErrors bean="${sweepInstance}" field="remarks">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${sweepInstance}" field="remarks">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: sweepInstance, field: 'status', 'has-error')} ">
	<label class="control-label col-sm-4" for="status">
		<g:message code="sweep.status.label" default="Status" />
		
	</label>
	<div class="col-sm-8"><g:select id="status" name="status.id" from="${icbs.lov.SweepStatus.list()}" optionKey="id"optionValue="description" value="${sweepInstance?.status?.id}" class="many-to-one form-control" noSelection="['null': '']"/>

            <g:hasErrors bean="${sweepInstance}" field="status">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${sweepInstance}" field="status">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


