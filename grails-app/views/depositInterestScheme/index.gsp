
<%@ page import="icbs.deposit.DepositInterestScheme" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'depositInterestScheme.label', default: 'DepositInterestScheme')}" />
		<title>Deposit Interest Scheme</title>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><span class="current">Deposit Interest Scheme</span>
            </content>
            <content tag="main-content">   
		<div id="list-depositInterestScheme" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
                        <g:form>          	
                            <div class="row">
				    <div class="col-md-12">
				        <div class="col-md-2">
				            <g:select name="max" value="${params.max}" from="[5, 10, 15, 20]" class="form-control input-sm pull-left"onchange="this.form.submit()" />
				        </div>
				        <div class="input-group col-md-10">
				            <input type="text" name="query" class="form-control" placeholder="Enter Code or Name" value="" id="query" />
		                	<div class="input-group-btn">
		                    	<input type="submit" name="Search" class="btn btn-primary" value="Search" id="Search" />
		                	</div>
				        </div>
				    </div>
                            </div>				
                        </g:form>
                        </br>
			<div class="table-responsive">
                            <table class="table table-hover table-condensed table-bordered table-striped">
                                <thead>
					<tr>
					
						<g:sortableColumn property="code" title="${message(code: 'depositInterestScheme.code.label', default: 'Code')}" />
					
						<g:sortableColumn property="name" title="${message(code: 'depositInterestScheme.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="interestRate" title="${message(code: 'depositInterestScheme.interestRate.label', default: 'Interest Rate')}" />
					
						<g:sortableColumn property="divisor" title="${message(code: 'depositInterestScheme.divisor.label', default: 'Divisor')}" />
					
						<g:sortableColumn property="minInterestRate" title="${message(code: 'depositInterestScheme.minInterestRate.label', default: 'Min Interest Rate')}" />
					
						<g:sortableColumn property="maxInterestRate" title="${message(code: 'depositInterestScheme.maxInterestRate.label', default: 'Max Interest Rate')}" />
                                                <th>Status</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${depositInterestSchemeInstanceList}" status="i" var="depositInterestSchemeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${depositInterestSchemeInstance.id}">${fieldValue(bean: depositInterestSchemeInstance, field: "code")}</g:link></td>
					
						<td>${fieldValue(bean: depositInterestSchemeInstance, field: "name")}</td>
					
						<td><g:formatNumber format="#,##0.00" number="${depositInterestSchemeInstance?.interestRate}"/>%</td>
					
						<td>${fieldValue(bean: depositInterestSchemeInstance, field: "divisor")}</td>
					
						<td><g:formatNumber format="#,##0.00" number="${depositInterestSchemeInstance?.minInterestRate}"/>%</td>
					
						<td><g:formatNumber format="#,##0.00" number="${depositInterestSchemeInstance?.maxInterestRate}"/>%</td>
                                                
                                                <td>${depositInterestSchemeInstance?.status?.description}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${DepositInterestSchemeInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                     <li><g:link class="create" action="create">Create Deposit Interest Scheme</g:link></li>
		</ul>
            </content>
	</body>
</html>
