
<legend>Sweep Accounts</legend>

<div class="table-responsive">
    <table class="table table-hover table-condensed table-bordered table-striped">
	    <tbody>
			<tr>
				<td><label>Account No.</label></td>			
				<td><label>Fund Limit</label></td>		
				<td><label>Remarks</label></td>
				<td><label>Order</label></td>				
			</tr>
		</tbody>
		<tbody>
			<g:each var="sweepAccounts" in="${loanInstance?.sweepAccounts}">
			<tr>
				<td>${sweepAccounts?.depositAccount?.acctNo}</td>
				<td>${sweepAccounts?.rule?.description}</td>
				<td>${sweepAccounts?.remarks} %</td>						
				<td>${sweepAccounts?.ordinalNum}</td>
			</tr>
			</g:each>
		</tbody>
	</table>
</div>