
<%@ page import="icbs.gl.TxnGlLink" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'txnGlLink.label', default: 'TxnGlLink')}" />
		<title>GL Link Transactions</title>
	</head>
	<body>
            <content tag="main-content">   
		<div id="list-txnGlLink" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
                        <g:form class="form-inline">
				<div class="form-group">
					<g:select name="max" value="${params.max}" from="[25, 50, 75, 100]" class="form-control input-sm pull-left"onchange="this.form.submit()" />
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
						<g:sortableColumn property="description" title="${message(code: 'txnGlLink.description.label', default: 'Description')}" />
						
						<g:sortableColumn property="status" title="${message(code: 'txnGlLink.status.label', default: 'Status')}" />
					
						
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${txnGlLinkInstanceList}" status="i" var="txnGlLinkInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${txnGlLinkInstance.id}">${fieldValue(bean: txnGlLinkInstance, field: "description")}</g:link></td>
					
						<td>${fieldValue(bean: txnGlLinkInstance, field: "status")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${TxnGlLinkInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <!-- <li><g:link class="create" action="create">New GL Transaction Link</g:link></li> -->
		</ul>
            </content>
	</body>
</html>
