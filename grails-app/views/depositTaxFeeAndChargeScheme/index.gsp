
<%@ page import="icbs.deposit.DepositTaxFeeAndChargeScheme" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'depositTaxFeeAndChargeScheme.label', default: 'DepositTaxFeeAndChargeScheme')}" />
		<title>Deposit Taxes/Fees and Charges Scheme</title>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><span class="current">Deposit Taxes/Fees and Charges Scheme</span>
            </content>
            <content tag="main-content">   
		<div id="list-depositTaxFeeAndChargeScheme" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
                        <g:form>          	
                            <div class="row">
				    <div class="col-md-12">
				        <div class="col-md-2">
				            <g:select name="max" value="${params.max}" from="[5, 10, 15, 20]" class="form-control input-sm pull-left"onchange="this.form.submit()" />
				        </div>
				        <div class="input-group col-md-10">
				            <input type="text" name="query" class="form-control" placeholder="Enter Code or Name" value="" id="query" />
		                	<div class="input-group-btn">
		                    	<input type="submit" name="Search" class="btn btn-primary" value="Search" id="Search" />
		                	</div>
				        </div>
				    </div>
                            </div>				
                        </g:form>
			<div class="table-responsive">
                            <table class="table table-hover table-condensed table-bordered table-striped">
                                <thead>
					<tr>
					
						<g:sortableColumn property="code" title="${message(code: 'depositTaxFeeAndChargeScheme.code.label', default: 'Code')}" />
					
						<th><g:message code="depositTaxFeeAndChargeScheme.type.label" default="Type" /></th>
					
						<g:sortableColumn property="taxRate" title="${message(code: 'depositTaxFeeAndChargeScheme.taxRate.label', default: 'Tax Rate')}" />
					
						<g:sortableColumn property="feeRate" title="${message(code: 'depositTaxFeeAndChargeScheme.feeRate.label', default: 'Fee Rate')}" />
					
						<g:sortableColumn property="feeAmt" title="${message(code: 'depositTaxFeeAndChargeScheme.feeAmt.label', default: 'Fee Amt')}" />
					
						<g:sortableColumn property="chargeRate" title="${message(code: 'depositTaxFeeAndChargeScheme.chargeRate.label', default: 'Charge Rate')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${depositTaxFeeAndChargeSchemeInstanceList}" status="i" var="depositTaxFeeAndChargeSchemeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${depositTaxFeeAndChargeSchemeInstance.id}">${fieldValue(bean: depositTaxFeeAndChargeSchemeInstance, field: "code")}</g:link></td>
					
						<td>${fieldValue(bean: depositTaxFeeAndChargeSchemeInstance, field: "type")}</td>
					
						<td><g:formatNumber format="#,##0.00" number="${depositTaxFeeAndChargeSchemeInstance?.taxRate}"/>%</td>
					
						<td><g:formatNumber format="#,##0.00" number="${depositTaxFeeAndChargeSchemeInstance?.feeRate}"/>%</td>
					
						<td><g:formatNumber format="###,###,##0.00" number="${depositTaxFeeAndChargeSchemeInstance?.feeAmt}"/></td>
					
						<td><g:formatNumber format="#,##0.00" number="${depositTaxFeeAndChargeSchemeInstance?.chargeRate}"/>%</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${DepositTaxFeeAndChargeSchemeInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>
            <content tag="main-actions">
                 <ul>
                     <li><g:link class="create" action="create">Create Deposit Taxes/Fees and Charges Scheme</g:link></li>
		</ul>
            </content>
	</body>
</html>
