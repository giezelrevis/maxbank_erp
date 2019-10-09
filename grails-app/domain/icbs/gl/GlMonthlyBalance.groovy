package icbs.gl

import icbs.admin.Currency
import icbs.admin.Branch

class GlMonthlyBalance {

    GlAccount glAcct

    Currency currency
    Branch branch
    String code
    String name
    Date refDate  // reference date
    Integer refMonth
    Integer refYear

    //Double debitToday //Total Debits for the day
    //Double creditToday //Total Credits for the day
    Double debitBalance //Total Debit Balance for the day
    Double creditBalance //Total Credit Balance for the day


    static constraints = {
        debitBalance scale:2//Total Debit Balance for the day
        creditBalance scale:2//Total Credit Balance for the day
        
    }
    static mapping = {
      id sqlType: "int", generator: "increment"
      currency sqlType: "int"
      branch sqlType: "int"
    }

}



