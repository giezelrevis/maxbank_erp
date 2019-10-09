<%@ page import="icbs.loans.InterestIncomeScheme" %>


<div>
	<p id="installment-type">${interestIncomeScheme?.installmentType.id ?: 1}</p>
    <p id="installment-calculation">${interestIncomeScheme?.installmentCalcType.id ?: 1}</p>
    <p id="default-interest-rate">${interestIncomeScheme?.defaultInterestRate ?: 0}</p>
    <p id="min-interest-rate">${interestIncomeScheme?.minInterestRate ?: 0}</p>
    <p id="max-interest-rate">${interestIncomeScheme?.maxInterestRate ?: 100}</p>
    <p id="balloon-mode">${interestIncomeScheme?.hasBalloonMode}</p>    
    <p id="changeable-interest-rate">${interestIncomeScheme?.canChangeInterestRate}</p>
</div>


