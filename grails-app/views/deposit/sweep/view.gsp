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
        <title>ATA/Sweep Maintenance</title>
        <g:javascript>

            // update form fields based on type
            
                updateForm = function() {
                    var type = $('#rule').val();	
                    if (type == 1||type==2) {  // tax-amount 
                        document.getElementById('fixed-amount-div').style.display = 'none';
                        document.getElementById('variable-amount-div').style.display = 'none';
                    } 
                    if (type == 3) {  // tax-rate
                        document.getElementById('fixed-amount-div').style.display = 'block';
                        document.getElementById('variable-amount-div').style.display = 'none';
                    } 
                    if (type == 4) {  // tax-amount 
                        document.getElementById('fixed-amount-div').style.display = 'none';
                        document.getElementById('variable-amount-div').style.display = 'block';
                    } 

                }
            function updateSweepForm(){
                icbs.Deposit.Sweep('sweepForm',"${createLink(controller : 'search', action:'search')}",{id:${depositInstance?.id},searchDomain:"deposit-sweep"});
            }
            
            function addSweep(params){
                console.log(params);
                if(params){
                    console.log('sweep 1');
                    icbs.Deposit.Sweep('add',"${createLink(controller : 'deposit', action:'createSweepAjax')}",{id:${depositInstance?.id},deposit:params.deposit});
                }else{
                    console.log('sweep 2');
                    icbs.Deposit.Sweep('add',"${createLink(controller : 'deposit', action:'createSweepAjax')}",{id:${depositInstance?.id}});
                }
            }
            function saveSweep(){
                checkIfAllowed("DEP01501", saveSweepAuthCallback);
            }
            function saveSweepAuthCallback() {
                icbs.Deposit.Sweep('save',"${createLink(controller : 'deposit', action:'saveSweepAjax')}",jQuery('#saveSweepForm').serialize());
            }
            function editSweep(id){
                icbs.Deposit.Sweep('edit',"${createLink(controller : 'deposit', action:'editSweepAjax')}",{id:id});
            }
            function updateSweep(){
                checkIfAllowed("DEP01502", updateSweepAuthCallback);
            }
            function updateSweepAuthCallback() {
                icbs.Deposit.Sweep('update',"${createLink(controller : 'deposit', action:'updateSweepAjax')}",jQuery('#updateSweepForm').serialize());
            }
            icbs.Dependencies.Ajax.addLoadEvent(function(){
                $('#editSweepModal').on('hidden.bs.modal', function () {
                    updateSweepForm();
                })
                $('#addSweepModal').on('hidden.bs.modal', function () {
                    updateSweepForm();
                });
            })
            var modal;
            function initializeDepositSearchModal(){
                modal = new icbs.UI.Modal({id:"addSweepSearchModal",url:"${createLink(controller : 'search', action:'search', params:[searchDomain: "deposit"])}",title:"Search Deposit Accounts",onCloseCallback:addSweep});
            }
        </g:javascript>
    </head>
    <body>
        <content tag="breadcrumbs">
            <span class="fa fa-chevron-right"></span><span class="current">ATA/Sweep Maintenance</span>
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
                <div id="sweepFormDiv">
                    <g:render template="/search/searchTemplate/deposit/sweep/viewGrid"/>
                </div>
            </div>
            <div class="modal" id="addSweepModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">Add Sweep Account</h4>
                        </div>
                        <div class="modal-body">
                            <g:render template='/deposit/details/depositInfo' model="[depositInstance:depositInstance]"/>
                             <div id="add">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="#" data-dismiss="modal" class="btn">Close</a>
                            <a href="#" class="btn btn-primary"onclick="saveSweep()">Save changes</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal" id="editSweepModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">Edit Sweep Account</h4>
                        </div>
                        <div class="modal-body">
                            <g:render template='/deposit/details/depositInfo' model="[depositInstance:depositInstance]"/>
                             <div id="edit">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="#" data-dismiss="modal" class="btn">Close</a>
                            <a href="#" class="btn btn-primary"onclick="updateSweep()">Save changes</a>
                        </div>
                    </div>
                </div>
            </div>
        </content>
        
        <content tag="main-actions">
            <ul>
                <g:if test="${depositInstance}">
                    <li><a href="#" onclick="addSweep('${params}')">New Sweep Account</a></li>
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
