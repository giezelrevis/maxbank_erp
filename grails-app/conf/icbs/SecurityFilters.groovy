package icbs

class SecurityFilters {

    def userMasterService

    def filters = {
        loginCheck(controller:'*', action:'*', controllerExclude: 'assets|ATMInterfaceListener', actionExclude:'login|authenticate|logout') {
            before = {
                if(!session.user) {
                    redirect(controller:"authentication", action:"login")
                    return false
                }
            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }
        changePasswordCheck(controller:'*', action:'*', controllerExclude: 'assets|ATMInterfaceListener', actionExclude:'login|authenticate|logout|changePassword|saveChangePassword') {
            before = {
                if(userMasterService.checkIfChangePassword()) {
                    redirect(controller:"userMaster", action:"changePassword")
                    return false
                }
            }
        }
    }
}
