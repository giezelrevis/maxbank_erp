<%@ page import="icbs.loans.ROPA" %>
<!DOCTYPE html>
<html>
    <head>
	<meta name="layout" content="main">
	<title>ROPA Information</title>
    </head>
    <body>
        <content tag="breadcrumbs">
            <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/ropa')}">ROPA Index</a>
            <span class="fa fa-chevron-right"></span><span class="current">ROPA Details</span>
        </content>
        <content tag="main-content">
             <div id="show-ROPA" class="content scaffold-show" role="main">
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
                            <td style="width:30%"><label>ROPA GL Account</label></td>
                            <td style="width:70%">${ropaInstance?.glContraRopa}</td>    
                        </tr> 
                        <tr>
                            <td style="width:30%"><label>Litigation Expense GL Account</label></td>
                            <td style="width:70%">${ropaInstance?.glContraLitigationExp}</td>    
                        </tr>                         
                        <tr>
                            <td style="width:30%"><label>Branch</label></td>
                            <td style="width:70%">${ropaInstance?.branch?.name}</td>    
                        </tr>                         
                        <tr>
                            <td style="width:30%"><label>Acquired From</label></td>
                            <td style="width:70%">${ropaInstance?.acquiredFrom?.displayName}</td>    
                        </tr> 
                        <tr>
                            <td style="width:30%"><label>Collateral</label></td>
                            <td style="width:70%">${ropaInstance?.collateral}</td>    
                        </tr> 
                        <tr>
                            <td style="width:30%"><label>ROPA Date</label></td>
                            <td><g:formatDate  format="MM/dd/yyyy" date="${ropaInstance?.ropaDate}" /></td>    
                        </tr>
                        <tr>
                            <td style="width:30%"><label>Loan Account Number</label></td>
                            <td style="width:70%">${ropaInstance?.loan?.accountNo}</td>    
                        </tr> 
                        <tr>
                            <td style="width:30%"><label>Loan Balance (at Transfer)</label></td>
                            <td style="width:70%"><g:formatNumber format="###,###,##0.00" number="${ropaInstance?.loanBalance}"/></td>    
                        </tr>  
                        <tr>
                            <td style="width:30%"><label>Cost Capitalized</label></td>
                            <td style="width:70%"><g:formatNumber format="###,###,##0.00" number="${ropaInstance?.costsCapitalized}"/></td>    
                        </tr>  
                        <tr>
                            <td style="width:30%"><label>Provision Amount</label></td>
                            <td style="width:70%"><g:formatNumber format="###,###,##0.00" number="${ropaInstance?.provisionAmt}"/></td>    
                        </tr>  
                        <tr>
                            <td style="width:30%"><label>Provision Rate</label></td>
                            <td style="width:70%"><g:formatNumber format="###,###,##0.00" number="${ropaInstance?.provisionRate}"/></td>    
                        </tr>   
                        <tr>
                            <td style="width:30%"><label>Allocated Book Value Land</label></td>
                            <td style="width:70%"><g:formatNumber format="###,###,##0.00" number="${ropaInstance?.allocatedBookValueLand}"/></td>    
                        </tr> 
                        <tr>
                            <td style="width:30%"><label>Allocated Book Value Building</label></td>
                            <td style="width:70%"><g:formatNumber format="###,###,##0.00" number="${ropaInstance?.allocatedBookValueBuilding}"/></td>    
                        </tr> 
                        <tr>
                            <td style="width:30%"><label>Allocated Depreciation Building</label></td>
                            <td style="width:70%"><g:formatNumber format="###,###,##0.00" number="${ropaInstance?.accumulatedDepreciationBuilding}"/></td>    
                        </tr> 
                        <tr>
                            <td style="width:30%"><label>Allowance for Probable losses Building</label></td>
                            <td style="width:70%"><g:formatNumber format="###,###,##0.00" number="${ropaInstance?.allowanceBuilding}"/></td>    
                        </tr> 
                        <tr>
                            <td style="width:30%"><label>Other Costs</label></td>
                            <td style="width:70%"><g:formatNumber format="###,###,##0.00" number="${ropaInstance?.otherCosts}"/></td>    
                        </tr> 
                        <tr>
                            <td style="width:30%"><label>Allowance for Probable Losses - Other Costs</label></td>
                            <td style="width:70%"><g:formatNumber format="###,###,##0.00" number="${ropaInstance?.allowanceOthers}"/></td>    
                        </tr>                        
                        <tr>
                            <td style="width:30%"><label>Former Title</label></td>
                            <td style="width:70%">${ropaInstance?.formerTitle}</td>    
                        </tr>                          
                        <tr>
                            <td style="width:30%"><label>Former Title</label></td>
                            <td style="width:70%">${ropaInstance?.kindOfLand}</td>    
                        </tr>                        
                        <tr>
                            <td style="width:30%"><label>Land Area</label></td>
                            <td style="width:70%"><g:formatNumber format="###,###,##0.00" number="${ropaInstance?.landArea}"/></td>    
                        </tr>  
                        <tr>
                            <td style="width:30%"><label>Location</label></td>
                            <td style="width:70%">${ropaInstance?.location}</td>    
                        </tr>
                        <tr>
                            <td style="width:30%"><label>Date of Certificate</label></td>
                            <td><g:formatDate  format="MM/dd/yyyy" date="${ropaInstance?.dateOfCertificate}" /></td>    
                        </tr>                        
                        <tr>
                            <td style="width:30%"><label>Date of Certificate Registration</label></td>
                            <td><g:formatDate  format="MM/dd/yyyy" date="${ropaInstance?.dateOfCertificateRegistration}" /></td>    
                        </tr> 
                        <tr>
                            <td style="width:30%"><label>Date of Consolidation</label></td>
                            <td><g:formatDate  format="MM/dd/yyyy" date="${ropaInstance?.dateConsolidated}" /></td>    
                        </tr> 
                        <tr>
                            <td style="width:30%"><label>New TCT</label></td>
                            <td style="width:70%">${ropaInstance?.newTct}</td>    
                        </tr>                        
                        <tr>
                            <td style="width:30%"><label>Land Appraisal</label></td>
                            <td style="width:70%"><g:formatNumber format="###,###,##0.00" number="${ropaInstance?.landAppraisal}"/></td>    
                        </tr>  
                        <tr>
                            <td style="width:30%"><label>Building Appraisal</label></td>
                            <td style="width:70%"><g:formatNumber format="###,###,##0.00" number="${ropaInstance?.buildingAppraisal}"/></td>    
                        </tr>
                        <tr>
                            <td style="width:30%"><label>Other Appraisal</label></td>
                            <td style="width:70%"><g:formatNumber format="###,###,##0.00" number="${ropaInstance?.otherAppraisal}"/></td>    
                        </tr>                
                        <tr>
                            <td style="width:30%"><label>Date of Appraisal</label></td>
                            <td><g:formatDate  format="MM/dd/yyyy" date="${ropaInstance?.dateOfAppraisal}" /></td>    
                        </tr> 
                        <tr>
                            <td style="width:30%"><label>Appraised By</label></td>
                            <td style="width:70%">${ropaInstance?.appraisedBy}</td>    
                        </tr>                          
                        <tr>
                            <td style="width:30%"><label>Fire Insurance Policy Number</label></td>
                            <td style="width:70%">${ropaInstance?.fireInsurancePolicyNo}</td>    
                        </tr>                         
                        <tr>
                            <td style="width:30%"><label>Fire Insurance Amount</label></td>
                            <td style="width:70%"><g:formatNumber format="###,###,##0.00" number="${ropaInstance?.fireInsuranceAmt}"/></td>    
                        </tr>                         
                        <tr>
                            <td style="width:30%"><label>Fire Insurance Date</label></td>
                            <td><g:formatDate  format="MM/dd/yyyy" date="${ropaInstance?.fireInsuranceDate}" /></td>    
                        </tr>                         
                        <tr>
                            <td style="width:30%"><label>Fire Insurance Provision Amount</label></td>
                            <td style="width:70%"><g:formatNumber format="###,###,##0.00" number="${ropaInstance?.provisionForFireInsurance}"/></td>    
                        </tr>
                        <tr>
                            <td style="width:30%"><label>Created By</label></td>
                            <td style="width:70%">${ropaInstance?.createdBy.username}</td>    
                        </tr> 
                        <tr>
                            <td style="width:30%"><label>Date Created</label></td>
                            <td><g:formatDate  format="MM/dd/yyyy" date="${ropaInstance?.dateCreated}" /></td>    
                        </tr>                         
                    </tbody>
                </table>                                  
            </div>
        </content>	
        <content tag="main-actions">
            <ul>
                <li><g:link action="edit" id="${ropaInstance?.id}" >Edit</g:link></li>
                <li><g:link action="viewTransactions" id="${RopaInstance?.id}" >View ROPA Transactions</g:link></li>
                <li><g:link action="ropaDebit" id="${RopaInstance?.id}">ROPA Debit</g:link></li>
                <li><g:link action="ropaCredit" id="${RopaInstance?.id}">ROPA Credit</g:link></li>
                <li><g:link action="ropaExpense" id="${RopaInstance?.id}">Create ROPA Expense</g:link></li>
                <li><g:link action="index" >ROPA List</g:link></li>
            </ul>
        </content>
    </body>
</html>

