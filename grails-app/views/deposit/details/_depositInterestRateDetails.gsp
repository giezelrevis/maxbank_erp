<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->
<%@ page contentType="text/html;charset=UTF-8" %>
    <div class="section-container">
        <fieldset>
        <legend class="section-header">Account Information</legend>
        <div class="infowrap">
             <dl class="dl-horizontal">
                <dt>Account Number</dt>
                <dd>${depositInstance?.acctNo}</dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Account Name</dt>
                <dd>${depositInstance?.acctName}</dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Date Opened</dt>
                <dd><g:formatDate format="MM/dd/yyyy" value="{$depositInstance?.dateOpened}"/></dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Interest Rate</dt>
               <dd><g:formatNumber format="#,##0.00" number="${depositInstance?.interestRate}"/>%</dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Status</dt>
                <dd>${depositInstance?.status?.description}</dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Interest Rate</dt>
                <dd><g:formatNumber format="#,##0.00" number="${depositInstance?.interestRate}"/>%</dd>
            </dl>
            <div class="fieldcontain form-group ${hasErrors(bean: depositInstance, field: 'interestRate', 'has-error')} ">
                <label class="control-label col-sm-4" for="interestRate">
                        <g:message code="deposit.interestRate.label" default="New Interest Rate" />
                </label>
                <div class="col-sm-8">
                    <g:field name="interestRate" id="interestRate" value="" class="form-control"/>
                    <g:hasErrors bean="${depositInstance}" field="interestRate">
                        <div class="controls">
                                <span class="help-block">
                                    <g:eachError bean="${depositInstance}" field="interestRate">
                                        <g:message error="${it}" /><br/>
                                    </g:eachError>
                                </span>
                        </div>
                    </g:hasErrors>
                </div>             
            </div>
        </div>
        </fieldset>
    </div>