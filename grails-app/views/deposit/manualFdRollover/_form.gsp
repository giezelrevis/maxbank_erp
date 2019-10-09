<%@ page import="icbs.deposit.Rollover" %>
<g:hiddenField name ="deposit" id="deposit.id" value="${rolloverInstance.deposit.id}"/>
<div class="fieldcontain form-group ${hasErrors(bean: rolloverInstance, field: 'startDate', 'has-error')} required">
	<label class="control-label col-sm-4" for="startDate">
		<g:message code="rollover.startDate.label" default="Start Date" />
		<span class="required-indicator">*</span>
	</label>
        <g:hiddenField name="startDate" precision="day" class="form-control"  value="${rolloverInstance.deposit.branch.runDate.format("MM/dd/yyyy")}"  />
	<div class="col-sm-8"><g:field disabled="disabled"name="startDate" precision="day" class="form-control"  value="${rolloverInstance.deposit.branch.runDate.format("MM/dd/yyyy")}"  />

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
	<div class="col-sm-8"><g:customDatePicker name="endDate" precision="day" class="form-control"  value="${rolloverInstance.deposit.branch.runDate+rolloverInstance?.deposit?.fixedDepositTermScheme?.value.toInteger()}"  />
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
<!--
<div class="fieldcontain form-group ${hasErrors(bean: rolloverInstance, field: 'interestPaymentMode', 'has-error')} ">
	<label class="control-label col-sm-4" for="interestPaymentMode">
		<g:message code="rollover.interestPaymentMode.label" default="Interest Payment Mode" />
	</label>
	<div class="col-sm-8">
                <g:if test="${rolloverInstance?.deposit?.currentRollover?.type?.id==1}">
                    <g:select id="interestPaymentMode" name="interestPaymentMode.id" from="${icbs.lov.InterestPaymentMode.list()}" optionKey="id" optionValue="description"value="${interestPaymentMode?.id}" class="many-to-one form-control" noSelection="['null': '']"/>
                </g:if>
                <g:if test="${rolloverInstance?.deposit?.currentRollover?.type?.id==2}">
                    <g:select id="interestPaymentMode" name="interestPaymentMode.id" from="${icbs.lov.InterestPaymentMode.findAllByIdNotInList([3])}" optionKey="id" optionValue="description"value="${interestPaymentMode?.id}" class="many-to-one form-control" noSelection="['null': '']"/>
                </g:if>
                <g:if test="${rolloverInstance?.deposit?.currentRollover?.type?.id==3}">
                    <g:select id="interestPaymentMode" name="interestPaymentMode.id" from="${icbs.lov.InterestPaymentMode.findAllByIdNotInList([1,2])}" optionKey="id" optionValue="description"value="${interestPaymentMode?.id}" class="many-to-one form-control" noSelection="['null': '']"/> 
                </g:if>
          
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
-->
