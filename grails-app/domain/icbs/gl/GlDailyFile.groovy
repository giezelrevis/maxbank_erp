package icbs.gl

import icbs.admin.Currency
import icbs.admin.Branch
import icbs.gl.GlAccount

class GlDailyFile {
    GlAccount glAcct

    Currency currency
    Branch branch
    String code
    String name
    Date refDate  // reference date

    Double debitToday //Total Debits for the day
    Double creditToday //Total Credits for the day
    Double debitBalance //Total Debit Balance for the day
    Double creditBalance //Total Credit Balance for the day
    
    Integer financialYear

    static constraints = {    
        currency nullable: false
        branch nullable: false
        refDate nullable: false
        debitToday scale:2//Total Debits for the day
        creditToday scale:2//Total Credits for the day
        debitBalance scale:2//Total Debit Balance for the day
        creditBalance scale:2//Total Credit Balance for the day
    }
    
    static mapping = {
      id sqlType: "int", generator: "increment"
      currency sqlType: "int"
      branch sqlType: "int"
    }
}
