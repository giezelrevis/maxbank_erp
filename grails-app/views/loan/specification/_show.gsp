<table class="table table-bordered table-striped">
    <legend>Loan Specification</legend>
    <tr>
        <td style="font-weight:bold" width="30%">PN No.</td>
        <td width="70%"><span>${loanInstance?.pnNo}</span></td>
    </tr>
    <tr>
        <td style="font-weight:bold" width="30%">Product</td>
        <td width="70%"><span><g:link controller="product" action="show" id="${loanApplicationInstance?.product?.id}">${loanApplicationInstance?.product?.name}</g:link></span></td>
    </tr>
<g:if test="${loanInstance?.branch?.id == null}">
    <tr>
        <td style="font-weight:bold" width="30%">Branch</td>
        <td width="70%"><span><g:link controller="branch" action="show" id="${loanApplicationInstance?.branch?.id}">${loanApplicationInstance?.branch?.name}</g:link></span></td>
    </tr>
</g:if>
<g:else>
    <tr>
        <td style="font-weight:bold" width="30%">Branch</td>
        <td width="70%"><span><g:link controller="branch" action="show" id="${loanInstance?.branch?.id}">${loanInstance?.branch?.name}</g:link></span></td>
    </tr>    
</g:else>  
    <tr>
        <td style="font-weight:bold" width="30%">Currency</td>
        <td width="70%"><span>${loanInstance?.currency?.name}</span></td>
    </tr>
    <tr>
        <td style="font-weight:bold" width="30%">Granted Amount</td>
        <td width="70%"><span><g:formatNumber format="###,###,##0.00" number="${loanInstance?.grantedAmount}"/></span></td>
    </tr>
    <tr>
        <td style="font-weight:bold" width="30%">Ownership Type</td>
        <td width="70%"><span>${loanInstance?.ownershipType?.description}</span></td>
    </tr>
    <tr>
        <td style="font-weight:bold" width="30%">Interest Income Scheme</td>
        <td width="70%"><span><g:link controller="interestIncomeScheme" action="show" id="${loanInstance?.interestIncomeScheme?.id}">${loanInstance?.interestIncomeScheme?.name}</g:link></span></td>
    </tr>
    <tr>
        <td style="font-weight:bold" width="30%">Current Penalty Income Scheme</td>
        <td width="70%"><span><g:link controller="penaltyIncomeScheme" action="show" id="${loanInstance?.currentPenaltyScheme?.id}">${loanInstance?.currentPenaltyScheme?.name}</g:link></span></td>
    </tr>
    <tr>
        <td style="font-weight:bold" width="30%">Past Due Penalty Income Scheme</td>
        <td width="70%"><span><g:link controller="penaltyIncomeScheme" action="show" id="${loanInstance?.pastDuePenaltyScheme?.id}">${loanInstance?.pastDuePenaltyScheme?.name}</g:link></span></td>
    </tr>
    <tr>
        <td style="font-weight:bold" width="30%">Interest Rate</td>
        <td width="70%"><span><g:formatNumber format="###,###,##0.00" number="${loanInstance?.interestRate}"/> %</span></td>
    </tr>
<g:if test="${loanInstance?.currentPenaltyScheme?.type?.id == 1}">
    <tr>
        <td style="font-weight:bold" width="30%">Penalty Amount</td>
        <td width="70%"><span><g:formatNumber format="###,###,##0.00" number="${loanInstance?.penaltyAmount}"/></span></td>
    </tr>
</g:if>
<g:elseif test="${loanInstance?.currentPenaltyScheme?.type?.id == 1}">
    <tr>
        <td style="font-weight:bold" width="30%">Penalty Rate</td>
        <td width="70%"><span>${loanInstance?.penaltyRate} %</span></td>
    </tr>    
</g:elseif>
<g:else>
    <tr>
        <td style="font-weight:bold" width="30%">Service Charge Amount</td>
        <td width="70%"><span><g:formatNumber format="###,###,##0.00" number="${loanInstance?.serviceCharge}"/></span></td>
    </tr>     	
