
<%@ page import="icbs.admin.TxnTemplate" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'txnTemplate.label', default: 'TxnTemplate')}" />
		<title>Transaction Template List</title>
	</head>
	<body>
		<content tag="breadcrumbs">
	            <span class="fa fa-chevron-right"></span><span class="current">Transction Template List</span>
		</content>
	    <content tag="main-content">
		<div id="list-txnTemplate" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
                     
			<g:form class="form-inline">
				<div class="form-group">
					<g:select name="max" value="${params.max}" from="[200, 300]" class="form-control input-sm pull-left"onchange="this.form.submit()" />
				</div>
				<div class="right">
					<div class="form-group">
						<g:textField  type="text" name="query" class="form-control input-sm pull-right" style="width: 350px;" placeholder="Search"/>
					</div>
					<g:submitButton name="Search" class="btn btn-sm btn-default"><i class="fa fa-search"></i></g:submitButton>
				</div>
			</g:form>

			<div class="table-responsive">
            <table class="table table-bordered table-rounded table-striped table-hover">
                <thead>
					<tr>

						<g:sortableColumn property="code" title="${message(code: 'txnTemplate.code.label', default: 'Code')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'txnTemplate.description.label', default: 'Description')}" />

						<g:sortableColumn property="shortDescription" title="${message(code: 'txnTemplate.shortDescription.label', default: 'Short Description')}" />
					
						<th><g:message code="txnTemplate.txnModule.label" default="Txn Module" /></th>
					
						<th><g:message code="txnTemplate.txnType.label" default="Txn Type" /></th>
                                                <g:sortableColumn property="configItemStatus" title="${message(code: 'txnTemplate.shortDescription.label', default: 'Status')}" />

					</tr>
				</thead>
				<tbody>
				<g:each in="${txnTemplateInstanceList}" status="i" var="txnTemplateInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

						<td><g:link action="show" id="${txnTemplateInstance.id}">${fieldValue(bean: txnTemplateInstance, field: "code")}</g:link></td>

						<td>${fieldValue(bean: txnTemplateInstance, field: "description")}</td>

						<td>${fieldValue(bean: txnTemplateInstance, field: "shortDescription")}</td>

						<td>${fieldValue(bean: txnTemplateInstance, field: "txnType.description")}</td>
					
						<td>${fieldValue(bean: txnTemplateInstance, field: "txnModule.description")}</td>
                                                <td>${fieldValue(bean: txnTemplateInstance, field: "configItemStatus.description")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${TxnTemplateInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                    <li><g:link action="create">New Transaction Template</g:link></li>
                </ul>
            </content>
	</body>
</html>
