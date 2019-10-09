package icbs.admin



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import icbs.admin.InstitutionConfig
import groovy.sql.Sql
import groovy.json.JsonBuilder
import grails.converters.JSON
import grails.converters.deep.JSON
@Transactional(readOnly = true)
class InstitutionController {
   
    static allowedMethods = [update: "PUT"]
    def dataSource
    def index(Integer max) {
        // params.max = Math.min(max ?: 50, 100)
        
        //respond Institution.listOrderById(params), model:[InstitutionInstanceCount: Institution.count()]
        params.max = Math.min(max ?: 10, 100)

        if (params.sort == null) {  // default ordering
            
        }

        if (params.query == null) {  // show all instances            
            respond Institution.list(params), model:[InstitutionInstanceCount: Institution.count()]
        }
        else {    // show query results
            def institutionList = Institution.createCriteria().list(params) {
                or {
                    ilike("paramCode", "%${params.query}%")
                    ilike("paramType", "%${params.query}%")
                    ilike("paramValue", "%${params.query}%")
                    ilike("caption", "%${params.query}%")
                }
            }
            respond institutionList, model:[InstitutionInstanceCount: institutionList.totalCount]
        }        
    }

    def edit(Integer max) {
        params.max = Math.min(max ?: 50, 100)
        respond Institution.list(params), model:[InstitutionInstanceCount: Institution.count()]
    }
    @Transactional
    def updateParamvalue(){
        def json = request.JSON
        def sql = new Sql(dataSource)
        def updateParamvalue = Institution.get()
        
       println "json.paramcode" + json.paramcode
  
//        def getinstitutionid = "select id from institution where param_code='"+json.paramcode+"'"
//        def institutionid = sql.rows(getinstitutionid)
//        
            println "json paramcode" +  json.paramcode
            
            def updateInsititution = "UPDATE institution SET param_value ='"+json.paramval+"' where param_code ='"+json.paramcode+"'"
            def updatesuccess = sql.execute(updateInsititution)
            render ([updatesuccess:updatesuccess]) as JSON
    }

    @Transactional
    def update() {
        def institutionConfig = new InstitutionConfig(params)

        println params

        institutionConfig.validate()

        if (institutionConfig.hasErrors()) {
            respond institutionConfig.errors, view:'edit'
            return
        }


        def institution = Institution.listOrderById()

        institution[0].paramValue = params.institutionName
        institution[1].paramValue = params.institutionCode

        for (i in 0..1) {
            institution[i].save(flush: true, failOnError: true)
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'Institution.label', default: 'Institution')])
        redirect(action: "index")
    }
    @Transactional
    def createNewInstitutionAjax() {
        def json = request.JSON
        def sql = new Sql(dataSource)
        println("paramcode: "+json.paramcode.toString())
        println("caption: "+json.caption.toString())
        println("paramval: "+json.paramval.toString())
        println("paramtype: "+json.paramtype.toString())
        def newInstitutionInstance = new Institution()
        newInstitutionInstance.paramCode = json.paramcode.toString()
        newInstitutionInstance.paramType = json.paramtype.toString()
        newInstitutionInstance.paramValue = json.paramval.toString()
        newInstitutionInstance.caption = json.caption.toString()
        newInstitutionInstance.save(flush: true)
        def redirectBacktoInsititution = "select * from institution limit 1"
        def returnbckToInstitution = sql.rows(redirectBacktoInsititution)
        render returnbckToInstitution as JSON
        
    }
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'institution.label', default: 'Institution'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
