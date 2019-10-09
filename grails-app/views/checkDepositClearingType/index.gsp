
<%@ page import="icbs.admin.CheckDepositClearingType" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'checkDepositClearingType.label', default: 'CheckDepositClearingType')}" />
		<title>Check Deposit Clearing Type</title>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><span class="current">Check Deposit Clearing Type</span>
            </content>
            <content tag="main-content">   
			<div id="list-checkDepositClearingType" class="content scaffold-list" role="main">
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
                                            
						<g:sortableColumn property="code" title="${message(code: 'checkDepositClearingType.code.label', default: 'Code')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'checkDepositClearingType.description.label', default: 'Description')}" />
					
					
						<g:sortableColumn property="isOnUs" title="${message(code: 'checkDepositClearingType.isOnUs.label', default: 'Is On Us')}" />
					
						<g:sortableColumn property="clearingDays" title="${message(code: 'checkDepositClearingType.clearingDays.label', default: 'Clearing Days')}" />

						<g:sortableColumn property="configItemStatus" title="${message(code: 'currency.configItemStatus.label', default: 'Status')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${checkDepositClearingTypeInstanceList}" status="i" var="checkDepositClearingTypeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                            <g:if test="${checkDepositClearingTypeInstance?.configItemStatusId==2}">
						<td><g:link action="show" id="${checkDepositClearingTypeInstance.id}">${fieldValue(bean: checkDepositClearingTypeInstance, field: "code")}</g:link></td>
					
						<td>${fieldValue(bean: checkDepositClearingTypeInstance, field: "description")}</td>
					
						<td><g:formatBoolean boolean="${checkDepositClearingTypeInstance.isOnUs}" /></td>
					
						<td>${fieldValue(bean: checkDepositClearingTypeInstance, field: "clearingDays")}</td>

						<td>${fieldValue(bean: checkDepositClearingTypeInstance, field: "configItemStatus.description")}</td>
                                            </g:if>
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${CheckDepositClearingTypeInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><g:link class="create" action="create">New Check Deposit Clearing Type</g:link></li>
				</ul>
            </content>
	</body>
</html>
