<%@ page import="icbs.gl.BillsPayable" %>
<!DOCTYPE html>
<html>
    <head>
	<meta name="layout" content="main">
	<title>Bills Payable Subsidiary Ledger Information</title>
    </head>
    <body>
        <content tag="breadcrumbs">
            <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/billsPayable')}">Bills Payable Subsidiary Ledger</a>
            <span class="fa fa-chevron-right"></span><span class="current">Bills Payable Subsidiary Ledger Information</span>
        </content>
        <content tag="main-content">
             <div id="show-billsPayable" class="content scaffold-show" role="main">
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
                            <td style="width:30%"><label>Currency</label></td>
                            <td style="width:70%">${billsPayableInstance?.currency?.name}</td>    
                        </tr>                         
                        <tr>
                            <td style="width:30%"><label>GL Account Code</label></td>
                            <td style="width:70%">${billsPayableInstance?.glContra}</td>    
                        </tr> 
                        <tr>
                            <td style="width:30%"><label>Creditor Name</label></td>
                            <td style="width:70%">${billsPayableInstance?.creditorName}</td>    
                        </tr> 
                        <tr>
                            <td style="width:30%"><label>Date Opened</label></td>
                            <td><g:formatDate  format="MM/dd/yyyy" date="${billsPayableInstance.dateOpened}" /></td>    
                        </tr>                        
                        <tr>
                            <td style="width:30%"><label>Maturity Date</label></td>
                            <td><g:formatDate  format="MM/dd/yyyy" date="${billsPayableInstance.dueDate}" /></td>    
                        </tr>
                        <tr>
                            <td style="width:30%"><label>Promissory Note Date</label></td>
                            <td><g:formatDate  format="MM/dd/yyyy" date="${billsPayableInstance.pnDate}" /></td>    
                        </tr>  
                        <tr>
                            <td style="width:30%"><label>Promissory Note Number</label></td>
                            <td style="width:70%">${billsPayableInstance?.pnNo}</td>    
                        </tr>
                        <tr>
                            <td style="width:30%"><label>Post Dated Check Issued</label></td>
                            <td style="width:70%">${billsPayableInstance?.pdcIssuedText}</td>  
                        </tr>  
                        <tr>
                            <td style="width:30%"><label>Account Name</label></td>
                            <td style="width:70%">${billsPayableInstance?.accountName}</td>    
                        </tr>   
                        <tr>
                            <td style="width:30%"><label>Payee</label></td>
                            <td style="width:70%">${billsPayableInstance?.payee}</td>    
                        </tr>   
                        <tr>
                            <td style="width:30%"><label>Interest Rate</label></td>
                            <td style="width:70%"><g:formatNumber format="###,###,##0.00" number="${billsPayableInstance?.interestRate}"/></td>    
                        </tr>  
                    </tbody>
                </table>                                  
            </div>
        </content>	
        <content tag="main-actions">
            <ul>
                <li><g:link action="edit" controller="billsPayable" id="${billsPayableInstance.id}" >Edit</g:link></li>
                <li><g:link action="viewTransactions" controller="billsPayable" id="${billsPayableInstance.id}" >View Bills Payable Transactions</g:link></li>
                <li><g:link action="bpDebit" controller="billsPayable"  id="${billsPayableInstance.id}">Bills Payable Debit</g:link></li>
                <li><g:link action="bpCredit" controller="billsPayable"  id="${billsPayableInstance.id}">Bills Payable Credit</g:link></li>
                <li><g:link action="index" controller="billsPayable" >Bills Payable List</g:link></li>
            </ul>
        </content>
    </body>
</html>
