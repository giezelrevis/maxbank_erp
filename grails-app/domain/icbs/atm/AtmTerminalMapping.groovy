package icbs.atm
import icbs.admin.Branch
import icbs.lov.ConfigItemStatus

class AtmTerminalMapping {
    Branch branch
    String terminalCode
    ConfigItemStatus terminalStatus
    String remarks
    
    static constraints = {
        branch nullable:false
        terminalCode nullable:true, unique:true
        terminalStatus nullable:false
        remarks nullable:true, maxsize:250
    }
    
    static mapping = {
        id sqlType: 'int', generator: 'increment'
    }
}
