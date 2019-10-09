package accounting.fixedasset

class Vendor {

       String companyname
       String contactname
       String address
       String vendortype
       String remarks
       Integer status
       String contactno
       String email    
    
    static constraints = {
        
        companyname(nullable:true)
        contactname(nullable:true)
        address(nullable:true)
        vendortype(nullable:true)
        remarks(nullable:true)
        status(nullable:true)
        contactno(nullable:true)
        email(nullable:true)
        
    }
    
    static mapping = {
        
        id generator: 'identity',
        params: [table: 'vendor', column: 'id']
    }
    
}
