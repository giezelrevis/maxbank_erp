<legend>Loan Applications</legend>

<div class="table-responsive">
	<table class="table table-hover table-condensed table-bordered table-striped">
	    <tbody>
			<tr>
				<td><label>ID</label></td>
				<td><label>Customer</label></td>
				<td><label>Product</label></td>
				<td><label>Amount</label></td>
				<td><label>Application Date</label></td>	
				<td class="col-sm-2"><label>Action</label></td>
			</tr>
		</tbody>
		<tbody>
			<g:each var="loanApplication" in="${collateralInstance?.loanApplications.sort{it.id}}">
			<tr>
				<td>${loanApplication?.id}</td>
				<td>${loanApplication?.customer?.displayName}</td>
				<td>${loanApplication?.product?.name}</td>                                
				<td><g:formatNumber format="###,###,##0.00" number="${loanApplication?.amount}"/></td>
				<td><g:formatDate format="MM/dd/yyyy" date="${loanApplication?.applicationDate}"/></td>
				<td><g:link class="btn btn-secondary" controller="loanApplication" action="show" id="${loanApplication?.id}">View</g:link></td>
			</tr>
			</g:each>
		</tbody>
	</table>
</div>
