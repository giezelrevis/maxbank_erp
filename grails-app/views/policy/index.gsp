
<%@ page import="icbs.admin.Policy" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'policy.label', default: 'Policy')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>

		<content tag="breadcrumbs">
          <span class="fa fa-chevron-right"></span><span class="current">Policy Management</span>
		</content>

            <content tag="main-content">   
		<div id="list-policy" class="content scaffold-list" role="main">
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

						<g:sortableColumn property="description" title="${message(code: 'policy.description.label', default: 'Description')}" />

						<th><g:message code="policy.type.label" default="Type" /></th>
					
						<th><g:message code="policy.policyTemplate.label" default="Policy Template" /></th>

						<g:sortableColumn width="150px" property="txnAmtCondition" title="${message(code: 'policy.txnAmtCondition.label', default: 'Transaction Amount Condition')}" />

						<th><g:message code="policy.policyAction.label" default="Policy Action" /></th>
					
						<g:sortableColumn property="reference" title="${message(code: 'policy.reference.label', default: 'Reference')}" />
					
						<th><g:message code="policy.configItemStatus.label" default="Config Item Status" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${policyInstanceList}" status="i" var="policyInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${policyInstance.id}">${fieldValue(bean: policyInstance, field: "description")}</g:link></td>

						<td>${fieldValue(bean: policyInstance, field: "policyTemplate.type")}</td>
					
						<td>${fieldValue(bean: policyInstance, field: "policyTemplate.description")}</td>

						<td>${fieldValue(bean: policyInstance, field: "txnAmtCondition")}</td>

						<td>${fieldValue(bean: policyInstance, field: "policyAction.description")}</td>
					
						<td>${fieldValue(bean: policyInstance, field: "reference")}</td>
					
						<td>${fieldValue(bean: policyInstance, field: "configItemStatus.description")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${PolicyInstanceCount ?: 0}" params="${params}" />
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
