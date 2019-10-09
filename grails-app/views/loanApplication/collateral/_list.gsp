<legend>Collateral</legend>

<div class="form-group form-buttons">
	<button id="add-button" type="button" onclick="showCollateralSearch()" class="btn btn-primary multi-field-btn-add"><span class="fa fa-plus"></span> Add Collateral</button>
</div>

<div class="table-responsive">
    <table class="table table-hover table-condensed table-bordered table-striped">
    <tbody>
		<tr>
			<td><label>ID</label></td>
			<td><label>Type</label></td>
			<td><label>Appraised Value</label></td>		
			<td><label>Status</label></td>		
			<td class="col-sm-2"><label>Actions</label></td>		
		</tr>
	</tbody>
	<tbody>
		<g:if test="${loanApplicationInstance?.collaterals}">
			<g:each var="collateral" in="${loanApplicationInstance?.collaterals.sort{it.id}}">
				<tr>
					<td>${collateral?.id}</td>
					<td>${collateral?.collateralType?.description}</td>
					<td><g:formatNumber format="###,##0.00" number="${collateral?.appraisedValue}" /></td>		
					<td>${collateral?.status?.description}</td>	
					<td><g:link class="btn btn-secondary" controller="collateralManagement" action="show" id="${collateral?.id}">View</g:link> 
					<a href="#" class="btn btn-secondary" onclick="deleteCollateralAjax('${collateral?.id}')">Remove</a>
					</td>		
				</tr>
			</g:each>
		</g:if>
		<g:elseif test="${session["collaterals"]}">
			<g:set var="i" value="${0}" />
			<g:each var="collateral" in="${session["collaterals"]}">
				<%
					if (!collateral.isAttached())
						collateral.attach()
				%>
				<tr>
					<td>${collateral?.id}</td>
					<td>${collateral?.collateralType?.description}</td>
					<td>${collateral?.appraisedValue}</td>		
					<td>${collateral?.status?.description}</td> 
					<td><g:link class="btn btn-secondary" controller="collateralManagement" action="show" id="${collateral?.id}">View</g:link> 
					<a href="#" class="btn btn-secondary" onclick="deleteCollateralAjax('${i}')">Remove</a>
					</td>		
				</tr>
				<g:set var="i" value="${i = i + 1}" />
			</g:each>		
		</g:elseif>
	</tbody>
	</table>
</div>


