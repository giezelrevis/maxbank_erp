<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<legend>Addresses</legend>
    <g:render template='form/address/onetomany/address' model="['address':customerInstance?.addresses[0],'i':0]"/>
<!-- Dito ung mga Phones Magaapend -->
<div id="addressList">
                <g:each var="address" in="${customerInstance.addresses}" status="i">
                    <g:if test="${i>0&&(address?.status?.id==2||!address?.id)}">
                        <g:render template='form/address/onetomany/address' model="['address':address,'i':i]"/>
                    </g:if>
                </g:each>
                        
                 
 </div>
 
<div class="form-group form-buttons">
    <button type="button" class="btn btn-primary multi-field-btn" onclick="addAddressAjax()"><span class="fa fa-plus"></span> Add more Addresses</button>
 </div>
 
    