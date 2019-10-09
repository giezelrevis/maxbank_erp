package icbs.admin
import icbs.lov.FirmSize
import icbs.lov.ResidentType
import icbs.lov.Town
import icbs.lov.LoanKindOfLoan
import icbs.lov.LoanProject
import icbs.lov.LoanSecurity
import org.springframework.dao.DataIntegrityViolationException

class LovMaintenanceController {
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    def index() { }
    
    def sizeOfFirmIndex(){
        def firmSize = FirmSize.list(sort: "code")
        respond firmSize
    }
    
    def firmSizeInstanceEdit(){
        def firmSize = FirmSize.get(params.id)
        if (firmSize){
            respond firmSize
        } else {
          redirect(action: "sizeOfFirmIndex")
        }           
    }
    
    def firmSizeInstanceUpdate(Long id, Long version){
        def firmSizeInstance = FirmSize.get(id)
        
        firmSizeInstance.properties = params
        if (!firmSizeInstance.save(flush: true)) {
            render(view: "firmSizeInstanceEdit", model: [firmSizeInstance: firmSizeInstance])
            return
        }
        flash.success = message(code: 'default.updated.message', args: [message(code: 'firmSize.label', default: 'FirmSize'), firmSizeInstance.id])
        redirect(action: "sizeOfFirmIndex", id: firmSizeInstance.id)
    }
    
    def firmSizeInstanceCreate() {
       [firmSizeInstance: new FirmSize(params)]  
    }
    
    def firmSizeInstanceSave() {
       def firmSizeInstance = new FirmSize(params)
        if (!firmSizeInstance.save(flush: true)) {
            render(view: "firmSizeInstanceCreate", model: [firmSizeInstance: firmSizeInstance])
            return
        }
        flash.success = message(code: 'default.created.message', args: [message(code: 'firmSize.label', default: 'FirmSize'), firmSizeInstance.id])
        redirect(action: "sizeOfFirmIndex", id: firmSizeInstance.id)
    }
    
     def firmSizeInstanceDelete(Long id) {
        def firmSizeInstance = FirmSize.get(id)
        if (!firmSizeInstance) {
            flash.success = message(code: 'default.not.found.message', args: [message(code: 'firmSize.label', default: 'FirmSize'), id])
            redirect(action: "sizeOfFirmIndex")
            return
        }
        try {
            firmSizeInstance.delete(flush: true)
            flash.success = message(code: 'default.deleted.message', args: [message(code: 'firmSize.label', default: 'FirmSize'), id])
            redirect(action: "sizeOfFirmIndex")
        }
        catch (DataIntegrityViolationException e) {
            flash.success = message(code: 'default.not.deleted.message', args: [message(code: 'firmSize.label', default: 'FirmSize'), id])
            redirect(action: "sizeOfFirmIndex", id: id)
        }
    }
    
    def customerResidentTypeIndex(){
       def residentType = ResidentType.list(sort:"code")
       respond residentType
   }
   
    def residentTypeInstanceEdit(){
        def residentType = ResidentType.get(params.id)
        if (residentType){
            respond residentType
        } else {
          redirect(action: "customerResidentTypeIndex")
        }      
    }
    
    def residentTypeInstanceUpdate(Long id, Long version){
        def residentTypeInstance = ResidentType.get(id)
        
        residentTypeInstance.properties = params
        if (!residentTypeInstance.save(flush: true)) {
            render(view: "residentTypeInstanceEdit", model: [residentTypeInstance: residentTypeInstance])
            return
        }
        flash.success = message(code: 'default.updated.message', args: [message(code: 'residentType.label', default: 'ResidentType'), residentTypeInstance.id])
        redirect(action: "customerResidentTypeIndex", id: residentTypeInstance.id)
    }
    
    def residentTypeInstanceCreate() {
       [residentTypeInstance: new ResidentType(params)]  
    }
    
    def residentTypeInstanceSave() {
       def residentTypeInstance = new ResidentType(params)
        if (!residentTypeInstance.save(flush: true)) {
            render(view: "residentTypeInstanceCreate", model: [residentTypeInstance: residentTypeInstance])
            return
        }
        flash.success = message(code: 'default.created.message', args: [message(code: 'residentType.label', default: 'ResidentType'), residentTypeInstance.id])
        redirect(action: "customerResidentTypeIndex", id: residentTypeInstance.id)
    }
    
    def residentTypeInstanceDelete(Long id) {
        def residentTypeInstance = ResidentType.get(id)
        if (!residentTypeInstance) {
            flash.success = message(code: 'default.not.found.message', args: [message(code: 'residentType.label', default: 'ResidentType'), id])
            redirect(action: "customerResidentTypeIndex")
            return
        }
        try {
            residentTypeInstance.delete(flush: true)
            flash.success = message(code: 'default.deleted.message', args: [message(code: 'residentType.label', default: 'ResidentType'), id])
            redirect(action: "customerResidentTypeIndex")
        }
        catch (DataIntegrityViolationException e) {
            flash.success = message(code: 'default.not.deleted.message', args: [message(code: 'residentType.label', default: 'ResidentType'), id])
            redirect(action: "customerResidentTypeIndex", id: id)
        }
    }
        
    
    def townAndMunicipalityIndex(){
       def town = Town.list(sort:"code")
       respond town
    }
    
