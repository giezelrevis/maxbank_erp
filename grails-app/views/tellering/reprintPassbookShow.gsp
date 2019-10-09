 <!--
   To change this license header, choose License Headers in Project Properties.
   To change this template file, choose Tools | Templates
   and open the template in the editor.
 -->
 
 <%@ page import="icbs.tellering.TxnFile" %>
 <%@ page contentType="text/html;charset=UTF-8" %>
 <!DOCTYPE html>
 <html>
     <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <meta name="layout" content="main">
         <title>Re-print Passbook Transactions</title>
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
             </g:if>            
             <div class="section-container">
                 <fieldset>
                     <legend class="section-header">Account Information</legend>
                         <div class="infowrap">
                             <div class="col-xs-8 col-sm-6 col-md-6">
                                 <dl class="dl-horizontal">
                                     <dt>Account Number</dt>
                                     <dd>${pbLedger?.acctNo}</dd>
                                 </dl>
                             </div>
                             <div class="col-xs-8 col-sm-6 col-md-6">
                                 <dl class="dl-horizontal">
                                     <dt>Account Name</dt>
                                     <dd>${pbLedger?.acct?.acctName}</dd>
                                 </dl>
                             </div> 
                         </div>
                         <div class="infowrap">
                             <div class="col-xs-8 col-sm-6 col-md-6">
                                 <dl class="dl-horizontal">
                                     <dt>Txn Date</dt>
                                     <dd>${pbLedger?.txnDate}</dd>
                                 </dl>
                             </div>
                             <div class="col-xs-8 col-sm-6 col-md-6">
                                 <dl class="dl-horizontal">
                                     <dt>txn Seq</dt>
                                     <dd>${pbLedger?.passbookLine}</dd>
                                 </dl>
                             </div> 
                         </div>                        
                 </fieldset>
             </div>
         
 
                 <g:if test = "${session["type"]==1 || session["type"]==2}">
                 <g:form name="pbLineForm" method="post" url="[action:'savePbLine',controller:'tellering']">
                     <div class="fieldcontain form-group ${hasErrors(bean: pbLedger, field: 'passbookLine', 'has-error')} ">
                         <label class="control-label col-sm-4" for="passbookLine">
                             <g:message code="pbLedger.passbookLine.label" default="Passbook Line Number" />
                         </label>
 
                         <div class="col-sm-6">
                            <g:hiddenField id="ledgerId" name="ledgerId" value="${fieldValue(bean: pbLedger, field: 'id')}" />
                            <g:field id="pbl" name="passbookLine" required="true" value="${fieldValue(bean: pbLedger, field: 'passbookLine')}" class="txn-amt form-control"/>
                         </div>             
                     </div>
                 </g:form>
                 </g:if>
                 <g:else>
                 <g:form name="pbLineForm" method="post" url="[action:'savePbLineTd',controller:'tellering']">
                     <div class="fieldcontain form-group ${hasErrors(bean: pbLedger, field: 'passbookLine', 'has-error')} ">
                         <label class="control-label col-sm-4" for="passbookLine">
                             <g:message code="pbLedger.passbookLine.label" default="Passbook Line Number" />
                         </label>
 
                         <div class="col-sm-6">
                            <g:hiddenField id="ledgerId" name="ledgerId" value="${fieldValue(bean: pbLedger, field: 'id')}" />
                            <g:field id="pbl" name="passbookLine" required="true" value="${fieldValue(bean: pbLedger, field: 'passbookLine')}" class="txn-amt form-control"/>
                         </div>             
                     </div>
                 </g:form>
                 </g:else>        
         </content>
         
         <content tag="main-actions">
             <ul>
                 <li><a id="save" class="save" onclick="
                         jQuery('#pbLineForm').submit();
                     ">${message(code: 'default.button.create.label', default: 'Submit')}</a></li>
                 <li><g:link action="index">Tellering Index</g:link></li>
             </ul>                                        
         </content>            
     </body>
	
 </html>
