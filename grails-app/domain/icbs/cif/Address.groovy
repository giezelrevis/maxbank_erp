package icbs.cif

import icbs.lov.AddressStatus
import icbs.lov.AddressType
import icbs.lov.ConfigItemStatus
import icbs.lov.Language
import icbs.lov.Lov
import icbs.lov.Town

class Address {
    static belongsTo = [customer:Customer]
    //customer_id
    AddressType type//lov
    boolean isPrimary
    boolean isMailing
    boolean isOwned
    boolean isMortaged
    boolean isRented
    String address1
    String address2
    String address3
    String postalCode
    String residenceSince
    Lov countryId
    Town town
    //Wala sa data dictionary
    String phone1
    String phone2
    String phone3
    String phone4
    Date addressSince
    //end wala sa data dicitionary
    String shortAddress
    String longLatLocation
    String addressContact
    String remarks
    String hash
    ConfigItemStatus status//lov
    Lov languageId//lov

    static constraints = {
        type nullable:true
        status nullable:true
        languageId nullable: true
        countryId nullable:true
        //end lov
        address1 nullable:false,maxSize:200
        address2 nullable:false,maxSize:200
        //address3= postalcode in view
        address3 nullable:false,maxSize:100
        town nullable:false,maxSize:100
        postalCode nullable:true,maxSize:10
        shortAddress nullable:true,maxSize:100
        addressContact nullable:true,maxSize:30
        //start wala sa data dictionary
        phone1 nullable:true,maxSize:30
        phone2 nullable:true,maxSize:30
        phone3 nullable:true,maxSize:30
        phone4 nullable:true,maxSize:30
        residenceSince nullable:true,maxSize:10
        addressSince nullable:true
        //end wala sa data dictionary
        longLatLocation nullable:true,maxSize:30
        hash nullable:true,maxSize:255
        remarks nullable:true,maxSize:255
        isRented nullable:true
        deleted bindable:true
    }
    def beforeInsert(){
        this.status = ConfigItemStatus.get(2)
    }
    static mapping = {
        id sqlType: "int", generator: "increment"
        address1 sqlType: "varchar"
        address2 sqlType: "varchar"
        address3 sqlType: "varchar"
        postalCode sqlType: "varchar"
        shortAddress sqlType: "varchar"
        longLatLocation sqlType: "varchar"
        addressContact sqlType: "varchar"
        remarks sqlType: "varchar"
        hash sqlType: "varchar"
    }
    boolean deleted
    static transients = ['deleted']
}
