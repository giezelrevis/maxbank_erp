package icbs.loans

class LoanConfigSettings {
	Integer interestDecimalPlaces
	Integer penaltyDecimalPlaces
	Integer taxDecimalPlaces
	Boolean hasApplicationProcessing
	String applicationRegistrationKey
	String applicationLicenseKey
	Boolean hasRemediationProcessing
	String remediationRegistrationKey
	String remediationLicenseKey

	static mapWith = "none"

	static constraints = {
		interestDecimalPlaces nullable: false, blank: false
		penaltyDecimalPlaces nullable: false, blank: false
		taxDecimalPlaces nullable: false, blank: false
		hasApplicationProcessing nullable: false
		applicationRegistrationKey maxSize: 100, nullable: false, blank: false
		applicationLicenseKey maxSize: 100, nullable: false, blank: false
		hasRemediationProcessing nullable: false
		remediationRegistrationKey maxSize: 100, nullable: false, blank: false
		remediationLicenseKey maxSize: 100, nullable: false, blank: false
	}
}
