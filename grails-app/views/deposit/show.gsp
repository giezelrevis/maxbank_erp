
<%@ page import="icbs.deposit.Deposit" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'deposit.label', default: 'Deposit')}" />
		<title>Deposit Account Number: ${depositInstance?.acctNo}</title>
	</head>
	<body>
            <content tag="main-content">   
		<div id="show-deposit" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
                            <!-- <div class="message" role="status">${flash.message}</div> -->
                            <script>
                                $(function(){
                                    var x = '${flash.message}';
                                        notify.message(x);
                                });
                            </script>
			</g:if>
			<ol class="property-list deposit">
                                <div class="row">
    <div class="col-xs-12 col-sm-12">
      <div class="section-container">
        <fieldset>
            <legend class="section-header">Deposit Account Information</legend>
            <div class="infowrap">
                 <div class="col-xs-3 col-sm-3">
                    <div ><g:if test="${(depositInstance?.customer?.attachments?.find{it.isPrimaryPhoto==true})?.id}"> <img width="160px" height="160px"src="${createLink(controller:'Attachment', action:'show', id: (depositInstance?.customer?.attachments?.find{it.isPrimaryPhoto==true})?.id )}"/></g:if></div>
                 </div>
                <div class="col-xs-9 col-sm-9">
                        <h3 style="font-weight:bold;">${depositInstance?.acctName}</h3>
                        <p><i>(Last Name, First Name, Middle Name)</i></p>
                        </br>
                        <dl class="dl-horizontal">
                            <dt>Customer ID</dt>
                            <dd><g:link controller="customer" action="customerInquiry" id="${depositInstance?.customer?.id}">${depositInstance?.customer?.customerId}</g:link></dd>
                        </dl>
                        <dl class="dl-horizontal">
                            <dt>Branch</dt>
                            <dd><g:link controller="branch" action="show" id="${depositInstance?.branch?.id}">${depositInstance?.branch?.name.encodeAsHTML()}</g:link></dd>
                        </dl>
                        <dl class="dl-horizontal">
                            <dt>Deposit Type</dt>
                            <dd><g:link controller="depositType" action="show" id="${depositInstance?.type?.id}">${depositInstance?.type?.encodeAsHTML()}</g:link></dd>
                        </dl>
                        <dl class="dl-horizontal">
                            <dt>Account Number</dt>
                            <dd><g:fieldValue bean="${depositInstance}" field="acctNo"/></dd>
                        </dl>
                       <g:if test="${depositInstance?.acctNoFormat}">
                            <dl class="dl-horizontal">
                                <dt>Acct No Format</dt>
                                <dd><g:link controller="acctNoFormat" action="show" id="${depositInstance?.acctNoFormat?.id}">${depositInstance?.acctNoFormat?.encodeAsHTML()}</g:link></dd>
                            </dl> 
                        </g:if>
                        <g:if test="${depositInstance?.ownershipType}">
                            <dl class="dl-horizontal">
                                <dt>Ownership Type</dt>
                                <dd><g:link controller="ownershipType" action="show" id="${depositInstance?.ownershipType?.id}">${depositInstance?.ownershipType?.encodeAsHTML()}</g:link></dd>
                            </dl> 
                        </g:if>
                        <g:if test="${depositInstance?.sigRules}">
                            <dl class="dl-horizontal">
                                <dt>Sig Rules</dt>
                                <dd><g:fieldValue bean="${depositInstance}" field="sigRules"/></dd>
                            </dl> 
                        </g:if>
                        <g:if test="${depositInstance?.sigRemarks}">
                            <dl class="dl-horizontal">
                                <dt>Sig Remarks</dt>
                                <dd><g:fieldValue bean="${depositInstance}" field="sigRemarks"/></dd>
                            </dl> 
                        </g:if>      
                        <g:if test="${depositInstance?.signatories}">
                            <dl class="dl-horizontal">
                                <dt>Signatories</dt>
                                <g:each in="${depositInstance.signatories}" var="s">
                                    <dd><span class="property-value" aria-labelledby="signatories-label"><g:link controller="signatory" action="show" id="${s.id}">${s.id}</g:link></span></dd>
                                </g:each>
                            </dl> 
                        </g:if>
                        <g:if test="${depositInstance?.depositInterestScheme}">
                            <dl class="dl-horizontal">
                                <dt>Deposit Interest Scheme</dt>
                                <dd><g:link controller="depositInterestScheme" action="show" id="${depositInstance?.depositInterestScheme?.id}">${depositInstance?.depositInterestScheme?.encodeAsHTML()}</g:link></dd>
                            </dl> 
                        </g:if>
                        <g:if test="${depositInstance?.depositTaxChargeScheme}">
                            <dl class="dl-horizontal">
                                <dt><label>Dep Tax Charge Scheme</label></dt>
                                <dd><g:link controller="depositTaxFeeAndChargeScheme" action="show" id="${depositInstance?.depositTaxChargeScheme?.id}">${depositInstance?.depositTaxChargeScheme?.encodeAsHTML()}</g:link></dd>
                            </dl> 
                        </g:if>
                        <g:if test="${depositInstance?.fixedDepositPreTermScheme}">
                            <dl class="dl-horizontal">
                                <dt><label>FD Pre Term Scheme</label></dt>
                                <dd><g:link controller="fixedDepositPreTermScheme" action="show" id="${depositInstance?.fixedDepositPreTermScheme?.id}">${depositInstance?.fixedDepositPreTermScheme?.encodeAsHTML()}</g:link></dd>
                            </dl> 
                        </g:if>
                        <g:if test="${depositInstance?.dateOpened}">
                            <dl class="dl-horizontal">
                                <dt><label>Date Opened</label></dt>
                                <dd><g:formatDate format="MM/dd/yyyy" date="${depositInstance?.dateOpened}" /></dd>
                            </dl> 
                        </g:if>
                        <g:if test="${depositInstance?.dateClosed}">
                            <dl class="dl-horizontal">
                                <dt><label>Date Closed</label></dt>
                                <dd><g:formatDate format="MM/dd/yyyy" date="${depositInstance?.dateClosed}" /></dd>
                            </dl> 
                        </g:if>
                        <g:if test="${depositInstance?.status}">
                            <dl class="dl-horizontal">
                                <dt><label>Deposit Status</label></dt>
                                <dd><g:link controller="depositStatus" action="show" id="${depositInstance?.status?.id}">${depositInstance?.status?.encodeAsHTML()}</g:link></dd>
                            </dl>
                        </g:if>
                        <g:if test="${depositInstance?.statusChangeDate}">
                            <dl class="dl-horizontal">
                                <dt><label>Status Change Date</label></dt>
                                <dd><g:formatDate format="MM/dd/yyyy" date="${depositInstance?.statusChangeDate}" /></dd>
                            </dl>
                        </g:if>
                        <g:if test="${depositInstance?.ledgerBalAmt}">
                             <dl class="dl-horizontal">
                                <dt><label>Ledger Bal Amt</label></dt>
                                <dd><g:fieldValue bean="${depositInstance}" field="ledgerBalAmt"/></dd>
                            </dl>
                        </g:if>
                        <g:if test="${depositInstance?.availableBalAmt}">
                            <dl class="dl-horizontal">
                                <dt><label>Available Bal Amt</label></dt>
                                <dd><g:formatNumber format="###,###,##0.00" number="${depositInstance?.availableBalAmt}"/></dd>
                            </dl>
                        </g:if> 
                        <g:if test="${depositInstance?.passbookBalAmt}">
                            <dl class="dl-horizontal">
                                <dt><label>Passbook Bal Amt</label></dt>
                                <dd><g:formatNumber format="###,###,##0.00" number="${depositInstance?.passbookBalAmt}"/></dd>
                            </dl>
                        </g:if>
                        <g:if test="${depositInstance?.interestBalAmt}">
                            <dl class="dl-horizontal">
                                <dt><label>Interest Bal Amt</label></dt>
                                <dd><g:formatNumber format="###,###,##0.00" number="${depositInstance?.interestBalAmt}"/></dd>
                            </dl>
                        </g:if>
                        <g:if test="${depositInstance?.lmAveBalAmt}">
                            <dl class="dl-horizontal">
                                <dt><label>Lm Ave Bal Amt</label></dt>
                                <dd><g:formatNumber format="###,###,##0.00" number="${depositInstance?.lmAveBalAmt}"/></dd>
                            </dl>
                        </g:if>
                        <g:if test="${depositInstance?.interestRate}">
                            <dl class="dl-horizontal">
                                <dt><label>Interest Rate</label></dt>
                                <dd><g:formatNumber format="#,##0.00" number="${depositInstance?.interestRate}"/>%</dd>
                            </dl>
                        </g:if>
                        <g:if test="${depositInstance?.acrintAmt}">
                            <dl class="dl-horizontal">
                                <dt><label>Acrint Amt</label></dt>
                                <dd><g:formatNumber format="###,###,##0.00" number="${depositInstance?.acrintAmt}"/></dd>
                            </dl>
                        </g:if>
                        <g:if test="${depositInstance?.acrintDate}">
                            <dl class="dl-horizontal">
                                <dt><label>Acrint Date</label></dt>
                                <dd><g:formatDate date="${depositInstance?.acrintDate}" /></dd>
                            </dl>
                        </g:if>
                        <g:if test="${depositInstance?.debitAcrintAmt}">
                            <dl class="dl-horizontal">
                                <dt><label>Debit Acrint Amt</label></dt>
                                <dd><g:fieldValue bean="${depositInstance}" field="debitAcrintAmt"/></dd>
                            </dl>
                        </g:if>
                        <g:if test="${depositInstance?.debitAcrintDate}">
                            <dl class="dl-horizontal">
                                <dt><label>Debit Acrint Date</label></dt>
                                <dd><g:formatDate format="MM/dd/yyyy" date="${depositInstance?.debitAcrintDate}" /></dd>
                            </dl>
                        </g:if>
                        <g:if test="${depositInstance?.passbooks}">
                            
                            <dl class="dl-horizontal">
                                <dt><label>Passbooks</label></dt>
                                <g:each in="${depositInstance.passbooks}" var="p">
                                <dd><g:link controller="passbook" action="show" id="${p.id}">${s?.encodeAsHTML()}</g:link></dd>
                                </g:each>
                            </dl>
                        </g:if>
                        <g:if test="${depositInstance?.txnWithdrawalsCounterMonthly}">
                            <dl class="dl-horizontal">
                                <dt><label>Txn Withdrawals Counter Monthly</label></dt>
                                <dd><g:fieldValue bean="${depositInstance}" field="txnWithdrawalsCounterMonthly"/></dd>
                            </dl>
                        </g:if>
                        <g:if test="${depositInstance?.txnWithdrawalsCounterCummulative}">
                            <dl class="dl-horizontal">
                                <dt><label>Txn Withdrawals Counter Cummulative</label></dt>
                                <dd><g:fieldValue bean="${depositInstance}" field="txnWithdrawalsCounterCummulative"/></dd>
                            </dl>
                        </g:if>
                        <g:if test="${depositInstance?.lastCapitalizationDate}">
                            <dl class="dl-horizontal">
                                <dt><label>Last Capitalization Date</label></dt>
                                <dd><g:formatDate format="MM/dd/yyyy" date="${depositInstance?.lastCapitalizationDate}" /></dd>
                            </dl>
                        </g:if> 
                        <g:if test="${depositInstance?.currency}">
                            <dl class="dl-horizontal">
                                <dt><label>Currency</label></dt>
                                <dd><g:fieldValue bean="${depositInstance}" field="currency"/></dd>
                            </dl>
                        </g:if>
                        <g:if test="${depositInstance?.isSweep}">
                            <dl class="dl-horizontal">
                                <dt><label>Is Sweep</label></dt>
                                <dd><g:formatBoolean boolean="${depositInstance?.isSweep}" /></dd>
                            </dl>
                        </g:if> 
                        <g:if test="${depositInstance?.txnDepCounterCummulative}">
                            <dl class="dl-horizontal">
                                <dt><label>Txn Dep Counter Cummulative</label></dt>
                                <dd><g:fieldValue bean="${depositInstance}" field="txnDepCounterCummulative"/></dd>
                            </dl>
                        </g:if>
                        <g:if test="${depositInstance?.txnDepCounterMonthly}">
                            <dl class="dl-horizontal">
                                <dt><label>Txn Dep Counter Monthly</label></dt>
                                <dd><g:fieldValue bean="${depositInstance}" field="txnDepCounterMonthly"/></dd>
                            </dl>
                        </g:if>    
                </div>
            </div>    
        </fieldset>
      </div><!-- end section-container-->
    </div> 
</div>


			</ol>
                        <!--
			<g:form url="[resource:depositInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${depositInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
                        </-->
		</div>
            </content>
             <content tag="main-actions">
                 <ul>
                    <li><g:link  action="depositInquiry" id="${depositInstance.id}" resource="${depositInstance}">Proceed to Deposit Inquiry</g:link><li>
                    <li><g:link class="edit" action="edit" resource="${depositInstance}"><g:message code="default.button.edit.label" default="Edit" /> this Deposit Account</g:link></li>
                </ul>
            </content>
	</body>
</html>
