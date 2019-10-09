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
 
        <title>ROPA</title>

    </head>
    <body>
        <content tag="main-content">
             
<div class="form-group">
    <label class="control-label">Transaction Type</label>
    <div class="col-sm-6">
        <select id="txnTemplate" name="txnTemplate" class="many-to-one form-control">
            <g:each in="${icbs.admin.TxnTemplate.findAllByTxnType(icbs.lov.TxnType.read(38))}" var="txnTemplateInstance">
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
		<g:message code="loan.status.id" default="status" />
        <span class="required-indicator">*</span>
	</label>
	<div class="col-sm-7"><g:field name="status" value="${loanInstance?.status?.description}" class="form-control" readonly="true"/>        

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
    <div class="fieldcontain form-group ${hasErrors(bean: txnRopaInstance, field: 'modeOfForeclosure', 'has-error')} ">
	<label class="control-label col-sm-4" for="txnRopaInstance">
		<g:message code="txnRopaInstance.label" default="Mode of Foreclosure" />
     
	</label>
	<div class="col-sm-7"><g:field name="modeOfForeclosure" value="${txnRopaInstance?.modeOfForeclosure}" class="form-control"/></div>        

        <g:hasErrors bean="${txnRopaInstance}" field="modeOfForeclosure">
            <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${txnRopaInstance}" field="modeOfForeclosure">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
            </div>
        </g:hasErrors>
    </div>   
    <div class="fieldcontain form-group ${hasErrors(bean: txnRopaInstance, field: 'dateBooked', 'has-error')} ">
        <label class="control-label col-sm-4" for="dateBooked">
            <g:message code="txnRopaInstance.dateBooked.label" default="Date Booked" />     
        </label>
        <div class="col-sm-8"><g:customDatePicker name="dateBooked" precision="day" class="form-control" format="MM/dd/yyyy" value="${loanInstance?.branch?.runDate}"/>

            <g:hasErrors bean="${txnRopaInstance}" field="dateBooked">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnRopaInstance}" field="dateBooked">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
    </div>
     <div class="fieldcontain form-group ${hasErrors(bean: txnRopaInstance, field: 'dateAcquired', 'has-error')} ">
        <label class="control-label col-sm-4" for="dateAcquired">
            <g:message code="txnRopaInstance.dateAcquired.label" default="Date Acquired" />     
        </label>
        <div class="col-sm-8"><g:customDatePicker name="dateAcquired" precision="day" class="form-control" format="MM/dd/yyyy" value="${loanInstance?.branch?.runDate}"/>

            <g:hasErrors bean="${txnRopaInstance}" field="dateAcquired">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnRopaInstance}" field="dateAcquired">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
    </div> 

     <div class="fieldcontain form-group ${hasErrors(bean: txnRopaInstance, field: 'dateRegistered', 'has-error')} ">
        <label class="control-label col-sm-4" for="dateRegistered">
            <g:message code="txnRopaInstance.dateRegistered.label" default="Date Registered" />     
        </label>
        <div class="col-sm-8"><g:customDatePicker name="dateRegistered" precision="day" class="form-control" format="MM/dd/yyyy" value="${loanInstance?.branch?.runDate}"/>

            <g:hasErrors bean="${txnRopaInstance}" field="dateRegistered">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnRopaInstance}" field="dateRegistered">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
    </div>    
     <div class="fieldcontain form-group ${hasErrors(bean: txnRopaInstance, field: 'dateNotarized', 'has-error')} ">
        <label class="control-label col-sm-4" for="dateNotarized">
            <g:message code="txnRopaInstance.dateNotarized.label" default="Date Notarized" />     
        </label>
        <div class="col-sm-8"><g:customDatePicker name="dateNotarized" precision="day" class="form-control" format="MM/dd/yyyy" value="${loanInstance?.branch?.runDate}"/>

            <g:hasErrors bean="${txnRopaInstance}" field="dateNotarized">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnRopaInstance}" field="dateNotarized">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
    </div> 
     <div class="fieldcontain form-group ${hasErrors(bean: txnRopaInstance, field: 'dateConsolidated', 'has-error')} ">
        <label class="control-label col-sm-4" for="dateConsolidated">
            <g:message code="txnRopaInstance.dateConsolidated.label" default="Date Consolidated" />     
        </label>
        <div class="col-sm-8"><g:customDatePicker name="dateConsolidated" precision="day" class="form-control" format="MM/dd/yyyy" value="${loanInstance?.branch?.runDate}"/>

            <g:hasErrors bean="${txnRopaInstance}" field="dateConsolidated">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnRopaInstance}" field="dateConsolidated">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
    </div> 
     <div class="fieldcontain form-group ${hasErrors(bean: txnRopaInstance, field: 'expiryOfRedemption', 'has-error')} ">
        <label class="control-label col-sm-4" for="expiryOfRedemption">
            <g:message code="txnRopaInstance.expiryOfRedemption.label" default="Expiry of Redemption" />     
        </label>
        <div class="col-sm-8"><g:customDatePicker name="expiryOfRedemption" precision="day" class="form-control" format="MM/dd/yyyy" value="${loanInstance?.branch?.runDate}"/>

            <g:hasErrors bean="${txnRopaInstance}" field="expiryOfRedemption">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnRopaInstance}" field="expiryOfRedemption">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
    </div>     
    <div class="fieldcontain form-group ${hasErrors(bean: txnRopaInstance, field: 'particulars', 'has-error')} ">
	<label class="control-label col-sm-4" for="loan">
		<g:message code="particulars.label" default="Transaction Particulars" />
     
	</label>
	<div class="col-sm-7"><g:textArea name="particulars" value="${txnRopaInstance?.particulars}" rows="5" cols="50"/>        

            <g:hasErrors bean="${txnRopaInstance}" field="particulars">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${txnRopaInstance}" field="particulars">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
            </g:hasErrors>
        </div>
     </div>
 </div>
  
    </content>    
    <content tag="main-actions">
            <ul>
            <g:if test="${loanInstance?.status?.id == 5 || loanInstance?.status?.id == 4}"> 
                <li><g:form id="transfers" name="transfers" url="[controller:loan, action:'transferR', id:loanInstance.id]" method="POST"></g:form>
                    <g:actionSubmit id="transfer"action="transferR" value="Transfer Account to ROPA" onclick="
                        alertify.confirm(AppTitle,'Are you sure you want to continue Transfer to ROPA transaction?',
                                function(){
                                    checkIfAllowed('LON02001', 'form#transfers', 'Transfer to Ropa', null);
                                },
                                function(){
                                    return;
                                });                         
                        " />
                </li>
            </g:if>
                <li><g:link class="list" action="index" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">Cancel</g:link></li>
              </ul>
<!--            <script type="text/javascript">
                    $(document).ready(function() {
                           $( "#transfer" ).click(function() {
                              checkIfAllowed('LON02001', 'form#transfers', 'Amend holiday.', null); // params: policyTemplate.code, form to be saved
                           });
                    });
            </script>-->
    </content>
    </body>
</html>
