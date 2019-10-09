
<%@ page import="icbs.loans.LoanApplication" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loanApplication.label', default: 'LoanApplication')}" />
		<title>Loan Proposal</title>
	</head>
	<body>
        <content tag="main-content">   
		<div id="list-loanApplication" class="content scaffold-list" role="main">
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
				            <g:textField  type="text" name="query" class="form-control" placeholder="Loan Application ID"/>
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
                                <thead>
					<tr>
						<g:sortableColumn property="id" title="${message(code: 'loanApplication.id', default: 'ID')}" />
						
						<g:sortableColumn property="customer.displayName" title="${message(code: 'loanApplication.customer.label', default: 'Customer')}" />
					
						<g:sortableColumn property="product.name" title="${message(code: 'loanApplication.product.label', default: 'Product')}" />

						<g:sortableColumn property="branch.name" title="${message(code: 'loanApplication.branch.label', default: 'Branch')}" />													
						<g:sortableColumn property="amount" title="${message(code: 'loanApplication.amount.label', default: 'Amount')}" />
					
						<g:sortableColumn property="term" title="${message(code: 'loanApplication.term.label', default: 'Term')}" />

						<g:sortableColumn property="applicationDate" title="${message(code: 'loanApplication.applicationDate.label', default: 'Application Date')}" />

						<td><label>Action</label></td>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${loanApplicationInstanceList}" status="i" var="loanApplicationInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

						<td>${fieldValue(bean: loanApplicationInstance, field: "id")}</td>

						<td>${loanApplicationInstance.customer.displayName}</td>
					
						<td>${loanApplicationInstance.product.name}</td>
					
						<td>${loanApplicationInstance.branch.name}</td>
					
						<td align="right">${fieldValue(bean: loanApplicationInstance, field: "amount")}</td>
					
						<td align="right">${fieldValue(bean: loanApplicationInstance, field: "term")}</td>

						<td><g:formatDate format="MM/dd/yyyy" date="${loanApplicationInstance.applicationDate}"/></td>
					
						<td><g:link class="btn btn-secondary" action="createTemplate" id="${loanApplicationInstance.id}">Create Template</g:link></td>

					</tr>
				</g:each>
				</tbody>
			</table>
             </div>
			<div class="pagination">
				<g:paginate total="${LoanApplicationInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
        </content>
        <content tag="main-actions">
            <ul>
                <%--<li><g:link class="create" action="create">New Loan Application</g:link></li>--%>
			</ul>
        </content>
	</body>
</html>
