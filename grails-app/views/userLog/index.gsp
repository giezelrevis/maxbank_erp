
<%@ page import="icbs.audit.AuditLog" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'auditLog.label', default: 'AuditLog')}" />
		<title>User Logs</title>
	</head>
	<body>
            <content tag="breadcrumbs">
            <span class="fa fa-chevron-right"></span><span class="current">User Logs</span>
            </content>
            <content tag="main-content">   
		<div id="list-auditLog" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
                        <g:form class="form-inline">
					<div class="form-group">
						<g:select name="max" value="${params.max}" from="[5, 10, 15, 20]" class="form-control input-sm pull-left"onchange="this.form.submit()" />
					</div>
					<div class="right">
						<div class="form-group">
							<g:textField  type="text" name="query" class="form-control input-sm pull-right" style="width: 150px;" placeholder="Search"/>
						</div>
						<g:submitButton name="Search" class="btn btn-sm btn-default"><i class="fa fa-search"></i></g:submitButton>
					</div>
				</g:form>
			<div class="table-responsive">
                            <table class="table table-hover table-condensed table-bordered table-striped">
                                <thead>
					<tr>
					
						<th><g:message code="auditLog.auditType.label" default="User" /></th>
					
						<g:sortableColumn property="date" title="${message(code: 'auditLog.date.label', default: 'Date/Time')}" />
					
						<th><g:message code="auditLog.module.label" default="Activity" /></th>
                                                <th>Description</th>

						<g:sortableColumn property="ipAddress" title="${message(code: 'auditLog.ipAddress.label', default: 'IP Address')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${auditLogInstanceList}" status="i" var="auditLogInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
					
						<td>${fieldValue(bean: auditLogInstance, field: "userMaster.name")}</td>
					
						<td>${auditLogInstance.date}</td>

						<td>${auditLogInstance.auditType.description}</td>
                                                
                                                <td>${auditLogInstance.description}</td>
					
						<td>${fieldValue(bean: auditLogInstance, field: "ipAddress")}</td>
					
					
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${AuditLogInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><a href='#' id="add-buttons" type="button" data-toggle="modal" data-target="#modalParameters" class="btn btn-primary multi-field-btn-add">Print Audit Log</a></li>

                <!-- Modal -->
                <div id="modalParameters" class="modal fade" role="dialog">
                  <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title" style="color: black;">Generate Audit Log</h4>
                        </div>
                        <div class="modal-body">
                            <div class="col-sm-8">
                                <label class="control-label col-sm-4" style="color: gray;">System Log Type: </label>
                                <g:select id="audittype" name="audittype" from="${icbs.lov.AuditType.list()}" optionKey="description" optionValue="description" value="" class="form-control"/>
                                
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
                            
                            <a href = "#" onclick="generatereport();" class="btn btn-default"> Print Report </a>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                       
                        <g:javascript>
                            function generatereport(){
                                reportlink = "${icbs.admin.Institution.get(94).paramValue}${icbs.admin.Report.get(26).baseParams}&output=${icbs.admin.Report.get(26).outputParam}";
                                reportlink = reportlink + "&reportUnit=${icbs.admin.Report.get(26).reportUnit}";
                                reportlink = reportlink + "&DateFrom=" + dateformat(document.getElementById('date1').value);
                                reportlink = reportlink + "&DateTo=" + dateformat(document.getElementById('date2').value);
                                reportlink = reportlink + "&multi_select_audit_type=" + document.getElementById('audittype').value;
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
