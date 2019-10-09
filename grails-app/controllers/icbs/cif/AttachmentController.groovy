package icbs.cif



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

class AttachmentController {
    //static allowedTypes=['zip','jpeg','ppt','pptx']
    def download =  {
        def attachmentInstance = Attachment.read( params.id ) // get the record
        if(attachmentInstance){
            response.setContentType("APPLICATION/OCTET-STREAM")
            response.setHeader("Content-Disposition", "Attachment;Filename=\"${attachmentInstance.fileName}\"")
            response.setContentType(attachmentInstance.fileType)//set content type
            response.outputStream << attachmentInstance.fileData
            response.outputStream.flush()
            response.outputStream.close()
        }else{
            //error here
        }
    }
    def show = {
        def attachmentInstance = Attachment.read( params.id ) // get the record
        if(attachmentInstance){
             String[] contentType = attachmentInstance.fileType.split("\\/"); // String array, each element is text between 
             if(contentType[0]=="image"){
                 //show image files
                 showImage(attachmentInstance)
             }
             if(contentType[0]=="text"){
                 //show image files
                 showText(attachmentInstance)
             }
             if(contentType[0]=="application"){
                 //show image files
                 showText(attachmentInstance)
             }
             
              showImage(attachmentInstance)
        }else{
            //errors
        }
    }
    
    private def showImage(Attachment attachmentInstance){
        response.setHeader("Content-Disposition", "inline;Filename=\"${attachmentInstance.fileName}\"")
        response.setContentType(attachmentInstance.fileType)//set content type
        response.outputStream << attachmentInstance.fileData // write the image to the outputstream
        response.outputStream.flush()
        response.outputStream.close()
    }
    private def showText(Attachment attachmentInstance){
        response.setHeader("Content-Disposition", "inline;Filename=\"${attachmentInstance.fileName}\"")
        response.setContentType(attachmentInstance.fileType)//set content type
        response.outputStream << attachmentInstance.fileData // write the image to the outputstream
        response.outputStream.flush()
        response.outputStream.close()
    }
    private def showApplication(Attachment attachmentInstance){
        response.setHeader("Content-Disposition", "inline;Filename=\"${attachmentInstance.fileName}\"")
        response.setContentType(attachmentInstance.fileType)//set content type
        response.outputStream << attachmentInstance.fileData // write the image to the outputstream
        response.outputStream.flush()
        response.outputStream.close()
    }
}