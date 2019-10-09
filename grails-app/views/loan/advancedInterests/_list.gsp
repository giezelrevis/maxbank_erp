<%@ page import="icbs.loans.LoanEIRSchedule" %>

<legend>UID</legend>

<div class="table-responsive">
    <table class="table table-hover table-condensed table-bordered table-striped">
	    <tbody>
			<tr>
				<td><label>No.</label></td>
				<td><label>Date</label></td>							
				<td ><label>Amount</label></td>
			</tr>
		</tbody>
		<tbody>
			<g:each var="eirSchedule" status="i" in="${loanInstance?.loanEIRSchedules?.sort{it.transferDate}}">
			<tr>
				<td>${i + 1}</td>
				<td><g:formatDate format="MM-dd-yyyy" date="${eirSchedule?.transferDate}"/></td>
                                <td align="right"><g:formatNumber number="${eirSchedule?.uidAmount}" format="###,##0.00"/></td>
                               
			</tr>

			</g:each>
		</tbody>
                <br><br>
                
                                        <tbody>        

                        <tr>
                            <td> <strong>TOTAL</strong></td>
                        <td>...</td>                            
                        <td align="right"><label><g:formatNumber number="${totalUID}" format="###,##0.00"/></label></td>
                        </tr>            
                                                </tbody>                 
	</table>
</div>