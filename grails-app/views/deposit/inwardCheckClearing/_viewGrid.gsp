<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<div class="box-body table-responsive no-padding">
    <table id="clearingTable" class="table table-hover table-condensed table-bordered table-striped">
        <tr> 
            <td><label>Account No</label></td>
            <td><label>Check No</label></td>
            <td><label>Amount</label></td>
        </tr>
        <g:each in="${inwardCheckClearingList}" status="i" var="checkClearing">   
                <tr>
                     <td><g:formatNumber format="############" number="{$checkClearing?.accountNo}"/></td>
                     <td>${checkClearing?.checkNo}</td>
                     <td><g:formatNumber format="###,###,##0.00" number="{$checkClearing?.amt}"/></td>
                </tr>
       </g:each>     
    </table>
</div>