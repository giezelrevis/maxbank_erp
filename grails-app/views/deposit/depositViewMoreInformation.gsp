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
        <title>Deposit View More Information</title>
    </head>
    <body>
        <content tag="breadcrumbs">
            <span class="fa fa-chevron-right"></span><span class="current">Deposit View Information</span>
	</content>
        <content tag="main-content">
            
           <h3>Account Number: ${depositInstance?.acctNo}</h3> 
            <div class="row">
                <div class="col-xs-12 col-sm-12">
                        <g:render template='/customer/details/newCustomerDetailedInfo' model="[customerInstance:depositInstance?.customer]"/>
                </div>

            </div>
            <div class="row">
                <div class="section-container">
                    <fieldset>
                    <legend class="section-header">Account Information</legend>
                    <table class="table table-bordered table-striped">
                        <tbody>
                            <tr>
                                <td style="font-weight:bold" width="30%">Date Open</td>
                                <td width="75%"><g:formatDate format="MM/dd/yyyy" date="${depositInstance?.dateOpened}"/></td>
                            </tr>
                            <g:if test="${depositInstance?.type?.id==3}">  
                            <tr>
                                <td style="font-weight:bold" width="30%">Interest Start Date</td>
                                <td width="75%"><g:formatDate format="MM/dd/yyyy" date="${depositInstance?.currentRollover?.startDate}"/></td>
                            </tr>
                            <tr>
                                <td style="font-weight:bold" width="30%">Maturity Date</td>
                                 <g:if test="${depositInstance?.depositInterestScheme?.fdMonthlyTransfer==true}">
                                    <td width="75%"><g:formatDate format="MM/dd/yyyy"  date="${depositInstance?.maturityDate}" /></td>
                                 </g:if>
                                 <g:else>
                                     <td width="75%"><g:formatDate format="MM/dd/yyyy" date="${depositInstance?.currentRollover?.endDate}" /></td>
                                 </g:else>
                            </tr>
                            <tr>
                                <td style="font-weight:bold" width="30%">Term</td>
                                <td width="75%"><g:formatNumber format="##,###" number="${depositInstance?.maturityDate - depositInstance?.currentRollover?.startDate}"/></td>
                            </tr>
                            </g:if>
                            <tr>
                                <td style="font-weight:bold" width="30%">Interest Rate</td>
                                <td width="75%"><g:formatNumber format="#,##0.00" number="${depositInstance?.interestRate}"/>%</td>
                            </tr>
                            <tr>
                                <td style="font-weight:bold" width="30%">Passbook No</td>
                                <td width="75%"><g:formatNumber format="###############" id="NoPass" number="${depositInstance.passBookNo}"/></td>
                            </tr>
                            <g:if test="${depositInstance?.type?.id==3}">
                            <tr>
                                <td style="font-weight:bold" width="30%">Rollover Type</td>
                                <td width="75%">${depositInstance?.currentRollover?.type}</td>
                            </tr>
                            <tr>
                                <td style="font-weight:bold" width="30%">Mode of Interest Payment</td>
                                <td width="75%">${depositInstance?.currentRollover?.interestPaymentMode?.description}</td>
                            </tr>
                            <tr>
                                <td style="font-weight:bold" width="30%">Credit Account</td>
                                <td width="75%"><g:link action="depositInquiry" id="${depositInstance?.currentRollover?.fundedDeposit?.id}">${depositInstance?.currentRollover?.fundedDeposit?.acctNo}</g:link></td>
                            </tr>
                            </g:if>
                            <tr>
                                <td style="font-weight:bold" width="30%">Last Transaction Date</td>
                                <td width="75%"><g:formatDate format="MM/dd/yyyy"  date="${depositInstance?.lastTxnDate}" /></td>
                            </tr>
                            <tr>
                                <td style="font-weight:bold" width="30%">Status Change Date</td>
                                <td width="75%"><g:formatDate format="MM/dd/yyyy"  date="${depositInstance?.statusChangeDate}" /></td>
                            </tr>
                            <tr>
                                <td style="font-weight:bold" width="30%">Last Capitalization Date</td>
                                <td width="75%"><g:formatDate format="MM/dd/yyyy" date="${depositInstance?.lastCapitalizationDate}" /></td>
                            </tr>
                        </tbody>
                    </table>
                    </fieldset>
                </div>  
            </div>

            <div class="row">
                <div class="section-container">
                    <fieldset>
                        <legend class="section-header">Balance Information</legend>
                            <table class="table table-bordered table-striped">
                                <tbody>
                                    <tr>
                                        <td style="font-weight:bold" width="30%">Current Balance</td>
                                        <td width="75%"><g:formatNumber format="###,###,##0.00" number="${depositInstance?.ledgerBalAmt}"/></td>
                                    </tr>
                                    <tr>
                                        <td style="font-weight:bold" width="30%">Available Balance</td>
                                        <td width="75%"><g:formatNumber format="###,###,##0.00" number="${depositInstance?.availableBalAmt}"/></td>
                                    </tr>
                                    <tr>
                                        <td style="font-weight:bold" width="30%">Passbook Balance</td>
                                        <td width="75%"><g:formatNumber format="###,###,##0.00" number="${depositInstance?.passbookBalAmt}"/></td>
                                    </tr>
                                    <tr>
                                        <td style="font-weight:bold" width="30%">Hold Balance</td>
                                        <td width="75%"><g:formatNumber format="###,###,##0.00" number="${depositInstance?.holdBalAmt}"/></td>
                                    </tr>
                                    <g:if test="${depositInstance?.type?.id == 3 && depositInstance?.currentRollover?.status?.id == 1}">
                                        <g:if test="${depositInstance?.status?.id == 7}">
                                            <tr>
                                                <td style="font-weight:bold" width="30%">Accrued Interest</td>
                                                <td width="75%"><g:formatNumber format="###,###,##0.00" number="${depositInstance?.acrintAmt}"/></td>
                                            </tr>
                                        </g:if>    
                                        <g:else>
                                            <tr>
                                                <td style="font-weight:bold" width="30%">Accrued Interest</td>
                                                <td width="75%"><g:formatNumber format="###,###,##0.00" number="${depositInstance?.currentRollover?.normalInterestAmt}"/></td>
                                            </tr>
                                            <tr>
                                                <td style="font-weight:bold" width="30%">Pre-Term Interest</td>
                                                <td width="75%"><g:formatNumber format="###,###,##0.00" number="${depositInstance?.currentRollover?.preTermInterestAmt}"/></td>
                                            </tr>
                                        </g:else>
                                    </g:if>
                                    <g:else>
                                        <tr>
                                            <td style="font-weight:bold" width="30%">Accrued Interest</td>
                                            <td width="75%"><g:formatNumber format="###,###,##0.00" number="${depositInstance?.acrintAmt}"/></td>
                                        </tr>
                                    </g:else>
                                        <tr>
                                            <td style="font-weight:bold" width="30%">Last EOM ADB</td>
                                            <td width="75%"><g:formatNumber format="###,###,##0.00" number="${depositInstance?.lmAveBalAmt}"/></td>
                                        </tr>
                                </tbody>
                            </table>    
                    </fieldset>
                </div>
            </div>
            
            <div class="row">
                <div class="section-container">
                    <fieldset>
                        <legend class="section-header">Other Owners/Signatories</legend>
                            <table class="table table-bordered table-striped">
                                <tbody>
                                    <tr>
                                        <td style="font-weight:bold" width="30%">Ownership Type</td>
                                        <td width="75%">${depositInstance?.ownershipType?.description}</td>
                                    </tr>
                                    <tr>
                                        <td style="font-weight:bold" width="30%">Signatory Rules</td>
                                        <td width="75%">${depositInstance?.sigRules}</td>
                                    </tr>
                                    <tr>
                                        <td style="font-weight:bold" width="30%">Signatory Remarks</td>
                                        <td width="75%">${depositInstance?.sigRemarks}</td>
                                    </tr>
                                </tbody>
                            </table>    
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
                    </fieldset>
                </div>
            </div>
            
            <div class="row">
                <g:render template="/search/searchTemplate/deposit/txn/viewGrid"/>
            </div>
        </content>
        <content tag="main-actions">
            <ul>
                <!-- <li><g:link action="depositInquiry" id="${depositInstance?.id}" onclick="return confirm('Are you sure you want to return to Deposit Inquiries page?');  ">Return to Deposit Inquiry Page</g:link></li>-->
                <li><g:link action="depositInquiry" id="${depositInstance?.id}" >Return to Deposit Inquiry Page</g:link></li>
                <li>
                <a href = "#" onclick="genReportDEP007();">Print Deposit Inquiry</a></li>
                
                <g:javascript>
                    function genReportDEP007(){
                        reportlink = "${icbs.admin.Institution.get(94).paramValue}${icbs.admin.Report.get(14).baseParams}&output=${icbs.admin.Report.get(14).outputParam}";
                        reportlink = reportlink + "&reportUnit=${icbs.admin.Report.get(14).reportUnit}";             
                        reportlink = reportlink + "&deposit_acct_no=${depositInstance?.acctNo}";
                        reportlink = reportlink + "&generatedby=${icbs.admin.UserMaster.get(session.user_id).username}";
                        sendtojasperver(reportlink);
                    }       
                </g:javascript>
                
                <li><a href='#' id="add-buttons" type="button" data-toggle="modal" data-target="#modalParameters" class="btn btn-primary multi-field-btn-add">
                        Print Bank Statement</a></li>
                <!-- Modal -->
                <div id="modalParameters" class="modal fade" role="dialog">
                  <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title" style="color: black;">Deposit Bank Statement</h4>
                        </div>
                        <div class="modal-body">
                            
                            <!-- date1 -->
                            <div class="fieldcontain form-group ${hasErrors(bean: customerInstance, field: 'registrationDate', 'has-error')} ">
                                <label class="control-label col-sm-4" style="color: gray;">Cut-Off Date Start: </label>
                                <div class="col-sm-8"><g:customDatePicker name="date1" id="date1"  precision="day" class="form-control"  value="" default="none" noSelection="['': '']" /></div>
                            </div>
                            <!-- date2 -->
                            <div class="fieldcontain form-group ${hasErrors(bean: customerInstance, field: 'registrationDate', 'has-error')} ">
                                <label class="control-label col-sm-4" style="color: gray;">Cut-Off Date End: </label>
                                <div class="col-sm-8"><g:customDatePicker name="date2" id="date2"  precision="day" class="form-control"  value="" default="none" noSelection="['': '']" /></div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href = "#" onclick="genReportDEP008();" class="btn btn-default"> Print Report </a>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                       
                        <g:javascript>
                            function genReportDEP008(){
                                reportlink = "${icbs.admin.Institution.get(94).paramValue}${icbs.admin.Report.get(15).baseParams}&output=${icbs.admin.Report.get(15).outputParam}";
                                reportlink = reportlink + "&reportUnit=${icbs.admin.Report.get(15).reportUnit}";
                                reportlink = reportlink + "&DateFrom=" + dateformat(document.getElementById('date1').value);
                                reportlink = reportlink + "&DateTo=" + dateformat(document.getElementById('date2').value);
                                reportlink = reportlink + "&deposit_acct_no=${depositInstance?.acctNo}";
                                reportlink = reportlink + "&generatedby=${icbs.admin.UserMaster.get(session.user_id).username}";
                                sendtojasperver(reportlink);
                            }
                        </g:javascript>
                    </div>

                  </div>
                </div>  
                <!-- modal close --> 
            </ul>       
        </content>
    </body>
</html>
