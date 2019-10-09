
<%@ page import="icbs.admin.Branch" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'branch.label', default: 'Branch')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<content tag="breadcrumbs">
          <span class="fa fa-chevron-right"></span><span class="current">Branch Maintenance</span>
		</content>

        <content tag="main-content">   
		<div id="list-branch" class="content scaffold-list" role="main">
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
					
						<g:sortableColumn property="code" title="${message(code: 'branch.code.label', default: 'Code')}" />
					
						<g:sortableColumn property="name" title="${message(code: 'branch.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="swiftCode" title="${message(code: 'branch.swiftCode.label', default: 'Swift Code')}" />
					
						<th><g:message code="branch.region.label" default="Region" /></th>

						<th><g:message code="branch.branchRunStatus.label" default="Run Status" /></th>

						<th><g:message code="branch.status.label" default="Branch Status" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${branchInstanceList}" status="i" var="branchInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${branchInstance.id}">${fieldValue(bean: branchInstance, field: "code").padLeft(3, '0')}</g:link></td>
					
						<td>${fieldValue(bean: branchInstance, field: "name")}</td>
					
						<td>${fieldValue(bean: branchInstance, field: "swiftCode")}</td>
					
						<td>${fieldValue(bean: branchInstance, field: "region.itemValue")}</td>

						<td>${fieldValue(bean: branchInstance, field: "branchRunStatus.description")}</td>

						<td>${fieldValue(bean: branchInstance, field: "status.description")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${BranchInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <!--
                    <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
                    -->
                    <li><g:link action="noCreate">Create New Branch</g:link></li>
		</ul>
            </content>
	</body>
</html>
