
<%@ page import="icbs.admin.TxnTemplate" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'txnTemplate.label', default: 'TxnTemplate')}" />
		<title>Transaction Template Information</title>
	</head>
	<body>
	<content tag="breadcrumbs">
            <span class="fa fa-chevron-right"></span><a href="${createLink(uri:'/txnTemplate')}">Transction Template List</a>
            <span class="fa fa-chevron-right"></span><span class="current">Transaction Template Information</span>
	</content>
    <content tag="main-content">   
		<div id="show-txnTemplate" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>

			<div class="nav-tab-container">
              <ul class="nav nav-tabs">
                <li class="active"><a href="#tab_1" data-toggle="tab">Transaction Template Details</a></li>
                <li><a href="#tab_2" data-toggle="tab">Charges</a></li>
              </ul>
            </div>

            <div class="tab-content">
            	<div class="tab-pane active fade in" id="tab_1">
                    <table class="table table-bordered table-rounded table-striped table-hover">
                        <tbody>
                            <g:if test="${txnTemplateInstance?.txnModule}">
                                <tr>
                                    <td style="width:30%"><label><g:message code="txnTemplate.txnModule.label" default="Txn Module" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="txnModule-label">${txnTemplateInstance?.txnModule?.description}</span></td>
				</tr>
                            </g:if>
                            <g:if test="${txnTemplateInstance?.txnType}">
				<tr>
                                    <td style="width:30%"><label><g:message code="txnTemplate.txnType.label" default="Txn Type" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="txnType-label">${txnTemplateInstance?.txnType?.description}</span></td>
				</tr>
                            </g:if>
                            <g:if test="${txnTemplateInstance?.code}">
				<tr>
                                    <td style="width:30%"><label><g:message code="txnTemplate.code.label" default="Code" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="code-label"><g:fieldValue bean="${txnTemplateInstance}" field="code"/></span></td>
				</tr>
                            </g:if>
                            <g:if test="${txnTemplateInstance?.description}">
				<tr>
						<td style="width:30%"><label><g:message code="txnTemplate.description.label" default="Description" /></label></td>
						<td style="width:70%"><span class="property-value" aria-labelledby="descriptio<span n-label"><g:fieldValue bean="${txnTemplateInstance}" field="description"/></span></td>
						</tr>
						</g:if>
                                                <g:if test="${txnTemplateInstance?.shortDescription}">
						<tr>
                                                    <td style="width:30%"><label><g:message code="txnTemplate.shortDescription.label" default="Short Description" /></label></td>
                                                    <td style="width:70%"><span class="property-value" aria-labelledby="shortDescription-label"><g:fieldValue bean="${txnTemplateInstance}" field="shortDescription"/></span></td>
						</tr>
						</g:if>
                                                <g:if test="${txnTemplateInstance?.minAmt}">
						<tr>
                                                    <td style="width:30%"><label><g:message code="txnTemplate.minAmt.label" default="Min Amt" /></label></td>
                                                    <td style="width:70%"><span class="property-value" aria-labelledby="minAmt-label"><g:fieldValue bean="${txnTemplateInstance}" field="minAmt"/></span></td>
						</tr>
						</g:if>
                                                <g:if test="${txnTemplateInstance?.maxAmt}">
						<tr>
                                                    <td style="width:30%"><label><g:message code="txnTemplate.maxAmt.label" default="Max Amt" /></label></td>
                                                    <td style="width:70%"><span class="property-value" aria-labelledby="maxAmt-label"><g:fieldValue bean="${txnTemplateInstance}" field="maxAmt"/></span></td>
						</tr>
						</g:if>
                                                <g:if test="${txnTemplateInstance?.amlaCode}">
						<tr>
                                                    <td style="width:30%"><label><g:message code="txnTemplate.amlaCode.label" default="Amla Code" /></label></td>
                                                    <td style="width:70%"><span class="property-value" aria-labelledby="amlaCode-label"><g:fieldValue bean="${txnTemplateInstance}" field="amlaCode"/></span></td>
						</tr>
						</g:if>
                                                <g:if test="${txnTemplateInstance?.requireTxnDescription}">
						<tr>
                                                    <td style="width:30%"><label><g:message code="txnTemplate.requireTxnDescription.label" default="Require Txn Description" /></label></td>
                                                    <td style="width:70%"><span class="property-value" aria-labelledby="requireTxnDescription-label"><g:formatBoolean boolean="${txnTemplateInstance?.requireTxnDescription}" true="Yes" false="No" /></span></td>
						</tr>
						</g:if>
                                                <g:if test="${txnTemplateInstance?.requireTxnReference}">
						<tr>
                                                    <td style="width:30%"><label><g:message code="txnTemplate.requireTxnReference.label" default="Require Txn Reference" /></label></td>
                                                    <td style="width:70%"><span class="property-value" aria-labelledby="requireTxnReference-label"><g:formatBoolean boolean="${txnTemplateInstance?.requireTxnReference}" true="Yes" false="No" /></span></td>
						</tr>
						</g:if>
                                                <g:if test="${txnTemplateInstance?.validationCopyNo}">
						<tr>
                                                    <td style="width:30%"><label><g:message code="txnTemplate.validationCopyNo.label" default="Validation Copy No" /></label></td>
                                                    <td style="width:70%"><span class="property-value" aria-labelledby="validationCopyNo-label"><g:fieldValue bean="${txnTemplateInstance}" field="validationCopyNo"/></span></td>
						</tr>
						</g:if>
                                                <g:if test="${txnTemplateInstance?.validationFormCode}">
						<tr>
                                                    <td style="width:30%"><label><g:message code="txnTemppan id="validationFormCode-label" clate.validationFormCode.label" default="Validation Form Code" /></label></td>
                                                    <td style="width:70%"><span class="property-value" aria-labelledby="validationFormCode-label"><g:fieldValue bean="${txnTemplateInstance}" field="validationFormCode"/></span></td>
						</tr>
						</g:if>
                                                <g:if test="${txnTemplateInstance?.currency}">
						<tr>
                                                    <td style="width:30%"><label><g:message code="txnTemplate.currency.label" default="Currency" /></label></td>
                                                    <td style="width:70%"><span class="property-value" aria-labelledby="currency-label"><g:link controller="currency" action="show" id="${txnTemplateInstance?.currency?.id}">${txnTemplateInstance?.currency?.name}</g:link></span></td>
						</tr>
						</g:if>
                                                <g:if test="${txnTemplateInstance?.requirePassbook}">
						<tr>
                                                    <td style="width:30%"><label><g:message code="txnTemplate.requirePassbook.label" default="Require Passbook" /></label></td>
                                                    <td style="width:70%"><span class="property-value" aria-labelledby="requirePassbook-label">${txnTemplateInstance?.requirePassbook?.description}</span></td>
						</tr>
						</g:if>
					
						<g:if test="${txnTemplateInstance?.atmOnlyTxn}">
						<tr>
                                                    <td style="width:30%"><label><g:message code="txnTemplate.atmOnlyTxn.label" default="Atm Only Txn" /></label></td>
                                                    <td style="width:70%"><span class="property-value" aria-labelledby="atmOnlyTxn-label">${txnTemplateInstance?.atmOnlyTxn?.description}</span></td>
						</tr>
						</g:if>
					
						<g:if test="${txnTemplateInstance?.interbranchTxn}">
						<tr>
                                                    <td style="width:30%"><label><g:message code="txnTemplate.interbranchTxn.label" default="Interbranch Txn" /></label></td>
                                                    <td style="width:70%"><span class="property-value" aria-labelledby="interbranchTxn-label">${txnTemplateInstance?.interbranchTxn?.description}</span></td>
						</tr>
						</g:if>
					
						<g:if test="${txnTemplateInstance?.systemOnlyTxn}">
						<tr>
                                                    <td style="width:30%"><label><g:message code="txnTemplate.systemOnlyTxn.label" default="System Only Txn" /></label></td>
                                                    <td style="width:70%"><span class="property-value" aria-labelledby="systemOnlyTxn-label"><g:formatBoolean boolean="${txnTemplateInstance?.systemOnlyTxn}" /></span></td>
						</tr>
						</g:if>
					
						<g:if test="${txnTemplateInstance?.memoTxnType}">
						<tr>
                                                    <td style="width:30%"><label><g:message code="txnTemplate.memoTxnType.label" default="Memo Txn Type" /></label></td>
                                                    <td style="width:70%"><span class="property-value" aria-labelledby="memoTxnType-label">${txnTemplateInstance?.memoTxnType?.description}</span></td>
						</tr>
						</g:if>
					
						<g:if test="${txnTemplateInstance?.batchTxn}">
						<tr>
                                                    <td style="width:30%"><label><g:message code="txnTemplate.batchTxn.label" default="Batch Txn" /></label></td>
                                                    <td style="width:70%"><span class="property-value" aria-labelledby="batchTxn-label">${txnTemplateInstance?.batchTxn?.description}</span></td>
						</tr>	
						</g:if>
					
						<g:if test="${txnTemplateInstance?.configItemStatus}">
						<tr>
                                                    <td style="width:30%"><label><g:message code="txnTemplate.configItemStatus.label" default="Config Item Status" /></label></td>
                                                    <td style="width:70%"><span class="property-value" aria-labelledby="configItemStatus-label">${txnTemplateInstance?.configItemStatus?.description}</span></td>
						</tr>
						</g:if>
                                            </tbody>
                                        </table>
				</div>

				<div class="tab-pane fade in" id="tab_2">
                                <table class="table table-bordered table-rounded table-striped table-hover">
                                    <tbody>
                                        <g:each in="${txnTemplateInstance.charges}" var="charge" >
                                            <tr>
                                                <td>${charge.description}</td>
                                            </tr>
                                          </g:each>
                                    </tbody>
                                </table>
                                </div>
                        </div>

			<g:form url="[resource:txnTemplateInstance, action:'delete']" method="DELETE">
			</g:form>
		</div>
    </content>
    <content tag="main-actions">
        <ul>
           <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
           <li><g:link class="edit" action="updateTxnTemplate" id="${txnTemplateInstance?.id}"> Edit</g:link></li>
           <li><g:link action="create">Create new Transaction Template</g:link></li>
           <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
            
	</ul>
    </content>
	</body>
</html>
