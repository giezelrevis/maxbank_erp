
<%@ page import="icbs.loans.LoanConfigSettings" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loanConfigSettings.label', default: 'LoanConfigSettings')}" />
		<title>Loan Configuration Settings</title>
	</head>
	<body>
		<content tag="main-content">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ul class="property-list loanConfigSettings">			
				<li class="fieldcontain">
					<span id="interestDecimalPlaces-label" class="property-label"><g:message code="loanConfigSettings.interestDecimalPlaces.label" default="Interest Decimal Places" /></span>
					
					<span class="property-value" aria-labelledby="interestDecimalPlaces-label"><g:fieldValue bean="${loanConfigSettings}" field="interestDecimalPlaces"/></span>					
				</li>

				<li class="fieldcontain">
					<span id="penaltyDecimalPlaces-label" class="property-label"><g:message code="loanConfigSettings.penaltyDecimalPlaces.label" default="Penalty Decimal Places" /></span>
					
					<span class="property-value" aria-labelledby="penaltyDecimalPlaces-label"><g:fieldValue bean="${loanConfigSettings}" field="penaltyDecimalPlaces"/></span>
				</li>

				<li class="fieldcontain">
					<span id="taxDecimalPlaces-label" class="property-label"><g:message code="loanConfigSettings.taxDecimalPlaces.label" default="Tax Decimal Places" /></span>
					
					<span class="property-value" aria-labelledby="taxDecimalPlaces-label"><g:fieldValue bean="${loanConfigSettings}" field="taxDecimalPlaces"/></span>
				</li>

				<li class="fieldcontain">
					<span id="hasApplicationProcessing-label" class="property-label"><g:message code="loanConfigSettings.hasApplicationProcessing.label" default="Activate Loan Application Processing" /></span>
					
					<span class="property-value" aria-labelledby="hasApplicationProcessing-label"><g:formatBoolean boolean="${loanConfigSettings?.hasApplicationProcessing}" /></span>
				</li>

				<li class="fieldcontain">
					<span id="applicationRegistrationKey-label" class="property-label"><g:message code="loanConfigSettings.applicationRegistrationKey.label" default="Loan Application Registration Key" /></span>
					
					<span class="property-value" aria-labelledby="applicationRegistrationKey-label"><g:fieldValue bean="${loanConfigSettings}" field="applicationRegistrationKey"/></span>
				</li>

				<li class="fieldcontain">
					<span id="applicationLicenseKey-label" class="property-label"><g:message code="loanConfigSettings.applicationLicenseKey.label" default="Loan Application License Key" /></span>
					
					<span class="property-value" aria-labelledby="applicationLicenseKey-label"><g:fieldValue bean="${loanConfigSettings}" field="applicationLicenseKey"/></span>
				</li>

				<li class="fieldcontain">
					<span id="hasRemediationProcessing-label" class="property-label"><g:message code="loanConfigSettings.hasRemediationProcessing.label" default="Activate Loan Remediation Processing" /></span>
					
					<span class="property-value" aria-labelledby="hasRemediationProcessing-label"><g:formatBoolean boolean="${loanConfigSettings?.hasRemediationProcessing}" /></span>
				</li>

				<li class="fieldcontain">
					<span id="remediationRegistrationKey-label" class="property-label"><g:message code="loanConfigSettings.remediationRegistrationKey.label" default="Loan Remediation Registration Key" /></span>
					
					<span class="property-value" aria-labelledby="remediationRegistrationKey-label"><g:fieldValue bean="${loanConfigSettings}" field="remediationRegistrationKey"/></span>
				</li>

				<li class="fieldcontain">
					<span id="remediationLicenseKey-label" class="property-label"><g:message code="loanConfigSettings.remediationLicenseKey.label" default="Loan Remediation License Key" /></span>
					
					<span class="property-value" aria-labelledby="remediationLicenseKey-label"><g:fieldValue bean="${loanConfigSettings}" field="remediationLicenseKey"/></span>
				</li>
			</ul>			
			<fieldset class="buttons">
				<g:link class="btn btn-primary edit" action="edit">Edit</g:link>
			</fieldset>
		</content>
	</body>
</html>
