
<%@ page import="icbs.gl.GlAccount" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'glAccount.label', default: 'GlAccount')}" />
		<title>${glAccountInstance?.name.encodeAsHTML()}</title>
	</head>
	<body>
            <content tag="main-content">   
		<div id="show-glAccount" class="content scaffold-show" role="main">
                    <g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
                    </g:if>
                    <table class="table table-bordered table-rounded table-striped table-hover">
                        <tbody>
                            <tr>
                                <td><label>GL Account Type</label></td>
                                <td><g:link controller="glAcctType" action="show" id="${glAccountInstance?.type?.id}">${glAccountInstance?.type?.encodeAsHTML()}</g:link></td>
                            </tr>
                            <tr>
                                <td><label>Currency</label></td>
                                <td><g:link controller="currency" action="show" id="${glAccountInstance?.currency?.id}">${glAccountInstance?.currency?.name.encodeAsHTML()}</g:link></td>
                            </tr>
                            <tr>
                                <td><label>GL Account Number</label></td>
                                <td>${glAccountInstance?.code}</td>
                            </tr>
                            <tr>
                                <td><label>GL Account Name</label></td>
                                <td>${glAccountInstance?.name}</td>
                            </tr>
                            <tr>
                                <td><label>GL Account Shortened Name</label></td>
                                <td>${glAccountInstance?.shortName}</td>
                            </tr>
                            <tr>
                                <td><label>GL Account Sort Code (Parent)</label></td>
                                <td>${glAccountInstance?.parent?.sort_name}</td>
                            </tr>
                            <tr>
                                <td><label>Update GL through Batch Only</label></td>
                                <td><g:formatBoolean boolean="${glAccountInstance?.batchUpdate}" /></td>
                            </tr>
                            <tr>
                                <td><label>Total Debits</label></td>
                                <td><g:formatNumber format="###,###,##0.00" number="${glAccountInstance?.debit}"/></td>
                            </tr>
                            <tr>
                                <td><label>Total Credits</label></td>
                                <td><g:formatNumber format="###,###,##0.00" number="${glAccountInstance?.credit}"/></td>
                            </tr>
                            <tr>
                                <td><label>Total Debits Today</label></td>
                                <td><g:formatNumber format="###,###,##0.00" number="${glAccountInstance?.debitToday}"/></td>
                            </tr>
                            <tr>
                                <td><label>Total Credits Today</label></td>
                                <td><g:formatNumber format="###,###,##0.00" number="${glAccountInstance?.creditToday}"/></td>
                            </tr>                            
                            <tr>
                                <td><label>Debit Balance</label></td>
                                <td><g:formatNumber format="###,###,##0.00" number="${glAccountInstance?.debitBalance}"/></td>
                            </tr>
                            <tr>
                                <td><label>Credit Balance</label></td>
                                <td><g:formatNumber format="###,###,##0.00" number="${glAccountInstance?.creditBalance}"/></td>
                            </tr> 
                            <tr>
                                <td><label>Normal Balance</label></td>
                                <td><g:formatNumber format="###,###,##0.00" number="${glAccountInstance?.balance}"/></td>
                            </tr>                             
                        </tbody>
                    </table>   
		</div>
            </content>
             <content tag="main-actions">
                <ul>
                    <li><g:link class="list" action="index">GL Accounts</g:link></li>
                    <li><g:link class="edit" action="edit" resource="${glAccountInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link></li>
                    <li><g:form id="delete" url="[resource:glAccountInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
                                        <a href="#" onClick="alertifyConfirmOverrideFunction();">Delete</a>
				</fieldset>
			</g:form></li>
                    
                    <li><g:link class="create" action="create">Create New GL Account</g:link></li>
                    <li><a href='#' id="add-buttons" type="button" data-toggle="modal" data-target="#modalParameters" class="btn btn-primary multi-field-btn-add">Print GL Transactions</a></li>

                <!-- Modal -->
                <div id="modalParameters" class="modal fade" role="dialog">
                  <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title" style="color: black;">Generate GL Transactions for an Account</h4>
                        </div>
                        <div class="modal-body">
                            <div class="fieldcontain form-group ${hasErrors(bean: customerInstance, field: 'registrationDate', 'has-error')} ">
                                <label class="control-label col-sm-4" style="color: gray;">Currency Code: </label>
                                <div class="col-sm-8"><g:textField class="form-control" id="glcode" name="glcode" value="${glAccountInstance?.currency?.code.encodeAsHTML()}"/></div>
                            </div>
                            <div class="fieldcontain form-group ${hasErrors(bean: customerInstance, field: 'registrationDate', 'has-error')} ">
                                <label class="control-label col-sm-4" style="color: gray;">Gl Code: </label>
                                <div class="col-sm-8"><g:textField class="form-control" id="glcode" name="glcode" value="${glAccountInstance.code}"/></div>
                            </div>
                            
                            
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
                            <!--<g:link target="_blank" class="btn btn-default" url = "${icbs.admin.Institution.get(94).paramValue}${icbs.admin.Report.get(6).baseParams}&output=${icbs.admin.Report.get(6).outputParam}&reportUnit=${icbs.admin.Report.get(6).reportUnit}&date_start=document.getElementById('date1').value&date_end=document.getElementById('date2').value&gl_code=${glAccountInstance.code}&currency_code=${glAccountInstance?.currency?.code}&generatedby=${icbs.admin.UserMaster.get(session.user_id).username}">Print Report</g:link>
                            -->
                            <a href = "#" onclick="generatereport();" class="btn btn-default"> Print Report </a>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                       
                        <g:javascript>
                            function alertifyConfirmOverrideFunction(){
                                checkIfAllowed("GEN00203", deleteGlAccountAuthCallback);
                            }
                            function deleteGlAccountAuthCallback(){
                                alertify.confirm(AppTitle,'Are you sure you want to Delete Gl Account?',
                                    function(){
                                        // sending form into controller;
                                        document.getElementById("delete").submit();
                                    },
                                    function(){
                                        return;
                                    });
                            }
                            function generatereport(){
                                reportlink = "${icbs.admin.Institution.get(94).paramValue}${icbs.admin.Report.get(24).baseParams}&output=${icbs.admin.Report.get(24).outputParam}";
                                reportlink = reportlink + "&reportUnit=${icbs.admin.Report.get(24).reportUnit}";
                                reportlink = reportlink + "&DateFrom=" + dateformat(document.getElementById('date1').value);
                                reportlink = reportlink + "&DateTo=" + dateformat(document.getElementById('date2').value);
                                reportlink = reportlink + "&gl_code=${glAccountInstance.code}&currency_code=${glAccountInstance?.currency?.code}";
                                reportlink = reportlink + "&branch_name=${icbs.admin.UserMaster.get(session.user_id).branch.name}";
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
