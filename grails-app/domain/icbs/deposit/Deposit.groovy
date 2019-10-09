package icbs.deposit

import icbs.cif.Customer
import icbs.admin.Branch
import icbs.lov.AcctNoFormat
import icbs.lov.DepositStatus
import icbs.lov.DepositType
import icbs.lov.OwnershipType
import icbs.admin.Product
import icbs.gl.CfgAcctGlTemplate
class Deposit {
    //for depositViewMoreInformation show passbook number
    static transients = ['passBookNo'] 
    static belongsTo=[customer:Customer]
    static hasMany=[signatories:Signatory,passbooks:IssuePassbook,chequebooks:Chequebook,
        ctds:IssueCTD,holds:Hold,standingOrders:StandingOrder,sweeps:Sweep,rollovers:Rollover
    ]
    Rollover currentRollover//bago to
    Integer passBookNo
    static mappedBy=[currentRollover:"deposit",rollovers:"deposit",standingOrders:'fundingDeposit',sweeps:'fundingDeposit']
    List signatories = [].withLazyDefault {new Signatory()}
    List passbooks = [].withLazyDefault {new Passbook()}
    List holds = [].withLazyDefault {new Hold()}
    List sweeps = [].withLazyDefault {new Sweep()}
    List rollovers = [].withLazyDefault {new Rollover()}
    Branch branch
    DepositType type
    CfgAcctGlTemplate glLink
    Product product
    String acctNo
    String acctName//new
    AcctNoFormat acctNoFormat
    OwnershipType ownershipType
    String sigRules
    String sigRemarks//new
    DepositInterestScheme depositInterestScheme
    DepositTaxFeeAndChargeScheme depositTaxChargeScheme
    FixedDepositPreTermScheme fixedDepositPreTermScheme
    FixedDepositTermScheme fixedDepositTermScheme
    int lastTermInterval//new addition
   //GL Acct ID
   //GL Acct Orig
    Date dateOpened
    Date dateClosed
    DepositStatus status
    Date statusChangeDate
    //Date startDate //bago
    //Date maturityDate
    //Transaction id
    //Last Customer Transaction Date
    Double ledgerBalAmt
    Double holdBalAmt
    Double availableBalAmt
    Double outstandingBalAmt
    Double passbookBalAmt
    Double grossRolloverInterestAmt// cumulative
    Double netRolloverInterestAmt// cummulative
    Double interestBalAmt//periodic daily balance table dont add, for the day
    Double unclearedCheckBalAmt // total of uncleared checks
    Double lmAveBalAmt
    Double interestRate
    Double acrintAmt
    Date acrintDate
    Double debitAcrintAmt
    Double taxWithheld
    Date debitAcrintDate
    
    Double accruedIntForTheMonth  // updated during EOM, for current month only
    Double accruedTaxForTheMonth  // updated during EOM, for current month only
    Double accruedIntPayable    // updated during EOM, cummulative
    Double accruedTaxPayable    // updated during EOM, cummulative
    Double lastInterestPosted   // updated during EOM interest posting, reset to zero on next capitalization
    int txnWithdrawalsCounterMonthly
    int txnWithdrawalsCounterCummulative
    Integer createdBy
    int txnDepCounterMonthly
    int txnDepCounterCummulative
    
    Date lastCapitalizationDate
    Currency currency
    boolean isSweep
    //rollover type
    int rolloverSequence//rollover count
    //rollover seq
    
    Date dateCreated
    Date maturityDate
    
