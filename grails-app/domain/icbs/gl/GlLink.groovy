package icbs.gl

import icbs.gl.GlAccount
import icbs.lov.GlAcctType

class GlLink {

    String gl_link
    String entry_description
    String gl_link_type

    GlAccount gl_acct

    //Account or Transaction
    String transaction_type
    GlAcctType gl_acct_type

    //Account Status - Past Due etc

    static constraints = {
      gl_link maxsize:4 , nullable:false
      entry_description maxsize:50, nullable:false
    }


    static mapping = {
      id sqlType:'int'
      gl_acct sqlType: 'int'
      gl_acct_type sqlType: "int"
    }
}