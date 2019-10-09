package icbs.cif

//import icbs.lov.BusinessIndustry
import icbs.lov.LoanProject
class Business {

    static belongsTo = [customer:Customer]
    Date registrationDate
    String name
    String address1
    String address2
    String address3
    String contactNo
    String faxNo
    String eMail
    //BusinessIndustry businessIndustryId
    LoanProject lProject
    
    static constraints = {
        //businessIndustryId nullable:true
        //end lov
        registrationDate nullable:true
        name nullable:true,maxSize:50
        lProject nullable: true
        address1 nullable:true,maxSize:50    
        address2 nullable:true,maxSize:50
        address3 nullable:true,maxSize:30
        contactNo nullable:true,maxSize:50
        faxNo nullable:true,maxSize:50
        eMail nullable:true,maxSize:50
    }
    static mapping = {
        id sqlType: "int", generator: "increment"
        name sqlType: "varchar"
        
        address1 sqlType: "varchar"
        address2 sqlType: "varchar"
        address3 sqlType: "varchar"
        contactNo sqlType: "varchar"
        faxNo sqlType: "varchar"
        email sqlType: "varchar"
        
    }
}
