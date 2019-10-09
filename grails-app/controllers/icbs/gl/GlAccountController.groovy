package icbs.gl



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import icbs.admin.Branch
import icbs.admin.UserMaster
import icbs.admin.Currency
import icbs.loans.LoanDeductionScheme

@Transactional(readOnly = true)
class GlAccountController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def GlTransactionService
    
    def index(Integer max) {
         //glAccountInstance.save flush:true
        
        params.max = Math.min(max ?: 10, 100)
        if(params.offset==null){
            params.offset=0
        }
        if (params.query == null) {
            def GlAccountList = GlAccount.createCriteria().list (params) {
                and  {
                    eq("branch",UserMaster.get(session.user_id).branch )
                    eq("financialYear", Branch.get(1).runDate.format('yyyy').toInteger())
                    eq("currency",Currency.get(1))
                }
                order("code", "asc")
            }
            respond GlAccountList, model:[params:params,GlAccountInstanceCount: GlAccountList.totalCount]
            return
        }
        else{
            def GlAccountList = GlAccount.createCriteria().list (params) {               
                and  {
                    eq("branch",UserMaster.get(session.user_id).branch )
                    eq("financialYear", Branch.get(1).runDate.format('yyyy').toInteger())
                    eq("currency",Currency.get(1))
                }                
                or  {
                    ilike("code", "%${params.query}%")
                    ilike("name","%${params.query}%")
                }
                order("code", "asc")
            }
            respond GlAccountList, model:[params:params,GlAccountInstanceCount: GlAccountList.totalCount]
        }
        return
    }

    def show(GlAccount glAccountInstance) {
        respond glAccountInstance
    }

    def create() {
        respond new GlAccount(params)
    }

    @Transactional
    def save(GlAccount glAccountInstance) {
        if (glAccountInstance == null) {
            notFound()
            return
        }
        
        // check for duplicates
        def Gl = GlAccount.findByCode(glAccountInstance.code)
        if (Gl) {
            flash.message = 'Duplicate GL Account'
            respond glAccountInstance.errors, view:'create'
            return            
        }
        
        // check for empty sort code
        /*
        if (!params.parent.sortName) {
            flash.message = 'Sort Name is null'
            respond glAccountInstance.errors, view:'create'
            return             
        }
        */

        if (glAccountInstance.hasErrors()) {
            flash.message = 'GL Account has errors'
            respond glAccountInstance.errors, view:'create'
            return
        }

        GlTransactionService.saveGlAccountsToMultipleBranches(params)

        redirect action: "index"
    }

    def edit(GlAccount glAccountInstance) {
        respond glAccountInstance
    }

    @Transactional
    def update(GlAccount glAccountInstance) {
        if (glAccountInstance == null) {
            notFound()
            return
        }

        if (glAccountInstance.hasErrors()) {
            respond glAccountInstance.errors, view:'edit'
            return
        }
        
        glAccountInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'GlAccount.label', default: 'GlAccount'), glAccountInstance.id])
                redirect glAccountInstance
            }
            '*'{ respond glAccountInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(GlAccount glAccountInstance) {
        println("params: "+params)
        if (glAccountInstance == null) {
            notFound()
            return
        }
        
        def errMsg
        Boolean removeThis = true
        def gls = GlAccount.findAllByCode(glAccountInstance.code) 
        println gls
        for (gl in gls) {
            if (gl.debit > 0 || gl.credit > 0) {
                errMsg = 'transaction'
                removeThis = false
            } 
            def brs = Branch.list()
            for (br in brs) {
                if (br.dueFromGl.id == gl.id || br.dueToGl.id == gl.id || br.yearEndClosingGl.id == gl.id) {
                    errMsg = 'branch'
                    removeThis = false
                }
            }
            def user = UserMaster.list()
            for (u in user) {
                println("u.cash.id: "+u?.cash?.id)
                println("gl.id: "+gl?.id)
                println("u.coci.id: "+u?.coci?.id)
                if (u?.cash?.id == gl?.id || u?.coci?.id == gl?.id) {
                    errMsg = 'user'
                    removeThis = false
                }
            }
            def lnds = LoanDeductionScheme.list()
            for (ld in lnds) {
                if (ld.contraAcct.id == gl.id) {
                    errMsg = 'loan deduction scheme'
                   removeThis = false 
                }
            }
        }
        
        if (!removeThis) {
            flash.message = message(code: 'Foreign key violation, cannot delete * ' + errMsg, args: [message(code: 'GlAccount.label', default: 'GlAccount'), glAccountInstance.id])
            respond glAccountInstance.errors, view:'show'
            return
        } else {
            def glDel = GlAccount.findAllByCode(glAccountInstance.code) 
            for (gld in glDel) {
                println ("Removing from the Gl Account Table....."+gld) 
                //gld.delete flush:true
                try{
                    gld.delete(failOnError:true)
                    println("Successfully Removed..")
                    println("---------------------------------------------")
                }                
                catch(e) {
                    flash.message = message(code: 'default.deleted.message', args: [message(code: 'GlAccount.label', default: 'GlAccount'), glAccountInstance.id])
                    respond glAccountInstance.errors, view:'show'
                    return                    //it didn't work, do something about it here
                }
            }
                        
        }
        //glAccountInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'GlAccount.label', default: 'GlAccount'), glAccountInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'glAccount.label', default: 'GlAccount'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def viewReports() {
        
    }

}
