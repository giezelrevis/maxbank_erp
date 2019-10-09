<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<g:hiddenField name="id" value="${standingOrderInstance?.id}"/>
<g:hiddenField id="fundingDeposit"name="fundingDeposit.id" value="${standingOrderInstance?.fundingDeposit?.id}"/>

<div class="fieldcontain form-group ${hasErrors(bean: standingOrderInstance, field: 'fundedDeposit', 'has-error')} required">
	<label class="control-label col-sm-4" for="fundedDeposit">
		<g:message code="standingOrder.fundedDeposit.label" default="Transfer to Account" />
		<span class="required-indicator">*</span>
	</label>
        <div class="col-sm-8">
            <g:if test="${!standingOrderInstance?.id}">
                <input type="button" href="#"onclick="initializeDepositSearchModal();modal.show()"value="Search Deposits"/>
            </g:if>
	
            <g:hiddenField id="fundedDeposit" name="fundedDeposit.id" value="${standingOrderInstance?.fundedDeposit?.id}"/>
            <g:textField id="fundedDeposit" name="fundedDeposit.acctNo" disabled="disabled" value="${standingOrderInstance?.fundedDeposit?.acctNo}"/>

            <g:hasErrors bean="${standingOrderInstance}" field="fundedDeposit">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${standingOrderInstance}" field="fundedDeposit">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<div class="fieldcontain form-group ${hasErrors(bean: standingOrderInstance, field: 'type', 'has-error')} required">
	<label class="control-label col-sm-4" for="type">
		<g:message code="standingOrder.type.label" default="Type" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="type" onchange="updateForm()"name="type.id" from="${icbs.lov.StandingOrderType.list()}" optionKey="id"optionValue="description" required="" value="${standingOrderInstance?.type?.id}" class="many-to-one form-control"/>

            <g:hasErrors bean="${standingOrderInstance}" field="type">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${standingOrderInstance}" field="type">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: standingOrderInstance, field: 'freq', 'has-error')} required">
	<label class="control-label col-sm-4" for="freq">
		<g:message code="standingOrder.freq.label" default="Freq" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="freq" name="freq.id" from="${icbs.lov.StandingOrderFreq.list()}" optionKey="id" optionValue="description"required="" value="${standingOrderInstance?.freq?.id}" class="many-to-one form-control"/>

            <g:hasErrors bean="${standingOrderInstance}" field="freq">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${standingOrderInstance}" field="freq">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<div id="fixed-amount-div" style="<g:if test="${standingOrderInstance?.type?.id==1||!standingOrderInstance?.type}">display:block</g:if><g:else>display:none</g:else>">
<div class="fieldcontain form-group ${hasErrors(bean: standingOrderInstance, field: 'fundFixedAmt', 'has-error')} ">
	<label class="control-label col-sm-4" for="fundFixedAmt">
		<g:message code="standingOrder.fundFixedAmt.label" default="Fund Fixed Amt" />
		
	</label>
	<div class="col-sm-8"><g:field name="fundFixedAmt" value="${fieldValue(bean: standingOrderInstance, field: 'fundFixedAmt')}" class="form-control"/>

            <g:hasErrors bean="${standingOrderInstance}" field="fundFixedAmt">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${standingOrderInstance}" field="fundFixedAmt">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
</div>
<div id="variable-amount-div" style="<g:if test="${standingOrderInstance?.type?.id==2}">display:block</g:if><g:else>display:none</g:else>">
<div class="fieldcontain form-group ${hasErrors(bean: standingOrderInstance, field: 'percent', 'has-error')} ">
	<label class="control-label col-sm-4" for="percent">
		<g:message code="standingOrder.percent.label" default="Percent" />
		
	</label>
	<div class="col-sm-8"><g:field name="percent" value="${fieldValue(bean: standingOrderInstance, field: 'percent')}" class="form-control"/>

            <g:hasErrors bean="${standingOrderInstance}" field="percent">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${standingOrderInstance}" field="percent">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: standingOrderInstance, field: 'retries', 'has-error')} required">
	<label class="control-label col-sm-4" for="retries">
		<g:message code="standingOrder.retries.label" default="Retries" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="retries" type="number" value="${standingOrderInstance.retries}" required="" class="form-control"/>

            <g:hasErrors bean="${standingOrderInstance}" field="retries">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${standingOrderInstance}" field="retries">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: standingOrderInstance, field: 'status', 'has-error')} ">
	<label class="control-label col-sm-4" for="status">
		<g:message code="standingOrder.status.label" default="Status" />
		
	</label>
	<div class="col-sm-8"><g:select id="status" name="status.id" from="${icbs.lov.StandingOrderStatus.list()}" optionKey="id" optionValue="description" value="${standingOrderInstance?.status?.id}" class="many-to-one form-control"/>

            <g:hasErrors bean="${standingOrderInstance}" field="status">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${standingOrderInstance}" field="status">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>