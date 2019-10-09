package icbs.admin

import icbs.lov.Gender
import icbs.lov.Designation
import icbs.lov.ConfigItemStatus
import icbs.lov.Lov
import icbs.gl.GlAccount

class UserMaster {

	String username
	String password
    // String confirmPassword
	String name1
	String name2
	String name3
	String name4
	Date birthdate
	Gender gender
	String address1
	String address2
	Lov province
	String zipCode
	String email
	String contact
	Date dateHired
	Designation designation
	Branch branch
    GlAccount cash
    GlAccount coci
	Lov employmentType
	Date expiryDate
        Date expiryPwdDate
    boolean isLocked
    boolean hasExceededMaxLogin
    boolean isFirstLogin
    boolean isTellerBalanced
	ConfigItemStatus configItemStatus

    String getName() {
        "${name1} ${name2 ?: ''} ${name3}"
    }

    static belongsTo = [Role]

    static hasMany = [roles: Role]

    static constraints = {
    	username maxSize:20, unique:true
    	password nullable:false
        // confirmPassword blank:true
    	name1 maxSize:50
    	name2 maxSize:50, nullable:true  
    	name3 maxSize:50, nullable:false
    	name4 maxSize:50, nullable:true
    	birthdate nullable:false
    	gender nullable:false
    	address1 maxSize:100
    	address2 maxSize:100, nullable:true
    	province nullable:true
    	zipCode maxSize:10
    	email maxSize:100
    	contact maxSize:30
    	dateHired nullable:true
    	designation nullable:false
    	branch nullable:false
        cash nullable:true
        coci nullable:true
    	employmentType nullable:false
    	expiryDate nullable:false
        expiryPwdDate nullable:true
    	configItemStatus blank:true
    }

    static mapping = {
        roles joinTable: [name:'user_role', key:'user_master_id']
    	id sqlType:'int', generator:'increment'
    	gender sqlType:'smallint'
    	designation sqlType:'smallint'
    	branch sqlType:'int'
    	configItemStatus sqlType:'smallint'
        province sqlType:'int'
        employmentType sqlType:'int'
    }

    static transients = ['name']
}
