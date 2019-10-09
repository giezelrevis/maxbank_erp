
<%@ page import="icbs.admin.Role" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'role.label', default: 'Role')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>

		<content tag="breadcrumbs">
          <span class="fa fa-chevron-right"></span><span class="current">User Role Management</span>
		</content>

            <content tag="main-content">   
		<div id="list-role" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
                <div class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div>
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
					
						<g:sortableColumn property="code" title="${message(code: 'role.code.label', default: 'Code')}" />
					
						<g:sortableColumn property="name" title="${message(code: 'role.name.label', default: 'Name')}" />
					
						<th><g:message code="role.configItemStatus.label" default="Status" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${roleInstanceList}" status="i" var="roleInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                            <g:if test="${roleInstance.configItemStatusId==2}">
						<td><g:link action="show" id="${roleInstance.id}">${fieldValue(bean: roleInstance, field: "code")}</g:link></td>
					
						<td>${fieldValue(bean: roleInstance, field: "name")}</td>
					
						<td>${fieldValue(bean: roleInstance, field: "configItemStatus.description")}</td>
                                            </g:if>
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${RoleInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				</ul>
            </content>
	</body>
</html>