    def townInstanceEdit(){
        def town = Town.get(params.id)
        if (town){
            respond town
        } else {
          redirect(action: "townAndMunicipalityIndex")
        }      
    }
    
    def townInstanceUpdate(Long id, Long version){
        def townInstance = Town.get(id)
        
        townInstance.properties = params
        if (!townInstance.save(flush: true)) {
            render(view: "townInstanceEdit", model: [townInstance: townInstance])
            return
        }
        flash.success = message(code: 'default.updated.message', args: [message(code: 'town.label', default: 'Town'), townInstance.id])
        redirect(action: "townAndMunicipalityIndex", id: townInstance.id)
    }
    
    def townInstanceCreate() {
       [townInstance: new Town(params)]  
    }
    
    def townInstanceSave() {
       def townInstance = new Town(params)
        if (!townInstance.save(flush: true)) {
            render(view: "townInstanceCreate", model: [townInstance: townInstance])
            return
        }
        flash.success = message(code: 'default.created.message', args: [message(code: 'town.label', default: 'Town'), townInstance.id])
        redirect(action: "townAndMunicipalityIndex", id: townInstance.id)
    }
    
    def townInstanceDelete(Long id) {
        def townInstance = Town.get(id)
        if (!townInstance) {
            flash.success = message(code: 'default.not.found.message', args: [message(code: 'town.label', default: 'Town'), id])
            redirect(action: "townAndMunicipalityIndex")
            return
        }
        try {
            townInstance.delete(flush: true)
            flash.success = message(code: 'default.deleted.message', args: [message(code: 'town.label', default: 'Town'), id])
            redirect(action: "townAndMunicipalityIndex")
        }
        catch (DataIntegrityViolationException e) {
            flash.success = message(code: 'default.not.deleted.message', args: [message(code: 'town.label', default: 'Town'), id])
            redirect(action: "townAndMunicipalityIndex", id: id)
        }
    }
   
    def kindsOfLoanIndex(){
       def loanKindOfLoan = LoanKindOfLoan.list(sort:"code")
       respond loanKindOfLoan
    }
    
    def kindsOfLoanInstanceEdit(){
        def loanKindOfLoan = LoanKindOfLoan.get(params.id)
        if (loanKindOfLoan){
            respond loanKindOfLoan
        } else {
          redirect(action: "kindsOfLoanIndex")
        }      
    }
    
    def kindsOfLoanInstanceUpdate(Long id, Long version){
        def loanKindOfLoanInstance = LoanKindOfLoan.get(id)
        
        loanKindOfLoanInstance.properties = params
        if (!loanKindOfLoanInstance.save(flush: true)) {
            render(view: "kindsOfLoanInstanceEdit", model: [loanKindOfLoanInstance: loanKindOfLoanInstance])
            return
        }
        flash.success = message(code: 'default.updated.message', args: [message(code: 'loanKindOfLoan.label', default: 'LoanKindOfLoan'), loanKindOfLoanInstance.id])
        redirect(action: "kindsOfLoanIndex", id: loanKindOfLoanInstance.id)
    }
    
    def kindsOfLoanInstanceCreate() {
       [loanKindOfLoanInstance: new LoanKindOfLoan(params)]  
    }
    
    def kindsOfLoanInstanceSave() {
       def loanKindOfLoanInstance = new LoanKindOfLoan(params)
        if (!loanKindOfLoanInstance.save(flush: true)) {
            render(view: "kindsOfLoanInstanceCreate", model: [loanKindOfLoanInstance: loanKindOfLoanInstance])
            return
        }
        flash.success = message(code: 'default.created.message', args: [message(code: 'loanKindOfLoan.label', default: 'LoanKindOfLoan'), loanKindOfLoanInstance.id])
        redirect(action: "kindsOfLoanIndex", id: loanKindOfLoanInstance.id)
    }
    
    def kindsOfLoanInstanceDelete(Long id) {
        def loanKindOfLoanInstance = LoanKindOfLoan.get(id)
        if (!loanKindOfLoanInstance) {
            flash.success = message(code: 'default.not.found.message', args: [message(code: 'loanKindOfLoan.label', default: 'LoanKindOfLoan'), id])
            redirect(action: "kindsOfLoanIndex")
            return
        }
        try {
            loanKindOfLoanInstance.delete(flush: true)
            flash.success = message(code: 'default.deleted.message', args: [message(code: 'loanKindOfLoan.label', default: 'LoanKindOfLoan'), id])
            redirect(action: "kindsOfLoanIndex")
        }
        catch (DataIntegrityViolationException e) {
            flash.success = message(code: 'default.not.deleted.message', args: [message(code: 'loanKindOfLoan.label', default: 'LoanKindOfLoan'), id])
            redirect(action: "kindsOfLoanIndex", id: id)
        }
    }
   
