
<%@ page import="icbs.cif.Customer" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'customer.label', default: 'Customer')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
            <content tag="main-content">   
		<div id="show-customer" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list customer">
			
				<g:if test="${customerInstance?.contacts}">
				<li class="fieldcontain">
					<span id="contacts-label" class="property-label"><g:message code="customer.contacts.label" default="Contacts" /></span>
					
						<g:each in="${customerInstance.contacts}" var="c">
						<span class="property-value" aria-labelledby="contacts-label"><g:link controller="contact" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.addresses}">
				<li class="fieldcontain">
					<span id="addresses-label" class="property-label"><g:message code="customer.addresses.label" default="Addresses" /></span>
					
						<g:each in="${customerInstance.addresses}" var="a">
						<span class="property-value" aria-labelledby="addresses-label"><g:link controller="address" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.employments}">
				<li class="fieldcontain">
					<span id="employments-label" class="property-label"><g:message code="customer.employments.label" default="Employments" /></span>
					
						<g:each in="${customerInstance.employments}" var="e">
						<span class="property-value" aria-labelledby="employments-label"><g:link controller="employment" action="show" id="${e.id}">${e?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.businesses}">
				<li class="fieldcontain">
					<span id="businesses-label" class="property-label"><g:message code="customer.businesses.label" default="Businesses" /></span>
					
						<g:each in="${customerInstance.businesses}" var="b">
						<span class="property-value" aria-labelledby="businesses-label"><g:link controller="business" action="show" id="${b.id}">${b?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.educations}">
				<li class="fieldcontain">
					<span id="educations-label" class="property-label"><g:message code="customer.educations.label" default="Educations" /></span>
					
						<g:each in="${customerInstance.educations}" var="e">
						<span class="property-value" aria-labelledby="educations-label"><g:link controller="education" action="show" id="${e.id}">${e?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.extendedinfos}">
				<li class="fieldcontain">
					<span id="extendedinfos-label" class="property-label"><g:message code="customer.extendedinfos.label" default="Extendedinfos" /></span>
					
						<g:each in="${customerInstance.extendedinfos}" var="e">
						<span class="property-value" aria-labelledby="extendedinfos-label"><g:link controller="extendedInfo" action="show" id="${e.id}">${e?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.otheraccts}">
				<li class="fieldcontain">
					<span id="otheraccts-label" class="property-label"><g:message code="customer.otheraccts.label" default="Otheraccts" /></span>
					
						<g:each in="${customerInstance.otheraccts}" var="o">
						<span class="property-value" aria-labelledby="otheraccts-label"><g:link controller="otherAcct" action="show" id="${o.id}">${o?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.attachments}">
				<li class="fieldcontain">
					<span id="attachments-label" class="property-label"><g:message code="customer.attachments.label" default="Attachments" /></span>
					
						<g:each in="${customerInstance.attachments}" var="a">
						<span class="property-value" aria-labelledby="attachments-label"><g:link controller="attachment" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.presentedids}">
				<li class="fieldcontain">
					<span id="presentedids-label" class="property-label"><g:message code="customer.presentedids.label" default="Presentedids" /></span>
					
						<g:each in="${customerInstance.presentedids}" var="p">
						<span class="property-value" aria-labelledby="presentedids-label"><g:link controller="presentedId" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.relations}">
				<li class="fieldcontain">
					<span id="relations-label" class="property-label"><g:message code="customer.relations.label" default="Relations" /></span>
					
						<g:each in="${customerInstance.relations}" var="r">
						<span class="property-value" aria-labelledby="relations-label"><g:link controller="relation" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.type}">
				<li class="fieldcontain">
					<span id="type-label" class="property-label"><g:message code="customer.type.label" default="Customer Type Id" /></span>
					
						<span class="property-value" aria-labelledby="type-label"><g:link controller="type" action="show" id="${customerInstance?.type?.id}">${customerInstance?.type?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.gender}">
				<li class="fieldcontain">
					<span id="gender-label" class="property-label"><g:message code="customer.gender.label" default="Gender Id" /></span>
					
						<span class="property-value" aria-labelledby="gender-label"><g:link controller="gender" action="show" id="${customerInstance?.gender?.id}">${customerInstance?.gender?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.dosriCode}">
				<li class="fieldcontain">
					<span id="dosriCode-label" class="property-label"><g:message code="customer.dosriCode.label" default="Customer Dosri Code Id" /></span>
					
						<span class="property-value" aria-labelledby="dosriCode-label"><g:link controller="dosriCode" action="show" id="${customerInstance?.dosriCode?.id}">${customerInstance?.dosriCode?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="property-label"><g:message code="customer.status.label" default="Customer Status Id" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:link controller="status" action="show" id="${customerInstance?.status?.id}">${customerInstance?.status?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.title}">
				<li class="fieldcontain">
					<span id="title-label" class="property-label"><g:message code="customer.title.label" default="Title " /></span>
					
						<span class="property-value" aria-labelledby="title-label"><g:link controller="lov" action="show" id="${customerInstance?.title?.id}">${customerInstance?.title?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.civilStatus}">
				<li class="fieldcontain">
					<span id="civilStatus-label" class="property-label"><g:message code="customer.civilStatus.label" default="Civil Status Id" /></span>
					
						<span class="property-value" aria-labelledby="civilStatus-label"><g:link controller="lov" action="show" id="${customerInstance?.civilStatus?.id}">${customerInstance?.civilStatus?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.customerId}">
				<li class="fieldcontain">
					<span id="customerId-label" class="property-label"><g:message code="customer.customerId.label" default="Customer Id" /></span>
					
						<span class="property-value" aria-labelledby="customerId-label"><g:fieldValue bean="${customerInstance}" field="customerId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.name1}">
				<li class="fieldcontain">
					<span id="name1-label" class="property-label"><g:message code="customer.name1.label" default="Name1" /></span>
					
						<span class="property-value" aria-labelledby="name1-label"><g:fieldValue bean="${customerInstance}" field="name1"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.name2}">
				<li class="fieldcontain">
					<span id="name2-label" class="property-label"><g:message code="customer.name2.label" default="Name2" /></span>
					
						<span class="property-value" aria-labelledby="name2-label"><g:fieldValue bean="${customerInstance}" field="name2"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.name3}">
				<li class="fieldcontain">
					<span id="name3-label" class="property-label"><g:message code="customer.name3.label" default="Name3" /></span>
					
						<span class="property-value" aria-labelledby="name3-label"><g:fieldValue bean="${customerInstance}" field="name3"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.name4}">
				<li class="fieldcontain">
					<span id="name4-label" class="property-label"><g:message code="customer.name4.label" default="Name4" /></span>
					
						<span class="property-value" aria-labelledby="name4-label"><g:fieldValue bean="${customerInstance}" field="name4"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.displayName}">
				<li class="fieldcontain">
					<span id="displayName-label" class="property-label"><g:message code="customer.displayName.label" default="Display Name" /></span>
					
						<span class="property-value" aria-labelledby="displayName-label"><g:fieldValue bean="${customerInstance}" field="displayName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.shortAddress}">
				<li class="fieldcontain">
					<span id="shortAddress-label" class="property-label"><g:message code="customer.shortAddress.label" default="Short Address" /></span>
					
						<span class="property-value" aria-labelledby="shortAddress-label"><g:fieldValue bean="${customerInstance}" field="shortAddress"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.birthDate}">
				<li class="fieldcontain">
					<span id="birthDate-label" class="property-label"><g:message code="customer.birthDate.label" default="Birth Date" /></span>
					
						<span class="property-value" aria-labelledby="birthDate-label"><g:formatDate date="${customerInstance?.birthDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.birthPlace}">
				<li class="fieldcontain">
					<span id="birthPlace-label" class="property-label"><g:message code="customer.birthPlace.label" default="Birth Place" /></span>
					
						<span class="property-value" aria-labelledby="birthPlace-label"><g:fieldValue bean="${customerInstance}" field="birthPlace"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.isTaxable}">
				<li class="fieldcontain">
					<span id="isTaxable-label" class="property-label"><g:message code="customer.isTaxable.label" default="Is Taxable" /></span>
					
						<span class="property-value" aria-labelledby="isTaxable-label"><g:formatBoolean boolean="${customerInstance?.isTaxable}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.creditLimit}">
				<li class="fieldcontain">
					<span id="creditLimit-label" class="property-label"><g:message code="customer.creditLimit.label" default="Credit Limit" /></span>
					
						<span class="property-value" aria-labelledby="creditLimit-label"><g:fieldValue bean="${customerInstance}" field="creditLimit"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.sssNo}">
				<li class="fieldcontain">
					<span id="sssNo-label" class="property-label"><g:message code="customer.sssNo.label" default="Sss No" /></span>
					
						<span class="property-value" aria-labelledby="sssNo-label"><g:fieldValue bean="${customerInstance}" field="sssNo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.gisNo}">
				<li class="fieldcontain">
					<span id="gisNo-label" class="property-label"><g:message code="customer.gisNo.label" default="Gis No" /></span>
					
						<span class="property-value" aria-labelledby="gisNo-label"><g:fieldValue bean="${customerInstance}" field="gisNo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.tinNo}">
				<li class="fieldcontain">
					<span id="tinNo-label" class="property-label"><g:message code="customer.tinNo.label" default="Tin No" /></span>
					
						<span class="property-value" aria-labelledby="tinNo-label"><g:fieldValue bean="${customerInstance}" field="tinNo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.passportNo}">
				<li class="fieldcontain">
					<span id="passportNo-label" class="property-label"><g:message code="customer.passportNo.label" default="Passport No" /></span>
					
						<span class="property-value" aria-labelledby="passportNo-label"><g:fieldValue bean="${customerInstance}" field="passportNo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.remarks}">
				<li class="fieldcontain">
					<span id="remarks-label" class="property-label"><g:message code="customer.remarks.label" default="Remarks" /></span>
					
						<span class="property-value" aria-labelledby="remarks-label"><g:fieldValue bean="${customerInstance}" field="remarks"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerInstance?.hash}">
				<li class="fieldcontain">
					<span id="hash-label" class="property-label"><g:message code="customer.hash.label" default="Hash" /></span>
					
						<span class="property-value" aria-labelledby="hash-label"><g:fieldValue bean="${customerInstance}" field="hash"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:customerInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${customerInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
            </content>
             <content tag="main-actions">
                 <ul>
                    <li><g:link  action="customerInquiry" id="${customerInstance.id}" resource="${customerInstance}">Proceed to Customer Inquiry</g:link><li>
                    <li><g:link class="edit" action="edit" resource="${customerInstance}"><g:message code="default.button.edit.label" default="Edit" /> this Customer</g:link></li>
                </ul>
            </content>
	</body>
</html>
