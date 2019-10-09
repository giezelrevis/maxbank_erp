package icbs.periodicops
import icbs.cif.Customer
import icbs.admin.Branch
import icbs.lov.CustomerDosriCode
import icbs.lov.CustomerStatus
import icbs.lov.CustomerType
import icbs.lov.FirmSize
import icbs.lov.Gender
import icbs.lov.Lov
import icbs.lov.ResidentType
import icbs.lov.RiskType
import icbs.admin.CustomerGroup

class MonthlyCustomer {
    Date refDate
    Customer customer
    CustomerType type//lov
    Branch branch
    String cid// changed 2/5/15
    String name1
    String name2
    String name3
    String name4
    String displayName
    String shortAddress
    String pepDescription
    String amla
    Date birthDate
    Lov title
    Gender gender//lov
    Lov civilStatus
    String birthPlace
    boolean isTaxable
    double creditLimit
    ResidentType customerCode1
    RiskType customerCode2
    
    FirmSize customerCode3
    Lov nationality
    String sourceOfIncome
    CustomerDosriCode dosriCode//lov
    //EXTRA FROM SB.200010B
    //citizenship
    String sssNo
    String gisNo
    String tinNo
    String passportNo
    String remarks
    CustomerGroup group
    CustomerStatus status//lov

    static constraints = {
        customer nullable:true
        type nullable:true
        branch nullable:true
        cid nullable:true
        name1 nullable:true
        name2 nullable:true
        name3 nullable:true
        name4 nullable:true
        displayName nullable:true
        shortAddress nullable:true
        pepDescription nullable:true
        amla nullable:true
        birthDate nullable:true
        title nullable:true
        gender nullable:true
        civilStatus nullable:true
        birthPlace nullable:true
        isTaxable nullable:true
        creditLimit nullable:true
        customerCode1 nullable:true
        customerCode2 nullable:true
    
        customerCode3 nullable:true
        nationality nullable:true
        sourceOfIncome nullable:true
        dosriCode nullable:true
        //EXTRA FROM SB.200010B
        //citizenship
        sssNo nullable:true
        gisNo nullable:true
        tinNo nullable:true
        passportNo nullable:true
        remarks nullable:true
        group nullable:true
        status nullable:true
    }
    static mapping = {
		id sqlType: "int", generator: "increment"
    }
}
