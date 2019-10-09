<%@ page import="icbs.loans.LoanApplication" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loanApplication.label', default: 'LoanApplication')}" />
		<title>Update Loan Specification</title>
		<g:javascript>
			function updateCustomerInfoAjax(params) {
                $.ajax({
				    type: 'POST',
				    data: {id:params.customer2},
				    url: "${createLink(controller :'customer', action:'showBasicCustomerInfoAjax')}",
				    success: function(msg){						
						$('#customer-name').val($(msg).find('#display-name').html());
						$('#customer').val(params.customer2);
						$('#birth-date').html($(msg).find('#birth-date').html())
						$('#address').html($(msg).find('#address').html())
						$('#photo').html($(msg).find('#photo').html())
				    },
				    error:function(XMLHttpRequest,textStatus,errorThrown){
                		alert(XMLHttpRequest+textStatus+errorThrown);
            		}
				});
            }

            function showCustomerSearch() {
                modal = new icbs.UI.Modal({id:"customerDetailsModal", url:"${createLink(controller: 'search', action:'search')}", title:"Search Customer", onCloseCallback:updateCustomerInfoAjax});
                modal.show();
            }

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

        	icbs.Dependencies.Ajax.addLoadEvent(function(){
            	updateCustomerInfoAjax({customer2:"${loanApplicationInstance?.customer?.id}"});
            });
   		</g:javascript>
	</head>
	<body>
        <content tag="main-content">
		<div id="edit-loanApplication" class="content scaffold-edit" role="main">
			<g:if test="${flash.message}">
                <div class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div>
            </g:if>
			<g:hasErrors bean="${loanApplicationInstance}">
	            <div class="box-body">
	                <div class="alert alert-danger alert-dismissable">
	                    <i class="fa fa-ban"></i>
	                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	                    <b>Alert!</b> 
	                    <ul class="errors" role="alert">
	                        There are errors
	                    </ul>            
	                </div>
	            </div>
            </g:hasErrors>
			<g:form url="[resource:loanApplicationInstance, action:'updateSpecification']" method="PUT" class="form-horizontal">
				<g:hiddenField name="version" value="${loanApplicationInstance?.version}" />
				
                <fieldset class="form">
					<g:render template="specification"/>
				</fieldset>

				<div class="form-group form-buttons">
					<g:actionSubmit class="btn btn-primary" action="updateSpecification" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</div>
			</g:form>

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
		</div>
        </content>
        <content tag="main-actions">
            <ul>
                <li><g:link class="list" action="index">Loan Application List</g:link></li>
                <li><g:link class="create" action="create">New Loan Application</g:link></li>
                <li><g:link action="show" id="${loanApplicationInstance.id}">View Loan Application</g:link></li>
                <li><g:link action="showDetails" id="${loanApplicationInstance.id}">View More Details</g:link></li>
                <li><button disabled="disabled">Update Loan Specification</button></li>
                <li><g:link action="editFinancialDetails" resource="${loanApplicationInstance}">Update Financial Details</g:link></li>
                <li><g:link action="editComakers" resource="${loanApplicationInstance}">Update Co-makers</g:link></li>
                <li><g:link action="showCollaterals" resource="${loanApplicationInstance}">Collaterals</g:link></li>
                <li><a href="#" onclick="showUpdateStatus()">Update Status</a></li>
                <%--<li><g:link action="createTemplate" resource="${loanApplicationInstance}">Loan Application Template</g:link>--%>
            </ul>
        </content>
	</body>
</html>
