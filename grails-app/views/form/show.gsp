
<%@ page import="icbs.admin.Form" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'form.label', default: 'Form')}" />
		<title>Form Information</title>
	</head>
	<body>
		<content tag="breadcrumbs">
		  <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/form')}">Form Designer</a>
          <span class="fa fa-chevron-right"></span><span class="current">Form Information</span>
		</content>
        <content tag="main-content">   
		<div id="show-form" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ul class="property-list form">
			
				<g:if test="${formInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="form.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${formInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${formInstance?.sourceFile}">
				<li class="fieldcontain">
					<span id="sourceFile-label" class="property-label"><g:message code="form.sourceFile.label" default="Source File" /></span>
					
						<span class="property-value" aria-labelledby="sourceFile-label"><g:fieldValue bean="${formInstance}" field="sourceFile"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${formInstance?.configItemStatus}">
				<li class="fieldcontain">
					<span id="configItemStatus-label" class="property-label"><g:message code="form.configItemStatus.label" default="Config Item Status" /></span>
					
						<span class="property-value" aria-labelledby="configItemStatus-label">${formInstance?.configItemStatus?.description}</span>
					
				</li>
				</g:if>
			
			</ul>
			<g:form id="show" url="[resource:formInstance, action:'delete']" method="DELETE">
			</g:form>
		</div>
            </content>
             <content tag="main-actions">
                <ul>
		</ul>
            </content>
	</body>
</html>