    def loanProjectIndex(){
       def loanProject = LoanProject.list(sort:"code")
       respond loanProject
    }
   
    def loanProjectInstanceEdit(){
        def loanProject = LoanProject.get(params.id)
        if (loanProject){
            respond loanProject
        } else {
          redirect(action: "loanProjectIndex")
        }      
    }
    
    def loanProjectInstanceUpdate(Long id, Long version){
        def loanProjectInstance = LoanProject.get(id)
        
        loanProjectInstance.properties = params
        if (!loanProjectInstance.save(flush: true)) {
            render(view: "loanProjectInstanceEdit", model: [loanProjectInstance: loanProjectInstance])
            return
        }
        flash.success = message(code: 'default.updated.message', args: [message(code: 'loanProject.label', default: 'LoanProject'), loanProjectInstance.id])
        redirect(action: "loanProjectIndex", id: loanProjectInstance.id)
    }
    
    def loanProjectInstanceCreate() {
       [loanProjectInstance: new LoanProject(params)]  
    }
    
    def loanProjectInstanceSave() {
       def loanProjectInstance = new LoanProject(params)
        if (!loanProjectInstance.save(flush: true)) {
            render(view: "loanProjectInstanceCreate", model: [loanProjectInstance: loanProjectInstance])
            return
        }
        flash.success = message(code: 'default.created.message', args: [message(code: 'loanProject.label', default: 'LoanProject'), loanProjectInstance.id])
        redirect(action: "loanProjectIndex", id: loanProjectInstance.id)
    }
    
    def loanProjectInstanceDelete(Long id) {
        def loanProjectInstance = LoanProject.get(id)
        if (!loanProjectInstance) {
            flash.success = message(code: 'default.not.found.message', args: [message(code: 'loanProject.label', default: 'LoanProject'), id])
            redirect(action: "loanProjectIndex")
            return
        }
        try {
            loanProjectInstance.delete(flush: true)
            flash.success = message(code: 'default.deleted.message', args: [message(code: 'loanProject.label', default: 'LoanProject'), id])
            redirect(action: "loanProjectIndex")
        }
        catch (DataIntegrityViolationException e) {
            flash.success = message(code: 'default.not.deleted.message', args: [message(code: 'loanProject.label', default: 'LoanProject'), id])
            redirect(action: "loanProjectIndex", id: id)
        }
    }
   
    def loanSecurityClassificationIndex(){
       def loanSecurity = LoanSecurity.list(sort:"code")
       respond loanSecurity
    }
   
   def loanSecurityInstanceEdit(){
        def loanSecurity = LoanSecurity.get(params.id)
        if (loanSecurity){
            respond loanSecurity
        } else {
          redirect(action: "loanSecurityClassificationIndex")
        }      
    }
    
    def loanSecurityInstanceUpdate(Long id, Long version){
        def loanSecurityInstance = LoanSecurity.get(id)
        
        loanSecurityInstance.properties = params
        if (!loanSecurityInstance.save(flush: true)) {
            render(view: "loanSecurityInstanceEdit", model: [loanSecurityInstance: loanSecurityInstance])
            return
        }
        flash.success = message(code: 'default.updated.message', args: [message(code: 'loanSecurity.label', default: 'LoanSecurity'), loanSecurityInstance.id])
        redirect(action: "loanSecurityClassificationIndex", id: loanSecurityInstance.id)
    }
    
    def loanSecurityInstanceCreate() {
       [loanSecurityInstance: new LoanSecurity(params)]  
    }
    
    def loanSecurityInstanceSave() {
       def loanSecurityInstance = new LoanSecurity(params)
        if (!loanSecurityInstance.save(flush: true)) {
            render(view: "loanSecurityInstanceCreate", model: [loanSecurityInstance: loanSecurityInstance])
            return
        }
        flash.success = message(code: 'default.created.message', args: [message(code: 'loanSecurity.label', default: 'LoanSecurity'), loanSecurityInstance.id])
        redirect(action: "loanSecurityClassificationIndex", id: loanSecurityInstance.id)
    }
    
    def loanSecurityInstanceDelete(Long id) {
        def loanSecurityInstance = LoanSecurity.get(id)
        if (!loanSecurityInstance) {
            flash.success = message(code: 'default.not.found.message', args: [message(code: 'loanSecurity.label', default: 'LoanSecurity'), id])
            redirect(action: "loanSecurityClassificationIndex")
            return
        }
        try {
            loanSecurityInstance.delete(flush: true)
            flash.success = message(code: 'default.deleted.message', args: [message(code: 'loanSecurity.label', default: 'LoanSecurity'), id])
            redirect(action: "loanSecurityClassificationIndex")
        }
        catch (DataIntegrityViolationException e) {
            flash.success = message(code: 'default.not.deleted.message', args: [message(code: 'loanSecurity.label', default: 'LoanSecurity'), id])
            redirect(action: "loanSecurityClassificationIndex", id: id)
        }
    }
    
}
