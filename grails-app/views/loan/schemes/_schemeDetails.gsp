<%@ page import="icbs.loans.InterestIncomeScheme" %>


<div>
    <p id="installment-type">${interestIncomeScheme?.installmentType?.id ?: 1}</p>
    <p id="installment-calculation">${interestIncomeScheme?.installmentCalcType?.id ?: 1}</p>
    <p id="default-interest-rate">${interestIncomeScheme?.defaultInterestRate ?: ""}</p>
    <p id="min-interest-rate">${interestIncomeScheme?.minInterestRate ?: ""}</p>
    <p id="max-interest-rate">${interestIncomeScheme?.maxInterestRate ?: ""}</p>
    <p id="balloon-mode">${interestIncomeScheme?.hasBalloonMode}</p>    
    <p id="changeable-interest-rate">${interestIncomeScheme?.canChangeInterestRate}</p>
    <p id="adv-interest-type">${interestIncomeScheme?.advInterestType?.id ?: 1}</p>

    <p id="penalty-type">${penaltyIncomeScheme?.type?.id ?: 1}</p>
    <p id="default-penalty-rate">${penaltyIncomeScheme?.defaultPenaltyRate ?: ""}</p>
    <p id="min-penalty-rate">${penaltyIncomeScheme?.minPenaltyRate ?: ""}</p>
    <p id="max-penalty-rate">${penaltyIncomeScheme?.maxPenaltyRate ?: 100}</p>
    <p id="changeable-penalty-rate">${penaltyIncomeScheme?.canChangePenaltyRate}</p>
    <p id="default-penalty-amount">${penaltyIncomeScheme?.defaultPenaltyAmount ?: ""}</p>
    <p id="min-penalty-amount">${penaltyIncomeScheme?.minPenaltyAmount ?: ""}</p>
    <p id="max-penalty-amount">${penaltyIncomeScheme?.maxPenaltyAmount ?: ""}</p>

    <%--<p id="service-charge-type">${amortizedChargeScheme?.type?.id ?: 1}</p>
    <p id="service-charge-amount">${amortizedChargeScheme?.amount ?: ""}</p>
    <p id="service-charge-rate">${amortizedChargeScheme?.rate ?: ""}</p>--%>
</div>


