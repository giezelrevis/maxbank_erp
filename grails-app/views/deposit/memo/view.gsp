<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <asset:javascript src="depositHelper.js"/>
        <title>Memo Transactions</title>
        <g:javascript>
            function changeMemoForm(caller){
                if(caller==="adjustment"){
                    checkIfAllowed("DEP01001", adjustmentAuthCallback);     
                }
                if(caller==="remittance"){
                    checkIfAllowed("DEP01002", remittanceAuthCallback);
                }
                if(caller==="billsPayment"){
                    checkIfAllowed("DEP01003", billsPaymentAuthCallback);
                }
            }
            var memotypevalidate = ""
            function adjustmentAuthCallback() {
                    console.log("pumasok na dito jm");
                    console.log("memotypevalidate: "+memotypevalidate);
                    
                    //icbs.Deposit.Memo('adjForm',"${createLink(controller : 'deposit', action:'changeMemoFormAjax')}",$('#adjustmentFormSend').serialize()+"&formType=0");
                    if(memotypevalidate == 1){
                        console.log("sending form debit");
                        alertify.confirm(AppTitle,"Are you sure about this Transaction?",
                        function(){
                           document.getElementById("adjustmentMemoDebitFormSend").submit();
                        },
                        function(){
                          alertify.error('Canceled');
                        });
                        
                    }else{
                        console.log("sending form credit");
                        alertify.confirm(AppTitle,"Are you sure about this Transaction?",
                        function(){
                           document.getElementById("adjustmentMemoCreditFormSend").submit();
                        },
                        function(){
                          alertify.error('Canceled');
                        });                        
                        
                    }

            }
            function remittanceAuthCallback() {
                icbs.Deposit.Memo('remForm',"${createLink(controller : 'deposit', action:'changeMemoFormAjax')}",$('#remittanceFormSend').serialize()+"&formType=1");
            }
            function billsPaymentAuthCallback() {
                icbs.Deposit.Memo('billsForm',"${createLink(controller : 'deposit', action:'changeMemoFormAjax')}",$('#billsPaymentFormSend').serialize()+"&formType=2");
            }
            var modal;
            function updateCustomerDetailsForm(params){
                params.boxName = "Sender";
                icbs.Deposit.Form.getForm('customerDetails',"${createLink(controller : 'deposit', action:'showCustomerDetailsAjax')}",params);
            }
            function initializeCustomerDetailsSearchModal(){
                modal = new icbs.UI.Modal({id:"customerDetailsModal",url:"${createLink(controller : 'search', action:'search')}",title:"Search Customer",onCloseCallback:updateCustomerDetailsForm});
            }
           
        </g:javascript>
    </head>
    <body>
        <content tag="breadcrumbs">
            <span class="fa fa-chevron-right"></span><span class="current">Memo Transaction</span>
	</content>
        <content tag="main-content">
            <g:if test="${flash.message}">
                      <script>
                        $(function(){
                            var x = '${flash.message}';
                            console.log("x value: "+x);
                            var idDepositxD = $('#depositIdx').val()
                            var x1 = "/icbs/deposit/viewMemo/"+idDepositxD
                            console.log("x1: "+x1);
                            
                            console.log("idDepositxD: "+idDepositxD);
                            alertify.alert(AppTitle,""+x, function(){
                              window.location = x1;
                            });
                            
                            
                            
                        });
                </script>  
            </g:if>
             <g:if test="${flash.errors}">
                 <script>
                    $(function(){
                        var x = '${it}';
                        notify.error(x);
                       // console.log(x)
                       // setTimeout(function(){ notify.success(x); }, 3000);
                    });
                </script>
            </g:if>
            <g:hasErrors bean="${billsPaymentInstance}">
                <script>
                    $(function(){
                        var x = '${it}';
                        notify.message(x);
                       // console.log(x)
                       // setTimeout(function(){ notify.success(x); }, 3000);
                    });
                </script>
            </g:hasErrors>
            <g:hasErrors bean="${remittanceInstance}">
                <script>
                    $(function(){
                        var x = '${flash.message}';
                                notify.message(x);
                    });
                </script>
            </g:hasErrors>
            <g:hasErrors bean="${adjustmentInstance}">
                <script>
                    $(function(){
                        var x = '${it}';
                        notify.message(x);
                       // console.log(x)
                       // setTimeout(function(){ notify.success(x); }, 3000);
                    });
                </script>
            </g:hasErrors>
            <div class="row">
                <div class="col-md-12">
                   <g:render template='/customer/details/newCustomerDetailedInfo' model="[customerInstance:depositInstance?.customer]"/>
                </div>

                <div class="col-md-12">
                   <g:render template='/deposit/details/depositDetails' model="[depositInstance:depositInstance]"/> 
                </div>
            </div>
            <g:if test = "${depositInstance.type.id == 3}">
                <div class="row">
                    <div class="col-md-12">
                        <g:render template='/deposit/details/fdDetails' model="[depositInstance:depositInstance]"/>
                    </div>
                </div>
            </g:if>    

            
            <div class="section-container">
                <legend class="section-header">Memo Transaction Details</legend>
                <div class="box-body table-responsive no-padding">

                            <table class="table table-hover table-condensed table-bordered table-striped">
                                <tr> 
                                    <td><label>Txn ID</label></td>
                                    <td><label>Txn Date</label></td>
                                    <td><label>Txn Type</label></td>
                                    <td><label>Teller</label></td>
                                    <td><label>Transaction Amount</label></td>            
                                    <td><label>Currency</label></td>
                                    <td><label>Txn Reference</label></td>
                                    <td><label>Actions</label></td>
                                </tr>
                                <g:each in="${TxnFileInstance}" status="i" var="domainInstance">   
                                        <tr>
                                            <td>${domainInstance?.id}</td>
                                            
                                            <td>${domainInstance?.txnDate?.format("MM/dd/yyyy")}</td>
                                             <td>${domainInstance?.txnType}</td>
                                             <td>${domainInstance?.user?.username}</td>
                                             <td align="right"><g:formatNumber number="${domainInstance?.txnAmt}" format="###,##0.00" /></td>
                                             
                                           <td>${domainInstance?.currency?.code}</td> 
                                           <td>${domainInstance?.txnRef}</td>
                                            <td>
                                                 <g:if test="${domainInstance?.txnType?.id == 9}">
                                                    <a class="btn btn-primary" onclick="alertify.confirm(AppTitle,'Print Memo Transaction - (Credit Adjustment) Validation Slip?',
                                                       function(){
                                                           var w = window.open('/icbs/deposit/MemoTransactionValidationSlip', '_blank');
                                                               w.print()
                                                           },
                                                       function(){});">Validation</a>
                                                 </g:if>
                                                 <g:if test="${domainInstance?.txnType?.id == 7}">
                                                    <a class="btn btn-primary" onclick="alertify.confirm(AppTitle,'Print Memo Transaction - (Debit Adjustment) Validation Slip?',
                                                       function(){
                                                           var w = window.open('/icbs/deposit/MemoTransactionValidationSlip', '_blank');
                                                               w.print()
                                                           },
                                                       function(){});">Validation</a>                                                     
                                                 </g:if>
                                            </td>
                                        </tr>
                               </g:each>     
                            </table>
                            <div class="pagination">
                                <g:paginate total="${domainInstanceCount ?: 0}"/>   
                            </div>
                    </div>
            </div>
            
        </content>
        <content tag="main-actions">
            <ul>
                <g:hiddenField id="depositIdx" name="depositIdx" value="${depositInstance.id}" />    
                <li><g:link action="#" data-toggle="modal" data-target="#modalMemoDebit" id="${depositInstance.id}" resource="${depositInstance}">Debit Memo Adjustment</g:link></li>
                <li><g:link action="#" data-toggle="modal" data-target="#modalMemoCreedit" id="${depositInstance.id}" resource="${depositInstance}">Credit Memo Adjustment</g:link></li>
                <li><g:link action="depositDebitMemoBills" id="${depositInstance.id}" resource="${depositInstance}">Debit Memo Bills Payment</g:link></li>
                <li><g:link action="depositDebitMemoRem" id="${depositInstance.id}" resource="${depositInstance}">Debit Memo Remittance</g:link></li>
                <li><g:link action="depositCreditMemoRem" id="${depositInstance.id}" resource="${depositInstance}">Credit Memo Remittance</g:link></li>    
                <li>
                    <a href=# onclick="alertify.confirm(AppTitle,'Are you sure you want to return to Deposit Inquiries page?',
                        function(){
                        var t_url = '/icbs/deposit/depositInquiry/${depositInstance?.id}';
                        location.href=t_url;},
                        function(){});">Return to Deposit Inquiry Page</a>
                </li>
 <!--               <g:if test="${flash.message == "Memo Adjustment successfully made.|success|alert"}">
                    <li>
                        <a href=# onclick="alertify.confirm(AppTitle,'Print Memo Debit/Credit Adjustment Validation Slip?',
                            function(){
                                var w = window.open('/icbs/deposit/MemoTransactionValidationSlip', '_blank');
                                    w.print()
                                },
                            function(){});
                            ">Print Adjustment Validation</a>
                    </li>
                </g:if>
                <g:if test="${flash.message == "Memo Remittance Successfully made.|success|alert"}">
                    <li>
                        <a href=# onclick="alertify.confirm(AppTitle,'Print Memo Remittance Validation Slip?',
                            function(){
                                var w = window.open('/icbs/deposit/MemoTransactionValidationSlip', '_blank');
                                    w.print()
                                },
                            function(){});
                            ">Print Remittance Validation</a>
                    </li>
                </g:if>
                <g:if test="${flash.message == "Bills Payment Successfully made.|success|alert"}">
                    <li>
                        <a href=# onclick="alertify.confirm(AppTitle,'Print Memo Bills Payment Validation Slip?',
                            function(){
                                var w = window.open('/icbs/deposit/MemoTransactionValidationSlip', '_blank');
                                    w.print()
                                },
                            function(){});
                            ">Print Bills Payment Validation</a>
                    </li>
                </g:if> -->
            </ul>
