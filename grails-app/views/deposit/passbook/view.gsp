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
        <title>Passbook Maintenance</title>
        <g:javascript>
            function updatePassbookForm(){
                icbs.Deposit.Passbook('passbookForm',"${createLink(controller : 'search', action:'search')}",{id:${depositInstance?.id},searchDomain:"deposit-passbook"});
            }
            function addPassbook(params){
             
             if($('#dpstatus').html() == 'Dormant')
                    {
                        notify.message('Active account is required for this procedure!|error|alert');return;  
                    }
             if($('#dpstatus').html() == 'Closed')
                    {
                        notify.message('Active account is required for this procedure!|error|alert');return;  
                    }
             if($('#dpstatus').html() == 'Pending')
                    {
                        notify.message('Active account is required for this procedure!|error|alert');return;  
                    }
             if($('#dpstatus').html() == 'Locked/Frozen')
                    {
                        notify.message('Active account is required for this procedure!|error|alert');return;  
                    }                    
             if($('#dpstatus').html() == 'Cancelled')
                    {
                        notify.message('Active account is required for this procedure!|error|alert');return;  
                    }                    
                    
                if(params){
                    icbs.Deposit.Passbook('add',"${createLink(controller : 'deposit', action:'createPassbookAjax')}",{id:${depositInstance?.id}});
                }else{
                    icbs.Deposit.Passbook('add',"${createLink(controller : 'deposit', action:'createPassbookAjax')}",{id:${depositInstance?.id}});
                }
            }
            function savePassbook(){
                alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                    function(){
                        checkIfAllowed("DEP00601", savePassbookAuthCallback);
                    },
                    function(){
                        return;
                    });            
                //checkIfAllowed("DEP00601", savePassbookAuthCallback);  
                //savePassbookAuthCallback();
            }
            function savePassbookAuthCallback() {
                icbs.Deposit.Passbook('save',"${createLink(controller : 'deposit', action:'savePassbookAjax')}",jQuery('#savePassbookForm').serialize());
            }
            function editPassbook(id){
             if($('#dpstatus').html() != 'Active')
                    {
                        notify.message('Active account is required for this procedure!|error|alert');return;  
                    }
                icbs.Deposit.Passbook('edit',"${createLink(controller : 'deposit', action:'editPassbookAjax')}",{id:id});
            }
            function updatePassbook(){
                alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                    function(){
                        checkIfAllowed("DEP00602", updatePassbookAuthCallback);
                    },
                    function(){
                        return;
                    });             
            }
            function updatePassbookAuthCallback() {
                icbs.Deposit.Passbook('update',"${createLink(controller : 'deposit', action:'updatePassbookAjax')}",jQuery('#editPassbookForm').serialize());
            }
            icbs.Dependencies.Ajax.addLoadEvent(function(){
                $('#editPassbookModal').on('hidden.bs.modal', function () {
                    updatePassbookForm();
                })
                $('#addPassbookModal').on('hidden.bs.modal', function () {
                    updatePassbookForm();
                });
            })
        </g:javascript>
    </head>
    <body>
        <content tag="breadcrumbs">
            <span class="fa fa-chevron-right"></span><span class="current">Passbook Maintenance</span>
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
                <div id="showPassbookFormDiv">
                    <g:render template="/search/searchTemplate/deposit/passbook/viewGrid"/>
                </div>
            </div>
            <div class="modal" id="addPassbookModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">Add Passbook</h4>
                        </div>
                        <div class="modal-body">
                            <g:render template='/deposit/details/depositInfo' model="[depositInstance:depositInstance]"/>
                            <div id="add">
                            
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="#" data-dismiss="modal" class="btn">Close</a>
                            <a id="passsvbtn" href="#" class="btn btn-primary" onclick="savePassbook()">Save changes</a>
                            
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal" id="editPassbookModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">Edit Passbook</h4>
                        </div>
                        <div class="modal-body">
                            <g:render template='/deposit/details/depositInfo' model="[depositInstance:depositInstance]"/>
                            <div id="edit">
                            
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="#" data-dismiss="modal" class="btn">Close</a>
                            <a href="#" class="btn btn-primary"onclick="updatePassbook()">Save changes</a>
                        </div>
                    </div>
                </div>
            </div>
        </content>
        
        <content tag="main-actions">
            <ul>
                <g:if test="${depositInstance}">
                    
                        <li><a href="#" onclick="$('#passsvbtn').show();addPassbook()">Issue a new Passbook</a></li>
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
