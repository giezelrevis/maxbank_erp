<%@ page import="icbs.gl.CashInBank" %>
<%@ page import="icbs.gl.CashInBankCheckbook" %>
<!DOCTYPE html>
<html>
    <head>
	<meta name="layout" content="main">
	<title>Cash in Bank Subsidiary Ledger Checkbook List</title>
    </head>
    <body>

        <content tag="main-content">
            <g:render template="cashInBankDetails"/>
            
            <br></br>
            <h3>Checkbooks</h3>
		<div class="table-responsive">
                    <table class="table table-bordered table-rounded table-striped table-hover">
                        <thead>
                            <tr>
				<g:sortableColumn property="checkNo" title="${message(code: 'CashInBankCheckbook.checkNo.label', default: 'Check Number')}" />
				<g:sortableColumn property="checkDate" title="${message(code: 'CashInBankCheckbook.checkDate.label', default: 'Check Date')}" />
				<g:sortableColumn property="payee" title="${message(code: 'CashInBankCheckbook.payee.label', default: 'Payee')}" />
                                <g:sortableColumn property="checkAmt" title="${message(code: 'CashInBankCheckbook.checkAmt.date', default: 'Amount')}" />
				<g:sortableColumn property="checkStatus" title="${message(code: 'CashInBankCheckbook.checkStatus.label', default: 'Status')}" />
				<td><label>Action</label></td>
                            </tr>
			</thead>
			<tbody>
                            <g:each in="${CashInBankCheckbook.findAllByCashInBank(cashInBankInstance)}" status="i" var="cbInstance">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                    <td>${cbInstance?.checkNo}</td>
                                    <td><g:formatDate format="MM/dd/yyyy" date="${cbInstance?.checkDate}"/></td>
                                    <td>${cbInstance?.payee}</td>
                                    <td><g:formatNumber format="###,###,###,##0.00" number="${cbInstance?.checkAmt}"/></td>
                                    <td>${cbInstance?.checkStatus}</td>
                                    <td><g:link class="btn btn-secondary" action="chkDetails" id="${cbInstance.id}">View Details</g:link></td>
				</tr>
                            </g:each>
			</tbody>
                    </table>
                </div>
                    
        </content>	

        <content tag="main-actions">
            <ul>
                <li><g:link action="show" controller="cashInBank" id="${cashInBankInstance.id}" >Cash in Bank Details</g:link></li>
                <li><g:link action="createCb" controller="cashInBank" id="${cashInBankInstance.id}">Create New Checkbook</g:link></li>
                <li><g:link action="index" controller="cashInBank" id="${cashInBankInstance.id}">Check Voucher Transaction</g:link></li>
                <li><g:link action="index" controller="cashInBank" id="${cashInBankInstance.id}">Cash in Bank List</g:link></li>
            </ul>
        </content>
    </body>
</html>
