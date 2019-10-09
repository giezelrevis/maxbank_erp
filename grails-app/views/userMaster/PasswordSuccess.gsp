
<%@ page import="icbs.admin.UserMaster" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'userMaster.label', default: 'UserMaster')}" />
		<title>Password Change Successful</title>
	</head>
	<body>


        <content tag="main-content">   
		<div id="show-userMaster" class="content scaffold-show" role="main">
		<g:if test="${flash.message}">
                    <script>
                        $(function(){
                            var x = '${flash.message}';
                                notify.message(x);
                        });
                    </script>
                        
                </g:if>

		<ul class="property-list userMaster">
					
                    <g:if test="${userMasterInstance?.username}">
			<li class="fieldcontain">
                            <span id="username-label" class="property-label"><g:message code="userMaster.username.label" default="Username" /></span>
                            <span class="property-value" aria-labelledby="username-label"><g:fieldValue bean="${userMasterInstance}" field="username"/></span>
			</li>
                    </g:if>
                    <g:if test="${userMasterInstance?.name1}">
			<li class="fieldcontain">
                            <span id="name1-label" class="property-label"><g:message code="userMaster.name1.label" default="First Name" /></span>
                            <span class="property-value" aria-labelledby="name1-label"><g:fieldValue bean="${userMasterInstance}" field="name1"/></span>
			</li>
                    </g:if>
                    <g:if test="${userMasterInstance?.name2}">
			<li class="fieldcontain">
                            <span id="name2-label" class="property-label"><g:message code="userMaster.name2.label" default="Middle Name" /></span>
                            <span class="property-value" aria-labelledby="name2-label"><g:fieldValue bean="${userMasterInstance}" field="name2"/></span>
			</li>
                    </g:if>
                    <g:if test="${userMasterInstance?.name3}">
			<li class="fieldcontain">
                            <span id="name3-label" class="property-label"><g:message code="userMaster.name3.label" default="Last Name" /></span>
                            <span class="property-value" aria-labelledby="name3-label"><g:fieldValue bean="${userMasterInstance}" field="name3"/></span>
			</li>
                    </g:if>
                    <g:if test="${userMasterInstance?.name4}">
                        <li class="fieldcontain">
                            <span id="name4-label" class="property-label"><g:message code="userMaster.name4.label" default="Name4" /></span>
                            <span class="property-value" aria-labelledby="name4-label"><g:fieldValue bean="${userMasterInstance}" field="name4"/></span>
			</li>
                    </g:if>
                    <g:if test="${userMasterInstance?.birthdate}">
                        <li class="fieldcontain">
                            <span id="birthdate-label" class="property-label"><g:message code="userMaster.birthdate.label" default="Birthdate" /></span>
                            <span class="property-value" aria-labelledby="birthdate-label"><g:formatDate format="MM/dd/yyyy" date="${userMasterInstance?.birthdate}"/></span>
			</li>
                    </g:if>
                    <g:if test="${userMasterInstance?.gender}">
                        <li class="fieldcontain">
                            <span id="gender-label" class="property-label"><g:message code="userMaster.gender.label" default="Gender" /></span>
                            <span class="property-value" aria-labelledby="gender-label">${userMasterInstance?.gender?.description}</span>
			</li>
                    </g:if>
                    <g:if test="${userMasterInstance?.address1}">
                        <li class="fieldcontain">
                            <span id="address1-label" class="property-label"><g:message code="userMaster.address1.label" default="Address1" /></span>
                            <span class="property-value" aria-labelledby="address1-label"><g:fieldValue bean="${userMasterInstance}" field="address1"/></span>
			</li>
                    </g:if>
                    <g:if test="${userMasterInstance?.address2}">
			<li class="fieldcontain">
                            <span id="address2-label" class="property-label"><g:message code="userMaster.address2.label" default="Address2" /></span>
                            <span class="property-value" aria-labelledby="address2-label"><g:fieldValue bean="${userMasterInstance}" field="address2"/></span>
			</li>
                    </g:if>
                    <g:if test="${userMasterInstance?.province}">
                        <li class="fieldcontain">
                            <span id="province-label" class="property-label"><g:message code="userMaster.province.label" default="Province" /></span>
                            <span class="property-value" aria-labelledby="province-label">${userMasterInstance?.province?.itemValue}</span>
			</li>
                    </g:if>
                    <g:if test="${userMasterInstance?.zipCode}">
                        <li class="fieldcontain">
                            <span id="zipCode-label" class="property-label"><g:message code="userMaster.zipCode.label" default="Zip Code" /></span>
                            <span class="property-value" aria-labelledby="zipCode-label"><g:fieldValue bean="${userMasterInstance}" field="zipCode"/></span>
			</li>
                    </g:if>
                    <g:if test="${userMasterInstance?.email}">
                        <li class="fieldcontain">
                            <span id="email-label" class="property-label"><g:message code="userMaster.email.label" default="Email" /></span>
                            <span class="property-value" aria-labelledby="email-label"><g:fieldValue bean="${userMasterInstance}" field="email"/></span>
			</li>
                    </g:if>
                    <g:if test="${userMasterInstance?.contact}">
                        <li class="fieldcontain">
                            <span id="contact-label" class="property-label"><g:message code="userMaster.contact.label" default="Contact" /></span>
                            <span class="property-value" aria-labelledby="contact-label"><g:fieldValue bean="${userMasterInstance}" field="contact"/></span>
                        </li>
                    </g:if>
                    <g:if test="${userMasterInstance?.dateHired}">
                        <li class="fieldcontain">
                            <span id="dateHired-label" class="property-label"><g:message code="userMaster.dateHired.label" default="Date Hired" /></span>
                            <span class="property-value" aria-labelledby="dateHired-label"><g:formatDate format="MM/dd/yyyy" date="${userMasterInstance?.dateHired}"/></span>
			</li>
                    </g:if>
                    <g:if test="${userMasterInstance?.designation}">
                        <li class="fieldcontain">
                            <span id="designation-label" class="property-label"><g:message code="userMaster.designation.label" default="Designation" /></span>
                            <span class="property-value" aria-labelledby="designation-label">${userMasterInstance?.designation?.description}</span>
			</li>
                    </g:if>
                    <g:if test="${userMasterInstance?.branch}">
                        <li class="fieldcontain">
                            <span id="branch-label" class="property-label"><g:message code="userMaster.branch.label" default="Branch" /></span>
                            <span class="property-value" aria-labelledby="branch-label"><g:link controller="branch" action="show" id="${userMasterInstance?.branch?.id}">${userMasterInstance?.branch?.name}</g:link></span>
			</li>
                    </g:if>
                    <g:if test="${userMasterInstance?.cash}">
                        <li class="fieldcontain">
                            <span id="cash-label" class="property-label"><g:message code="userMaster.cash.label" default="Cash" /></span>
                            <span class="property-value" aria-labelledby="cash-label"><g:link controller="glAccount" action="show" id="${userMasterInstance?.cash?.id}">${userMasterInstance?.cash?.name}</g:link></span>
			</li>
                    </g:if>
                    <g:if test="${userMasterInstance?.coci}">
			<li class="fieldcontain">
                            <span id="coci-label" class="property-label"><g:message code="userMaster.coci.label" default="COCI" /></span>
                            <span class="property-value" aria-labelledby="branch-label"><g:link controller="glAccount" action="show" id="${userMasterInstance?.coci?.id}">${userMasterInstance?.coci?.name}</g:link></span>
			</li>
                    </g:if>
                    <g:if test="${userMasterInstance?.expiryDate}">
                        <li class="fieldcontain">
                            <span id="expiryDate-label" class="property-label"><g:message code="userMaster.expiryDate.label" default="Expiry Date" /></span>
                            <span class="property-value" aria-labelledby="expiryDate-label"><g:formatDate format="MM/dd/yyyy" date="${userMasterInstance?.expiryDate}"/></span>
                        </li>
                    </g:if>
		</ul>
            </div>
        </content>

        <content tag="main-actions">
            <ul>
                <li><g:link action="resetPassword" resource="${userMasterInstance}">Reset Password</g:link></li>
            </ul>
        </content>
    </body>
</html>
