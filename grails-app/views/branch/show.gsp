
<%@ page import="icbs.admin.Branch" %>
<!DOCTYPE html>
<html>
    <head>
	<meta name="layout" content="main">
	<g:set var="entityName" value="${message(code: 'branch.label', default: 'Branch')}" />
	<title>Branch Information</title>
    </head>
    <body>
        <content tag="breadcrumbs">
            <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/branch')}">Branch Maintenance</a>
            <span class="fa fa-chevron-right"></span><span class="current">Branch Information</span>
        </content>

        <content tag="main-content">   
            <div id="show-branch" class="content scaffold-show" role="main">
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
                            <td><label>Branch Code</label></td>
                            <td>${fieldValue(bean: branchInstance, field: "code").padLeft(3, '0')}</td>    
                        </tr> 
                        <tr>
                            <td><label>Branch Name</label></td>
                            <td>${branchInstance.name}</td>    
                        </tr> 
                        <tr>
                            <td><label>SWIFT Code</label></td>
                            <td>${branchInstance.swiftCode}</td>    
                        </tr>                        
                        <tr>
                            <td><label>Address</label></td>
                            <td>${branchInstance?.address}</td>    
                        </tr>
                        <tr>
                            <td><label>Region</label></td>
                            <td>${branchInstance?.region?.itemValue}</td>    
                        </tr>  
                        <tr>
                            <td><label>Contact Number</label></td>
                            <td>${branchInstance?.contactNumber}</td>    
                        </tr>
                        <tr>
                            <td><label>Branch Manager</label></td>
                            <td>
                                <g:if test="${branchInstance?.managerId}">
                                    ${branchInstance?.managerId?.name1}
                                </g:if>    
                            </td>    
                        </tr>  
                        <tr>
                            <td><label>Branch Opening Date</label></td>
                            <td><g:formatDate  format="MM/dd/yyyy" date="${branchInstance?.openDate}" /></td>    
                        </tr>     
                        <tr>
                            <td><label>Data Center</label></td>
                            <td><g:formatBoolean boolean="${branchInstance?.dataCenter}" true="Yes" false="No" /></td>    
                        </tr>
                        <tr>
                            <td><label>Branch Tax ID Number</label></td>
                            <td>${branchInstance?.taxNo}</td>    
                        </tr>  
                        <tr>
                            <td><label>Branch Working Days</label></td>
                            <td>
                                <ul>
                                    <g:if test="${branchInstance?.openOnMon == true}"><li>Monday</li></g:if>
                                    <g:if test="${branchInstance?.openOnTue == true}"><li>Tuesday</li></g:if>
                                    <g:if test="${branchInstance?.openOnWed == true}"><li>Wednesday</li></g:if>
                                    <g:if test="${branchInstance?.openOnThu == true}"><li>Thursday</li></g:if>
                                    <g:if test="${branchInstance?.openOnFri == true}"><li>Friday</li></g:if>
                                    <g:if test="${branchInstance?.openOnSat == true}"><li>Saturday</li></g:if>
                                    <g:if test="${branchInstance?.openOnSun == true}"><li>Sunday</li></g:if>
				</ul>
                            </td>    
                        </tr> 
                        <tr>
                            <td><label>Branch System Run Date</label></td>
                            <td><g:formatDate format="MM/dd/yyyy" date="${branchInstance?.runDate}"/></td>    
                        </tr>  
                        <tr>
                            <td><label>Branch System Run State</label></td>
                            <td>${branchInstance?.branchRunStatus?.description}</td>    
                        </tr> 
                        <tr>
                            <td><label>Branch Status</label></td>
                            <td>${branchInstance?.status?.description}</td>    
                        </tr>  
                        <tr>
                            <td><label>Branch GL - Due From Account</label></td>
                            <td>
                                <p>${branchInstance?.dueFromGl?.code}</p> 
                                <p>${branchInstance?.dueFromGl.name}</p>
                            </td>    
                        </tr>
                        <tr>
                            <td><label>Branch GL - Due to Account</label></td>
                            <td>
                                <p>${branchInstance?.dueToGl?.code}</p> 
                                <p>${branchInstance?.dueToGl.name}</p>
                            </td>    
                        </tr>
                        <tr>
                            <td><label>Branch GL - Default Inward Clearing Account</label></td>
                            <td>
                                <p>${branchInstance?.iccContra?.code}</p> 
                                <p>${branchInstance?.iccContra.name}</p>
                            </td>    
                        </tr>                    
                        <tr>
                            <td><label>Branch GL - Year End Closing Account</label></td>
                            <td>
                                <p>${branchInstance?.yearEndClosingGl?.code}</p> 
                                <p>${branchInstance?.yearEndClosingGl.name}</p>
                            </td>    
                        </tr>  
                    </tbody>
                </table>    

		<g:form name="remove" id="remove" url="[resource:branchInstance, action:'delete']" method="DELETE">
		</g:form>
                <g:form name="closed" id="closed" url="[resource:branchInstance, action:'close']" method="DELETE">
		</g:form>                                
            </div>
        </content>
        <content tag="main-actions">
            <ul>
                <g:if test="${isPending && isAllowed}">
                    <li><g:link action="takeAction" params="[isApproved:true]" resource="${branchInstance}">Approve</g:link></li>
                    <li><g:link action="takeAction" params="[isApproved:false]" resource="${branchInstance}">Disapprove</g:link></li>
                </g:if>
                <g:if test="${!isPending}">
	            <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
	            <li><g:link action="edit" resource="${branchInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link></li>
	            <li><g:actionSubmit id="deleteBranch"  resource="${branchInstance}" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'branch.button.close.confirm.message', default: 'Are you sure you want this branch to be deleted?')}');"  /></li>
                    <li><g:actionSubmit id="closeBranch"  resource="${branchInstance}" action="close" value="${message(code: 'default.button.close.label', default: 'Close')}" onclick="return confirm('${message(code: 'branch.button.close.confirm.message', default: 'Are you sure you want to close this branch?')}');" /></li>
                            
                            <!--<li><g:actionSubmit form="show" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></li>
	                    <li><g:actionSubmit form="show" action="close" value="${message(code: 'branch.button.close.label', default: 'Close')}" onclick="return confirm('${message(code: 'branch.button.close.confirm.message', default: 'Are you sure you want to close this branch?')}');" /></li>
                            -->
                </g:if>
            </ul>
            <script type="text/javascript">
                    $(document).ready(function() {
                           $( "#deleteBranch" ).click(function() {
                              checkIfAllowed('ADM00204', 'form#remove', 'Delete Branch.', null); // params: policyTemplate.code, form to be saved
                           });
                    });
                    
                    $(document).ready(function() {
                           $( "#closeBranch" ).click(function() {
                              checkIfAllowed('ADM00205', 'form#closed', 'Close Branch.', null); // params: policyTemplate.code, form to be saved
                           });
                    });
            </script>
        </content>
    </body>
</html>
