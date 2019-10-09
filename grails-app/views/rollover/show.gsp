
<%@ page import="icbs.deposit.Rollover" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'rollover.label', default: 'Rollover')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
            <content tag="main-content">   
		<div id="show-rollover" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list rollover">
			
				<g:if test="${rolloverInstance?.rolloverSequence}">
				<li class="fieldcontain">
					<span id="rolloverSequence-label" class="property-label"><g:message code="rollover.rolloverSequence.label" default="Rollover Sequence" /></span>
					
						<span class="property-value" aria-labelledby="rolloverSequence-label"><g:fieldValue bean="${rolloverInstance}" field="rolloverSequence"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${rolloverInstance?.startDate}">
				<li class="fieldcontain">
					<span id="startDate-label" class="property-label"><g:message code="rollover.startDate.label" default="Start Date" /></span>
					
						<span class="property-value" aria-labelledby="startDate-label"><g:formatDate date="${rolloverInstance?.startDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${rolloverInstance?.endDate}">
				<li class="fieldcontain">
					<span id="endDate-label" class="property-label"><g:message code="rollover.endDate.label" default="End Date" /></span>
					
						<span class="property-value" aria-labelledby="endDate-label"><g:formatDate date="${rolloverInstance?.endDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${rolloverInstance?.rolloverType}">
				<li class="fieldcontain">
					<span id="rolloverType-label" class="property-label"><g:message code="rollover.rolloverType.label" default="Rollover Type" /></span>
					
						<span class="property-value" aria-labelledby="rolloverType-label"><g:link controller="rolloverType" action="show" id="${rolloverInstance?.rolloverType?.id}">${rolloverInstance?.rolloverType?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${rolloverInstance?.principalAmt}">
				<li class="fieldcontain">
					<span id="principalAmt-label" class="property-label"><g:message code="rollover.principalAmt.label" default="Principal Amt" /></span>
					
						<span class="property-value" aria-labelledby="principalAmt-label"><g:fieldValue bean="${rolloverInstance}" field="principalAmt"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${rolloverInstance?.preTermInterestAmt}">
				<li class="fieldcontain">
					<span id="preTermInterestAmt-label" class="property-label"><g:message code="rollover.preTermInterestAmt.label" default="Pre Term Interest Amt" /></span>
					
						<span class="property-value" aria-labelledby="preTermInterestAmt-label"><g:fieldValue bean="${rolloverInstance}" field="preTermInterestAmt"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${rolloverInstance?.taxAmt1}">
				<li class="fieldcontain">
					<span id="taxAmt1-label" class="property-label"><g:message code="rollover.taxAmt1.label" default="Tax Amt1" /></span>
					
						<span class="property-value" aria-labelledby="taxAmt1-label"><g:fieldValue bean="${rolloverInstance}" field="taxAmt1"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${rolloverInstance?.taxAmt2}">
				<li class="fieldcontain">
					<span id="taxAmt2-label" class="property-label"><g:message code="rollover.taxAmt2.label" default="Tax Amt2" /></span>
					
						<span class="property-value" aria-labelledby="taxAmt2-label"><g:fieldValue bean="${rolloverInstance}" field="taxAmt2"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${rolloverInstance?.taxAmt3}">
				<li class="fieldcontain">
					<span id="taxAmt3-label" class="property-label"><g:message code="rollover.taxAmt3.label" default="Tax Amt3" /></span>
					
						<span class="property-value" aria-labelledby="taxAmt3-label"><g:fieldValue bean="${rolloverInstance}" field="taxAmt3"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${rolloverInstance?.ctd}">
				<li class="fieldcontain">
					<span id="ctd-label" class="property-label"><g:message code="rollover.ctd.label" default="Ctd" /></span>
					
						<span class="property-value" aria-labelledby="ctd-label"><g:link controller="CTD" action="show" id="${rolloverInstance?.ctd?.id}">${rolloverInstance?.ctd?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${rolloverInstance?.rolloverStatus}">
				<li class="fieldcontain">
					<span id="rolloverStatus-label" class="property-label"><g:message code="rollover.rolloverStatus.label" default="Rollover Status" /></span>
					
						<span class="property-value" aria-labelledby="rolloverStatus-label"><g:link controller="rolloverStatus" action="show" id="${rolloverInstance?.rolloverStatus?.id}">${rolloverInstance?.rolloverStatus?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${rolloverInstance?.interestPaymentMode}">
				<li class="fieldcontain">
					<span id="interestPaymentMode-label" class="property-label"><g:message code="rollover.interestPaymentMode.label" default="Interest Payment Mode" /></span>
					
						<span class="property-value" aria-labelledby="interestPaymentMode-label"><g:link controller="interestPaymentMode" action="show" id="${rolloverInstance?.interestPaymentMode?.id}">${rolloverInstance?.interestPaymentMode?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${rolloverInstance?.deposit}">
				<li class="fieldcontain">
					<span id="deposit-label" class="property-label"><g:message code="rollover.deposit.label" default="Deposit" /></span>
					
						<span class="property-value" aria-labelledby="deposit-label"><g:link controller="deposit" action="show" id="${rolloverInstance?.deposit?.id}">${rolloverInstance?.deposit?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${rolloverInstance?.normalInterestAmt}">
				<li class="fieldcontain">
					<span id="normalInterestAmt-label" class="property-label"><g:message code="rollover.normalInterestAmt.label" default="Normal Interest Amt" /></span>
					
						<span class="property-value" aria-labelledby="normalInterestAmt-label"><g:fieldValue bean="${rolloverInstance}" field="normalInterestAmt"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:rolloverInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${rolloverInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
            </content>
             <content tag="main-actions">
                <ul>
                    <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                    <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                    <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
		</ul>
            </content>
	</body>
</html>
