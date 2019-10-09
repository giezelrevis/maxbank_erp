
<legend>Other Charges</legend>

<div class="table-responsive">
    <table class="table table-hover table-condensed table-bordered table-striped">
	    <tbody>
			<tr>
				<td><label>Scheme</label></td>
				<td><label>Type</label></td>
				<td><label>Amount</label></td>
			</tr>
		</tbody>
		<tbody>
                        <g:set var="x" value="${0}" />
			<g:each var="serviceCharge" in="${loanInstance?.serviceCharges.sort{it.scheme.id}}">
			<tr>
				<g:set var="type" value="${serviceCharge?.scheme?.type.id}" />
				<td>${serviceCharge?.scheme?.name}</td>
				<td>${serviceCharge?.scheme?.type?.description}</td>
				<td><g:formatNumber format="###,##0.00" number="${serviceCharge?.amount}" /></td>
			</tr>
                        <g:set var="x" value="${x + serviceCharge?.amount}" />
			</g:each>
                        <tr>
				<td><label>TOTAL</label></td>
				<td></td>
				<td align="right"><g:formatNumber format="###,##0.00" number="${x}" /></td>
			</tr>
		</tbody>
	</table>
</div>