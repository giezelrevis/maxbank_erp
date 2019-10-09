<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<div class="box-body table-responsive no-padding">
    <table class="table table-hover table-condensed table-bordered table-striped">
        <tr> 
            <td><label>Check No</label></td>
            <td><label>Check Date</label></td>
            <td><label>Payee </label></td>
            <td><label>Payee Acct No</label></td>
            <td><label>Amount</label></td>
            <td><label>Clear Account No</label></td>
        </tr>
        <g:each in="${chequebookInstance.cheques}" status="i" var="cheque">   
                <tr>
                     <td><g:formatNumber format="############" number="${cheque?.chequeNo}"/></td>
                     <td><g:formatDate format="MM/dd/yyyy" date="${cheque?.chequeDate}"/></td>
                     <td>${cheque?.payeeName}</td>
                     <td><g:formatNumber format="############" number="${cheque?.payeeAcctNo}"/></td>
                     <td><g:formatNumber format="###,###,##0.00" number="${cheque?.chequeAmt}"/></td>
                     <td>${cheque?.clrAcctNo}</td>
                </tr>
       </g:each>     
    </table>
</div>