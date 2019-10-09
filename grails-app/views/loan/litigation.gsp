
<%@ page import="icbs.loans.Loan" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loan.label', default: 'Loan')}" />
		<title>Litigation</title>
		<g:javascript>			
			function showAddLitigationExpense() {
				$('#add-litigation-expense-modal').modal({show:true});
            }            
            
            function showAddLitigationDeficiency() {
				$('#add-litigation-deficiency-modal').modal({show:true});
            }    
		</g:javascript>
	</head>
	<body>
        <content tag="main-content">   
		<div id="show-loan" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
                <div class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div>
            </g:if>
            
			<div class="nav-tab-container">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#tab_1" data-toggle="tab">Expenses</a></li>
                    <li><a href="#tab_2" data-toggle="tab">Deficiencies</a></li>
                </ul>
            </div>
            <div class="tab-content">
				<div class="tab-pane active fade in" id="tab_1">
					<g:render template="litigationExpenses"/>
				</div>
				<div class="tab-pane" id="tab_2">
					<g:render template="litigationDeficiencies"/>
				</div>
			</div>			
        </div>
        </content>
        <content tag="main-actions">
            <ul>
                <%--<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--%>
                <li><g:link controller="loan" action="show" id="${loanInstance.id}">View Loan Account</g:link></li>
			</ul>			
        </content>
	</body>
</html>
