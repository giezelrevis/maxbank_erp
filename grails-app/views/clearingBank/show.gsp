
<%@ page import="icbs.admin.ClearingBank" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'clearingBank.label', default: 'ClearingBank')}" />
		<title>Clearing Bank Information</title>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/clearingBank')}">Clearing Bank List</a>
                <span class="fa fa-chevron-right"></span><span class="current">Clearing Bank Information</span>
            </content>
            <content tag="main-content">   
		<div id="show-clearingBank" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
                        <!--    
			<div class="message" role="status">${flash.message}</div>
                        -->
                        <script>
                        $(function(){
                            var x = '${flash.message}';
                                notify.message(x);
                        });
                        </script>
			</g:if>

			<div class="nav-tab-container">
              <ul class="nav nav-tabs">
                <li class="active"><a href="#tab_1" data-toggle="tab">Clearing Bank Details</a></li>
                %{-- <li><a href="#tab_2" data-toggle="tab">Branches</a></li> --}%
              </ul>
            </div>

            <div class="tab-content">
            	<div class="tab-pane active fade in" id="tab_1">
                    <div class="section-container">
                        <legend class="section-header">Details</legend>
                    <table class="table table-bordered table-rounded table-striped table-hover">
                        <tbody>
                            <tr>
                                <td style = "width:30%;"><b>Code<b></td>
                                <td style = "width:70%;">${clearingBankInstance?.code}</td>
                            </tr>
                            <tr>
                                <td><b>Name<b></td>
                                <td>${clearingBankInstance?.name}</td>
                            </tr>
                            <tr>
                                <td><b>Short Name<b></td>
                                <td>${clearingBankInstance?.shortName}</td>
                            </tr>
                            <tr>
                                <td><b>Address<b></td>
                                <td>${clearingBankInstance?.address}</td>
                            </tr>
                            <tr>
                                <td><b>Contact Person<b></td>
                                <td>${clearingBankInstance?.contactPerson}</td>
                            </tr>
                            <tr>
                                <td><b>Contact<b></td>
                                <td>${clearingBankInstance?.contact}</td>
                            </tr>
                            <tr>
                                <td><b>Email<b></td>
                                <td>${clearingBankInstance?.email}</td>
                            </tr>                            
                            
                            <tr>
                                <td><b>Swift Code<b></td>
                                <td>${clearingBankInstance?.swiftCode}</td>
                            </tr>
                            <tr>
                                <td><b>Config Item Status<b></td>
                                <td>${clearingBankInstance?.configItemStatus}</td>
                            </tr>
                        </tbody>
                    </table>
                    </div>
            		<ul class="property-list clearingBank">
                                            
						<g:if test="${clearingBankInstance?.code}">
<!--						<li class="fieldcontain">
							<span id="code-label" class="property-label"><g:message code="clearingBank.code.label" default="Code" /></span>
							
								<span class="property-value" aria-labelledby="code-label"><g:fieldValue bean="${clearingBankInstance}" field="code"/></span>
							
						</li>-->
						</g:if>
					
						<g:if test="${clearingBankInstance?.name}">
<!--						<li class="fieldcontain">
							<span id="name-label" class="property-label"><g:message code="clearingBank.name.label" default="Name" /></span>
							
								<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${clearingBankInstance}" field="name"/></span>
							
						</li>-->
						</g:if>
					
						<g:if test="${clearingBankInstance?.shortName}">
<!--						<li class="fieldcontain">
							<span id="shortName-label" class="property-label"><g:message code="clearingBank.shortName.label" default="Short Name" /></span>
							
								<span class="property-value" aria-labelledby="shortName-label"><g:fieldValue bean="${clearingBankInstance}" field="shortName"/></span>
							
						</li>-->
						</g:if>
					
						<g:if test="${clearingBankInstance?.address}">
						<!--<li class="fieldcontain">
							<span id="address-label" class="property-label"><g:message code="clearingBank.address.label" default="Address" /></span>
							
								<span class="property-value" aria-labelledby="address-label"><g:fieldValue bean="${clearingBankInstance}" field="address"/></span>
							
						</li> -->
						</g:if>
					
						<g:if test="${clearingBankInstance?.contactPerson}">
						<!-- <li class="fieldcontain">
							<span id="contactPerson-label" class="property-label"><g:message code="clearingBank.contactPerson.label" default="Contact Person" /></span>
							
								<span class="property-value" aria-labelledby="contactPerson-label"><g:fieldValue bean="${clearingBankInstance}" field="contactPerson"/></span>
							
						</li> -->
						</g:if>
					
						<g:if test="${clearingBankInstance?.contact}">
						<!-- <li class="fieldcontain">
							<span id="contact-label" class="property-label"><g:message code="clearingBank.contact.label" default="Contact" /></span>
							
								<span class="property-value" aria-labelledby="contact-label"><g:fieldValue bean="${clearingBankInstance}" field="contact"/></span>
							
						</li> -->
						</g:if>
					
						<g:if test="${clearingBankInstance?.email}">
						<!-- <li class="fieldcontain">
							<span id="email-label" class="property-label"><g:message code="clearingBank.email.label" default="Email" /></span>
							
								<span class="property-value" aria-labelledby="email-label"><g:fieldValue bean="${clearingBankInstance}" field="email"/></span>
							
						</li> -->
						</g:if>
					
						<g:if test="${clearingBankInstance?.swiftCode}">
<!--						<li class="fieldcontain">
							<span id="swiftCode-label" class="property-label"><g:message code="clearingBank.swiftCode.label" default="Swift Code" /></span>
							
								<span class="property-value" aria-labelledby="swiftCode-label"><g:fieldValue bean="${clearingBankInstance}" field="swiftCode"/></span>
							
						</li>-->
						</g:if>
					
						<g:if test="${clearingBankInstance?.configItemStatus}">
<!--						<li class="fieldcontain">
							<span id="configItemStatus-label" class="property-label"><g:message code="clearingBank.configItemStatus.label" default="Config Item Status" /></span>
							
								<span class="property-value" aria-labelledby="configItemStatus-label">${clearingBankInstance?.configItemStatus?.description}</span>
							
						</li>-->
						</g:if>
                                            
					</ul>
            	</div>

            	%{-- <div class="tab-pane fade in" id="tab_2">
            		<ul>
					<g:each in="${clearingBankInstance.branches}" var="branch" >
						<li>${branch.name}</li>
					</g:each>
					</ul>
            	</div> --}%
            </div>	
            <g:form id="delete" url="[resource:clearingBankInstance, action:'delete']" method="DELETE"></g:form>
        </div>
    </content>
    
    <content tag="main-actions">
        <ul>
            <li><g:link class="create" action="create"><g:message code="default.new.clearingBank" args="[entityName]" default="New Clearing Bank" /></g:link></li>
            <li><g:link class="edit" action="edit" resource="${clearingBankInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link></li>
            <li><g:actionSubmit class="delete" id="deleteClearingBank" name="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="
                            alertify.confirm(AppTitle,'Are you sure you want to delete?',
                                function(){
                                    checkIfAllowed('CFG00303', 'form#delete', 'Override delete clearing bank.', null); 
                                },
                                function(){
                                    return;
                                });                      
                " /></li>
        </ul>
        <!--
        <script type="text/javascript">
            $(document).ready(function() {
                $( "#deleteClearingBank" ).click(function() {
                         checkIfAllowed('CFG00303', 'form#delete', 'Override delete clearing bank.', null); // params: policyTemplate.code, form to be saved
                });
            }); 
        </script>
        -->
    </content>
	</body>
</html>
