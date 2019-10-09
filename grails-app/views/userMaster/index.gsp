
<%@ page import="icbs.admin.UserMaster" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'userMaster.label', default: 'UserMaster')}" />
		<title>User Maintenance</title>
	</head>
	<body>
		<content tag="breadcrumbs">
          <span class="fa fa-chevron-right"></span><span class="current">User Management</span>
		</content>

            <content tag="main-content">
		<div id="list-userMaster" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
                <!-- <div class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div> -->
                            <script>
                                $(function(){
                                    var x = '${flash.message}';
                                        notify.message(x);
                                });
                            </script>
            </g:if>

			<g:form class="form-inline">
				<div class="form-group">
					<g:select name="max" value="${params.max}" from="[5, 10, 15, 20]" class="form-control input-sm pull-left"onchange="this.form.submit()" />
				</div>
				<div class="right">
					<div class="form-group">
						<g:textField  type="text" name="query" class="form-control input-sm pull-right" style="width: 150px;" placeholder="Search"/>
					</div>
					<g:submitButton name="Search" class="btn btn-sm btn-default"><i class="fa fa-search"></i></g:submitButton>
				</div>
			</g:form>

			<div class="table-responsive">
            <table class="table table-bordered table-rounded table-striped table-hover">
                <thead>
					<tr>

						<g:sortableColumn property="username" title="${message(code: 'userMaster.username.label', default: 'Username')}" />

						<g:sortableColumn property="name1" title="${message(code: 'userMaster.name1.label', default: 'Full Name')}" />

						<g:sortableColumn property="branch" title="${message(code: 'userMaster.branch.label', default: 'Branch')}" />

						<g:sortableColumn property="designation" title="${message(code: 'userMaster.designation.label', default: 'Designation')}" />

						<g:sortableColumn property="configItemStatus" title="${message(code: 'currency.configItemStatus.label', default: 'Status')}" />
                                                
                                                <g:sortableColumn property="isLocked" title="${message(code: 'userMaster.isLocked.label', default: 'Locked')}" />
                                                
                                                <g:sortableColumn property="isTellerBalanced" title="${message(code: 'userMaster.isTellerBalanced.label', default: 'Balanced')}" />
                                                
                                                <g:sortableColumn property="expiryDate" title="${message(code: 'userMaster.expiryDate.label', default: 'Expiry Date')}" />

					</tr>
				</thead>
				<tbody>
				<g:each in="${userMasterInstanceList}" status="i" var="userMasterInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

						<td><g:link action="show" id="${userMasterInstance.id}">${fieldValue(bean: userMasterInstance, field: "username")}</g:link></td>

						<td>${fieldValue(bean: userMasterInstance, field: "name1") + " " + fieldValue(bean: userMasterInstance, field: "name2") + " " + fieldValue(bean: userMasterInstance, field: "name3")} </td>

						<td>${fieldValue(bean: userMasterInstance, field: "branch.name")}</td>

						<td>${fieldValue(bean: userMasterInstance, field: "designation.description")}</td>

						
                                                <g:if test="${userMasterInstance.configItemStatus.description == 'Active'}">
                                                    <td>Active</td>
                                                </g:if>
                                                <g:else>
                                                    <td>De-Activated/Deleted</td>
                                                </g:else>
                                                
                                                <g:if test="${userMasterInstance.isLocked}">
                                                    <td>Yes</td>
                                                </g:if>
                                                <g:else>
                                                    <td>No</td>
                                                </g:else>
                                                 <g:if test="${userMasterInstance.isTellerBalanced}">
                                                    <td>Yes</td>
                                                </g:if>
                                                <g:else>
                                                    <td>No</td>
                                                </g:else>
                                                <td>
                                                <g:formatDate format="MM/dd/yyyy" date="${userMasterInstance?.expiryDate}"/>
                                                </td>

					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${UserMasterInstanceCount ?: 0}" params="${params}" />
			</div>

			<g:jasperReport action="createReport" controller="userMaster" format="PDF" jasper="users" name="All Users"/>
			
			<g:jasperReport action="createReport" controller="userMaster" format="XLS" jasper="users" name="All Users"/>

			<button type="button" class="btn btn-default btn-lg">
			  <span class="icon-pdf" aria-hidden="true"></span> Generate PDF Report
			</button>
			<button type="button" class="btn btn-default btn-lg">
			  <span class="icon-xls" aria-hidden="true"></span> Generate Excel Report
			</button>

	</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><g:link class="create" action="create"><g:message code="default.new.user" args="[entityName]" default="New User" /></g:link></li>
				</ul>
            </content>
	</body>
</html>
