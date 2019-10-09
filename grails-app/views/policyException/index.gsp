
<%@ page import="icbs.admin.PolicyException" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'policyException.label', default: 'PolicyException')}" />
		<title>Policy Exception List</title>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><span class="current">Policy Exception List</span>
            </content>
            <content tag="main-content">   
		<div id="list-policyException" class="content scaffold-list" role="main">
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
                            <table class="table table-hover table-condensed table-bordered table-striped">
                                <thead>
					<tr>
					
						
					
						<g:sortableColumn property="dateOfRequest" title="${message(code: 'policyException.dateOfRequest.label', default: 'Exception Date')}" />

						<g:sortableColumn property="requestingUser" title="${message(code: 'policyException.requestingUser.label', default: 'Created By')}" />
					
						<th><g:message code="policyException.policyTemplate.label" default="Policy" /></th>

						<th>Action Taken</th>
						<th>Action By</th>
						<th>Date of Action</th>
					
						<g:sortableColumn property="recordUrl" title="${message(code: 'policyException.recordUrl.label', default: 'Take Action')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${policyExceptionInstanceList}" status="i" var="policyExceptionInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
					
					
						<td><g:formatDate date="${policyExceptionInstance.dateOfRequest}" /></td>

						<td>${fieldValue(bean: policyExceptionInstance, field: "requestingUser.name")}</td>
					
						<td>${fieldValue(bean: policyExceptionInstance, field: "policyTemplate.description")}</td>

						<td>
						<g:if test="${policyExceptionInstance.dateOfAction}">
							<g:formatBoolean boolean="${policyExceptionInstance?.isApproved}" true="Approved" false="Disapproved" />
						</g:if>
						</td>

						<td>${fieldValue(bean: policyExceptionInstance, field: "approvingUser.name")}</td>

						<td><g:formatDate date="${policyExceptionInstance.dateOfAction}" /></td>
					
						<td><a href="/icbs/${fieldValue(bean: policyExceptionInstance, field: "recordUrl")}" target="_self">Go to Record</a></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${PolicyExceptionInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
				</ul>
            </content>
	</body>
</html>
