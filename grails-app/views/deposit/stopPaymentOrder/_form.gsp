<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<g:hiddenField name="id" value="${stopPaymentOrderInstance?.id}"/>
<g:hiddenField name="deposit.id" value="${stopPaymentOrderInstance?.deposit?.id}"/>
<div class="fieldcontain form-group ${hasErrors(bean: stopPaymentOrderInstance, field: 'chequeNo', 'has-error')} required">
	<label class="control-label col-sm-4" for="chequeNo">
		<g:message code="stopPaymentOrder.chequeNo.label" default="Cheque No" />
		<span class="required-indicator">*</span>
	</label>
        <div class="col-sm-8">
        <g:if test="${edit}">
           <g:textField disabled="disabled" id="cheque" name="cheque.id" value="${stopPaymentOrderInstance?.cheque?.chequeNo}"class="form-control"/>
        </g:if>
        <g:else>
            <g:textField id="chequeNo" name="chequeNo" value="${stopPaymentOrderInstance?.cheque?.chequeNo}"class="form-control"/>
        </g:else>
            <g:hasErrors bean="${stopPaymentOrderInstance}" field="chequeNo">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${stopPaymentOrderInstance}" field="chequeNo">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<div class="fieldcontain form-group ${hasErrors(bean: stopPaymentOrderInstance, field: 'chkPayee', 'has-error')} ">
	<label class="control-label col-sm-4" for="chkPayee">
		<g:message code="stopPaymentOrder.chkPayee.label" default="Chk Payee" />
		
	</label>
	<div class="col-sm-8"><g:textField name="chkPayee" maxlength="50" value="${stopPaymentOrderInstance?.chkPayee}"class="form-control"/>

            <g:hasErrors bean="${stopPaymentOrderInstance}" field="chkPayee">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${stopPaymentOrderInstance}" field="chkPayee">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: stopPaymentOrderInstance, field: 'chkDate', 'has-error')} ">
	<label class="control-label col-sm-4" for="chkDate">
		<g:message code="stopPaymentOrder.chkDate.label" default="Chk Date" />
		
	</label>
	<div class="col-sm-8"><g:customDatePicker name="chkDate" precision="day" class="form-control"  value="${stopPaymentOrderInstance?.chkDate}" default="none" noSelection="['': '']" />

            <g:hasErrors bean="${stopPaymentOrderInstance}" field="chkDate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${stopPaymentOrderInstance}" field="chkDate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: stopPaymentOrderInstance, field: 'chkAmt', 'has-error')} ">
	<label class="control-label col-sm-4" for="chkAmt">
		<g:message code="stopPaymentOrder.chkAmt.label" default="Chk Amt" />
		
	</label>
	<div class="col-sm-8"><g:field name="chkAmt" value="${fieldValue(bean: stopPaymentOrderInstance, field: 'chkAmt')}" class="form-control"/>

            <g:hasErrors bean="${stopPaymentOrderInstance}" field="chkAmt">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${stopPaymentOrderInstance}" field="chkAmt">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: stopPaymentOrderInstance, field: 'ref', 'has-error')} ">
	<label class="control-label col-sm-4" for="ref">
		<g:message code="stopPaymentOrder.ref.label" default="Reference" />
		
	</label>
	<div class="col-sm-8"><g:textField name="ref" maxlength="50" value="${stopPaymentOrderInstance?.ref}"class="form-control"/>

            <g:hasErrors bean="${stopPaymentOrderInstance}" field="ref">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${stopPaymentOrderInstance}" field="ref">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: stopPaymentOrderInstance, field: 'remarks', 'has-error')} ">
	<label class="control-label col-sm-4" for="remarks">
		<g:message code="stopPaymentOrder.remarks.label" default="Remarks" />
		
	</label>
	<div class="col-sm-8"><g:textArea name="remarks" cols="40" rows="5" maxlength="255" value="${stopPaymentOrderInstance?.remarks}"class="form-control"/>

            <g:hasErrors bean="${stopPaymentOrderInstance}" field="remarks">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${stopPaymentOrderInstance}" field="remarks">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<div class="fieldcontain form-group ${hasErrors(bean: stopPaymentOrderInstance, field: 'status', 'has-error')} ">
	<label class="control-label col-sm-4" for="status">
		<g:message code="stopPaymentOrder.status.label" default="Status" />
		
	</label>
	<div class="col-sm-8"><g:select id="status" name="status.id" from="${icbs.lov.ConfigItemStatus.list()}" optionKey="id"optionValue="description" value="${stopPaymentOrderInstance?.status?.id}" class="many-to-one form-control" noSelection="['null': '']"/>

            <g:hasErrors bean="${stopPaymentOrderInstance}" field="status">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${stopPaymentOrderInstance}" field="status">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

