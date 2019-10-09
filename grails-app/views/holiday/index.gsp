
<%@ page import="icbs.admin.Holiday" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'holiday.label', default: 'Holiday')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<content tag="breadcrumbs">
          <span class="fa fa-chevron-right"></span><span class="current">Holiday Maintenance</span>
		</content>

            <content tag="main-content">   
		<div id="list-holiday" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
				<!-- <div class="message" role="status">${flash.message}</div> -->
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
					
						<g:sortableColumn property="code" title="${message(code: 'holiday.code.label', default: 'Code')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'holiday.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="date" title="${message(code: 'holiday.date.label', default: 'Date')}" />
					
						<g:sortableColumn property="type" title="${message(code: 'holiday.type.label', default: 'Type')}" />
                                                
                                                <g:sortableColumn property="status" title="${message(code: 'holiday.configItemStatus.label', default: 'Status')}" />
                                                
                                                <g:sortableColumn property="status" title="${message(code: 'holiday.institutionWideHoliday.label', default: 'Bank Wide')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${holidayInstanceList}" status="i" var="holidayInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${holidayInstance.id}">${fieldValue(bean: holidayInstance, field: "code")}</g:link></td>
					
						<td>${fieldValue(bean: holidayInstance, field: "description")}</td>
					
						<td><g:formatDate  format="MM/dd/yyyy" date="${holidayInstance?.holidayDate}" /></td>
					
						<td>${fieldValue(bean: holidayInstance, field: "type")}</td>
                                                
                                                <td>${fieldValue(bean: holidayInstance, field: "configItemStatus")}</td>
                                                
                                                <td>${fieldValue(bean: holidayInstance, field: "institutionWideHoliday")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${HolidayInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				</ul>
            </content>
	</body>
</html>
