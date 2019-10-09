
<%@ page import="icbs.deposit.FixedDepositTermScheme" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'fixedDepositTermScheme.label', default: 'FixedDepositTermScheme')}" />
		<title>Fixed Deposit Term Scheme List</title>
	</head>
	<body>
             <content tag="breadcrumbs">
               <span class="fa fa-chevron-right"></span><span class="current">Fixed Deposit Term Scheme List</span>
            </content>
            <content tag="main-content">   
		<div id="list-fixedDepositTermScheme" class="content scaffold-list" role="main">
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
			<div class="table-responsive">
                            <table class="table table-hover table-condensed table-bordered table-striped">
                                <thead>
					<tr>
					
						<g:sortableColumn property="code" title="${message(code: 'fixedDepositTermScheme.code.label', default: 'Code')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'fixedDepositTermScheme.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="value" title="${message(code: 'fixedDepositTermScheme.value.label', default: 'Value')}" />
					
						<g:sortableColumn property="termMin" title="${message(code: 'fixedDepositTermScheme.termMin.label', default: 'Term Min')}" />
					
						<g:sortableColumn property="termMax" title="${message(code: 'fixedDepositTermScheme.termMax.label', default: 'Term Max')}" />
					
						<th><g:message code="fixedDepositTermScheme.status.label" default="Status" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${fixedDepositTermSchemeInstanceList}" status="i" var="fixedDepositTermSchemeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${fixedDepositTermSchemeInstance.id}">${fieldValue(bean: fixedDepositTermSchemeInstance, field: "code")}</g:link></td>
					
						<td>${fieldValue(bean: fixedDepositTermSchemeInstance, field: "description")}</td>
					
						<td>${fieldValue(bean: fixedDepositTermSchemeInstance, field: "value")}</td>
					
						<td>${fieldValue(bean: fixedDepositTermSchemeInstance, field: "termMin")}</td>
					
						<td>${fieldValue(bean: fixedDepositTermSchemeInstance, field: "termMax")}</td>
					
						<td>${fieldValue(bean: fixedDepositTermSchemeInstance, field: "status")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${FixedDepositTermSchemeInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><g:link class="create" action="create">Create Fixed Deposit Term Scheme</g:link></li>
		</ul>
            </content>
	</body>
</html>
