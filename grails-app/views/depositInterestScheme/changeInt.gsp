<%@ page import="icbs.deposit.DepositInterestScheme" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'depositInterestScheme.label', default: 'DepositInterestScheme')}" />
		<title>Change Interest Rate</title>
                <asset:javascript src="depositHelper.js"/>
                <g:javascript>
                    function isGraduatedChecked(){
                        var e = $("#isGraduated")
                        if ($(e).is(":checked")){
                            $($("#tabs").find("li")[1]).show();
                        }else{
                            $("#graduatedList").empty();
                            $($("#tabs").find("li")[1]).hide();
                        }
                    }
                    function addGraduatedAjax(){
                        icbs.Deposit.DepositInterestScheme.Form.getForm('graduated',"${createLink(controller : 'depositInterestScheme', action:'addGraduatedFormAjax')}");
                    }
                    
                </g:javascript>
	</head>
	<body>
            <content tag="main-content">
		<div id="edit-depositInterestScheme" class="content scaffold-edit" role="main">
                    <g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
                    </g:if>
                    <g:hasErrors bean="${depositInterestSchemeInstance}">
			<ul class="errors" role="alert">
                            <!--
				<g:eachError bean="${depositInterestSchemeInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
                            -->    
			</ul>
                    </g:hasErrors>
                    <ol class="property-list depositInterestScheme">
			
			<g:if test="${depositInterestSchemeInstance?.code}">
                            <li class="fieldcontain">
				<span id="code-label" class="property-label"><g:message code="depositInterestScheme.code.label" default="Code" /></span>
				<span class="property-value" aria-labelledby="code-label"><g:fieldValue bean="${depositInterestSchemeInstance}" field="code"/></span>
                            </li>
			</g:if>
			
			<g:if test="${depositInterestSchemeInstance?.name}">
                            <li class="fieldcontain">
				<span id="name-label" class="property-label"><g:message code="depositInterestScheme.name.label" default="Name" /></span>
				<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${depositInterestSchemeInstance}" field="name"/></span>
                            </li>
			</g:if>
                        <g:if test="${depositInterestSchemeInstance?.depositInterestStart}">
                            <li class="fieldcontain">
				<span id="name-label" class="property-label"><g:message code="depositInterestScheme.depositInterestStart.label" default="Deposit Interest Start" /></span>
                                <span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${depositInterestSchemeInstance}" field="depositInterestStart.description"/></span>
                            </li>
			</g:if>
			<g:if test="${depositInterestSchemeInstance?.interestRate}">
                            <li class="fieldcontain">
				<span id="interestRate-label" class="property-label"><g:message code="depositInterestScheme.interestRate.label" default="Interest Rate" /></span>
                                <span class="property-value" aria-labelledby="interestRate-label"><g:formatNumber format="#,##0.00" number="${depositInterestSchemeInstance?.interestRate}"/>%</span>
                            </li>
			</g:if>
			<g:if test="${depositInterestSchemeInstance?.divisor}">
                            <li class="fieldcontain">
				<span id="divisor-label" class="property-label"><g:message code="depositInterestScheme.divisor.label" default="Divisor" /></span>
                                <span class="property-value" aria-labelledby="divisor-label"><g:fieldValue bean="${depositInterestSchemeInstance}" field="divisor"/></span>
                            </li>
			</g:if>
			<g:if test="${depositInterestSchemeInstance?.minInterestRate}">
                            <li class="fieldcontain">
				<span id="minInterestRate-label" class="property-label"><g:message code="depositInterestScheme.minInterestRate.label" default="Min Interest Rate" /></span>
                                <span class="property-value" aria-labelledby="minInterestRate-label"><g:formatNumber format="#,##0.00" number="${depositInterestSchemeInstance?.minInterestRate}"/>%</span>
                            </li>
			</g:if>
			<g:if test="${depositInterestSchemeInstance?.maxInterestRate}">
                            <li class="fieldcontain">
                                <span id="maxInterestRate-label" class="property-label"><g:message code="depositInterestScheme.maxInterestRate.label" default="Max Interest Rate" /></span>
                                <span class="property-value" aria-labelledby="maxInterestRate-label"><g:formatNumber format="#,##0.00" number="${depositInterestSchemeInstance?.maxInterestRate}"/>%</span>
                            </li>
			</g:if>
                        <g:if test="${depositInterestSchemeInstance?.fdPostMaturityRate}">
                            <li class="fieldcontain">
				<span id="interestRate-label" class="property-label"><g:message code="depositInterestScheme.fdPostMaturityRate.label" default="FD Post Maturity Interest Rate" /></span>
				<span class="property-value" aria-labelledby="interestRate-label"><g:formatNumber format="#,##0.00" number="${depositInterestSchemeInstance?.fdPostMaturityRate}"/>%</span>
                            </li>
			</g:if>	
			<g:if test="${depositInterestSchemeInstance?.fdMonthlyTransfer}">
                            <li class="fieldcontain">
				<span id="fdMonthlyTransfer-label" class="property-label"><g:message code="depositInterestScheme.fdMonthlyTransfer.label" default="FD Monthly Transfer" /></span>
				<span class="property-value" aria-labelledby="fdMonthlyTransfer-label"><g:formatBoolean boolean="${depositInterestSchemeInstance?.fdMonthlyTransfer}" /></span>
                            </li>
			</g:if>   
                        <g:if test="${depositInterestSchemeInstance?.minBalanceToEarnInterest}">
                            <li class="fieldcontain">
                                <span id="minBalanceToEarnInterest-label" class="property-label"><g:message code="depositInterestScheme.minBalanceToEarnInterest.label" default="Min Balance To Earn Interest" /></span>
				<span class="property-value" aria-labelledby="minBalanceToEarnInterest-label"><g:formatNumber format="###,###,##0.00" number="${depositInterestSchemeInstance?.minBalanceToEarnInterest}"/></span>
                            </li>
			</g:if>
			<g:if test="${depositInterestSchemeInstance?.canChangeInterestRate}">
                            <li class="fieldcontain">
				<span id="canChangeInterestRate-label" class="property-label"><g:message code="depositInterestScheme.canChangeInterestRate.label" default="Can Change Interest Rate" /></span>
                                <span class="property-value" aria-labelledby="canChangeInterestRate-label"><g:formatBoolean boolean="${depositInterestSchemeInstance?.canChangeInterestRate}" /></span>
                            </li>
			</g:if>
                        <g:if test="${depositInterestSchemeInstance?.isAccrual}">
                            <li class="fieldcontain">
				<span id="isAccrual-label" class="property-label"><g:message code="depositInterestScheme.isAccrual.label" default="Is Accrual" /></span>
                                <span class="property-value" aria-labelledby="isAccrual-label"><g:formatBoolean boolean="${depositInterestSchemeInstance?.isAccrual}" /></span>
                            </li>
			</g:if>
			<g:if test="${depositInterestSchemeInstance?.depositCapitalizationFreq}">
                            <li class="fieldcontain">
				<span id="depositCapitalizationFreq-label" class="property-label"><g:message code="depositInterestScheme.depositCapitalizationFreq.label" default="Deposit Capitalization Freq" /></span>
				<span class="property-value" aria-labelledby="depositCapitalizationFreq-label">${depositInterestSchemeInstance?.depositCapitalizationFreq?.encodeAsHTML()}</span>
                            </li>
			</g:if>
			<g:if test="${depositInterestSchemeInstance?.depositInterestCalculation}">
                            <li class="fieldcontain">
				<span id="depositInterestCalculation-label" class="property-label"><g:message code="depositInterestScheme.depositInterestCalculation.label" default="Deposit Interest Calculation:" /></span>
                                <span class="property-value" aria-labelledby="depositInterestCalculation-label">${depositInterestSchemeInstance?.depositInterestCalculation.description}</span>
                            </li>
			</g:if>
			<g:if test="${depositInterestSchemeInstance?.status}">
                            <li class="fieldcontain">
				<span id="status-label" class="property-label"><g:message code="depositInterestScheme.status.label" default="Status" /></span>
				<span class="property-value" aria-labelledby="status-label">${depositInterestSchemeInstance?.status?.encodeAsHTML()}</span>
                            </li>
			</g:if>
			<g:if test="${depositInterestSchemeInstance?.isGraduated}">
                            <li class="fieldcontain">
				<span id="isGraduated-label" class="property-label"><g:message code="depositInterestScheme.isGraduated.label" default="Is Graduated" /></span>
				<span class="property-value" aria-labelledby="isGraduated-label"><g:formatBoolean boolean="${depositInterestSchemeInstance?.isGraduated}" /></span>
                            </li>
			</g:if>
                            <li class="fieldcontain">
                                <span id="products-label" class="property-label">Products</span>
                                    <ul id="products">
                                        <g:each in="${depositInterestSchemeInstance.products}" var="product">
                                            <li>${product.name}</li>
                                        </g:each>
                                    </ul>					
                            </li>
			</ol>                        
			<g:form id="DepositInterestSchemeForm" url="[resource:depositInterestSchemeInstance, action:'saveIntRate']" method="PUT" >
                            <g:hiddenField name="version" value="${depositInterestSchemeInstance?.version}" />

                            <fieldset class="form">
                                <div class="fieldcontain form-group ${hasErrors(bean: depositInterestSchemeInstance, field: 'interestRate', 'has-error')} required">
                                    <label class="control-label col-sm-4" for="interestRate">
                                        <g:message code="depositInterestScheme.interestRate.label" default="Interest Rate" />
                                        <span class="required-indicator">*</span>
                                    </label>
                                    <div class="col-sm-8"><g:field name="interestRate" value="${fieldValue(bean: depositInterestSchemeInstance, field: 'interestRate')}"  class="form-control"/>
                                        <g:hasErrors bean="${depositInterestSchemeInstance}" field="interestRate">
                                            <div class="controls">
                                                <span class="help-block">
                                                    <g:eachError bean="${depositInterestSchemeInstance}" field="interestRate">
                                                        <g:message error="${it}" /><br/>
                                                    </g:eachError>
                                                </span>
                                            </div>
                                        </g:hasErrors>
                                    </div>             
                                </div>
                            </fieldset>
                            <g:if test="${depositInterestSchemeInstance?.isGraduated==true}">
                                <div class="tab-pane" id="tab_2">
                                    <g:render template="form/graduated/graduatedInfo"/>
                                </div>
                            </g:if>
			</g:form>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><g:submitButton name="saveIntRate" id="saveIntRate" value="${message(code: 'default.button.update.label', default: 'Change Interest Rate')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Save?')}');"/></li>
                    <!--<li><a href="#" onclick="$('#DepositInterestSchemeForm').submit()">Update</a></li>-->
                    <li><g:link class="list" action="show" id="${depositInterestSchemeInstance.id}">Back to Show</g:link></li>
	       	</ul>
                <script type="text/javascript">
                    $(document).ready(function() {
                        $( "#saveIntRate" ).click(function() {
                                 checkIfAllowed('CFG01003', 'form#DepositInterestSchemeForm', 'Override Change Interest Rate', null); // params: policyTemplate.code, form to be saved
                        });
                    }); 
                </script>
            </content>
	</body>
</html>