</g:else>
<g:if test="${loanInstance?.interestIncomeScheme?.installmentCalcType?.id == 1}">
    <tr>
        <td style="font-weight:bold" width="30%">Term</td>
        <td width="70%"><span>${loanInstance?.term}</span></td>
    </tr>     
</g:if>
<g:else>
    <tr>
        <td style="font-weight:bold" width="30%">Frequency</td>
        <td width="70%"><span>${loanInstance?.frequency?.description}</span></td>
    </tr>
    <tr>
        <td style="font-weight:bold" width="30%">No. of Installments</td>
        <td width="70%"><span>${loanInstance?.numInstallments}</span></td>
    </tr>
    <g:if test="${loanInstance?.interestIncomeScheme?.installmentCalcType?.id == 2 || loanInstance?.interestIncomeScheme?.installmentCalcType?.id == 5}">
        <tr>
            <td style="font-weight:bold" width="30%">Balloon Installments</td>
            <td width="70%"><span>${loanInstance?.balloonInstallments}</span></td>
        </tr>
    </g:if>
</g:else>
    <tr>
        <td style="font-weight:bold" width="30%">Processing Date</td>
        <td width="70%"><span><g:formatDate format="MM/dd/yyyy" date="${loanInstance?.applicationDate}"/></span></td>
    </tr>
    <tr>
        <td style="font-weight:bold" width="30%">Opening Date</td>
        <td width="70%"><span><g:formatDate format="MM/dd/yyyy" date="${loanInstance?.openingDate}"/></span></td>
    </tr>
    <tr>
        <td style="font-weight:bold" width="30%">Interest Start Date</td>
        <td width="70%"><span><g:formatDate format="MM/dd/yyyy" date="${loanInstance?.interestStartDate}"/></span></td>
    </tr>
    <tr>
        <td style="font-weight:bold" width="30%">First Installment Date</td>
        <td width="70%"><span><g:formatDate format="MM/dd/yyyy" date="${loanInstance?.firstInstallmentDate}"/></span></td>
    </tr>
    <tr>
        <td style="font-weight:bold" width="30%">Maturity Date</td>
        <td width="70%"><span><g:formatDate format="MM/dd/yyyy" date="${loanInstance?.maturityDate}"/></span></td>
    </tr>
    <tr>
        <td style="font-weight:bold" width="30%">Status</td>
        <td width="70%"><span>${loanInstance?.status?.description}</span></td>
    </tr>
</table>						
<!--<div class="fieldcontain form-group">
	<label class="control-label col-sm-4">
		<g:message code="loan.accountNo.label" default="Account No." />
	</label>

	<span>${loanInstance?.accountNo}</span>
</div> -->




<%--<div class="fieldcontain form-group">
	<label class="control-label col-sm-4">
		<g:message code="loan.numberOfOwners.label" default="No. of Owners" />
	</label>

	<span>${loanInstance?.numberOfOwners}</span>
</div>--%>

<%--<div class="fieldcontain form-group">
	<label class="control-label col-sm-4">
		<g:message code="loan.amortizedChargeScheme.label" default="Amortized Charge Scheme" />
	</label>

	<span>${loanInstance?.amortizedChargeScheme?.name}</span>
</div>--%>




<%--<g:if test="${loanInstance?.amortizedChargeScheme?.type?.id == 1}">
<div class="fieldcontain form-group">
	<label class="control-label col-sm-4">
		<g:message code="loan.serviceCharge.label" default="Service Charge Amount" />
	</label>

	<span>${loanInstance?.amortizedChargeScheme?.amount}</span>
</div>	
</g:if>

<g:elseif test="${loanInstance?.amortizedChargeScheme?.type?.id == 2}">
<div class="fieldcontain form-group">
	<label class="control-label col-sm-4">
		<g:message code="loan.serviceCharge.label" default="Service Charge Rate" />
	</label>

	<span>${loanInstance?.amortizedChargeScheme?.rate} %</span>
</div>	
</g:elseif>--%>