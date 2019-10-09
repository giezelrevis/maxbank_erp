
<%@ page import="icbs.deposit.DepositInterestScheme" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'depositInterestScheme.label', default: 'DepositInterestScheme')}" />
                <title>Show Deposit Interest Scheme</title>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/depositInterestScheme')}">Deposit Interest Scheme</a>
                <span class="fa fa-chevron-right"></span><span class="current">Show Deposit Interest Scheme</span>
            </content>
            <content tag="main-content">   
		<div id="show-depositInterestScheme" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
                            <script>
                            $(function(){
                                var x = '${flash.message}';
                                    notify.message(x);
                            });
                            </script>  
                            <!--
                            <div class="box-body">
                                <div class="alert alert-info alert-dismissable">
                                    <i class="fa fa-info"></i>
                                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                    <b>Message</b> <div class="message" role="status">${flash.message}</div>
                                </div>
                            </div>
                            -->
			</g:if>
                        <div class="nav-tab-container">
                            <ul class="nav nav-tabs">
                                <li class="active"><a href="#tab_1" data-toggle="tab">Deposit Interest Scheme Details</a></li>
                                <li><a href="#tab_2" data-toggle="tab">Products</a></li>                        
                                                    
                            </ul>
                        </div>
                        <div class="tab-content">
                            
                            <div class="tab-pane active fade in table-responsive" id="tab_1">
                                    <span id="products-label" class="property-label"><legend>Deposit Interest Scheme Details</legend></span>
                                    <table class="table table-bordered table-striped">
                                        
                                            <g:if test="${depositInterestSchemeInstance?.code}">
                                                <tr>
                                                    <td><label><span id="code-label" class="property-label"><g:message code="depositInterestScheme.code.label" default="Code" /></span></label></td>  
                                                    <td><span class="property-value" aria-labelledby="code-label"><g:fieldValue bean="${depositInterestSchemeInstance}" field="code"/></span></td>
                                                </tr>  
                                            </g:if>  
                                            <g:if test="${depositInterestSchemeInstance?.name}">
                                                <tr>
                                                    <td><label><span id="name-label" class="property-label"><g:message code="depositInterestScheme.name.label" default="Name" /></span></label></td>  
                                                    <td><span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${depositInterestSchemeInstance}" field="name"/></span></td>
                                                </tr> 
                                            </g:if>
                                            <g:if test="${depositInterestSchemeInstance?.depositInterestStart}">
                                                <tr>
                                                    <td><label><span id="name-label" class="property-label"><g:message code="depositInterestScheme.depositInterestStart.label" default="Deposit Interest Start" /></span></label></td>  
                                                    <td><span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${depositInterestSchemeInstance}" field="depositInterestStart.description"/></span></td>
                                                </tr>                                                 
                                            </g:if>   
                                            <g:if test="${depositInterestSchemeInstance?.interestRate}">
                                                <tr>
                                                    <td><label><span id="interestRate-label" class="property-label"><g:message code="depositInterestScheme.interestRate.label" default="Interest Rate" /></span></label></td>  
                                                    <td><span class="property-value" aria-labelledby="interestRate-label"><g:formatNumber format="#,##0.00" number="${depositInterestSchemeInstance?.interestRate}"/>%</span></td>
                                                </tr>  
                                            </g:if>
                                            <g:if test="${depositInterestSchemeInstance?.divisor}">
                                                <tr>
                                                    <td><label><span id="divisor-label" class="property-label"><g:message code="depositInterestScheme.divisor.label" default="Divisor" /></span></label></td>  
                                                    <td><span class="property-value" aria-labelledby="divisor-label"><g:fieldValue bean="${depositInterestSchemeInstance}" field="divisor"/></span></td>
                                                </tr> 
                                            </g:if>
                                            <g:if test="${depositInterestSchemeInstance?.minInterestRate}">
                                                <tr>
                                                    <td><label><span id="minInterestRate-label" class="property-label"><g:message code="depositInterestScheme.minInterestRate.label" default="Min Interest Rate" /></span></label></td>  
                                                    <td><span class="property-value" aria-labelledby="minInterestRate-label"><g:formatNumber format="#,##0.00" number="${depositInterestSchemeInstance?.minInterestRate}"/>%</span></td>
                                                </tr> 
                                            </g:if>
                                            <g:if test="${depositInterestSchemeInstance?.maxInterestRate}">
                                                <tr>
                                                    <td><label><span id="maxInterestRate-label" class="property-label"><g:message code="depositInterestScheme.maxInterestRate.label" default="Max Interest Rate" /></span></label></td>  
                                                    <td><span class="property-value" aria-labelledby="maxInterestRate-label"><g:formatNumber format="#,##0.00" number="${depositInterestSchemeInstance?.maxInterestRate}"/>%</span></td>
                                                </tr> 
                                            </g:if>
                                            <g:if test="${depositInterestSchemeInstance?.fdPostMaturityRate}">
                                                <tr>
                                                    <td><label><span id="interestRate-label" class="property-label"><g:message code="depositInterestScheme.fdPostMaturityRate.label" default="FD Post Maturity Interest Rate" /></span></label></td>  
                                                    <td><span class="property-value" aria-labelledby="interestRate-label"><g:formatNumber format="#,##0.00" number="${depositInterestSchemeInstance?.fdPostMaturityRate}"/>%</span></td>
                                                </tr> 
                                            </g:if>	
                                            <g:if test="${depositInterestSchemeInstance?.fdMonthlyTransfer}">
                                                <tr>
                                                    <td><label><span id="fdMonthlyTransfer-label" class="property-label"><g:message code="depositInterestScheme.fdMonthlyTransfer.label" default="FD Monthly Transfer" /></span></label></td>  
                                                    <td><span class="property-value" aria-labelledby="fdMonthlyTransfer-label"><g:formatBoolean boolean="${depositInterestSchemeInstance?.fdMonthlyTransfer}" /></span></td>
                                                </tr>
                                            </g:if>   
                                            <g:if test="${depositInterestSchemeInstance?.minBalanceToEarnInterest}">
                                                <tr>
                                                    <td><label><span id="minBalanceToEarnInterest-label" class="property-label"><g:message code="depositInterestScheme.minBalanceToEarnInterest.label" default="Min Balance To Earn Interest" /></span></label></td>  
                                                    <td><span class="property-value" aria-labelledby="minBalanceToEarnInterest-label"><g:formatNumber format="###,###,##0.00" number="${depositInterestSchemeInstance?.minBalanceToEarnInterest}"/></span></td>
                                                </tr>
                                  
                                            </g:if>
                                            <g:if test="${depositInterestSchemeInstance?.canChangeInterestRate}">
                                                <tr>
                                                    <td><label><span id="canChangeInterestRate-label" class="property-label"><g:message code="depositInterestScheme.canChangeInterestRate.label" default="Can Change Interest Rate" /></span></label></td>  
                                                    <td><span class="property-value" aria-labelledby="canChangeInterestRate-label"><g:formatBoolean boolean="${depositInterestSchemeInstance?.canChangeInterestRate}" /></span></td>
                                                </tr>
                                            </g:if>    
                                            <g:if test="${depositInterestSchemeInstance?.isAccrual}">
                                                <tr>
                                                    <td><label><span id="isAccrual-label" class="property-label"><g:message code="depositInterestScheme.isAccrual.label" default="Is Accrual" /></span></label></td>  
                                                    <td><span class="property-value" aria-labelledby="isAccrual-label"><g:formatBoolean boolean="${depositInterestSchemeInstance?.isAccrual}" /></span></td>
                                                </tr>
                                            </g:if>
                                            <g:if test="${depositInterestSchemeInstance?.depositCapitalizationFreq}">
                                                <tr>
                                                    <td><label><span id="depositCapitalizationFreq-label" class="property-label"><g:message code="depositInterestScheme.depositCapitalizationFreq.label" default="Deposit Capitalization Freq" /></span></label></td>  
                                                    <td><span class="property-value" aria-labelledby="depositCapitalizationFreq-label">${depositInterestSchemeInstance?.depositCapitalizationFreq?.encodeAsHTML()}</span></td>
                                                </tr>
                                            </g:if>
                                            <g:if test="${depositInterestSchemeInstance?.depositInterestCalculation}">
                                                <tr>
                                                    <td><label><span id="depositInterestCalculation-label" class="property-label"><g:message code="depositInterestScheme.depositInterestCalculation.label" default="Deposit Interest Calculation:" /></span></label></td>  
                                                    <td><span class="property-value" aria-labelledby="depositInterestCalculation-label">${depositInterestSchemeInstance?.depositInterestCalculation.description}</span></td>
                                                </tr>
                                            </g:if>
                                            <g:if test="${depositInterestSchemeInstance?.status}">
                                                <tr>
                                                    <td><label><span id="status-label" class="property-label"><g:message code="depositInterestScheme.status.label" default="Status" /></span></label></td>  
                                                    <td><span class="property-value" aria-labelledby="status-label">${depositInterestSchemeInstance?.status?.encodeAsHTML()}</span></td>
                                                </tr>
                                            </g:if>
                                            <g:if test="${depositInterestSchemeInstance?.isGraduated}">
                                                <tr>
                                                    <td><label><span id="isGraduated-label" class="property-label"><g:message code="depositInterestScheme.isGraduated.label" default="Is Graduated" /></span></label></td>  
                                                    <td><span class="property-value" aria-labelledby="isGraduated-label"><g:formatBoolean boolean="${depositInterestSchemeInstance?.isGraduated}" /></span></td>
                                                </tr>
                                            </g:if>
                                    </table>
                            </div>
                            
                            <div class="tab-pane" id="tab_2">
                                    <span id="products-label" class="property-label"><legend>Products</legend></span>
                                    <table class="table table-bordered table-rounded table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <g:sortableColumn property="code" title="${message(code: 'product.code.label', default: 'Code')}" />
                                                <g:sortableColumn property="name" title="${message(code: 'product.description.label', default: 'Product Name')}" />
                                            </tr>    
                                        </thead>   
                                        <tbody>
                                            <g:each in="${depositInterestSchemeInstance.products}" status="i" var="product">
                                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                                    <td><g:link controller="Product" action="show" id="${product.id}">${product.code}</g:link></td>
                                                    <td>${product.name}</td>
                                                </tr>
                                            </g:each>
                                        </tbody>    
                                    </table>						
                            </div> <!-- tab id=2 -->
                            
                        </div> <!-- Div Close tab-content -->
			
		</div>
            </content>
             <content tag="main-actions">
                <ul>
      			<li><g:link class="list" action="index">Deposit Interest Scheme List</g:link></li>
      			<li><g:link class="create" action="create">New Deposit Interest Scheme</g:link></li>
                <li><button disabled="disabled">View Deposit Interest Scheme</button></li>
                <g:if test="${depositInterestSchemeInstance.status.id.toInteger() in [1, 2]}">
                    <li><g:link action="edit" controller="DepositInterestScheme" id="${depositInterestSchemeInstance.id}">Update Deposit Interest Scheme</g:link></li>
                </g:if>
                <g:if test="${depositInterestSchemeInstance.status.id == 1}">
                <li><g:form url="[id:depositInterestSchemeInstance.id, action:'activate']" method="POST">
                        <g:actionSubmit action="activate" value="Activate" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                    </g:form></li>
                </g:if>

                <g:if test="${depositInterestSchemeInstance.status.id.toInteger() in [1, 2]}">
                    <li><g:form id="deleteDepositInterestSchemeForm" url="[id:depositInterestSchemeInstance.id, action:'delete']" method="POST">
                        </g:form>
                        <g:actionSubmit id="deleteDepositIntScheme" action="delete" value="Delete" onclick="
                            alertify.confirm(AppTitle,'Are you sure you want to delete?',
                                function(){
                                    checkIfAllowed('CFG01004', 'form#deleteDepositInterestSchemeForm', 'Override edit Deposit Interest Scheme.', null); 
                                },
                                function(){
                                    return;
                                });                                
                            " />
                    </li>
                </g:if>
                    <li><g:link action="changeInt" controller="DepositInterestScheme" id="${depositInterestSchemeInstance.id}">Change Interest Rate</g:link></li>
	       	</ul>
                <!--
                <script type="text/javascript">
                    $(document).ready(function() {
                        $( "#deleteDepositIntScheme" ).click(function() {
                                 checkIfAllowed('CFG01004', 'form#deleteDepositInterestSchemeForm', 'Override edit Deposit Interest Scheme.', null); // params: policyTemplate.code, form to be saved
                        });
                    }); 
                </script>
                -->
            </content>
	</body>
</html>
