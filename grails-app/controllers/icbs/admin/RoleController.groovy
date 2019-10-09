package icbs.admin



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import icbs.lov.ConfigItemStatus
import icbs.admin.RoleModule
    
@Transactional(readOnly = true)
class RoleController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def auditLogService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        if (params.sort == null) {  // default ordering
            params.sort = "code"
        }

        if (params.query == null) {  // show all instances            
            respond Role.list(params), model:[RoleInstanceCount: Role.count()]
        }
        else {    // show query results
            def roleList = Role.createCriteria().list(params) {
                or {
                    ilike("code", "%${params.query}%")
                    ilike("name", "%${params.query}%")
                }
            }
            respond roleList, model:[RoleInstanceCount: roleList.totalCount]
        }
    }

    def show(Role roleInstance) {
        respond roleInstance
    }

    def create() {
        respond new Role(params)
    }

    @Transactional
    def save(Role roleInstance) {
        roleInstance.configItemStatus = ConfigItemStatus.get(2)

        if (roleInstance == null) {
            notFound()
            return
        }

        if (roleInstance.hasErrors()) {
            respond roleInstance.errors, view:'create'
            return
        }

        roleInstance.save flush:true
        
        def modules = params.list('modules')
        
        modules.each {
            RoleModule rm = new RoleModule(module:it, role:roleInstance, configItemStatus:ConfigItemStatus.get(2)).save(flush:true)
        }

        // Log

        def description = 'save new role ' + roleInstance.name
        auditLogService.insert('040', 'ADM00602', description, 'role' ,null,null,'role/show/'+roleInstance.id, roleInstance.id)


        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'role.label', default: 'Role'), roleInstance.id])
                redirect roleInstance
            }
            '*' { respond roleInstance, [status: CREATED] }
        }
    }

    def edit(Role roleInstance) {
        respond roleInstance
    }

    @Transactional
    def update(Role roleInstance) {
        if (roleInstance == null) {
            notFound()
            return
        }

        if (roleInstance.hasErrors()) {
            respond roleInstance.errors, view:'edit'
            return
        }

        roleInstance.save flush:true

        def modules = params.list('modules')

        updateModules(roleInstance, modules)

        // Log

        def description = 'save new role ' + roleInstance.name
        auditLogService.insert('040', 'ADM00602', description, 'role' ,null,null,'role/show/'+roleInstance.id, roleInstance.id)


        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Role.label', default: 'Role'), roleInstance.id])
                redirect roleInstance
            }
            '*'{ respond roleInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Role roleInstance) {
        roleInstance.configItemStatus = ConfigItemStatus.get(3)

        if (roleInstance == null) {
            notFound()
            return
        }

        def rm = RoleModule.findAllByRole(roleInstance)
        for (r in rm) {
            r.configItemStatus = ConfigItemStatus.get(3)
            r.save(flush:true)
        }
        
        def ur = UserRole.findAllByRole(roleInstance)
        for (u in ur) {
            u.configItemStatus = ConfigItemStatus.get(3)
            u.save(flush:true)
        }
        roleInstance.save flush:true

        // Log

        def description = 'delete role ' + roleInstance.name
        auditLogService.insert('040', 'ADM00602', description, 'role' ,null,null,'role/show/'+roleInstance.id, roleInstance.id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Role.label', default: 'Role'), roleInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'role.label', default: 'Role'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def updateModules(Role roleInstance, def modules) {
        // add items that are selected
        for (id in modules) {
            def module = Module.get(id) 
            def link = RoleModule.findByRoleAndModule(roleInstance, module)
            
            if (!link) {
                (new RoleModule(role:roleInstance, module:module, configItemStatus:ConfigItemStatus.get(2))).save flush:true
            }
        }
        
        // remove items not selected
        for (module in roleInstance.modules) {
            if (module) {
                if (!(modules.contains(module.id.toString()))) {  // if existing, delete
                    def link = RoleModule.findByRoleAndModule(roleInstance, module)
                    link.delete flush:true   
                }
            } else {  // if there are no selected items, delete every item
                def link = RoleModule.findByRoleAndModule(roleInstance, module)
                link.delete flush:true   
            }
        }
    }
}
