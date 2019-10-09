package icbs.admin

import icbs.lov.ConfigItemStatus

class BranchProduct {

	Branch branch
	Product product
    ConfigItemStatus configItemStatus
	// BigDecimal minOpen
	// BigDecimal maxOpen
	// BigDecimal minBalance
	// BigDecimal maxBalance
	// Integer minTerm
	// Integer maxTerm
	// boolean status
	// String hash

    static constraints = {
    	
    }

    static mapping = {
    	branch sqlType:'int'
    	product sqlType:'int'
        configItemStatus sqlType:'smallint'
        id sqlType:'int', generator:'increment'
    	// minOpen sqlType:'numeric(24,8)'
    	// maxOpen sqlType:'numeric(24,8)'
    	// minBalance sqlType:'numeric(24,8)'
    	// maxBalance sqlType:'numeric(24,8)'
    	// minTerm sqlType:'smallint'	
    	// maxTerm sqlType:'smallint'
    }
}
