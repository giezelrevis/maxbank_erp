
<%@ page import="accounting.bankpayables.Payables" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'payables.label', default: 'payables')}" />
		<title>Payables Information</title>
	</head>
	<body>
		<content tag="breadcrumbs">
		  <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/payables')}">Payables Maintainance</a>
          <span class="fa fa-chevron-right"></span><span class="current">Payables Information</span>
		</content>

            <content tag="main-content">   
		<div id="show-payables" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ul class="property-list payables">
			
				<g:if test="${payablesInstance?.checknumber}">
				<li class="fieldcontain">
					<span id="trnid-label" class="property-label"><g:message code="payables.checknumber.label" default="Trn. ID" /></span>
					
						<span class="property-value" aria-labelledby="trnid-label"><g:fieldValue bean="${payablesInstance}" field="trnid"/></span>
					
				</li>
				</g:if>

				<g:if test="${payablesInstance?.checkamt}">
				<li class="fieldcontain">
					<span id="checkamt-label" class="property-label"><g:message code="payables.checkamt.label" default="Amount" /></span>
					
						<span class="property-value" aria-labelledby="checkamt-label"><g:fieldValue bean="${payablesInstance}" field="checkamt"/></span>
					
				</li>
				</g:if>
			
			
			</ul>
			<g:form url="[resource:payablesInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
				<g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" />
				</fieldset>
			</g:form>
		</div>
            </content>
             <content tag="main-actions">
                <ul>
                    <li><g:link class="create" action="create"><g:message code="default.newupdate.label" args="[entityName]" default="New Payables" /></g:link></li>
                    <li><g:link action="edit" id="${payablesInstance.id}">Edit Payables</g:link></li>
				</ul>
            </content>
	</body>
</html>
