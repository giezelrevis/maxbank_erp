<%@ page import="icbs.loans.LoanApplication" %>

<legend>Deductions</legend>

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
			<g:each var="deduction" in="${loanInstance?.loanDeductions.sort{it.scheme.id}}">
			<tr>
				<g:set var="type" value="${deduction?.scheme?.type.id}" />
				<td>${deduction?.scheme?.name}</td>
				<td>${deduction?.scheme?.type?.description}</td>
				<td align="right"><g:formatNumber format="###,##0.00" number="${deduction?.amount}" /></td>
			</tr>
              
			</g:each>
		</tbody>
                <br><br>
                
                                        <tbody>        
                        <tr>
                                <td><label>TOTAL DEDUCTION AMOUNT</label>
                                <td><label></label>
                                <td align="right"><label><g:formatNumber format="###,##0.00" number="${totalDeductions}" /></label></td>
                        </tr>            
                                                </tbody> 
                
                
	</table>
                        
</div>