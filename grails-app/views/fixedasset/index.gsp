
<%@ page import="accounting.fixedasset.Bankasset" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'bankasset.label', default: 'Bankasset')}" />
		<title>Fixed Asset</title>
	</head>
	<body>
		<content tag="breadcrumbs">
          <span class="fa fa-chevron-right"></span><span class="current">Fixed Asset List</span>
		</content>

            <content tag="main-content">   
		<div id="list-bankasset" class="content scaffold-list" role="main">
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
					
						<th><g:message code="bankasset.assetcode.label" default="assetcode" /></th>
					
						<g:sortableColumn property="assetdesc" title="${message(code: 'bankasset.assetdesc.label', default: 'assetdesc')}" />
					
						<g:sortableColumn property="purcost" title="${message(code: 'bankasset.purcost.label', default: 'purcost')}" />
					
						<g:sortableColumn property="purdate" title="${message(code: 'bankasset.purdate.label', default: 'purdate')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${bankassetInstanceList}" status="i" var="bankassetInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${bankassetInstance.id}">${fieldValue(bean: bankassetInstance, field: "assetcode")}</g:link></td>
					
						<td>${fieldValue(bean: bankassetInstance, field: "assetdesc")}</td>
					
						<td>${fieldValue(bean: bankassetInstance, field: "purcost")}</td>
					
						<td>${fieldValue(bean: bankassetInstance, field: "purdate")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${BankassetInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><g:link class="create" action="create">New Asset</g:link></li>
				</ul>
            </content>
	</body>
</html>
