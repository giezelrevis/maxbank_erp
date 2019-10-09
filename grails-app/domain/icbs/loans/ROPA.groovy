package icbs.loans
import icbs.cif.Customer
import icbs.admin.UserMaster
import icbs.admin.Branch

class ROPA {
    Branch branch
    Customer acquiredFrom
    Collateral collateral
    Loan loan
    String loanAcctNo
    String customerDisplayName
    Double loanBalance
    Date ropaDate
 
    Double costsCapitalized
    Double provisionAmt
    Double provisionRate
    Double allocatedBookValueLand
    Double allocatedBookValueBuilding
    Double accumulatedDepreciationBuilding
    Double allowanceBuilding
    Double otherCosts
    Double allowanceOthers
    String formerTitle
    String kindOfLand
    Double landArea
    String location
    Date dateOfCertificate
    Date dateOfCertificateRegistration
    Date dateConsolidated
    String newTct
    Double landAppraisal
    Double buildingAppraisal
    Double otherAppraisal
    Date dateOfAppraisal
    String appraisedBy
    String fireInsurancePolicyNo
    Double fireInsuranceAmt
    Date fireInsuranceDate
    Double provisionForFireInsurance
    
    String glContraLitigationExp
    String glContraRopa
    
    UserMaster createdBy
    Date dateCreated
    
    static constraints = {
        branch nullable:true
        acquiredFrom nullable:true
        collateral nullable:true
        loan nullable:true
        loanAcctNo nullable:true
        customerDisplayName nullable:true
        loanBalance min:0D, scale:2, nullable:true
        ropaDate nullable:true
 
        costsCapitalized min:0D, scale:2, nullable:true
        provisionAmt min:0D, scale:2, nullable:true
        provisionRate min:0D, scale:5, nullable:true
        allocatedBookValueLand min:0D, scale:2, nullable:true
        allocatedBookValueBuilding min:0D, scale:2, nullable:true
        accumulatedDepreciationBuilding min:0D, scale:2, nullable:true
        allowanceBuilding min:0D, scale:2, nullable:true
        otherCosts min:0D, scale:2, nullable:true
        allowanceOthers min:0D, scale:2, nullable:true
        formerTitle nullable:true
        kindOfLand nullable:true
        landArea min:0D, scale:5, nullable:true
        location nullable:true
        dateOfCertificate nullable:true
        dateOfCertificateRegistration nullable:true
        dateConsolidated nullable:true
        newTct nullable:true
        landAppraisal min:0D, scale:2, nullable:true
        buildingAppraisal min:0D, scale:2, nullable:true
        otherAppraisal min:0D, scale:2, nullable:true
        dateOfAppraisal nullable:true
        appraisedBy nullable:true
        fireInsurancePolicyNo nullable:true
        fireInsuranceAmt min:0D, scale:2, nullable:true
        fireInsuranceDate nullable:true
        provisionForFireInsurance min:0D, scale:2, nullable:true
        glContraRopa nullable:true
        glContraLitigationExp nullable:true
        createdBy nullable:true
        dateCreated nullable:true        
    }
    
    static mapping = {
        id sqlType: "int", generator: "increment"
    }
}
