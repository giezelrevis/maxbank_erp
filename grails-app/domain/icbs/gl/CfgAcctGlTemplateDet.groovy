package icbs.gl

import icbs.gl.CfgAcctGlTemplate
import icbs.gl.GlAccount

class CfgAcctGlTemplateDet {
	
	CfgAcctGlTemplate glTemplate
	String glDescription
	GlAccount glAcct
  
  Integer status
  Integer transactionType
  String ordinalPos
  String glCode
  static belongsTo = [glTemplate: CfgAcctGlTemplate]

  static constraints = {
  	glAcct nullable:true
    status nullable:true
    transactionType nullable:true
    ordinalPos nullable:true
    glCode nullable: true
    }

  String getEntry() {
        "${ordinalPos} ${glDescription} (${transactionType})"
  }

 	static mapping = {
    id sqlType: "int", generator: "increment"
    glTemplate sqlType: "int"
    glAcct sqlType: "int"
  }	
}
