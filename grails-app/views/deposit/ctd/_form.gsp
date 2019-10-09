<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<g:hiddenField name="id" value="${issueCTDInstance?.id}"/>
<g:hiddenField id="deposit"name="deposit.id" value="${issueCTDInstance?.deposit?.id}"/>
<div class="fieldcontain form-group ${hasErrors(bean: issueCTDInstance, field: 'ctdNo', 'has-error')} required">
	<label class="control-label col-sm-4" for="ctdNo">
		<g:message code="issueCTD.ctdNo.label" default="Ctd No" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
            <g:if test="${!issueCTDInstance?.id}">
                <g:field name="ctdNo" type="number" value="${issueCTDInstance?.ctdNo}" required="" class="form-control"/>
            </g:if>
            <g:else>
                <g:field disabled="disabled" name="ctdNo" type="number" value="${issueCTDInstance?.ctd?.ctdNo}" required="" class="form-control"/>
            </g:else>

            <g:hasErrors bean="${issueCTDInstance}" field="ctdNo">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${issueCTDInstance}" field="ctdNo">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: issueCTDInstance, field: 'remarks', 'has-error')} ">
	<label class="control-label col-sm-4" for="remarks">
		<g:message code="issueCTD.remarks.label" default="Remarks" />
		
	</label>
	<div class="col-sm-8"><g:textArea name="remarks" cols="40" rows="5" maxlength="255" value="${issueCTDInstance?.remarks}"class="form-control"/>

            <g:hasErrors bean="${issueCTDInstance}" field="remarks">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${issueCTDInstance}" field="remarks">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

