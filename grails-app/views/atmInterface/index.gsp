

<%@ page import="icbs.atm.AtmTxn" %>
<!DOCTYPE html>


<html>
    <head>

	<meta name="layout" content="main">
	
        <g:set var="entityName" value="${message(code: 'AtmTxn.label', default: 'ATM Interface')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        
  		<content tag="breadcrumbs">
          <span class="fa fa-chevron-right"></span><span class="current">Atm Interface List</span>
		</content>

        <content tag="main-content">   
		<div id="list-atm_txn" class="content scaffold-list" role="main">
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
					
						<g:sortableColumn property="txnDate" title="${message(code: 'AtmTxn.txnDate.label', default: 'Txn Date')}" />
					
						<g:sortableColumn property="mti" title="${message(code: 'AtmTxn.mti.label', default: 'MTI')}" />
					
						<g:sortableColumn property="acct1" title="${message(code: 'AtmTxn.acct1.label', default: 'Acct1')}" />
					
						<g:sortableColumn property="atmCardNumber" title="${message(code: 'AtmTxn.atmCardNumber.label', default: 'Atm Card Number')}" />

						<g:sortableColumn property="txnCode" title="${message(code: 'AtmTxn.txnCode.label', default: 'Txn Code')}" />

						<g:sortableColumn property="txnAmt" title="${message(code: 'AtmTxn.txnAmt.label', default: 'Txn Amt')}" />
                                                
                                                <g:sortableColumn property="txnRef" title="${message(code: 'AtmTxn.txnRef.label', default: 'Txn Ref')}" />
                                                
                                                <th>Action</th>
					
					</tr>
				</thead>
				<tbody>
                                
				<g:each in="${atmTxnListInstance}" status="i" var="branchInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						
					
						<td>${fieldValue(bean: branchInstance, field: "txnDate")}</td>
					
						<td>${fieldValue(bean: branchInstance, field: "mti")}</td>
					
						<td>${fieldValue(bean: branchInstance, field: "acct1")}</td>

						<td>${fieldValue(bean: branchInstance, field: "atmCardNumber")}</td>

						<td>${fieldValue(bean: branchInstance, field: "txnCode")}</td>
                                                <td>${fieldValue(bean: branchInstance, field: "txnAmt")}</td>
                                                <td>${fieldValue(bean: branchInstance, field: "txnRef")}</td>
                                                
                                                <td><g:link class="btn btn-primary" controller="ATMInterface" action="viewAtmInterface" id="${branchInstance.id}" params="['atmtxnid': branchInstance.id]">View</g:link></td>    
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${BranchInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>

        <content tag="main-actions">
            <ul>

                    <!--
                    <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
                    -->
                <li><g:link action="atmTerminalView">View ATM Terminals</g:link></li>
            </ul>
        </content>
    </body>
</html>
