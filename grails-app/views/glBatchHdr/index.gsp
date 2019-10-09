
<%@ page import="icbs.gl.GlBatchHdr" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'glBatchHdr.label', default: 'GlBatchHdr')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
            <content tag="main-content">   
		<div id="list-glBatchHdr" class="content scaffold-list" role="main">
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
					
						<th><g:message code="glBatchHdr.contraGl.label" default="Contra Gl" /></th>
					
						<th><g:message code="glBatchHdr.errorGl.label" default="Error Gl" /></th>
					
						<g:sortableColumn property="batchType" title="${message(code: 'glBatchHdr.batchType.label', default: 'Batch Type')}" />
					
						<g:sortableColumn property="batchParticulars" title="${message(code: 'glBatchHdr.batchParticulars.label', default: 'Batch Particulars')}" />
					
						<th><g:message code="glBatchHdr.loanAcct.label" default="Loan Acct" /></th>
					
						<g:sortableColumn property="txnType" title="${message(code: 'glBatchHdr.txnType.label', default: 'Txn Type')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${glBatchHdrInstanceList}" status="i" var="glBatchHdrInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${glBatchHdrInstance.id}">${fieldValue(bean: glBatchHdrInstance, field: "contraGl")}</g:link></td>
					
						<td>${fieldValue(bean: glBatchHdrInstance, field: "errorGl")}</td>
					
						<td>${fieldValue(bean: glBatchHdrInstance, field: "batchType")}</td>
					
						<td>${fieldValue(bean: glBatchHdrInstance, field: "batchParticulars")}</td>
					
						<td>${fieldValue(bean: glBatchHdrInstance, field: "loanAcct")}</td>
					
						<td>${fieldValue(bean: glBatchHdrInstance, field: "txnType")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${GlBatchHdrInstanceCount ?: 0}" params="${params}" />
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
