package icbs.admin

import icbs.admin.Currency
import icbs.gl.GlAccount

class GlConfigSettings {

  Currency currency
  String revaluationPolicy
  Integer taxMonthEnd
  GlAccount errorAcct


  static constraints = {
  	currency nullable:false
  	revaluationPolicy nullable:false
  	taxMonthEnd nullable:false
  	errorAcct nullable:false
  }

  static mapping = {
  	id sqlType:'int', generator:'increment'
  	currency sqlType:'int'
  	errorAcct sqlType:'int'
  }
}
