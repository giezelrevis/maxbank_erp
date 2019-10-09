
<!DOCTYPE html>

<html>
    <head>
	<meta name="layout" content="main">
	<title>Real and Other Properties Acquired (ROPA) ${ropaInstanceList}</title>
    </head>
    <body>
	<content tag="main-content">
            <div id="list-atm_txn" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
                

			<g:form class="form-inline">
				<div class="form-group">
					<g:select name="max" value="${params.max}" from="[5, 10, 15, 20]" class="form-control input-sm pull-left"onchange="this.form.submit()" />
				</div>
				<div class="right">
					<div class="form-group">
						<g:textField  type="text" name="query" class="form-control input-sm pull-right" style="width: 250px;" placeholder="Search Account No or Borrower Name"/>
					</div>
					<g:submitButton name="Search" class="btn btn-sm btn-default"><i class="fa fa-search"></i></g:submitButton>
				</div>
			</g:form>

			<div class="table-responsive">
                <table class="table table-bordered table-rounded table-striped table-hover">
                    <thead>
					<tr>
					
						<g:sortableColumn property="id" title="${message(code: 'GlContigentAccount.id.label', default: 'ID')}" />
                                                <g:sortableColumn property="loan?.accountNo" title="${message(code: 'GlContigentAccount.id.label', default: 'Loan Account No')}" />
                                                <g:sortableColumn property="loan?.customer?.displayName" title="${message(code: 'GlContigentAccount.id.label', default: 'Borrower Name')}" />
                                                <g:sortableColumn property="ropaDate" title="${message(code: 'ropa.ropaDate.label', default: 'Date of Transfer')}" />
						<g:sortableColumn property="loanBalance" title="${message(code: 'ropa.loanBalance.label', default: 'Loan Balance')}" />
						
                                                <th><label>Action</label></th>
					
					</tr>
				</thead>
				<tbody>
                                
				<g:each in="${RopaInstanceList}" status="i" var="RopaInstance">
                                        
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                                <td>${RopaInstance.id}</td>
						<td>${RopaInstance.loan.accountNo}</td>     
                                                <td>${RopaInstance.acquiredFrom.displayName}</td>

                                                <td><g:formatDate format="MM/dd/yyyy" date="${RopaInstance.ropaDate}"/></td>
                                                <td align="right"><g:formatNumber format="###,###,##0.00" number="${RopaInstance?.loanBalance}"/></td>
                                                <td><g:link class="btn btn-secondary" action="show" id="${RopaInstance?.id}">View</g:link></td>
  
					</tr>
 
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${BranchInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
        </content>	
		
        <content tag="main-actions">
            <ul>
                <li><g:link controller="home" action="landing">Home</g:link></li>
                <li><g:link action="create">New ROPA</g:link></li>
                <li><g:link action="printRopaSchedule">Print Schedule of ROPA</g:link></li>
            </ul>
        </content>
    </body>
</html>
