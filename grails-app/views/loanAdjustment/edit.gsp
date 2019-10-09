<%@ page import="icbs.loans.LoanLedger" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loanLedger.label', default: 'LoanLedger')}" />
		<title>Edit Loan Adjustment</title>
	</head>
	<body>
        <content tag="main-content">
		<div id="edit-loanLedger" class="content scaffold-edit" role="main">
			<g:if test="${flash.message}">
                <div class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div>
            </g:if>
			<g:hasErrors bean="${loanLedgerInstance}">
	            <div class="box-body">
	                <div class="alert alert-danger alert-dismissable">
	                    <i class="fa fa-ban"></i>
	                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	                    <b>Alert!</b> 
	                    <ul class="errors" role="alert">
	                        There are errors
	                    </ul>            
	                </div>
	            </div>
            </g:hasErrors>
			<g:form url="[controller:loanAdjustment, id:"${loanLedgerInstance?.id}", action:'update']"  method="PUT" >
				<g:hiddenField name="version" value="${loanLedgerInstance?.version}" />
				<div>
					<g:render template="form"/>
				</div>
				<div class="form-group form-buttons">
					<g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</div>
			</g:form>
		</div>
        </content>
        <content tag="main-actions">
            <ul>
                <%--<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--%>
                <li><g:link action="index">Loan Adjustment List</g:link></li>
                <li><g:link action="show" id="${loanLedgerInstance.id}">View Loan Adustment</g:link></li>
                <li><button disabled="disabled">Update Loan Adjustment</button></li>
                <li><g:form url="[controller:loanAdjustment, id:"${loanLedgerInstance?.id}", action:'delete']" method="DELETE">
					<g:actionSubmit action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</g:form></li>
            </ul>
        </content>
	</body>
</html>
