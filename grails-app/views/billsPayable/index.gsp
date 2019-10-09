<!DOCTYPE html>
<html>
    <head>
	<meta name="layout" content="main">
	<title>Bills Payable Subsidiary Ledger</title>
    </head>
    <body>
        <content tag="breadcrumbs">
            <span class="fa fa-chevron-right"></span><span class="current">Bills Payable Subsidiary Ledger</span>
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
				<g:sortableColumn property="accountName" title="${message(code: 'billsPayable.accountName.label', default: 'Account Name')}" />
				<g:sortableColumn property="creditorName" title="${message(code: 'billsPayable.creditorName.label', default: 'Creditor Name')}" />
				<g:sortableColumn property="dateOpened" title="${message(code: 'billsPayable.dateOpened.label', default: 'Date Opened')}" />
                                <g:sortableColumn property="dueDate" title="${message(code: 'billsPayable.dueDate.date', default: 'Due Date')}" />
				<g:sortableColumn property="currency" title="${message(code: 'billsPayable.currency.label', default: 'Currency')}" />
				<td><label>Action</label></td>
                            </tr>
			</thead>
			<tbody>
                            <g:each in="${billsPayableInstanceList}" status="i" var="billsPayableInstance">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                    <td>${billsPayableInstance?.accountName}</td>
                                    <td>${billsPayableInstance?.creditorName}</td>
                                    <td><g:formatDate format="MM/dd/yyyy" date="${billsPayableInstance?.dateOpened}"/></td>
                                    <td><g:formatDate format="MM/dd/yyyy" date="${billsPayableInstance?.dueDate}"/></td>
                                    <td>${billsPayableInstance?.currency?.code}</td>
                                    <td><g:link class="btn btn-secondary" action="show" id="${billsPayableInstance.id}">View</g:link></td>
				</tr>
                            </g:each>
			</tbody>
                    </table>
                </div>
		<div class="pagination">
                    <g:paginate total="${billsPayableInstanceCount ?: 0}" params="${params}" />
		</div>
            </div>
        </content>
		
        <content tag="main-actions">
            <ul>
                <li><g:link controller="home" action="landing">Home</g:link></li>
                <li><g:link controller="billsPayable" action="create">New Bills Payable Subsidiary Ledger</g:link></li>
                <li><g:link controller="home" action="landing">Print Schedule of Cash in Bank</g:link></li>
            </ul>
        </content>
    </body>
</html>
