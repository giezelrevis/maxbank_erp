<%@ page import="icbs.admin.GlConfigSettings" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'glConfigSettings.label', default: 'LoanConfigSettings')}" />
		<title>Update GL Configuration Settings</title>
	</head>
	<body>
		<content tag="main-content">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${glConfigSettings}">
			<ul class="errors" role="alert">
				<g:eachError bean="${glConfigSettings}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form action="update" method="PUT" >
				<fieldset class="form">

					<div class="form-group fieldcontain ${hasErrors(bean: glConfigSettings, field: 'currency', 'error')} required">
						<label class="control-label col-sm-3" for="currency">
							<g:message code="glConfigSettings.currency.label" default="Currency:" />
							<span class="required-indicator">*</span>
						</label>
						<g:field class="form-control" name="currency" value="${glConfigSettings.currency	}" required=""/>
					</div>

					<div class="form-group fieldcontain ${hasErrors(bean: glConfigSettings, field: 'taxMonthEnd', 'error')} required">
						<label class="control-label col-sm-3" for="taxMonthEnd">
							<g:message code="glConfigSettings.taxMonthEnd.label" default="Tax Month End:" />
							<span class="required-indicator">*</span>
						</label>
						<g:field class="form-control" name="taxMonthEnd" type="number" value="${glConfigSettings.taxMonthEnd}" required=""/>
					</div>

					<div class="form-group fieldcontain ${hasErrors(bean: glConfigSettings, field: 'glSortCodeMask', 'error')} required">
						<label class="control-label col-sm-3" for="glSortCodeMask">
							<g:message code="glConfigSettings.glSortCodeMask.label" default="GL Sort Code Mask:" />
							<span class="required-indicator">*</span>
						</label>
						<g:field class="form-control" name="glSortCodeMask" value="${glConfigSettings.glSortCodeMask}" required=""/>
					</div>

					<div class="form-group fieldcontain ${hasErrors(bean: glConfigSettings, field: 'glAccountCodeMask', 'error')} required">
						<label class="control-label col-sm-3" for="glAccountCodeMask">
							<g:message code="glConfigSettings.glAccountCodeMask.label" default="Account Sort Code Mask:" />
							<span class="required-indicator">*</span>
						</label>
						<g:field class="form-control" name="glAccountCodeMask" value="${glConfigSettings.glAccountCodeMask}" required=""/>
					</div>

					<div class="form-group fieldcontain ${hasErrors(bean: glConfigSettings, field: 'revaluationPolicy', 'error')} required">
						<label class="control-label col-sm-3" for="revaluationPolicy">
							<g:message code="glConfigSettings.revaluationPolicy.label" default="Revaluation Policy:" />
							<span class="required-indicator">*</span>
						</label>
						<g:field class="form-control" name="revaluationPolicy" value="${glConfigSettings.revaluationPolicy}" required=""/>
					</div>

					<div class="form-group fieldcontain ${hasErrors(bean: glConfigSettings, field: 'errorAccount', 'error')} required">
						<label class="control-label col-sm-3" for="errorAccount">
							<g:message code="glConfigSettings.errorAccount.label" default="Error Account:" />
							<span class="required-indicator">*</span>
						</label>
						<g:field class="form-control" name="errorAccount" value="${glConfigSettings.errorAccount}" required=""/>
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
