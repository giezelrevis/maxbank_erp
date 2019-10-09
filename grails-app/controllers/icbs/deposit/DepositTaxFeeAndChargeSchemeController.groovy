package icbs.deposit


import icbs.lov.TfcSpecialCalculationType
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class DepositTaxFeeAndChargeSchemeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    
    def auditLogService
    
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        if(params.offset==null){
            params.offset=0
        }
        if (params.query == null) {
            respond DepositTaxFeeAndChargeScheme.list(params), model:[params:params,DepositTaxFeeAndChargeSchemeInstanceCount:  DepositTaxFeeAndChargeScheme.count()]
            return
        }
        else{
            def DepositTaxFeeAndChargeSchemeList = DepositTaxFeeAndChargeScheme.createCriteria().list (params) {
                or {
                    ilike("code", "%" + params.query.trim() + "%")
                    //ilike("name", "%" + params.query.trim() + "%")
                }
            }
            respond DepositTaxFeeAndChargeSchemeList, model:[params:params,DepositTaxFeeAndChargeSchemeInstanceCount: DepositTaxFeeAndChargeSchemeList.totalCount]
        }
        return
    }

    def show(DepositTaxFeeAndChargeScheme depositTaxFeeAndChargeSchemeInstance) {
        respond depositTaxFeeAndChargeSchemeInstance
    }

    def create() {
        respond new DepositTaxFeeAndChargeScheme(params)
    }

    @Transactional
    def save(DepositTaxFeeAndChargeScheme depositTaxFeeAndChargeSchemeInstance) {
        if (depositTaxFeeAndChargeSchemeInstance == null) {
            notFound()
            return
        }

        if (depositTaxFeeAndChargeSchemeInstance.hasErrors()) {
            respond depositTaxFeeAndChargeSchemeInstance.errors, view:'create'
            return
        }

        // do not update fields based on type
        // tax rate
        if (depositTaxFeeAndChargeSchemeInstance.type.id == 1) {
            depositTaxFeeAndChargeSchemeInstance.feeRate = 0d
            depositTaxFeeAndChargeSchemeInstance.feeAmt = 0d
            depositTaxFeeAndChargeSchemeInstance.chargeRate = 0d
            depositTaxFeeAndChargeSchemeInstance.chargeAmt = 0d
            depositTaxFeeAndChargeSchemeInstance.feeBaseAmtCondition = false
            depositTaxFeeAndChargeSchemeInstance.feeCountCondition = false
            depositTaxFeeAndChargeSchemeInstance.gracePeriod = 0
            depositTaxFeeAndChargeSchemeInstance.feeRateBasis = 0d
            depositTaxFeeAndChargeSchemeInstance.chargeRateBasis = 0d
        }
        // tax amount
        if (depositTaxFeeAndChargeSchemeInstance.type.id == 2) {
            depositTaxFeeAndChargeSchemeInstance.taxRate = 0d
            depositTaxFeeAndChargeSchemeInstance.feeRate = 0d
            depositTaxFeeAndChargeSchemeInstance.feeAmt = 0d
            depositTaxFeeAndChargeSchemeInstance.chargeRate = 0d
            depositTaxFeeAndChargeSchemeInstance.chargeAmt = 0d
            depositTaxFeeAndChargeSchemeInstance.specialCalculation = TfcSpecialCalculationType.get(5)
            depositTaxFeeAndChargeSchemeInstance.feeBaseAmtCondition = false
            depositTaxFeeAndChargeSchemeInstance.feeCountCondition = false
            depositTaxFeeAndChargeSchemeInstance.gracePeriod = 0
            depositTaxFeeAndChargeSchemeInstance.feeRateBasis = 0d
            depositTaxFeeAndChargeSchemeInstance.chargeRateBasis = 0d             
        }        
        // fee rate
        if (depositTaxFeeAndChargeSchemeInstance.type.id == 3) {
            depositTaxFeeAndChargeSchemeInstance.taxRate = 0d
            depositTaxFeeAndChargeSchemeInstance.feeAmt = 0d
            depositTaxFeeAndChargeSchemeInstance.chargeRate = 0d
            depositTaxFeeAndChargeSchemeInstance.chargeAmt = 0d
            depositTaxFeeAndChargeSchemeInstance.chargeRateBasis = 0d
            depositTaxFeeAndChargeSchemeInstance.minAmtException = 0d               
        }
        // fee amount
        if (depositTaxFeeAndChargeSchemeInstance.type.id == 4) {
            depositTaxFeeAndChargeSchemeInstance.taxRate = 0d
            depositTaxFeeAndChargeSchemeInstance.feeRate = 0d
            depositTaxFeeAndChargeSchemeInstance.chargeRate = 0d
            depositTaxFeeAndChargeSchemeInstance.chargeAmt = 0d
            depositTaxFeeAndChargeSchemeInstance.feeRateBasis = 0d
            depositTaxFeeAndChargeSchemeInstance.chargeRateBasis = 0d
            depositTaxFeeAndChargeSchemeInstance.minAmtException = 0d               
        }
        // charge rate
        if (depositTaxFeeAndChargeSchemeInstance.type.id == 5) {
            depositTaxFeeAndChargeSchemeInstance.taxRate = 0d
            depositTaxFeeAndChargeSchemeInstance.feeRate = 0d
            depositTaxFeeAndChargeSchemeInstance.feeAmt = 0d
            depositTaxFeeAndChargeSchemeInstance.chargeAmt = 0d
            depositTaxFeeAndChargeSchemeInstance.feeBaseAmtCondition = false
            depositTaxFeeAndChargeSchemeInstance.feeCountCondition = false
            depositTaxFeeAndChargeSchemeInstance.feeRateBasis = 0d
            depositTaxFeeAndChargeSchemeInstance.minAmtException = 0d               
        }
        // charge amount
        if (depositTaxFeeAndChargeSchemeInstance.type.id == 6) {
            depositTaxFeeAndChargeSchemeInstance.taxRate = 0d
            depositTaxFeeAndChargeSchemeInstance.feeRate = 0d
            depositTaxFeeAndChargeSchemeInstance.feeAmt = 0d
            depositTaxFeeAndChargeSchemeInstance.chargeRate = 0d
            depositTaxFeeAndChargeSchemeInstance.feeBaseAmtCondition = false
            depositTaxFeeAndChargeSchemeInstance.feeCountCondition = false
            depositTaxFeeAndChargeSchemeInstance.feeRateBasis = 0d
            depositTaxFeeAndChargeSchemeInstance.chargeRateBasis = 0d
            depositTaxFeeAndChargeSchemeInstance.minAmtException = 0d               
        }
        
        depositTaxFeeAndChargeSchemeInstance.save flush:true
        auditLogService.insert('040', 'CFG01400', 'save new '+depositTaxFeeAndChargeSchemeInstance.description, 'depositTaxFeeAndChargeScheme', null, null, null, depositTaxFeeAndChargeSchemeInstance.id)    
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'depositTaxFeeAndChargeScheme.label', default: 'DepositTaxFeeAndChargeScheme'), depositTaxFeeAndChargeSchemeInstance.id])
                redirect depositTaxFeeAndChargeSchemeInstance
            }
            '*' { respond depositTaxFeeAndChargeSchemeInstance, [status: CREATED] }
        }
    }

    def edit(DepositTaxFeeAndChargeScheme depositTaxFeeAndChargeSchemeInstance) {
        respond depositTaxFeeAndChargeSchemeInstance
    }

    @Transactional
    def update(DepositTaxFeeAndChargeScheme depositTaxFeeAndChargeSchemeInstance) {
        if (depositTaxFeeAndChargeSchemeInstance == null) {
            notFound()
            return
        }

        if (depositTaxFeeAndChargeSchemeInstance.hasErrors()) {
            respond depositTaxFeeAndChargeSchemeInstance.errors, view:'edit'
            return
        }
        // do not update fields based on type
        // tax rate
        if (depositTaxFeeAndChargeSchemeInstance.type.id == 1) {
            depositTaxFeeAndChargeSchemeInstance.feeRate = 0d
            depositTaxFeeAndChargeSchemeInstance.feeAmt = 0d
            depositTaxFeeAndChargeSchemeInstance.chargeRate = 0d
            depositTaxFeeAndChargeSchemeInstance.chargeAmt = 0d
            depositTaxFeeAndChargeSchemeInstance.feeBaseAmtCondition = false
            depositTaxFeeAndChargeSchemeInstance.feeCountCondition = false
            depositTaxFeeAndChargeSchemeInstance.gracePeriod = 0
            depositTaxFeeAndChargeSchemeInstance.feeRateBasis = 0d
            depositTaxFeeAndChargeSchemeInstance.chargeRateBasis = 0d
        }
        // tax amount
        if (depositTaxFeeAndChargeSchemeInstance.type.id == 2) {
            depositTaxFeeAndChargeSchemeInstance.taxRate = 0d
            depositTaxFeeAndChargeSchemeInstance.feeRate = 0d
            depositTaxFeeAndChargeSchemeInstance.feeAmt = 0d
            depositTaxFeeAndChargeSchemeInstance.chargeRate = 0d
            depositTaxFeeAndChargeSchemeInstance.chargeAmt = 0d
            depositTaxFeeAndChargeSchemeInstance.specialCalculation = TfcSpecialCalculationType.get(5)
            depositTaxFeeAndChargeSchemeInstance.feeBaseAmtCondition = false
            depositTaxFeeAndChargeSchemeInstance.feeCountCondition = false
            depositTaxFeeAndChargeSchemeInstance.gracePeriod = 0
            depositTaxFeeAndChargeSchemeInstance.feeRateBasis = 0d
            depositTaxFeeAndChargeSchemeInstance.chargeRateBasis = 0d             
        }        
        // fee rate
        if (depositTaxFeeAndChargeSchemeInstance.type.id == 3) {
            depositTaxFeeAndChargeSchemeInstance.taxRate = 0d
            depositTaxFeeAndChargeSchemeInstance.feeAmt = 0d
            depositTaxFeeAndChargeSchemeInstance.chargeRate = 0d
            depositTaxFeeAndChargeSchemeInstance.chargeAmt = 0d
            depositTaxFeeAndChargeSchemeInstance.chargeRateBasis = 0d
            depositTaxFeeAndChargeSchemeInstance.minAmtException = 0d               
        }
        // fee amount
        if (depositTaxFeeAndChargeSchemeInstance.type.id == 4) {
            depositTaxFeeAndChargeSchemeInstance.taxRate = 0d
            depositTaxFeeAndChargeSchemeInstance.feeRate = 0d
            depositTaxFeeAndChargeSchemeInstance.chargeRate = 0d
            depositTaxFeeAndChargeSchemeInstance.chargeAmt = 0d
            depositTaxFeeAndChargeSchemeInstance.feeRateBasis = 0d
            depositTaxFeeAndChargeSchemeInstance.chargeRateBasis = 0d
            depositTaxFeeAndChargeSchemeInstance.minAmtException = 0d               
        }
        // charge rate
        if (depositTaxFeeAndChargeSchemeInstance.type.id == 5) {
            depositTaxFeeAndChargeSchemeInstance.taxRate = 0d
            depositTaxFeeAndChargeSchemeInstance.feeRate = 0d
            depositTaxFeeAndChargeSchemeInstance.feeAmt = 0d
            depositTaxFeeAndChargeSchemeInstance.chargeAmt = 0d
            depositTaxFeeAndChargeSchemeInstance.feeBaseAmtCondition = false
            depositTaxFeeAndChargeSchemeInstance.feeCountCondition = false
            depositTaxFeeAndChargeSchemeInstance.feeRateBasis = 0d
            depositTaxFeeAndChargeSchemeInstance.minAmtException = 0d               
        }
        // charge amount
        if (depositTaxFeeAndChargeSchemeInstance.type.id == 6) {
            depositTaxFeeAndChargeSchemeInstance.taxRate = 0d
            depositTaxFeeAndChargeSchemeInstance.feeRate = 0d
            depositTaxFeeAndChargeSchemeInstance.feeAmt = 0d
            depositTaxFeeAndChargeSchemeInstance.chargeRate = 0d
            depositTaxFeeAndChargeSchemeInstance.feeBaseAmtCondition = false
            depositTaxFeeAndChargeSchemeInstance.feeCountCondition = false
            depositTaxFeeAndChargeSchemeInstance.feeRateBasis = 0d
            depositTaxFeeAndChargeSchemeInstance.chargeRateBasis = 0d
            depositTaxFeeAndChargeSchemeInstance.minAmtException = 0d               
        }
        depositTaxFeeAndChargeSchemeInstance.save flush:true
        auditLogService.insert('040', 'CFG01400', 'update '+depositTaxFeeAndChargeSchemeInstance.description, 'depositTaxFeeAndChargeScheme', null, null, null, depositTaxFeeAndChargeSchemeInstance.id)    

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'DepositTaxFeeAndChargeScheme.label', default: 'DepositTaxFeeAndChargeScheme'), depositTaxFeeAndChargeSchemeInstance.id])
                redirect depositTaxFeeAndChargeSchemeInstance
            }
            '*'{ respond depositTaxFeeAndChargeSchemeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(DepositTaxFeeAndChargeScheme depositTaxFeeAndChargeSchemeInstance) {

        if (depositTaxFeeAndChargeSchemeInstance == null) {
            notFound()
            return
        }

        depositTaxFeeAndChargeSchemeInstance.delete flush:true
        auditLogService.insert('040', 'CFG01400', 'delete '+depositTaxFeeAndChargeSchemeInstance.description, 'depositTaxFeeAndChargeScheme', null, null, null, depositTaxFeeAndChargeSchemeInstance.id)    

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'DepositTaxFeeAndChargeScheme.label', default: 'DepositTaxFeeAndChargeScheme'), depositTaxFeeAndChargeSchemeInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'depositTaxFeeAndChargeScheme.label', default: 'DepositTaxFeeAndChargeScheme'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
