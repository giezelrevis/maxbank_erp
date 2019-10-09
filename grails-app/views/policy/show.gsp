
<%@ page import="icbs.admin.Policy" %>
<!DOCTYPE html>
<html>
    <head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'policy.label', default: 'Policy')}" />
		<title>Policy Information</title>
    </head>
    <body>
	<content tag="breadcrumbs">
            <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/policy')}">Policy Management</a>
            <span class="fa fa-chevron-right"></span><span class="current">Policy Information</span>
	</content>

	<content tag="main-content">   
            <div id="show-policy" class="content scaffold-show" role="main">
		<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
		</g:if>

                <div class="nav-tab-container">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab_1" data-toggle="tab">Policy Details</a></li>
                        <g:if test="${policyInstance.policyTemplate.type.toString() == 'TXN'}">
                            <li id="txntab"><a href="#tab_2" data-toggle="tab">Transactions</a></li>
                        </g:if>
                        <li><a href="#tab_3" data-toggle="tab">Roles</a></li>
                        <li><a href="#tab_4" data-toggle="tab">Approvers</a></li>
                    </ul>
                </div>

                <div class="tab-content">
                    <div class="tab-pane active fade in" id="tab_1">
                        <table class="table table-bordered table-rounded table-striped table-hover">
                            <tbody>
                                <tr>
                                    <td><label>Policy Template</label></td>
                                    <td>${policyInstance?.policyTemplate?.description}</td>
                                </tr>       
                                <tr>
                                    <td><label>Policy Description</label></td>
                                    <td>${policyInstance?.description}</td>
                                </tr>  
                                <tr>
                                    <td><label>Amount Condition (Transaction)</label></td>
                                    <td><g:formatNumber format="###,###,##0.00" number="${policyInstance?.txnAmtCondition}"/></td>
                                </tr>   
                                <tr>
                                    <td><label>Policy Action</label></td>
                                    <td>${policyInstance?.policyAction?.description}</td>
                                </tr> 
                                <tr>
                                    <td><label>Reference</label></td>
                                    <td>${policyInstance?.reference}</td>
                                </tr> 
                                <tr>
                                    <td><label>Status</label></td>
                                    <td>${policyInstance?.configItemStatus?.description}</td>
                                </tr> 
                            </tbody>
                        </table>
                    </div>

                    <div class="tab-pane fade in" id="tab_2">
                        <table class="table table-bordered table-rounded table-striped table-hover">
                            <tbody>
                                <g:each in="${policyInstance.txnTemplates}" var="txnTemplate" >
                                    <tr>
                                        <td>${txnTemplate.description}</td>
                                    </tr>    
                                </g:each>
                            </tbody>
                        </table>
                    </div>

                    <div class="tab-pane fade in" id="tab_3">
                        <table class="table table-bordered table-rounded table-striped table-hover">
                            <tbody>
                                <g:each in="${policyInstance.roles}" var="role" >
                                    <tr>
                                        <td>${role.name}</td>
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>

                    <div class="tab-pane fade in" id="tab_4">
                        <table class="table table-bordered table-rounded table-striped table-hover">
                            <tbody>                        
				<g:each in="${policyInstance.approvers}" var="approver" >
                                    <tr><td>${approver.name}</td></tr>
				</g:each>
                            </tbody>
                        </table>
                    </div>

		</div>

		<g:form id="remove" url="[resource:policyInstance, action:'delete']" method="DELETE">
		</g:form>
            </div>
        </content>
        <content tag="main-actions">
                <ul>
                	<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
                	<!-- <li><g:link class="edit" action="edit" resource="${policyInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link></li>
                	<li><g:actionSubmit id="deletePolicy"  resource="${policyInstance}" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" /></li> -->
                        <g:if test="${policyInstance?.configItemStatus?.id == 1 || policyInstance?.configItemStatus?.id == 2}">
                            <li><g:actionSubmit id="deletePolicy" form="show" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="
                            alertify.confirm(AppTitle,'Are you sure you want to delete?',
                                function(){
                                    checkIfAllowed('ADM00404', 'form#remove', 'Remove policy.', null);
                                },
                                function(){
                                    return;
                                });                                       
                                " /></li>
                        </g:if>    
                </ul>
                <!--
                <script type="text/javascript">
                    $(document).ready(function() {
                           $( "#deletePolicy" ).click(function() {
                              checkIfAllowed('ADM00404', 'form#remove', 'Remove holiday.', null); // params: policyTemplate.code, form to be saved
                           });
                    });
                </script>
                -->
        </content>
    </body>
</html>
