
<%@ page import="icbs.loans.CreditInvestigation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'creditInvestigation.label', default: 'CreditInvestigation')}" />
		<title>View Credit Investigation</title>
	</head>
	<body>
        <content tag="main-content">   
		<div id="show-creditInvestigation" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
                <div class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div>
            </g:if>
			<div class="nav-tab-container">
                <ul class="nav nav-tabs">
					<li class="active"><a href="#tab_1" data-toggle="tab">Details</a></li>
               		<li><a href="#tab_2" data-toggle="tab">Attachments</a></li>
                	<li><a href="#tab_3" data-toggle="tab">Checklist</a></li>
                </ul>
            </div>
            <div class="tab-content">
				<div class="tab-pane active fade in table-responsive" id="tab_1">
                    <g:render template="details/show"/>
                </div>
                <div class="tab-pane" id="tab_2">
                    <g:render template="attachments/show"/>
                </div>
                <div class="tab-pane" id="tab_3">
                    <g:render template="checklist" model="[creditInvestigationInstance:creditInvestigationInstance]"/>
                </div>
			</div>			
		</div>
        </content>
         <content tag="main-actions">
            <ul>
                <li><g:link class="list" action="index">Search Credit Investigation</g:link></li>
                <li><g:link action="edit" controller="creditInvestigation" id="${creditInvestigationInstance.id}">Update Credit Investigation</g:link></li>
                <li><a href="#" onclick="genReportLNA002()">Print Credit Investigation Report</a></li>
                <g:javascript>
                    function genReportLNA002(){
                        reportlink = "${icbs.admin.Institution.get(94).paramValue}${icbs.admin.Report.get(17).baseParams}&output=${icbs.admin.Report.get(17).outputParam}";
                        reportlink = reportlink + "&reportUnit=${icbs.admin.Report.get(17).reportUnit}";             
                        reportlink = reportlink + "&loan_application_id=${creditInvestigationInstance?.id}";
                        reportlink = reportlink + "&generatedby=${icbs.admin.UserMaster.get(session.user_id).username}";
                        sendtojasperver(reportlink);
                    }       
                </g:javascript>
            </ul>
    	</content>
	</body>
</html>
