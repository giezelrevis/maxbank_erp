package icbs.gl

import icbs.admin.Currency
import icbs.admin.Branch
import icbs.lov.GlAcctType
import icbs.gl.GlSortCode

class GlAccount {

    GlAcctType type

    Currency currency
    Branch branch
    String code
    String name
    String shortName
    GlSortCode parent
    boolean batchUpdate // flag for batch update

    Double debit //Total Debits for the financial year
    Double credit //Total Credits for the financial year
    Double balance //ending balance
    Double debitToday //Total Debits for the day
    Double creditToday //Total Credits for the day
    Double debitBalance //Debit Balance for trial balance (difference of debit-credit)
    Double creditBalance //Credit Balance for trial balance (difference of debit-credit)
    
    Integer financialYear
    Date lastTxnDate

    String getGl() {
        "${name} (${code})"
    }

    static constraints = {
        
        type nullable:true
        currency nullable: true
        branch nullable: true
        code maxsize:11 , nullable:false, unique: ['branch', 'currency', 'financialYear']
        name nullable:false
        // parent nullable: true
        shortName nullable:true
        debit nullable:true, min: 0d, scale: 2
        credit nullable:true, min: 0d, scale: 2
        debitToday nullable:true, min: 0d, scale: 2
        creditToday nullable:true, min: 0d, scale: 2
        debitBalance nullable:true, min: 0d, scale: 2
        creditBalance nullable:true, min: 0d, scale: 2
        balance nullable:true
        
        financialYear nullable:true
        lastTxnDate nullable:true

    }

    static mapping = {
      id sqlType: "int", generator: "increment"
      currency sqlType: "int"
      type sqlType: "int"
      branch sqlType: "int"
      parent sqlType: "int"
    }

    def beforeInsert(){
        if (!this.credit) {
            this.credit = 0
        }
        if (!this.debit) {
            this.debit = 0
        }
        this.debitToday = 0
        this.creditToday = 0
        if (!this.debitBalance) {
            this.debitBalance = 0
        }
        if (!this.creditBalance) {
            this.creditBalance = 0
        }
        if (!this.balance) {
            this.balance = 0
        }
        this.lastTxnDate = Branch.get(1).runDate
    }
    
    def beforeUpdate() {
        this.lastTxnDate = Branch.get(1).runDate
    }
    
}
