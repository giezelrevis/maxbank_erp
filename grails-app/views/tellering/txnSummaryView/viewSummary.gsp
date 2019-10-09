<%@ page contentType="text/html;charset=UTF-8" %>


<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <title>Teller Transaction Summary</title>
    </head>
    
    
<body>
    <content tag="main-content">
    
         <div class="row">
             
             <div class="infowrap">
                <div class="col-md-6">
                 <legend class="section-header">Cash</legend>
                 <table class="table table-bordered table-striped">
                 <tbody>
                     <tr>
                         <td>Total Cash In:</td>
                           <td></td>
                     </tr>
                      <tr>
                          <td>Total Cash Out:</td>
                           <td></td>
                     </tr>
                 </tbody>
                 </table>
                </div>

                 <div class="col-md-6">
                   <legend class="section-header">Checks</legend>
                   <table class="table table-bordered table-striped">
                 <tbody>
                     <tr>
                         <td>Total Received:</td>
                           <td></td>
                     </tr>
                      <tr>
                          <td>Total Payout:</td>
                           <td></td>
                     </tr>
                 </tbody>
                 </table>
                  </div>    
               </div>
         </div>
    </content>
    
    
     <content tag="main-actions">
            <ul>
                
                 <li><g:link action="createTellerCashFromVaultTxn">Receive Cash from Vault</g:link></li>
                 <li><g:link action="createTellerCashTransferTxn">Teller Cash Transfer</g:link></li>
                 <li><g:link action="createTellerCheckToCOCITxn">Checks to COCI</g:link></li>
                 <li><g:link action="createTellerCashToVaultTxn">Cash to Vault</g:link></li>
                 <li><g:link action="index">Back to Tellering Index</g:link></li>
                
            </ul>                                        
        </content>
    
    
    
</body>


</html>
