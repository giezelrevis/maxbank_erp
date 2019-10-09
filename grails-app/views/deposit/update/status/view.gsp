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
        <title><g:if test="${depositInstance?.status?.id!=7}">Closing of Deposit</g:if><g:else>Reopening of Deposit</g:else></title>
    </head>
    <body>
        <content tag="main-content">
            <g:if test="${flash.message}">
                <div id= "updateStatusMessage" class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div>
            </g:if>
            <g:hasErrors bean="${depositInstance}">
                <div id= "updateStatusError" class="box-body">
                    <div class="alert alert-danger alert-dismissable">
                        <i class="fa fa-ban"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Alert!</b> 
                        <ul class="errors" role="alert">
                            <g:eachError bean="${depositInstance}" field="status">
                                 <g:message error="${it}" /><br/>
                            </g:eachError>
                        </ul>            
                    </div>
                </div>
            </g:hasErrors>
            <div class="row">
                <div class="col-md-12">
                   <g:render template='/customer/details/newCustomerDetailedInfo' model="[customerInstance:depositInstance?.customer]"/>
                </div>

                <div class="col-md-12">
                   <g:render template='/deposit/details/depositDetails' model="[depositInstance:depositInstance]"/> 

                </div>
            </div>
            <div class="row">
                <g:render template='update/status/form' model="[depositInstance:depositInstance]"/> 
            </div>
        </content>
        <content tag="main-actions">
            <ul>
                <g:if test="${depositInstance?.status?.id!=7}">
                    <li><a class="save" onclick="
                            alertify.confirm(AppTitle,'Are you sure you want to Close this Account?',
                            function(){
                                //jQuery('#depositUpdateStatusForm').submit();
                                checkIfAllowed('DEP00501', 'form#depositUpdateStatusForm', 'depositUpdateStatus');
                            },
                            function(){
                                return;
                            });">Close Account</a></li>
                </g:if>
                <g:else>
                   <li><a class="save" onclick="
                            alertify.confirm(AppTitle,'Are you sure you want re-activate this account?',
                            function(){
                                //jQuery('#depositUpdateStatusForm').submit();
                                checkIfAllowed('DEP00502', 'form#depositUpdateStatusForm', 'depositUpdateStatus');
                            },
                            function(){
                                return;
                            });">Activate Account</a></li>
                </g:else>
                <li>
                    <g:if test="${depositInstance.status.description == 'Closed'}">
                        <a href=# params="[module:'close']" onclick="alertify.confirm(AppTitle,'Are you sure you want to return to Deposit Inquiries page?',
                                    function(){
                                    var t_url = '/icbs/deposit/depositInquiry/${depositInstance?.id}?module=close';
                                    location.href=t_url;},
                                    function(){});">Return to Deposit Inquiry Page</a>
                        

                    </g:if>
                    <g:else>
                        <a href=# onclick="alertify.confirm(AppTitle,'Are you sure you want to return to Deposit Inquiries page?',
                                    function(){
                                    var t_url = '/icbs/deposit/depositInquiry/${depositInstance?.id}';
                                    location.href=t_url;},
                                    function(){});">Return to Deposit Inquiry Page</a>
                    </g:else>
                </li>
            </ul>                                        
        </content>
    </body>
</html>
