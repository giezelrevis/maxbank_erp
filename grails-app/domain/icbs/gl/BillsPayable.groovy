package icbs.gl
import icbs.admin.UserMaster
import icbs.admin.Branch
import icbs.admin.Currency
import icbs.lov.ConfigItemStatus

class BillsPayable {
    Branch branch
    Currency currency
    String creditorName
    Date dateOpened
    Date dueDate
    Date pnDate
    String pnNo
    String pdcIssuedText
    String accountName
    String payee
    Double principal
    Double interestAmt
    Double interestRate
    String glContra
    UserMaster createdBy
    Date dateCreated
    ConfigItemStatus status
    
    static constraints = {
        branch nullable:true
        currency nullable:true
        creditorName nullable:true
        dateOpened nullable:true
        dueDate nullable:true
        pnDate nullable:true
        pnNo nullable:true
        pdcIssuedText nullable:true
        accountName nullable:true
        payee nullable:true
        principal min:0D, scale:2, nullable:true
        interestAmt min:0D, scale:2, nullable:true
        interestRate min:0D, scale:5, nullable:true
        glContra nullable:true
        createdBy nullable:true
        dateCreated nullable:true    
        status nullable:true
    }
    
    static mapping = {
      id sqlType: "int", generator: "increment"
    }     
}
