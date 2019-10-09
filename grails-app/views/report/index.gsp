
<%@ page import="icbs.admin.Report" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'report.label', default: 'Report')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
            <content tag="main-content">   
		<div id="list-report" class="content scaffold-list" role="main">
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

			<div class="table-responsive">
            <table class="table table-bordered table-rounded table-striped table-hover">
                <thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'report.name.label', default: 'Name')}" />
					
						<th><g:message code="report.reportGroup.label" default="Report Group" /></th>
					
						<th><g:message code="report.reportType.label" default="Report Type" /></th>
					
						<g:sortableColumn property="remarks" title="${message(code: 'report.remarks.label', default: 'Remarks')}" />
					
						<th><g:message code="report.configItemStatus.label" default="Status" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${reportInstanceList}" status="i" var="reportInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${reportInstance.id}">${fieldValue(bean: reportInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: reportInstance, field: "reportGroup.description")}</td>
					
						<td>${fieldValue(bean: reportInstance, field: "reportType.description")}</td>
					
						<td>${fieldValue(bean: reportInstance, field: "remarks")}</td>
					
						<td>${fieldValue(bean: reportInstance, field: "configItemStatus.description")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${ReportInstanceCount ?: 0}" params="${params}" />
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
