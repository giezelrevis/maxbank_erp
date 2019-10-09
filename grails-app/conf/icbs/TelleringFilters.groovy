package icbs

import icbs.admin.Branch
import icbs.admin.UserMaster

class TelleringFilters {

    def filters = {
        all(controller:'tellering', action:'*') {
            before = {
                def branch = UserMaster.get(session.user_id).branch
                if(!branch.isTelleringActive) {
                    flash.error = "Teller transactions not allowed."
                    redirect(controller:'home', action:'landing')
                    return false
                }
            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }
    }
}
