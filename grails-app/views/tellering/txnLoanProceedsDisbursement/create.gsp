<%@ page contentType="text/html;charset=UTF-8" %>


<!DOCTYPE html>

<html>
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <title>Loan Proceeds Disbursement Transaction</title>
        
        <script type="text/javascript" src="${resource(dir: 'js', file: 'customerSearch.js')}"></script>
        <asset:javascript src="telleringHelper.js"/>

        <g:javascript>
            function updateBreakdown() {
                Net = parseFloat($('#totalNetProceeds').val().replace(',', ''));
                if (isNaN(Net))
                    Net = 0;
                $('#DisburseAmt').val(Net);
                $('#TotalProceeds').val(Net);
            }
            
            function addCommas(nStr)
            {
                nStr += '';
                x = nStr.split('.');
                x1 = x[0];
                x2 = x.length > 1 ? '.' + x[1] : '';
                var rgx = /(\d+)(\d{3})/;
                while (rgx.test(x1)) {
                        x1 = x1.replace(rgx, '$1' + ',' + '$2');
                }
                return x1 + x2;
            }
            
            var modal;
            function refreshForm(params){
                if(params.loan2){
                    //icbs.Tellering.loanDetails('getLoanDetailsCallback',"${createLink(controller : 'tellering', action:'changeLoanDetails')}",{loan:params.loan2});
                    
                    $.ajax({
                        type: 'POST',
                        data: {loan:params.loan2},
                        url: "${createLink(controller:'tellering', action:'changeLoanDetails')}",
                        success: function(msg){	         
                            $('#loanId').val($(msg).find('#acctId').html());
                            $('#accountNo').html($(msg).find('#accountNo').html());
                            $('#customer').html($(msg).find('#customer').html());
                            $('#photo').html($(msg).find('#photo').html());                                   
                            $('#openingDate').html($(msg).find('#openingDate').html());                                   
                            $('#status').html($(msg).find('#status').html());
                            $('#grantedAmt').html($(msg).find('#grantedAmt').html());
                            $('#totalNetProceeds1').html($(msg).find('#totalNetProceeds1').html());
                            
                            $('#totalNetProceeds').val(parseFloat($(msg).find('#totalNetProceeds').html()));
                            
                            $('#Net_Proceeds').val(parseFloat($(msg).find('#totalNetProceeds1').html()));
                            $('#Net_Disburse').val(parseFloat($(msg).find('#disb').html()));
                            document.getElementById('totalNetProceeds').value = $('#totalNetProceeds1').html();
                            updateBreakdown();
                        },
                        error:function(XMLHttpRequest,textStatus,errorThrown){
                            alert(XMLHttpRequest+textStatus+errorThrown);
                        }
                    });
                }
            }
            function initializeLoanAcctSearchModal(){
                modal = new icbs.UI.Modal({id:"loanModal",url:"${createLink(controller : 'loan', action:'search', params:[searchDomain: "loan", flag: flag_])}",title:"Search Loan Account",onCloseCallback:refreshForm});
            }
        </g:javascript>         
    </head>
    
    <body>
        <content tag="main-content">
           <g:if test="${flash.message}">
                <script>
                        $(function(){
                            var x = '${flash.message}';
                                notify.message(x);
                                $('#SlipTransaction').hide();
                                if(x.indexOf('|success') > -1){
                                $('#SlipTransaction').show();
                            }
                           // console.log(x)
                           // setTimeout(function(){ notify.success(x); }, 3000);
                        });
                </script>
                <div id="SlipTransaction" class="alert alert-success alert-dismissable" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                    <div> 
                        <a onclick="
                                 var w = window.open('printValidationSlip', '_blank')
                                     w.print();
                                 ">
                             <g:img dir="images" file="validate.png" width="35" height="35"/>
                             Validation Slip
                        </a>
                        &nbsp;&nbsp;
                        <a onclick="
                                var w = window.open('printTransactionSlip', '_blank')
                                    w.print();
                                ">
                             <g:img dir="images" file="transactionslip.png" width="35" height="35"/>
                             Transaction Slip 
                        </a>
                    </div>   
                </div>
            </g:if>
            <g:hasErrors bean="${txnLoanProceedsDisbursementInstance}">
                <script>
                    $(function(){
                        var x = '${it}';
                        notify.error(x);
                       // console.log(x)
                       // setTimeout(function(){ notify.success(x); }, 3000);
                    });
                </script>
