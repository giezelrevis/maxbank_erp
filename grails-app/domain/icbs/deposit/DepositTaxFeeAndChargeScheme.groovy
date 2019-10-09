package icbs.deposit

import icbs.lov.TaxFeeCharge
import icbs.lov.TfcSpecialCalculationType
import icbs.admin.TxnTemplate

class DepositTaxFeeAndChargeScheme {
    String code
    String name
    String description
    TaxFeeCharge type
    Double taxRate
    Double feeRate
    Double feeAmt
    Double chargeRate
    Double chargeAmt
    TfcSpecialCalculationType specialCalculation
    boolean feeBaseAmtCondition
    boolean feeCountCondition//based sa transaction withdrawals for the month
    int gracePeriod
    double feeRateBasis
    double chargeRateBasis
    boolean isApplyToClosingBal
    Double minAmtException

    // static belongsTo = [TxnTemplate]

    static hasMany = [txnTemplates: TxnTemplate]

    static constraints = {
        code maxSize: 10, unique: true, nullable: false, blank: false
        name maxSize: 50, unique: true, nullable: false, blank: false
        type nullable:false
        taxRate scale: 5, nullable: true, blank: false, min: 0d
        feeRate scale: 5, nullable: true, blank: false, min: 0d
        feeAmt nullable:true, min: 0d
        chargeRate scale: 5, nullable: true, blank: false, min: 0d
        chargeAmt nullable:true, min: 0d, scale: 2
        specialCalculation nullable:false
        feeBaseAmtCondition nullable:true
        feeCountCondition nullable:true
        gracePeriod nullable:true, min: 0
        feeRateBasis nullable:true, min: 0d, scale: 2
        chargeRateBasis nullable:true, min: 0d
        isApplyToClosingBal nullable:true
        minAmtException nullable:true, min: 0d, scale: 2
    }
    static mapping = {
    	id sqlType: "int", generator: "increment"
        //status sqlType: "smallint"?
        txnTemplates joinTable: [name:'txn_charge', key:'charge_id']
    }
    
    String toString(){
        return this.code+":"+this.name
    }
    
    def beforeInsert() {
       
    }
}
