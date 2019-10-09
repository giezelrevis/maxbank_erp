
<%@ page import="icbs.gl.GlSortCode" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'glSortCode.label', default: 'GlSortCode')}" />
		<title>GL Sort Codes</title>
	</head>
	<body>
            <content tag="main-content">   
		<div id="list-glSortCode" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
                        <g:form class="form-inline">
				<div class="form-group">
					<g:select name="max" value="${params.max}" from="[5, 10, 15, 20]" class="form-control input-sm pull-left"onchange="this.form.submit()" />
				</div>
				<div class="right">
					<div class="form-group">
						<g:textField  type="text" name="query" class="form-control input-sm pull-right" style="width: 350px;" placeholder="Search"/>
					</div>
					<g:submitButton name="Search" class="btn btn-sm btn-default"><i class="fa fa-search"></i></g:submitButton>
				</div>
			</g:form>
			<div class="table-responsive">
                            <table class="table table-hover table-condensed table-bordered table-striped">
                                <thead>
					<tr>
					
						<g:sortableColumn property="sort_code" title="${message(code: 'glSortCode.sort_code.label', default: 'Code')}" />
					
						<g:sortableColumn property="sort_name" title="${message(code: 'glSortCode.sort_name.label', default: 'Name')}" />
					
						<th><g:message code="glSortCode.parent_id.label" default="Type" /></th>
					
						<g:sortableColumn property="sort_code_status" title="${message(code: 'glSortCode.sort_code_status.label', default: 'Status')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${glSortCodeInstanceList}" status="i" var="glSortCodeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${glSortCodeInstance.id}">${fieldValue(bean: glSortCodeInstance, field: "sort_code")}</g:link></td>
					
						<td>${fieldValue(bean: glSortCodeInstance, field: "sort_name")}</td>
					
						<td>${fieldValue(bean: glSortCodeInstance, field: "parent_id")}</td>
					
						<td><g:formatBoolean boolean="${glSortCodeInstance.sort_code_status}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${GlSortCodeInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                    <li><g:link class="create" action="create">New GL Sort Code</g:link></li>
		</ul>
            </content>
	</body>
</html>
