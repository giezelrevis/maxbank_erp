
<%@ page import="icbs.audit.AuditLog" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'auditLog.label', default: 'AuditLog')}" />
		<title>Configuration and Actions Logs</title>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><span class="current">Configuration Logs</span>
            </content>
            <content tag="main-content">   
		<div id="list-auditLog" class="content scaffold-list" role="main">
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
                            <table class="table table-hover table-condensed table-bordered table-striped">
                                <thead>
					<tr>
					
						<th><g:message code="auditLog.auditType.label" default="User" /></th>
					
						<g:sortableColumn property="date" title="${message(code: 'auditLog.date.label', default: 'Date/Time')}" />
					
						<th><g:message code="auditLog.module.label" default="Activity" /></th>
                                                <g:sortableColumn property="description" title="${message(code: 'auditLog.description.label', default: 'Description')}" />
						<g:sortableColumn property="ipAddress" title="${message(code: 'auditLog.ipAddress.label', default: 'IP Address')}" />
                                                
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${auditLogInstanceList}" status="i" var="auditLogInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
					
						<td>${fieldValue(bean: auditLogInstance, field: "userMaster.name")}</td>
					
						<td>${auditLogInstance.date}</td>

						<td><a href="${fieldValue(bean: auditLogInstance, field: "recordUrl")}" target="_blank">${fieldValue(bean: auditLogInstance, field: "module.name")}</a></td>
                                                <td>${fieldValue(bean: auditLogInstance, field: "description")}</td>
						<td>${fieldValue(bean: auditLogInstance, field: "ipAddress")}</td>
					
					
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${AuditLogInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
				</ul>
            </content>
	</body>
</html>