<!-- Modal MEMO DEBIT-->
<div id="modalMemoDebit" class="modal fade" role="dialog">
    <g:form name="adjustmentMemoDebitFormSend" id="adjustmentMemoDebitFormSend" controller="deposit" action="saveMemoAdjustment">
    <div class="modal-dialog">
    <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title" style="color: black;">Memo Debit Transactions</h4>
            </div>
            
            <g:hiddenField id="type" name="type" value="1"/>
            <g:hiddenField id="acct"name="acct.id" value="${adjustmentInstance?.acct?.id?:depositInstance?.id}"/>
            
            <div class="modal-body">
                <g:hiddenField id="typeDebit" name="typeDebit" value="1" />
            <div class="fieldcontain form-group ${hasErrors(bean: customerInstance, field: 'registrationDate', 'has-error')} ">
                <label class="control-label col-sm-4" style="color: gray;">Transaction Code: </label>
                <div class="col-sm-8"><g:select id="txnTemplateDebit" name="txnTemplate.id" from="${icbs.admin.TxnTemplate.findAllByTxnTypeAndMemoTxnType(icbs.lov.TxnType.read(7),icbs.lov.MemoTxnType.read(1),[sort:"code", order:"asc"])}" optionKey="id" optionValue ="description" value="" class="form-control"/></div>
            </div>

            <div class="fieldcontain form-group ${hasErrors(bean: customerInstance, field: 'registrationDate', 'has-error')} ">
                <label class="control-label col-sm-4" style="color: gray;">Amount: </label>
                <div class="col-sm-8"><g:textField id="AjustmentAmtDebit" name="amt" value="${adjustmentInstance?.amt}" class="form-control truncated"/></div>
            </div>
            
            <div class="fieldcontain form-group ${hasErrors(bean: customerInstance, field: 'registrationDate', 'has-error')} ">
                <label class="control-label col-sm-4" style="color: gray;">Transaction Reference: </label>
                <div class="col-sm-8"> <g:textField id="AdjustRefDebit" name="txnRef" value="${adjustmentInstance?.txnRef}" class="form-control"/></div>
            </div>
            <div class="fieldcontain form-group ${hasErrors(bean: customerInstance, field: 'registrationDate', 'has-error')} ">
                <label class="control-label col-sm-4" style="color: gray;">Description: </label>
                <div class="col-sm-8"> <g:textField id="txnDescriptionssDebit" name="txnDescription" value="${adjustmentInstance?.txnRef}" class="form-control"/></div>
            </div>  

