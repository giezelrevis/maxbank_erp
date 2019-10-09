
<%@ page import="icbs.loans.Collateral" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'collateral.label', default: 'Collateral')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
            <content tag="main-content">   
		<div id="show-collateral" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list collateral">
			
				<g:if test="${collateralInstance?.collateralType}">
				<li class="fieldcontain">
					<span id="collateralType-label" class="property-label"><g:message code="collateral.collateralType.label" default="Collateral Type" /></span>
					
						<span class="property-value" aria-labelledby="collateralType-label"><g:link controller="loanCollateralType" action="show" id="${collateralInstance?.collateralType?.id}">${collateralInstance?.collateralType?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${collateralInstance?.estimatedValue}">
				<li class="fieldcontain">
					<span id="estimatedValue-label" class="property-label"><g:message code="collateral.estimatedValue.label" default="Estimated Value" /></span>
					
						<span class="property-value" aria-labelledby="estimatedValue-label"><g:fieldValue bean="${collateralInstance}" field="estimatedValue"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${collateralInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="collateral.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${collateralInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${collateralInstance?.remarks}">
				<li class="fieldcontain">
					<span id="remarks-label" class="property-label"><g:message code="collateral.remarks.label" default="Remarks" /></span>
					
						<span class="property-value" aria-labelledby="remarks-label"><g:fieldValue bean="${collateralInstance}" field="remarks"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${collateralInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="property-label"><g:message code="collateral.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:link controller="loanCollateralStatus" action="show" id="${collateralInstance?.status?.id}">${collateralInstance?.status?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${collateralInstance?.rem}">
				<li class="fieldcontain">
					<span id="rem-label" class="property-label"><g:message code="collateral.rem.label" default="Rem" /></span>
					
						<span class="property-value" aria-labelledby="rem-label"><g:link controller="collateralREM" action="show" id="${collateralInstance?.rem?.id}">${collateralInstance?.rem?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${collateralInstance?.chattel}">
				<li class="fieldcontain">
					<span id="chattel-label" class="property-label"><g:message code="collateral.chattel.label" default="Chattel" /></span>
					
						<span class="property-value" aria-labelledby="chattel-label"><g:link controller="collateralChattel" action="show" id="${collateralInstance?.chattel?.id}">${collateralInstance?.chattel?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${collateralInstance?.holdout}">
				<li class="fieldcontain">
					<span id="holdout-label" class="property-label"><g:message code="collateral.holdout.label" default="Holdout" /></span>
					
						<span class="property-value" aria-labelledby="holdout-label"><g:link controller="collateralHoldout" action="show" id="${collateralInstance?.holdout?.id}">${collateralInstance?.holdout?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${collateralInstance?.pdc}">
				<li class="fieldcontain">
					<span id="pdc-label" class="property-label"><g:message code="collateral.pdc.label" default="Pdc" /></span>
					
						<span class="property-value" aria-labelledby="pdc-label"><g:link controller="collateralPDC" action="show" id="${collateralInstance?.pdc?.id}">${collateralInstance?.pdc?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${collateralInstance?.loanApplications}">
				<li class="fieldcontain">
					<span id="loanApplications-label" class="property-label"><g:message code="collateral.loanApplications.label" default="Loan Applications" /></span>
					
						<g:each in="${collateralInstance.loanApplications}" var="l">
						<span class="property-value" aria-labelledby="loanApplications-label"><g:link controller="loanApplicationCollateral" action="show" id="${l.id}">${l?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:collateralInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="editCollateral" controller="loanApplication" id="${collateralInstance.id}" params="[loanApplication:"${loanApplicationInstance?.id}"]"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
        </content>
         <content tag="main-actions">
            <ul>
                <li><g:link action="show" id="${loanApplicationInstance.id}">View Loan Application</g:link></li>
                <li><g:link action="showCollaterals" resource="${loanApplicationInstance}">View Collateral List</g:link></li>                    
                <li><g:link action="createCollateral"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
        </content>
	</body>
</html>
