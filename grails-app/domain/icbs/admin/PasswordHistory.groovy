package icbs.admin

class PasswordHistory {

	UserMaster userMaster
	String password
	Date dateUsed

    static constraints = {
    }
    
    static mapping = {
        id sqlType:'int', generator:'increment'
    }
}
