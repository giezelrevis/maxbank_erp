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

             <div id="show-cashInBank" class="content scaffold-show" role="main">
                
		<table class="table table-bordered table-rounded table-striped table-hover">
                    <tbody>
                        <tr>
                            <td style="width:30%"><label>Check Number</label></td>
                            <td style="width:70%">${cashInBankCheckbookInstance?.checkNo}</td>    
                        </tr>                         

                        <tr>
                            <td style="width:30%"><label>Check Voucher Number</label></td>
                            <td style="width:70%">${cashInBankCheckbookInstance?.checkVoucherNo}</td>    
                        </tr> 
                        <tr>
                            <td style="width:30%"><label>Reference</label></td>
                            <td style="width:70%">${cashInBankCheckbookInstance?.reference}</td>    
                        </tr>                         
                        <tr>
                            <td style="width:30%"><label>Check Date</label></td>
                            <td style="width:70%"><g:formatDate  format="MM/dd/yyyy" date="${cashInBankCheckbookInstance?.checkDate}" /></td>    
                        </tr>                        
                        <tr>
                            <td style="width:30%"><label>Payee</label></td>
                            <td style="width:70%">${cashInBankCheckbookInstance?.payee}</td>    
                        </tr>
                        <tr>
                            <td style="width:30%"><label>Particulars</label></td>
                            <td style="width:70%">${cashInBankCheckbookInstance?.particulars}</td>    
                        </tr>  
                        <tr>
                            <td style="width:30%"><label>Release Date</label></td>
                            <td style="width:70%"><g:formatDate  format="MM/dd/yyyy" date="${cashInBankCheckbookInstance?.releaseDate}" /></td>    
                        </tr> 
                        <tr>
                            <td style="width:30%"><label>Check Amount</label></td>
                            <td style="width:70%"><g:formatNumber format="###,###,##0.00" number="${cashInBankCheckbookInstance?.checkAmt}"/></td>    
                        </tr>    
                        <tr>
                            <td style="width:30%"><label>Issued By</label></td>
                            <td style="width:70%">${cashInBankCheckbookInstance?.issuedBy?.name}</td>    
                        </tr>
                        <tr>
                            <td style="width:30%"><label>Approved By</label></td>
                            <td style="width:70%">${cashInBankCheckbookInstance?.approvedBy?.name}</td>    
                        </tr>                       
                        <tr>
                            <td style="width:30%"><label>Created By</label></td>
                            <td style="width:70%">${cashInBankCheckbookInstance?.createdBy?.name}</td>    
                        </tr>
                        <tr>
                            <td style="width:30%"><label>Create Date</label></td>
                            <td style="width:70%"><g:formatDate  format="MM/dd/yyyy" date="${cashInBankCheckbookInstance?.approveDate}" /></td>    
                        </tr> 
                        <tr>
                            <td style="width:30%"><label>Status</label></td>
                            <td style="width:70%">${cashInBankCheckbookInstance?.checkStatus?.description}</td>    
                        </tr>   
                    </tbody>
                </table>                                  
            </div>
                    
        </content>	

        <content tag="main-actions">
            <ul>
                <li><g:link action="show" controller="cashInBank" id="${cashInBankCheckbookInstance.cashInBank.id}" >Cash in Bank Details</g:link></li>
                <li><g:link action="index" controller="cashInBank">Cash in Bank List</g:link></li>
            </ul>
        </content>
    </body>
</html>
