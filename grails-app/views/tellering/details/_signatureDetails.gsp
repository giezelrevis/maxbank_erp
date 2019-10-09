<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<div class="col-md-6">
<div class="section-container">
    <fieldset>
        <legend class="section-header">Signature</legend>
        <div class="infowrap">
            <g:if test="${(depositInstance?.customer?.attachments?.find{it.isPrimarySig==true})?.id}"> <img width="240px" height="240px"src="${createLink(controller:'Attachment', action:'show', id: (depositInstance?.customer?.attachments?.find{it.isPrimarySig==true})?.id )}"/></g:if>
        </div>
    </fieldset>
    </div>
</div>