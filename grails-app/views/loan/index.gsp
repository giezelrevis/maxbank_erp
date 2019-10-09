
<%@ page import="icbs.loans.Loan" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loan.label', default: 'Loan')}" />
		<title>${title}</title>
		<g:javascript>
			icbs.Dependencies.Ajax.addLoadEvent(function(){
				var url = window.location.href
				if (url.match(/^.*\/icbs\/loan(\/|\/index)?$/)) {
					url = url.replace("loan", "${module}");
					window.history.pushState("", "", url);
				}        		
            });
		</g:javascript>
	</head>
	<body>				
        <content tag="main-content">   
		<div id="list-loan" class="content scaffold-list" role="main">
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
				            <g:textField  type="text" name="query" class="form-control" placeholder="Enter Loan Account No."/>
		                	<div class="input-group-btn">
		                    	<g:submitButton name="Search" class="btn btn-primary"></g:submitButton>
		                	</div>
				        </div>
				    </div>
				</div>
				<g:hiddenField id="module" name="module" value="${module}" />
            </g:form>
            <br />
			<div class="table-responsive">
                            <table class="table table-hover table-condensed table-bordered table-striped">
                                <thead>
					<tr>
						<!--<g:sortableColumn property="id" title="${message(code: 'loan.id', default: 'ID')}" />-->
					
						<g:sortableColumn property="accountNo" title="${message(code: 'loan.accountNo.label', default: 'Account No.')}" />
					
						<g:sortableColumn property="customer.displayName" title="${message(code: 'loan.customer.label', default: 'Customer')}" />
					
						<g:sortableColumn property="product.name" title="${message(code: 'loan.product.label', default: 'Product')}" />

						<g:sortableColumn property="amount" title="${message(code: 'loan.amount.label', default: 'Amount')}" />

						<g:sortableColumn property="openingDate" title="${message(code: 'loan.openingDate.label', default: 'Opening Date')}" />
                                                <td>Branch</td>
                                                <!--<g:sortableColumn property="glCode" title="${message(code: 'loan.glCode.label', default: 'GL Code')}" />-->
                                                <g:sortableColumn property="status" title="${message(code: 'loan.status.label', default: 'Status')}" />
                                                <g:sortableColumn property="balance" title="${message(code: 'loan.status.label', default: 'Balance')}" />
                                                <g:sortableColumn property="maturityDate" title="${message(code: 'loan.status.label', default: 'Maturity Date')}" />
						<td><label>Action</label></td>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${loanInstanceList}" status="i" var="loanInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
						<!--<td>${fieldValue(bean: loanInstance, field: "id")}</td>-->

						<td>${loanInstance?.accountNo}</td>

						<td>${loanInstance?.customer?.displayName}</td>
					
						<td>${loanInstance?.product?.name}</td>
					
						<td align="right"><g:formatNumber format="###,###,##0.00" number="${loanInstance?.grantedAmount}"/></td>				

						<td><g:formatDate format="MM/dd/yyyy" date="${loanInstance.openingDate}"/></td>
                                                <td>${loanInstance?.branch?.name}</td>
                                                <!--<td>${loanInstance?.glLink?.description}</td>-->
                                                <td>${loanInstance?.status?.description}</td>
                                                <td align="right"><g:formatNumber format="###,###,##0.00" number="${loanInstance?.balanceAmount}"/></td>
                                                <td><g:formatDate format="MM/dd/yyyy" date="${loanInstance.maturityDate}"/></td>
						<td><g:link class="btn btn-secondary" controller="${module}" action="show" id="${loanInstance.id}">View</g:link></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
             </div>
				<div class="pagination">
					<g:paginate total="${LoanInstanceCount ?: 0}" params="${params}" />
				</div>				
			</div>
            </content>
            <content tag="main-actions">
                <ul>          
                	<g:if test="${module == 'loan'}">
                    <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
                    </g:if>
				</ul>
            </content>
	</body>
</html>
