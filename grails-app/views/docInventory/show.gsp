
<%@ page import="icbs.deposit.DocInventory" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'docInventory.label', default: 'DocInventory')}" />
		<title>Show Deposit Inventory</title>
	</head>
	<body>
            <content tag="main-content">   
		<div id="show-docInventory" class="content scaffold-show" role="main">
                    <g:if test="${flash.message}">
			<!-- div class="message" role="status">${flash.message}</div -->
                            <script>
                            $(function(){
                                var x = '${flash.message}';
                                    notify.message(x);
                                    //$('#SlipTransaction').hide();
                                    if(x.indexOf('|success') > -1){
                                    //$('#SlipTransaction').show();
                                }
                            });
                            </script>
                    </g:if>
                    <table class="table table-bordered table-rounded table-striped table-hover">
                        <tbody>
                            <tr>
                                <td><label>Branch</label></td>
                                <td><g:link controller="branch" action="show" id="${docInventoryInstance?.branch?.id}">${docInventoryInstance?.branch?.name.encodeAsHTML()}</g:link></td>    
                            </tr> 
                            <tr>
                                <td><label>Type</label></td>
                                <td>${docInventoryInstance?.type?.encodeAsHTML()}</td>
                            </tr>
                            <tr>
                                <td><label>Series Start</label></td>
                                <td>${docInventoryInstance?.seriesStart}</td>
                            </tr>
                            <tr>
                                <td><label>Series End</label></td>
                                <td>${docInventoryInstance?.seriesEnd}</td>
                            </tr>
                            <tr>
                                <td><label>Usage Count</label></td>
                                <td>${docInventoryInstance?.usageCount}</td>
                            </tr>
                            <tr>
                                <td><label>Particulars</label></td>
                                <td>${docInventoryInstance?.docParticulars}</td>
                            </tr>
                            <tr>
                                <td><label>Checking Account Number (Checks)</label></td>
                                <td>${docInventoryInstance?.checkAcctNo}</td>
                            </tr>
                            <tr>
                                <td><label>Doc Inventory Item Canceled</label></td>
                                <td><g:formatBoolean boolean="${docInventoryInstance?.isCanceled}" /></td>
                            </tr>
                            <tr>
                                <td><label>Canceled Date</label></td>
                                <td><g:formatDate format="yyyy-MM-dd" date="${docInventoryInstance?.canceledAt}" /></td>
                            </tr>
                            <tr>
                                <td><label>Canceled By</label></td>
                                <td><g:link controller="userMaster" action="show" id="${docInventoryInstance?.canceledBy?.username}">${docInventoryInstance?.canceledBy?.encodeAsHTML()}</g:link></td>
                            </tr>  
                            <tr>
                                <td><label>Status</label></td>
                                <td>${docInventoryInstance?.status?.encodeAsHTML()}</td>
                            </tr>
 
                        </tbody>
                    </table>
		</div>
            </content>
             <content tag="main-actions">
                <ul>
                    <li><g:link class="list" action="index">Document Inventory List</g:link></li>
      			<li><g:link class="create" action="create">Create Document Inventory</g:link></li>
                <li><button disabled="disabled">View Document Inventory</button></li>
                <!--        
                <li><g:link action="edit"id="${docInventoryInstance.id}">Update Document Inventory</g:link></li>
                -->
                <g:if test="${docInventoryInstance.status.id == 1}">
                    <li><g:form url="[id:docInventoryInstance.id, action:'activate']" method="POST">
			<g:actionSubmit action="activate" value="Activate" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                    </g:form></li>
                </g:if>
<!--Action cancel added -->
                <g:if test="${docInventoryInstance.status.id.toInteger() in [1, 2]}">
                    <li><g:form url="[id:docInventoryInstance.id, action:'cancel']" method="POST">
                            <g:actionSubmit action="cancel" value="Cancel" onclick="return confirm('${message(code: 'default.button.cancel.confirm.message', default: 'Are you sure?')}');" />
                        </g:form>
                    </li>
                </g:if>
                        
                <g:if test="${docInventoryInstance.status.id.toInteger() in [1, 2]}">
                    <li><g:form url="[id:docInventoryInstance.id, action:'delete']" method="POST">
                            <g:actionSubmit action="delete" value="Delete" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                        </g:form>
                    </li>
                </g:if>
                <li><g:link action="viewDetails"id="${docInventoryInstance.id}">View Inventory Details</g:link></li>
		</ul>
            </content>
	</body>
</html>
