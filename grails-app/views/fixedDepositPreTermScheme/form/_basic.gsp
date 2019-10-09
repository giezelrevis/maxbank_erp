<%@ page import="icbs.deposit.FixedDepositPreTermScheme" %>




<div class="fieldcontain form-group ${hasErrors(bean: fixedDepositPreTermSchemeInstance, field: 'code', 'has-error')} required">
	<label class="control-label col-sm-4" for="code">
		<g:message code="fixedDepositPreTermScheme.code.label" default="Code" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="code" maxlength="10" required="" value="${fixedDepositPreTermSchemeInstance?.code}"class="form-control"/>

            <g:hasErrors bean="${fixedDepositPreTermSchemeInstance}" field="code">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${fixedDepositPreTermSchemeInstance}" field="code">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: fixedDepositPreTermSchemeInstance, field: 'name', 'has-error')} required">
	<label class="control-label col-sm-4" for="name">
		<g:message code="fixedDepositPreTermScheme.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="name" maxlength="50" value="${fixedDepositPreTermSchemeInstance?.name}"class="form-control"/>

            <g:hasErrors bean="${fixedDepositPreTermSchemeInstance}" field="name">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${fixedDepositPreTermSchemeInstance}" field="name">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: fixedDepositPreTermSchemeInstance, field: 'description', 'has-error')} ">
	<label class="control-label col-sm-4" for="description">
		<g:message code="fixedDepositPreTermScheme.description.label" default="Description" />
		
	</label>
	<div class="col-sm-8"><g:textArea name="description" cols="40" rows="5" maxlength="255" value="${fixedDepositPreTermSchemeInstance?.description}"class="form-control"/>

            <g:hasErrors bean="${fixedDepositPreTermSchemeInstance}" field="description">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${fixedDepositPreTermSchemeInstance}" field="description">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: fixedDepositPreTermSchemeInstance, field: 'type', 'has-error')} required">
	<label class="control-label col-sm-4" for="type">
		<g:message code="fixedDepositPreTermScheme.type.label" default="Type" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="type" name="type.id" from="${icbs.lov.FdPreTerminationType.list()}" optionKey="id" optionValue="description" required="" value="${fixedDepositPreTermSchemeInstance?.type?.id}" class="many-to-one form-control"/>

            <g:hasErrors bean="${fixedDepositPreTermSchemeInstance}" field="type">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${fixedDepositPreTermSchemeInstance}" field="type">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: fixedDepositPreTermSchemeInstance, field: 'rate', 'has-error')} required">
	<label class="control-label col-sm-4" for="rate">
		<g:message code="fixedDepositPreTermScheme.rate.label" default="Rate" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="rate" value="${fieldValue(bean: fixedDepositPreTermSchemeInstance, field: 'rate')}" required="" class="form-control"/>

            <g:hasErrors bean="${fixedDepositPreTermSchemeInstance}" field="rate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${fixedDepositPreTermSchemeInstance}" field="rate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: fixedDepositPreTermSchemeInstance, field: 'term1stHalf', 'has-error')} required">
	<label class="control-label col-sm-4" for="term1stHalf">
		<g:message code="fixedDepositPreTermScheme.term1stHalf.label" default="Term1st Half" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="term1stHalf" value="${fieldValue(bean: fixedDepositPreTermSchemeInstance, field: 'term1stHalf')}" required="" class="form-control"/>

            <g:hasErrors bean="${fixedDepositPreTermSchemeInstance}" field="term1stHalf">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${fixedDepositPreTermSchemeInstance}" field="term1stHalf">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: fixedDepositPreTermSchemeInstance, field: 'term2ndHalf', 'has-error')} required">
	<label class="control-label col-sm-4" for="term2ndHalf">
		<g:message code="fixedDepositPreTermScheme.term2ndHalf.label" default="Term2nd Half" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="term2ndHalf" value="${fieldValue(bean: fixedDepositPreTermSchemeInstance, field: 'term2ndHalf')}" required="" class="form-control"/>

            <g:hasErrors bean="${fixedDepositPreTermSchemeInstance}" field="term2ndHalf">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${fixedDepositPreTermSchemeInstance}" field="term2ndHalf">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: fixedDepositPreTermSchemeInstance, field: 'divisor', 'has-error')} required">
	<label class="control-label col-sm-4" for="divisor">
		<g:message code="fixedDepositPreTermScheme.divisor.label" default="Divisor" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="divisor" type="number" value="${fixedDepositPreTermSchemeInstance.divisor}" required="" class="form-control"/>

            <g:hasErrors bean="${fixedDepositPreTermSchemeInstance}" field="divisor">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${fixedDepositPreTermSchemeInstance}" field="divisor">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<g:if test="${fixedDepositPreTermSchemeInstance?.id}">
    <div class="fieldcontain form-group ${hasErrors(bean: fixedDepositPreTermSchemeInstance, field: 'status', 'has-error')} ">
            <label class="control-label col-sm-4" for="status">
                    <g:message code="fixedDepositPreTermScheme.status.label" default="Status" />

            </label>
            <div class="col-sm-8"><g:select id="status" name="status.id" from="${icbs.lov.ConfigItemStatus.list()}" optionKey="id" optionValue="description" value="${fixedDepositPreTermSchemeInstance?.status?.id}" class="many-to-one form-control" noSelection="['null': '']"/>

                <g:hasErrors bean="${fixedDepositPreTermSchemeInstance}" field="status">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${fixedDepositPreTermSchemeInstance}" field="status">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>
</g:if>

<div class="fieldcontain form-group ${hasErrors(bean: fixedDepositPreTermSchemeInstance, field: 'isGradeRate', 'has-error')} ">
	<label class="control-label col-sm-4" for="isGradeRate">
		<g:message code="fixedDepositPreTermScheme.isGradeRate.label" default="Is Grade Rate" />
		
	</label>
	<div class="col-sm-8"><g:checkBox name="isGradeRate" class="" value="${fixedDepositPreTermSchemeInstance?.isGradeRate}" />

            <g:hasErrors bean="${fixedDepositPreTermSchemeInstance}" field="isGradeRate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${fixedDepositPreTermSchemeInstance}" field="isGradeRate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
