
<%@ page import="icbs.loans.Collateral" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>Collateral Management</title>
	</head>
	<body>
        <content tag="main-content">   
		<div id="list-collateral" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
                <div class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div>
            </g:if>
			<g:form>            	
            	<div class="row">
				    <div class="col-md-12">
				        <div class="col-md-2">
				             <g:select name="max" value="${params.max}" from="[25, 50, 75, 100]" class="form-control input-sm" onchange="this.form.submit()" />
				        </div>
				        <div class="input-group col-md-10">
				            <g:textField  type="text" name="query" class="form-control" placeholder="Enter Collateral ID"/>
		                	<div class="input-group-btn">
		                    	<g:submitButton name="Search" class="btn btn-primary"></g:submitButton>
		                	</div>
				        </div>
				    </div>
				</div>				
            </g:form>
            <br />
			<div class="table-responsive">
                <table class="table table-hover table-condensed table-bordered table-striped">
                <tbody>
					<tr>
						<g:sortableColumn property="id" title="ID" />

						<g:sortableColumn property="collateralType.owner.displayName" title="Owner" />
						
						<g:sortableColumn property="collateralType.description" title="Type" />
					
						<g:sortableColumn property="appraisedValue" title="Appraised Value" />

						<g:sortableColumn property="description" title="Description" />

						<g:sortableColumn property="status.description" title="Status" />					

						<td><label>Action</label></td>
					
					</tr>
				</tbody>
				<tbody>
				<g:each in="${collateralInstanceList}" status="i" var="collateralInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

						<td>${fieldValue(bean: collateralInstance, field: "id")}</td>

						<td>${collateralInstance?.owner?.displayName}</td>

						<td>${collateralInstance?.collateralType?.description}</td>		
					
						<td><g:formatNumber format="###,###,##0.00" number="${collateralInstance?.appraisedValue}" /></td>	

						<td>${collateralInstance?.description}</td>		

						<td>${collateralInstance?.status?.description}</td>		
					
						<td><g:link class="btn btn-secondary" action="show" id="${collateralInstance.id}">View</g:link></td>

					</tr>
				</g:each>
				</tbody>
				</table>
	        </div>
			<div class="pagination">
				<g:paginate total="${collateralInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
        </content>
        <content tag="main-actions">
            <ul>
                <li><g:link class="create" action="create">New Collateral</g:link></li>
                <li><a href="#" onclick="genReportLNA003()">Print Collateral Listing Report</a></li>
                <g:javascript>
                    function genReportLNA003(){
                        reportlink = "${icbs.admin.Institution.get(94).paramValue}${icbs.admin.Report.get(18).baseParams}&output=${icbs.admin.Report.get(18).outputParam}";
                        reportlink = reportlink + "&reportUnit=${icbs.admin.Report.get(18).reportUnit}";
                        reportlink = reportlink + "&generatedby=${icbs.admin.UserMaster.get(session.user_id).username}";
                        sendtojasperver(reportlink);
                    }       
                </g:javascript>
            </ul>
        </content>
	</body>
</html>
