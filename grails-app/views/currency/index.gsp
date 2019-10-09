
<%@ page import="icbs.admin.Currency" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'currency.label', default: 'Currency')}" />
		<title>Transaction Currency Maintenance</title>
	</head>
	<body>
		<content tag="breadcrumbs">
          <span class="fa fa-chevron-right"></span><span class="current">Currency Maintenance</span>
		</content>
		<content tag="main-content">
			<div id="list-currency" class="content scaffold-list" role="main">
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
						
							<g:sortableColumn property="code" title="${message(code: 'currency.code.label', default: 'Code')}" />
						
							<g:sortableColumn property="name" title="${message(code: 'currency.name.label', default: 'Name')}" />

							<g:sortableColumn property="configItemStatus" title="${message(code: 'currency.configItemStatus.label', default: 'Status')}" />
						</tr>
					</thead>
					<tbody>
					<g:each in="${currencyInstanceList}" status="i" var="currencyInstance">
                                            <g:if test="${currencyInstance.configItemStatusId==2}">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
							<td><g:link action="show" id="${currencyInstance.id}">${fieldValue(bean: currencyInstance, field: "code")}</g:link></td>
						
							<td>${fieldValue(bean: currencyInstance, field: "name")}</td>

							<td>${fieldValue(bean: currencyInstance, field: "configItemStatus.description")}</td>
						</tr>
                                            </g:if>
					</g:each>
					</tbody>
				</table>
				<div class="pagination">
					<g:paginate total="${currencyInstanceCount ?: 0}" />
				</div>
			</div>
		</content>	
		<content tag="main-actions">
			<ul>
                            <li><g:link controller="currency" action="create" >New</g:link></li>
                            

			</ul>
		</content>
	</body>
</html>
