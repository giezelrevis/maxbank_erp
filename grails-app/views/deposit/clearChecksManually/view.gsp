<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <asset:javascript src="depositHelper.js"/>
        <title>Clear Checks Manually</title>
        <g:javascript>
            function updateClearChecksManuallyForm(){
                icbs.Deposit.ClearChecksManually('checksForm',"${createLink(controller : 'search', action:'search')}",{id:${depositInstance?.id},searchDomain:"deposit-clearChecksManually"});
            }
            function editChecksManually(id){
                alert(id);
            
                icbs.Deposit.CTD('edit',"${createLink(controller : 'deposit', action:'editClearChecksManuallyAjax')}",{id:id});
            }
            function updateChecksManually(){
                checkIfAllowed("DEP01700", updateChecksManuallyAuthCallback);
            }
            function updateChecksManuallyAuthCallback() {
                icbs.Deposit.CTD('update',"${createLink(controller : 'deposit', action:'updateClearChecksManuallyAjax')}",jQuery('#updateChecksManuallyForm').serialize());
            }
            icbs.Dependencies.Ajax.addLoadEvent(function(){
                ;$('#editClearChecksManuallyModal').on('hidden.bs.modal', function () {
                    updateClearChecksManuallyForm();
                })
            })
            var paramValueID,paramValueX,paramValueT = ""
            function comfirmChecksManuallyOverride(id,x,t){
                paramValueID = id
                paramValueX = x
                paramValueT = t
                checkIfAllowed("DEP01700", editCOCIAuthCallback);
            }
            function editCOCIAuthCallback()
            {
                var id,x,t
                id = paramValueID
                x = paramValueX
                t = paramValueT
                // x = 1 = clear / 0 = cancel
                var url = '';
                var row = t.parentNode.parentNode;
                if(x==1)
                {
                    url = '/icbs/deposit/editClearChecksManuallyAjaxConfirm/'+id;
                } else {
                    url = '/icbs/deposit/editClearChecksManuallyAjaxCancel/'+id;
                }
                
                var ret = $.post(url);
                ret.success(function(data){
                    if(data.success)
                    {
                        notify.message(data.success);
                        document.getElementById("tbl").deleteRow(row.rowIndex);
                        //setTimeout(function(){ location.reload(); }, 5000);
                        
                    }
                    console.log(data);
                });
                
               // ret.error(function(data){
               //     notify.alert(data);
              //  });
                
                
                
        
                
            }
        </g:javascript>
    </head>
    <body>
        <content tag="breadcrumbs">
            <span class="fa fa-chevron-right"></span><span class="current">Clear Checks Manually</span>
	</content>
        <content tag="main-content">
            <div class="row">
                <div class="col-md-12">
                   <g:render template='/customer/details/newCustomerDetailedInfo' model="[customerInstance:depositInstance?.customer]"/>
                </div>
                <div class="col-md-12">
                   <g:render template='details/depositDetails' model="[depositInstance:depositInstance]"/>
                </div>
            </div>
            <div class="row">
                <div id="clearChecksManuallyFormDiv">
                    <g:render template="/search/searchTemplate/deposit/clearChecksManually/viewGrid"/>
                </div>
            </div>
            <div class="modal" id="editClearChecksManuallyModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">Edit Check</h4>
                        </div>
                        <div class="modal-body">
                            <g:render template='/deposit/details/depositInfo' model="[depositInstance:depositInstance]"/>
                             <div id="edit">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="#" data-dismiss="modal" class="btn">Close</a>
                            <a href="#" class="btn btn-primary"onclick="updateChecksManually()">Save changes</a>
                        </div>
                    </div>
                </div>
            </div>
        </content>
        <content tag="main-actions">
            <ul>
                <li>
                    <a href=# onclick="alertify.confirm(AppTitle,'Are you sure you want to return to Deposit Inquiries page?',
                                    function(){
                                    var t_url = '/icbs/deposit/depositInquiry/${depositInstance?.id}';
                                    location.href=t_url;},
                                    function(){});">Return to Deposit Inquiry Page</a>
                </li>
            </ul>                                        
        </content>
    </body>
</html>
