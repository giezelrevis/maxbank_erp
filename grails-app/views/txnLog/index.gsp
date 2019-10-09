<%@ page import="icbs.tellering.TxnFile" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>
    <title>Transactions Logs</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="main">
  </head>
  <body>
    <content tag="breadcrumbs">
            <span class="fa fa-chevron-right"></span><span class="current">Transaction Logs</span>
    </content>  
    <content tag="main-content">
		<div id="list-txn" class="content scaffold-list" role="main">
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
					
						<g:sortableColumn property="id" title="${message(code: 'txnFile.id.label', default: 'Txn ID')}" />
					
						<g:sortableColumn property="acctNo" title="${message(code: 'txnFile.acctNo.label', default: 'Account No')}" />
					
						<g:sortableColumn property="branch" title="${message(code: 'txnFile.branch.label', default: 'Branch')}" />
                                                
						<g:sortableColumn property="user" title="${message(code: 'txnFile.user.label', default: 'User')}" />
                                                
                                                <g:sortableColumn property="txnType" title="${message(code: 'txnFile.txnType.label', default: 'Txn Type')}" />
                                                
                                                <g:sortableColumn property="txnDate" title="${message(code: 'txnFile.txnDate.label', default: 'Txn Date')}" />

						<g:sortableColumn property="txnParticulars" title="${message(code: 'txnFile.txnParticulars.label', default: 'Particulars')}" />
                                                
                                                <g:sortableColumn property="txnTimestamp" title="${message(code: 'txnFile.txnTimestamp.label', default: 'Date/Time Stamp')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${txnFileInstanceList}" status="i" var="txnFileInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
                                            <td>${fieldValue(bean: txnFileInstance, field: "id")}</td>
                                            
                                            <td>${fieldValue(bean: txnFileInstance, field: "acctNo")}</td>
					
                                            <td>${fieldValue(bean: txnFileInstance, field: "branch.name")}</td>
					
                                            <td>${fieldValue(bean: txnFileInstance, field: "user.username")}</td>
                                            
                                            <td>${txnFileInstance.txnType.description}</td>

                                            <td><g:formatDate date="${txnFileInstance.txnDate}" format="MM-dd-yyyy" /></td>

                                            <td>${fieldValue(bean: txnFileInstance, field: "txnParticulars")}</td>
                                            
                                            <td>${txnFileInstance.txnTimestamp}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${txnFileInstance ?: 0}" params="${params}" />
			</div>
		</div>

    </content>
    
  </body>
</html>
