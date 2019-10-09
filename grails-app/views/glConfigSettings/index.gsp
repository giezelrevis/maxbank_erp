
<%@ page import="icbs.admin.GlConfigSettings" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'glConfigSettings.label', default: 'glConfigSettings')}" />
		<title>GL Configuration Settings</title>
	</head>
	<body>
		<content tag="main-content">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ul class="property-list glConfigSettings">
				<li class="fieldcontain">
					<span id="currency-label" class="property-label"><g:message code="glConfigSettings.currency.label" default="Currency:" /></span>
					<span class="property-value" aria-labelledby="currency-label"><g:fieldValue bean="${glConfigSettings}" field="currency"/></span>
				</li>
			</ul>

			<ul class="property-list glConfigSettings">
				<li class="fieldcontain">
					<span id="taxMonthEnd-label" class="property-label"><g:message code="glConfigSettings.taxMonthEnd.label" default="Tax Month End:" /></span>
					<span class="property-value" aria-labelledby="taxMonthEnd-label"><g:fieldValue bean="${glConfigSettings}" field="taxMonthEnd"/></span>
				</li>
			</ul>

			<ul class="property-list glConfigSettings">
				<li class="fieldcontain">
					<span id="glSortCodeMask-label" class="property-label"><g:message code="glConfigSettings.glSortCodeMask.label" default="GL Sort Code Mask:" /></span>
					<span class="property-value" aria-labelledby="glSortCodeMask-label"><g:fieldValue bean="${glConfigSettings}" field="glSortCodeMask"/></span>
				</li>
			</ul>

			<ul class="property-list glConfigSettings">
				<li class="fieldcontain">
					<span id="glAccountCodeMask-label" class="property-label"><g:message code="glConfigSettings.glAccountCodeMask.label" default="GL Account Code Mask:" /></span>
					<span class="property-value" aria-labelledby="glAccountCodeMask-label"><g:fieldValue bean="${glConfigSettings}" field="glAccountCodeMask"/></span>
				</li>
			</ul>

			<ul class="property-list glConfigSettings">
				<li class="fieldcontain">
					<span id="revaluationPolicy-label" class="property-label"><g:message code="glConfigSettings.revaluationPolicy.label" default="Revaluation Policy:" /></span>
					<span class="property-value" aria-labelledby="revaluationPolicy-label"><g:fieldValue bean="${glConfigSettings}" field="revaluationPolicy"/></span>
				</li>
			</ul>

			<ul class="property-list glConfigSettings">
				<li class="fieldcontain">
					<span id="errorAccount-label" class="property-label"><g:message code="glConfigSettings.errorAccount.label" default="Error Account:" /></span>
					<span class="property-value" aria-labelledby="errorAccount-label"><g:fieldValue bean="${glConfigSettings}" field="errorAccount"/></span>
				</li>
			</ul>

			<fieldset class="buttons">
				<g:link class="btn btn-primary edit" action="edit">Edit</g:link>
			</fieldset>
		</content>
	</body>
</html>
