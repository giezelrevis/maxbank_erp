
<%@ page import="icbs.loans.PenaltyIncomeScheme" %>
<%@ page import="icbs.lov.LoanPenaltyBasis" %>
<%@ page import="icbs.lov.LoanPenaltyFreq" %>
<%@ page import="icbs.lov.ConfigItemStatus" %>
<%@ page import="icbs.admin.Product" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'penaltyIncomeScheme.label', default: 'PenaltyIncomeScheme')}" />
		<title>View Penalty Income Scheme</title>		
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/penaltyIncomeScheme')}">Penalty Income Scheme</a>
                <span class="fa fa-chevron-right"></span><span class="current">View Penalty Income Scheme</span>
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
                                        <td style="width:30%"><label><g:message code="penaltyIncomeScheme.code.label" default="Code" /></label></td>				
                                        <td style="width:70%"><span><g:fieldValue bean="${penaltyIncomeSchemeInstance}" field="code"/></span></td>
                                    </tr>
                                    <tr>
					<td style="width:30%"><label><g:message code="penaltyIncomeScheme.name.label" default="Name" /></label></td>					
					<td style="width:70%"><span><g:fieldValue bean="${penaltyIncomeSchemeInstance}" field="name"/></span></td>
                                    </tr>
                                    <tr>
					<td style="width:30%"><label><g:message code="penaltyIncomeScheme.basis.label" default="Basis" /></label></td>					
					<td style="width:70%"><span>${penaltyIncomeSchemeInstance?.basis?.description}</span></td>
                                    </tr>					
                                    <tr>
					<td style="width:30%"><label><g:message code="penaltyIncomeScheme.type.label" default="Type" /></label></td>					
					<td style="width:70%"><span>${penaltyIncomeSchemeInstance?.type?.description}</span></td>
                                    </tr>

                                    <g:if test="${penaltyIncomeSchemeInstance.type.id == 1}">
                                    <tr>
					<td style="width:30%"><label><g:message code="penaltyIncomeScheme.frequency.label" default="Frequency" /></label></td>					
					<td style="width:70%"><span>${penaltyIncomeSchemeInstance?.frequency?.description}</span></td>
                                    </tr>
                                    <tr>
					<td style="width:30%"><label><g:message code="penaltyIncomeScheme.defaultPenaltyAmount.label" default="Default Penalty Amount" /></label></td>					
					<td style="width:70%"><span><g:fieldValue bean="${penaltyIncomeSchemeInstance}" field="defaultPenaltyAmount"/></span></td>
                                    </tr>
                                    <tr>
					<td style="width:30%"><label><g:message code="penaltyIncomeScheme.minPenaltyAmount.label" default="Min Penalty Amount" /></label></td>					
					<td style="width:70%"><span><g:fieldValue bean="${penaltyIncomeSchemeInstance}" field="minPenaltyAmount"/></span></td>
                                    </tr>					
                                    <tr>
					<td style="width:30%"><label><g:message code="penaltyIncomeScheme.maxPenaltyAmount.label" default="Max Penalty Amount" /></label></td>					
					<td style="width:70%"><span><g:fieldValue bean="${penaltyIncomeSchemeInstance}" field="maxPenaltyAmount"/></span></td>
                                    </tr>
                                    </g:if>
                                    <g:elseif test="${penaltyIncomeSchemeInstance.type.id == 2}">
                                    <tr>
					<td style="width:30%"><label><g:message code="penaltyIncomeScheme.defaultPenaltyRate.label" default="Default Penalty Rate" /></label></td>					
					<td style="width:70%"><span><g:fieldValue bean="${penaltyIncomeSchemeInstance}" field="defaultPenaltyRate"/>%</span></td>
                                    </tr>
                                    <tr>
					<td style="width:30%"><label><g:message code="penaltyIncomeScheme.minPenaltyRate.label" default="Min Penalty Rate" /></label></td>					
					<td style="width:70%"><span><g:fieldValue bean="${penaltyIncomeSchemeInstance}" field="minPenaltyRate"/>%</span></td>
                                    </tr>
                                    <tr>
					<td style="width:30%"><label><g:message code="penaltyIncomeScheme.maxPenaltyRate.label" default="Max Penalty Rate" /></label></td>					
					<td style="width:70%"><span><g:fieldValue bean="${penaltyIncomeSchemeInstance}" field="maxPenaltyRate"/>%</span></td>
                                    </tr>
                                    <tr>
					<td style="width:30%"><label><g:message code="penaltyIncomeScheme.divisor.label" default="Divisor" /></label></td>					
					<td style="width:70%"><span><g:fieldValue bean="${penaltyIncomeSchemeInstance}" field="divisor"/></span></td>
                                    </tr>
                                    </g:elseif>
                                    <tr>
					<td style="width:30%"><label><g:message code="penaltyIncomeScheme.gracePeriod.label" default="Grace Period" /></label></td>					
					<td style="width:70%"><span><g:fieldValue bean="${penaltyIncomeSchemeInstance}" field="gracePeriod"/></span></td>
                                    </tr>				
                                    <tr>
					<td style="width:30%"><label><g:message code="penaltyIncomeScheme.canChangePenaltyRate.label" default="Changeable Penalty Rate" /></label></td>					
					<td style="width:70%"><span><g:formatBoolean boolean="${penaltyIncomeSchemeInstance?.canChangePenaltyRate}" /></span></td>
                                    </tr>
                                    <tr>
					<td style="width:30%"><label><g:message code="penaltyIncomeScheme.hasWeekendMode.label" default="Weekend Mode" /></label></td>					
					<td style="width:70%"><span><g:formatBoolean boolean="${penaltyIncomeSchemeInstance?.hasWeekendMode}" /></span></td>
                                    </tr>			
                                    <tr>
					<td style="width:30%"><label><g:message code="penaltyIncomeScheme.status.label" default="Status" /></label></td>					
					<td style="width:70%"><span>${penaltyIncomeSchemeInstance?.status?.description}</span></td>
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
                                            <g:each in="${penaltyIncomeSchemeInstance.products}" status="i" var="product">
                                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                                    <td><g:link controller="Product" action="show" id="${product.id}">${product.code}</g:link></td>
                                                    <td>${product.name}</td>
                                                </tr>
                                            </g:each>
                                        </tbody>    
                                    </table>    				
	
				</div>						
			</div>
			<%--<g:form url="[resource:penaltyIncomeSchemeInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="btn btn-primary edit" action="edit" resource="${penaltyIncomeSchemeInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="btn btn-primary delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>--%>
		</div>
		</content>
		<content tag="main-actions">
      		<ul>
      			<li><g:link class="list" action="index">Search Penalty Income Scheme</g:link></li>
                <li><g:link action="edit" controller="penaltyIncomeScheme" id="${penaltyIncomeSchemeInstance.id}">Update Penalty Income Scheme</g:link></li>

                <g:if test="${penaltyIncomeSchemeInstance.status.id == 1}">
                <li><g:form id="activate" url="[resource:penaltyIncomeSchemeInstance, action:'activate']" method="POST">
                    </g:form>
                     <g:actionSubmit id="activatePenaltyIncomeScheme" action="activate" value="Activate" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </li>
                </g:if>

                <g:if test="${penaltyIncomeSchemeInstance.status.id.toInteger() in [1, 2]}">
                    <li><g:form id="delete" url="[resource:penaltyIncomeSchemeInstance, action:'delete']" method="POST">
                        </g:form>
                        <g:actionSubmit id="deletePenaltyIncomeScheme" action="delete" value="Delete" onclick="
                            alertify.confirm(AppTitle,'Are you sure you want to delete?',
                                function(){
                                    checkIfAllowed('CFG01104', 'form#delete', 'Override New Penalty Income Scheme.', null);
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
                        //$( "#deletePenaltyIncomeScheme" ).click(function() {
                        //         checkIfAllowed('CFG01104', 'form#delete', 'Override New Penalty Income Scheme.', null); // params: policyTemplate.code, form to be saved
                        //});
                        $( "#activatePenaltyIncomeScheme" ).click(function() {
                                 checkIfAllowed('CFG01103', 'form#activate', 'Override New Penalty Income Scheme.', null); // params: policyTemplate.code, form to be saved
                        });
                    }); 
                </script> 
	    </content>
	</body>
</html>
