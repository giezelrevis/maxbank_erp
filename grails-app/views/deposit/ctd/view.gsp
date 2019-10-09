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
        <title>CTD Maintenance</title>
        <g:javascript>
           function updateCTDForm(){
                icbs.Deposit.CTD('ctdForm',"${createLink(controller : 'search', action:'search')}",{id:${depositInstance?.id},searchDomain:"deposit-ctd"});
            }
            function addCTD(params){
                icbs.Deposit.CTD('add',"${createLink(controller : 'deposit', action:'createCTDAjax')}",{id:${depositInstance?.id}});
            }
            function saveCTD(){
                alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                    function(){
                        checkIfAllowed("DEP00701", saveCTDAuthCallback); 
                    },
                    function(){
                        return;
                    });  
            }
            function saveCTDAuthCallback() {
                icbs.Deposit.CTD('save',"${createLink(controller : 'deposit', action:'saveCTDAjax')}",jQuery('#saveCTDForm').serialize());            
            }
            function editCTD(id){
                icbs.Deposit.CTD('edit',"${createLink(controller : 'deposit', action:'editCTDAjax')}",{id:id});
            }
            function updateCTD(){
                alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                    function(){
                        checkIfAllowed("DEP00702", updateCTDAuthCallback);
                    },
                    function(){
                        return;
                    });               
            }
            function updateCTDAuthCallback() {
                icbs.Deposit.CTD('update',"${createLink(controller : 'deposit', action:'updateCTDAjax')}",jQuery('#updateCTDForm').serialize());
            }
            icbs.Dependencies.Ajax.addLoadEvent(function(){
                ;$('#editCTDModal').on('hidden.bs.modal', function () {
                    updateCTDForm();
                })
                $('#addCTDModal').on('hidden.bs.modal', function () {
                    updateCTDForm();
                });
            })
        </g:javascript>
    </head>
    <body>
        <content tag="breadcrumbs">
            <span class="fa fa-chevron-right"></span><span class="current">CTD Maintenance</span>
	</content>
        <content tag="main-content">
            <div class="row">
                <div class="col-md-12">
                   <g:render template='/customer/details/newCustomerDetailedInfo' model="[customerInstance:depositInstance?.customer]"/>
                </div>
                <div class="col-md-12">
                   <g:render template='details/ctdDetails' model="[depositInstance:depositInstance]"/>
                </div>
            </div>
            <div class="row">
                <div id="showCTDFormDiv">
                    <g:render template="/search/searchTemplate/deposit/ctd/viewGrid"/>
                </div>
            </div>
            <div class="modal" id="addCTDModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">Issue CTD</h4>
                        </div>
                        <div class="modal-body">
                            <g:render template='/deposit/details/depositInfo' model="[depositInstance:depositInstance]"/>
                            <div id="add">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="#" data-dismiss="modal" class="btn">Close</a>
                            <a href="#" class="btn btn-primary"onclick="saveCTD()">Save changes</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal" id="editCTDModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">Edit CTD</h4>
                        </div>
                        <div class="modal-body">
                            <g:render template='/deposit/details/depositInfo' model="[depositInstance:depositInstance]"/>
                             <div id="edit">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="#" data-dismiss="modal" class="btn">Close</a>
                            <a href="#" class="btn btn-primary"onclick="updateCTD()">Save changes</a>
                        </div>
                    </div>
                </div>
            </div>
        </content>
        <content tag="main-actions">
            <ul>
                <g:if test="${depositInstance}">
                    <li><a href="#" onclick="addCTD()">Issue CTD</a></li>
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
