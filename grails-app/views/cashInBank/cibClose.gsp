<%@ page import="icbs.gl.CashInBank" %>
<!DOCTYPE html>
<html>
    <head>
	<meta name="layout" content="main">
	<title>Close Cash in Bank Subsidiary Ledger</title>
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
            <g:form id="cibClose" url="[resource:cashInBankInstance, action:'saveCibClose']" method="PUT" >
                <g:hiddenField name="cashInBankId" id="cashInBankId" value="${params.id}" />
            </g:form>
        </content>	
	
        <content tag="main-actions">
            <ul>
                <li><g:actionSubmit class="save" id="saveCibClose" name="saveCibClose" action="saveCibClose" value="${message(code: 'default.button.Save.label', default: 'Close Cash in Bank')}" onclick="
                        alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                     checkIfAllowed('CFG00303', 'form#cibClose', 'Override edit cash in bank.', null); 
                                },
                                function(){
                                    return;
                                });                      
                    "/></li>                
                <li><g:link action="index" controller="cashInBank" id="${cashInBankInstance.id}">Cash in Bank List</g:link></li>
            </ul>
        </content>
    </body>
</html>
