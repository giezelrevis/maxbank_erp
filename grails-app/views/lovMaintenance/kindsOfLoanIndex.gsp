
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="CustomerKindOfLoan" />
		<title>Kind of Loan</title>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/lovMaintenance')}">List of Values Maintenance</a>
                <span class="fa fa-chevron-right"></span><span class="current">Kind of Loan</span>
            </content>
            <content tag="main-content">
		<g:if test="${flash.success}">
                    <div style="margin:auto" class="box-bodylogin">
                        <div class="alert alert-info alert-dismissable">
                            <i class="fa fa-info"></i>
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                <b>Message</b> <div class="message" role="status">${flash.success}</div>
                        </div>
                    </div>
                </g:if>
		<table class="table table-bordered table-rounded table-striped table-hover">
                    <thead>
			<tr>
                            <th>Code</th>
                            <th>Description</th>
                            <th>Actions</th>
			</tr>
                    </thead>
			<tbody>
                            <g:each in="${loanKindOfLoanInstanceList}" status="i" var="loanKindOfLoanInstance">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                    <td>${loanKindOfLoanInstance.code}</td>
                                    <td>${loanKindOfLoanInstance.description}</td>
                                    <td>
                                        <g:link class="btn btn-secondary" action="kindsOfLoanInstanceEdit" id="${loanKindOfLoanInstance.id}">Edit</g:link>
                                        <g:link class="btn btn-secondary" action="kindsOfLoanInstanceDelete" id="${loanKindOfLoanInstance.id}" value="${message(code: 'default.button.delete.label', default: 'Delete')}" formnovalidate="" onclick="return confirm('${message(code: 'default.button.update.confirm.message', default: 'Are you sure you want to delete this kind of loan?')}');" >Delete</g:link>
                                    </td>
				</tr>
                            </g:each>                            
			</tbody>
		</table>                        
            </content>	
            <content tag="main-actions">
		<ul>
                    <li><g:link action="kindsOfLoanInstanceCreate">Create New Kind of Loan</g:link></li>
                    <li><g:link action="index">List of Values Index</g:link></li>
		</ul>
            </content>
	</body>
</html>
