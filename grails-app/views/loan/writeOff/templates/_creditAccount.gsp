<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>



<div class="row">
    <div class="col-md-6">
       <g:render template='/customer/details/customerDetails' model="[customerInstance:fundTransferInstance?.destinationAcct?.customer]"/>
    </div>
    <div class="col-md-6">
       <g:render template='details/depositDetails' model="[depositInstance:fundTransferInstance?.destinationAcct]"/>
    </div>
</div>
<table>
    <tr>
    <td></td>
    <td><div class="row">
    <g:if test="${!disabled}">
        <h1> <input type="button"  accept=""class="btn btn-default form-control"href="#"onclick="initializeDepositSearchModal();modal.show()"value="Search Deposits"/></h1>
    </g:if>
</div></td>
<td></td></tr>
</table>