package icbs.gl

class CfgAcctGlTemplate {

	//AcctGlDescription
	String description
	Integer type 
	

    static hasMany = [links: CfgAcctGlTemplateDet]

    static constraints = {
    	description nullable:false
    	type nullable:false
    }

    static mapping = {
      id sqlType: "int", generator: "increment"
      links joinTable: [name:'CfgAcctGlTemplateDet', key:'gl_template_id']
    }
}
