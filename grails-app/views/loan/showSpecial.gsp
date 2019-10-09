
<%@ page import="icbs.loans.Loan" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loan.label', default: 'Loan')}" />
		<title>Loan Special</title>
	</head>
	<body>
        <content tag="main-content">   
		<div id="show-special" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
                <div class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div>
            </g:if>

			<div>
				<div class="fieldcontain form-group">
					<label class="control-label col-sm-4">Type</label>
					<span>${loanInstance?.special?.type?.description}</span>
				</div>
				<div class="fieldcontain form-group">
					<label class="control-label col-sm-4">Action</label>
					<span>${loanInstance?.special?.action}</span>
				</div>
				<div class="fieldcontain form-group">
					<label class="control-label col-sm-4">Transfer Date</label>
					<span>${loanInstance?.special?.transferDate}</span>
				</div>
			</div>	
			<div class="form-group form-buttons">
				<g:link class="btn btn-primary" action="editSpecial"  id="${loanInstance.id}">Update</g:link>
			</div>		
		</div>
        </content>
        <content tag="main-actions">
            <ul>            	
                <li><g:link action="show" id="${loanInstance.id}">View Loan Account</g:link></li>                
			</ul>			
        </content>
	</body>
</html>
