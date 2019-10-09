package icbs.cif

//import icbs.lov.BusinessIndustry
import icbs.lov.Lov

class Employment {

    //customer id
    static belongsTo = [customer:Customer]
    boolean isPrimary
    //employment type
    //mga bagong saksak
    String employerName
    String supervisor
    String address1
    String address2
    String address3
    String contactNo
    String faxNo
    String eMail
    
    //end bagong saksak
    String employmentId//missing
    String designation
    String yearStart
    String yearEnd
    double monthlyIncome//missing mandatory
    //BusinessIndustry businessIndustryId
    boolean isDeped
    Lov region
    //missing
    String depedEmploymentId//missing
    String remarks//missing
    //status
    String hash
    
    static constraints = {
        //businessIndustryId nullable:true
        region nullable:true
        //end lov
        isPrimary nullable:true
        employerName nullable:true,size:2..50
        supervisor nullable:true,maxSize:50
        address1 nullable:true,maxSize:50
        address2 nullable:true,maxSize:50
        address3 nullable:true,maxSize:30
        contactNo nullable:true,maxSize:50
        faxNo nullable:true,maxSize:50
        eMail nullable:true,maxSize:50
        employmentId nullable:true,maxSize:30
        designation nullable:true,maxSize:50
        yearStart nullable:true,maxSize:4
        yearEnd nullable:true,maxSize:4
        monthlyIncome nullable:true
        isDeped nullable:true,blankable:true
        depedEmploymentId nullable:true,maxSize:30
        remarks nullable:true,maxSize:255
        hash nullable:true,maxSize:255
    }
    static mapping = {
        id sqlType: "int", generator: "increment"
        employerName sqlType: "varchar"
        supervisor sqlType: "varchar"
        address1 sqlType: "varchar"
        address2 sqlType: "varchar"
        address3 sqlType: "varchar"
        contactNo sqlType: "varchar"
        faxNo sqlType: "varchar"
        eMail sqlType: "varchar"
        employmentId sqlType: "varchar"
        designation sqlType: "varchar"
        yearStart sqlType: "varchar"
        yearEnd sqlType: "varchar"
        monthlyIncome sqlType:"decimal", precision: 24, scale: 8
        depedEmploymentId sqlType: "varchar"
        remarks sqlType: "varchar"
        hash sqlType: "varchar"
    }
}