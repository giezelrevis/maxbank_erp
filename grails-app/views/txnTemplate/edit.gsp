<%@ page import="icbs.admin.TxnTemplate" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'txnTemplate.label', default: 'TxnTemplate')}" />
		<title>Assign Charges</title>
	</head>
	<body>
			<content tag="breadcrumbs">
		<span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/txnTemplate')}">Transaction Template</a>
		      <span class="fa fa-chevron-right"></span><g:link action="show" resource="${txnTemplateInstance}">Transaction Information</g:link>
		      <span class="fa fa-chevron-right"></span><span class="current">Assign Charges</span>
			</content>
            <content tag="main-content">
		<div id="edit-txnTemplate" class="content scaffold-edit" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${txnTemplateInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${txnTemplateInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>

			<div class="nav-tab-container">
              <ul class="nav nav-tabs">
                <li><a href="#tab_1" data-toggle="tab">Transaction Template Details</a></li>
                <li class="active"><a href="#tab_2" data-toggle="tab">Charges</a></li>
              </ul>
            </div>

            <div class="tab-content">
            	<div class="tab-pane fade in" id="tab_1">
            		<g:form id="edit" url="[resource:txnTemplateInstance, action:'saveCharge']" method="PUT" >
						<g:hiddenField name="version" value="${txnTemplateInstance?.version}" />
						<fieldset class="form">
							<g:render template="detail"/>
						</fieldset>
            	</div>
				<div class="tab-pane active fade in" id="tab_2">
					<h3>Assign Charges to Transaction</h3>
						<fieldset>
							<g:render template="charge" />
						</fieldset>
					</g:form>
				</div>
			</div>

		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><g:actionSubmit form="edit" action="saveCharge" value="${message(code: 'default.button.save.label', default: 'Save')}" /></li>
                    <li><g:link action="show" id="${txnTemplateInstance.id}">Cancel</g:link></li>
                </ul>
            </content>
            
	</body>
</html>
