
<!DOCTYPE html>
<html>
    <head>
	<meta name="layout" content="main">
	<title>Cash in Bank/Due From Bank Subsidiary Ledger</title>
    </head>
    <body>
        <content tag="breadcrumbs">
            <span class="fa fa-chevron-right"></span><span class="current">Cash in Bank/Due From Bank Subsidiary Ledger</span>
        </content>
        <content tag="main-content">   
            <div id="list-branch" class="content scaffold-list" role="main">
		<g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
		</g:if>
                <g:form class="form-inline">
                    <div class="form-group">
			<g:select name="max" value="${params.max}" from="[5, 10, 15, 20]" class="form-control input-sm pull-left"onchange="this.form.submit()" />
                    </div>
                    <div class="right">
			<div class="form-group">
                            <g:textField  type="text" name="query" class="form-control input-sm pull-right" style="width:500px;" placeholder="Search"/>
			</div>
			<g:submitButton name="Search" class="btn btn-sm btn-default"><i class="fa fa-search"></i></g:submitButton>
                    </div>
                </g:form>

		<div class="table-responsive">
                    <table class="table table-bordered table-rounded table-striped table-hover">
                        <thead>
                            <tr>
				<g:sortableColumn property="bankName" title="${message(code: 'cashInBank.bankName.label', default: 'Bank Name')}" />
				<g:sortableColumn property="branch" title="${message(code: 'cashInBank.branch.label', default: 'Branch')}" />
				<g:sortableColumn property="acctNo" title="${message(code: 'cashInBank.acctNo.label', default: 'Account Number')}" />
                                <g:sortableColumn property="openDate" title="${message(code: 'cashInBank.openDate.date', default: 'Opening Date')}" />
				<g:sortableColumn property="currency" title="${message(code: 'cashInBank.currency.label', default: 'Currency')}" />
				<td><label>Action</label></td>
                            </tr>
			</thead>
			<tbody>
                            <g:each in="${cashInBankInstanceList}" status="i" var="cashInBankInstance">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                    <td>${cashInBankInstance?.bankName}</td>
                                    <td>${cashInBankInstance?.bankBranch}</td>
                                    <td>${cashInBankInstance?.acctNo}</td>
                                    <td><g:formatDate format="MM/dd/yyyy" date="${cashInBankInstance?.openDate}"/></td>
                                    <td>${cashInBankInstance?.currency?.code}</td>
                                    <td><g:link class="btn btn-secondary" action="show" id="${cashInBankInstance.id}">View</g:link></td>
				</tr>
                            </g:each>
			</tbody>
                    </table>
                </div>
		<div class="pagination">
                    <g:paginate total="${CashInBankInstanceCount ?: 0}" params="${params}" />
		</div>
            </div>
        </content>
		
        <content tag="main-actions">
            <ul>
                <li><g:link controller="home" action="landing">Home</g:link></li>
                <li><g:link controller="cashInBank" action="create">New Cash in Bank Subsidiary Ledger</g:link></li>
                <li><g:link controller="home" action="landing">Print Schedule of Cash in Bank</g:link></li>
            </ul>
        </content>
    </body>
</html>
