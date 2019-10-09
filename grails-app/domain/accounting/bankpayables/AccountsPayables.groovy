package accounting.bankpayables

class AccountsPayables {

    String glaccount
    String clientname
    String checknunmber
    Double amount
    Date transdate
    String reference
    String particulars
    Integer tag
    
    static constraints = {
        
         glaccount(nullable:true)
         clientname(nullable:true)
         checknunmber(nullable:true)
         amount(nullable:true)
         transdate(nullable:true)
         reference(nullable:true)
         particulars(nullable:true)
         tag(nullable:true)
        
    }
    
    static mapping = {
    
        id generator: 'identity',
        params: [table: 'accountspayables', column: 'id']
    }
    
}
