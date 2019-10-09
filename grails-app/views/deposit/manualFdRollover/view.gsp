<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="icbs.deposit.Rollover" %>
<%@ page import="icbs.admin.Branch" %>
<%@ page import="icbs.admin.UserMaster" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <asset:javascript src="depositHelper.js"/>
        <title>FD Rollover Options</title>
        <g:javascript>
             
            function addRollover(){
                icbs.Deposit.ManualRollover('add',"${createLink(controller : 'deposit', action:'createManualRolloverAjax')}",{id:${depositInstance?.id}});
            }
            function saveRollover(){
                alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                    function(){
                        checkIfAllowed("DEP01800", saveRolloverAuthCallback);
                    },
                    function(){
                        return;
                    });               
            }
            function saveRolloverAuthCallback() {
                icbs.Deposit.ManualRollover('save',"${createLink(controller : 'deposit', action:'saveManualRollover')}",jQuery('#saveRolloverForm').serialize());
            }
        </g:javascript>
    </head>
    <body>
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
                <div class="section-container">
                <fieldset>
                    <legend class="section-header">Other Owners/Signatories</legend>
                    <div class="infowrap">
                        <dl class="dl-horizontal">
                            <dt>Ownership Type</dt>
                            <dd>${depositInstance?.ownershipType?.description}</dd>
                        </dl>
                        <div class="table-responsive col-md-12">
                            <g:if test="${depositInstance?.signatories?.size()>0}">
                                <table id="signatoryTable" class="table table-hover table-condensed table-striped">
                                    <tr>
                                        <td><label>CID</label></td>
                                        <td><label>Name</label></td>
                                        <td><label>Signatory</label></td>
                                    </tr>
                                    <tbody height="100px">
                                        <div id="signatoryList">
                                            <g:each var="signatory" in="${depositInstance?.signatories}" status="i">
                                                <g:if test="${signatory.status.id!=3}">
                                                    <g:render template='form/signatory/onetomany/signatory' model="[signatory:signatory,i:i,displayOnly:'true']"/>
                                                </g:if>
                                            </g:each>
                                    </tbody>
                                </table>
                            </g:if>
                        </div>
                        <dl class="dl-horizontal">
                            <dt>Signatory Rules</dt>
                            <dd>${depositInstance?.sigRules}</dd>
                        </dl>
                        <dl class="dl-horizontal">
                            <dt>Signatory Remarks</dt>
                            <dd>${depositInstance?.sigRemarks}</dd>
                        </dl>
                    </div>
                </fieldset>
                </div>
            </div>
            <div class="modal" id="addRolloverModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">Manual Rollover</h4>
                        </div>
                        <div class="modal-body">
                            <g:render template='/deposit/details/depositInfo' model="[depositInstance:depositInstance]"/>
                            <div id="add">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="#" data-dismiss="modal" class="btn">Close</a>
                            <a href="#" class="btn btn-primary"onclick="saveRollover()">Save changes</a>
                        </div>
                    </div>
                </div>
            </div>
        </content>
        
        <content tag="main-actions">
            <ul>
                <g:if test="${depositInstance}">
                    <li><a href="#" onclick="addRollover()">Manual FD Rollover</a></li>
                    <li><a href='/icbs/deposit/editRollover/${depositInstance?.id}'>Rollover FD</a></li>
                </g:if>
                <li><a href="#" onclick="addRollover()">Print Rollover History</a></li>
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
