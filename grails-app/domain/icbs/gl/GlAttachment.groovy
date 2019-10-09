package icbs.gl
import icbs.admin.Branch
import icbs.admin.UserMaster
import icbs.lov.ConfigItemStatus

class GlAttachment {

    String reference
    String particulars
    String filename
    String batchId
    byte[] filedata
    Date uploadDate = new Date()
    UserMaster attachedBy
    Branch branch
    ConfigItemStatus status
    
    static constraints = {
        filename(blank:false,nullable:false)
        filedata(blank: true, nullable:true, maxSize:1073741824)
    }
    
    static mapping = {
      id sqlType: "int", generator: "increment"
      branch sqlType: "int"
      postedBy sqlType: "int"
      attachedBy sqlType: "int"
    }
    
}
