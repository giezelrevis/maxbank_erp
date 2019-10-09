package icbs.loans


import grails.converters.JSON
import grails.converters.deep.JSON
import icbs.lov.LoanCalculation
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional


@Transactional(readOnly = true)
class LoanProposalController {

    def index() {
        render(view: "create")
    } 
    
    def getInterestIncomeSchemeInfoAjax() {
        def interestIncomeScheme = null
        if (params.id) {
            interestIncomeScheme = InterestIncomeScheme.get(params.id)
        }

        render(template:"interestIncomeSchemeInfo", model:[interestIncomeScheme: interestIncomeScheme]) as JSON
        return
    }    

    def showInstallmentScheduleAjax() {
        // for manual installment
        def installmentDates = []
        def principalAmounts = []
        def interestAmounts = []
        def tempDates = params.list("installmentDate")
        def tempPrincipalAmounts = params.list("principalAmount")
        def tempInterestAmounts = params.list("interestAmount")
        for (int i = 0; i < tempDates.size() - 1; i++) {
            if (tempDates[i]) {
                installmentDates.add(new Date().parse("MM/dd/yyyy", tempDates[i]))
            }

            if (tempPrincipalAmounts[i]) {
                principalAmounts.add(tempPrincipalAmounts[i].replaceAll(",","").toDouble())
            }

            if (tempInterestAmounts[i]) {
                interestAmounts.add(tempInterestAmounts[i].replaceAll(",","").toDouble())
            }
        }

        def interestIncomeScheme = InterestIncomeScheme.get(params?.interestIncomeScheme)

        def amount = 0
        if (interestIncomeScheme.installmentType.id == 5 || interestIncomeScheme.installmentCalcType.id == 6) {
            for(principal in principalAmounts) {
                amount = amount + principal
            }
        } else {
            amount = (params?.amount.replaceAll(",","")).toDouble()
        }
        def interestRate = params?.interestRate.toDouble() * 0.01
        def term = params?.term ? params.term.toInteger() : 1
        def frequency = params?.frequency ? params?.frequency.toInteger() : 1
        def numInstallments = params?.numInstallments ? params.numInstallments.toInteger() : 12
        def balloonInstallments

        def installmentAmount = null  // for overriding annuity installment amount
        if (interestIncomeScheme.installmentCalcType.id == 3 && params?.installmentAmount) {
            installmentAmount = params?.installmentAmount.replaceAll(",","").toDouble()
            println '3'
            println installmentAmount
        }
        if (interestIncomeScheme.installmentCalcType.id == 7 && params?.installmentAmount) {
            installmentAmount = params?.installmentAmount.replaceAll(",","").toDouble()
            println '7'
            println installmentAmount            
        }        
        if (interestIncomeScheme?.hasBalloonMode) {
            balloonInstallments = params?.balloonInstallments ? params.balloonInstallments.toInteger() : 0
        } else {
            balloonInstallments = 0
        }
        
        def openingDate = new Date().parse("MM/dd/yyyy", params?.openingDate)
        def firstInstallmentDate = null
        if (params?.firstInstallmentDate) {
            firstInstallmentDate = new Date().parse("MM/dd/yyyy", params?.firstInstallmentDate)
        }
        if (interestIncomeScheme.installmentCalcType == LoanCalculation.get(6)) {
            firstInstallmentDate = tempDates[0]
        }
        def interestStartDate = null
        if (params?.interestStartDate) {
            interestStartDate = new Date().parse("MM/dd/yyyy", params?.interestStartDate)
        }
        
        if (interestIncomeScheme.installmentType.id == 5 || interestIncomeScheme.installmentCalcType.id == 6) {
            Double interest
            Double prinAmt
            Double lnBal
            interestAmounts = []
            amount = 0
            def divisor = interestIncomeScheme.divisor
            def date1 = new Date()
            def date2 = new Date()
            for (int i = 0; i < tempDates.size() - 1; i++) {
                prinAmt = tempPrincipalAmounts[i].replaceAll(",","").toDouble()
                amount = amount + prinAmt
            }
            lnBal = amount
            
            for (int i = 0; i < tempDates.size() - 1; i++) {
                interest = tempInterestAmounts[i].replaceAll(",","").toDouble()
                prinAmt = tempPrincipalAmounts[i].replaceAll(",","").toDouble()
                if (i == 0) {
                    firstInstallmentDate = new Date().parse("MM/dd/yyyy", tempDates[i])
                    date1 = new Date().parse("MM/dd/yyyy", params?.openingDate)
                } else {
                    date1 = new Date().parse("MM/dd/yyyy", tempDates[i-1])
                }
                date2 = new Date().parse("MM/dd/yyyy", tempDates[i])
            
                interest = lnBal * (date2 - date1) * interestRate.div(divisor)
                lnBal -= prinAmt
                    
                if (tempInterestAmounts[i]) {
                    interestAmounts.add(interest)
                }
            }   
            println interestAmounts
        }
            
        def schedParams = [interestIncomeScheme: interestIncomeScheme,
                           amount: amount,
                           interestRate: interestRate,
                           term: term,
                           frequency: frequency,
                           numInstallments: numInstallments,
                           installmentAmount: installmentAmount,
                           openingDate: openingDate,
                           firstInstallmentDate: firstInstallmentDate,
                           interestStartDate: interestStartDate,
                           installmentDates: installmentDates,
                           balloonInstallments: balloonInstallments,
                           principalAmounts: principalAmounts,
                           interestAmounts: interestAmounts,
                           divisor: interestIncomeScheme.divisor]

        render(template:"installment", model:schedParams) as JSON
        return
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'loanApplication.label', default: 'LoanApplication'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
