package icbs.admin

import grails.validation.Validateable

@Validateable
class InstitutionConfig {

	String institutionName
	String institutionCode

	static mapWith = "none"

    static constraints = {
    	institutionName blank:false, nullable:false
    	institutionCode nullable:false
    }
}
