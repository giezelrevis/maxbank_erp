package icbs.loans


import grails.converters.JSON
import grails.converters.deep.JSON

import static org.springframework.http.HttpStatus.*
import org.springframework.web.multipart.MultipartHttpServletRequest
import grails.transaction.Transactional
import icbs.lov.LoanCollateralStatus
import icbs.lov.AttachmentType
import icbs.deposit.Deposit
import icbs.admin.Institution
import icbs.admin.UserMaster

@Transactional(readOnly = true)
class CollateralManagementController {
    def auditLogService
    
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
      //  params.max = Math.min(max ?: 10, 100)   // no. of items on display
          params.max = Math.min(max ?: 25, 100)
        
        if (params.sort == null) {  // default ordering
            params.sort = "id"
        }

        if (params.query == null || params.query.trim() == "") {  // show all instances
            respond Collateral.list(params), model:[params:params, collateralInstanceCount: Collateral.count()]
        } else {    // show query results
            def result = Collateral.createCriteria().list(params) {                
               // idEq(params.query.trim().toLong())
              or{
                    'owner'{
                        or{
                            ilike("displayName","%${params.query.trim()}%")
                        }
                    }
                    if(params.query.trim().isLong()){
                        idEq(params.query.trim().toLong())
                    }
                }
            }
            
            respond result, model:[params:params, collateralInstanceCount: result.totalCount]
        }
        return
    } 

    def search(Integer max) {
      //  params.max = Math.min(max ?: 10, 100)   
          params.max = Math.min(max ?: 25, 100)    
        
        if (params.sort == null) {
            params.sort = "id"
        }

        if (params.query == null || params.query.trim() == "" ) {  // show all instances
            render(template:"search/searchCollateral", model:[params:params, domainInstanceList:Collateral.list(params), domainInstanceCount:Collateral.count()]) as JSON
        } else {    // show query results
            def result = Collateral.createCriteria().list(params) {                
                  // idEq(params.query.trim().toLong())
              or{
                    'owner'{
                        or{
                            ilike("displayName","%${params.query.trim()}%")
                        }
                    }
                    if(params.query.trim().isLong()){
                        idEq(params.query.trim().toLong())
                    }
                }
            }
            
            render(template:"search/searchCollateral", model:[params:params, domainInstanceList:result, domainInstanceCount:result.totalCount]) as JSON
        }            
        return
    }    

    def show(Collateral collateralInstance) {
        respond collateralInstance
    }    

    def create() {
        // initialize session variables
        session["pdcs"] = []
        session["attachments"] = []
        session["loanApplications"] = []

        respond new Collateral(params)
    }

    @Transactional
    def save(Collateral collateralInstance) {

        if (collateralInstance == null) {
            notFound()
            return
        }
       
        if (collateralInstance?.owner?.id == null)
        { 
            flash.message = 'Please choose customer !.|error|alert'
            render(view: '/collateralManagement/create', model: [collateralInstance:collateralInstance])
            return
        } 
             if (collateralInstance.appraisedValue == null)
            { 
            flash.message = 'Appraise Value Cannot be null ! Please make sure to up apraise value first.|error|alert'
            render(view: '/collateralManagement/create', model: [collateralInstance:collateralInstance])
            return
            }   
            if (collateralInstance.appraisedValue < 0)
            { 
            flash.message = 'Appraise Value Cannot be negative ! Please make sure to up apraise value first.|error|alert'
            render(view: '/collateralManagement/create', model: [collateralInstance:collateralInstance])
            return
            }
        
        if (collateralInstance?.collateralType?.id == 1) {
            def remInstance = new CollateralREM(params)
            
//             if (collateralInstance.appraisedValue == null)
//            { 
//            flash.message = 'Appraise Value Cannot be null !.|error|alert'
//            render(view: '/collateralManagement/create', model: [collateralInstance:collateralInstance,remInstance:remInstance])
//            return
//            } 
            if (remInstance.tctNo == null)
            { 
            flash.message = 'TCT number Cannot be null !.|error|alert'
            render(view: '/collateralManagement/create', model: [collateralInstance:collateralInstance,remInstance:remInstance])
            return
            } 
            if (remInstance.lotNo == null)
            { 
            flash.message = 'Lot number Cannot be null !.|error|alert'
            render(view: '/collateralManagement/create', model: [collateralInstance:collateralInstance,remInstance:remInstance])
            return
            } 
            if (remInstance.location == null)
            { 
            flash.message = 'Location Cannot be null !.|error|alert'
            render(view: '/collateralManagement/create', model: [collateralInstance:collateralInstance,remInstance:remInstance])
            return
            } 
            if (remInstance.registryOfDeeds == null)
            { 
            flash.message = 'Registry of Deeds Cannot be null !.|error|alert'
            render(view: '/collateralManagement/create', model: [collateralInstance:collateralInstance,remInstance:remInstance])
            return
            }
            if (remInstance.dateOfIssuance == null)
            { 
            flash.message = 'Issue Date Cannot be null !.|error|alert'
            render(view: '/collateralManagement/create', model: [collateralInstance:collateralInstance,remInstance:remInstance])
            return
            }
            
            remInstance.validate()
            
            if (collateralInstance.hasErrors() || remInstance.hasErrors()) {
                respond collateralInstance.errors, model: [remInstance:remInstance], view:'create'
                return
            } else {
                remInstance.save flush: true
                collateralInstance.rem = remInstance 
            }      
        } 
        else if (collateralInstance?.collateralType?.id == 2) {
            def chattelInstance = new CollateralChattel(params)
            
//            if (collateralInstance.appraisedValue == null)
//            { 
//            flash.message = 'Appraise Value Cannot be null !.|error|alert'
//            render(view: '/collateralManagement/create', model: [collateralInstance:collateralInstance,chattelInstance:chattelInstance])
//            return
//            } 
            if (chattelInstance.identificationNo == null)
            { 
            flash.message = 'ID number Cannot be null !.|error|alert'
            render(view: '/collateralManagement/create', model: [collateralInstance:collateralInstance,chattelInstance:chattelInstance])
            return
            }
            if (chattelInstance.acquisitionCost == null)
            { 
            flash.message = 'Cost of Acquisition Cannot be null !.|error|alert'
            render(view: '/collateralManagement/create', model: [collateralInstance:collateralInstance,chattelInstance:chattelInstance])
            return
            }
            if (chattelInstance.acquisitionDate == null)
            { 
            flash.message = 'Date of Acquisition Cannot be null !.|error|alert'
            render(view: '/collateralManagement/create', model: [collateralInstance:collateralInstance,chattelInstance:chattelInstance])
            return
            }
            chattelInstance.validate()
            
            if (collateralInstance.hasErrors() || chattelInstance.hasErrors()) {
                respond collateralInstance.errors, model: [chattelInstance:chattelInstance], view:'create'
                return
            } else {
                chattelInstance.save flush: true
                collateralInstance.chattel = chattelInstance 
            }       
        } 
        else if (collateralInstance?.collateralType?.id == 3) {
            def holdoutInstance = new CollateralHoldout(params)
            
//            if (collateralInstance.appraisedValue == null)
//            { 
//            flash.message = 'Appraise Value Cannot be null !.|error|alert'
//            render(view: '/collateralManagement/create', model: [collateralInstance:collateralInstance,holdoutInstance:holdoutInstance])
//            return
//            } 
            if (holdoutInstance.accountNo == null)
            { 
            flash.message = 'Account number Cannot be null !.|error|alert'
            render(view: '/collateralManagement/create', model: [collateralInstance:collateralInstance,holdoutInstance:holdoutInstance])
            return
            }
            def depInstance = Deposit.findByAcctNo(holdoutInstance.accountNo)
            if (depInstance == null) {
            flash.message = 'Invalid Account number !.|error|alert'
            render(view: '/collateralManagement/create', model: [collateralInstance:collateralInstance,holdoutInstance:holdoutInstance])
            return                
            }
            holdoutInstance.accountType  = depInstance.product.name
            if (holdoutInstance.accountType == null)
            { 
            flash.message = 'Account Type Cannot be null !.|error|alert'
            render(view: '/collateralManagement/create', model: [collateralInstance:collateralInstance,holdoutInstance:holdoutInstance])
            return
            } 
            // hold amount to be based on approved loan
            holdoutInstance.amount = collateralInstance.appraisedValue
            if (holdoutInstance.amount == null)
            { 
            flash.message = 'Amount Cannot be null !.|error|alert'
            render(view: '/collateralManagement/create', model: [collateralInstance:collateralInstance,holdoutInstance:holdoutInstance])
            return
            } 
            if (holdoutInstance.amount < 0)
            { 
            flash.message = 'Amount Cannot be negative value !.|error|alert'
            render(view: '/collateralManagement/create', model: [collateralInstance:collateralInstance,holdoutInstance:holdoutInstance])
            return
            } 
            holdoutInstance.bank = Institution.findByParamCode('GEN.10000').paramValue
            if (holdoutInstance.bank == null)
            { 
            flash.message = 'Bank Name Cannot be null !.|error|alert'
            render(view: '/collateralManagement/create', model: [collateralInstance:collateralInstance,holdoutInstance:holdoutInstance])
            return
            } 
            if (holdoutInstance.holdoutDate == null)
            { 
            flash.message = 'Holdout Date Cannot be null !.|error|alert'
            render(view: '/collateralManagement/create', model: [collateralInstance:collateralInstance,holdoutInstance:holdoutInstance])
            return
            } 
            holdoutInstance.onUs = true
            holdoutInstance.validate()
            
            if (collateralInstance.hasErrors() || holdoutInstance.hasErrors()) {
                respond collateralInstance.errors, model: [holdoutInstance:holdoutInstance], view:'create'
                return
            } else {
                holdoutInstance.save flush: true
                collateralInstance.holdout = holdoutInstance 
            }      
        } /*else if (collateralInstance?.collateralType?.id == 4) {
            def pdcInstance = new CollateralPDC(params)
            pdcInstance.validate()
            
            if (collateralInstance.hasErrors() || pdcInstance.hasErrors()) {
                respond collateralInstance.errors, model: [pdcInstance:pdcInstance], view:'create'
                return
            } else {
                pdcInstance.save flush: true
                collateralInstance.pdc = pdcInstance 
            }        
        } */ else {
            if (collateralInstance.hasErrors()) {
                respond collateralInstance.errors, view:'create'
                return
            }       
        }        

        for(pdc in session["pdcs"]) {
        
            collateralInstance.addToPdcs(pdc)
            
            
        }
        session["pdcs"] = null

        for(attachment in session["attachments"]) {
            collateralInstance.addToAttachments(attachment)
        }
        session["attachments"] = null

        for(loanApplication in session["loanApplications"]) {
            if (!loanApplication.isAttached())
                loanApplication.attach()
            collateralInstance.addToLoanApplications(loanApplication)
        }
        session["loanApplications"] = null

        collateralInstance.save flush:true
             def description = 'Loan Collateral ' +  collateralInstance.id + ' was created '
           auditLogService.insert('090', 'LON00301', description, 'Loan', null, null, null, collateralInstance.id)
        
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'Collateral.label', default: 'Collateral'), collateralInstance.id])
                //redirect collateralInstance
                redirect action: "show", id: collateralInstance.id
            }
            '*' { respond collateralInstance, [status: CREATED] }
        }
    }    

    def edit(Collateral collateralInstance) {        
        if (collateralInstance?.collateralType?.id == 1) {
            def remInstance = collateralInstance?.rem
            respond collateralInstance, model: [remInstance:remInstance]            
        } else if (collateralInstance?.collateralType?.id == 2) {
            def chattelInstance = collateralInstance?.chattel
            respond collateralInstance, model: [chattelInstance:chattelInstance]
        } else if (collateralInstance?.collateralType?.id == 3) {
            def holdoutInstance = collateralInstance?.holdout
            respond collateralInstance, model: [holdoutInstance:holdoutInstance]
        }/* else if (collateralInstance?.collateralType?.id == 4) {
            def pdcInstance = collateralInstance?.pdc
            respond collateralInstance, model: [pdcInstance:pdcInstance]
        }*/ else {
            respond collateralInstance
        }        
    }

    @Transactional
    def update(Collateral collateralInstance) {        
        if (collateralInstance == null) {
            notFound()
            return
        }
        
        if (collateralInstance?.collateralType?.id == 1) {
            def remInstance = new CollateralREM(params)
            remInstance.validate()
            
            if (collateralInstance.hasErrors() || remInstance.hasErrors()) {
                respond collateralInstance.errors, model: [remInstance:remInstance], view:'edit'
                return
            } else {
                remInstance.save flush: true
                collateralInstance.rem = remInstance 
            }

            collateralInstance.pdcs.clear()
        } else if (collateralInstance?.collateralType?.id == 2) {
            def chattelInstance = new CollateralChattel(params)
            chattelInstance.validate()
            
            if (collateralInstance.hasErrors() || chattelInstance.hasErrors()) {
                respond collateralInstance.errors, model: [chattelInstance:chattelInstance], view:'edit'
                return
            } else {
                chattelInstance.save flush: true
                collateralInstance.chattel = chattelInstance 
            }       

            collateralInstance.pdcs.clear()
        } else if (collateralInstance?.collateralType?.id == 3) {
            def holdoutInstance = new CollateralHoldout(params)
            
            def depInstance = Deposit.findByAcctNo(holdoutInstance.accountNo)
            if (depInstance == null) {
                flash.message = 'Invalid Account number !.|error|alert'
                respond collateralInstance.errors, model: [holdoutInstance:holdoutInstance], view:'edit'
                return                
            }
            holdoutInstance.accountType  = depInstance.product.name
            if (holdoutInstance.accountType == null)
            { 
                flash.message = 'Account Type Cannot be null !.|error|alert'
                respond collateralInstance.errors, model: [holdoutInstance:holdoutInstance], view:'edit'
                return
            } 
            // hold amount to be based on approved loan
            holdoutInstance.amount = collateralInstance.appraisedValue
            if (holdoutInstance.amount == null)
            { 
                flash.message = 'Amount Cannot be null !.|error|alert'
                respond collateralInstance.errors, model: [holdoutInstance:holdoutInstance], view:'edit'
                return
            } 
            if (holdoutInstance.amount < 0)
            { 
                flash.message = 'Amount Cannot be negative value !.|error|alert'
                respond collateralInstance.errors, model: [holdoutInstance:holdoutInstance], view:'edit'
                return
            } 
            holdoutInstance.bank = Institution.findByParamCode('GEN.10000').paramValue
            if (holdoutInstance.bank == null)
            { 
                flash.message = 'Bank Name Cannot be null !.|error|alert'
                respond collateralInstance.errors, model: [holdoutInstance:holdoutInstance], view:'edit'
                return
            } 
            
            if (collateralInstance.hasErrors() || holdoutInstance.hasErrors()) {
                respond collateralInstance.errors, model: [holdoutInstance:holdoutInstance], view:'edit'
                println 'error---------'
                println collateralInstance.errors
                println holdoutInstance.errors
                return
            } else {
                holdoutInstance.save flush: true
                collateralInstance.holdout = holdoutInstance 
            }      
            holdoutInstance.validate()
            collateralInstance.pdcs.clear()
        } else if (collateralInstance?.collateralType?.id == 4) {
            if (collateralInstance.hasErrors()) {
                respond collateralInstance.errors, view:'edit'
                return
            }
        } else {
            if (collateralInstance.hasErrors()) {
                respond collateralInstance.errors, view:'edit'
                return
            }       

            collateralInstance.pdcs.clear()
        }

        collateralInstance.save flush:true
            def description = 'Loan Collateral ' +  collateralInstance.id + ' was updated by ' + UserMaster.get(session.user_id).username
           auditLogService.insert('090', 'LON00302', description, 'Loan', null, null, null, collateralInstance.id)
        
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Collateral.label', default: 'Collateral'), collateralInstance.id])
                //redirect collateralInstance
                redirect action: "show", id: collateralInstance.id
            }
            '*'{ respond collateralInstance, [status: OK] }
            }
    }    
 
    def showUpdateStatusAjax() {
        def collateralInstance = Collateral.get(params.id)

        render(template:"status/editStatus", model:[collateralInstance:collateralInstance]) as JSON
        return
    }

    @Transactional
    def updateStatusAjax() {
        def collateralInstance = Collateral.get(params.id)

        collateralInstance.status = LoanCollateralStatus.get(params.status.id)
        collateralInstance.save flush:true
        def description = 'Loan Collateral ' +  collateralInstance.id + ' status updated by ' + UserMaster.get(session.user_id).username
           auditLogService.insert('090', 'LON00302', description, 'Loan', null, null, null, collateralInstance.id)
        
        def message = "Status successfully updated"
        render(template:"status/editStatus", model:[collateralInstance:collateralInstance, message:message]) as JSON

        return
    }

    /*
     * PDC
     */

    def showPDCsAjax() {
        render(template:"pdc/list") as JSON
        return
    }  

    def showPDCsAjax2() {
        def id  = params?.id
        def collateralInstance = Collateral.get(id)

        render(template:"pdc/list", model:[collateralInstance:collateralInstance]) as JSON
        return
    } 

    def showAddPDCAjax() {    
        render(template:"pdc/form") as JSON
        return
    }

    def addPDCAjax() {         
        def accountNo = params?.accountNo
        def checkNo = params?.checkNo
        
         def amount
          if (params?.amount == '')
        {
             amount = params?.amount
        }
        else
        {
             amount = params?.amount.toDouble()
        }

        def bank = params?.bank
        def onUs = params?.onUs?.toBoolean()
        def pdcDate = params?.pdcDate
        def pdc = new CollateralPDC(accountNo:accountNo, checkNo:checkNo, amount:amount, bank:bank, onUs:onUs, pdcDate:pdcDate) 
        
        if (accountNo == '')
        {
            def message = 'Account Number cannot be null !'
            render(template:"pdc/form" , model:[pdc:pdc,message:message]) as JSON
            return
        }
        if (checkNo == '')
        {
            def message = 'Check Number cannot be null !'
            render(template:"pdc/form" , model:[pdc:pdc,message:message]) as JSON
            return
        }
        if (amount == '')
        {
            def message = 'Amount cannot be null !'
            render(template:"pdc/form" , model:[pdc:pdc,message:message]) as JSON
            return
        }
        if (amount < 0 )
        {
            def message = 'Amount cannot be negative !'
            render(template:"pdc/form" , model:[pdc:pdc,message:message]) as JSON
            return
        }
        if (bank == '')
        {
            def message = 'Bank cannot be null !'
            render(template:"pdc/form" , model:[pdc:pdc,message:message]) as JSON
            return
        }
        if (pdcDate == '')
        {
            def message = 'Date cannot be null !'
            render(template:"pdc/form" , model:[pdc:pdc,message:message]) as JSON
            return
        }
        

        if (!pdc.validate()) {
            render(template:"pdc/form", model:[pdc:pdc]) as JSON
            return
        }
            
           def ch =  session["pdcs"].size
           println "gelo " + ch
            for (int i = 0; i < ch; i++) 
            {
               def x = session["pdcs"].checkNo[i]
                println "gelo " + x
                if (x == checkNo)
                {
                    def message = 'Check No Duplicate !'
                     render(template:"pdc/form" , model:[pdc:pdc,message:message]) as JSON
                     return 
                }
        }
 
        def pdcs
        if (session["pdcs"]) {
            pdcs = session["pdcs"]
        } else {
            pdcs = []
        }        
        pdcs.add(pdc)
        session["pdcs"] = pdcs

        def message = 'PDC with amount of P' + amount + ' on Bank ' + bank + ' was succesfully Added!' 
        render(template:"pdc/form", model:[message:message]) as JSON

        return
    }

    @Transactional
    def addPDCAjax2() {
        def id  = params?.id
        def accountNo = params?.accountNo
        def checkNo = params?.checkNo
        def amount
          if (params?.amount == '')
        {
             amount = params?.amount
        }
        else
        {
             amount = params?.amount.toDouble()
        }
        def bank = params?.bank
        def onUs = params?.onUs?.toBoolean()
        def pdcDate = params?.pdcDate

        def pdc = new CollateralPDC(accountNo:accountNo, checkNo:checkNo, amount:amount, bank:bank, onUs:onUs, pdcDate:pdcDate)
         if (accountNo == '')
        {
            def message = 'Account Number cannot be null !'
            render(template:"pdc/form" , model:[pdc:pdc,message:message]) as JSON
            return
        }
        if (checkNo == '')
        {
            def message = 'Check Number cannot be null !'
            render(template:"pdc/form" , model:[pdc:pdc,message:message]) as JSON
            return
        }
        if (amount == '')
        {
            def message = 'Amount cannot be null !'
            render(template:"pdc/form" , model:[pdc:pdc,message:message]) as JSON
            return
        }
         if (amount < 0 )
        {
            def message = 'Amount cannot be negative!'
            render(template:"pdc/form" , model:[pdc:pdc,message:message]) as JSON
            return
        }
        if (bank == '')
        {
            def message = 'Bank cannot be null !'
            render(template:"pdc/form" , model:[pdc:pdc,message:message]) as JSON
            return
        }
        if (pdcDate == '')
        {
            def message = 'Date cannot be null !'
            render(template:"pdc/form" , model:[pdc:pdc,message:message]) as JSON
            return
        }
        
        if (!pdc.validate()) {
            render(template:"pdc/form", model:[pdc:pdc]) as JSON
            return
        }        
         def ch =  session["pdcs"].size
           println "gelo " + ch
            for (int i = 0; i < ch; i++) 
            {
               def x = session["pdcs"].checkNo[i]
                println "gelo " + x
                if (x == checkNo)
                {
                    def message = 'Check No Duplicate !'
                     render(template:"pdc/form" , model:[pdc:pdc,message:message]) as JSON
                     return 
                }
        }
        def collateralInstance = Collateral.get(id)
        collateralInstance.addToPdcs(pdc)
        collateralInstance.save flush:true       

        def message = 'PDC with amount of P' + amount + ' on Bank ' + bank + ' was succesfully Added!' 
        render(template:"pdc/form", model:[message:message]) as JSON
        return
    }

    def showUpdatePDCAjax() {        
        def id = params?.id?.toInteger()

        def pdcs = session["pdcs"]        
        def pdc = pdcs[id]

        render(template:"pdc/form", model:[pdc:pdc]) as JSON
        return
    }

    def showUpdatePDCAjax2() {   
        def id = params?.id?.toInteger()
        
        def pdc = CollateralPDC.get(id)

        render(template:"pdc/form", model:[pdc:pdc]) as JSON
        return
    }

    def updatePDCAjax() {   
        def id = params?.id?.toInteger()
        def accountNo = params?.accountNo
        def checkNo = params?.checkNo
        def amount = params?.amount ? params?.amount?.toDouble() : null
        def bank = params?.bank
        def onUs = params?.onUs?.toBoolean()        
        def pdcDate = params?.pdcDate ? new Date().parse("MM/dd/yyyy", params?.pdcDate) : null
        def tempPDC = new CollateralPDC(accountNo:accountNo, checkNo:checkNo, amount:amount, bank:bank, onUs:onUs, pdcDate:pdcDate)

          if (accountNo == '')
        {
            def message = 'Account Number cannot be null !'
            render(template:"pdc/form" , model:[pdc:tempPDC,message:message]) as JSON
            return
        }
        if (checkNo == '')
        {
            def message = 'Check Number cannot be null !'
            render(template:"pdc/form" , model:[pdc:tempPDC,message:message]) as JSON
            return
        }
        if (amount == '')
        {
            def message = 'Amount cannot be null !'
            render(template:"pdc/form" , model:[pdc:tempPDC,message:message]) as JSON
            return
        }
         if (amount < 0 )
        {
            def message = 'Amount cannot be negative!'
            render(template:"pdc/form" , model:[pdc:tempPDC,message:message]) as JSON
            return
        }
        if (bank == '')
        {
            def message = 'Bank cannot be null !'
            render(template:"pdc/form" , model:[pdc:tempPDC,message:message]) as JSON
            return
        }
        if (pdcDate == '')
        {
            def message = 'Date cannot be null !'
            render(template:"pdc/form" , model:[pdc:tempPDC,message:message]) as JSON
            return
        }
      
        if (!tempPDC.validate()) {
            render(template:"pdc/form", model:[pdc:tempPDC]) as JSON
            return
        }        

        def pdcs = session["pdcs"]        
        def pdc = pdcs[id]

        pdc.accountNo = accountNo
        pdc.checkNo = checkNo
        pdc.amount = amount
        pdc.bank = bank
        pdc.onUs = onUs
        pdc.pdcDate = pdcDate

        def message = "PDC successfully updated"
        render(template:"pdc/form", model:[pdc:pdc, message:message]) as JSON

        return
    }

    @Transactional
    def updatePDCAjax2() {   
        def id = params?.id?.toInteger()
        def pdc = CollateralPDC.get(id)
        pdc.accountNo = params?.accountNo ?: null
        pdc.checkNo = params?.checkNo ?: null
        pdc.amount = params?.amount ? params?.amount?.toDouble() : null
        pdc.bank = params?.bank ?: null
        pdc.onUs = params?.onUs?.toBoolean()        
        pdc.pdcDate = params?.pdcDate ? new Date().parse("MM/dd/yyyy", params?.pdcDate) : null
          if (pdc.accountNo == '')
        {
            def message = 'Account Number cannot be null !'
            render(template:"pdc/form" , model:[pdc:pdc,message:message]) as JSON
            return
        }
        if (pdc.checkNo == '')
        {
            def message = 'Check Number cannot be null !'
            render(template:"pdc/form" , model:[pdc:pdc,message:message]) as JSON
            return
        }
        if (pdc.amount == '')
        {
            def message = 'Amount cannot be null !'
            render(template:"pdc/form" , model:[pdc:pdc,message:message]) as JSON
            return
        }
         if (pdc.amount < 0 )
        {
            def message = 'Amount cannot be negative!'
            render(template:"pdc/form" , model:[pdc:pdc,message:message]) as JSON
            return
        }
        if (pdc.bank == '')
        {
            def message = 'Bank cannot be null !'
            render(template:"pdc/form" , model:[pdc:pdc,message:message]) as JSON
            return
        }
        if (pdc.pdcDate == '')
        {
            def message = 'Date cannot be null !'
            render(template:"pdc/form" , model:[pdc:pdc,message:message]) as JSON
            return
        }
        if (!pdc.validate()) {
            render(template:"pdc/form", model:[pdc:pdc]) as JSON
            return
        }     

        pdc.save flush:true

        def message = "PDC successfully updated"
        render(template:"pdc/form", model:[pdc:pdc, message:message]) as JSON

        return
    }

    def deletePDCAjax() {
        def id = params?.id?.toInteger()
        session["pdcs"].remove(id)

        render "success"
        return
    }

    @Transactional
    def deletePDCAjax2() {
        def id = params?.id?.toInteger()
        def pdcId = params?.pdcId?.toInteger()

        def collateralInstance = Collateral.get(id)
        def pdc = CollateralPDC.get(pdcId)

        collateralInstance.removeFromPdcs(pdc)
        collateralInstance.save flush:true

        render "success"
        return
    }

     /*
     * Attachments
     */

    def showAttachmentsAjax() {
        render(template:"attachments/list") as JSON
        return
    }    

    def showAttachmentsAjax2() {
        def id  = params?.id
        def collateralInstance = Collateral.get(id)

        render(template:"attachments/list", model:[collateralInstance:collateralInstance]) as JSON
        return
    } 

    def showAddAttachmentAjax() {    
        render(template:"attachments/form") as JSON
        return
    }

    def addAttachmentAjax() { 
        def description = params?.description
        def type = params?.type           

        if (params?.file == "undefined") {
            def attachment = new LoanAttachment(description: description, type: AttachmentType.get(type))
            attachment.errors.rejectValue("fileData", "loanAttachment.file.empty")

            render(template:"attachments/form", model:[attachment:attachment]) as JSON
            return
        }

        def fileName = params?.file?.getOriginalFilename()
        def fileType = params?.file?.getContentType()
        def fileData = params?.file?.getBytes()        

        def attachment = new LoanAttachment(fileName: fileName, fileType: fileType, fileData: fileData, 
            description: description, type: AttachmentType.get(type))
                
        def attachments
        if (session["attachments"]) {
            attachments = session["attachments"]
        } else {
            attachments = []
        }        
        attachments.add(attachment)
        session["attachments"] = attachments        

        def message = "Attachment successfully added"
        render(template:"attachments/form", model:[message:message]) as JSON    
        return
    }

    @Transactional
    def addAttachmentAjax2() {
        def id  = params?.id 
        def description = params?.description
        def type = params?.type           

        if (params?.file == "undefined") {
            def attachment = new LoanAttachment(description: description, type: AttachmentType.get(type))
            attachment.errors.rejectValue("fileData", "loanAttachment.file.empty")

            render(template:"attachments/form", model:[attachment:attachment]) as JSON
            return
        }

        def fileName = params?.file?.getOriginalFilename()
        def fileType = params?.file?.getContentType()
        def fileData = params?.file?.getBytes()        

        def attachment = new LoanAttachment(fileName: fileName, fileType: fileType, fileData: fileData, 
            description: description, type: AttachmentType.get(type))
                
        def collateralInstance = Collateral.get(id)
        collateralInstance.addToAttachments(attachment)
        collateralInstance.save flush:true       

        def message = "Attachment successfully added"
        render(template:"attachments/form", model:[message:message]) as JSON    
        return
    }

    def showUpdateAttachmentAjax() {   
        def id = params?.id?.toInteger()
        
        def attachments = session["attachments"]        
        def attachment = attachments[id]

        render(template:"attachments/edit", model:[attachment:attachment]) as JSON
        return
    }

    def showUpdateAttachmentAjax2() {
        def id = params?.id?.toInteger()
        
        def attachment = LoanAttachment.get(id)

        render(template:"attachments/edit", model:[attachment:attachment]) as JSON
        return
    } 

    def updateAttachmentAjax() {  
        def id = params?.id?.toInteger()
        def description = params?.description
        def type = params?.type           

        def attachments = session["attachments"]        
        def attachment = attachments[id]

        attachment.description = description
        attachment.type = AttachmentType.get(type)

        def message = "Attachment successfully updated"
        render(template:"attachments/edit", model:[attachment:attachment, message:message]) as JSON    
        return
    }

    @Transactional
    def updateAttachmentAjax2() {  
        def id = params?.id?.toInteger()
        def description = params?.description
        def type = params?.type           

        def attachment = LoanAttachment.get(id)
        attachment.description = description
        attachment.type = AttachmentType.get(type)
        attachment.save flush:true

        def message = "Attachment successfully updated"
        render(template:"attachments/edit", model:[attachment:attachment, message:message]) as JSON    
        return
    }

    def deleteAttachmentAjax() {
        def id = params?.id?.toInteger()
        session["attachments"].remove(id)

        render "success"
        return
    }

    @Transactional
    def deleteAttachmentAjax2() {
        def id = params?.id?.toInteger()
        def attachmentId = params?.attachmentId?.toInteger()

        def collateralInstance = Collateral.get(id)
        def attachment = LoanAttachment.get(attachmentId)

        collateralInstance.removeFromAttachments(attachment)
        collateralInstance.save flush:true

        render "success"
        return
    }

    def showAttachment() {
        def id = params?.id
        def attachment = LoanAttachment.get(id)

        if (attachment) {
            response.setHeader("Content-Disposition", "inline;Filename=\"${attachment.fileName}\"")
            response.setContentType(attachment.fileType)
            response.outputStream << attachment.fileData
            response.outputStream.flush()
            response.outputStream.close()
        }
    }

    def downloadAttachment() {
        def id = params?.id
        def attachment = LoanAttachment.get(id)

        if (attachment) {
            response.setContentType("APPLICATION/OCTET-STREAM")
            response.setHeader("Content-Disposition", "Attachment;Filename=\"${attachment.fileName}\"")
            response.setContentType(attachment.fileType)
            response.outputStream << attachment.fileData
            response.outputStream.flush()
            response.outputStream.close()
        }
    }

    /*
     * Loan Applications
     */

    def showLoanApplicationsAjax() {
        render(template:"loanApplications/list") as JSON
        return
    }  

    def showLoanApplicationsAjax2() {        
        def id  = params?.id
        def collateralInstance = Collateral.get(id)

        render(template:"loanApplications/list", model:[collateralInstance:collateralInstance]) as JSON
        return
    }  

    def addLoanApplicationAjax() {
        def id = params?.id

        def loanApplication = LoanApplication.get(id)

        def loanApplications
        if (session["loanApplications"]) {
            loanApplications = session["loanApplications"]
        } else {
            loanApplications = []
        } 

        if (!(loanApplications*.id.contains(loanApplication.id))) {
            loanApplications.add(loanApplication)
            session["loanApplications"] = loanApplications
        }

        render "success"
        return
    }

    @Transactional
    def addLoanApplicationAjax2() {
        def id = params?.id
        def loanApplicationId = params?.loanApplicationId

        def collateralInstance = Collateral.get(id)
        def loanApplication = LoanApplication.get(loanApplicationId)

        if (!(collateralInstance*.loanApplications.id.contains(loanApplication.id))) {
            collateralInstance.addToLoanApplications(loanApplication)
            collateralInstance.save flush:true
        }

        render "success"
        return
    }

    def deleteLoanApplicationAjax() {
        def id = params?.id?.toInteger()

        session["loanApplications"].remove(id)

        render "success"
        return
    }

    @Transactional
    def deleteLoanApplicationAjax2() {
        def id = params?.id
        def loanApplicationId = params?.loanApplicationId

        def collateralInstance = Collateral.get(id)
        def loanApplication = LoanApplication.get(loanApplicationId)

        collateralInstance.removeFromLoanApplications(loanApplication)
        collateralInstance.save flush:true

        render "success"
        return
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'collateral.label', default: 'Collateral'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

}
