
<%@ page import="icbs.gl.GlAccount" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'glAccount.label', default: 'GlAccount')}" />
		<title>GL Accounts Maintenance</title>
	</head>
	<body>
            <content tag="main-content">   
		<div id="list-glAccount" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
                        <g:form class="form-inline">
				<div class="form-group">
					<g:select name="max" value="${params.max}" from="[5, 10, 15, 20]" class="form-control input-sm pull-left"onchange="this.form.submit()" />
				</div>
				<div class="right">
					<div class="form-group">
						<g:textField  type="text" name="query" class="form-control input-sm pull-right" style="width: 350px;" placeholder="Search"/>
					</div>
					<g:submitButton name="Search" class="btn btn-sm btn-default"><i class="fa fa-search"></i></g:submitButton>
				</div>
			</g:form>
			<div class="table-responsive">
                            <table class="table table-hover table-condensed table-bordered table-striped">
                                <thead>
					<tr>
						<g:sortableColumn property="name" title="${message(code: 'glAccount.name.label', default: 'Name')}" />
						<g:sortableColumn property="code" title="${message(code: 'glAccount.code.label', default: 'Code')}" />
                                                <!--
						<th><g:message code="glAccount.currency.label" default="Currency" /></th>

						<th><g:message code="glAccount.branch.label" default="Branch" /></th>
                                                -->
						<th><g:message code="glAccount.type.label" default="Type" /></th>
						<th><g:message code="glAccount.parent.label" default="Parent" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${glAccountInstanceList}" status="i" var="glAccountInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${glAccountInstance.id}">${fieldValue(bean: glAccountInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: glAccountInstance, field: "code")}</td>
						<!--
						<td>${fieldValue(bean: glAccountInstance, field: "currency.name")}</td>
					
						<td>${fieldValue(bean: glAccountInstance, field: "branch.name")}</td>
                                                -->
						<td>${fieldValue(bean: glAccountInstance, field: "type")}</td>
					
						<td>${fieldValue(bean: glAccountInstance, field: "parent.sort_name")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${GlAccountInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                    <li><g:link class="create" action="create">Add New GL Account</g:link></li>
                     <li><a class="home" href="${createLink(uri: '/glSortCode')}">GL Sort Codes</li>
                     <li><a href = "#" onclick="genReportGNL000();">Print Manual of Accounts</a></li>
                   <g:javascript>
                        function genReportGNL000(){
                            reportlink = "${icbs.admin.Institution.get(94).paramValue}${icbs.admin.Report.get(37).baseParams}&output=${icbs.admin.Report.get(37).outputParam}";
                            reportlink = reportlink + "&reportUnit=${icbs.admin.Report.get(37).reportUnit}";             
                            reportlink = reportlink + "&currency_code=PHP";
                            reportlink = reportlink + "&generatedby=${icbs.admin.UserMaster.get(session.user_id).username}";
                            sendtojasperver(reportlink);
                        }       
                    </g:javascript>
		</ul>
            </content>
	</body>
</html>
