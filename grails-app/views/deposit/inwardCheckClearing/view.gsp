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
        <title>Inward Check Clearing</title>
        <g:javascript>
            function submitCheckClearingForm(){
                $('#inwardCheckClearingForm').submit();
            }
            icbs.Dependencies.Ajax.addLoadEvent(function(){
                document.getElementById('checkClearing').addEventListener('change', submitCheckClearingForm, false);
            })
        </g:javascript>
    </head>
    <body>
        <content tag="breadcrumbs">
            <span class="fa fa-chevron-right"></span><span class="current">Inward Clear Checking</span>
	</content>
        <content tag="main-content">
            <g:if test="${flash.message}">
                <!--
                <div class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div>
                -->
                <script>
                    $(function(){
                        var x = '${flash.message}';
                        notify.message(x);
                    });
                </script>
            </g:if>
            <div class="row">
                <g:uploadForm name="inwardCheckClearingForm" action="viewInwardCheckClearing"controller="deposit">
                    <g:render template='inwardCheckClearing/form' model=''/>
                </g:uploadForm>
            </div>
            <div class="row">
                <g:uploadForm name="processInwardCheckingForm" action="processInwardCheckClearing"controller="deposit">
                    <div class="box-body table-responsive no-padding">
                        <table id="clearingTable" class="table table-hover table-condensed table-bordered table-striped">
                            <tr> 
                                <td>Count</td>
                                <td><label>Account Number</label></td>
                                <td><label>Check No</label></td>
                                <td><label>Amount</label></td>
                                <td><label>BRSTN</label></td>
                                <td><label>TRANCD</label></td>
                                <td></td>
                            </tr>
                            <g:each var="check" in="${domainInstance?.checks}" status="i">
                                <tr>
                                    <g:hiddenField name="checks[${i}].chequeNo" value="${check?.chequeNo}"/>
                                    <g:hiddenField name="checks[${i}].amt" value="${check?.amt}"/>
                                    <g:hiddenField name="checks[${i}].brstn" value="${check?.brstn}"/>
                                    <g:hiddenField name="checks[${i}].trancd" value="${check?.trancd}"/>
                                    <g:hiddenField name="checks[${i}].acctNo" value="${check?.acctNo}"/>
                                    <td>${i}</td>
                                    <td>${check?.acctNo}</td>
                                    <td>${check?.chequeNo}</td>
                                    <td><g:formatNumber format="###,###,##0.00" number="${check?.amt}"/></td>
                                    <td>${check?.brstn}</td>
                                    <td>${check?.trancd}</td>
                                    <td>
                                         <g:hasErrors bean="${domainInstance}" field="checks[${i}].acctNo">
                                        <span class="help-block">
                                            <g:eachError bean="${domainInstance}" field="checks[${i}].acctNo">
                                                <g:message error="${it}" /><br/>
                                            </g:eachError>
                                        </span>
                                        </g:hasErrors> 
                                        <g:hasErrors bean="${domainInstance}" field="checks[${i}].chequeNo">
                                        <span class="help-block">
                                            <g:eachError bean="${domainInstance}" field="checks[${i}].chequeNo">
                                                <g:message error="${it}" /><br/>
                                            </g:eachError>
                                        </span>
                                        </g:hasErrors> 
                                         <g:hasErrors bean="${domainInstance}" field="checks[${i}].amt">
                                        <span class="help-block">
                                            <g:eachError bean="${domainInstance}" field="checks[${i}].amt">
                                                <g:message error="${it}" /><br/>
                                            </g:eachError>
                                        </span>
                                        </g:hasErrors> 
                                         <g:hasErrors bean="${domainInstance}" field="checks[${i}].brstn">
                                        <span class="help-block">
                                            <g:eachError bean="${domainInstance}" field="checks[${i}].brstn">
                                                <g:message error="${it}" /><br/>
                                            </g:eachError>
                                        </span>
                                        </g:hasErrors> 
                                         <g:hasErrors bean="${domainInstance}" field="checks[${i}].trancd">
                                        <span class="help-block">
                                            <g:eachError bean="${domainInstance}" field="checks[${i}].trancd">
                                                <g:message error="${it}" /><br/>
                                            </g:eachError>
                                        </span>
                                        </g:hasErrors> 
                                    </td>
                                </tr>
                            </g:each> 
                        </table>
                    </div>
                </g:uploadForm>
            </div>
        </content>
        <content tag="main-actions">
            <ul>
                <li><button id="checkClearBtn" ${disabledProcessing} onclick="$('#processInwardCheckingForm').submit()">Process Inward Check Clearing</button></li>
                <li>Print Inward Report</li>
                <!--
                <li><g:link action="depositInquiry" id="${depositInstance?.id}"  
                                                    onclick="return confirm('Are you sure you want to return to Deposit Inquiries page?');">Return to Deposit Inquiry Page</g:link></li>
                -->                                    
            </ul>                                        
        </content>
    </body>
</html>