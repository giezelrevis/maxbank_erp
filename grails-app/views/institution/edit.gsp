
<%@ page import="icbs.admin.Institution" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'institution.label', default: 'Institution')}" />
		<title>Edit Institution Settings</title>
	</head>
	<body>
		<content tag="main-content">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			
			<g:form url="[action:'update']" method="PUT" >
				<fieldset class="form">
					<div class="fieldcontain form-group ${hasErrors(bean: institution, field: 'institutionName', 'has-error')} required">
						<label class="control-label col-sm-4" for="institutionName">
							<g:message code="institutionConfig" default="Institution Name" />
							<span class="required-indicator">*</span>
						</label>
						<div class="col-sm-8"><g:textField name="institutionName" value="${icbs.admin.Institution.findByParamCode("GEN.10000").paramValue}" class="form-control"/>        
						</div>             
					</div>
				</fieldset>
				<fieldset class="form">
					<div class="fieldcontain form-group ${hasErrors(bean: institution, field: 'institutionCode', 'has-error')} required">
						<label class="control-label col-sm-4" for="institutionCode">
							<g:message code="institutionConfig" default="Institution Code" />
							<span class="required-indicator">*</span>
						</label>
						<div class="col-sm-8"><g:textField name="institutionCode" required="" value="${icbs.admin.Institution.findByParamCode("GEN.10010").paramValue}" class="form-control"/>        
						</div>             
					</div>
				</fieldset>
				
				<fieldset class="buttons">
					<g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</fieldset>
			</g:form>
				
		</content>
		<content tag="main-actions">
		</content>
	</body>
</html>
