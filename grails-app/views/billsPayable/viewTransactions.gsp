<%@ page import="icbs.gl.BillsPayable" %>
<%@ page import="icbs.gl.BillsPayableLedger" %>
<!DOCTYPE html>
<html>
    <head>
	<meta name="layout" content="main">
	<title>Bills Payable Ledger Transactions</title>
    </head>
    <body>

        <content tag="main-content">
            <div class="panel panel-default">
           <table class="table table-bordered table-rounded table-striped table-hover">
                <tbody>
                    <tr>
                        <legend>${billsPayableInstance?.accountName} - ${billsPayableInstance?.glContra}</legend>
                    </tr>
                    <tr>
                        <td style="width:30%"><label>Branch</label></td>
                        <td>${billsPayableInstance?.branch?.name}</td> 
                    </tr>  
                    <tr>
                        <td style="width:30%"><label>Creditor Name</label></td>
                        <td>${billsPayableInstance?.creditorName}</td> 
                    </tr>  
                    <tr>
                        <td style="width:30%"><label>Date Opened</label></td>
                        <td><g:formatDate  format="MM/dd/yyyy" date="${billsPayableInstance?.dateOpened}" /></td> 
                    </tr> 
                    <tr>
                        <td><label>Balance</label></td>
                        <td><g:formatNumber format="###,###,##0.00" number="${billsPayableInstance?.principal}"/></td>    
                    </tr> 
                </tbody>
             </table>
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
				<g:sortableColumn property="refDate" title="${message(code: 'billsPayableLedger.refDate.label', default: 'Ref Date')}" />
				<g:sortableColumn property="valueDate" title="${message(code: 'billsPayableLedger.valueDate.label', default: 'Value Date')}" />
                                <g:sortableColumn property="reference" title="${message(code: 'billsPayableLedger.reference.date', default: 'References')}" />
				<g:sortableColumn property="particulars" title="${message(code: 'billsPayableLedger.particulars.label', default: 'Particulars')}" />
				<g:sortableColumn property="debit" title="${message(code: 'billsPayableLedger.debit.label', default: 'Debit Amount')}" />
				<g:sortableColumn property="credit" title="${message(code: 'billsPayableLedger.credit.label', default: 'Credit Amount')}" />
				<g:sortableColumn property="balance" title="${message(code: 'billsPayableLedger.balance.label', default: 'Balance Amount')}" />
                            </tr>
                       </thead>
			<tbody>
                            <g:each in="${BillsPayableLedger.findAllByBillsPayable(billsPayableInstance)}" status="i" var="billsPayableLedgerInstance">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                    <td><g:formatDate format="MM/dd/yyyy" date="${billsPayableLedgerInstance?.refDate}"/></td>
                                    <td><g:formatDate format="MM/dd/yyyy" date="${billsPayableLedgerInstance?.valueDate}"/></td>
                                    <td>${billsPayableLedgerInstance?.reference}</td>
                                    <td>${billsPayableLedgerInstance?.particulars}</td>
                                    <g:if test="${billsPayableLedgerInstance?.debit == 0}">
                                        <td></td>
                                    </g:if> 
                                    <g:else>    
                                    <td align = "right"><g:formatNumber format="###,###,##0.00" number="${billsPayableLedgerInstance?.debit}"/></td>
                                    </g:else>
                                    <g:if test="${billsPayableLedgerInstance?.credit == 0}">
                                        <td></td>
                                    </g:if> 
                                    <g:else>   
                                    <td align = "right"><g:formatNumber format="###,###,##0.00" number="${billsPayableLedgerInstance?.credit}"/></td>
                                    </g:else>   
                                    <td align = "right"><g:formatNumber format="###,###,##0.00" number="${billsPayableLedgerInstance?.balance}"/></td>
				</tr>
                            </g:each>
			</tbody>
                    </table>
                </div>
                </div>
            </div>
		<div class="pagination">
                    <g:paginate total="${billsPayableLedgerInstanceCount ?: 0}" params="${params}" />
		</div>
        </content>	

        <content tag="main-actions">
            <ul>
                <li><g:link action="edit" controller="billsPayable" id="${billsPayableInstance.id}" >Edit</g:link></li>
                <li><g:link action="show" controller="billsPayable" id="${billsPayableInstance.id}" >View Details</g:link></li>
                <li><g:link action="index" controller="billsPayable" id="${billsPayableInstance.id}">Bills Payable List</g:link></li>
            </ul>
        </content>
    </body>
</html>
