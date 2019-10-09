
<%@ page import="icbs.loans.InterestIncomeScheme" %>
<%@ page import="icbs.lov.LoanInstallmentType" %>
<%@ page import="icbs.lov.ConfigItemStatus" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'interestIncomeScheme.label', default: 'InterestIncomeScheme')}" />
		<title>Interest Income Scheme</title>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><span class="current">Interest Income Scheme</span>
            </content>
		<content tag="main-content">
		<div class="content scaffold-show" role="main">
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
				            <g:textField  type="text" name="query" class="form-control" placeholder="Enter Code or Name"/>
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
						<g:sortableColumn property="code" title="${message(code: 'interestIncomeScheme.code.label', default: 'Code')}" />
					
						<g:sortableColumn property="name" title="${message(code: 'interestIncomeScheme.name.label', default: 'Name')}" />

						<g:sortableColumn property="installmentType" title="${message(code: 'interestIncomeScheme.installmentType.label', default: 'Installment Type')}" />

						<g:sortableColumn property="status" title="${message(code: 'interestIncomeScheme.status.label', default: 'Status')}" />

						<td><label>Action</label></td>				
					</tr>
				</tbody>
				<tbody>
				<g:each in="${interestIncomeSchemeInstanceList}" status="i" var="interestIncomeSchemeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">					
						<td>${interestIncomeSchemeInstance?.code}</td>
					
						<td>${interestIncomeSchemeInstance?.name}</td>
					
						<td>${interestIncomeSchemeInstance?.installmentType?.description}</td>
					
						<td>${interestIncomeSchemeInstance?.status?.description}</td>	

						<td><g:link class="btn btn-secondary" action="show" id="${interestIncomeSchemeInstance.id}">View</g:link></td>				
					</tr>
				</g:each>
				</tbody>
				</table>
			</div>
			<div class="pagination">
				<g:paginate total="${interestIncomeSchemeInstanceCount ?: 0}" />
			</div>
		</div>
		</content>
		<content tag="main-actions">
      		<ul>
      			<%--<li><g:link class="list" action="index">Index</g:link></li>--%>
				<li><g:link class="create" action="create">New Interest Income Scheme</g:link></li>
	       	</ul>
	    </content>
	</body>
</html>
