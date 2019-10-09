
<%@ page import="accounting.bankpayables.Payables" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'payables.label', default: 'payables')}" />
		<title>Payables List</title>
	</head>
	<body>
		<content tag="breadcrumbs">
          <span class="fa fa-chevron-right"></span><span class="current">Payables</span>
		</content>

            <content tag="main-content">   
		<div id="list-forexRate" class="content scaffold-list" role="main">
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
					
						<th><g:message code="payables.trnid.label" default="trnid" /></th>
					
						<g:sortableColumn property="clientname" title="${message(code: 'payables.clientname.label', default: 'clientname')}" />
					
						<g:sortableColumn property="checkamt" title="${message(code: 'payables.checkamt.label', default: 'amount')}" />
					
						<g:sortableColumn property="status" title="${message(code: 'payables.status.label', default: 'status')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${payablesInstanceList}" status="i" var="payablesInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${payablesInstance.id}">${fieldValue(bean: payablesInstance, field: "trnid")}</g:link></td>
					
						<td>${fieldValue(bean: payablesInstance, field: "clientname")}</td>
					
						<td>${fieldValue(bean: payablesInstance, field: "checkamt")}</td>
					
						<td>${fieldValue(bean: payablesInstance, field: "status")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${PayablesInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><g:link class="create" action="create">New/Update Payables</g:link></li>
				</ul>
            </content>

	</body>
</html>
