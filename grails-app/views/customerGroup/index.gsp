
<%@ page import="icbs.admin.CustomerGroup" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'customerGroup.label', default: 'CustomerGroup')}" />
		<title>Customer Group Maintenance</title>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><span class="current">Customer Group Maintenance</span>
            </content>
		<content tag="main-content">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
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
			
			<table class="table table-bordered table-rounded table-striped table-hover">
			<thead>
					<tr>
					
						<g:sortableColumn property="code" title="${message(code: 'customerGroup.code.label', default: 'Code')}" />
					
						<g:sortableColumn property="name" title="${message(code: 'customerGroup.name.label', default: 'Name')}" />

						<g:sortableColumn property="name" title="${message(code: 'customerGroup.configItemStatus.label', default: 'Status')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${customerGroupInstanceList}" status="i" var="customerGroupInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                            <g:if test="${customerGroupInstance?.configItemStatusId==2}">
						<td><g:link action="show" id="${customerGroupInstance.id}">${fieldValue(bean: customerGroupInstance, field: "code")}</g:link></td>
					
						<td>${fieldValue(bean: customerGroupInstance, field: "name")}</td>

						<td>${fieldValue(bean: customerGroupInstance, field: "configItemStatus.description")}</td>
                                            </g:if>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${customerGroupInstanceCount ?: 0}" />
			</div>
		</content>
		<content tag="main-actions">
			<ul>
				<li><g:link action="create">New Customer Group</g:link></li>
			</ul>
		</content>
	</body>
</html>