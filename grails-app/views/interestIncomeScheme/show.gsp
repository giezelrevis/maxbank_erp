
<%@ page import="icbs.loans.InterestIncomeScheme" %>
<%@ page import="icbs.lov.LoanInstallmentType" %>
<%@ page import="icbs.lov.LoanCalculation" %>
<%@ page import="icbs.lov.LoanAdvancedInterestType" %>
<%@ page import="icbs.lov.ConfigItemStatus" %>
<%@ page import="icbs.admin.Product" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'interestIncomeScheme.label', default: 'InterestIncomeScheme')}" />
		<title>View Interest Income Scheme</title>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/interestIncomeScheme')}">Interest Income Scheme</a>
                <span class="fa fa-chevron-right"></span><span class="current">View Interest Income Scheme</span>
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
                                        <td style="width:30%"><label><g:message code="interestIncomeScheme.code.label" default="Code" /></label></td>
                                        <td style="width:70%"><span><g:fieldValue bean="${interestIncomeSchemeInstance}" field="code"/></span></td>
                                    </tr>
                                    <tr>
                                        <td style="width:30%"><label><g:message code="interestIncomeScheme.name.label" default="Name" /></label></td>					
					<td style="width:70%"><span><g:fieldValue bean="${interestIncomeSchemeInstance}" field="name"/></span></td>
                                    </tr>
                                    <tr>
                                        <td style="width:30%"><label><g:message code="interestIncomeScheme.installmentType.label" default="Installment Type" /></label></td>					
					<td style="width:70%"><span>${interestIncomeSchemeInstance.installmentType.description}</span></td>
                                    </tr>
                                    <tr>
                                        <td style="width:30%"><label><g:message code="interestIncomeScheme.installmentCalcType.label" default="Installment Calculation Type" /></label></td>
					<td style="width:70%"><span>${interestIncomeSchemeInstance.installmentCalcType.description}</span></td>
                                    </tr>
                                    <tr>
                                        <td style="width:30%"><label><g:message code="interestIncomeScheme.advInterestType.label" default="Advanced Interest Type" /></label></td>					
                                        <td style="width:70%"><span>${interestIncomeSchemeInstance.advInterestType.description}</span></td>
                                    </tr>
                                    <tr>
                                        <td style="width:30%"><label><g:message code="interestIncomeScheme.defaultInterestRate.label" default="Default Interest Rate" /></label></td>					
					<td style="width:70%"><span><g:formatNumber format="#,##0.00" number="${interestIncomeSchemeInstance?.defaultInterestRate}"/>%</span></td>
                                    </tr>
                                    <tr>
                                        <td style="width:30%"><label><g:message code="interestIncomeScheme.pastDueInterestRate.label" default="Past Due Interest Rate" /></label></td>
					<td style="width:70%"><span><g:formatNumber format="#,##0.00" number="${interestIncomeSchemeInstance?.pastDueInterestRate}"/>%</span></td>
                                    </tr>
                                    <tr>
                                        <td style="width:30%"><label><g:message code="interestIncomeScheme.minInterestRate.label" default="Min Interest Rate" /></label></td>					
					<td style="width:70%"><span><g:formatNumber format="#,##0.00" number="${interestIncomeSchemeInstance?.minInterestRate}"/>%</span></td>
                                    </tr>
                                    <tr>
                                        <td style="width:30%"><label><g:message code="interestIncomeScheme.maxInterestRate.label" default="Max Interest Rate" /></label></td>
					<td style="width:70%"><span><g:formatNumber format="#,##0.00" number="${interestIncomeSchemeInstance?.maxInterestRate}"/>%</span></td>
                                    </tr>
                                    <tr>
                                        <td style="width:30%"><label><g:message code="interestIncomeScheme.divisor.label" default="Divisor" /></label></td>					
					<td style="width:70%"><span><g:fieldValue bean="${interestIncomeSchemeInstance}" field="divisor"/></span></td>
                                    </tr>
                                    <tr>
                                        <td style="width:30%"><label><g:message code="interestIncomeScheme.gracePeriod.label" default="Grace Period" /></label></td>				
					<td style="width:70%"><span><g:fieldValue bean="${interestIncomeSchemeInstance}" field="gracePeriod"/></span></td>
                                    </tr>
                                    <tr>
                                        <td style="width:30%"><label><g:message code="interestIncomeScheme.hasBalloonMode.label" default="Balloon Mode" /></label></td>				
					<td style="width:70%"><span><g:formatBoolean boolean="${interestIncomeSchemeInstance.hasBalloonMode}" /></span></td>
                                    </tr>
                                    <tr>
                                        <td style="width:30%"><label><g:message code="interestIncomeScheme.canChangeInterestRate.label" default="Changeable Interest Rate" /></label></td>					
					<td style="width:70%"><span><g:formatBoolean boolean="${interestIncomeSchemeInstance.canChangeInterestRate}" /></span></td>
                                    </tr>
                                    <tr>
                                        <td style="width:30%"><label><g:message code="interestIncomeScheme.hasInterestAccrual.label" default="Interest Accrual" /></label></td>					
					<td style="width:70%"><span><g:formatBoolean boolean="${interestIncomeSchemeInstance.hasInterestAccrual}" /></span></td>
                                    </tr>
                                    <tr>
                                        <td style="width:30%"><label><g:message code="interestIncomeScheme.status.label" default="Status" /></label></td>					
					<td style="width:70%"><span>${interestIncomeSchemeInstance.status.description}</span></td>
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
                                            <g:each in="${interestIncomeSchemeInstance.products}" status="i" var="product">
                                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                                    <td><g:link controller="Product" action="show" id="${product.id}">${product.code}</g:link></td>
                                                    <td>${product.name}</td>
                                                </tr>
                                            </g:each>
                                        </tbody>    
                                    </table>    				
				</div>
			</div>
			<%--<g:form url="[resource:interestIncomeSchemeInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="btn btn-primary edit" action="edit" resource="${interestIncomeSchemeInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="btn btn-primary delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>--%>
		</div>
		</content>
		<content tag="main-actions">
      		<ul>
      		<li><g:link class="list" action="index">Search Interest Income Scheme</g:link></li>
                <g:if test="${interestIncomeSchemeInstance.status.id.toInteger() in [1, 2]}">
                    <li><g:link action="edit" controller="interestIncomeScheme" id="${interestIncomeSchemeInstance.id}">Update Interest Income Scheme</g:link></li>
                </g:if>
                <g:if test="${interestIncomeSchemeInstance.status.id == 1}">
                <li><g:form id="activate" url="[resource:interestIncomeSchemeInstance, action:'activate']" method="POST">
                    </g:form>
                    <g:actionSubmit id="activateInterestIncomeScheme" action="activate" value="Activate" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </li>
                </g:if>

                <g:if test="${interestIncomeSchemeInstance.status.id.toInteger() in [1, 2]}">
                        <li><g:form id="delete" url="[resource:interestIncomeSchemeInstance, action:'delete']" method="POST">
                        </g:form>
                        <g:actionSubmit id="deleteInterestIncomeScheme" action="delete" value="Delete" onclick="
                            alertify.confirm(AppTitle,'Are you sure you want to delete?',
                                function(){
                                    checkIfAllowed('CFG01004', 'form#delete', 'Override delete Interest Income Scheme.', null);
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
                        //$( "#deleteInterestIncomeScheme" ).click(function() {
                        //         checkIfAllowed('CFG01004', 'form#delete', 'Override Edit Interest Income Scheme.', null); // params: policyTemplate.code, form to be saved
                        //});
                        $( "#activateInterestIncomeScheme" ).click(function() {
                                 checkIfAllowed('CFG01003', 'form#activate', 'Override Edit Interest Income Scheme.', null); // params: policyTemplate.code, form to be saved
                        });
                    });
                    
                </script>
	    </content>
	</body>
</html>
	