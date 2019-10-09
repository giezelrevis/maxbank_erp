<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<g:hiddenField id="fundingAcct"name="fundingAcct.id" value="${fundTransferInstance?.fundingAcct?.id}"/>
<g:hiddenField id="destinationAcct"name="destinationAcct.id" value="${fundTransferInstance?.destinationAcct?.id}"/>

  <div class="form-group fieldcontain ${hasErrors(bean: fundTransferInstance, field: 'txnTemplate', 'has-error')} ">
            <label class="control-label col-sm-4"for="txnTemplate">
                    <g:message code="fundTransfer.txnTemplate.label" default="Transfer Type" />
            </label>
            <div class="col-sm-8">
                <g:select id="txnTemplate" name="txnTemplate.id" from="${icbs.admin.TxnTemplate.findAllByTxnType(icbs.lov.TxnType.read(8))}" optionKey="id" optionValue ="description" value="${fundTransferInstance?.txnTemplate?.id}"class="form-control"/>
                <g:hasErrors bean="${fundTransferInstance}" field="txnTemplate">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${fundTransferInstance}" field="txnTemplate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>


<div class="form-group fieldcontain ${hasErrors(bean: fundTransferInstance, field: 'amt', 'has-error')} ">
    <label class="control-label col-sm-4"for="amt">
            <g:message code="fundTransfer.amt.label" default="Amount" />
    </label>
    <div class="col-sm-8">
        <g:textField name="amt" value="${fundTransferInstance?.amt}" class="form-control"/>
        <g:hasErrors bean="${fundTransferInstance}" field="amt">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${fundTransferInstance}" field="amt">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>
</div>



<div class="form-group fieldcontain ${hasErrors(bean: fundTransferInstance, field: 'txnRef', 'has-error')} ">
    <label class="control-label col-sm-4"for="txnRef">
            <g:message code="fundTransfer.txnRef.label" default="Transaction Refference" />
    </label>
    <div class="col-sm-8">
        <g:textField name="txnRef" value="${fundTransferInstance?.txnRef}" class="form-control"/>
        <g:hasErrors bean="${fundTransferInstance}" field="txnRef">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${fundTransferInstance}" field="txnRef">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>
</div>



<div class="form-group fieldcontain ${hasErrors(bean: fundTransferInstance, field: 'txnDescription', 'has-error')} ">
    <label class="control-label col-sm-4"for="ref">
            <g:message code="fundTransfer.txnDescription.label" default="Description" />
    </label>
    <div class="col-sm-8">
        <g:textField name="txnDescription" value="${fundTransferInstance?.txnDescription}" class="form-control"/>
        <g:hasErrors bean="${fundTransferInstance}" field="txnDescription">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${fundTransferInstance}" field="txnDescription">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>
</div>