
<%@ page import="icbs.deposit.Deposit" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'deposit.label', default: 'Deposit')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
            <content tag="main-content">   
		<div id="list-deposit" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
                        <g:form>
                            <div class="input-group">
                                <g:select name="max" value="${params.max}" from="[5, 10, 15, 20]" class="form-control input-sm pull-left"onchange="this.form.submit()" />
                            </div>
                            <div class="input-group">
                                <g:textField  type="text" name="query" class="form-control input-sm pull-right" style="width: 150px;" placeholder="Search"/>
                                <div class="input-group-btn">
                                    <g:submitButton name="search" class="btn btn-sm btn-default"><i class="fa fa-search"></i></g:submitButton>
                                </div>
                            </div>
                        </g:form>
			<div class="table-responsive">
                            <table class="table table-hover table-condensed table-bordered table-striped">
                                <thead>
					<tr>
					
						<th><g:message code="deposit.branch.label" default="Branch" /></th>
					
						<th><g:message code="deposit.depositType.label" default="Deposit Type" /></th>
					
						<g:sortableColumn property="acctNo" title="${message(code: 'deposit.acctNo.label', default: 'Acct No')}" />
					
						<th><g:message code="deposit.acctNoFormat.label" default="Acct No Format" /></th>
					
						<th><g:message code="deposit.ownershipType.label" default="Ownership Type" /></th>
					
						<g:sortableColumn property="sigRules" title="${message(code: 'deposit.sigRules.label', default: 'Sig Rules')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${depositInstanceList}" status="i" var="depositInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${depositInstance.id}">${fieldValue(bean: depositInstance, field: "branch")}</g:link></td>
					
						<td>${fieldValue(bean: depositInstance, field: "depositType")}</td>
					
						<td>${fieldValue(bean: depositInstance, field: "acctNo")}</td>
					
						<td>${fieldValue(bean: depositInstance, field: "acctNoFormat")}</td>
					
						<td>${fieldValue(bean: depositInstance, field: "ownershipType")}</td>
					
						<td>${fieldValue(bean: depositInstance, field: "sigRules")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${DepositInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                    <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
		</ul>
            </content>
	</body>
</html>
