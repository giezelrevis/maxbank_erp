
<%@ page import="icbs.gl.GlBatch" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'glBatch.label', default: 'GlBatch')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
            <content tag="main-content">   
		<div id="list-glBatch" class="content scaffold-list" role="main">
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
					
						<g:sortableColumn property="amount" title="${message(code: 'glBatch.amount.label', default: 'Amount')}" />
					
						<g:sortableColumn property="batchId" title="${message(code: 'glBatch.batchId.label', default: 'Batch Id')}" />
					
						<g:sortableColumn property="batchType" title="${message(code: 'glBatch.batchType.label', default: 'Batch Type')}" />
					
						<th><g:message code="glBatch.creditGL.label" default="Credit GL" /></th>
					
						<th><g:message code="glBatch.debitGl.label" default="Debit Gl" /></th>
					
						<g:sortableColumn property="lineNo" title="${message(code: 'glBatch.lineNo.label', default: 'Line No')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${glBatchInstanceList}" status="i" var="glBatchInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${glBatchInstance.id}"><g:formatNumber format="###,###,##0.00" number="${glBatchInstance?.amount}"/></g:link></td>
					
						<td>${fieldValue(bean: glBatchInstance, field: "batchId")}</td>
					
						<td>${fieldValue(bean: glBatchInstance, field: "batchType")}</td>
					
						<td>${fieldValue(bean: glBatchInstance, field: "creditGL")}</td>
					
						<td>${fieldValue(bean: glBatchInstance, field: "debitGl")}</td>
					
						<td>${fieldValue(bean: glBatchInstance, field: "lineNo")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${GlBatchInstanceCount ?: 0}" params="${params}" />
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
