package icbs.gl

import icbs.gl.CfgGlLinkEntry

class TxnGlLink {
	
	//Active or Inactive
	String status
	String description
    
    static hasMany = [links: CfgGlLinkEntry]

    static constraints = {
    	status nullable:false
    	description nullable:false
    }

    static mapping = {
    	id sqlType:'int', generator:'increment'
        links joinTable: [name:'CfgGlLinkEntry', key:'gl_link_id']
    }
}
