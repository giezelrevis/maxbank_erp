// loan_kind_of_loan
package icbs.lov

class LoanKindOfLoan {
    
    String code
        String description
        String shortDescription
        boolean status 

    static constraints = {
        code maxSize:10, unique:true
        description maxSize:75, unique:true
        shortDescription nullable:true, maxSize:10
    }
    static mapping = {
        id sqlType:'smallint'
        id generator:'increment'
    }
    
    String toString () {
        return description
    } 
    
    String getCodeDescription() {
        "${code} - ${description}"
    }
}

/*
The following list of values are follows:

1. New Loan
2. Separate Loan
3. Reloan
4. Extension
5. Renewal

*/