<!-- date2 -->



</div>

<div class="modal-footer">

<a href ="#" onclick="validateOverride();" id="sender" name="sender" class="btn btn-primary">Submit</a>
<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
<g:if test="${flash.message == "Memo Adjustment successfully made.|success|alert"}">
   <a class="btn btn-primary" onclick="alertify.confirm(AppTitle,'Print Memo Transaction - (Debit Adjustment) Validation Slip?',
      function(){
          var w = window.open('/icbs/deposit/MemoTransactionValidationSlip', '_blank');
              w.print()
          },
      function(){});">Validation</a>
</g:if>

</div>
<g:javascript>

    function validateOverride(){
        console.log("boom");
       
        var txntype = $('#typeDebit').val()
        memotypevalidate = txntype
        var txntemp = $('#txnTemplateDebit').val()
        var txnamount = $('#AjustmentAmtDebit').val()
        var txnref = $('#AdjustRefDebit').val()
        var txndescs = $('#txnDescriptionssDebit').val()
        console.log("============================");
        console.log("txntype: "+txntype);
        console.log("txntemp: "+txntemp);
        console.log("txnamount: "+txnamount);
        console.log("txnref: "+txnref);
        console.log("txndesc: "+txndescs);
        console.log("============================");
        if(txnamount == ""){
            notify.message('Amount Cannot be null!|error|alert'); 
        }
        else if(txnref == ""){
            notify.message('Transaction Reference Cannot be null! |error|alert'); 
        }
        else if(txndescs == ""){
            notify.message('Description Cannot be null! |error|alert'); 
        }
        else{
            checkIfAllowed("DEP01001", adjustmentAuthCallback);
        }
    }
    
