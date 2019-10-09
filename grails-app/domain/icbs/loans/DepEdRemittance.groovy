package icbs.loans

import icbs.cif.Customer

class DepEdRemittance {

    String batchSerial
    String regNo
    String divCode
    String staCode
    String empCode
    String fnPre
    String fName
    String lName
    String midName
    String appel
    String dedCode
    String dedIdNo
    String effYear
    String effMm
    String terYy
    String terMm
    Double dedAmt
    String policyNo
    String agent
    Double principal
    Double interest
    Double charges
    Double proceeds
    String agency
    Date downDate
    Date payrDate
    Customer customer
    
    static constraints = {
        batchSerial nullable:true
        regNo nullable:true
        divCode nullable:true
        staCode nullable:true
        empCode nullable:true
        fnPre nullable:true
        fName nullable:true
        lName nullable:true
        midName nullable:true
        appel nullable:true
        dedCode nullable:true
        dedIdNo nullable:true
        effYear nullable:true
        effMm nullable:true
        terYy nullable:true
        terMm nullable:true
        dedAmt nullable:true
        policyNo nullable:true
        agent nullable:true
        principal nullable:true
        interest nullable:true
        charges nullable:true
        proceeds nullable:true
        agency nullable:true
        downDate nullable:true
        payrDate nullable:true
        customer nullable:true
    }
    
    static mapping = {
        id sqlType:'int', generator:'increment'
    }
}
