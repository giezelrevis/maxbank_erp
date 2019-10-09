
<%@ page import="icbs.admin.Form" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'form.label', default: 'Form')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<content tag="breadcrumbs">
          <span class="fa fa-chevron-right"></span><span class="current">Form Designer</span>
		</content>
		<content tag="main-content">   
		<div id="list-form" class="content scaffold-list" role="main">
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
					
						<g:sortableColumn property="name" title="${message(code: 'form.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="sourceFile" title="${message(code: 'form.sourceFile.label', default: 'Source File')}" />
					
						<th><g:message code="form.configItemStatus.label" default="Status" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${formInstanceList}" status="i" var="formInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${formInstance.id}">${fieldValue(bean: formInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: formInstance, field: "sourceFile")}</td>
					
						<td>${fieldValue(bean: formInstance, field: "configItemStatus.description")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${FormInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>
            <content tag="main-actions">
                <ul>                   
		</ul>
            </content>
	</body>
</html>