</g:javascript>  
</div>

</div>
</g:form>
</div>
<!-- modal close -->
                        
<!-- Modal MEMO CREDIT-->
<div id="modalMemoCreedit" class="modal fade" role="dialog">
    <g:form name="adjustmentMemoCreditFormSend" id="adjustmentMemoCreditFormSend" controller="deposit" action="saveMemoAdjustment">
    <div class="modal-dialog">
    <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title" style="color: black;">Memo Credit Transactions</h4>
            </div>
            
            <g:hiddenField id="type" name="type" value="2"/>
            <g:hiddenField id="acct"name="acct.id" value="${adjustmentInstance?.acct?.id?:depositInstance?.id}"/>
            <div class="modal-body">
            
            <g:hiddenField id="typeCredit" name="typeCredit" value="2" />
            <div class="fieldcontain form-group ${hasErrors(bean: customerInstance, field: 'registrationDate', 'has-error')} ">
                <label class="control-label col-sm-4" style="color: gray;">Transaction Code: </label>
                <div class="col-sm-8"><g:select id="txnTemplateCredit" name="txnTemplate.id" from="${icbs.admin.TxnTemplate.findAllByTxnTypeAndMemoTxnType(icbs.lov.TxnType.read(9),icbs.lov.MemoTxnType.read(1),[sort:"code", order:"asc"])}" optionKey="id" optionValue ="description" value="1" class="form-control"/></div>
            </div>
            
            <div class="fieldcontain form-group ${hasErrors(bean: customerInstance, field: 'registrationDate', 'has-error')} ">
                <label class="control-label col-sm-4" style="color: gray;">Amount: </label>
                <div class="col-sm-8"><g:textField id="AjustmentAmtCredit" name="amt" value="${adjustmentInstance?.amt}" class="form-control truncated"/></div>
            </div>
            <div class="fieldcontain form-group ${hasErrors(bean: customerInstance, field: 'registrationDate', 'has-error')} ">
                <label class="control-label col-sm-4" style="color: gray;">Transaction Reference: </label>
                <div class="col-sm-8"> <g:textField id="AdjustRefCredit" name="txnRef" value="${adjustmentInstance?.txnRef}" class="form-control"/></div>
            </div>
            <div class="fieldcontain form-group ${hasErrors(bean: customerInstance, field: 'registrationDate', 'has-error')} ">
                <label class="control-label col-sm-4" style="color: gray;">Description: </label>
                <div class="col-sm-8"> <g:textField id="txnDescriptionssCredit" name="txnDescription" value="${adjustmentInstance?.txnRef}" class="form-control"/></div>
            </div> 

<!-- date2 -->



</div>

<div class="modal-footer">


<a href ="#" onclick="validateOverride1();" id="sender" name="sender" class="btn btn-primary">Submit</a>
<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
<g:if test="${flash.message == "Memo Adjustment successfully made.|success|alert"}">
   <a class="btn btn-primary" onclick="alertify.confirm(AppTitle,'Print Memo Transaction - (Credit Adjustment) Validation Slip?',
      function(){
          var w = window.open('/icbs/deposit/MemoTransactionValidationSlip', '_blank');
              w.print()
          },
      function(){});">Validation</a>
</g:if>

</div>
<g:javascript>

    function validateOverride1(){
        console.log("puaaaaaaa");
        var txntype = $('#typeCredit').val()
        memotypevalidate = txntype
        var txntemp = $('#txnTemplateCredit').val()
        var txnamount = $('#AjustmentAmtCredit').val()
        var txnref = $('#AdjustRefCredit').val()
        var txndescs = $('#txnDescriptionssCredit').val()
        console.log("============================");
        console.log("txntype: "+txntype);
        console.log("txntemp: "+txntemp);
        console.log("txnamount: "+txnamount);
        console.log("txnref: "+txnref);
        console.log("txndesc: "+txndescs);
        console.log("============================");     
        if(txnamount == ""){
            notify.message('Amount Cannot be null!|error|alert'); 
        }
        else if(txnref == ""){
            notify.message('Transaction Reference Cannot be null! |error|alert'); 
        }
        else if(txndescs == ""){
            notify.message('Description Cannot be null! |error|alert'); 
        }
        else{
            checkIfAllowed("DEP01001", adjustmentAuthCallback);
        }
        
    }
    
</g:javascript>    

</div>

</div>
</g:form>
</div>
<!-- modal close -->                        
                        
                        
        </content>
    </body>
</html>