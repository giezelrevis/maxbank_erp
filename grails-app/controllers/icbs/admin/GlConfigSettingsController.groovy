package icbs.admin

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)

class GlConfigSettingsController {

	static allowedMethods = [update: "PUT"]

    def index()
		{
    	def institution = Institution.findAllByParamCodeLike("GLS.%", [sort: "paramCode", order: "asc"])


			def glConfigSettings = new GlConfigSettings()

			glConfigSettings.currency = institution[0]?.paramValue
			glConfigSettings.taxMonthEnd = institution[1]?.paramValue?.toInteger()
			glConfigSettings.glSortCodeMask = institution[2]?.paramValue
			glConfigSettings.glAccountCodeMask = institution[3]?.paramValue
			glConfigSettings.revaluationPolicy = institution[4]?.paramValue
			glConfigSettings.errorAccount = institution[5]?.paramValue

			[glConfigSettings: glConfigSettings]

		}

    def edit() {
    	def institution = Institution.findAllByParamCodeLike("GLS.%", [sort:"paramCode", order:"asc"])

			def glConfigSettings = new GlConfigSettings()

			glConfigSettings.currency = institution[0]?.paramValue
			glConfigSettings.taxMonthEnd = institution[1]?.paramValue?.toInteger()
			glConfigSettings.glSortCodeMask = institution[2]?.paramValue
			glConfigSettings.glAccountCodeMask = institution[3]?.paramValue
			glConfigSettings.revaluationPolicy = institution[4]?.paramValue
			glConfigSettings.errorAccount = institution[5]?.paramValue

			[glConfigSettings: glConfigSettings]
    }

    @Transactional
    def update() {

				def glConfigSettings = new GlConfigSettings(params)

        if (glConfigSettings.hasErrors()) {
            respond glConfigSettings.errors, view:'edit'
            return
        }

    	def institution = Institution.findAllByParamCodeLike("LNS.%", [sort:"paramCode", order:"asc"])

			institution[0]?.paramValue = glConfigSettings.currency.toString()
			institution[1]?.paramValue = glConfigSettings.taxMonthEnd
			institution[2]?.paramValue = glConfigSettings.glSortCodeMask.toString()
			institution[3]?.paramValue = glConfigSettings.glAccountCodeMask.toString()
			institution[4]?.paramValue = glConfigSettings.revaluationPolicy.toString()
			institution[5]?.paramValue = glConfigSettings.errorAccount.toString()

    	for (i in 0..5) {
    		institution[i].save(flush: true, failOnError: true)
    	}

        flash.message = message(code: 'default.updated.message', args: [message(code: 'glConfigSettings.label', default: 'glConfigSettings')])
		redirect(action: "index")
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'glConfigSettings.label', default: 'glConfigSettings')])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
