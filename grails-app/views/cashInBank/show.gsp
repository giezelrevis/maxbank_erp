<%@ page import="icbs.gl.CashInBank" %>
<!DOCTYPE html>
<html>
    <head>
	<meta name="layout" content="main">
	<title>Cash in Bank Subsidiary Ledger Information</title>
    </head>
    <body>
        <content tag="breadcrumbs">
            <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/cashInBank')}">Cash in Bank/Due From Bank Subsidiary Ledger</a>
            <span class="fa fa-chevron-right"></span><span class="current">Cash in Bank Subsidiary Ledger Information</span>
        </content>
        <content tag="main-content">
             <div id="show-cashInBank" class="content scaffold-show" role="main">
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
                            <td style="width:30%"><label>Branch</label></td>
                            <td style="width:70%">${cashInBankInstance?.branch?.name}</td>    
                        </tr>                         
                        <tr>
                            <td style="width:30%"><label>Deposit Type</label></td>
                            <td style="width:70%">${cashInBankInstance?.type?.description}</td>    
                        </tr> 
                        <tr>
                            <td style="width:30%"><label>Deposit Currency</label></td>
                            <td style="width:70%">${cashInBankInstance?.currency?.code}</td>    
                        </tr> 
                        <tr>
                            <td style="width:30%"><label>Bank Name</label></td>
                            <td style="width:70%">${cashInBankInstance?.bankName}</td>    
                        </tr>                        
                        <tr>
                            <td style="width:30%"><label>Bank Branch</label></td>
                            <td style="width:70%">${cashInBankInstance?.bankBranch}</td>    
                        </tr>
                        <tr>
                            <td style="width:30%"><label>Bank Address</label></td>
                            <td style="width:70%">${cashInBankInstance?.bankAddress}</td>    
                        </tr>  
                        <tr>
                            <td style="width:30%"><label>Account Number</label></td>
                            <td style="width:70%">${cashInBankInstance?.acctNo}</td>    
                        </tr>
                        <tr>
                            <td style="width:30%"><label>Interest Rate</label></td>
                            <td style="width:70%"><g:formatNumber format="##0.00000" number="${cashInBankInstance?.intRate}"/>%</td>    
                        </tr>  
                        <tr>
                            <td style="width:30%"><label>Balance</label></td>
                            <td style="width:70%"><g:formatNumber format="###,###,##0.00" number="${cashInBankInstance?.balance}"/></td>    
                        </tr>   
                        <tr>
                            <td style="width:30%"><label>Open Date</label></td>
                            <td style="width:70%"><g:formatDate  format="MM/dd/yyyy" date="${cashInBankInstance?.openDate}" /></td>    
                        </tr>   
                        <tr>
                            <td style="width:30%"><label>Maturity Date</label></td>
                            <td style="width:70%"><g:formatDate  format="MM/dd/yyyy" date="${cashInBankInstance?.maturityDate}" /></td>    
                        </tr>  
                        <tr>
                            <td style="width:30%"><label>User</label></td>
                            <td style="width:70%">${cashInBankInstance?.user?.name}</td>    
                        </tr>
                        <tr>
                            <td style="width:30%"><label>Create Date</label></td>
                            <td style="width:70%"><g:formatDate  format="MM/dd/yyyy" date="${cashInBankInstance?.createDate}" /></td>    
                        </tr> 
                        <tr>
                            <td style="width:30%"><label>GL Account Code</label></td>
                            <td style="width:70%">${cashInBankInstance?.glContra}</td>    
                        </tr>
                        <tr>
                            <td style="width:30%"><label>Status</label></td>
                            <td style="width:70%">${cashInBankInstance?.status?.description}</td>    
                        </tr>  
                        <tr>
                            <td style="width:30%"><label>Remarks</label></td>
                            <td style="width:70%">${cashInBankInstance?.remarks}</td>    
                        </tr>  
                    </tbody>
                </table>                                  
            </div>
        </content>	
	
        <content tag="main-actions">
            <ul>
                <g:if test="${cashInBankInstance.status.id == 2}">
                    <li><g:link action="edit" controller="cashInBank" id="${cashInBankInstance.id}" >Edit</g:link></li>
                </g:if>                    
                <li><g:link action="viewTransactions" controller="cashInBank" id="${cashInBankInstance.id}" >View Transactions</g:link></li>
                <g:if test="${cashInBankInstance.type.id == 2}">
                    <g:if test="${cashInBankInstance.status.id == 2}">
                        <li><g:link action="createCb" controller="cashInBank" id="${cashInBankInstance.id}">Create New Checkbook</g:link></li>																													  
                        <li><g:link action="checkbookList" controller="cashInBank" id="${cashInBankInstance.id}">Checkbook List</g:link></li>
                        <li><g:link action="createCheckTransaction" controller="cashInBank" id="${cashInBankInstance.id}">Check Voucher Transaction</g:link></li>
                    </g:if>
                </g:if>
                <g:else>
                    <g:if test="${cashInBankInstance.status.id == 2}">
                        <li><g:link action="cashWithdrawal" controller="cashInBank" id="${cashInBankInstance.id}">Cash Withdrawal</g:link></li>
                    </g:if>    
                </g:else>
                <g:if test="${cashInBankInstance.status.id == 2}">
                    <li><g:link action="cashAndCheckDeposit" controller="cashInBank" id="${cashInBankInstance.id}">Cash and Check Deposit</g:link></li>
                    <li><g:link action="cibDebit" controller="cashInBank" id="${cashInBankInstance.id}">Debit Adjustment</g:link></li>
                    <li><g:link action="creditAdjustment" controller="cashInBank" id="${cashInBankInstance.id}">Credit Adjustment</g:link></li>
                    <li><g:link action="cibClose" id="${cashInBankInstance.id}">Close Cash in Bank Account</g:link></li>
                </g:if>
                <li><g:link action="index" controller="cashInBank" id="${cashInBankInstance.id}">Cash in Bank List</g:link></li>
            </ul>
        </content>
    </body>
</html>