    Date lastTxnDate
    static constraints = {
        customer nullable:false
        signatories nullable:true
        passbooks nullable:true
        chequebooks nullable:true
        ctds nullable:true
        holds nullable:true
        standingOrders nullable:true
        rollovers nullable:true
        currentRollover nullable:true
        grossRolloverInterestAmt nullable:true, scale: 2
        netRolloverInterestAmt nullable:true, scale: 2 //accrul
        branch nullable:true
        type nullable:false
        glLink nullable:false
        product nullable:false
        acctNo maxSize:30,nullable:true
        acctName maxSize:50, nullable:false
        acctNoFormat nullable:true
        ownershipType nullable:true
        sigRules maxSize:50, nullable:true
        sigRemarks maxSize:255, nullable:true
        depositInterestScheme nullable:true
        depositTaxChargeScheme nullable:false
        fixedDepositPreTermScheme nullable:true
        fixedDepositTermScheme nullable:true
        lastTermInterval nullable:true//new addition
        dateOpened nullable:true
        dateClosed nullable:true
        status nullable:true
        statusChangeDate nullable:true
        ledgerBalAmt nullable:true, scale: 2
        holdBalAmt nullable:true, scale: 2
        availableBalAmt nullable:true, scale: 2
        outstandingBalAmt nullable:true, scale: 2
        passbookBalAmt nullable:true, scale: 2
        interestBalAmt nullable:true, scale: 2
        unclearedCheckBalAmt nullable:true, scale: 2
        lmAveBalAmt nullable:true, scale: 2//savings and current
        interestRate nullable:true, scale: 5
        acrintAmt nullable:true, scale: 2//earned from interest net
        acrintDate nullable:true
        debitAcrintDate nullable:true//wala to
        debitAcrintAmt nullable:true, scale: 2//wala to    
        txnWithdrawalsCounterMonthly nullable:true
        txnWithdrawalsCounterCummulative nullable:true
        lastCapitalizationDate nullable:true
        currency nullable:true
        isSweep nullable:true
        rolloverSequence nullable:true
        createdBy nullable:true
        taxWithheld nullable:true, scale: 2
        dateCreated nullable:true
        unclearedCheckBalAmt nullable:true, scale: 2
        lastTxnDate nullable:true
        accruedIntForTheMonth  nullable:true, scale: 2
        accruedTaxForTheMonth  nullable:true, scale: 2
        accruedIntPayable    nullable:true, scale: 2
        accruedTaxPayable    nullable:true, scale: 2
        lastInterestPosted  nullable:true
        maturityDate nullable:true
    }
    static mapping={
        id sqlType: "int", generator: "increment"
        signatories cascade: "all-delete-orphan"
        
   
    }
    def beforeInsert(){
        this.ledgerBalAmt = 0
        this.holdBalAmt = 0
        this.passbookBalAmt =0
        this.availableBalAmt =0
        this.outstandingBalAmt = 0
        this.interestBalAmt = 0
        this.lmAveBalAmt = 0
        this.acrintAmt = 0
        this.debitAcrintAmt = 0
        this.status = DepositStatus.get(2)
        this.rolloverSequence = 0
        this.dateCreated = Branch.get(1).runDate
        this.statusChangeDate = Branch.get(1).runDate
        this.accruedIntForTheMonth = 0
        this.accruedTaxForTheMonth = 0
        this.accruedIntPayable = 0
        this.accruedTaxPayable = 0
        this.lastInterestPosted = 0  
        this.grossRolloverInterestAmt = 0
        //this.dateOpened = new Date()
        if(this.type.id==3){
          this.acrintDate = Branch.get(1).runDate
        }
        if (!this.interestRate) {
            this.interestRate = 0
        }
    }
    def beforeUpdate(){
        if (this.type.id == 3) {
            if (this.interestRate == null && this.depositInterestScheme.isGraduated) {
                def gradInt = this.depositInterestScheme.graduateds.find { it.startBal <= this.ledgerBalAmt && it.endBal >= this.ledgerBalAmt}
                if (gradInt) {
                    this.interestRate = gradInt.interestRate
                }                
            }
        } else if (this.depositInterestScheme.isGraduated) {
            def gradInt = this.depositInterestScheme.graduateds.find { it.startBal <= this.ledgerBalAmt && it.endBal >= this.ledgerBalAmt}
            if (gradInt) {
                this.interestRate = gradInt.interestRate
            }
        }        
        if (this.type.id == 3) {
            this.passbookBalAmt = this.ledgerBalAmt
            if (this.currentRollover) {
                //make new condition for FD products with monthly credits interest to savings
                // if this.depositInterestScheme.fdMonthlyTransfer == false 
                if(this.depositInterestScheme.fdMonthlyTransfer == false){
                   this.maturityDate = this.currentRollover.endDate
                }
                // if this.depositInterestScheme.fdMonthlyTransfer == true
                // this.maturiyDate will not be changed
            }
            
        }
    }
}
