
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>Bulk Data Processing</title>
	</head>
	<body>
    <content tag="main-content">   
		<div  class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
                        
			<div class="table-responsive">
            <table class="table table-bordered table-rounded table-striped table-hover">
				<thead>
					<tr>
						<th>Date Set</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>Customer Information</td>
						<td align="center"><g:link action="cif" class="btn btn-primary">Export</g:link></td>
					</tr>
					<tr>
						<td>Deposits</td>
						<td align="center"><g:link action="deposit" class="btn btn-primary">Export</g:link></td>
					</tr>
					<tr>
						<td>Loans Accounts</td>
						<td align="center"><g:link action="loanAccount" class="btn btn-primary">Export</g:link></td>
					</tr>
					<tr>
						<td>General Ledger Trial Balance</td>
						<td align="center"><g:link action="" class="btn btn-primary">Export</g:link></td>
					</tr>
					<tr>
						<td>General Ledger Transactions</td>
						<td align="center"><g:link action="" class="btn btn-primary">Export</g:link></td>
					</tr>
					<tr>
						<td>DepEd Collection File Processing</td>
						<td align="center"><g:link action="depEdCollectionProcessing" class="btn btn-primary">Process</g:link></td>
					</tr> 
					<tr>
						<td>Loan Collection File Processing</td>
						<td align="center"><g:link action="loanCollectionProcessing" class="btn btn-primary">Process</g:link></td>
					</tr>
					<tr>
						<td>Loan Collection Mixed Batch - Debit Deposit Account</td>
						<td align="center"><g:link action="loanCollMixedBatch" class="btn btn-primary">Process</g:link></td>
					</tr>                                        
					<tr>
						<td>Import General Ledger Transactions</td>
						<td align="center"><g:link action="importGlTransactions" class="btn btn-primary">Process</g:link></td>
					</tr> 
					<tr>
						<td>Import Deposit Account Debit/Credit List</td>
						<td align="center"><g:link action="importDepositList" class="btn btn-primary">Process</g:link></td>
					</tr>                                         
				</tbody>
			</table>
                     </div>
			
		</div>
    </content>
    <content tag="main-actions">
        <ul>
		</ul>
    </content>
	</body>
</html>
