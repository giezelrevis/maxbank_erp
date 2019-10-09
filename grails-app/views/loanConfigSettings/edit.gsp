<%@ page import="icbs.loans.LoanConfigSettings" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loanConfigSettings.label', default: 'LoanConfigSettings')}" />
		<title>Update Loan Configuration Settings</title>
	</head>
	<body>
		<content tag="main-content">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${loanConfigSettings}">
			<ul class="errors" role="alert">
				<g:eachError bean="${loanConfigSettings}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form action="update" method="PUT" >
				<fieldset class="form">
					<div class="form-group fieldcontain ${hasErrors(bean: loanConfigSettings, field: 'interestDecimalPlaces', 'error')} required">
						<label class="control-label col-sm-3" for="interestDecimalPlaces">
							<g:message code="loanConfigSettings.interestDecimalPlaces.label" default="Interest Decimal Places" />
							<span class="required-indicator">*</span>
						</label>
						<g:field class="form-control" name="interestDecimalPlaces" type="number" value="${loanConfigSettings.interestDecimalPlaces}" required=""/>
					</div>

					<div class="form-group fieldcontain ${hasErrors(bean: loanConfigSettings, field: 'penaltyDecimalPlaces', 'error')} required">
						<label class="control-label col-sm-3" for="penaltyDecimalPlaces">
							<g:message code="loanConfigSettings.penaltyDecimalPlaces.label" default="Penalty Decimal Places" />
							<span class="required-indicator">*</span>
						</label>
						<g:field class="form-control" name="penaltyDecimalPlaces" type="number" value="${loanConfigSettings.penaltyDecimalPlaces}" required=""/>
					</div>

					<div class="form-group fieldcontain ${hasErrors(bean: loanConfigSettings, field: 'taxDecimalPlaces', 'error')} required">
						<label class="control-label col-sm-3" for="taxDecimalPlaces">
							<g:message code="loanConfigSettings.taxDecimalPlaces.label" default="Tax Decimal Places" />
							<span class="required-indicator">*</span>
						</label>
						<g:field class="form-control" name="taxDecimalPlaces" type="number" value="${loanConfigSettings.taxDecimalPlaces}" required=""/>
					</div>
					
					<div class="form-group fieldcontain ${hasErrors(bean: loanConfigSettings, field: 'hasApplicationProcessing', 'error')} ">
						<label class="control-label col-sm-3" for="hasApplicationProcessing">
							<g:message code="loanConfigSettings.hasApplicationProcessing.label" default="Activate Loan Application Processing" />
							
						</label>
						<g:checkBox class="form-control" name="hasApplicationProcessing" value="${loanConfigSettings?.hasApplicationProcessing}" />
					</div>

					<div class="form-group fieldcontain ${hasErrors(bean: loanConfigSettings, field: 'applicationRegistrationKey', 'error')} required">
						<label class="control-label col-sm-3" for="applicationRegistrationKey">
							<g:message code="loanConfigSettings.applicationRegistrationKey.label" default="Loan Application Registration Key" />
							<span class="required-indicator">*</span>
						</label>
						<g:textField class="form-control" name="applicationRegistrationKey" maxlength="10" required="" value="${loanConfigSettings?.applicationRegistrationKey}"/>
					</div>

					<div class="form-group fieldcontain ${hasErrors(bean: loanConfigSettings, field: 'applicationLicenseKey', 'error')} required">
						<label class="control-label col-sm-3" for="applicationLicenseKey">
							<g:message code="loanConfigSettings.applicationLicenseKey.label" default="Loan Application License Key" />
							<span class="required-indicator">*</span>
						</label>
						<g:textField class="form-control" name="applicationLicenseKey" maxlength="10" required="" value="${loanConfigSettings?.applicationLicenseKey}"/>
					</div>

					<div class="form-group fieldcontain ${hasErrors(bean: loanConfigSettings, field: 'hasRemediationProcessing', 'error')} ">
						<label class="control-label col-sm-3" for="hasRemediationProcessing">
							<g:message code="loanConfigSettings.hasRemediationProcessing.label" default="Activate Loan Remediation Processing" />
							
						</label>
						<g:checkBox class="form-control" name="hasRemediationProcessing" value="${loanConfigSettings?.hasRemediationProcessing}" />
					</div>

					<div class="form-group fieldcontain ${hasErrors(bean: loanConfigSettings, field: 'remediationRegistrationKey', 'error')} required">
						<label class="control-label col-sm-3" for="remediationRegistrationKey">
							<g:message code="loanConfigSettings.remediationRegistrationKey.label" default="Loan Remediation Registration Key" />
							<span class="required-indicator">*</span>
						</label>
						<g:textField class="form-control" name="remediationRegistrationKey" maxlength="10" required="" value="${loanConfigSettings?.remediationRegistrationKey}"/>
					</div>

					<div class="form-group fieldcontain ${hasErrors(bean: loanConfigSettings, field: 'remediationLicenseKey', 'error')} required">
						<label class="control-label col-sm-3" for="remediationLicenseKey">
							<g:message code="loanConfigSettings.remediationLicenseKey.label" default="Loan Remediation License Key" />
							<span class="required-indicator">*</span>
						</label>
						<g:textField class="form-control" name="remediationLicenseKey" maxlength="10" required="" value="${loanConfigSettings?.remediationLicenseKey}"/>
					</div>

					<g:hiddenField name="update" value="true" />
				</fieldset>
				<fieldset class="buttons">
					<g:actionSubmit class="btn btn-primary save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</fieldset>
			</g:form>
		</content>
	</body>
</html>
