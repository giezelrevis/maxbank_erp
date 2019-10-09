
<%@ page import="icbs.gl.TxnGlLink" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'txnGlLink.label', default: 'TxnGlLink')}" />
		<title>GL Transaction Link</title>
	</head>
	<body>
            <content tag="main-content">   
		<div id="show-txnGlLink" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<div class="nav-tab-container">
              <ul class="nav nav-tabs">
                <li class="active"><a href="#tab_1" data-toggle="tab">Transaction GL Link</a></li>
                <li><a href="#tab_2" data-toggle="tab">GL Link Entries</a></li>
              </ul>
        	</div>


            <div class="tab-content">
            	<div class="tab-pane active fade in" id="tab_1">

					<ul class="property-list role">
							<g:if test="${txnGlLinkInstance?.status}">
								<li class="fieldcontain">
									<span id="status-label" class="property-label"><g:message code="txnGlLink.status.label" default="Status" /></span>
									
										<span class="property-value" aria-labelledby="status-label"><g:fieldValue bean="${txnGlLinkInstance}" field="status"/></span>
									
								</li>
								</g:if>
							
								<g:if test="${txnGlLinkInstance?.description}">
								<li class="fieldcontain">
									<span id="description-label" class="property-label"><g:message code="txnGlLink.description.label" default="Description" /></span>
									
										<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${txnGlLinkInstance}" field="description"/></span>
									
								</li>
								</g:if>		
					</ul>

				</div>

				<div class="tab-pane fade in" id="tab_2">
            		<ul>
						<g:if test="${txnGlLinkInstance?.links}">
							<g:each in="${txnGlLinkInstance.links}" var="l">
								<li><span class="property-value" aria-labelledby="links-label"><g:link controller="cfgGlLinkEntry" action="show" id="${l.id}">${l?.description.encodeAsHTML()}</g:link></span>
								</li>
							</g:each>
						</g:if>
					</ul>
            	</div>
            </div>
		</div>
			
			%{-- <g:form url="[resource:txnGlLinkInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form> --}%
		</div>
            </content>
             <content tag="main-actions">
                <ul>
                    <li><g:link class="list" action="index">Back</g:link></li>
                    <li><g:link class="create" action="create">New Link</g:link></li>
                    <li><g:link class="edit" action="edit" resource="${txnGlLinkInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link></li>
                    <li></li>

		</ul>
            </content>
	</body>
</html>
