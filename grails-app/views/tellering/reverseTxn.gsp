<%@ page import="icbs.tellering.TxnFile" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <title>Reversal Transaction Success</title>
    </head>    
    <body>
        <content tag="main-content">

            <br> <br>
          
            <div class="row">
                <div class="form-horizontal">
                    <div class="col-md-8">
                        <div class="infowrap">
                            <table class="table table-bordered table-striped">
                                <legend class="section-header">Reversed Transaction Details</legend>
                                    <tr>
                                        <td> Transaction ID </td>
                                        <td><g:fieldValue bean="${reverseTransactionFileInstance}" field="id"/></td>
                                    </tr>                                
                                    <tr>
                                        <td> Transaction Date </td>
                                        <td><g:formatDate  format="MM/dd/yyyy" date="${reverseTransactionFileInstance?.txnDate}" /></td>
                                    </tr>
                                    <tr>
                                        <td> Transaction Type </td>
                                        <td><g:fieldValue bean="${reverseTransactionFileInstance}" field="txnType.description"/></td>
                                    </tr>
                                    <tr>
                                        <td> Account Number </td>
                                        <td><g:fieldValue bean="${reverseTransactionFileInstance}" field="acctNo"/></td>
                                    </tr>                                    
                                    <tr>
                                        <td> branch </td>
                                        <td><g:fieldValue bean="${reverseTransactionFileInstance}" field="branch.name"/></td>
                                    </tr>                                     
                                    <tr>
                                        <td> Transaction Amount </td>
                                        <td><g:formatNumber format="###,###,##0.00" number="${reverseTransactionFileInstance?.txnAmt}"/></td>
                                    </tr>

                                    <tr>
                                        <td> Transaction Code </td>
                                        <td><g:fieldValue bean="${reverseTransactionFileInstance}" field="txnCode"/></td>
                                    </tr>
                                    <tr>
                                        <td> Transaction Template </td>
                                        <td><g:fieldValue bean="${reverseTransactionFileInstance}" field="txnTemplate.description"/></td>
                                    </tr>                                      
                                    <tr>
                                        <td> Transaction Description </td>
                                        <td><g:fieldValue bean="${reverseTransactionFileInstance}" field="txnDescription"/></td>
                                    </tr>  
                                    <tr>
                                        <td> Reference </td>
                                        <td><g:fieldValue bean="${reverseTransactionFileInstance}" field="txnRef"/></td>
                                    </tr>
                                    <tr>
                                        <td> Particulars </td>
                                        <td><g:fieldValue bean="${reverseTransactionFileInstance}" field="txnParticulars"/></td>
                                    </tr>
                                     <tr>
                                        <td> Reversal Transaction Particulars </td>
                                        <td>${getRefereceAndParticularsReverseInstance.txnParticulars.toString().replace("[", "").replace("]", "")}</td>
                                    </tr>
                                     <tr>
                                        <td> Reversal Transaction Reference </td>
                                        <td>${getRefereceAndParticularsReverseInstance.txnReference.toString().replace("[", "").replace("]", "")}</td>
                                    </tr>
                                    <tr>
                                        <td> Status </td>
                                        <td><g:fieldValue bean="${reverseTransactionFileInstance}" field="status.description"/> </td>
                                    </tr>
                                    <tr>
                                        <td> User </td>
                                        <td><g:fieldValue bean="${reverseTransactionFileInstance}" field="user.username"/></td>
                                    </tr>                                    
                            </table>


                        </div>
                    </div>

                </div>
            </div>
    <script>
        function asd(){
            //var w = window.open("${g.createLink(controller: 'tellering', action: 'printValidationSlip', params: [txnFile:reverseTransactionFileInstance.id])}",'_blank');
            //w.print();        
            //}
        function genReportTLR001(){
                        //reportlink = "${icbs.admin.Institution.get(94).paramValue}${icbs.admin.Report.get(20).baseParams}&output=${icbs.admin.Report.get(20).outputParam}";
                        //reportlink = reportlink + "&reportUnit=${icbs.admin.Report.get(20).reportUnit}";             
                        //reportlink = reportlink + "&txn_file_id_for_cashbreakdown=${reverseTransactionFileInstance.id}";
                        //reportlink = reportlink + "&generatedby=${icbs.admin.UserMaster.get(session.user_id).username}";
                        //sendtojasperver(reportlink);
                    }
                    
        function genReportTSLP001(){
                        //reportlink = "${icbs.admin.Institution.get(94).paramValue}${icbs.admin.Report.get(62).baseParams}&output=${icbs.admin.Report.get(62).outputParam}";
                        //reportlink = reportlink + "&reportUnit=${icbs.admin.Report.get(62).reportUnit}";             
                        //reportlink = reportlink + "&txn_file_id=${reverseTransactionFileInstance.id}";
                        //reportlink = reportlink + "&generatedby=${icbs.admin.UserMaster.get(session.user_id).username}";
                        //sendtojasperver(reportlink);
                    }
    </script>
    <script>
        function txnslip(){
            //var w = window.open("${g.createLink(controller: 'tellering', action: 'printTransactionSlip', params: [txnFile:reverseTransactionFileInstance.id])}",'_blank');
            //w.print();        
            }
    </script>
                <div id="SlipTransaction" class="alert alert-success alert-dismissable" role="alert">
                   <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <div> 
                            <a onclick="javascript:asd()">
                                <g:img dir="images" file="validate.png" width="35" height="35"/>
                                Validation Slip
                            </a>
                            &nbsp;&nbsp;
                            <a onclick="javascript:genReportTSLP001()">
                                <g:img dir="images" file="transactionslip.png" width="35" height="35"/>
                                 Transaction Slip1
                            </a>
                            &nbsp;&nbsp;
                            
                            <a onclick="
                               <%-- if ($('#passbookline').val() == 1 && $('#id').val() != $('#jrxmlTcId').val() ) {
                                    alertify.confirm(AppTitle,'Passbook page reach the maximum line, turn to next page.',
                                    function(){
                                    var w = window.open('printPassbookTransactions', '_blank');
                                        w.print(); 
                                    },
                                function(){return;});
                                }
                                --%>
                            
                                else {
                                     var w = window.open('printPassbookTransactions', '_blank');
                                    w.print(); 
                                }
                                ">
                                 <g:img dir="images" file="passbook-icon.jpg" width="35" height="35"/>
                                 <g:link action="printPassbookTransactions" params="${[txnId: reverseTransactionFileInstance.id]}">Passbook</g:link>
                            </a>
                            
                            <p><input id="passbookline"  name="passbookline" required="" value="${passbookline}" style="display:none"/></p>
                            <p><input id="id"  name="id" required="" value="${id}" style="display:none"/></p>
                            <p><input id="jrxmlTcId"  name="jrxmlTcId" required="" value="${jrxmlTcId}" style="display:none"/></p>
                        </div>   
                </div>                                 
        </content>
        
        <content tag="main-actions">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
            </ul>                                        
        </content>
    </body>
</html>
