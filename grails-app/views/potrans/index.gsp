
<%@ page import="accounting.bankpayables.AccountsPayables" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'accountsPayables.label', default: 'accountsPayables')}" />
		<title>Accounts Payable List</title>
	</head>
	<body>
		<content tag="breadcrumbs">
          <span class="fa fa-chevron-right"></span><span class="current">Accounts Payable Maintainance</span>
		</content>

            <content tag="main-content">   
		<div id="list-accountsPayables" class="content scaffold-list" role="main">
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
					
						<th><g:message code="accountsPayables.reference.label" default="Reference" /></th>
					
						<g:sortableColumn property="clientname" title="${message(code: 'accountsPayables.clientname.label', default: 'Clientname/Vendor')}" />
					
						<g:sortableColumn property="transdate" title="${message(code: 'accountsPayables.transdate.label', default: 'Transaction Date')}" />
					
						<g:sortableColumn property="amount" title="${message(code: 'accountsPayables.amount.label', default: 'amount')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${accountsPayablesInstanceList}" status="i" var="accountsPayablesInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${accountsPayablesInstance.id}">${fieldValue(bean: accountsPayablesInstance, field: "reference")}</g:link></td>
					
						<td>${fieldValue(bean: accountsPayablesInstance, field: "clientname")}</td>
					
						<td>${fieldValue(bean: accountsPayablesInstance, field: "transdate")}</td>
					
						<td>${fieldValue(bean: accountsPayablesInstance, field: "amount")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${AccountsPayablesInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>
            <content tag="main-actions">
                <!-- <ul>
                    <li><g:link class="create" action="create">New/Update AP</g:link></li>
				</ul> -->
            </content>
	</body>
</html>
