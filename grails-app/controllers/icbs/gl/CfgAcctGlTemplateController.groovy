package icbs.gl



import static org.springframework.http.HttpStatus.*
import icbs.lov.GlLinkEntryType							   
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CfgAcctGlTemplateController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        if(params.offset==null){
            params.offset=0
        }
        if (params.query == null) {
            respond CfgAcctGlTemplate.list(params), model:[params:params,CfgAcctGlTemplateInstanceCount:  CfgAcctGlTemplate.count()]
            return
        }
        else{
            def CfgAcctGlTemplateList = CfgAcctGlTemplate.createCriteria().list (params) {
                or {
                    ilike("description", "%${params.query}%")
                   }                
            }
            respond CfgAcctGlTemplateList, model:[params:params,CfgAcctGlTemplateInstanceCount: CfgAcctGlTemplateList.totalCount]
        }
        return
    }

    def show(CfgAcctGlTemplate cfgAcctGlTemplateInstance,Integer max) {
        
        respond cfgAcctGlTemplateInstance 
    }

    def create() {
        respond new CfgAcctGlTemplate(params)
    }
    @Transactional
    def glLinkEntry(){
        
    }
    @Transactional
    def glLinkCreateNewEntry(){
        
    }
    @Transactional
    def addGlLinkEntry(){
        println("params: "+params)
        def gldescription = params.description
        def glLinkEntryselect = params.glLinkEntry.toInteger()
        
        println("gldescription: "+gldescription)
        println("glLinkEntryselect: "+glLinkEntryselect)
        
        def glCfgAcctGlTemplate = new CfgAcctGlTemplate()
        glCfgAcctGlTemplate.description = gldescription
        glCfgAcctGlTemplate.type = glLinkEntryselect
        glCfgAcctGlTemplate.save(flush:true)
        redirect action: "index"
    }
    @Transactional
    def save(CfgAcctGlTemplate cfgAcctGlTemplateInstance) {
        if (cfgAcctGlTemplateInstance == null) {
            notFound()
            return
        }

        if (cfgAcctGlTemplateInstance.hasErrors()) {
            respond cfgAcctGlTemplateInstance.errors, view:'create'
            return
        }

        cfgAcctGlTemplateInstance.save flush:true

        def links = params.list('links')
        
        links.each {
            CfgAcctGlTemplateDet cfgLink = new CfgAcctGlTemplateDet(link:it).save(flush:true)
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'cfgAcctGlTemplate.label', default: 'CfgAcctGlTemplate'), cfgAcctGlTemplateInstance.id])
                redirect cfgAcctGlTemplateInstance
            }
            '*' { respond cfgAcctGlTemplateInstance, [status: CREATED] }
        }
    }

    def edit(CfgAcctGlTemplate cfgAcctGlTemplateInstance) {
        respond cfgAcctGlTemplateInstance
    }

    @Transactional
    def update(CfgAcctGlTemplate cfgAcctGlTemplateInstance) {
        if (cfgAcctGlTemplateInstance == null) {
            notFound()
            return
        }

        if (cfgAcctGlTemplateInstance.hasErrors()) {
            respond cfgAcctGlTemplateInstance.errors, view:'edit'
            return
        }

        cfgAcctGlTemplateInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'CfgAcctGlTemplate.label', default: 'CfgAcctGlTemplate'), cfgAcctGlTemplateInstance.id])
                redirect cfgAcctGlTemplateInstance
            }
            '*'{ respond cfgAcctGlTemplateInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(CfgAcctGlTemplate cfgAcctGlTemplateInstance) {

        if (cfgAcctGlTemplateInstance == null) {
            notFound()
            return
        }

        cfgAcctGlTemplateInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'CfgAcctGlTemplate.label', default: 'CfgAcctGlTemplate'), cfgAcctGlTemplateInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'cfgAcctGlTemplate.label', default: 'CfgAcctGlTemplate'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
