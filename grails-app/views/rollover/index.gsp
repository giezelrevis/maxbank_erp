
<%@ page import="icbs.deposit.Rollover" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'rollover.label', default: 'Rollover')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
            <content tag="main-content">   
		<div id="list-rollover" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
                        <g:form>
                            <div class="input-group">
                                <g:select name="max" value="${params.max}" from="[5, 10, 15, 20]" class="form-control input-sm pull-left"onchange="this.form.submit()" />
                            </div>
                            <div class="input-group">
                                <g:textField  type="text" name="query" class="form-control input-sm pull-right" style="width: 150px;" placeholder="Search"/>
                                <div class="input-group-btn">
                                    <g:submitButton name="search" class="btn btn-sm btn-default"><i class="fa fa-search"></i></g:submitButton>
                                </div>
                            </div>
                        </g:form>
			<div class="table-responsive">
                            <table class="table table-hover table-condensed table-bordered table-striped">
                                <thead>
					<tr>
					
						<g:sortableColumn property="rolloverSequence" title="${message(code: 'rollover.rolloverSequence.label', default: 'Rollover Sequence')}" />
					
						<g:sortableColumn property="startDate" title="${message(code: 'rollover.startDate.label', default: 'Start Date')}" />
					
						<g:sortableColumn property="endDate" title="${message(code: 'rollover.endDate.label', default: 'End Date')}" />
					
						<th><g:message code="rollover.rolloverType.label" default="Rollover Type" /></th>
					
						<g:sortableColumn property="principalAmt" title="${message(code: 'rollover.principalAmt.label', default: 'Principal Amt')}" />
					
						<g:sortableColumn property="preTermInterestAmt" title="${message(code: 'rollover.preTermInterestAmt.label', default: 'Pre Term Interest Amt')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${rolloverInstanceList}" status="i" var="rolloverInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${rolloverInstance.id}">${fieldValue(bean: rolloverInstance, field: "rolloverSequence")}</g:link></td>
					
						<td><g:formatDate date="${rolloverInstance.startDate}" /></td>
					
						<td><g:formatDate date="${rolloverInstance.endDate}" /></td>
					
						<td>${fieldValue(bean: rolloverInstance, field: "rolloverType")}</td>
					
						<td>${fieldValue(bean: rolloverInstance, field: "principalAmt")}</td>
					
						<td>${fieldValue(bean: rolloverInstance, field: "preTermInterestAmt")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${RolloverInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                    <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
		</ul>
            </content>
	</body>
</html>