<!--            <div id= "addCustomerRelatedError" class="box-body">
                    <div class="alert alert-danger alert-dismissable">
                        <i class="fa fa-ban"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Alert!</b> 
                        <ul class="errors" role="alert">
                            <div id="errorList">
                            </div>
                            <g:eachError bean="${txnLoanProceedsDisbursementInstance}" var="error">
                                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                            </g:eachError>
                        </ul>            
                    </div>
                </div>-->
            </g:hasErrors>
            <g:form name="txnLoanProceedsDisbursementForm" action="saveTellerLoanProceedsDisbursementTxn" controller="tellering">
                <g:render template='txnLoanProceedsDisbursement/form' model="[txnLoanProceedsDisbursementInstance:txnLoanProceedsDisbursementInstance]"/>
            </g:form>
 
        </content>
        
        <!--Grails tag for jasper plugin-->
         <g:jasperReport action="printSLIP"  controller="tellering" format="PDF" name="TRANSACTION"  jasper="SLIP">
         </g:jasperReport>
        
        <content tag="main-actions">
            <script>
                function createnew()
                {
                    if(!$('#txnTemplate').val()){
                        notify.message('Transaction type required!|error|alert');return;   
                    }
                    if(!$('#loanId').val()){
                        notify.message('Customer required!|error|alert');return;   
                    }
                    if($('#status').html() != 'Approved')
                    {
                        notify.message('Loan not yet approved!|error|alert');return;  
                    }
                    //alert(totalcash);
                    totalcash = +totalcash.toFixed(2);
                    if(totalcash < $('#TotalProceeds').val())
                    {
                        notify.message('Unable to continue transaction. Not enough cash on hand!|error|alert');return;   
                    }                      
                    if($('#TotalProceeds').val() == 0)
                    {
                        notify.message('Net proceeds amount required!|error|alert');return; 
                    }
                    if($('#TotalProceeds').val() < 0)
                    {
                        notify.message('Net proceeds amount must be greater than 0!|error|alert');return; 
                    }
                    if(!$('#txnRef').val()){
                        notify.message('Transaction reference required!|error|alert');return;   
                    }
                    if(parseFloat(($('#totalNetProceeds').val()).replace(',','')) > 0){
                        //if(parseFloat(($('#Net_Disburse').val()).replace(',','')) < parseFloat(($('#Net_Proceeds').val()).replace(',',''))){
                            //if((parseFloat(($('#Net_Disburse').val()).replace(',','')) + parseFloat(($('#DisburseAmt').val()).replace(',',''))) <= parseFloat(($('#Net_Proceeds').val()).replace(',',''))){
                                alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                    //jQuery('#txnLoanProceedsDisbursementForm').submit();
                                    checkIfAllowed($('#txnTemplate option:selected').data('code'), 'form#txnLoanProceedsDisbursementForm', 'txnLoanProceedsDisbursementOverride', $('#TotalProceeds').val());
                                },
                                function(){
                                    return;
                                });
                            //}else {
                            //    notify.message('Disburse amount cannot be greater than the net proceeds!|error|alert');return;
                            //}    
                        //}else{
                        //    notify.message('Disburse amount is already greater than total net proceeds!|error|alert');return;
                        //}
                    }else{
                        notify.message('Disburse amount must be greater than zero(0)!|error|alert');return;
                    }
                }
            </script>
            <ul>
                <li><a class="save" onclick="createnew()">${message(code: 'default.button.create.label', default: 'Create')}</a></li>
                <li><g:link action="index" >Tellering Index</g:link></li>
            </ul>                                       
        </content>
    </body>
</html>
