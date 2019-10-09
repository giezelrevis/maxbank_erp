
<%@ page import="icbs.deposit.DocInventory" %>
<%@ page import="icbs.deposit.Passbook" %>
<!DOCTYPE html>
<html>
	<head>
            <meta name="layout" content="main">
            <g:set var="entityName" value="${message(code: 'docInventory.label', default: 'DocInventory')}" />
            <title>Show Check Inventory Details</title>
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
                    <g:form name="ChkDetails" url="[action:'viewDetails',controller:'DocInventory']">
                           <g:hiddenField id="id" name="id" value="${docInventoryInstance.id}"/>
                            <div class="row">
                                <div class=" col-md-2">
                                     <g:select name="max" value="${params.max}" from="[5, 10, 15, 20]" class="form-control input-sm" onchange="submit(${docInventoryInstance.id})" />
                                </div>
                               
                                <div class="input-group col-md-6">
                                    <input id="searchQuery"name="query"type="text" class="form-control" value="${params?.query}" onchange="this.form.submit()">
                                    <span class="input-group-btn">
                                      <g:submitButton name="search" value="Search" class="btn btn-primary" />
                                    </span>
                                </div><!-- /input-group -->
                            </div><!-- /.col-lg-6 -->
                    </g:form>    
                    <div class="box-body table-responsive no-padding">
                        <table id="chequeTable" class="table table-hover table-condensed table-bordered table-striped">
                            <tr> 
                                <td width="15%"><label>Account No </label></td>
                                <td width="15%"><label>Account Name </label></td>
                                <td width="15%"><label>Check No.</label></td>
                                <td width="15%"><label>Date Issued</label></td>
                               <td width="10%"><label>Status</label></td>
                            </tr>
                            <g:each var="chk"  status="i" in="${chkInstance}">
                                <tr>
                                    <td>${chk?.chequebook?.deposit?.acctNo}</td>
                                    <td>${chk?.chequebook?.deposit?.acctName}</td>
                                    <td>${chk?.chequeNo}</td>
                                    <td><g:formatDate date="${chk?.chequebook?.dateIssued}" type="date" style="LONG"/></td>
                                    <td>${chk?.status?.description}</td>
                                </tr>
                            </g:each>  
                        </table>
              
            </div>
              <div class="pagination">
                        <g:paginate total="${chkInstanceCount?: 0}" params="${params}"/>
                </div>
                
            </div>
            </content>
             <content tag="main-actions">
                <ul>
                <li><g:link class="list" action="index">Document Inventory List</g:link></li>
      		<li><g:link class="create" action="create">Create Document Inventory</g:link></li>
                <li><g:link action="show"id="${docInventoryInstance.id}">View Document Inventory</g:link></li>
		</ul>
            </content>
	</body>
<g:javascript>
 
    function getMaxParams(){
    
    
    }
              
</g:javascript>
</html>
