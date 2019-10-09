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
        <title>Checkbook Maintenance</title>
        <g:javascript>
            var modal;
            function updateCheckbookForm(){
                icbs.Deposit.Checkbook('checkbookForm',"${createLink(controller : 'search', action:'search')}",{id:${depositInstance?.id},searchDomain:"deposit-checkbook"});
            }
            function initializeChecksSearchModal(id){
                modal = new icbs.UI.Modal({id:"checksModal",url:"${createLink(controller : 'search', action:'search')}",title:"View Checks",params:{id:id,searchDomain:'deposit-check'}});
            }
            function addCheckbook(){
                if ($('#dpstatus').html() != 'Active' && $('#dpstatus').html() != 'Re-Activated')
                    {
                        notify.message('Active account is required for this procedure!|error|alert');return;  
                    }
                icbs.Deposit.Checkbook('add',"${createLink(controller : 'deposit', action:'createCheckbookAjax')}",{id:${depositInstance?.id}});
            }
            function saveCheckbook(){
                alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                    function(){
                        checkIfAllowed("DEP01201", createChqBookAuthCallback);
                    },
                    function(){
                        return;
                    });                
            }
            function createChqBookAuthCallback(){
                icbs.Deposit.Checkbook('save',"${createLink(controller : 'deposit', action:'saveCheckbookAjax')}",jQuery('#saveCheckbookForm').serialize());            
            }            
            function editCheckbook(id){
            if($('#dpstatus').html() != 'Active')
                    {
                        notify.message('Active account is required for this procedure!|error|alert');return;  
                    }
                icbs.Deposit.Checkbook('edit',"${createLink(controller : 'deposit', action:'editCheckbookAjax')}",{id:id});
            }
            function updateCheckbook(){
                alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                    function(){
                        checkIfAllowed("DEP01202", updateCheckbookAuthCallback);
                    },
                    function(){
                        return;
                    });             
            }
            function cancelCheckbook(id) {
                    alertify.confirm(AppTitle,'Are you sure you want to return to Cancel Checkbook?',
                        function(){icbs.Deposit.Checkbook('update',"${createLink(controller : 'deposit', action:'cancelCheckbookAjax')}",{id:id});location.reload();},
                        function(){ return; });
            }
            function updateCheckbookAuthCallback() {
                icbs.Deposit.Checkbook('update',"${createLink(controller : 'deposit', action:'updateCheckbookAjax')}",jQuery('#updateCheckbookForm').serialize());            
            }
            icbs.Dependencies.Ajax.addLoadEvent(function(){
                ;$('#editCheckbookModal').on('hidden.bs.modal', function () {
                    updateCheckbookForm();
                })
                $('#addCheckbookModal').on('hidden.bs.modal', function () {
                    updateCheckbookForm();
                });
            })
        </g:javascript>
    </head>
    <body>
        <content tag="breadcrumbs">]
            <span class="fa fa-chevron-right"></span><span class="current">Checkbook Maintenance</span>
	</content>
        <content tag="main-content">
            <div class="row">
                <div class="col-md-12">
                   <g:render template='/customer/details/newCustomerDetailedInfo' model="[customerInstance:depositInstance?.customer]"/>
                </div>

                <div class="col-md-12">
                   <g:render template='/deposit/details/depositDetails' model="[depositInstance:depositInstance]"/> 

                </div>
            </div>
            <div class="row">
                <div id="showCheckbookFormDiv">
                    <g:render template="/search/searchTemplate/deposit/checkbook/viewGrid"/>
                </div>
            </div>
            <div class="modal" id="addCheckbookModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">Add Checkbook</h4>
                        </div>
                        <div class="modal-body">
                            <g:render template='/deposit/details/depositInfo' model="[depositInstance:depositInstance]"/>
                            <div id="add">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="#" data-dismiss="modal" class="btn">Close</a>
                            <a href="#" class="btn btn-primary" onclick="saveCheckbook()">Save changes</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal" id="editCheckbookModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">Edit Checkbook</h4>
                        </div>
                        <div class="modal-body">
                            <g:render template='/deposit/details/depositInfo' model="[depositInstance:depositInstance]"/>
                             <div id="edit">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="#" data-dismiss="modal" class="btn">Close</a>
                            <a href="#" class="btn btn-primary"onclick="updateCheckbook()">Save changes</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal" id="viewChecksModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">View Checks</h4>
                        </div>
                        <div class="modal-body">

                        </div>
                        <div class="modal-footer">
                            <a href="#" data-dismiss="modal" class="btn">Close</a>
                        </div>
                    </div>
                </div>
            </div>
        </content>
        
        <content tag="main-actions">
            <ul>
                <g:if test="${depositInstance && depositInstance.type.id == 2}">
                    <g:if test="${depositInstance.status.id == 2 || depositInstance.status.id==3 || depositInstance.status.id==4}">
                        <li><a href="#" onclick="addCheckbook()">Issue a new Checkbook</a></li>
                    </g:if>
                </g:if>
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
