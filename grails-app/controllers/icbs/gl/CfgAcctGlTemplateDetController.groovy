package icbs.gl



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import groovy.sql.Sql
import grails.converters.JSON
import grails.converters.deep.JSON

@Transactional(readOnly = true)
class CfgAcctGlTemplateDetController {

    static allowedMethods = [save: "POST", update: ["PUT","POST"], delete: "DELETE"]
    
    def dataSource
    def index(Integer max) {
      
        params.max = Math.min(max ?: 10, 100)
        if(params.offset==null){
            params.offset=0
        }
        if (params.query == null) {
            respond CfgAcctGlTemplateDet.list(params), model:[params:params,CfgAcctGlTemplateDetInstanceCount:  CfgAcctGlTemplateDet.count()]
            return
        }
        else{
            def CfgAcctGlTemplateDetList = CfgAcctGlTemplateDet.createCriteria().list (params) {
                or {
                    ilike("glCode", "%${params.query}%")
                    ilike("glDescription", "%${params.query}%")
                   }                   
            }
            respond CfgAcctGlTemplateDetList, model:[params:params,CfgAcctGlTemplateDetInstanceCount: CfgAcctGlTemplateDetList.totalCount]
        }
        return
    }

    def show(CfgAcctGlTemplateDet cfgAcctGlTemplateDetInstance) {
        
        respond cfgAcctGlTemplateDetInstance
        
    }
    @Transactional
    def updatecfgacctdet(){
        println("params: "+params)
        def CfgAcctGlTemplateDetInstance = CfgAcctGlTemplateDet.get(params.id.toInteger())
        [CfgAcctGlTemplateDetInstance:CfgAcctGlTemplateDetInstance] 
    }
    
    @Transactional
    def createGlLinkentry(){
        
    }
    @Transactional
    def editCfgDetInformationAjax(){
        def json = request.JSON
        println("########### value from ajax #################################")
        
        println("cfgtemplateid :"+json.cfgtemplateid)
        println("transactionType: "+json.transactiontype)
        println("status: "+json.statustype)
        println("glCode: "+json.glcode)
        println("ordinalPos: "+json.ordinalvalue)
        println("glDescription: "+json.gldescription)
        println("cfgdetid: "+json.cfgdetid) 
        println("############################################")
        
        def CfgAcctGlTemplateDetInstance = CfgAcctGlTemplateDet.get(json.cfgdetid.toInteger())
        
        CfgAcctGlTemplateDetInstance.glDescription = json.gldescription.toString()
        CfgAcctGlTemplateDetInstance.transactionType = json.transactiontype.toInteger()
        CfgAcctGlTemplateDetInstance.glTemplate = CfgAcctGlTemplate.get(json.cfgtemplateid.toInteger())
        CfgAcctGlTemplateDetInstance.status = json.statustype.toInteger()
        CfgAcctGlTemplateDetInstance.ordinalPos = json.ordinalvalue.toString()
        CfgAcctGlTemplateDetInstance.glCode = json.glcode.toString()
        CfgAcctGlTemplateDetInstance.save(flush:true)
        println("editting complete!.....")
        
        render CfgAcctGlTemplateDetInstance as JSON
        
    }
    @Transactional
    def insertnewcfgDetAjax(){
        def json = request.JSON
        def sql = new Sql(dataSource)
        println("cfgtemplateid :"+json.cfgtemplateid)
        println("transactiontype: "+json.transactiontype)
        println("statustype: "+json.statustype)
        println("glcode: "+json.glcode)
        println("ordinalvalue: "+json.ordinalvalue)
        println("gldescription: "+json.gldescription)
        def CfgAcctGlTemplateDetInstance = new CfgAcctGlTemplateDet()
        CfgAcctGlTemplateDetInstance.glDescription = json.gldescription.toString()
        CfgAcctGlTemplateDetInstance.transactionType = json.transactiontype.toInteger()
        CfgAcctGlTemplateDetInstance.glTemplate = CfgAcctGlTemplate.get(json.cfgtemplateid.toInteger())
        CfgAcctGlTemplateDetInstance.status = json.statustype.toInteger()
        CfgAcctGlTemplateDetInstance.ordinalPos = json.ordinalvalue.toString()
        CfgAcctGlTemplateDetInstance.glCode = json.glcode.toString()
        CfgAcctGlTemplateDetInstance.save(flush:true)
        if(CfgAcctGlTemplateDetInstance){
            println("nag save naaa!!!!")
            flash.message= "Successfully Saved!..."
            render CfgAcctGlTemplateDetInstance as JSON
            //redirect(action: "show",controller: "cfgAcctGlTemplate", params: [id: json.cfgtemplateid.toInteger()])
        }else{
            println("Hindi nag save")
            flash.message= "Error..."
            //redirect(action: "show", id: json.cfgtemplateid.toInteger(), params: [id: json.cfgtemplateid.toInteger()])
        }
        
    }
    def checkGlcodeAjax(){
        def json = request.JSON
        def sql = new Sql(dataSource)
        println("glcode :"+json.glcode)
        println("financialyear: "+json.financialyear)
        println("branchid: "+json.branchid)
      
        def queryall = "select * from gl_account  where code= '${json.glcode.toString()}' and branch_id = '${json.branchid.toInteger()}' and financial_year = '${json.financialyear.toInteger()}' and currency_id = 1"
        def resultqueryall = sql.rows(queryall)
        render resultqueryall as JSON
    }
    def checkduplicatesCfgglAcctDetAjax(){
        
        def json = request.JSON
        def sql = new Sql(dataSource)
        
        println("CfgGlAccountTemplate :"+json.cfgtemplateid)
        println("Transaction type :"+json.transactiontype)
        println("StatusType :"+json.statustype)
        println("OrdinalValue :"+json.ordinalvalue)
        println("cfgdetid: "+json.cfgdetid)
        def  queryall = "select * from cfg_acct_gl_template_det where gl_template_id = '${json.cfgtemplateid.toInteger()}' and ordinal_pos = '${json.ordinalvalue.toString()}' and status = '${json.statustype.toInteger()}' and transaction_type = '${json.transactiontype.toInteger()}'"
        def resultqueryall = sql.rows(queryall)
        render resultqueryall as JSON
    }
    def create() {
        respond new CfgAcctGlTemplateDet(params)
    }
     @Transactional
    def updatecfgAcctGlDetAjax(){
        def json = request.JSON
        def sql = new Sql(dataSource)
                                                 
        println("cfgtemplateid: "+json.cfgtemplateid)
        println("glCode: "+json.glCode)  
        println("glDescription: "+json.glDescription)  
        println("cfgdetid: "+json.cfgdetid)  
        def CfgAcctGlTemplateDetInstance = CfgAcctGlTemplateDet.get(json.cfgdetid.toInteger())
        
        CfgAcctGlTemplateDetInstance.glDescription = json.glDescription.toString()
        CfgAcctGlTemplateDetInstance.glCode = json.glCode.toString()
        CfgAcctGlTemplateDetInstance.save(flush:true)
        println("editting complete!.....")
        
        render CfgAcctGlTemplateDetInstance as JSON
        
    }

