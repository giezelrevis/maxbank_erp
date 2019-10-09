<%@ page import="icbs.gl.CashInBank" %>
<%@ page import="icbs.gl.CashInBankLedger" %>
<!DOCTYPE html>
<html>
    <head>
	<meta name="layout" content="main">
	<title>Cash in Bank Ledger Transactions</title>
    </head>
    <body>

        <content tag="main-content">
            <div class="panel panel-default">
            <g:render template="cashInBankDetails"/>
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
				<g:sortableColumn property="txnDate" title="${message(code: 'cashInBankLedger.txnDate.label', default: 'Txn Date')}" />
				<g:sortableColumn property="valueDate" title="${message(code: 'cashInBankLedger.valueDate.label', default: 'Value Date')}" />
                                <g:sortableColumn property="reference" title="${message(code: 'cashInBankLedger.reference.date', default: 'References')}" />
				<g:sortableColumn property="particulars" title="${message(code: 'cashInBankLedger.particulars.label', default: 'Particulars')}" />
				<g:sortableColumn property="debitAmt" title="${message(code: 'cashInBankLedger.debitAmt.label', default: 'Debit Amount')}" />
				<g:sortableColumn property="creditAmt" title="${message(code: 'cashInBankLedger.creditAmt.label', default: 'Credit Amount')}" />
				<g:sortableColumn property="balanceAmt" title="${message(code: 'cashInBankLedger.balanceAmt.label', default: 'Balance Amount')}" />
				<g:sortableColumn property="checkbook" title="${message(code: 'cashInBankLedger.checkbook.label', default: 'Checkbook')}" />
                            </tr>
			</thead>
			<tbody>
                            <g:each in="${CashInBankLedger.findAllByCashInBank(cashInBankInstance)}" status="i" var="cashInBankLedgerInstance">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                    <td><g:formatDate format="MM/dd/yyyy" date="${cashInBankLedgerInstance?.txnDate}"/></td>
                                    <td><g:formatDate format="MM/dd/yyyy" date="${cashInBankLedgerInstance?.valueDate}"/></td>
                                    <td>${cashInBankLedgerInstance?.reference}</td>
                                    <td>${cashInBankLedgerInstance?.particulars}</td>
                                    <g:if test="${cashInBankLedgerInstance?.debitAmt == 0}">
                                        <td></td>
                                    </g:if> 
                                    <g:else>    
                                    <td align = "right"><g:formatNumber format="###,###,##0.00" number="${cashInBankLedgerInstance?.debitAmt}"/></td>
                                    </g:else>
                                    <g:if test="${cashInBankLedgerInstance?.creditAmt == 0}">
                                        <td></td>
                                    </g:if> 
                                    <g:else>   
                                    <td align = "right"><g:formatNumber format="###,###,##0.00" number="${cashInBankLedgerInstance?.creditAmt}"/></td>
                                    </g:else>   
                                    <td align = "right"><g:formatNumber format="###,###,##0.00" number="${cashInBankLedgerInstance?.balanceAmt}"/></td>
                                    <td>${cashInBankLedgerInstance?.checkbook}</td>
				</tr>
                            </g:each>
			</tbody>
                    </table>
                </div>
                </div>
            </div>
		<div class="pagination">
                    <g:paginate total="${CashInBankInstanceCount ?: 0}" params="${params}" />
		</div>
        </content>	

        <content tag="main-actions">
            <ul>
                <li><g:link action="edit" controller="cashInBank" id="${cashInBankInstance.id}" >Edit</g:link></li>
                <li><g:link action="show" controller="cashInBank" id="${cashInBankInstance.id}" >View Details</g:link></li>
                <li><g:link action="index" controller="cashInBank" id="${cashInBankInstance.id}">Cash in Bank List</g:link></li>
            </ul>
        </content>
    </body>
</html>
