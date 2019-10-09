package icbs.gl

import icbs.lov.GlAcctType

class GlSortCode {

  String sort_code
  String sort_name
  GlAcctType parent_id
  Boolean sort_code_status

  static constraints = {
    sort_code nullable:true, unique:true
    sort_name nullable:true
  }

  static mapping = {
    id sqlType:'int', generator:'increment'
    parent_id sqlType: 'int'
  }
}