    @Transactional
    def save(CfgAcctGlTemplateDet cfgAcctGlTemplateDetInstance) {
        if (cfgAcctGlTemplateDetInstance == null) {
            notFound()
            return
        }

        if (cfgAcctGlTemplateDetInstance.hasErrors()) {
            respond cfgAcctGlTemplateDetInstance.errors, view:'create'
            return
        }

        cfgAcctGlTemplateDetInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'cfgAcctGlTemplateDet.label', default: 'CfgAcctGlTemplateDet'), cfgAcctGlTemplateDetInstance.id])
                redirect cfgAcctGlTemplateDetInstance
            }
            '*' { respond cfgAcctGlTemplateDetInstance, [status: CREATED] }
        }
    }

    def edit(CfgAcctGlTemplateDet cfgAcctGlTemplateDetInstance) {
        respond cfgAcctGlTemplateDetInstance
    }

    @Transactional
    def update(CfgAcctGlTemplateDet cfgAcctGlTemplateDetInstance) {
        if (cfgAcctGlTemplateDetInstance == null) {
            notFound()
            return
        }

        if (cfgAcctGlTemplateDetInstance.hasErrors()) {
            respond cfgAcctGlTemplateDetInstance.errors, view:'edit'
            return
        }

        cfgAcctGlTemplateDetInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'CfgAcctGlTemplateDet.label', default: 'CfgAcctGlTemplateDet'), cfgAcctGlTemplateDetInstance.id])
                redirect cfgAcctGlTemplateDetInstance
            }
            '*'{ respond cfgAcctGlTemplateDetInstance, [status: OK] }
        }
    }
    
    

    @Transactional
    def delete(CfgAcctGlTemplateDet cfgAcctGlTemplateDetInstance) {

        if (cfgAcctGlTemplateDetInstance == null) {
            notFound()
            return
        }

        cfgAcctGlTemplateDetInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'CfgAcctGlTemplateDet.label', default: 'CfgAcctGlTemplateDet'), cfgAcctGlTemplateDetInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'cfgAcctGlTemplateDet.label', default: 'CfgAcctGlTemplateDet'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
