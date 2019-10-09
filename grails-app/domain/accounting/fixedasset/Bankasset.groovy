package accounting.fixedasset

class Bankasset {

        //static hasMany = [glacc:GlAccount, ebitglacc:GlAccount, creditglacc:GlAccount, vendorlink:Vendor]

        String assetcode
        String assetdesc
        Date assetexpire
        String assetserial
        String assetpo
        Integer isnew
        String purdesc
        Date purdate
        Double purcost
        Double salvagevalue
        Double deprevalue
        Integer lifeinyears
        Double annualexpense
        String glacc
        String userid
        Integer tag
        String ebitglacc
        String creditglacc
        String vendorlink
        Double soldamt
        Integer noofinstallment
        String assacc
        Integer tag2
        Double monthlyexpense
    
    static constraints = {
    
         assetcode(blank:false, nullable:false, unique:true)
         assetdesc(blank:false, nullable:false)
         assetexpire(nullable:true)
         assetserial(blank:false, nullable:false)
         assetpo(blank:false, nullable:false)
         isnew(nullable:true)
         purdesc(nullable:true)
         purdate(blank:false, nullable:false)
         purcost(nullable:false)
         salvagevalue(nullable:false)
         deprevalue(nullable:false)
         lifeinyears(nullable:false)
         annualexpense(nullable:false)
         glacc(nullable:true)
         userid(nullable:true)
         tag(nullable:true)
         ebitglacc(nullable:true)
         creditglacc(nullable:true)
         vendorlink(nullable:true)
         soldamt(nullable:true)
         noofinstallment(nullable:true)
         assacc(nullable:true)
         tag2(nullable:true)
         monthlyexpense(blank:false, nullable:false)

    }
    
    static mapping = {
        id generator: 'identity',
        params: [table: 'bankasset', column: 'id']
    }

}
