
<%@ page import="icbs.loans.Loan" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loan.label', default: 'Loan')}" />
		<title>Loan Reports</title>
	</head>
	<body>				
        <content tag="main-content">   
		<div id="loan-reports" class="content scaffold-create" role="main">
			<%--<g:if test="${flash.message}">
                <div class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div>
            </g:if>
            <g:hasErrors bean="${loanInstance}">
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
            </g:hasErrors>--%>

            <g:form id="report-form" url="[controller:loan, action:'generateReport']">
            	<div>
            		<legend>Select Report Type</legend>

            		<div class="fieldcontain form-group">
					    <%--<label class="control-label col-sm-4" for="reportType">
					        Type
					    </label>--%>
					    <div class="col-sm-8">
					        <g:select name="type" from="${['Loan Listing', 'Loan Summary', 'Loan Ledger']}" keys="${[1, 2, 3]}" class="many-to-one form-control"/>
					    </div>
					</div>
        		</div>

        		<g:hiddenField name="_format" value="PDF"/>
        		<%--<g:hiddenField name="_name" value="Loan Listing"/>
                <g:hiddenField name="_file" value="loan_listing"/>--%>

        		<%--<g:jasperReport action="createLoanListingReport" controller="loan" format="PDF" jasper="loan_listing" name="Loan Listing"/>--%>
            </g:form>
        </div>
        </content>
        <content tag="main-actions">
            <ul>              
                <li><g:submitButton name="generate" value="Generate Report" onclick="jQuery('#report-form').submit()" /></li>
			</ul>
        </content>
	</body>
</html>
