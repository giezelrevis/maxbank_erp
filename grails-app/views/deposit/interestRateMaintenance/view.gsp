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
        <title>Deposit Interest Rate Maintenance</title>
    </head>
    <body>
        <content tag="main-content">
            <g:if test="${flash.message}">
                    <div class="box-body">
                        <div class="alert alert-info alert-dismissable">
                            <i class="fa fa-info"></i>
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                            <b>Message</b> <div class="message" role="status">${flash.message}</div>
                        </div>
                    </div>
            </g:if>
            <g:hasErrors bean="${depositInstance}">
                <div class="box-body">
                    <div class="alert alert-danger alert-dismissable">
                        <i class="fa fa-ban"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Alert!</b> 
                        <ul class="errors" role="alert">
                            There are errors. The tabs containing the errors are highlighted in red
                        </ul>            
                    </div>
                </div>
            </g:hasErrors>
            <g:hasErrors bean="${depositInterestSchemeInstance}">
                <div class="box-body">
                    <div class="alert alert-danger alert-dismissable">
                        <i class="fa fa-ban"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Alert!</b> 
                        <ul class="errors" role="alert">
                            There are errors. The tabs containing the errors are highlighted in red
                        </ul>            
                    </div>
                </div>
            </g:hasErrors>
            <g:form name="interestRateMaintenanceForm"action="updateInterestRate">
                <g:hiddenField name="deposit"value="${depositInstance?.id}"/>
                <g:hiddenField name="type" checked="checked"  id="type" value="1"/>
                <div class="row">
                    <div class="col-md-12">
                       <g:render template='/customer/details/newCustomerDetailedInfo' model="[customerInstance:depositInstance?.customer]"/>
                    </div>
                    <div class="col-md-12">
                        <g:render template='/deposit/details/depositInterestRateDetails' model="[depositInstance:depositInstance]"/> 
                    </div>
                    
                </div>
            </g:form>
            <!--
            <div class="modal" id="editAllAcctModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">Edit All Accounts Interest Rate</h4>
                        </div>
                        <div class="modal-body">
                            <div id="createRelatedDiv">
                            
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="#" data-dismiss="modal" class="btn">Close</a>
                            <a href="#" class="btn btn-primary"onclick="update()">Save changes</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal" id="editSpecificAcctModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">Update Specific Account Interest Rate</h4>
                        </div>
                        <div class="modal-body">
                            <div id="editRelatedDiv">
                            
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="#" data-dismiss="modal" class="btn">Close</a>
                            <a href="#" class="btn btn-primary"onclick="update">Save changes</a>
                        </div>
                    </div>
                </div>
            </div>
            -->
        </content>
        
        <content tag="main-actions">
            <ul>
                <g:if test="${depositInstance}">
                    <li><a href="#" onclick="
                        if( $('#interestRate').val() ){
                            //$('#interestRateMaintenanceForm').submit()
                            alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                    checkIfAllowed('DEP01600', 'form#interestRateMaintenanceForm', 'interestRateMaintenance');
                                },
                                function(){
                                    return;
                                });
                          } else {
                                notify.message('Empty value for interest rate is not allowed!|error|alert');
                          }                        
                        ">Update Interest Rate</a></li>
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
