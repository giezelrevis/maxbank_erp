
<%@ page import="icbs.deposit.DepositTaxFeeAndChargeScheme" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'depositTaxFeeAndChargeScheme.label', default: 'DepositTaxFeeAndChargeScheme')}" />
		<title>Show Deposit Taxes/Fees and Charges Scheme</title>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/depositTaxFeeAndChargeScheme')}">Deposit Taxes/Fees and Charges Scheme</a>
                <span class="fa fa-chevron-right"></span><span class="current">Show Deposit Taxes/Fees and Charges Scheme</span>
            </content>
            <content tag="main-content">   
		<div id="show-depositTaxFeeAndChargeScheme" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
                            <div class="box-body">
                                <div class="alert alert-info alert-dismissable">
                                    <i class="fa fa-info"></i>
                                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                    <b>Message</b> <div class="message" role="status">${flash.message}</div>
                                </div>
                            </div>
			</g:if>
		<table class="table table-bordered table-rounded table-striped table-hover">
                    <tbody>
                        <g:if test="${depositTaxFeeAndChargeSchemeInstance?.code}">
                            <tr>
                                <td style="width:30%"><label><g:message code="depositTaxFeeAndChargeScheme.code.label" default="Code" /></label></td>
                                <td style="width:70%"><span class="property-value" aria-labelledby="code-label"><g:fieldValue bean="${depositTaxFeeAndChargeSchemeInstance}" field="code"/></span></td>
                            </tr>
			</g:if>
			<g:if test="${depositTaxFeeAndChargeSchemeInstance?.type}">
                            <tr>
                                <td style="width:30%"><label><g:message code="depositTaxFeeAndChargeScheme.type.label" default="Type" /></label></td>
                                <td style="width:70%"><span class="property-value" aria-labelledby="type-label">${depositTaxFeeAndChargeSchemeInstance?.type?.encodeAsHTML()}</span></td>
                            </tr>
			</g:if>
			<g:if test="${depositTaxFeeAndChargeSchemeInstance?.taxRate}">
                            <tr>
                                <td style="width:30%"><label><g:message code="depositTaxFeeAndChargeScheme.taxRate.label" default="Tax Rate" /></label></td>
                                <td style="width:70%"><span class="property-value" aria-labelledby="taxRate-label"><g:formatNumber format="#,##0.00" number="${depositTaxFeeAndChargeSchemeInstance?.taxRate}"/>%</span></td>
                            </tr>
                        </g:if>
			<g:if test="${depositTaxFeeAndChargeSchemeInstance?.feeRate}">
                            <tr>
                                <td style="width:30%"><label><g:message code="depositTaxFeeAndChargeScheme.feeRate.label" default="Fee Rate" /></label></td>
                                <td style="width:70%"><span class="property-value" aria-labelledby="feeRate-label"><g:formatNumber format="#,##0.00" number="${depositTaxFeeAndChargeSchemeInstance?.feeRate}"/>%</span></td>
                            </tr>
			</g:if>
			<g:if test="${depositTaxFeeAndChargeSchemeInstance?.feeAmt}">
                            <tr>
                                <td style="width:30%"><label><g:message code="depositTaxFeeAndChargeScheme.feeAmt.label" default="Fee Amt" /></label></td>
				<td style="width:70%"><span class="property-value" aria-labelledby="feeAmt-label"><g:formatNumber format="###,###,##0.00" number="${depositTaxFeeAndChargeSchemeInstance?.feeAmt}"/></span></td>
                            </tr>
			</g:if>
			<g:if test="${depositTaxFeeAndChargeSchemeInstance?.chargeRate}">
                            <tr>
                                <td style="width:30%"><label><g:message code="depositTaxFeeAndChargeScheme.chargeRate.label" default="Charge Rate" /></label></td>
                                <td style="width:70%"><span class="property-value" aria-labelledby="chargeRate-label"><g:formatNumber format="#,##0.00" number="${depositTaxFeeAndChargeSchemeInstance?.chargeRate}"/>%</span></td>
                            </tr>
			</g:if>
			<g:if test="${depositTaxFeeAndChargeSchemeInstance?.chargeAmt}">
                            <tr>
                                <td style="width:30%"><label><g:message code="depositTaxFeeAndChargeScheme.chargeAmt.label" default="Charge Amt" /></label></td>
                                <td style="width:70%"><span class="property-value" aria-labelledby="chargeAmt-label"><g:formatNumber format="###,###,##0.00" number="${depositTaxFeeAndChargeSchemeInstance?.chargeAmt}"/></span></td>
                            </tr>
			</g:if>
			<g:if test="${depositTaxFeeAndChargeSchemeInstance?.specialCalculation}">
                            <tr>
                                <td style="width:30%"><label><g:message code="depositTaxFeeAndChargeScheme.specialCalculation.label" default="Special Calculation" /></label></td>
                                <td style="width:70%"><span class="property-value" aria-labelledby="specialCalculation-label">${depositTaxFeeAndChargeSchemeInstance?.specialCalculation?.encodeAsHTML()}</span></td>
                            </tr>
                        </g:if>
			<g:if test="${depositTaxFeeAndChargeSchemeInstance?.feeBaseAmtCondition}">
                            <tr>
                                <td style="width:30%"><label><g:message code="depositTaxFeeAndChargeScheme.feeBaseAmtCondition.label" default="Fee Base Amt Condition" /></label></td>
                                <td style="width:70%"><span class="property-value" aria-labelledby="feeBaseAmtCondition-label"><g:formatBoolean boolean="${depositTaxFeeAndChargeSchemeInstance?.feeBaseAmtCondition}" /></span></td>
                            </tr>
			</g:if>
			<g:if test="${depositTaxFeeAndChargeSchemeInstance?.feeCountCondition}">
                            <tr>
                                <td style="width:30%"><label><g:message code="depositTaxFeeAndChargeScheme.feeCountCondition.label" default="Fee Count Condition" /></label></td>
                                <td style="width:70%"><span class="property-value" aria-labelledby="feeCountCondition-label"><g:formatBoolean boolean="${depositTaxFeeAndChargeSchemeInstance?.feeCountCondition}" /></span></td>
                            </tr>
			</g:if>
			<g:if test="${depositTaxFeeAndChargeSchemeInstance?.gracePeriod}">
                            <tr>
                                <td style="width:30%"><label><g:message code="depositTaxFeeAndChargeScheme.gracePeriod.label" default="Grace Period" /></label></td>
                                <td style="width:70%"><span class="property-value" aria-labelledby="gracePeriod-label"><g:fieldValue bean="${depositTaxFeeAndChargeSchemeInstance}" field="gracePeriod"/></span></td>
                            </tr>
			</g:if>
			<g:if test="${depositTaxFeeAndChargeSchemeInstance?.feeRateBasis}">
                            <tr>
                                <td style="width:30%"><label><g:message code="depositTaxFeeAndChargeScheme.feeRateBasis.label" default="Fee Rate Basis" /></label></td>
                                <td style="width:70%"><span class="property-value" aria-labelledby="feeRateBasis-label"><g:fieldValue bean="${depositTaxFeeAndChargeSchemeInstance}" field="feeRateBasis"/></span></td>
                            </tr>
			</g:if>
			<g:if test="${depositTaxFeeAndChargeSchemeInstance?.chargeRateBasis}">
                            <tr>
                                <td style="width:30%"><label><g:message code="depositTaxFeeAndChargeScheme.chargeRateBasis.label" default="Charge Rate Basis" /></label></td>
                                <td style="width:70%"><span class="property-value" aria-labelledby="chargeRateBasis-label"><g:fieldValue bean="${depositTaxFeeAndChargeSchemeInstance}" field="chargeRateBasis"/></span></td>
                            </tr>
			</g:if>
			<g:if test="${depositTaxFeeAndChargeSchemeInstance?.isApplyToClosingBal}">
                            <tr>
                                <td style="width:30%"><label><g:message code="depositTaxFeeAndChargeScheme.isApplyToClosingBal.label" default="Is Apply To Closing Bal" /></label></td>
                                <td style="width:70%"><span class="property-value" aria-labelledby="isApplyToClosingBal-label"><g:formatBoolean boolean="${depositTaxFeeAndChargeSchemeInstance?.isApplyToClosingBal}" /></span></td>
                            </tr>
			</g:if>
			<g:if test="${depositTaxFeeAndChargeSchemeInstance?.minAmtException}">
                            <tr>
                                <td style="width:30%"><label><g:message code="depositTaxFeeAndChargeScheme.minAmtException.label" default="Min Amt Exception" /></label></td>
                                <td style="width:70%"><span class="property-value" aria-labelledby="minAmtException-label"><g:fieldValue bean="${depositTaxFeeAndChargeSchemeInstance}" field="minAmtException"/></span></td>
                            </tr>
			</g:if>
			<g:if test="${depositTaxFeeAndChargeSchemeInstance?.description}">
                            <tr>
                                <td style="width:30%"><label><g:message code="depositTaxFeeAndChargeScheme.description.label" default="Description" /></label></td>
                                <td style="width:70%"><span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${depositTaxFeeAndChargeSchemeInstance}" field="description"/></span></td>
                            </tr>
			</g:if>
                    </tbody>
                </table>	
            </div>
            </content>
             <content tag="main-actions">
                <ul>
                    <li><g:link class="list" action="index">Deposit Taxes/Fees and Charges Scheme List</g:link></li>
                    <li><g:link class="create" action="create">New Deposit Taxes/Fees and Charges Scheme</g:link></li>
                    <li><button disabled="disabled">View Deposit Tax/Charges and Fees Scheme </button></li>
                    <li><g:link action="edit" id="${depositTaxFeeAndChargeSchemeInstance.id}">Update Deposit Taxes/Fees and Charges Scheme</g:link></li>                    
	       	</ul>
            </content>
	</body>
</html>
