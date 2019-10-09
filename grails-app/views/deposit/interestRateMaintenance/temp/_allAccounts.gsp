<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

 <div class="col-md-12">
    <div class="fieldcontain form-group ${hasErrors(bean: depositInterestSchemeInstance, field: 'code', 'has-error')} required">
	<label class="control-label col-sm-4" for="code">
		<g:message code="depositInterestScheme.id.label" default="Deposit Interest Scheme" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"> <div class="col-sm-8"><g:select onchange="changeInterestRateFormAjax()" id="id" name="id" from="${icbs.deposit.DepositInterestScheme.list()}" optionKey="id" value="${depositInterestSchemeInstance?.id}" class="many-to-one form-control" noSelection="['null': '']"/>
            
            <g:hasErrors bean="${depositInterestSchemeInstance}" field="id">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${depositInterestSchemeInstance}" field="id">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
            </div>             
        </div>
    </div>
 </div>
<div class="col-md-12" id="showAndChangeInterestRateDiv">
        <div class="col-md-6">
            <div class="fieldcontain form-group ${hasErrors(bean: depositInterestSchemeInstance, field: 'interestRate', 'has-error')} required">
                <label class="control-label col-sm-4" for="interestRate">
                        <g:message code="depositInterestScheme.interestRate.label" default=" Old Interest Rate" />
                        <span class="required-indicator">*</span>
                </label>
                <div class="col-sm-8"><g:field name="interestRate" disabled="disabled" value="${fieldValue(bean: depositInterestSchemeInstance, field: 'interestRate')}" required="" class="form-control"/>

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
        </div>
        <div class="col-md-6">
            <div class="fieldcontain form-group ${hasErrors(bean: depositInterestSchemeInstance, field: 'interestRate', 'has-error')} required">
                <label class="control-label col-sm-4" for="interestRate">
                        <g:message code="depositInterestScheme.interestRate.label" default="New  Interest Rate" />
                        <span class="required-indicator">*</span>
                </label>
                <div class="col-sm-8"><g:field name="interestRate" value="" required="" class="form-control"/>

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
        </div>
    </div>