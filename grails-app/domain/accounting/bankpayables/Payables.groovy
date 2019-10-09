package accounting.bankpayables

class Payables {

       Integer trnid
       Date transdate
       String clientname
       Double checkamt
       Integer checknumber
       Integer status
       String trntype
       Integer acc
       Integer apptype
       String glaccount
       Date duedate
       String particulars

    static constraints = {
        
        trnid(blank:false, nullable:false, unique: true)
        transdate(nullable:true)
        clientname(blank:false, nullable:false)
        checkamt(nullable:false)
        checknumber(nullable:true)
        status(nullable:true)
        trntype(nullable:true)
        acc(nullable:true)
        apptype(nullable:true)
        glaccount(nullable:true)
        duedate(nullable:true)
        particulars(nullable:true)
        
    }
    
    static mapping = {
        
        id generator: 'identity',
        params: [table: 'payables', column: 'id']
    }
    
}
