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
        <title>Stop Payment Order Maintenance</title>
        <g:javascript>
            function updateStopPaymentOrderForm(){
                icbs.Deposit.StopPaymentOrder('stopPaymentOrderForm',"${createLink(controller : 'search', action:'search')}",{id:${depositInstance?.id},searchDomain:"deposit-stopPaymentOrder"});
            }
            function addStopPaymentOrder(params){
                if(params){
                    icbs.Deposit.StopPaymentOrder('add',"${createLink(controller : 'deposit', action:'createStopPaymentOrderAjax')}",{id:${depositInstance?.id},deposit:'${params?.deposit}'});
                }else{
                    icbs.Deposit.StopPaymentOrder('add',"${createLink(controller : 'deposit', action:'createStopPaymentOrderAjax')}",{deposit:${depositInstance?.id}});
                }
            }
            function saveStopPaymentOrder(){
                alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                    function(){
                        checkIfAllowed("DEP01401", saveStopPaymentOrderAuthCallback); 
                    },
                    function(){
                        return;
                    });            
            }
            function saveStopPaymentOrderAuthCallback() {
                icbs.Deposit.StopPaymentOrder('save',"${createLink(controller : 'deposit', action:'saveStopPaymentOrderAjax')}",jQuery('#saveStopPaymentOrderForm').serialize()+"&deposit=${depositInstance?.id}");
            }
            function editStopPaymentOrder(id){
                icbs.Deposit.StopPaymentOrder('edit',"${createLink(controller : 'deposit', action:'editStopPaymentOrderAjax')}",{id:id});
            }
            function updateStopPaymentOrder(){
                alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                    function(){
                        checkIfAllowed("DEP01402", updateStopPaymentOrderAuthCallback); 
                    },
                    function(){
                        return;
                    });            
            }
            function updateStopPaymentOrderAuthCallback() {
                icbs.Deposit.StopPaymentOrder('update',"${createLink(controller : 'deposit', action:'updateStopPaymentOrderAjax')}",jQuery('#updateStopPaymentOrderForm').serialize());
            }
            icbs.Dependencies.Ajax.addLoadEvent(function(){
                ;$('#editStopPaymentOrderModal').on('hidden.bs.modal', function () {
                    updateStopPaymentOrderForm();
                })
                $('#addStopPaymentOrderModal').on('hidden.bs.modal', function () {
                    updateStopPaymentOrderForm();
                });
            })
        </g:javascript>
    </head>
    <body>
        <content tag="breadcrumbs">
            <span class="fa fa-chevron-right"></span><span class="current">Stop Payment Order Maintenance</span>
	</content>
        <content tag="main-content">
            <div class="row">
                <div class="col-md-6">
                   <g:render template='/customer/details/customerDetails' model="[customerInstance:depositInstance?.customer]"/>
                </div>

                <div class="col-md-6">
                   <g:render template='/deposit/details/depositDetails' model="[depositInstance:depositInstance]"/> 
                </div>
            </div>
            <div class="row">
                <div id="stopPaymentOrderFormDiv">
                    <g:render template="/search/searchTemplate/deposit/stopPaymentOrder/viewGrid"/>
                </div>
            </div>
            <div class="modal" id="addStopPaymentOrderModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">Add Stop Payment Order</h4>
                        </div>
                        <div class="modal-body">
                            <g:render template='/deposit/details/depositInfo' model="[depositInstance:depositInstance]"/>
                             <div id="add">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="#" data-dismiss="modal" class="btn">Close</a>
                            <a href="#" class="btn btn-primary"onclick="saveStopPaymentOrder()">Save changes</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal" id="editStopPaymentOrderModal">
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
                            <a href="#" class="btn btn-primary"onclick="updateStopPaymentOrder()">Save changes</a>
                        </div>
                    </div>
                </div>
            </div>
        </content>
        
        <content tag="main-actions">
            <ul>
                <g:if test="${depositInstance}">
                    <li><a href="#" onclick="addStopPaymentOrder()">New Stop Payment Order</a></li>
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
