package icbs.gl
import icbs.admin.Branch
import icbs.admin.UserMaster
import icbs.admin.Currency
import icbs.lov.ConfigItemStatus

class AccountsPayable {
    Branch branch
    Currency currency
    String glContra
    Date bookingDate
    String payable
    String particulars
    Double balance
    Date dateCreated
    UserMaster user
    ConfigItemStatus status
    
    static constraints = {
        branch nullable:true
        currency nullable:true
        glContra nullable:true
        bookingDate nullable:true
        payable nullable:true, maxSize:50
        particulars nullable:true
        balance mid:0D, scale:2, nullable:true
        dateCreated nullable:true
        user nullable:true
        status nullable:true
    }
    
    static mapping = {
      id sqlType: "int", generator: "increment"
    }    
}
