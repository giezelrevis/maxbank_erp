<%@ page import="icbs.loans.LoanLedger" %>
<legend>Missed Installments</legend>

<div class="table-responsive">
    <table class="table table-hover table-condensed table-bordered table-striped">
	    <tbody>
			<tr>
				<td><label>No.</label></td>
				<td><label>Installment Date</label></td>
				<td><label>Principal</label></td>
				<td><label>Interest</label></td>
				<!-- <td><label>Penalty</label></td> -->
				<td><label>Service Charge</label></td>
			</tr>
		</tbody>
		<tbody>
			<g:each var="installment" in="${loanInstance?.loanInstallments.findAll{it.status.id == 3L || it.status.id == 4L}.sort{it.sequenceNo}}">
			<tr>
				<td>${installment?.sequenceNo}</td>
				<td><g:formatDate format="MM-dd-yyyy" date="${installment?.installmentDate}"/></td>				
				<td align="right"><g:formatNumber format="###,##0.00" number="${installment?.principalInstallmentAmount - installment?.principalInstallmentPaid}" /></td>			
				<td align="right"><g:formatNumber format="###,##0.00" number="${installment?.interestInstallmentAmount - installment?.interestInstallmentPaid}" /></td>
				<!-- <td align="right"><g:formatNumber format="###,##0.00" number="${installment?.penaltyInstallmentAmount - installment?.penaltyInstallmentPaid}" /></td> -->
				<td align="right"><g:formatNumber format="###,##0.00" number="${installment?.serviceChargeInstallmentAmount - installment?.serviceChargeInstallmentPaid}" /></td>								
			</tr>
                        </g:each>
                        <tr>
                        <g:each var="totalpri" in="${loanInstance?.loanInstallments.findAll{it.status.id == 3L || it.status.id == 4L}.sum{it.principalInstallmentAmount}}">
                        <g:each var="totalpripd" in="${loanInstance?.loanInstallments.findAll{it.status.id == 3L || it.status.id == 4L}.sum{it.principalInstallmentPaid}}">
                        <g:each var="totalint" in="${loanInstance?.loanInstallments.findAll{it.status.id == 3L || it.status.id == 4L}.sum{it.interestInstallmentAmount}}"> 
                        <g:each var="totalintpd" in="${loanInstance?.loanInstallments.findAll{it.status.id == 3L || it.status.id == 4L}.sum{it.interestInstallmentPaid}}">
                        <g:each var="totalpen" in="${loanInstance?.loanInstallments.findAll{it.status.id == 3L || it.status.id == 4L}.sum{it.penaltyInstallmentAmount}}">
                        <g:each var="totalpenpd" in="${loanInstance?.loanInstallments.findAll{it.status.id == 3L || it.status.id == 4L}.sum{it.penaltyInstallmentPaid}}">
                        <g:each var="totalser" in="${loanInstance?.loanInstallments.findAll{it.status.id == 3L || it.status.id == 4L}.sum{it.serviceChargeInstallmentAmount}}">
                        <g:each var="totalserpd" in="${loanInstance?.loanInstallments.findAll{it.status.id == 3L || it.status.id == 4L}.sum{it.serviceChargeInstallmentPaid}}">
                                <td></td>
                                <td></td>
                                <td align="right"><label><g:formatNumber format="###,##0.00" number="${totalpri - totalpripd}" /></label></td>
                                <td align="right"><label><g:formatNumber format="###,##0.00" number="${totalint - totalintpd}" /></label></td>
                                <!-- <td align="right"><label><g:formatNumber format="###,##0.00" number="${totalpen - totalpenpd}" /></label></td> -->
                                <td align="right"><label><g:formatNumber format="###,##0.00" number="${totalser - totalserpd}" /></label></td>
                      
                        </tr>
                        </g:each>
                        </g:each>
                        </g:each>
                        </g:each>
                        </g:each>   
			</g:each>
                        </g:each>
                        </g:each>
		</tbody>
	</table>
</div>


<legend>Loan Outstanding Balance</legend>

<div class="table-responsive">
    <table class="table table-hover table-condensed table-bordered table-striped">
	    <thead>
			<tr>
			
				<td><label>Principal</label></td>
				<td><label>Interest</label></td>
				<td><label>Penalty</label></td>
				<td><label>Service Charge</label></td>
                                <td><label>TOTAL</label></td>
			</tr>
		</thead>
		<tbody>
			<tr>
				
				<td align="right"><label><g:formatNumber format="###,##0.00" number="${loanInstance?.balanceAmount}"/></label></td>
				<td align="right"><label><g:formatNumber format="###,##0.00" number="${loanInstance?.interestBalanceAmount}"/></label></td>
				<td align="right"><label><g:formatNumber format="###,##0.00" number="${loanInstance?.penaltyBalanceAmount}"/></label></td>				
				<td align="right"><label><g:formatNumber format="###,##0.00" number="${loanInstance?.serviceChargeBalanceAmount}"/></label></td>
                                <td align="right"><label><g:formatNumber format="###,##0.00" number="${loanInstance?.balanceAmount + loanInstance?.interestBalanceAmount + loanInstance?.penaltyBalanceAmount + loanInstance?.serviceChargeBalanceAmount}"/></label></td>    
                        </tr>
		</tbody>
                
	</table>
    <table class="table table-hover table-condensed table-bordered table-striped">
        <tbody>
            <tr>
                <td><label>Principal Amount Due</label></td>
                <td align="right"><g:formatNumber format="###,##0.00" number="${loanInstance?.overduePrincipalBalance}" /></td>
            </tr>
            <tr>
                <td><label>Total Amount Due</label></td>
                <td align="right"><g:formatNumber format="###,##0.00" number="${loanInstance?.overduePrincipalBalance + loanInstance?.interestBalanceAmount + loanInstance?.penaltyBalanceAmount + loanInstance?.serviceChargeBalanceAmount}" /></td>
            </tr> 
            <tr>
                <td><label>Accrued Interest Balance to Date</label></td>
                <td align="right">
                    <g:if test="${loanInstance?.numInstallments == 1}">
                        <g:formatNumber format="###,##0.00" number="${loanInstance?.interestBalanceAmount}" />
                    </g:if>
                    <g:else>
                        <g:formatNumber format="###,##0.00" number="${intToDate}" />
                    </g:else>
                </td>
            </tr>        
        </tbody>    
    </table>    
</div>
