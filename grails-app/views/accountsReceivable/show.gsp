<%@ page import="icbs.gl.AccountsReceivable" %>
<!DOCTYPE html>
<html>
    <head>
	<meta name="layout" content="main">
	<title>Accounts Receivable Subsidiary Ledger Information</title>
    </head>
    <body>
        <content tag="main-content">
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
                            <td><label>Reference</label></td>
                            <td>${accountsReceivableInstance.reference}</td>    
                        </tr> 
                        <tr>
                            <td><label>Currency</label></td>
                            <td>${accountsReceivableInstance?.currency?.code}</td>    
                        </tr> 
                        <tr>
                            <td><label>GL Code</label></td>
                            <td>${accountsReceivableInstance.glContra}</td>    
                        </tr> 
                        <tr>
                            <td><label>Booking Date</label></td>
                            <td><g:formatDate  format="MM/dd/yyyy" date="${accountsReceivableInstance.bookingDate}" /></td>    
                        </tr> 
                        <tr>
                            <td><label>Balance</label></td>
                            <td><g:formatNumber format="###,###,##0.00" number="${accountsReceivableInstance.balance}"/></td>    
                        </tr> 
                        <tr>
                            <td><label>Required Valuation Reserves</label></td>
                            <td><g:formatNumber format="###,###,##0.00" number="${accountsReceivableInstance.requiredValuationReserves}"/></td>    
                        </tr> 
                        <tr>
                            <td><label>User</label></td>
                            <td>${accountsReceivableInstance?.user?.name}</td>    
                        </tr> 
                        <tr>
                            <td><label>Status</label></td>
                            <td>${accountsReceivableInstance.status}</td>    
                        </tr> 
                    </tbody>
                </table>
            </div>
        </content>		

        <content tag="main-actions">
            <ul>
                <li><g:link action="edit" controller="accountsReceivable" id="${accountsReceivableInstance.id}" >Edit</g:link></li>
                <li><g:link action="viewTransactions" controller="accountsReceivable" id="${accountsReceivableInstance.id}">View Accounts Receivable Transactions</g:link></li>
                <li><g:link action="arDebit" id="${accountsReceivableInstance.id}">Accounts Receivable Debit</g:link></li>
                <li><g:link action="arCredit" id="${accountsReceivableInstance.id}">Accounts Receivable Credit</g:link></li>
                <li><g:link action="index" id="${accountsReceivableInstance.id}">Accounts Receivable List</g:link></li>
            </ul>
        </content>
    </body>
</html>
