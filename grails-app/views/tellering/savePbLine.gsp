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
         <title>Print Passbook Transactions</title>
     </head>    
     <body>
         <content tag="main-content">
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
                             <div class="col-xs-8 col-sm-6 col-md-6">
                                 <dl class="dl-horizontal">
                                     <dt>Starting Line</dt>
                                     <dd>${pbLineNo}</dd>
                                 </dl>
                             </div> 
                         </div>
                 </fieldset>
             </div>
             <div id="SlipTransaction" class="alert alert-success alert-dismissable" role="alert">
                 <div>
                 <div id="SlipTransaction" class="alert alert-success alert-dismissable" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                         <div> 
                             <a onclick="
                                     var w = window.open('printToPassbookTransactions', '_blank')
                                         w.print();
                                     ">
                                 <g:img dir="images" file="passbook-icon.jpg" width="35" height="35"/>
                                 Print Passbook
                             </a>
                             <p><input id="passbookline"  name="passbookline" required="" value="${passbookline}" style="display:none"/></p>
                             <p><input id="id"  name="id" required="" value="${id}" style="display:none"/></p>
                             <p><input id="jrxmlTcId"  name="jrxmlTcId" required="" value="${jrxmlTcId}" style="display:none"/></p>
                         </div>   
                 </div>                
 
                 </div>
             </div>
         </content>
         
         <content tag="main-actions">
             <ul>
                 <li><g:link action="index">Tellering Index</g:link></li>
             </ul>                                        
         </content>            
     </body>
 </html>