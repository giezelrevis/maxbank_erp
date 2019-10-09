<legend>Loan History</legend>

<div class="table-responsive">
    <table class="table table-hover table-condensed table-bordered table-striped">
        <tbody>
			<tr>
				<td><label>Date Modified</label></td>
				<td><label>Activity</label></td>
				<td><label>Product</label></td>
				<td><label>Amount</label></td>
                                <td><label>Loan Performance ID</label></td>
				<td><label>Interest Rate</label></td>
				<td><label>Opening Date</label></td>
				<td><label>Maturity Date</label></td>				
				<td><label>Action</label></td>
			</tr>
		</tbody>
		<tbody>
		<g:each in="${loanHistoryList}" status="i" var="loanHistoryInstance">
			<tr>
				<td><g:formatDate format="MM/dd/yyyy" date="${loanHistoryInstance?.dateModified}"/></td>
			
				<td>${loanHistoryInstance?.activity}</td>

				<td>${loanHistoryInstance?.product?.name}</td>
			
				<td align="right"><g:formatNumber format="###,##0.00" number="${loanHistoryInstance.grantedAmount}" /></td>

                                <td>${loanHistoryInstance?.loanPerformanceId} %</td>
                                
                                <td>${loanHistoryInstance?.interestRate} %</td>
                               
				<td><g:formatDate format="MM/dd/yyyy" date="${loanHistoryInstance?.openingDate}"/></td>

				<td><g:formatDate format="MM/dd/yyyy" date="${loanHistoryInstance?.maturityDate}"/></td>
			
				<td><g:link class="btn btn-secondary" action="showHistory" params="[id:loanInstance.id, history:loanHistoryInstance.id]">View</g:link></td>
			</tr>
		</g:each>
		</tbody>
	</table>
</div>
			