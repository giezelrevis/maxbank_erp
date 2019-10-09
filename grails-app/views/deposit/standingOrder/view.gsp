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
        <title>Standing Order Maintenance</title>
        <g:javascript>
            // update form fields based on type
                updateForm = function() {
                    var type = $('#type').val();	
                    if (type == 1) {  // tax-rate
                        document.getElementById('fixed-amount-div').style.display = 'block';
                        document.getElementById('variable-amount-div').style.display = 'none';
                    } 
                    if (type == 2) {  // tax-amount 
                        document.getElementById('fixed-amount-div').style.display = 'none';
                        document.getElementById('variable-amount-div').style.display = 'block';
                    } 
                    
                }
            function updateStandingOrderForm(){
                icbs.Deposit.StandingOrder('standingOrderForm',"${createLink(controller : 'search', action:'search')}",{id:${depositInstance?.id},searchDomain:"deposit-standingOrder"});
            }
            function addStandingOrder(params){
                if(params){
                    icbs.Deposit.StandingOrder('add',"${createLink(controller : 'deposit', action:'createStandingOrderAjax')}",{id:${depositInstance?.id},deposit:params.deposit});
                }else{
                    icbs.Deposit.StandingOrder('add',"${createLink(controller : 'deposit', action:'createStandingOrderAjax')}",{id:${depositInstance?.id}});
                }
            }
            function saveStandingOrder(){
                checkIfAllowed("DEP00901", saveStandingOrderAuthCallback); 
            }
            function saveStandingOrderAuthCallback() {
                icbs.Deposit.StandingOrder('save',"${createLink(controller : 'deposit', action:'saveStandingOrderAjax')}",jQuery('#saveStandingOrderForm').serialize());
            }
            function editStandingOrder(id){
                icbs.Deposit.StandingOrder('edit',"${createLink(controller : 'deposit', action:'editStandingOrderAjax')}",{id:id});
            }
            function updateStandingOrder(){
                checkIfAllowed("DEP00902", updateStandingOrderAuthCallback); 
            }
            function updateStandingOrderAuthCallback() {
                icbs.Deposit.StandingOrder('update',"${createLink(controller : 'deposit', action:'updateStandingOrderAjax')}",jQuery('#updateStandingOrderForm').serialize());
            }
            icbs.Dependencies.Ajax.addLoadEvent(function(){
                ;$('#editStandingOrderModal').on('hidden.bs.modal', function () {
                    updateStandingOrderForm();
                })
                $('#addStandingOrderModal').on('hidden.bs.modal', function () {
                    updateStandingOrderForm();
                });
            })
            var modal;
            function initializeDepositSearchModal(){
                modal = new icbs.UI.Modal({id:"addStandingOrderSearchModal",url:"${createLink(controller : 'search', action:'search', params:[searchDomain: "deposit"])}",title:"Search Deposit Accounts",onCloseCallback:addStandingOrder});
            }
        </g:javascript>
    </head>
    <body>
        <content tag="breadcrumbs">
            <span class="fa fa-chevron-right"></span><span class="current">Standing Order Maintenance</span>
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
                <div id="showStandingOrderFormDiv">
                    <g:render template="/search/searchTemplate/deposit/standingOrder/viewGrid"/>
                </div>
            </div>
            <div class="modal" id="addStandingOrderModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">Add Standing Order</h4>
                        </div>
                        <div class="modal-body">
                            <g:render template='/deposit/details/depositInfo' model="[depositInstance:depositInstance]"/>
                             <div id="add">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="#" data-dismiss="modal" class="btn">Close</a>
                            <a href="#" class="btn btn-primary"onclick="saveStandingOrder()">Save changes</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal" id="editStandingOrderModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">Edit Standing Order</h4>
                        </div>
                        <div class="modal-body">
                            <g:render template='/deposit/details/depositInfo' model="[depositInstance:depositInstance]"/>
                            <div id="edit">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="#" data-dismiss="modal" class="btn">Close</a>
                            <a href="#" class="btn btn-primary"onclick="updateStandingOrder()">Save changes</a>
                        </div>
                    </div>
                </div>
            </div>
        </content>
        
        <content tag="main-actions">
            <ul>
                <g:if test="${depositInstance}">
                    <li><a href="#" onclick="addStandingOrder()">New Standing Order</a></li>
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
