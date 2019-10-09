
<%@ page import="icbs.deposit.FixedDepositPreTermScheme" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'fixedDepositPreTermScheme.label', default: 'FixedDepositPreTermScheme')}" />
		<title>Show Fixed Deposit Pre-Term Scheme</title>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/fixedDepositPreTermScheme')}">Fixed Deposit Pre-Term Scheme List</a>
                <span class="fa fa-chevron-right"></span><span class="current">Show Fixed Deposit Pre-Term Scheme List</span>
            </content>
            <content tag="main-content">   
		<div id="show-fixedDepositPreTermScheme" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
                            <div class="box-body">
                                <div class="alert alert-info alert-dismissable">
                                    <i class="fa fa-info"></i>
                                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                    <b>Message</b> <div class="message" role="status">${flash.message}</div>
                                </div>
                            </div>
			</g:if>
                        <table class="table table-bordered table-rounded table-striped table-hover">
                            <tbody>
                                <g:if test="${fixedDepositPreTermSchemeInstance?.code}">
				<tr>
                                    <td style="width:30%"><label><g:message code="fixedDepositPreTermScheme.code.label" default="Code" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="code-label"><g:fieldValue bean="${fixedDepositPreTermSchemeInstance}" field="code"/></span></td>
				</tr>
				</g:if>
			
				<g:if test="${fixedDepositPreTermSchemeInstance?.description}">
				<tr>
                                    <td style="width:30%"><label><g:message code="fixedDepositPreTermScheme.description.label" default="Description" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${fixedDepositPreTermSchemeInstance}" field="description"/></span></td>
				</tr>
				</g:if>
			
				<g:if test="${fixedDepositPreTermSchemeInstance?.type}">
				<tr>
                                    <td style="width:30%"><label><g:message code="fixedDepositPreTermScheme.type.label" default="Type" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="type-label">${fixedDepositPreTermSchemeInstance?.type?.encodeAsHTML()}</span></td>
				</tr>
				</g:if>
			
				<g:if test="${fixedDepositPreTermSchemeInstance?.rate}">
				<tr>
                                    <td style="width:30%"><label><g:message code="fixedDepositPreTermScheme.rate.label" default="Rate" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="rate-label"><g:fieldValue bean="${fixedDepositPreTermSchemeInstance}" field="rate"/></span></td>
				</tr>
				</g:if>
			
				<g:if test="${fixedDepositPreTermSchemeInstance?.term1stHalf}">
				<tr>
                                    <td style="width:30%"><label><g:message code="fixedDepositPreTermScheme.term1stHalf.label" default="Term1st Half" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="term1stHalf-label"><g:fieldValue bean="${fixedDepositPreTermSchemeInstance}" field="term1stHalf"/></span></td>
				</tr>
				</g:if>
			
				<g:if test="${fixedDepositPreTermSchemeInstance?.term2ndHalf}">
				<tr>
                                    <td style="width:30%"><label><g:message code="fixedDepositPreTermScheme.term2ndHalf.label" default="Term2nd Half" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="term2ndHalf-label"><g:fieldValue bean="${fixedDepositPreTermSchemeInstance}" field="term2ndHalf"/></span></td>
				</tr>
				</g:if>
			
				<g:if test="${fixedDepositPreTermSchemeInstance?.divisor}">
				<tr>
                                    <td style="width:30%"><label><g:message code="fixedDepositPreTermScheme.divisor.label" default="Divisor" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="divisor-label"><g:fieldValue bean="${fixedDepositPreTermSchemeInstance}" field="divisor"/></span></td>
				</tr>
				</g:if>
			
				<g:if test="${fixedDepositPreTermSchemeInstance?.status}">
				<tr>
                                    <td style="width:30%"><label><g:message code="fixedDepositPreTermScheme.status.label" default="Status" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="status-label">${fixedDepositPreTermSchemeInstance?.status?.encodeAsHTML()}</span></td>
				</tr>
				</g:if>
			
				<g:if test="${fixedDepositPreTermSchemeInstance?.isGradeRate}">
				<tr>
                                    <td style="width:30%"><label><g:message code="fixedDepositPreTermScheme.isGradeRate.label" default="Is Grade Rate" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="isGradeRate-label"><g:formatBoolean boolean="${fixedDepositPreTermSchemeInstance?.isGradeRate}" /></span></td>
				</tr>
				</g:if>
                            </tbody>
                        </table>
                                    <label><h3>Products</h3></label>
                                    <table class="table table-bordered table-rounded table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <g:sortableColumn property="code" title="${message(code: 'product.code.label', default: 'Code')}" />
                                                <g:sortableColumn property="name" title="${message(code: 'product.description.label', default: 'Product Name')}" />
                                            </tr>    
                                        </thead>   
                                        <tbody>
                                            <g:each in="${fixedDepositPreTermSchemeInstance.products}" status="i" var="product">
                                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                                    <td style="width:30%"><g:link controller="Product" action="show" id="${product.id}">${product.code}</g:link></td>
                                                    <td style="width:70%">${product.name}</td>
                                                </tr>
                                            </g:each>
                                        </tbody>    
                                    </table>    				
				
		</div>
            </content>
             <content tag="main-actions">
                <ul>
      			<li><g:link class="list" action="index">Fixed Deposit Pre-Term Scheme List</g:link></li>
      			<li><g:link class="create" action="create">New Fixed Deposit Pre-Term Scheme</g:link></li>
                <li><button disabled="disabled">View Fixed Deposit Pre-Term Scheme</button></li>
                <li><g:link action="edit" controller="FixedDepositPreTermScheme" id="${fixedDepositPreTermSchemeInstance.id}">Update Fixed Deposit Pre-Term Scheme</g:link></li>

                <g:if test="${fixedDepositPreTermSchemeInstance.status.id == 1}">
                <li><g:form url="[id:fixedDepositPreTermSchemeInstance.id, action:'activate']" method="POST">
					<g:actionSubmit action="activate" value="Activate" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</g:form></li>
                </g:if>

                <g:if test="${fixedDepositPreTermSchemeInstance.status.id.toInteger() in [1, 2]}">
                    <li><g:form id="deleteFixedDepositPreTermSchemeForm" url="[id:fixedDepositPreTermSchemeInstance.id, action:'delete']" method="POST">                                           
                        </g:form>
                        <g:actionSubmit id="deleteFixedDepositPreTermScheme" action="delete" value="Delete" onclick="
                            alertify.confirm(AppTitle,'Are you sure you want to delete?',
                                function(){
                                    checkIfAllowed('CFG00903', 'form#deleteFixedDepositPreTermSchemeForm', 'Override delete Fixed Deposit PreTerm Scheme.', null); 
                                },
                                function(){
                                    return;
                                });                             
                            " />
                    </li>
                </g:if>
	       	</ul>
                <!--
                <script type="text/javascript">
                    $(document).ready(function() {
                        $( "#deleteFixedDepositPreTermScheme" ).click(function() {
                                 checkIfAllowed('CFG00903', 'form#deleteFixedDepositPreTermSchemeForm', 'Override new Fixed Deposit PreTerm Scheme.', null); // params: policyTemplate.code, form to be saved
                        });
                    }); 
                </script>
                -->
            </content>
	</body>
</html>
