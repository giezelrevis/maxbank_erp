<%@ page import="icbs.gl.AccountsReceivable" %>
<%@ page import="icbs.gl.AccountsReceivableLedger" %>
<!DOCTYPE html>
<html>
    <head>
	<meta name="layout" content="main">
	<title>Accounts Receivable Ledger Transactions</title>
    </head>
    <body>

        <content tag="main-content">
            <div class="panel panel-default">
                <div class="panel panel-default">
                    <div class="content scaffold-show" role="main">
                    <g:if test="${flash.message}">
                        <div class="box-body">
                            <div class="alert alert-info alert-dismissable">
                                <i class="fa fa-info"></i>
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                <b>Message</b> <div class="message" role="status">${flash.message}</div>
                            </div>
                        </div>
                    </g:if>
                    <div class="panel-body">
                        <table class="table table-bordered table-rounded table-striped table-hover">
                            <tbody>
                                <tr>
                                    <td style = "width:30%;"><label>Branch</label></td>
                                    <td style = "width:70%;">${accountsReceivableInstance?.branch?.name}</td>    
                                </tr>
                                <tr>
                                    <td><label>Receivable</label></td>
                                    <td>${accountsReceivableInstance.receivableName}</td>    
                                </tr> 
                                <tr>
                                    <td><label>Description</label></td>
                                    <td>${accountsReceivableInstance.description}</td>    
                                </tr> 
                                <tr>
                                    <td><label>Balance</label></td>
                                    <td><g:formatNumber format="###,###,##0.00" number="${accountsReceivableInstance.balance}"/></td>    
                                </tr> 
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            </div>
            <div class="panel panel-default">
                <div class = "panel-heading">
                    <h4>Transaction Details</h4>
                </div>
                <div class="panel-body">
                <div class="table-responsive">
                     <table class="table table-bordered table-rounded table-striped table-hover">
                        <thead>
                            <tr>
				<g:sortableColumn property="refDate" title="${message(code: 'accountsReceivableLedger.refDate.label', default: 'Ref Date')}" />
				<g:sortableColumn property="valueDate" title="${message(code: 'accountsReceivableLedger.valueDate.label', default: 'Value Date')}" />
                                <g:sortableColumn property="reference" title="${message(code: 'accountsReceivableLedger.reference.date', default: 'References')}" />
				<g:sortableColumn property="particulars" title="${message(code: 'accountsReceivableLedger.particulars.label', default: 'Particulars')}" />
				<g:sortableColumn property="debit" title="${message(code: 'accountsReceivableLedger.debit.label', default: 'Debit Amount')}" />
				<g:sortableColumn property="credit" title="${message(code: 'accountsReceivableLedger.credit.label', default: 'Credit Amount')}" />
				<g:sortableColumn property="balance" title="${message(code: 'accountsReceivableLedger.balance.label', default: 'Balance Amount')}" />
                            </tr>
			</thead>
			<tbody>
                            <g:each in="${AccountsReceivableLedger.findAllByAccountsReceivable(accountsReceivableInstance)}" status="i" var="accountsReceivableLedgerInstance">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                    <td><g:formatDate format="MM/dd/yyyy" date="${accountsReceivableLedgerInstance?.refDate}"/></td>
                                    <td><g:formatDate format="MM/dd/yyyy" date="${accountsReceivableLedgerInstance?.valueDate}"/></td>
                                    <td>${accountsReceivableLedgerInstance?.reference}</td>
                                    <td>${accountsReceivableLedgerInstance?.particulars}</td>
                                    <g:if test="${accountsReceivableLedgerInstance?.debit == 0}">
                                        <td></td>
                                    </g:if> 
                                    <g:else>    
                                    <td align = "right"><g:formatNumber format="###,###,##0.00" number="${accountsReceivableLedgerInstance?.debit}"/></td>
                                    </g:else>
                                    <g:if test="${accountsReceivableLedgerInstance?.credit == 0}">
                                        <td></td>
                                    </g:if> 
                                    <g:else>   
                                    <td align = "right"><g:formatNumber format="###,###,##0.00" number="${accountsReceivableLedgerInstance?.credit}"/></td>
                                    </g:else>   
                                    <td align = "right"><g:formatNumber format="###,###,##0.00" number="${accountsReceivableLedgerInstance?.balance}"/></td>
				</tr>
                            </g:each>
			</tbody>
                    </table>
                </div>
                </div>
            </div>
		<div class="pagination">
                    <g:paginate total="${accountsReceivableInstanceCount?: 0}" params="${params}" />
		</div>
        </content>	

        <content tag="main-actions">
            <ul>
                <li><g:link action="edit" controller="accountsReceivable" id="${accountsReceivableInstance.id}" >Edit</g:link></li>
                <li><g:link action="show" controller="accountsReceivable" id="${accountsReceivableInstance.id}" >View Details</g:link></li>
                <li><g:link action="index" controller="accountsReceivable" id="${accountsReceivableInstance.id}">Account Receivable List</g:link></li>
            </ul>
        </content>
    </body>
</html>
