package icbs.gl
import icbs.admin.Branch
import icbs.admin.UserMaster
import icbs.admin.Currency
import icbs.lov.ConfigItemStatus

class AccountsReceivable {
    Branch branch
    Currency currency
    String glContra
    Date bookingDate
    String receivableName
    String description
    String reference
    Double balance
    Double requiredValuationReserves
    UserMaster user
    ConfigItemStatus status
    
    static constraints = {
        branch nullable:true
        currency nullable:true
        glContra nullable:true
        bookingDate nullable:true
        description nullable:true
        balance min:0D, scale:2, nullable:true
        requiredValuationReserves min:0D, scale:2, nullable:true
        user nullable:true
        status nullable:true
        receivableName nullable:true
        reference nullable:true
    }
    
    static mapping = {
      id sqlType: "int", generator: "increment"
    }      
}
