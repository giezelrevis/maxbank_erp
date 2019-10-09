
<legend>Loan Applications</legend>

<div class="form-group form-buttons">
	<button id="add-button" type="button" onclick="showLoanApplicationSearch()" class="btn btn-primary multi-field-btn-add"><span class="fa fa-plus"></span> Add Loan Application</button>
</div>

<div class="table-responsive">
    <table class="table table-hover table-condensed table-bordered table-striped">
    <tbody>
		<tr>
			<td><label>ID</label></td>
			<td><label>Customer</label></td>
			<td><label>Product</label></td>
			<td><label>Amount</label></td>
			<td><label>Application Date</label></td>
			<td class="col-sm-2"><label>Actions</label></td>		
		</tr>
	</tbody>
	<tbody>
		<g:if test="${collateralInstance?.loanApplications}">
			<g:each var="loanApplication" in="${collateralInstance?.loanApplications.sort{it.id}}">
				<tr>
					<td>${loanApplication?.id}</td>
					<td>${loanApplication?.customer?.displayName}</td>
					<td>${loanApplication?.product?.name}</td>
					<td>${loanApplication?.amount}</td>
					<td><g:formatDate format="MM/dd/yyyy" date="${loanApplication?.applicationDate}"/></td>
					<td><g:link class="btn btn-secondary" controller="loanApplication" action="show" id="${loanApplication?.id}">View</g:link> 
					<a href="#" class="btn btn-secondary" onclick="deleteLoanApplicationAjax('${loanApplication?.id}')">Remove</a></td>
				</tr>
			</g:each>
		</g:if>		
		<g:elseif test="${session["loanApplications"]}">
			<g:set var="i" value="${0}" />
			<g:each var="loanApplication" in="${session["loanApplications"]}">
				<%
					if (!loanApplication.isAttached())
						loanApplication.attach()
				%>
				<tr>
					<td>${loanApplication?.id}</td>
					<td>${loanApplication?.customer?.displayName}</td>
					<td>${loanApplication?.product?.name}</td>
					<td>${loanApplication?.amount}</td>
					<td><g:formatDate format="MM/dd/yyyy" date="${loanApplication?.applicationDate}"/></td>
					<td><g:link class="btn btn-secondary" controller="loanApplication" action="show" id="${loanApplication?.id}">View</g:link> 
					<a href="#" class="btn btn-secondary" onclick="deleteLoanApplicationAjax('${i}')">Remove</a></td>
				</tr>
				<g:set var="i" value="${i = i + 1}" />
			</g:each>		
		</g:elseif>
	</tbody>
	</table>
</div>
