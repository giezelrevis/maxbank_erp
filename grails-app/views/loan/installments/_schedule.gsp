<%@ page import="icbs.loans.LoanApplication" %>




<legend>Installment Schedule</legend>

<div class="table-responsive">
    <table class="table table-hover table-condensed table-bordered table-striped">
        <tbody>
            <tr>
                <td><label>No.</label></td>
                <td><label>Installment Date</label></td>
                <td><label>Gross Loan</label></td>
                <td><label>Principal</label></td>
                <td><label>Interest</label></td>
                <td><label>Service Charges</label></td>
                <td><label>Other Charges</label></td>
                <td><label>Cash Flows</label></td>
                <td><label>O/S Balance</label></td>
                <td><label>Status</label></td>
            </tr>
        </tbody>
        <tbody>
        <g:set var="advInterest" value="${loanInstance?.advInterest ?: 0}" />
        <g:set var="totalPrincipal" value="${0}" />
        <g:set var="totalInterest" value="${advInterest}" />
        <g:set var="totalServiceCharges" value="${0}" />

            <tr>
                <td></td>
                <td></td>
                <td align="right"><g:formatNumber format="###,##0.00" number="${loanInstance?.grantedAmount}" /></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td align="right"><g:formatNumber format="###,##0.00" number="${loanInstance?.grantedAmount}" /></td>
                <td></td>
            </tr> 
            <tr>
                <td>0</td>
                <td><g:formatDate format="MM-dd-yyyy" date="${loanInstance?.openingDate}"/></td>
                <td></td>
                <td></td>
                <td align="right">
                <g:if test="${advInterest > 0}">
                <g:formatNumber format="###,##0.00" number="${advInterest}" />
                </g:if>
                </td>
                <td></td>
                <td align="right"><g:formatNumber format="###,##0.00" number="${totalDeductions}" /></td>
                <td align="right"><g:formatNumber format="###,##0.00" number="${loanInstance?.grantedAmount - (totalDeductions + advInterest)}" /></td>
                <td align="right"><g:formatNumber format="###,##0.00" number="${loanInstance?.grantedAmount}" /></td>
                <td></td>
            </tr> 
        <g:set var="prevBalance" value="${loanInstance?.grantedAmount}" />
        <g:each in="${loanInstance?.loanInstallments?.sort{it.sequenceNo}}" var="loanInstallment">
            <tr>
                <g:set var="balance" value="${(prevBalance - loanInstallment?.principalInstallmentAmount).round(2)}" />
                <td>${loanInstallment?.sequenceNo}</td>
                <td><g:formatDate format="MM-dd-yyyy" date="${loanInstallment?.installmentDate}"/></td>
                <td></td>
                <g:set var="principal" value="${loanInstallment?.principalInstallmentAmount}" />
                <td align="right"><g:formatNumber format="###,##0.00" number="${principal}" /></td>
                <g:set var="interest" value="${loanInstallment?.interestInstallmentAmount}" />
                <td align="right"><g:formatNumber format="###,##0.00" number="${interest}" /></td>
                <g:set var="serviceCharge" value="${loanInstallment?.serviceChargeInstallmentAmount}" />
                <td align="right"><g:formatNumber format="###,##0.00" number="${serviceCharge}" /></td>
                <td></td>
                <g:set var="cashFlow" value="${loanInstallment?.totalInstallmentAmount * -1}" />
                <td align="right"><g:formatNumber format="###,##0.00" number="${cashFlow}" /></td>
                <td align="right"><g:formatNumber format="###,##0.00" number="${balance}" /></td>
                <g:set var="prevBalance" value="${balance}" />
                <g:set var="totalPrincipal" value="${totalPrincipal + principal}" />
                <g:set var="totalInterest" value="${totalInterest +interest}" />
                <g:set var="totalServiceCharges" value="${totalServiceCharges + serviceCharge}" />
                <td>${loanInstallment?.status?.description}</td>
            </tr>
        </g:each>
            <tr>
                <td></td>
                <td></td>
                <td></td>
                <td align="right"><label><g:formatNumber format="###,##0.00" number="${totalPrincipal}" /></label></td>
                <td align="right"><label><g:formatNumber format="###,##0.00" number="${totalInterest}" /></label></td>
                <td align="right"><label><g:formatNumber format="###,##0.00" number="${totalServiceCharges}" /></label></td>
                <td align="right"><label><g:formatNumber format="###,##0.00" number="${totalDeductions}" /></label></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>    
        </tbody>
    </table>
</div>

<div class="fieldcontain form-group">
    <label class="control-label col-sm-4">
        <g:message code="loan.grantedAmount.label" default="Granted Amount" />
    </label>

    <span><g:formatNumber format="###,##0.00" number="${loanInstance?.grantedAmount}" /></span>
</div>

<div class="fieldcontain form-group">
    <label class="control-label col-sm-4">
        <g:message code="loan.effectiveInterestRate.label" default="Effective Interest Rate" />
    </label>

    <span><g:formatNumber format="###,##0.00" number="${loanInstance?.effectiveInterestRate}" /> %</span>
</div>

<div class="fieldcontain form-group">
    <label class="control-label col-sm-4">
        <g:message code="loan.monthlyInterestRate.label" default="Monthly Interest Rate" />
    </label>

    <span><g:formatNumber format="###,##0.00" number="${loanInstance?.monthlyInterestRate}" /> %</span>
</div>

<div class="fieldcontain form-group">
    <label class="control-label col-sm-4">
        <g:message code="loan.totalNetProceeds.label" default="Total Net Proceeds" />
    </label>

    <span><g:formatNumber format="###,##0.00" number="${loanInstance?.totalNetProceeds}" /></span>
    <span></span>
</div>