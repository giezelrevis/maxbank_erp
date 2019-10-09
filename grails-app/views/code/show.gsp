
<%@ page import="icbs.cif.Code" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'code.label', default: 'Code')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
            <content tag="main-content">   
		<div id="show-code" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list code">
			
				<g:if test="${codeInstance?.type}">
				<li class="fieldcontain">
					<span id="type-label" class="property-label"><g:message code="code.type.label" default="Type Id" /></span>
					
						<span class="property-value" aria-labelledby="type-label"><g:link controller="lov" action="show" id="${codeInstance?.type?.id}">${codeInstance?.type?.itemValue}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${codeInstance?.value}">
				<li class="fieldcontain">
					<span id="value-label" class="property-label"><g:message code="code.value.label" default="Value" /></span>
					
						<span class="property-value" aria-labelledby="value-label"><g:fieldValue bean="${codeInstance}" field="value"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${codeInstance?.hash}">
				<li class="fieldcontain">
					<span id="hash-label" class="property-label"><g:message code="code.hash.label" default="Hash" /></span>
					
						<span class="property-value" aria-labelledby="hash-label"><g:fieldValue bean="${codeInstance}" field="hash"/></span>
					
				</li>
				</g:if>
			
			</ol>
		</div>
            </content>
             <content tag="main-actions">
                <ul>
                     <ul>
      			<li><g:link class="list" action="index">CIF Code List</g:link></li>
      			<li><g:link class="create" action="create">New CIF Code</g:link></li>
                <li><button disabled="disabled">View CIF Code</button></li>
                <li><g:link action="edit" id="${codeInstance.id}">Update CIF Code</g:link></li>
		</ul>
            </content>
	</body>
</html>
