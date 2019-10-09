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
        <title>Hold Maintenance</title>
        <g:javascript>
            // update form fields based on type
                updateForm = function() {
                    var type = $('#type').val();	
                    if (type == 1) {  // tax-rate
                        document.getElementById('fixed-amount-div').style.display = 'block';
                        document.getElementById('variable-amount-div').style.display = 'none';
                    } 
                    if (type !=1) {  // tax-amount 
                        document.getElementById('fixed-amount-div').style.display = 'none';
                        document.getElementById('variable-amount-div').style.display = 'block';
                    } 
                    
                }
            function updateHoldForm(){
                icbs.Deposit.Hold('holdForm',"${createLink(controller : 'search', action:'search')}",{id:${depositInstance?.id},searchDomain:"deposit-hold"});
            }
            function addHold(params){
               // if(params){
               //     icbs.Deposit.Hold('add',"${createLink(controller : 'deposit', action:'createHoldAjax')}",{id:${depositInstance?.id}});
              //  }else{
                    icbs.Deposit.Hold('add',"${createLink(controller : 'deposit', action:'createHoldAjax')}",{id:${depositInstance?.id}});
              //  }
            }
            function saveHold(){
                alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                    function(){
                        checkIfAllowed("DEP00801", saveHoldAuthCallback);
                    },
                    function(){
                        return;
                    });             
            }
            function saveHoldAuthCallback() {
                icbs.Deposit.Hold('save',"${createLink(controller : 'deposit', action:'saveHoldAjax')}",jQuery('#saveHoldForm').serialize());
            }
            function editHold(id){
                icbs.Deposit.Hold('edit',"${createLink(controller : 'deposit', action:'editHoldAjax')}",{id:id});
            }
            function updateHold(){
                alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                    function(){
                        checkIfAllowed("DEP00802", updateHoldAuthCallback);
                    },
                    function(){
                        return;
                    });      
            }
            function updateHoldAuthCallback() {
                icbs.Deposit.Hold('update',"${createLink(controller : 'deposit', action:'updateHoldAjax')}",jQuery('#editHoldForm').serialize());
            }
            icbs.Dependencies.Ajax.addLoadEvent(function(){
                $('#editHoldModal').on('hidden.bs.modal', function () {
                    updateHoldForm();
                });
                $('#addHoldModal').on('hidden.bs.modal', function () {
                    updateHoldForm();
                });
            })
        </g:javascript>
    </head>
    <body>
        <content tag="breadcrumbs">
            <span class="fa fa-chevron-right"></span><span class="current">Hold Maintenance</span>
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
                <div id="showHoldFormDiv">
                    <g:render template="/search/searchTemplate/deposit/hold/viewGrid"/>
                </div>
            </div>
            <div class="modal" id="addHoldModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">Add Hold Order</h4>
                        </div>
                        <div class="modal-body">
                            <g:render template='/deposit/details/depositInfo' model="[depositInstance:depositInstance]"/>
                             <div id="add">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="#" data-dismiss="modal" class="btn">Close</a>
                            <a href="#" class="btn btn-primary"onclick="saveHold()">Save changes</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal" id="editHoldModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">Edit Hold Order</h4>
                        </div>
                        <div class="modal-body">
                            <g:render template='/deposit/details/depositInfo' model="[depositInstance:depositInstance]"/>
                             <div id="edit">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="#" data-dismiss="modal" class="btn">Close</a>
                            <a href="#" class="btn btn-primary"onclick="updateHold()">Save changes</a>
                        </div>
                    </div>
                </div>
            </div>
        </content>
        
        <content tag="main-actions">
            <ul>
                <g:if test="${depositInstance}">
                    <li><a href="#" onclick="addHold()">Issue a new Hold Order</a></li>
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
