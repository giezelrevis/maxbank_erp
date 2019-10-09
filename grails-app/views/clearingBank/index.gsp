
<%@ page import="icbs.admin.ClearingBank" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'clearingBank.label', default: 'ClearingBank')}" />
		<title>Clearing Bank List</title>
	</head>
	<body>
            <content tag="breadcrumbs">
            <span class="fa fa-chevron-right"></span><span class="current">Clearing Bank List</span>
            </content>
            <content tag="main-content">   
		<div id="list-clearingBank" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
                            <!--	<div class="message" role="status">${flash.message}</div> -->
                            <script>
                                $(function(){
                                    var x = '${flash.message}';
                                    notify.message(x);
                                });
                            </script>
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
            <table class="table table-bordered table-rounded table-striped table-hover">
                <thead>
					<tr>
					
						<g:sortableColumn property="code" title="${message(code: 'clearingBank.code.label', default: 'Code')}" />
					
						<g:sortableColumn property="name" title="${message(code: 'clearingBank.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="shortName" title="${message(code: 'clearingBank.shortName.label', default: 'Short Name')}" />
					
						<g:sortableColumn property="contactPerson" title="${message(code: 'clearingBank.contactPerson.label', default: 'Contact Person')}" />
				
					</tr>
				</thead>
				<tbody>
				<g:each in="${clearingBankInstanceList}" status="i" var="clearingBankInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                            <g:if test="${clearingBankInstance.configItemStatusId==2}">
						<td><g:link action="show" id="${clearingBankInstance.id}">${fieldValue(bean: clearingBankInstance, field: "code")}</g:link></td>
					
						<td>${fieldValue(bean: clearingBankInstance, field: "name")}</td>
					
						<td>${fieldValue(bean: clearingBankInstance, field: "shortName")}</td>
					
						<td>${fieldValue(bean: clearingBankInstance, field: "contactPerson")}</td>
                                            </g:if>
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${ClearingBankInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><g:link class="create" action="create">New Clearing Bank</g:link></li>
				</ul>
            </content>
	</body>
</html>
