
<%@ page import="icbs.loans.Loan" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loan.label', default: 'Loan')}" />
		<title>Collaterals</title>
		<g:javascript>
			/*function updateDeductionFormAjax() {
                $.ajax({
				    type: 'POST',
				    data: {id:$('#deductionScheme').val()},
				    url: "${createLink(controller :'loan', action:'getDeductionSchemeInfoAjax')}",
				    success: function(msg){						    	
						var type = $(msg).find('#type').html();
						var rate = $(msg).find('#rate').html();
						var amount = $(msg).find('#amount').html();

						if (type == 1) {
							document.getElementById('deduction-rate-form-group').style.display = 'none';
							document.getElementById('deduction-amount-form-group').style.display = 'block';

							$('#deductionRate').val('');
							$('#deductionAmount').val(amount);
						} else if (type == 2) {								
							document.getElementById('deduction-rate-form-group').style.display = 'block';
							document.getElementById('deduction-amount-form-group').style.display = 'none';
							
							$('#deductionRate').val(rate);
							$('#deductionAmount').val('');
						} else {
							document.getElementById('deduction-rate-form-group').style.display = 'none';
							document.getElementById('deduction-amount-form-group').style.display = 'block';

							$('#deductionRate').val('');
							$('#deductionAmount').val('');
						}						
				    },
				    error:function(XMLHttpRequest,textStatus,errorThrown){
                		alert(XMLHttpRequest+textStatus+errorThrown);
            		}
				});
            }

			function showAddDeduction() {
				$('#add-deduction-modal').modal({show:true});
            }*/          
		</g:javascript>
	</head>
	<body>
        <content tag="main-content">   
		<div id="show-loan" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
                <div class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div>
            </g:if>
            <g:form url="[controller:loanApplication, id:"${loanApplicationInstance?.id}", action:'showCollaterals']" name="list-form">
            	<div class="row">
				    <div class="col-md-12">
				        <div class="col-md-2">
				             <g:select name="max" value="${params.max}" from="[5, 10, 15, 20]" class="form-control input-sm" onchange="this.form.submit()" />
				        </div>
				        <div class="input-group col-md-10">
				            <g:textField  type="text" name="query" class="form-control" placeholder="Collateral ID"/>
		                	<div class="input-group-btn">
		                    	<g:submitButton name="Search" class="btn btn-primary"></g:submitButton>
		                	</div>
				        </div>
				    </div>
				</div>				
            </g:form>
            <br />
			<div class="table-responsive">
                <table class="table table-hover table-condensed table-bordered table-striped">
                    <thead>
						<tr>
						<g:sortableColumn property="id" title="ID" />				
						<g:sortableColumn property="collateralType" title="Type" />
						<g:sortableColumn property="estimatedValue" title="Estimated Value" />				
						<g:sortableColumn property="status" title="Status" />				
						<td><label>Action</label></td>				
						</tr>
					</thead>
					<tbody>
						<g:each in="${collaterals}" status="i" var="collateral">
							<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">	
								<td>${collateral?.id}</td>
								<td>${collateral?.collateralType?.description}</td>				
								<td>${collateral?.estimatedValue}</td>		
								<td>${collateral?.status?.description}</td>
								<td><g:link class="btn btn-secondary" action="showCollateral" id="${collateral?.id}" params="[loanApplication:"${loanApplicationInstance?.id}"]">View</g:link>
							</tr>
						</g:each>
					</tbody>
				</table>			
			</div>
			<div>
				<g:paginate total="${count ?: 0}" params="${params}"/>
			</div>			

			<div class="form-group form-buttons">				
				<g:link class="btn btn-primary" action="createCollateral" params="[loanApplication:"${loanApplicationInstance?.id}"]">Add Collateral</g:link>
				<%--<a href="#" class="btn btn-primary" onclick="showAddDeduction();">Add Deduction</a>--%>
			</div>
		</div>
        </content>
        <content tag="main-actions">
            <ul>
                <li><g:link class="list" action="index">Loan Application List</g:link></li>
                <li><g:link class="create" action="create">New Loan Application</g:link></li>
                <li><g:link action="show" id="${loanApplicationInstance.id}">View Loan Application</g:link></li>
                <li><g:link action="showDetails" id="${loanApplicationInstance.id}">View More Details</g:link></li>
                <li><g:link action="editSpecification" resource="${loanApplicationInstance}">Update Loan Specification</g:link></li>
                <li><g:link action="editFinancialDetails" resource="${loanApplicationInstance}">Update Financial Details</g:link></li>
                <li><g:link action="editComakers" resource="${loanApplicationInstance}">Update Co-makers</g:link></li>
                <li><button disabled="disabled">Collaterals</button></li>
                <li><a href="#" onclick="showUpdateStatus()">Update Status</a></li>
			</ul>			
        </content>
	</body>
</html>
