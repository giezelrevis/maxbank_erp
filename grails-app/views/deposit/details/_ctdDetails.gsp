<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

    <div class="section-container">
        <fieldset>
        <legend class="section-header">Account Information</legend>
            <table class="table table-bordered table-striped">
                   <tbody>
                       <tr>
                           <td style="font-weight:bold" width="30%">Account Number</td>
                           <td width="70%">${depositInstance?.acctNo}</td>
                       </tr>
                       <tr>
                           <td style="font-weight:bold" width="30%">Account Name</td>
                           <td width="70%">${depositInstance?.acctName}</td>
                       </tr>
                       <tr>
                           <td style="font-weight:bold" width="30%">Date Opened</td>
                           <td width="70%">${depositInstance?.currentRollover?.startDate.format('MM/dd/yyyy')}</td>
                       </tr>
                       <tr>
                           <td style="font-weight:bold" width="30%">Maturity Date</td>
                           <td width="70%">${depositInstance?.currentRollover?.endDate.format('MM/dd/yyyy')}</td>
                       </tr>
                       <tr>
                           <td style="font-weight:bold" width="30%">Interest Rate</td>
                           <td width="70%"><g:formatNumber format="#,##0.00" number="${depositInstance?.interestRate}"/>%</td>
                       </tr>
                       <tr>
                           <td style="font-weight:bold" width="30%">Status</td>
                           <td width="70%">${depositInstance?.status?.description}</td>
                       </tr>
                    </tbody>
            </table>        
        </fieldset>
    </div>