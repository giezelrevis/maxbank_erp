<legend>Collateral</legend>

<div class="table-responsive">
	<table class="table table-hover table-condensed table-bordered table-striped">
	    <tbody>
			<tr>
				<td><label>ID</label></td>
				<td><label>Type</label></td>
				<td><label>Appraised Value</label></td>		
				<td><label>Status</label></td>					
				<td class="col-sm-2"><label>Action</label></td>
			</tr>
		</tbody>
		<tbody>
			<g:each var="collateral" in="${loanApplicationInstance?.collaterals.sort{it.id}}">
			<tr>
				<td>${collateral?.id}</td>
				<td>${collateral?.collateralType?.description}</td>
				<<td><g:formatNumber format="###,##0.00" number="${collateral?.appraisedValue}" /></td>		
				<td>${collateral?.status?.description}</td>
				<td><g:link class="btn btn-secondary" controller="collateralManagement" action="show" id="${collateral?.id}">View</g:link> 
			</tr>
			</g:each>
		</tbody>
	</table>
</div>
