package icbs.admin



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import icbs.lov.ConfigItemStatus
import icbs.deposit.DepositTaxFeeAndChargeScheme
import grails.converters.JSON
import grails.converters.deep.JSON
import icbs.lov.TxnType
import groovy.sql.Sql
import icbs.admin.Currency
import icbs.lov.MemoTxnType
import icbs.lov.YesNoNa
import icbs.lov.TxnModule
import java.math.BigDecimal;

@Transactional(readOnly = true)
class TxnTemplateController {

    static allowedMethods = [save: "POST", update: ["PUT","POST"], delete: "DELETE", saveCharge: "PUT"]
    def dataSource
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 20)
        if(params.offset==null){
            params.offset=0
        }
        if (params.query == null) {
            respond TxnTemplate.list(params), model:[params:params,TxnTemplateInstanceCount:  TxnTemplate.count()]
            return
        }
        else{
            def TxnTemplateList = TxnTemplate.createCriteria().list (params) {
                or {
                    ilike("amlaCode","%${params.query}%")
                    ilike("description", "%${params.query}%")
                    ilike("shortDescription", "%${params.query}%")
                }                
            }
            respond TxnTemplateList, model:[params:params,TxnTemplateInstanceCount: TxnTemplateList.totalCount]
        }
        return
    }

    def show(TxnTemplate txnTemplateInstance) {
        respond txnTemplateInstance
    }

     def create() {
         respond new TxnTemplate(params)
     }
     
     def getTxnTypeCodeAjax(){
        def json = request.JSON
        //def TxnTypeInstance = TxnType.get(json.typevalue.toInteger())
        //def TxnTypeInstance = TxnType.get(json.typevalue)
        def sql = new Sql(dataSource)
        def TxnTypeInstance = "select * from txn_type where id = '${json.typevalue.toInteger()}'"
        def resultqueryall = sql.rows(TxnTypeInstance)
        println("return: "+resultqueryall)
        render resultqueryall as JSON
     }
     def validateExistingCodeAjax(){
        def json = request.JSON
        def sql = new Sql(dataSource)
        println("codevalue: "+json.codevalue)
        println("typevlaue: "+json.txntypevalue)
       //def txnTemplateInstance = TxnTemplate.findByCodeAndTxnType(json.codevalue.toString(),icbs.lov.TxnType.get(json.txntypevalue.toInteger()))
        def queryall = "select * from txn_template where code = '${json.codevalue.toString()}' and txn_type_id = '${json.txntypevalue.toInteger()}'"
        def resultqueryall = sql.rows(queryall)
        println("return: "+resultqueryall)
        render resultqueryall as JSON
     }
     def validateExistingGlCodeAjax(){
        def json = request.JSON
        def sql = new Sql(dataSource)
        def depcontra = json.depcontra.toString()
        def financialYear = json.financialYear.toInteger()
        def curreny = Currency.get(1).id.toInteger()
        def branch = Branch.get(1).id.toInteger()
        
        println("depcontra: "+json.depcontra)
        println("financialYear: "+json.financialYear)
        println("curreny: "+curreny)
        println("branch: "+branch)
        
        def queryall = "select * from gl_account where code='${depcontra}' and currency_id='${curreny}' and branch_id = '${branch}' and financial_year = '${financialYear}'"
        def resultqueryall = sql.rows(queryall)
        println("return: "+resultqueryall)
        render resultqueryall as JSON
    }
    @Transactional
    def saveTxnTemplateAjax(){
        def json = request.JSON
        def sql = new Sql(dataSource)    

        def txnTemplateInstance = new TxnTemplate()
        txnTemplateInstance.txnType = TxnType.get(json.txntype.toInteger())
        txnTemplateInstance.code = json.code
        txnTemplateInstance.description = json.description
        txnTemplateInstance.shortDescription = json.shortDescription
       //BigDecimal minimumAmount = new BigDecimal(json.minAmt.replaceAll(",", ""));
       //txnTemplateInstance.minAmt = minimumAmount
       //BigDecimal maximumAmount = new BigDecimal(json.maxAmt.replaceAll(",", ""));
       // txnTemplateInstance.maxAmt = maximumAmount
        txnTemplateInstance.amlaCode = json.amlaCode
        //txnTemplateInstance.requireTxnDescription = json.requireTxnDescription.toBoolean()
        //txnTemplateInstance.requireTxnReference = json.requireTxnReference.toBoolean()
        //txnTemplateInstance.validationCopyNo = json.validationCopyNo.toInteger()
        //txnTemplateInstance.validationFormCode = json.validationFormCode
        txnTemplateInstance.currency = Currency.get(json.currency.toInteger())
        txnTemplateInstance.requirePassbook = YesNoNa.get(json.requirePassbook.toInteger())
        txnTemplateInstance.atmOnlyTxn = YesNoNa.get(json.atmOnlyTxn.toInteger())
        txnTemplateInstance.interbranchTxn = YesNoNa.get(json.interbranchTxn.toInteger())
        txnTemplateInstance.systemOnlyTxn = json.systemOnlyTxn
        txnTemplateInstance.memoTxnType = MemoTxnType.get(json.memoTxnType.toInteger())
        txnTemplateInstance.batchTxn = YesNoNa.get(json.batchTxn.toInteger())
        txnTemplateInstance.configItemStatus = ConfigItemStatus.get(2)
        txnTemplateInstance.appType = json.appType
        txnTemplateInstance.defContraAcct = json.depContra
        txnTemplateInstance.txnModule = TxnModule.get(json.txnModule.toInteger())
        txnTemplateInstance.save(flush: true)
        
        def queryall = "select * from txn_template order by id desc limit 1"
        def resultqueryall = sql.rows(queryall)
        println("result: "+resultqueryall)
        render resultqueryall as JSON
    }
    @Transactional
    def updateTxnTemplate(){
        println("params txntemplate id : "+params.id)
        def txnTemplateInstance = TxnTemplate.get(params.id.toInteger())
        [txnTemplateInstance:txnTemplateInstance]
    }
    @Transactional
    def updateTxnTemplateAjax(){
        def json = request.JSON
        def sql = new Sql(dataSource)    
        def txnTemplateInstance = TxnTemplate.get(json.idtxntemplate.toInteger())
        txnTemplateInstance.txnType = TxnType.get(json.txntype.toInteger())
        txnTemplateInstance.code = json.code
        txnTemplateInstance.description = json.description
        txnTemplateInstance.shortDescription = json.shortDescription
       //BigDecimal minimumAmount = new BigDecimal(json.minAmt.replaceAll(",", ""));
       //txnTemplateInstance.minAmt = minimumAmount
       //BigDecimal maximumAmount = new BigDecimal(json.maxAmt.replaceAll(",", ""));
       // txnTemplateInstance.maxAmt = maximumAmount
        txnTemplateInstance.amlaCode = json.amlaCode
        //txnTemplateInstance.requireTxnDescription = json.requireTxnDescription.toBoolean()
        //txnTemplateInstance.requireTxnReference = json.requireTxnReference.toBoolean()
        //txnTemplateInstance.validationCopyNo = json.validationCopyNo.toInteger()
        //txnTemplateInstance.validationFormCode = json.validationFormCode
        txnTemplateInstance.currency = Currency.get(json.currency.toInteger())
        txnTemplateInstance.requirePassbook = YesNoNa.get(json.requirePassbook.toInteger())
        txnTemplateInstance.atmOnlyTxn = YesNoNa.get(json.atmOnlyTxn.toInteger())
        txnTemplateInstance.interbranchTxn = YesNoNa.get(json.interbranchTxn.toInteger())
        txnTemplateInstance.systemOnlyTxn = json.systemOnlyTxn
        txnTemplateInstance.memoTxnType = MemoTxnType.get(json.memoTxnType.toInteger())
        txnTemplateInstance.batchTxn = YesNoNa.get(json.batchTxn.toInteger())
        txnTemplateInstance.configItemStatus = ConfigItemStatus.get(json.configitem.toInteger())
        txnTemplateInstance.appType = json.appType
        txnTemplateInstance.defContraAcct = json.depContra
        txnTemplateInstance.txnModule = TxnModule.get(json.txnModule.toInteger())
        txnTemplateInstance.save(flush: true)
        
        def queryall = "select * from txn_template where id = '${json.idtxntemplate.toInteger()}'"
        def resultqueryall = sql.rows(queryall)
        
        println("result: "+resultqueryall)
        render resultqueryall as JSON        
    }
     

    def edit(TxnTemplate txnTemplateInstance) {
        respond txnTemplateInstance
    }

    // @Transactional
    // def update(TxnTemplate txnTemplateInstance) {
    //     if (txnTemplateInstance == null) {
    //         notFound()
    //         return
    //     }

    //     if (txnTemplateInstance.hasErrors()) {
    //         respond txnTemplateInstance.errors, view:'edit'
    //         return
    //     }

    //     txnTemplateInstance.save flush:true

    //     params.charges.each {
    //         def tc = TxnCharge.findAllByTxnTemplateAndDepositTaxFeeAndChargeScheme(txnTemplateInstance, DepositTaxFeeAndChargeScheme.get(it))

    //         if(!tc) {
    //             TxnCharge newTC = new TxnCharge(charge:it, txnTemplate:txnTemplateInstance, configItemStatus:ConfigItemStatus.get(2)).save(flush:true)
    //         }
    //     }

    //     request.withFormat {
    //         form multipartForm {
    //             flash.message = message(code: 'default.updated.message', args: [message(code: 'TxnTemplate.label', default: 'TxnTemplate'), txnTemplateInstance.id])
    //             redirect txnTemplateInstance
    //         }
    //         '*'{ respond txnTemplateInstance, [status: OK] }
    //     }
    // }

    @Transactional
    def saveCharge(TxnTemplate txnTemplateInstance) {
        params.charges.each {
            def chargeInstance = DepositTaxFeeAndChargeScheme.get(it)

            def tc = TxnCharge.where {
                txnTemplate == txnTemplateInstance && charge == chargeInstance
            }.list()

            if(!tc) {
                TxnCharge newTC = new TxnCharge(charge:it, txnTemplate:txnTemplateInstance, configItemStatus:ConfigItemStatus.get(2)).save(flush:true)
            }
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'TxnTemplate.label', default: 'TxnTemplate'), txnTemplateInstance.id])
                redirect txnTemplateInstance
            }
            '*'{ respond txnTemplateInstance, [status: OK] }
        }
    }

    // @Transactional
    // def delete(TxnTemplate txnTemplateInstance) {

    //     if (txnTemplateInstance == null) {
    //         notFound()
    //         return
    //     }

    //     txnTemplateInstance.delete flush:true

    //     request.withFormat {
    //         form multipartForm {
    //             flash.message = message(code: 'default.deleted.message', args: [message(code: 'TxnTemplate.label', default: 'TxnTemplate'), txnTemplateInstance.id])
    //             redirect action:"index", method:"GET"
    //         }
    //         '*'{ render status: NO_CONTENT }
    //     }
    // }

    // protected void notFound() {
    //     request.withFormat {
    //         form multipartForm {
    //             flash.message = message(code: 'default.not.found.message', args: [message(code: 'txnTemplate.label', default: 'TxnTemplate'), params.id])
    //             redirect action: "index", method: "GET"
    //         }
    //         '*'{ render status: NOT_FOUND }
    //     }
    // }
}
