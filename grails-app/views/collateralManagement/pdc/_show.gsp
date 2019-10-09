
<legend>Post Dated Checks</legend>

<div class="table-responsive">
    <table class="table table-hover table-condensed table-bordered table-striped">
	    <tbody>
			<tr>
				<td><label>Account No</label></td>
				<td><label>Check No</label></td>
				<td><label>Amount</label></td>		
	            <td><label>Bank</label></td>
	            <td><label>On Us</label></td>
	            <td><label>Date</label></td>
			</tr>
		</tbody>
		<tbody>
			<g:each var="pdc" in="${collateralInstance?.pdcs.sort{it.accountNo}}">
			<tr>
				<td>${pdc?.accountNo}</td>
				<td>${pdc?.checkNo}</td>
				<td><g:formatNumber format="###,###,##0.00" number="${pdc?.amount}"/></td>
                <td>${pdc?.bank}</td>
                <td><g:formatBoolean boolean="${pdc?.onUs}" /></td>
                <td><g:formatDate format="MM/dd/yyyy" date="${pdc?.pdcDate}"/></td>
			</tr>
			</g:each>
		</tbody>
                
                
	</table>
</div>