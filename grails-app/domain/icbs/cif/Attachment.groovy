package icbs.cif

import icbs.lov.AttachmentType
import icbs.lov.ConfigItemStatus
import icbs.lov.CustomerAttachmentStatus

class Attachment {
    //customer_id
    static belongsTo = [customer:Customer]
    AttachmentType type
    boolean isPrimaryPhoto
    boolean isPrimarySig
    String description
    String fileName//new addition
    byte[] fileData
    String fileType
    String hash
    ConfigItemStatus status
    static constraints = {
        type nullable:false
        status nullable:true
        //end lov
        description nullable:true,maxSize:255
        fileName nullable:true,maxSize:50
        fileType nullable:false
        fileData nullable:false,maxSize:1073741824,validator: { val, obj, errors ->
            if (val.size()>0){
                if(obj.fileType!=null){
                    if(obj.type!=null &&obj.type.id<4)
                    {
                        String[] contentType = obj.fileType.split("\\/"); // String array, each element is text between 
                        if(contentType[0]!="image"){
                            errors.rejectValue('fileData','Only Image Files Are Allowed for Photos,Signatures,and ID Types');
                        }
                    }
                }
            }else{
                if(!obj?.id){
                    //create
                    errors.rejectValue('fileData','File cannot be existing only in your imagination sqrt(-1)');
                }
            }
        }
        hash nullable:true,maxSize:255
        deleted bindable: true
    }
    
    static mapping = {
        id sqlType: "int", generator: "increment"
        description sqlType: "varchar"
        fileName sqlType: "varchar"
        fileData sqlType: "bytea"
        hash sqlType: "varchar"
    }
    
    def beforeInsert(){
        this.status = ConfigItemStatus.get(2)
    }
    def beforeUpdate(){
        /*Do not update when size <1*/
        if(this.fileData.size()<1){
            this.fileData = this.getPersistentValue('fileData')
            this.fileName = this.getPersistentValue('fileName')
            this.fileType = this.getPersistentValue('fileType')
        }
    }
    boolean deleted
    static transients = ['deleted']
}
