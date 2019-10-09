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
        <g:javascript>
            function changeInterestRateFormAjax(){
                icbs.Deposit.interestRateMaintenance('changeInterestRateViewCallback',"${createLink(controller : 'deposit', action:'interestRateFormAjax')}",$('#interestRateMaintenanceForm').serialize());
            }
        </g:javascript>
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
                <div class="row">
                    <div class="col-md-12">
                        <label class="radio-inline">
                            <input type="radio" checked="checked" name="type"  id="type" value="0"> All Accounts
                        </label>
                    </div><!-- /.col-lg-6 -->

                        <div id="allAcctDiv">
                            <g:render template='interestRateMaintenance/template/allAccounts'/>
                        </div>

                </div>
                <br/>
                <br/>
                <div class="row">
                    <div class="col-md-12">
                        <label class="radio-inline">
                            <input type="radio" name="type"  id="type" value="1"> Specific Account
                        </label>
                    </div><!-- /.col-lg-6 -->
                </div>
                
                <div class="row">
                       <div class="form-group">
                            <label class="control-label">Deposit Account No.</label>
                            <div class="col-sm-9"><g:textField name="deposit"value="${depositInstance?.id}" disabled="disabled" class="form-control" /></div>
                        </div>
                </div>
                <div class="row">
                    
                    <div class="col-md-6">
                       <g:render template='/customer/details/customerDetails' model="[customerInstance:depositInstance?.customer]"/>
                    </div>
                    <div class="col-md-6">
                        <g:render template='/deposit/details/depositInterestRateDetails' model="[depositInstance:depositInstance]"/> 
                    </div>
                    
                </div>
            </g:form>
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
        </content>
        
        <content tag="main-actions">
            <ul>
                <g:if test="${depositInstance}">
                    <li><a href="#" onclick="$('#interestRateMaintenanceForm').submit()">Update</a></li>
                </g:if>
                <g:if test="${depositInstance}">
                    <li><a href="#" onclick="editAllAcctsInterestRate()">All Accounts Interest Rate Maintenance</a></li>
                </g:if>
                <g:if test="${depositInstance}">
                    <li><a href="#" onclick="editSpecificAcctsInterestRate()">Specific Account Interest Rate Maintenance</a></li>
                </g:if>
                <li><g:link action="depositInquiry" id="${depositInstance?.id}"  
                                                    onclick="return confirm('Are you sure you want to return to Deposit Inquiries page?');">Return to Deposit Inquiry Page</g:link></li>
            </ul>                                        
        </content>
    </body>
</html>
