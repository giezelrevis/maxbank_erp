
<%@ page import="icbs.admin.Role" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'role.label', default: 'Role')}" />
		<title>Role Information</title>
	</head>
	<body>
		<content tag="breadcrumbs">
		  <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/role')}">User Role Management</a>
          <span class="fa fa-chevron-right"></span><span class="current">Role Information</span>
		</content>

    <content tag="main-content">   
		<div id="show-role" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
                <div class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div>
            </g:if>

			<div class="nav-tab-container">
              <ul class="nav nav-tabs">
                <li class="active"><a href="#tab_1" data-toggle="tab">Role Details</a></li>
                <li><a href="#tab_2" data-toggle="tab">Permissions</a></li>
              </ul>
            </div>

            <div class="tab-content">
            	<div class="tab-pane active fade in" id="tab_1">

					<ul class="property-list role">
					
						<g:if test="${roleInstance?.code}">
						<li class="fieldcontain">
							<span id="code-label" class="property-label"><g:message code="role.code.label" default="Code" /></span>
							
								<span class="property-value" aria-labelledby="code-label"><g:fieldValue bean="${roleInstance}" field="code"/></span>
							
						</li>
						</g:if>
					
						<g:if test="${roleInstance?.name}">
						<li class="fieldcontain">
							<span id="name-label" class="property-label"><g:message code="role.name.label" default="Name" /></span>
							
								<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${roleInstance}" field="name"/></span>
							
						</li>
						</g:if>
					
						<g:if test="${roleInstance?.configItemStatus}">
						<li class="fieldcontain">
							<span id="configItemStatus-label" class="property-label"><g:message code="role.configItemStatus.label" default="Config Item Status" /></span>
							
								<span class="property-value" aria-labelledby="configItemStatus-label">${roleInstance?.configItemStatus?.description}</span>
							
						</li>
						</g:if>
					
					</ul>

				</div>

				<div class="tab-pane fade in" id="tab_2">
            		<ul>
					<g:each in="${roleInstance.modules}" var="module" >
						<li>${module.name}</li>
					</g:each>
					</ul>
            	</div>
            </div>
			<g:form id="remove" url="[resource:roleInstance, action:'delete']" method="DELETE">
			</g:form>
		</div>
    </content>

    <content tag="main-actions">
        <ul>
            <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            <g:if test="${roleInstance.configItemStatus.id.toInteger() in [1, 2]}">
                <li><g:link action="edit" resource="${roleInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link></li>
                <!--<li><g:actionSubmit id="deleteRole" class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></li>-->
                <li><g:actionSubmit id="deleteRole"  resource="${roleInstance}" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="
                            alertify.confirm(AppTitle,'Are you sure you want to delete?',
                                function(){
                                    checkIfAllowed('ADM00304', 'form#remove', 'Remove role.', null);
                                },
                                function(){
                                    return;
                                });                           
                    "/></li>
            </g:if>
	</ul>
        <!--
        <script type="text/javascript">
                    $(document).ready(function() {
                           $( "#deleteRole" ).click(function() {
                              checkIfAllowed('ADM00304', 'form#remove', 'Remove holiday.', null); // params: policyTemplate.code, form to be saved
                           });
                    });
        </script>
        -->
    </content>
	</body>
</html>
