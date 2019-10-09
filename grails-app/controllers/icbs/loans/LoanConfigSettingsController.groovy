package icbs.loans



import icbs.admin.Institution
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class LoanConfigSettingsController {

	static allowedMethods = [update: "PUT"]

    def index() {
    	def institution = Institution.findAllByParamCodeLike("LNS.%", [sort: "paramCode", order: "asc"])

		def loanConfigSettings = new LoanConfigSettings()
		loanConfigSettings.interestDecimalPlaces = institution[0]?.paramValue?.toInteger()
		loanConfigSettings.penaltyDecimalPlaces = institution[1]?.paramValue?.toInteger()
		loanConfigSettings.taxDecimalPlaces = institution[2]?.paramValue?.toInteger()
		loanConfigSettings.hasApplicationProcessing = institution[3]?.paramValue?.toBoolean()
		loanConfigSettings.applicationRegistrationKey = institution[4]?.paramValue
		loanConfigSettings.applicationLicenseKey = institution[5]?.paramValue
		loanConfigSettings.hasRemediationProcessing = institution[6]?.paramValue?.toBoolean()
		loanConfigSettings.remediationRegistrationKey = institution[7]?.paramValue
		loanConfigSettings.remediationLicenseKey = institution[8]?.paramValue

		[loanConfigSettings: loanConfigSettings]
    }

    def edit() {
    	def institution = Institution.findAllByParamCodeLike("LNS.%", [sort:"paramCode", order:"asc"])

		def loanConfigSettings = new LoanConfigSettings()
		loanConfigSettings.interestDecimalPlaces = institution[0]?.paramValue?.toInteger()
		loanConfigSettings.penaltyDecimalPlaces = institution[1]?.paramValue?.toInteger()
		loanConfigSettings.taxDecimalPlaces = institution[2]?.paramValue?.toInteger()
		loanConfigSettings.hasApplicationProcessing = institution[3]?.paramValue?.toBoolean()
		loanConfigSettings.applicationRegistrationKey = institution[4]?.paramValue
		loanConfigSettings.applicationLicenseKey = institution[5]?.paramValue
		loanConfigSettings.hasRemediationProcessing = institution[6]?.paramValue?.toBoolean()
		loanConfigSettings.remediationRegistrationKey = institution[7]?.paramValue
		loanConfigSettings.remediationLicenseKey = institution[8]?.paramValue

		[loanConfigSettings: loanConfigSettings]
    }

    @Transactional
    def update() {
        def loanConfigSettings = new LoanConfigSettings(params)

        if (loanConfigSettings.hasErrors()) {
            respond loanConfigSettings.errors, view:'edit'
            return
        }

    	def institution = Institution.findAllByParamCodeLike("LNS.%", [sort:"paramCode", order:"asc"])

    	institution[0].paramValue = params.interestDecimalPlaces.toString()
    	institution[1].paramValue = params.penaltyDecimalPlaces.toString()
    	institution[2].paramValue = params.taxDecimalPlaces.toString()
		institution[3].paramValue = params.hasApplicationProcessing ? "True" : "False"
    	institution[4].paramValue = params.applicationRegistrationKey
    	institution[5].paramValue = params.applicationLicenseKey
		institution[6].paramValue = params.hasRemediationProcessing ? "True" : "False"
    	institution[7].paramValue = params.remediationRegistrationKey
    	institution[8].paramValue = params.remediationLicenseKey

    	for (i in 0..8) {
    		institution[i].save(flush: true, failOnError: true)
    	}

        flash.message = message(code: 'default.updated.message', args: [message(code: 'LoanConfigSettings.label', default: 'LoanConfigSettings')])
		redirect(action: "index")
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'loanConfigSettings.label', default: 'LoanConfigSettings')])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
