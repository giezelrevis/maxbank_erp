package icbs

import icbs.admin.Module
import icbs.admin.UserMaster
import icbs.admin.UserMessage

class MenuFilters {

    def roleModuleService
    def policyService

    def filters = {
        all(controller:'*', action:'*', controllerExclude: 'assets|ATMInterfaceListener', actionExclude:'login|authenticate|logout') {
            before = {

            }
            after = { Map model ->
                model?.cifMenu = roleModuleService.getMenu('CIF00000')
                model?.depositsMenu = roleModuleService.getMenu('DEP00000')
                model?.loansMenu = roleModuleService.getMenu('LON00000')
                model?.telleringMenu = roleModuleService.getMenu('TLR00000')
                model?.glMenu = roleModuleService.getMenu('GEN00000')
                model?.adminMenu = roleModuleService.getMenu('ADM00000')
                model?.configMenu = roleModuleService.getMenu('CFG00000')
                model?.auditMenu = roleModuleService.getMenu('AUD00000')
                model?.unreadMessages = UserMessage.findAllByRecipientAndIsRead(UserMaster.get(session.user_id), false).size
                model?.pendingPolicyExceptions = policyService.getPendingPolicyExceptionCount()
                model?.runDate = UserMaster.get(session.user_id).branch.runDate

                model?.subModules = roleModuleService.getPermittedModules()
            }
            afterView = { Exception e ->

            }
        }
    }
}
