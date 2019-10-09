
<%@ page import="icbs.loans.LoanLedger" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loanLedger.label', default: 'LoanLedger')}" />
		<title>Loan Non-Cash Transaction</title>
	</head>
	<body>
        <content tag="main-content">   
		<div id="list-loanLedger" class="content scaffold-list" role="main">
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
				            <g:textField  type="text" name="query" class="form-control" placeholder="Enter Loan Application ID"/>
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
						<g:sortableColumn property="id" title="ID" />

						<g:sortableColumn property="loan.accountNo" title="Loan Account" />
                                                
                                                <g:sortableColumn property="loan.customer.displayName" title="Borrower's Name" />

						<g:sortableColumn property="txnType.description" title="Transaction Type" />

						<g:sortableColumn property="txnTemplate.description" title="Transaction Code" />

						<g:sortableColumn property="txnRef" title="Transaction Reference" />

						<td><label>Action</label></td>					
					</tr>
				</tbody>
				<tbody>
				<g:each in="${loanLedgerInstanceList}" status="i" var="loanLedgerInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						<td>${loanLedgerInstance?.id}</td>

						<td>${loanLedgerInstance?.loan?.accountNo}</td>	

                                                <td>${loanLedgerInstance?.loan?.customer?.displayName}</td>	

						<td>${loanLedgerInstance?.txnType?.description}</td>

						<td>${loanLedgerInstance?.txnTemplate?.description}</td>

						<td>${loanLedgerInstance?.txnRef}</td>

						<td><g:link class="btn btn-secondary" action="show" id="${loanLedgerInstance.id}">View</g:link></td>
					</tr>
				</g:each>
				</tbody>
				</table>
         	</div>
			<div class="pagination">
				<g:paginate total="${LoanLedgerInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
	    </content>
	    <content tag="main-actions">
	        <ul>
	            <%--<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--%>
	            <li><g:link action="create">New Loan Non-Cash Transaction</g:link></li>
		</ul>
        </content>
	</body>
</html>
