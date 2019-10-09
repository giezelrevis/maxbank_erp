
<%@ page import="icbs.deposit.FixedDepositPreTermScheme" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'fixedDepositPreTermScheme.label', default: 'FixedDepositPreTermScheme')}" />
		<title>Fixed Deposit Pre-Term Scheme List</title>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><span class="current">Fixed Deposit Pre-Term Scheme List</span>
            </content>
            <content tag="main-content">   
		<div id="list-fixedDepositPreTermScheme" class="content scaffold-list" role="main">
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
					
						<g:sortableColumn property="code" title="${message(code: 'fixedDepositPreTermScheme.code.label', default: 'Code')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'fixedDepositPreTermScheme.description.label', default: 'Description')}" />
					
						<th><g:message code="fixedDepositPreTermScheme.type.label" default="Type" /></th>
					
						<g:sortableColumn property="rate" title="${message(code: 'fixedDepositPreTermScheme.rate.label', default: 'Rate')}" />
					
						<g:sortableColumn property="term1stHalf" title="${message(code: 'fixedDepositPreTermScheme.term1stHalf.label', default: 'Term1st Half')}" />
					
						<g:sortableColumn property="term2ndHalf" title="${message(code: 'fixedDepositPreTermScheme.term2ndHalf.label', default: 'Term2nd Half')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${fixedDepositPreTermSchemeInstanceList}" status="i" var="fixedDepositPreTermSchemeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${fixedDepositPreTermSchemeInstance.id}">${fieldValue(bean: fixedDepositPreTermSchemeInstance, field: "code")}</g:link></td>
					
						<td>${fieldValue(bean: fixedDepositPreTermSchemeInstance, field: "description")}</td>
					
						<td>${fieldValue(bean: fixedDepositPreTermSchemeInstance, field: "type")}</td>
					
						<td>${fieldValue(bean: fixedDepositPreTermSchemeInstance, field: "rate")}</td>
					
						<td>${fieldValue(bean: fixedDepositPreTermSchemeInstance, field: "term1stHalf")}</td>
					
						<td>${fieldValue(bean: fixedDepositPreTermSchemeInstance, field: "term2ndHalf")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${FixedDepositPreTermSchemeInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><g:link class="create" action="create">Create Fixed Deposit Pre-Term Scheme</g:link></li>
		</ul>
            </content>
	</body>
</html>
