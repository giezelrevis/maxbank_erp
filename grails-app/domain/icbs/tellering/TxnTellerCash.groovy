package icbs.tellering

import icbs.admin.UserMaster
import icbs.admin.Currency
import icbs.admin.CurrencyDetail
import icbs.tellering.TxnFile

class TxnTellerCash {

    String txnRef
    UserMaster user
    Double txnAmt
    Currency currency
    CurrencyDetail currencydetail
    Integer billcount
//    Integer bills1000
//    Integer bills500
//    Integer bills200
//    Integer bills100
//    Integer bills50
//    Integer bills20
//    Integer bills10
//    Integer bills5
//    Integer bills2
//    Integer bills1
//    Integer coins10
//    Integer coins5
//    Integer coins1
//    Integer coins050
//    Integer coins025
//    Integer coins010
//    Integer coins005
//    Integer coins001
//    Double total1000
//    Double total500
//    Double total200
//    Double total100
//    Double total50
//    Double total20
//    Double total10
//    Double total5
//    Double total2
//    Double total1
//    Double total0100
//    Double total050
//    Double total025
//    Double total010
//    Double total005
//    Double total001
    //String denomination
    //Integer billCount
    //Double[] denominationVal = [1000, 500, 200, 100, 50, 20, 1, 0.01] as Double[]
    //Double totalAmtPerDenomination
    String hash
    TxnFile txnFile
    static hasMany=[checks:TxnCOCI]
    
    static constraints = {
        txnRef nullable:false
        user nullable:true
        txnAmt nullable:false, min:0d, scale:2
        currency nullable:true
        currencydetail nullable:true
        billcount nullable:true
        
//        bills1000 nullable:true
//        bills500 nullable:true
//        bills200 nullable:true
//        bills100 nullable:true
//        bills50 nullable:true
//        bills20 nullable:true
//        bills10 nullable:true
//        bills5 nullable:true
//        bills2 nullable:true
//        bills1 nullable:true
//        coins10 nullable:true
//        coins5 nullable:true
//        coins1 nullable:true
//        coins050 nullable:true
//        coins025 nullable:true
//        coins010 nullable:true
//        coins005 nullable:true
//        coins001 nullable:true
//        total1000 nullable:true
//        total500 nullable:true
//        total200 nullable:true
//        total100 nullable:true
//        total50 nullable:true
//        total20 nullable:true
//        total10 nullable:true
//        total5 nullable:true
//        total2 nullable:true
//        total1 nullable:true
//        total050 nullable:true
//        total025 nullable:true
//        total010 nullable:true
//        total005 nullable:true
//        total001 nullable:true
//        total0100 nullable:true
        //denomination nullable:true
        //billCount nullable:true
        //denominationVal nullable:true
        //totalAmtPerDenomination nullable:true
        hash nullable:true
        txnFile nullable:true
        checks nullable:true
    }
    
    static mapping = {
        id sqlType: 'int', generator: 'increment'
        txnRef sqlType: 'varchar'
    }
}
