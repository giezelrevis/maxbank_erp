<%@ page import="icbs.deposit.DocInventory" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'docInventory.label', default: 'DocInventory')}" />
		<title>Edit Document Inventory</title>
	</head>
	<body>
            <content tag="main-content">
		<div id="edit-docInventory" class="content scaffold-edit" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${docInventoryInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${docInventoryInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form id="docInventoryForm" url="[resource:docInventoryInstance, action:'update']" method="PUT" >
				<g:hiddenField name="version" value="${docInventoryInstance?.version}" />
				<fieldset class="form">
					<g:render template="form" model="[readonly:'true']"/>
				</fieldset>
			</g:form>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
      		<li><a href="#" onclick="$('#docInventoryForm').submit()">Update</a></li>
      		<li><g:link class="list" action="show" id="${docInventoryInstance.id}">Back to Show</g:link></li>

	       	</ul>
            </content>
            
	</body>
</html>
