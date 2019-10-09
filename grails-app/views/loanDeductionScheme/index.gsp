
<%@ page import="icbs.loans.LoanDeductionScheme" %>
<%@ page import="icbs.lov.ConfigItemStatus" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loanDeductionScheme.label', default: 'LoanDeductionScheme')}" />
		<title>Loan Deduction Scheme</title>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><span class="current">Loan Deduction Scheme</span>
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
						<g:sortableColumn property="code" title="${message(code: 'loanDeductionScheme.code.label', default: 'Code')}" />
					
						<g:sortableColumn property="name" title="${message(code: 'loanDeductionScheme.name.label', default: 'Name')}" />

						<g:sortableColumn property="type" title="${message(code: 'loanDeductionScheme.name.label', default: 'Type')}" />
					
						<g:sortableColumn property="status" title="${message(code: 'loanDeductionScheme.status.label', default: 'Status')}" />

						<td><label>Action</label></td>	
					</tr>
				</tbody>
				<tbody>
				<g:each in="${loanDeductionSchemeInstanceList}" status="i" var="loanDeductionSchemeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						<td>${loanDeductionSchemeInstance?.code}</td>
					
						<td>${loanDeductionSchemeInstance?.name}</td>

						<td>${loanDeductionSchemeInstance?.type?.description}</td>
					
						<td>${loanDeductionSchemeInstance?.status?.description}</td>

						<td><g:link class="btn btn-secondary" action="show" id="${loanDeductionSchemeInstance.id}">View</g:link></td>	
					</tr>
				</g:each>
				</tbody>
				</table>
			</div>
			<div class="pagination">
				<g:paginate total="${loanDeductionSchemeInstanceCount ?: 0}" />
			</div>
		</div>
		</content>
		<content tag="main-actions">
      		<ul>
      			<%--<li><g:link class="list" action="index">Index</g:link></li>--%>
				<li><g:link class="create" action="create">New Loan Deduction Scheme</g:link></li>
	       	</ul>
	    </content>
	</body>
</html>
