
<%@ page import="icbs.admin.Product" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'product.label', default: 'Product')}" />
		<title>Product Information</title>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/product')}">Product List</a>
                <span class="fa fa-chevron-right"></span><span class="current">Product Information</span>
            </content>
            <content tag="main-content">   
		<div id="show-product" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
                            <script>
                                $(function(){
                                    var x = '${flash.message}';
                                    notify.message(x+'|success|alert'); 
                                });
                            </script> 
			</g:if>

			<div class="nav-tab-container">
              <ul class="nav nav-tabs">
                <li class="active"><a href="#tab_1" data-toggle="tab">Product Details</a></li>
                <li><a href="#tab_2" data-toggle="tab">Branches</a></li>
                <li><a href="#tab_3" data-toggle="tab">Customer Groups</a></li>
                <li><a href="#tab_4" data-toggle="tab">Transactions</a></li>
              </ul>
            </div>

            <div class="tab-content">
            	<div class="tab-pane active fade in" id="tab_1">
			<table class="table table-bordered table-rounded table-striped table-hover">
                            <tbody>
                                <g:if test="${productInstance?.code}">
                                <tr>
                                    <td style="width:30%"><label><g:message code="product.code.label" default="Code" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="code-label">${fieldValue(bean: productInstance, field: "code").padLeft(3, '0')}</span></td>
				</tr>			
				</g:if>
				<g:if test="${productInstance?.name}">
                                <tr>
                                    <td style="width:30%"><label><g:message code="product.name.label" default="Name" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${productInstance}" field="name"/></span></td>
				</tr>
				</g:if>
                                <g:if test="${productInstance?.productType}">
				<tr>
                                    <td style="width:30%"><label><g:message code="product.productType.label" default="Product Type" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="productType-label">${productInstance?.productType?.description}</span></td>
				</tr>
                                </g:if>
				<g:if test="${productInstance?.shortName}">
				<tr>
                                    <td style="width:30%"><label><g:message code="product.shortName.label" default="Short Name" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="shortName-label"><g:fieldValue bean="${productInstance}" field="shortName"/></span></td>
				</tr>
                                </g:if>
				<g:if test="${productInstance?.allowFdPartialWithrawal}">
                                <tr>
                                    <td style="width:30%"><label><g:message code="product.allowFdPartialWithrawal.label" default="Allow Fd Partial Withrawal" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="allowFdPartialWithrawal-label"><g:formatBoolean boolean="${productInstance?.allowFdPartialWithrawal}" /></span></td>
				</tr>
				</g:if>
				<g:if test="${productInstance?.allowFdMultiplePlacement}">
                                <tr>
                                    <td style="width:30%"><label><g:message code="product.allowFdMultiplePlacement.label" default="Allow Fd Multiple Placement" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="allowFdMultiplePlacement-label"><g:formatBoolean boolean="${productInstance?.allowFdMultiplePlacement}" /></span></td>
				</tr>
                                </g:if>
				<g:if test="${productInstance?.depositDormancyMonths}">
                                <tr>	
                                    <td style="width:30%"><label><g:message code="product.depositDormancyMonths.label" default="Deposit Dormancy Months" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="depositDormancyMonths-label"><g:fieldValue bean="${productInstance}" field="depositDormancyMonths"/></span></td>
				</tr>
				</g:if>
				<g:if test="${productInstance?.depositDormancyTransferFreq}">
                                <tr>
                                    <td style="width:30%"><label><g:message code="product.depositDormancyTransferFreq.label" default="Deposit Dormancy Transfer Freq" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="depositDormancyTransferFreq-label"><g:link controller="depositAcctDormancyTransferFreq" action="show" id="${productInstance?.depositDormancyTransferFreq?.id}">${productInstance?.depositDormancyTransferFreq?.description}</g:link></span></td>
				</tr>
				</g:if>
				<g:if test="${productInstance?.hasDepositDormancyInterest}">
                                <tr>
                                    <td style="width:30%"><label><g:message code="product.hasDepositDormancyInterest.label" default="Has Deposit Dormancy Interest" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="hasDepositDormancyInterest-label"><g:formatBoolean boolean="${productInstance?.hasDepositDormancyInterest}" /></span></td>
				</tr>
                                </g:if>
				<g:if test="${productInstance?.depositDormancyAmt}">
                                <tr>
                                    <td style="width:30%"><label><g:message code="product.depositDormancyAmt.label" default="Deposit Dormancy Amt" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="depositDormancyAmt-label"><g:fieldValue bean="${productInstance}" field="depositDormancyAmt"/></span></td>
				</tr>
                                </g:if>
				<g:if test="${productInstance?.depositChargeStart}">
                                <tr>
                                    <td style="width:30%"><label><g:message code="product.depositChargeStart.label" default="Dormancy Charge Start" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="depositChargeStart-label"><g:fieldValue bean="${productInstance}" field="depositChargeStart"/></span></td>
				</tr>
				</g:if>
				<g:if test="${productInstance?.isMicrofinance}">
                                <tr>
                                    <td style="width:30%"><label><g:message code="product.isMicrofinance.label" default="Is Microfinance" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="isMicrofinance-label"><g:formatBoolean boolean="${productInstance?.isMicrofinance}" /></span></td>
				</tr>
				</g:if>
				<g:if test="${productInstance?.documentTemplate}">
                                <tr>
                                  <td style="width:30%"><label><g:message code="product.documentTemplate.label" default="Document Template" /></label></td>
                                  <td style="width:70%"><span class="property-value" aria-labelledby="documentTemplate-label"><g:fieldValue bean="${productInstance}" field="documentTemplate"/></span></td>
				</tr>
				</g:if>
				<g:if test="${productInstance?.amortizedChargeSchemes}">
                                <tr>
                                    <td style="width:30%"><label><g:message code="product.amortizedChargeSchemes.label" default="Amortized Charge Schemes" /></label></td>
                                    <td style="width:70%"><g:each in="${productInstance.amortizedChargeSchemes}" var="a">
					<span class="property-value" aria-labelledby="amortizedChargeSchemes-label"><g:link controller="amortizedChargeSchemeProduct" action="show" id="${a.id}">${a?.name}</g:link></span>
                                        </g:each></td>
				</tr>
				</g:if>
				<g:if test="${productInstance?.currency}">
                                <tr>
                                    <td style="width:30%"><label><g:message code="product.currency.label" default="Currency" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="currency-label"><g:link controller="currency" action="show" id="${productInstance?.currency?.id}">${productInstance?.currency?.name}</g:link></span></td>
				</tr>
				</g:if>
				</tbody>
                        </table>
                                    <g:if test="${productInstance?.interestIncomeSchemes}">
                                        <label><g:message code="product.interestIncomeSchemes.label" default="Interest Income Schemes" /></label>
                                        <table class="table table-bordered table-rounded table-striped table-hover">
                                            <thead>
                                                <tr>
                                                    <g:sortableColumn property="code" title="${message(code: 'interestIncomeSchemes.code.label', default: 'Code')}" />
                                                    <g:sortableColumn property="description" title="${message(code: 'interestIncomeSchemes.description.label', default: 'Description')}" />
                                                </tr>    
                                            </thead>   
                                            <tbody>
                                                <g:each in="${productInstance.interestIncomeSchemes}" status="i" var="intr">
                                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                                        <td style="width:30%"><g:link controller="interestIncomeScheme" action="show" id="${intr.id}">${intr.code}</g:link></td>
                                                        <td style="width:70%">${intr.name}</td>
                                                    </tr>
                                                </g:each>
                                            </tbody>    
                                        </table> 
                                    </g:if>
                                    <g:if test="${productInstance?.loanDeductionSchemes}">
					<label><g:message code="product.loanDeductionSchemes.label" default="Loan Deduction Schemes" /></label>
                                        <table class="table table-bordered table-rounded table-striped table-hover">
                                            <thead>
                                                <tr>
                                                    <g:sortableColumn property="code" title="${message(code: 'loanDeductionSchemes.code.label', default: 'Code')}" />
                                                    <g:sortableColumn property="description" title="${message(code: 'loanDeductionSchemes.description.label', default: 'Description')}" />
                                                </tr>    
                                            </thead>   
                                            <tbody>
                                                <g:each in="${productInstance.loanDeductionSchemes}" status="i" var="l">
                                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                                        <td style="width:30%"><g:link controller="loanDeductionScheme" action="show" id="${l.id}">${l.code}</g:link></td>
                                                        <td style="width:70%">${l.name}</td>
                                                    </tr>
                                                </g:each>
                                            </tbody>    
                                        </table> 							
                                    </g:if>
                                    <g:if test="${productInstance?.loanPerformanceClassificationSchemes}">
                                        <label><g:message code="product.loanPerformanceClassifications.label" default="Loan Performance Classifications" /></label>
						<table class="table table-bordered table-rounded table-striped table-hover">
                                                    <tbody>
                                                        <g:each in="${productInstance.loanPerformanceClassificationSchemes}" var="l">
                                                            <tr><span class="property-value" aria-labelledby="loanPerformanceClassifications-label"><g:link controller="loanPerformanceClassificationProduct" action="show" id="${l.id}">${l?.name}</g:link></span></tr>
                                                        </g:each>
                                                    </tbody>
                                                </table>
                                    </g:if>
				
                                    <table class="table table-bordered table-rounded table-striped table-hover">
                                        <tbody>
                                           <g:if test="${productInstance?.maxBalance}">
                                            <tr>
                                                <td style="width:30%"><label><g:message code="product.maxBalance.label" default="Max Balance" /></label></td>
                                                <td style="width:70%"><span class="property-value" aria-labelledby="maxBalance-label"><g:formatNumber format="###,###,##0.00" number="${productInstance?.maxBalance}"/></span></td>
                                            </tr>
                                            </g:if>
					
                                            <g:if test="${productInstance?.maxOpen}">
                                            <tr>
                                                <td style="width:30%"><label><g:message code="product.maxOpen.label" default="Max Open" /></label></td>
						<td style="width:70%"><span class="property-value" aria-labelledby="maxOpen-label"><g:fieldValue bean="${productInstance}" field="maxOpen"/></span></td>
                                            </tr>
                                            </g:if>
					
                                            <g:if test="${productInstance?.maxTerm}">
                                            <tr>
                                                <td style="width:30%"><label><g:message code="product.maxTerm.label" default="Max Term" /></label></td>
                                                <td style="width:70%"><span class="property-value" aria-labelledby="maxTerm-label"><g:formatNumber format="#####" number="${productInstance?.maxTerm}"/></span></td>
                                            </tr>
                                            </g:if>
					
                                            <g:if test="${productInstance?.minBalance}">
                                            <tr>
                                                <td style="width:30%"><label><g:message code="product.minBalance.label" default="Min Balance" /></label></td>
						<td style="width:70%"><span class="property-value" aria-labelledby="minBalance-label"><g:formatNumber format="###,###,##0.00" number="${productInstance?.minBalance}"/></span></td>
                                            </tr>
                                            </g:if>
					
                                            <g:if test="${productInstance?.minOpen}">
                                            <tr>
                                                <td style="width:30%"><label><g:message code="product.minOpen.label" default="Min Open" /></label></td>
                                                <td style="width:70%"><span class="property-value" aria-labelledby="minOpen-label"><g:formatNumber format="###,###,##0.00" number="${productInstance?.minOpen}"/></span></td>
                                            </tr>
                                            </g:if>
					
                                            <g:if test="${productInstance?.minTerm}">
                                            <tr>
                                                <td style="width:30%"><label><g:message code="product.minTerm.label" default="Min Term" /></label></td>
                                                <td style="width:70%"><span class="property-value" aria-labelledby="minTerm-label"><g:formatNumber format="#####" number="${productInstance?.minTerm}"/></span></td>
                                            </tr>
                                            </g:if>
                                        </tbody>
                                    </table>
					
                                    <g:if test="${productInstance?.penaltyIncomeSchemes}">
					<label><g:message code="product.penaltyIncomeSchemes.label" default="Penalty Income Schemes" /></label>
                                        <table class="table table-bordered table-rounded table-striped table-hover">
                                            <thead>
                                                <tr>
                                                    <g:sortableColumn property="code" title="${message(code: 'penaltyIncomeSchemes.code.label', default: 'Code')}" />
                                                    <g:sortableColumn property="description" title="${message(code: 'penaltyIncomeSchemes.description.label', default: 'Description')}" />
                                                </tr>    
                                            </thead>   
                                            <tbody>
                                                <g:each in="${productInstance.penaltyIncomeSchemes}" status="i" var="p">
                                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                                        <td style="width:30%"><g:link controller="penaltyIncomeScheme" action="show" id="${p.id}">${p.code}</g:link></td>
                                                        <td style="width:70%">${p.name}</td>
                                                    </tr>
                                                </g:each>
                                            </tbody>    
                                        </table> 							
                                    </g:if>
                                    <table class="table table-bordered table-rounded table-striped table-hover">
                                        <tbody>
                                            <g:if test="${productInstance?.loanProvisionFreq}">
                                                <tr>
                                                    <td style="width:30%"><label><g:message code="product.loanProvisionFreq.label" default="Loan Provision Freq" /></label></td>
                                                    <td style="width:70%"><span class="property-value" aria-labelledby="loanProvisionFreq-label">${productInstance?.loanProvisionFreq?.description}</span></td>
						</tr>
                                            </g:if>
					
                                            <g:if test="${productInstance?.loanReclassFreq}">
						<tr>
                                                    <td style="width:30%"><label><g:message code="product.loanReclassFreq.label" default="Loan Reclass Freq" /></label></td>
                                                    <td style="width:70%"><span class="property-value" aria-labelledby="loanReclassFreq-label">${productInstance?.loanReclassFreq?.description}</span></td>
						</tr>
                                            </g:if>
					
                                            <g:if test="${productInstance?.loanUidTransferFreq}">
						<tr>
                                                    <td style="width:30%"><label><g:message code="product.loanUidTransferFreq.label" default="Loan Uid Transfer Freq" /></label></td>
                                                    <td style="width:70%"><span class="property-value" aria-labelledby="loanUidTransferFreq-label">${productInstance?.loanUidTransferFreq?.description}</span></td>
						</tr>
                                            </g:if>

                                            <g:if test="${productInstance?.configItemStatus}">
						<tr>
                                                    <td style="width:30%"><label><g:message code="product.configItemStatus.label" default="Config Item Status" /></label></td>
                                                    <td style="width:70%"><span class="property-value" aria-labelledby="configItemStatus-label">${productInstance?.configItemStatus?.description}</span></td>
						</tr>
                                            </g:if>
                                        </tbody>
                                    </table>
                                </div>  
				<div class="tab-pane fade in" id="tab_2">
                                    <table class="table table-bordered table-rounded table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <g:sortableColumn property="code" title="${message(code: 'branch.code.label', default: 'Code')}" />
                                                <g:sortableColumn property="description" title="${message(code: 'branch.name.label', default: 'Branch Name')}" />
                                            </tr>    
                                        </thead>   
                                        <tbody>
                                            <g:each in="${productBranches}" status="i" var="productBranch" >
                                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                                    <td><g:link controller="Branch" action="show" id="${productBranch.branch.id}">${productBranch.branch.code}</g:link></td>
                                                    <td>${productBranch.branch.name}</td>
                                                </tr>
                                            </g:each>
                                        </tbody>    
                                    </table>  					
				</div>
				<div class="tab-pane fade in" id="tab_3">
                                    <table class="table table-bordered table-rounded table-striped table-hover">
                                        <tbody>
                                            <g:each in="${productInstance.customerGroups}" var="customerGroup" >
                                                <tr>
                                                    <td>${customerGroup.name}</td>
                                                </tr>
                                            </g:each>
                                        </tbody>  
                                    </table>
				</div>
				<div class="tab-pane fade in" id="tab_4">
                                    <table class="table table-bordered table-rounded table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <g:sortableColumn property="code" title="${message(code: 'txnTemplates.code.label', default: 'Code')}" />
                                                <g:sortableColumn property="description" title="${message(code: 'txnTemplates.description.label', default: 'Description')}" />
                                            </tr>    
                                        </thead>   
                                        <tbody>
                                            <g:each in="${productInstance.txnTemplates}" status="i" var="txnTemplate" >
                                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                                    <td><g:link controller="TxnTemplate" action="show" id="${txnTemplate.id}">${txnTemplate.code}</g:link></td>
                                                    <td>${txnTemplate.description}</td>
                                                </tr>
                                            </g:each>
                                        </tbody>    
                                    </table>    
				</div>	
			</div>
                        <g:form id="delete" url="[resource:productInstance, action:'delete']" method="DELETE">
                        </g:form>
		</div>
            </content>
             <content tag="main-actions">
                <ul>
                    <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
                    <g:if test="${productInstance.configItemStatus.id.toInteger() in [1, 2]}">      
                        <li><g:link class="edit" action="edit" resource="${productInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link></li>
                        <li><g:actionSubmit id="deleteProduct" class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="
                            alertify.confirm(AppTitle,'Are you sure you want to delete?',
                                function(){
                                    checkIfAllowed('CFG00703', 'form#delete', 'Override delete Product.', null);
                                },
                                function(){
                                    return;
                                });                                 
                            " /></li>
                    </g:if>
                    <!--
                    <script type="text/javascript">
                    $(document).ready(function() {
                        $( "#deleteProduct" ).click(function() {
                                 checkIfAllowed('CFG00703', 'form#delete', 'Override edit Product.', null); // params: policyTemplate.code, form to be saved
                        });
                    }); 
                    </script>
                    -->
                      <li><g:link action="index">Product Index</g:link></li>
		</ul>
            </content>
	</body>
</html>
