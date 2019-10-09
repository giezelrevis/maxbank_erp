<%@ page import="icbs.loans.LoanLedger" %>

<legend>Transactions</legend>

<div class="table-responsive">
    <table class="table table-hover table-condensed table-bordered table-striped">
        <tbody>
			<tr>
				<td><label>ID</label></td>
				<td><label>Date</label></td>				
                                <td><label>Type</label></td>
				<td><label>Code</label></td>
				<td><label>Reference</label></td>
                                <td><label>Particulars</label></td>
                                <td><label>Action</label></td>
			</tr>
		</tbody>
		<tbody>
		<g:each in="${LoanLedger.findAllByLoan(loanInstance).sort{it.id}}" var="loanLedgerInstance">
			<tr>
				<td>${loanLedgerInstance?.id}</td>
                                <td><g:formatDate format="MM/dd/yyyy" date="${loanLedgerInstance?.txnDate}"/></td>
				<td>${loanLedgerInstance?.txnType?.description}</td>
				<td>${loanLedgerInstance?.txnTemplate?.description}</td>
				<td>${loanLedgerInstance?.txnRef}</td>
                                <td>${loanLedgerInstance?.txnParticulars}</td>				
				<td><g:link class="btn btn-secondary" controller="loanAdjustment" action="show" id="${loanLedgerInstance?.id}">View</g:link></td>
			</tr>
		</g:each>
		</tbody>
	</table>
</div>
			