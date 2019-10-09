
<%@ page import="icbs.loans.LoanDeductionScheme" %>
<%@ page import="icbs.lov.LoanDeductionCalculationType" %>
<%@ page import="icbs.lov.LoanDeductionSpecialCalculation" %>
<%@ page import="icbs.lov.ConfigItemStatus" %>
<%@ page import="icbs.admin.Product" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loanDeductionScheme.label', default: 'LoanDeductionScheme')}" />
		<title>View Loan Deduction Scheme</title>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/loanDeductionScheme')}">Loan Deduction Scheme</a>
                <span class="fa fa-chevron-right"></span><span class="current">Show Loan Deduction Scheme</span>
            </content>
		<content tag="main-content">
		<div class="content scaffold-show" role="main">
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
            		<li class="active"><a href="#tab_1" data-toggle="tab">Details</a></li>
            		<li><a href="#tab_2" data-toggle="tab">Products</a></li>
          		</ul>
          	</div>
			<div class="tab-content">
    			<div class="tab-pane active fade in" id="tab_1">
                            <table class="table table-bordered table-rounded table-striped table-hover">
                                <tbody>
                                    <tr>
                                        <td style="width:30%"><label><g:message code="loanDeductionScheme.code.label" default="Code" /></label></td>				
					<td style="width:70%"><span><g:fieldValue bean="${loanDeductionSchemeInstance}" field="code"/></span></td>
                                    </tr>
                                    <tr>
					<td style="width:30%"><label><g:message code="loanDeductionScheme.name.label" default="Name" /></label></td>				
					<td style="width:70%"><span><g:fieldValue bean="${loanDeductionSchemeInstance}" field="name"/></span></td>
                                    </tr>
                                    <tr>
					<td style="width:30%"><label><g:message code="loanDeductionScheme.description.label" default="Description" /></label></td>				
					<td style="width:70%"><span><g:fieldValue bean="${loanDeductionSchemeInstance}" field="description"/></span></td>
                                    </tr>
                                    <tr>
                                        <td style="width:30%"><label><g:message code="loanDeductionScheme.specialCalculation.label" default="Special Calculation" /></label></td>
					<td style="width:70%"><span>${loanDeductionSchemeInstance?.specialCalculation?.description}</span></td>
				   </tr>
                                    <tr>
					<td style="width:30%"><label><g:message code="loanDeductionScheme.type.label" default="Type" /></label></td>
					<td style="width:70%"><span>${loanDeductionSchemeInstance?.type?.description}</span></td>
                                    </tr>	
                                    <g:if test="${loanDeductionSchemeInstance.type.id == 1}">
                                    <tr>
					<td style="width:30%"><label><g:message code="loanDeductionScheme.amount.label" default="Amount" /></label></td>
					<td style="width:70%"><span><g:fieldValue bean="${loanDeductionSchemeInstance}" field="amount"/></span></td>
                                    </tr>
                                    </g:if>
                                    <g:elseif test="${loanDeductionSchemeInstance.type.id == 2}">
                                    <tr>
					<td style="width:30%"><label><g:message code="loanDeductionScheme.rate.label" default="Rate" /></label></td>
					<td style="width:70%"><span><g:fieldValue bean="${loanDeductionSchemeInstance}" field="rate"/>%</span></td>
                                    </tr>
                                    <tr>
					<td style="width:30%"><label><g:message code="loanDeductionScheme.divisor.label" default="Divisor" /></label></td>
					<td style="width:70%"><span><g:fieldValue bean="${loanDeductionSchemeInstance}" field="divisor"/></span></td>
                                    </tr>
                                    </g:elseif>
                                    <tr>
					<td style="width:30%"><label><g:message code="loanDeductionScheme.hasEirMode.label" default="EIR Mode" /></label></td>
					<td style="width:70%"><span><g:formatBoolean boolean="${loanDeductionSchemeInstance?.hasEirMode}" /></span></td>
                                    </tr>
                                    <tr>
                                        <td style="width:30%"><label><g:message code="loanDeductionScheme.contraAcct.label" default="GL Contra Account" /></label></td>	
                                        <td style="width:70%"><span>${loanDeductionSchemeInstance?.contraAcct?.name}</span></td>
                                    </tr>	
                                    <tr>
                                        <td style="width:30%"><label><g:message code="loanDeductionScheme.status.label" default="Status" /></label></td>
                                        <td style="width:70%"><span>${loanDeductionSchemeInstance?.status?.description}</span></td>
                                    </tr>
                                </tbody>
                            </table>
			</div>	
				<div class="tab-pane fade in" id="tab_2">	
                                    <table class="table table-bordered table-rounded table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <g:sortableColumn property="code" title="${message(code: 'product.code.label', default: 'Code')}" />
                                                <g:sortableColumn property="name" title="${message(code: 'product.description.label', default: 'Product Name')}" />
                                            </tr>    
                                        </thead>   
                                        <tbody>
                                            <g:each in="${loanDeductionSchemeInstance.products}" status="i" var="product">
                                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                                    <td><g:link controller="Product" action="show" id="${product.id}">${product.code}</g:link></td>
                                                    <td>${product.name}</td>
                                                </tr>
                                            </g:each>
                                        </tbody>    
                                    </table>    				
				</div>	
			</div>
			<%--<g:form url="[resource:loanDeductionSchemeInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="btn btn-primary edit" action="edit" resource="${loanDeductionSchemeInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="btn btn-primary delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>--%>
		</div>
		</content>
		<content tag="main-actions">
      		<ul>
      			<li><g:link class="list" action="index">Search Loan Deduction Scheme</g:link></li>
                <li><g:link action="edit" controller="loanDeductionScheme" id="${loanDeductionSchemeInstance.id}">Update Loan Deduction Scheme</g:link></li>

                <g:if test="${loanDeductionSchemeInstance.status.id == 1}">
                <li><g:form id="activate" url="[resource:loanDeductionSchemeInstance, action:'activate']" method="POST">
                    </g:form>
                    <g:actionSubmit id="activateLoanDeductionScheme" action="activate" value="Activate" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                    </li>
                </g:if>

                <g:if test="${loanDeductionSchemeInstance.status.id.toInteger() in [1, 2]}">
                <li><g:form id="delete" url="[resource:loanDeductionSchemeInstance, action:'delete']" method="POST">       
                    </g:form>
                    <g:actionSubmit id="deleteLoanDeductionScheme" action="delete" value="Delete" onclick="
                            alertify.confirm(AppTitle,'Are you sure you want to delete?',
                                function(){
                                    checkIfAllowed('CFG01303', 'form#delete', 'Override new Check Deposit Clearing Type.', null);
                                },
                                function(){
                                    return;
                                });                           
                        " />
                </li>
                    </g:if>
	       	</ul>
                <script type="text/javascript">
                    $(document).ready(function() {
                        //$( "#deleteLoanDeductionScheme" ).click(function() {
                        //         checkIfAllowed('CFG01303', 'form#delete', 'Override new Check Deposit Clearing Type.', null); // params: policyTemplate.code, form to be saved
                        //});
                        $( "#activateLoanDeductionScheme" ).click(function() {
                                 checkIfAllowed('CFG01303', 'form#activate', 'Override new Check Deposit Clearing Type.', null); // params: policyTemplate.code, form to be saved
                        });
                    }); 
                </script>
	    </content>
	</body>
</html>
