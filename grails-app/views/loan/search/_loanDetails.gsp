
<div>
    <p id="account-no">${loanInstance?.accountNo}</p>
    <p id="customer">${loanInstance?.customer?.displayName}</p>
    <p id="granted-amount"><g:formatNumber format="###,###,##0.00" number="${loanInstance?.grantedAmount}"/></p>
    <p id="balance-amount"><g:formatNumber format="###,###,##0.00" number="${loanInstance?.balanceAmount}"/></p>
    <p id="interest-rate"><g:formatNumber format="###,###,##0.00" number="${loanInstance?.interestRate}"/></p>
    <p id="maturity-date"><g:formatDate format="MM/dd/yyyy" date="${loanInstance?.maturityDate}"/></p>
    <p id="total-net-proceeds"><g:formatNumber format="###,###,##0.00" number="${loanInstance?.totalNetProceeds}"/></p>
    <p id="total-disbursement-amount"><g:formatNumber format="###,###,##0.00" number="${loanInstance?.totalDisbursementAmount}"/></p>
    <p id="overdue-principal-balance"><g:formatNumber format="###,###,##0.00" number="${loanInstance?.overduePrincipalBalance}"/></p>    
    <p id="principal-balance"><g:formatNumber format="###,###,##0.00" number="${loanInstance?.balanceAmount}"/></p>
    <p id="interest-balance"><g:formatNumber format="###,###,##0.00" number="${loanInstance?.interestBalanceAmount}"/></p>
    <p id="penalty-balance"><g:formatNumber format="###,###,##0.00" number="${loanInstance?.penaltyBalanceAmount}"/></p>
    <p id="service-charge-balance"><g:formatNumber format="###,###,##0.00" number="${loanInstance?.serviceChargeBalanceAmount}"/></p>
</div>


