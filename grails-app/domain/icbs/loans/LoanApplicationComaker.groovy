package icbs.loans

import icbs.cif.Customer

class LoanApplicationComaker {	
	LoanApplication loanApplication
	Customer customer

    static constraints = {
        customer (validator: { val, obj, errors ->
            /*You cannot have a relationship with your own!*/
            println("pumasok dito sa customer validator!")
            if(val?.id!=null && obj.loanApplication.customer?.id!=null){
                if(obj.loanApplication.customer.id==val.id){
                    errors.rejectValue('customer.name1', 'You cannot be co-maker with your own account!')
                    errors.rejectValue('customer.name2', 'You cannot be co-maker with your own account!')
                    errors.rejectValue('customer.name3', 'You cannot be co-maker with your own account!')
                    errors.rejectValue('customer.name4', 'You cannot be co-maker with your own account!')
                    errors.rejectValue('customer', 'You cannot be co-maker with your own account!')
                    println("duplicate 1!")
                }
                /*If you have existing relationship with that person*/
                /*def customerInstance = Customer.read(obj.customer.id)*/
                if(obj.id==null){
                    def rel = LoanApplicationComaker.find{loanApplication.id==obj.loanApplication.id && customer.id==val.id}
                    if(rel){
                        errors.rejectValue('customer.name1', 'You cannot be co-maker with your own account!')
                        errors.rejectValue('customer.name2', 'You cannot be co-maker with your own account!')
                        errors.rejectValue('customer.name3', 'You cannot be co-maker with your own account!')
                        errors.rejectValue('customer.name4', 'You cannot be co-maker with your own account!')
                        println("duplicate 2!")
                    }
                }   
            }
        },nullable:true)
    }
    static mapping = {
        id sqlType:'int', generator:'increment'
    	version false
    	loanApplication sqlType: "int"
    	customer sqlType: "int"
    }
}
