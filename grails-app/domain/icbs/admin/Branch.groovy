package icbs.admin

import icbs.lov.BranchRunStatus
import icbs.lov.BranchStatus
import icbs.lov.Lov
import icbs.gl.GlAccount

class Branch {

	Integer code
	String name
	String swiftCode
        
	String address
	Lov country
	Lov region
	String contactNumber
	UserMaster manager
	Date openDate
	boolean dataCenter
	String taxNo
        boolean openOnMon
        boolean openOnTue
        boolean openOnWed
        boolean openOnThu
        boolean openOnFri
        boolean openOnSat
        boolean openOnSun
        Date newRunDate
	Date runDate
       
        boolean isTelleringActive
	BranchRunStatus branchRunStatus
	BranchStatus status
        
        GlAccount dueToGl
        GlAccount dueFromGl
        GlAccount yearEndClosingGl
        GlAccount iccContra

    String defDueToFromAcct
    
    static hasMany = [products: Product, clearingBanks: ClearingBank, checkDepositClearingTypes:CheckDepositClearingType, holidays:Holiday]

    static constraints = {
    	code min:0, max:999, unique:true
    	name maxSize:50, unique:true
    	swiftCode maxSize:50
    	address maxSize:255
    	country nullable:true
    	region nullable:true
    	contactNumber nullable:true
    	manager nullable:true
    	openDate nullable:true
    	dataCenter nullable:false
    	taxNo maxSize:50, nullable:true
        openOnMon nullable:false
        openOnTue nullable:false
        openOnWed nullable:false
        openOnThu nullable:false
        openOnFri nullable:false
        openOnSat nullable:false
        openOnSun nullable:false
    	runDate nullable:true
        newRunDate nullable:true
    	branchRunStatus nullable:true
        isTelleringActive nullable:true
        defDueToFromAcct nullable:true
        dueToGl nullable:true
        dueFromGl nullable:true
        iccContra nullable:true
        yearEndClosingGl nullable:true
    }

    static mapping = {
        products joinTable: [name:'branch_product', key:'branch_id']
        clearingBanks joinTable: [name:'branch_clearing_bank', key:'branch_id']
        checkDepositClearingTypes joinTable: [name:'branch_check_deposit_clearing_type', key:'branch_id']
        holidays joinTable: [name:'branch_holiday', key:'branch_id']
    	id sqlType:'int', generator:'increment'
    	openDate sqlType:'date'
    }
    
    def beforeInsert() {
        this.isTelleringActive = false
    }
    def beforeUpdate() {

    }
}
