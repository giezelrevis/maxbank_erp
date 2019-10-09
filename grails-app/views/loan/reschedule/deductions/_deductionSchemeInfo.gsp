<%@ page import="icbs.loans.LoanDeductionScheme" %>


<div>
    <p id="type">${deductionScheme?.type.id ?: 1}</p>
    <p id="rate">${deductionScheme?.rate ?: 0}</p>
    <p id="amount">${deductionScheme?.amount ?: 0}</p>
</div>


