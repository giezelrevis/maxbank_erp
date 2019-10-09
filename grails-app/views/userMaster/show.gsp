
<%@ page import="icbs.admin.UserMaster" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'userMaster.label', default: 'UserMaster')}" />
		<title>User Information</title>
	</head>
	<body>

		<content tag="breadcrumbs">
		  <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/userMaster')}">User Management</a>
          <span class="fa fa-chevron-right"></span><span class="current">User Information</span>
		</content>

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

			<div class="nav-tab-container">
              <ul class="nav nav-tabs">
                <li class="active"><a href="#tab_1" data-toggle="tab">User Details</a></li>
                <li><a href="#tab_2" data-toggle="tab">Roles</a></li>
              </ul>
            </div>

            <div class="tab-content">
            	<div class="tab-pane active fade in" id="tab_1">
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
					
						<g:if test="${userMasterInstance?.employmentType}">
						<li class="fieldcontain">
							<span id="employmentType-label" class="property-label"><g:message code="userMaster.employmentType.label" default="Employment Type" /></span>
							
								<span class="property-value" aria-labelledby="employmentType-label">${userMasterInstance?.employmentType?.itemValue}</span>
							
						</li>
						</g:if>
					
						<g:if test="${userMasterInstance?.expiryDate}">
						<li class="fieldcontain">
							<span id="expiryDate-label" class="property-label"><g:message code="userMaster.expiryDate.label" default="User Access Expiry Date" /></span>
							
								<span class="property-value" aria-labelledby="expiryDate-label"><g:formatDate format="MM/dd/yyyy" date="${userMasterInstance?.expiryDate}"/></span>
							
						</li>
						</g:if>
						<g:if test="${userMasterInstance?.expiryPwdDate}">
						<li class="fieldcontain">
							<span id="expiryDate-label" class="property-label"><g:message code="userMaster.expiryPwdDate.label" default="Password Expiry Date" /></span>
							
								<span class="property-value" aria-labelledby="expiryDate-label"><g:formatDate format="MM/dd/yyyy" date="${userMasterInstance?.expiryPwdDate}"/></span>
							
						</li>
						</g:if>
						<g:if test="${userMasterInstance?.isLocked}">
						<li class="fieldcontain">
							<span id="isLocked-label" class="property-label"><g:message code="userMaster.isLocked.label" default="User Locked" /></span>
                                                             
								<span class="property-value" aria-labelledby="isLocked-label">Yes</span>
							
						</li>
						</g:if>

						<g:if test="${userMasterInstance?.hasExceededMaxLogin}">
						<li class="fieldcontain">
							<span id="hasExceededMaxLogin-label" class="property-label"><g:message code="userMaster.hasExceededMaxLogin.label" default="User Has Exceeded Max Login Attempt" /></span>
							
								<span class="property-value" aria-labelledby="hasExceededMaxLogin-label"><g:formatBoolean boolean="${userMasterInstance?.hasExceededMaxLogin}" true="Yes" false="No" /></span>
							
						</li>
						</g:if>
					
						<g:if test="${userMasterInstance?.configItemStatus}">
						<li class="fieldcontain">
							<span id="configItemStatus-label" class="property-label"><g:message code="userMaster.configItemStatus.label" default="Config Item Status" /></span>
							
								<span class="property-value" aria-labelledby="configItemStatus-label">${userMasterInstance?.configItemStatus?.description}</span>
							
						</li>
						</g:if>
					
					</ul>
				</div>

				<div class="tab-pane fade in" id="tab_2">
            		<ul>
					<g:each in="${userMasterInstance.roles}" var="role" >
						<li>${role.name}</li>
					</g:each>
					</ul>
            	</div>
            </div>

			<g:form id="deactivateUser" url="[resource:userMasterInstance, action:'delete']" method="DELETE"> </g:form>
                        <g:form id="lockUserForm" url="[resource:userMasterInstance, action:'lock']" method="DELETE"> </g:form>
                        <g:form id="unlockUserForm" url="[resource:userMasterInstance, action:'unlock']" method="DELETE"> </g:form>

		</div>
        </content>

        <content tag="main-actions">
            <ul>
                <li><g:link class="create" action="create"><g:message code="default.new.user" args="[entityName]" default="New User" /></g:link></li>
                <li><g:link action="edit" resource="${userMasterInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link></li>
                <li><g:link action="resetPassword" resource="${userMasterInstance}">Reset Password</g:link></li>
                <li><g:link action="forceLogout" resource="${userMasterInstance}">Force Logout</g:link></li>
                
                <li><g:actionSubmit id="deleteUser" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="
                            alertify.confirm(AppTitle,'Are you sure you want to delete?',
                                function(){
                                    checkIfAllowed('ADM00504', 'form#deactivateUser', 'Delete User.', null);
                                },
                                function(){
                                    return;
                                });                          
                    " /></li>
                <g:if test="${!userMasterInstance.hasExceededMaxLogin && !userMasterInstance.isLocked}">
                    <li><g:actionSubmit id="lockUser" action="lock" value="${message(code: 'default.button.unlock.label', default: 'Lock User')}" onclick="
                            alertify.confirm(AppTitle,'Are you sure you want to lock user?',
                                function(){
                                    checkIfAllowed('ADM00506', 'form#lockUserForm', 'Unlock User.', null);
                                },
                                function(){
                                    return;
                                });                              
                        " /></li>
                </g:if>
                <g:else>
                    <li><g:actionSubmit id="unlockUser" action="unlock" value="${message(code: 'default.button.unlock.label', default: 'Unlock User')}" onclick="
                            alertify.confirm(AppTitle,'Are you sure you want to unlock user?',
                                function(){
                                    checkIfAllowed('ADM00506', 'form#unlockUserForm', 'Unlock User.', null);
                                },
                                function(){
                                    return;
                                });                               
                        " /></li>
                </g:else>
            </ul>
            <!--
            <script type="text/javascript">
                    $(document).ready(function() {
                           $( "#deleteUser" ).click(function() {
                              checkIfAllowed('ADM00504', 'form#deactivateUser', 'Delete User.', null); // params: policyTemplate.code, form to be saved
                           });
                    });
                    
                    $(document).ready(function() {
                           $( "#lockUser" ).click(function() {
                              checkIfAllowed('ADM00506', 'form#lockUserForm', 'Unlock User.', null); // params: policyTemplate.code, form to be saved
                           });
                    });
                    
                     $(document).ready(function() {
                           $( "#unlockUser" ).click(function() {
                              checkIfAllowed('ADM00506', 'form#unlockUserForm', 'Unlock User.', null); // params: policyTemplate.code, form to be saved
                           });
                    });
                    
                </script>
                -->
        </content>
	</body>
</html>
