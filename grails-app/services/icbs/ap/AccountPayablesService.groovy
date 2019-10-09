package icbs.ap

import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.util.WebUtils
import javax.servlet.http.HttpSession
import org.springframework.web.context.request.RequestContextHolder

import accounting.bankpayables.AccountsPayables

@Transactional
class AccountPayablesService {

    def insert(String amount, String checknumber, String clientname, String glaccount, String particulars, String reference, String transdate) {

        def c = new AccountsPayables(
            amount: amount,
            checknunmber: checknumber,
            clientname: clientname,
            glaccount: glaccount,
            particulars: particulars,
            reference: reference,
            tag: '1',
            transdate: transdate
        )

        c.save flush:true

        println "Done"
    }
}
