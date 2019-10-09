
<%@ page import="icbs.loans.LoanApplication" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loanApplication.label', default: 'LoanApplication')}" />
		<title>Show Financial Details</title>
		<g:javascript>
			function updateStatusAjax() {
				$.ajax({
				    type: 'POST',
				    data: $('#update-status-form').serialize(),
				    url: "${createLink(controller :'loanApplication', action:'updateStatusAjax')}",
				    success: function(msg){
				    	jQuery('#update-status-modal .modal-body').html(msg);
				    },
				    error:function(XMLHttpRequest,textStatus,errorThrown){
                		alert(XMLHttpRequest+textStatus+errorThrown);
            		}
				});
            }

			function showUpdateStatus() {
				modal = new icbs.UI.Modal({id:"update-status-modal", url:"${createLink(controller :'loanApplication', action:'showUpdateStatusAjax', params:[id:loanApplicationInstance.id])}", title:"Update Status", onCloseCallback:updateStatusAjax});		    	
                modal.show();
            }       
		</g:javascript>
	</head>
	<body>
        <content tag="main-content">   
		<div id="show-loanApplication" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
                <div class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div>
            </g:if>

			<g:render template="showFinancialDetails"/>

			<div class="modal" id="update-status-modal">
				<div class="modal-dialog">
		            <div class="modal-content">
		                <div class="modal-header">
		                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		                    <h4 class="modal-title">Update Status</h4>
		                </div>
		                <div class="modal-body">
		                </div>
		                <div class="modal-footer">
		                    <a href="#" data-dismiss="modal" class="btn">Close</a>
		                    <a href="#" class="btn btn-primary"onclick="updateStatusAjax()">Save changes</a>
		                </div>
		            </div>
		        </div>
		    </div>
			
			<!--<g:form url="[resource:loanApplicationInstance, action:'delete']" method="DELETE">
				<div class="form-group form-buttons">
					
					<g:actionSubmit class="btn" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</div>
			</g:form>-->
		</div>
        </content>
			<content tag="main-actions">
			<ul>                    
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link action="show" id="${loanApplicationInstance.id}">View Loan Application</g:link></li>
                <li><g:link action="showDetails" id="${loanApplicationInstance.id}">View More Details</g:link></li>
                <li><g:link action="editSpecification" resource="${loanApplicationInstance}">Update Loan Specification</g:link></li>
                <li><g:link action="editFinancialDetails" resource="${loanApplicationInstance}">Update Financial Details</g:link></li>
                <li><g:link action="editComakers" resource="${loanApplicationInstance}">Update Co-makers</g:link></li>
                <li><a href="#" onclick="showUpdateStatus()">Update Status</a></li>
			</ul>
		</content>
	</body>
</html>
