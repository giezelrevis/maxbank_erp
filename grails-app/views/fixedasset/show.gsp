
<%@ page import="accounting.fixedasset.Bankasset" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'bankasset.label', default: 'Bankasset')}" />
		<title>Asset Information</title>
	</head>
	<body>
		<content tag="breadcrumbs">
		  <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/fixedasset')}">Fixed Asset</a>
          <span class="fa fa-chevron-right"></span><span class="current">Asset Information</span>
		</content>

            <content tag="main-content">   
		<div id="show-bankasset" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ul class="property-list bankasset">
			
				<g:if test="${bankassetInstance?.assetdesc}">
				<li class="fieldcontain">
					<span id="assetdesc-label" class="property-label"><g:message code="bankasset.assetdesc.label" default="Asset Description" /></span>
					
						<span class="property-value" aria-labelledby="assetdesc-label"><g:fieldValue bean="${bankassetInstance}" field="assetdesc"/></span>
					
				</li>
				</g:if>

				<g:if test="${bankassetInstance?.purcost}">
				<li class="fieldcontain">
					<span id="purcost-label" class="property-label"><g:message code="bankasset.purcost.label" default="Purchase Cost" /></span>
					
						<span class="property-value" aria-labelledby="purcost-label"><g:fieldValue bean="${bankassetInstance}" field="purcost"/></span>
					
				</li>
				</g:if>
			
			
			</ul>
			<g:form url="[resource:bankassetInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
				<g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" />
				</fieldset>
			</g:form>
		</div>
            </content>
             <content tag="main-actions">
                <ul>
                    <li><g:link class="create" action="create"><g:message code="default.newupdate.label" args="[entityName]" default="New Asset" /></g:link></li>
                    <li><g:link action="edit" id="${bankassetInstance.id}">Edit Asset</g:link></li>
				</ul>
            </content>
	</body>
</html>
