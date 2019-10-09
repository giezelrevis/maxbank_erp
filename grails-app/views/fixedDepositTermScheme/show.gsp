
<%@ page import="icbs.deposit.FixedDepositTermScheme" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'fixedDepositTermScheme.label', default: 'FixedDepositTermScheme')}" />
		<title>Show Fixed Deposit Term Scheme</title>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/fixedDepositTermScheme')}">Fixed Deposit Term Scheme List</a>
                <span class="fa fa-chevron-right"></span><span class="current">Show Fixed Deposit Term Scheme</span>
            </content>
            <content tag="main-content">   
		<div id="show-fixedDepositTermScheme" class="content scaffold-show" role="main">
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
                                <g:if test="${fixedDepositTermSchemeInstance?.code}">
				<tr>
                                    <td style="width:30%"><label><g:message code="fixedDepositTermScheme.code.label" default="Code" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="code-label"><g:fieldValue bean="${fixedDepositTermSchemeInstance}" field="code"/></span></td>
				</tr>
				</g:if>
                                <g:if test="${fixedDepositTermSchemeInstance?.description}">
				<tr>
                                    <td style="width:30%"><label><g:message code="fixedDepositTermScheme.description.label" default="Description" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${fixedDepositTermSchemeInstance}" field="description"/></span></td>
				</tr>
				</g:if>
                                <g:if test="${fixedDepositTermSchemeInstance?.value}">
				<tr>
                                    <td style="width:30%"><label><g:message code="fixedDepositTermScheme.value.label" default="Value" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="value-label"><g:fieldValue bean="${fixedDepositTermSchemeInstance}" field="value"/></span></td>
				</tr>
				</g:if>
                                <g:if test="${fixedDepositTermSchemeInstance?.termMin}">
				<tr>
                                    <td style="width:30%"><label><g:message code="fixedDepositTermScheme.termMin.label" default="Term Min" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="termMin-label"><g:fieldValue bean="${fixedDepositTermSchemeInstance}" field="termMin"/></span></td>
				</tr>
				</g:if>
                                <g:if test="${fixedDepositTermSchemeInstance?.termMax}">
				<tr>
                                    <td style="width:30%"><label><g:message code="fixedDepositTermScheme.termMax.label" default="Term Max" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="termMax-label"><g:fieldValue bean="${fixedDepositTermSchemeInstance}" field="termMax"/></span></td>
				</tr>
				</g:if>
                                <g:if test="${fixedDepositTermSchemeInstance?.status}">
				<tr>
                                    <td style="width:30%"><label><g:message code="fixedDepositTermScheme.status.label" default="Status" /></label></td>
                                    <td style="width:70%"><span class="property-value" aria-labelledby="status-label">${fixedDepositTermSchemeInstance?.status?.encodeAsHTML()}</span></td>
				</tr>
				</g:if>
                            </tbody>
                        </table>
			<span id="products-label" class="property-label"><h3>Products</h3></span>
                                    <table class="table table-bordered table-rounded table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <g:sortableColumn property="code" title="${message(code: 'product.code.label', default: 'Code')}" />
                                                <g:sortableColumn property="name" title="${message(code: 'product.description.label', default: 'Product Name')}" />
                                            </tr>    
                                        </thead>   
                                        <tbody>
                                            <g:each in="${fixedDepositTermSchemeInstance.products}" status="i" var="product">
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
      			<li><g:link class="list" action="index">Fixed Deposit Term Scheme List</g:link></li>
      			<li><g:link class="create" action="create">New Fixed Deposit Term Scheme</g:link></li>
                <li><button disabled="disabled">View Fixed Deposit Term Scheme</button></li>
                <li><g:link action="edit" controller="FixedDepositTermScheme" id="${fixedDepositTermSchemeInstance.id}">Update Fixed Deposit Term Scheme</g:link></li>

                <g:if test="${fixedDepositTermSchemeInstance.status.id == 1}">
                    <li><g:form id="activatefixedDepositTermSchemeForm" url="[id:fixedDepositTermSchemeInstance.id, action:'activate']" method="POST">
                        </g:form>
                        <g:actionSubmit id="activatefixedDepositTermScheme" action="activate" value="Activate" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />    
                    </li>
                </g:if>

                <g:if test="${fixedDepositTermSchemeInstance.status.id.toInteger() in [1, 2]}">
                    <li><g:form id="deletefixedDepositTermSchemeForm" url="[id:fixedDepositTermSchemeInstance.id, action:'delete']" method="POST">
                        </g:form>
                        <g:actionSubmit id="deletefixedDepositTermScheme" action="delete" value="Delete" onclick="
                            alertify.confirm(AppTitle,'Are you sure you want to delete?',
                                function(){
                                    checkIfAllowed('CFG01504', 'form#deletefixedDepositTermSchemeForm', 'Override new fixed deposit term scheme form.', null); 
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
                        //$( "#deletefixedDepositTermScheme" ).click(function() {
                        //         checkIfAllowed('CFG01504', 'form#deletefixedDepositTermSchemeForm', 'Override new fixed deposit term scheme form.', null); // params: policyTemplate.code, form to be saved
                        //});
                        $( "#activatefixedDepositTermScheme" ).click(function() {
                                 checkIfAllowed('CFG01503', 'form#activatefixedDepositTermSchemeForm', 'Override new fixed deposit term scheme form.', null); // params: policyTemplate.code, form to be saved
                        });
                    }); 
                </script>
            </content>
	</body>
</html>
