<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
 
        <title>Write-Off</title>

    </head>
    <body>
        <content tag="main-content">
             
<div class="form-group">
    <label class="control-label">Transaction Type</label>
    <div class="col-sm-6">
        <select id="txnTemplate" name="txnTemplate" class="many-to-one form-control">
            <g:each in="${icbs.admin.TxnTemplate.findAllByTxnType(icbs.lov.TxnType.read(35))}" var="txnTemplateInstance">
                <option value="${txnTemplateInstance.id}">${txnTemplateInstance.codeDescription}</option>
            </g:each>
        </select>
    </div>
</div>        
      
<div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'loan', 'has-error')} ">
	<label class="control-label col-sm-4" for="loan">
		<g:message code="loan.label" default="Loan Account" />
        <span class="required-indicator">*</span>
	</label>
	<div class="col-sm-7"><g:field name="accountNo" value="${loanInstance?.accountNo}" class="form-control" readonly="true"/>        

        <g:hasErrors bean="${loanInstance}" field="loan">
            <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${loanInstance}" field="loan">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
            </div>
        </g:hasErrors>
    </div>
   </div>
        
    <div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'loan', 'has-error')} ">
	<label class="control-label col-sm-4" for="loan">
		<g:message code="loan.customer.label" default="Customer Name" />
        <span class="required-indicator">*</span>
	</label>
	<div class="col-sm-7"><g:field name="customer" value="${loanInstance?.customer?.name1 + loanInstance?.customer?.name2 + loanInstance?.customer?.name3}" class="form-control" readonly="true"/>        

        <g:hasErrors bean="${loanInstance}" field="loan">
            <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${loanInstance}" field="loan">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
            </div>
        </g:hasErrors>
    </div>
     </div>
     
        <div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'loan', 'has-error')} ">
	<label class="control-label col-sm-4" for="loan">
		<g:message code="loan.label" default="Granted Amount" />
        <span class="required-indicator">*</span>
	</label>
	<div class="col-sm-7"><g:field name="grantedAmount" value="${loanInstance?.grantedAmount}" class="form-control" readonly="true"/>        

        <g:hasErrors bean="${loanInstance}" field="loan">
            <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${loanInstance}" field="loan">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
            </div>
        </g:hasErrors>
    </div>
     </div>
      
        <div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'loan', 'has-error')} ">
	<label class="control-label col-sm-4" for="loan">
		<g:message code="loan.label" default="Maturity Date" />
        <span class="required-indicator">*</span>
	</label>
	<div class="col-sm-7"><g:field name="MaturityDate" value="${loanInstance?.maturityDate}" class="form-control" readonly="true"/>        

        <g:hasErrors bean="${loanInstance}" field="loan">
            <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${loanInstance}" field="loan">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
            </div>
        </g:hasErrors>
    </div>
    </div>
    <div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'loan', 'has-error')} ">
	<label class="control-label col-sm-4" for="loan">
		<g:message code="loan.label" default="Principal Balance" />
     
	</label>
	<div class="col-sm-7"><g:field name="balanceAmount" value="${loanInstance?.balanceAmount}" class="form-control" readonly="true"/>        

        <g:hasErrors bean="${loanInstance}" field="loan">
            <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${loanInstance}" field="loan">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
            </div>
        </g:hasErrors>
    </div>
     </div>
    <div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'loan', 'has-error')} ">
	<label class="control-label col-sm-4" for="loan">
		<g:message code="loan.label" default="Interest Balance" />
      
	</label>
	<div class="col-sm-7"><g:field name="interestBalanceAmount" value="${loanInstance?.interestBalanceAmount}" class="form-control" readonly="true"/>        

        <g:hasErrors bean="${loanInstance}" field="loan">
            <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${loanInstance}" field="loan">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
            </div>
        </g:hasErrors>
    </div>
     </div>
    <div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'loan', 'has-error')} ">
	<label class="control-label col-sm-4" for="loan">
		<g:message code="loan.label" default="Penalty Balance" />
     
	</label>
	<div class="col-sm-7"><g:field name="penaltyBalanceAmount" value="${loanInstance?.penaltyBalanceAmount}" class="form-control" readonly="true"/>        

        <g:hasErrors bean="${loanInstance}" field="loan">
            <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${loanInstance}" field="loan">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
            </div>
        </g:hasErrors>
    </div>
     </div>
    <div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'loan', 'has-error')} ">
	<label class="control-label col-sm-4" for="loan">
		<g:message code="loan.label" default="ServiceCharge Balance" />
     
	</label>
	<div class="col-sm-7"><g:field name="serviceChargeBalanceAmount" value="${loanInstance?.serviceChargeBalanceAmount}" class="form-control" readonly="true"/>        

        <g:hasErrors bean="${loanInstance}" field="loan">
            <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${loanInstance}" field="loan">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
            </div>
        </g:hasErrors>
    </div>
 </div>
   </content>    
    <content tag="main-actions">
            <ul>
                <g:if test="${loanInstance?.status?.id <= 5}"> 
                <li><g:form id="transfers" name="transfers" url="[controller:loan, action:'transferW', id:loanInstance.id]" method="POST"></g:form>
                <g:actionSubmit id="transfer" action="transferW" value="Transfer Account to Write off" onclick="
                alertify.confirm(AppTitle,'Are you sure you want to continue Write-Off transaction?',    
                function(){
                    checkIfAllowed('LON01900', 'form#transfers', 'Transfer to Write off', null);
                },
                function(){
                    return;
                });                        
                    "/></li>
            
                </g:if>
                <li><g:link class="list" action="index" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">Cancel</g:link></li>
            </ul>
            
               
    </content>
    </body>
</html>
